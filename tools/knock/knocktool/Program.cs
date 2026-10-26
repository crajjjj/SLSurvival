using Mutagen.Bethesda;
using Mutagen.Bethesda.Plugins;
using Mutagen.Bethesda.Plugins.Binary.Parameters;
using Mutagen.Bethesda.Plugins.Records;
using Mutagen.Bethesda.Skyrim;

static ModKey MK(string s) => ModKey.FromFileName(s);

var cmd = args[0];
if (cmd == "skpatch") { Patches.SimplyKnock(args[1], args[2]); return; }
if (cmd == "srpatch") { Patches.SimplerKnock(args[1], args[2], args[3], args[4]); return; }
switch (cmd)
{
    case "roundtrip":
    {
        // roundtrip <in> <out> [master ...]: write with the given master list (default: the file's own)
        var mod = SkyrimMod.CreateFromBinary(new ModPath(args[1]), SkyrimRelease.SkyrimSE);
        var masters = args.Length > 3
            ? args.Skip(3).Select(MK).ToArray()
            : mod.ModHeader.MasterReferences.Select(m => m.Master).ToArray();
        mod.ModHeader.MasterReferences.RemoveAll(m => !masters.Contains(m.Master));
        mod.BeginWrite.ToPath(args[2]).WithNoLoadOrder()
            .WithMastersListOrdering(masters)
            .WithExplicitOverridingMasterList(masters)
            .NoNextFormIDProcessing()
            .NoNullFormIDStandardization()
            .SingleThread()
            .Write();
        Console.WriteLine("ok");
        break;
    }
    case "links":
    {
        // links <plugin>: every record's referenced FormKeys, for a semantic before/after compare
        var mod = SkyrimMod.CreateFromBinaryOverlay(new ModPath(args[1]), SkyrimRelease.SkyrimSE);
        using var w = new StreamWriter(args[2]);
        foreach (var rec in mod.EnumerateMajorRecords())
        {
            var links = rec.EnumerateFormLinks().Select(l => l.FormKey.ToString()).OrderBy(s => s);
            w.WriteLine($"{rec.FormKey}|{string.Join(",", links)}");
        }
        Console.WriteLine("ok");
        break;
    }
}
