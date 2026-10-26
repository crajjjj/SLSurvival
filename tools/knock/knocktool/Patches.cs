using Mutagen.Bethesda;
using Mutagen.Bethesda.Plugins;
using Mutagen.Bethesda.Skyrim;

static class Patches
{
    static readonly ModKey SLS = ModKey.FromFileName("SL Survival.esp");
    static readonly ModKey SK = ModKey.FromFileName("SimplyKnock.esp");
    static readonly ModKey SR = ModKey.FromFileName("SimplerKnock.esp");

    static readonly FormKey BegDdi02 = new(SLS, 0x007369);   // "Please, I need a place to stay..."
    static readonly FormKey BegDdi03 = new(SLS, 0x009EAE);   // "Are you crazy?! I'm not putting that on!"
    static readonly FormKey BegDdi04 = new(SLS, 0x009EB0);   // "Wait! ...Ok fine"
    static readonly FormKey BegDdi05 = new(SLS, 0x009EB2);   // "Go to hell!"
    static readonly FormKey BegDdi02Info = new(SLS, 0x00736A);
    static readonly FormKey[] BegTopics =
    {
        BegDdi02, BegDdi03, BegDdi04, BegDdi05,
        new(SLS, 0x009EB6), new(SLS, 0x009EB8),              // retry pair, Simply Knock only
    };

    static void Write(SkyrimMod patch, string path, params string[] masterOrder)
    {
        patch.BeginWrite.ToPath(path).WithNoLoadOrder()
            .WithMastersListOrdering(masterOrder.Select(m => ModKey.FromFileName(m)).ToArray())
            .SingleThread()
            .Write();
    }

    // Everything SL Survival.esp did inside Simply Knock up to 0.801, as overrides: Simply Knock's
    // own dialogue SLS edited, and the beg topics re-attached to Simply Knock's door conversation.
    public static void SimplyKnock(string origSls, string outPath)
    {
        var orig = SkyrimMod.CreateFromBinaryOverlay(new ModPath(origSls), SkyrimRelease.SkyrimSE);
        var patch = new SkyrimMod(ModKey.FromFileName(Path.GetFileName(outPath)), SkyrimRelease.SkyrimSE);
        patch.ModHeader.Flags |= SkyrimModHeader.HeaderFlag.Small;
        patch.ModHeader.Author = "crajjjj";
        patch.ModHeader.Description = "SL Survival: begging for a bed through Simply Knock's door dialogue.";

        foreach (var q in orig.Quests.Where(r => r.FormKey.ModKey == SK)) patch.Quests.Add(q.DeepCopy());
        foreach (var v in orig.DialogViews.Where(r => r.FormKey.ModKey == SK)) patch.DialogViews.Add(v.DeepCopy());
        foreach (var t in orig.DialogTopics)
        {
            if (t.FormKey.ModKey == SK)
            {
                patch.DialogTopics.Add(t.DeepCopy());
            }
            else if (BegTopics.Contains(t.FormKey))
            {
                // 0.801's attached topic; only the opening info carries a Simply Knock condition
                var c = t.DeepCopy();
                c.Responses.RemoveAll(r => r.FormKey != BegDdi02Info);
                patch.DialogTopics.Add(c);
            }
        }
        Write(patch, outPath, "Skyrim.esm", "Update.esm", "SexLab.esm", "SimplyKnock.esp", "SL Survival.esp");
        Console.WriteLine($"{outPath}: {patch.EnumerateMajorRecords().Count()} records");
    }

    // The beg topics in Simpler Knock's door conversation: offered after you pick the resident,
    // and Simpler Knock's own Persuade / Intimidate / Friend lines follow the MCM "knock mod
    // dialogue" toggle like Simply Knock's do.
    public static void SimplerKnock(string origSls, string coreSls, string simplerEsp, string outPath)
    {
        var orig = SkyrimMod.CreateFromBinaryOverlay(new ModPath(origSls), SkyrimRelease.SkyrimSE);
        var core = SkyrimMod.CreateFromBinaryOverlay(new ModPath(coreSls), SkyrimRelease.SkyrimSE);
        var simpler = SkyrimMod.CreateFromBinaryOverlay(new ModPath(simplerEsp), SkyrimRelease.SkyrimSE);
        var patch = new SkyrimMod(ModKey.FromFileName(Path.GetFileName(outPath)), SkyrimRelease.SkyrimSE);
        patch.ModHeader.Flags |= SkyrimModHeader.HeaderFlag.Small;
        patch.ModHeader.Author = "crajjjj";
        patch.ModHeader.Description = "SL Survival: begging for a bed through Simpler Knock's door dialogue.";

        var knockQuest = new FormKey(SR, 0x000815);   // aaaknockknock

        // GetVMQuestVariable _SLS_Main ::SKdialog_var == 1, as on 0.801's Simply Knock persuade info
        var skDialogOn = orig.DialogTopics.SelectMany(t => t.Responses)
            .Single(r => r.FormKey == new FormKey(SK, 0x002857)).Conditions[0].DeepCopy();

        // modelled on Simpler Knock's own non-top-level branch (aaaknockknockBranch)
        var template = simpler.DialogBranches.Single(b => b.FormKey == new FormKey(SR, 0x000819));
        var branch = (DialogBranch)template.Duplicate(patch.GetNextFormKey());
        branch.EditorID = "_SLS_SimplerKnockBegBranch";
        branch.Quest.SetTo(knockQuest);
        branch.StartingTopic.SetTo(BegDdi02);
        patch.DialogBranches.Add(branch);

        foreach (var fk in new[] { BegDdi02, BegDdi03, BegDdi04, BegDdi05 })
        {
            var t = core.DialogTopics.Single(r => r.FormKey == fk).DeepCopy();
            t.Quest.SetTo(knockQuest);
            t.Branch.SetTo(branch);
            t.Responses.Clear();
            patch.DialogTopics.Add(t);
        }

        uint[] residentTopics = { 0x16, 0x18, 0x1A, 0x1C, 0x1E, 0x20 };   // "<HouseOwnerN> is at home."
        uint[] gatedTopics = { 0x0A, 0x0F, 0x11 };                        // Persuade, Friend, Intimidate
        foreach (var src in simpler.DialogTopics)
        {
            var id = src.FormKey.ID;
            if (residentTopics.Contains(id))
            {
                var t = src.DeepCopy();
                foreach (var r in t.Responses)
                    r.LinkTo.Add(new FormLink<IDialogTopicGetter>(BegDdi02));
                patch.DialogTopics.Add(t);
            }
            else if (gatedTopics.Contains(id))
            {
                var t = src.DeepCopy();
                foreach (var r in t.Responses)
                    r.Conditions.Insert(0, skDialogOn.DeepCopy());
                patch.DialogTopics.Add(t);
            }
        }
        Write(patch, outPath, "Skyrim.esm", "Update.esm", "Dawnguard.esm", "HearthFires.esm", "Dragonborn.esm",
            "SexLab.esm", "SimplerKnock.esp", "SL Survival.esp");
        Console.WriteLine($"{outPath}: {patch.EnumerateMajorRecords().Count()} records");
    }
}
