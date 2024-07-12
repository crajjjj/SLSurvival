Scriptname zbfSexLab extends sslAnimationFactory

; quirks of the documentation system below .... defines the layout of the sections

; @section: zbfSexLab

; @section: Basic

; @section: Advanced

; @section: Private

zbfBondageShell Property zbf Auto
zbfExternalInterface Property zbfEx Auto

SexLabFramework Property SexLab Auto Hidden ; Framework
Float Property Distance = -45.0 AutoReadOnly ; default distance

String[] Property sAnimList Auto
zbfSexLabBaseEntry[] Property Entries Auto Hidden
zbfSexLabBaseEntry[] Property SpecialEntries Auto Hidden
zbfSexLabBaseEntry[] Property CreatureEntries Auto Hidden
zbfSexLabBaseEntry[] Property BaseSlots Auto
zbfSexLabBaseEntry Property AllSoloEntry Auto

Sound Property Silent Auto
Sound[] Property Female01 Auto
Sound[] Property Male01 Auto

Int Property MaleFemale = -1 AutoReadOnly Hidden	; From sslExpressionFactory

Bool Property KeepExpressionPhoneme = True AutoReadOnly Hidden ; Set to true to keep all expression phonemes, instead of just removing all and replacing with open mouth

sslBaseVoice Property MaleGagVoice01 Auto		; SexLab voice slots for overrides
sslBaseVoice Property FemaleGagVoice01 Auto		; SexLab voice slots for overrides

Bool Property bForceSilenceSexLabSound Auto Hidden
Bool Property bOverrideSexLabExpression Auto Hidden
Bool Property bOverrideSexLabSound Auto Hidden
Bool Property bOverrideSexLabAnimation Auto Hidden

; SexLab expression slots for overrides
; 
; The following expressions are registered and in this order.
; # Afraid
; # Shy
; # Happy
; # Sad
; # Angry
; 
sslBaseExpression[] Property GagExpression Auto

sslBaseAnimation[] Property BorrowSlots Auto	; Objects that are borrowed
String[] Property BorrowModNames Auto			; Mod names that have borrowed slots, "" means slot is free

; @section: zbfSexLab
; 
; Skip down to ::Basic below if all you want to do is start sex using ZAP. There is a code example that you can 
; just copy/paste and use.
; 
; 
; Background: Since it's not feasible to define every set of combination of bindings and animations, 
; this module defines a set of building blocks to dynamically set up animations.
; 
; To accomplish this, it also needs to know what kind of animations are available to the system to use
; as building blocks. If, for instance, an armbinder animation is not available for the female of a specific 
; sex pose, then that pose can't be used if the female is wearing an armbinder (or at least it would look weird).
; 
; The overall steps to define and run an animation are as follows:
; # Determine capabilities
; # Set up the SexLab animation
; # Set up the SexLab thread
; 
; For those not so familiar with SexLab:
; Animations define how to play something, which animations to use, how long, how many actors are involved etc.
; Threads actually play the animation. You connect the actors to the thread, and the thread determines if a bed is used, how to
; strip actors, and so on.
; 
; 
; ### Determine capabilities
; 
; The system works by having a list of all animations, then excluding those that don't fit for some reason. Examples of not fitting
; could be because an animation is not defined for armbinders (there is no animation to fit that pose), but one actor is bound with an
; armbinder. Another example could be oral sex, but one actor is gagged, so the gag would get in the way of oral sex.
; 
; Animation capabilities are described by zbfSexLabBaseEntry:: objects (they do lots of other stuff too).
; 
; A typical flow at this stage may look like (pseudocode). In the example below it is assumed that zbfSL points to the zbfSexLab object.
; After filtering, "list", will contain a list of objects that are tagged as "Aggressive" and "Missionary" for two actors, and only 
; animations that can support the bindings on the involved actors are selected.
; 
; Code:
; zbfSexLab zbfSL = zbfSexLab.GetApi()
; Actor[] actors = zbfUtil.ActorList(SexActor1, SexActor2)
; zbfSexLabBaseEntry[] list = zbfSL.GetEntriesByTags(actors, "Missionary, Aggressive", aiMinActorCount = 2)
; 
; 
; ### Set up SexLab animations
; 
; At this stage, we'll select an animation base and set up the animation object. This defines the positions and actual animations 
; for all the involved actors. We use the "list", "zbfSL" and "actors" objects from the previous example.
; 
; In this example we'll initiate sex between a PlayerRef and a BanditRef.
; 
; Code:
; zbfSexLabBaseEntry entry = zbfSL.GetRandomEntry(list)
; sslBaseAnimation anim = zbfSL.NewAnimation("Module name")
; DefineAnimationEx(entry, anim, actors)
; 
; Ok, so what happened here?
; First of all, the first line fetches a random entry from the list of all entries that are still available. Then a new temporary 
; animation is retrieved. Do not worry about cleaning up, it's done automatically.
; 
; Then the system needs a list of how all the actors are bound, as this will influence exactly which animation is going to be played.
; In determining capabilities, we just figured out a suitable zbfSexLabBaseEntry:: which could support armbinder animations, but here we
; actually tell the system to use armbinder. You can force the system to select something else, but if you didn't check for that capability
; the system may not have the animations to play what you want.
; 
; After the "DefineAnimation" step, the animation is set up and ready to be passed on to SexLab.
; 
; 
; ### Set up SexLab thread
; 
; Purpose of this part is to set up all default settings of a new SexLab thread, which SexLab sometimes does and some times does not.
; Things like if beds should be used, if foreplay should be triggered and so on.
; 
; There are a set of helper functions in zbfSexLab to make this easier, and you can tweak the thread after using the helper functions.
; 
; The previous objects are still used.
; 
; Code:
; sslThreadModel thread = SexLab.NewThread()
; sslBaseAnimation[] Animations = New sslBaseAnimation[1]
; Animations[0] = anim
; thread.SetAnimations(Animations)
; thread.SetBedFlag(0)
; thread.DisableLeadIn(disabling = True)
; thread.DisableBedUse(disabling = True)
; Int i = 0
; While i < actors.Length
; 	Actor a = actors[i]
; 	If a != None
; 		thread.AddActor(a, isVictim = (a == PlayerRef))
; 		thread.DisableRagdollEnd(a, disabling = True)
; 		thread.SetStrip(a, zbfSL.GetDefaultStripSlots())
; 		thread.DisableUndressAnimation(a, disabling = True)
; 	EndIf
; 	i += 1
; EndWhile
; 
; This part is fairly simple. Create a new SexLab thread, and run settings, first globally, then for each actor. PlayerRef is set as the
; victim in this case. This code is just boilerplate, and there are deprecated support functions in zbfSexLab to perform these actions. Still,
; it's likely best to be explicit about the options that you set on your own threads.
; 
; You can now start the animation as normal. When the animation has finished playing, everything is back to normal again.
; 
; Code:
; thread.StartThread()
; 
; 
; ### Summing up
; 
; That's it. Have a look at the api, and the many other options that are there for filtering, and processing.
; 
; If you think this looks complicated or like "too many steps", check out the functions ::GetEntriesByTags and ::StartSex. They do exactly the same 
; as the steps outlined above, but has support for four actors, and does all it's filtering automatically. By using ::StartSex, it is still easy to 
; customize the filtering.
; 
; On the tags system:  
; There are quite a lot of tags being mentioned everywhere. This is an attempt at a guide of sorts to help find the right tags for filtering.
; 
; "Global" tags, that is, tags applied on the base animation and on the animation entry (the animation template, so to speak). These contain general
; information about what kind of animation the template will create. Tagging an animation with "Blowjop" will indicate that this is the theme of the
; animation.
; 
; Code:
; zbfSL.FilterEntries(list, 0, zbfUtil.StrList("Blowjob"), zbfUtil.StrList("Aggressive"))
; 
; The line above will remove all templates that are aggressive, and keep only those which have "Blowjob" specified. Actor with index 0 is the "global"
; position (that's the zero in the line above). Normally animations are not filtered on the global tags, but filtering out Aggressive, Loving and so on
; can be very useful to avoid animations that don't make sense.
; 
; The following tags are in use. When two tags are mutually exclusive, they are on the same line with a / between them. If a tag type is not present, it
; means the animation works equally well for both scenarios. Example: Not specifying foreplay or sex means that the animation can be used for both.
; 
;   - Aggressive / Loving: Aggressive animations are rough (like choking), and loving are softer (like kissing).
;   - Author tags: The author tag, if known. Rarely used for filtering.
;   - Vaginal, Oral, Breast, Anal: A "main theme" of sorts. Filtering on global tags does not guarantee individual actors can play.
;   - Pillory: Furniture is used to restrain in some way.
;   - Foreplay / Sex: Animation is either foreplay or sex. Animations marked with neither tag can be used for both.
;   - Boobjob / Blowjob / Missionary / Doggystyle / Spank / Cowgirl / Kissing / Licking: Animation contents; sex position.
;   - Lying / Standing / Sitting / Knees: Animation is mostly posed according to the keyword (lying = being horizontal, not untruthful).
;   - Masturbation: Animation is a solo masturbation animation.
;   - Forced: Always paired with aggressive. Non-consensual content, for instance struggling or similar.
; 
; Further, ZAP will apply tags on every animation it creates. These are not found on the templates.
;   - ZaZ: All animations are tagged with ZaZ.
;   - NoSwap: All animations are tagged with NoSwap to let other mods know that the animation is final and should not be swapped for another. (DDi and ZaZ both check for this)
; 
; For each actor there are tags as well, telling ZAP about what animation resources are available.
; 
; Code:
; zbfSL.FilterEntries(list, 2, zbfUtil.StrList("Yoke"), zbfUtil.StrList("Female"))
; 
; The code above will keep only entries (templates) that support a yoked actor in the second slot, and it can't be a female only slot. Normally female is 
; in the first slot and male in the second slot, so this makes sense. Animations such as Lesbian01 though require females in both slots, and some 
; animations work well with either gender. Thanks to strap-ons there are few "male only" slots.
; 
; The following tags are used in the actor slots:
;    - Yoke, Armbinder, Wrists: The type of restraint allowed in the slot.  
;                        All of these can be present at the same time, meaning that an actor wearing either can be slotted. Animations  
;                        support an actor wearing nothing as well. In that case the support functions will use the vanilla animation for that slot.
;    - Oral, Vaginal, Anal, Breast: The actor needs this "slot" free and accessible. Vaginal is used instead of penis in a male slot.
;    - Female: The slot is a female only slot.
;    - Male: The slot is a male only slot. Because of strapons there are few male only slots.
;    - NoStrip: The actor should not strip for SexLab scenes.
; 
; Example:  
; Lesbian01 set the following tags on both actors: "Wrists", "Armbinder", "Yoke", "Oral", "Vaginal", "Female"  
; This means that you can create the Lesbian01 animation with any combination of wrists, armbinder, yokes (or not bound at all). No actors can be belted or gagged (ring gag is 
; an exception). Both actors need to be females, and if you anyway slot a male in there, it will look weird.
; 
; Tags are defined in the functions at the end, called ::DefineLesbian01Base or similar sounding names. Have a look there for further information.
; 
; 


; 
; @section: Basic
; 
; 
; code: To set up and run a SexLab animation, with ZAP support, do the following:
; zbfSexLab zbfSL = zbfSexLab.GetApi()
; Actor[] actors = zbfUtil.ActorList(SexActor1, SexActor2)
; zbfSexLabBaseEntry[] list = zbfSL.GetEntriesByTags(actors, "Missionary, Aggressive", aiMinActorCount = 2)
; Int success = zbfSL.StartSex(actors, list, Victim = SexActor1, Hook = "MyHook")
; 
; The code above sets up SexLab to run on SexActor1 and SexActor2 using an animation that is Missionary and Aggressive. It will
; scan their gear for bindings and modify animations accordingly. These animations work perfectly fine even if no actors are restrained
; so they're safe to use in either case.
; 

; Retrieves the ZaZ SexLab instance.
; 
zbfSexLab Function GetApi() Global
	Return zbfUtil.GetGenericForm(0x0200CD14) As zbfSexLab
EndFunction

; Compound function to replace SexLabFramework::GetAnimationsByTag
; 
; Fetches a list of all entries that are reasonable given the provided actors, items worn by those actors, and requested keywords. 
; Some combinations will likely return few or no entries. Examples include oral sex on gagged actors, 
; or missionary sex with belted actors. An empty list is a good indicator that there are too many 
; conditions, or conflicting conditions.
; 
; The ::StartSex function can still work on empty lists, but will send of all actors to do solo animations instead. For two actors,
; with no requirements in asRequired and asBlocked, this function will return a list that can play sex animations using ::StartSex.
; 
; This functions is normally all you will need to find a list of suitable ZAP entries to use as base. If
; you further want to customize behavior, see the rest of the api under the ::Advanced section.
; 
; Parameters:
; akActors - List of all actors to include in the filtering.  
;            All their worn items will be considered for block/require by the animation system.  
;            Should be the same list sent to ::StartSex.
; asRequired - Any additional required keywords, in a comma separated list.
; asBlocked - Any unwanted keywords in a comma separated list.
; abSoftCheck - If set to true, then the function will evaluate first requirement up to aiMinActorCount, store 
;               that result, and then evaluate the rest of the actors.  
;               If there are no matches for the rest, then the first stored result will return. The rest of the 
;               actors can then be sent off to solos. This makes it possible to configure large groups having 
;               sex without having explicit animation support for such large groups.
; aiMinActorCount - The optional parameter aiMinActorCount is the lowest number of actors for which an animation must be found.
;                   The highest number of actors is always the number of passed in actors. If left at default setting, then it is assumed that
;                   every actor must fit in the animation.  
;                   This value is typically set to 2 or not touched at all.
; 
; Examples:
; GetEntriesByTags(actors, "missionary, aggressive") ; all animations that are aggressive and missionary
; GetEntriesByTags(actors, "loving", "kissing")	; all animations that are loving, but not kissing
; GetEntriesByTags(actors, "missionary", aiMinActorCount = 2) ; tries to find missionary entries for at least the first 2 actors. the rest can be sent off to solos if needed.
; 
zbfSexLabBaseEntry[] Function GetEntriesByTags(Actor[] akActors, String asRequired = "", String asBlocked = "", Bool abSoftCheck = True, Int aiMinActorCount = -1)
	Int iActorCount = zbfUtil.CountActorList(akActors)
	Log("GetEntriesByTag", "Too few actors passed to GetEntriesByTags.", aiLevel = iError, abCondition = (iActorCount < 1))
	If aiMinActorCount < 1 || aiMinActorCount > iActorCount
		Log("GetEntriesByTag", "Number of actors passed (" + iActorCount + ") must be at least as many as the specified minimum (" + aiMinActorCount + ").", aiLevel = iError, abCondition = (aiMinActorCount > iActorCount))
		aiMinActorCount = iActorCount
	EndIf

	zbfSexLabBaseEntry[] list = GetEntries()

	; Global checks: number of actors, and animation tags
	FilterEntriesOnActorCount(list, aiMinActorCount, iActorCount)
	FilterEntries(list, 0, zbfUtil.ArgString(asRequired), zbfUtil.ArgString(asBlocked))

	; Minimum viable entries list, filtered on actors
	Int i = 0
	While i < aiMinActorCount
		FilterEntries(list, i + 1, GetRequiredTags(akActors[i]), GetBlockedTags(akActors[i]))
		i += 1
	EndWhile
	zbfSexLabBaseEntry[] backup = CloneEntriesList(list)

	; Check the rest of the actors
	While i < iActorCount
		FilterEntries(list, i + 1, GetRequiredTags(akActors[i]), GetBlockedTags(akActors[i]))
		i += 1
	EndWhile

	; Do we need to fall back to the minimum set? Are we allowed to (abSoftCheck)?
	Int iActive = CountActiveEntries(list)
	If iActive <= 0 && abSoftCheck
		Return backup
	EndIf
	Return list
EndFunction

; Compound function to mimic behavior of SexLabFramework::StartSex
; 
; Starts sex with the actors provided in the actor array, and returns an int indicating the newly created thread id
; (like SexLabFramework does). 
; 
; The central difference is that it accepts a list of base entries instead of a list of animations. Base entries will be
; defined into animations, but this happens inside the function.
; 
; This functions is normally all you will need to start a SexLab animation from a list of potential entries. If you 
; further want to customize behavior, see the rest of the api under the ::Advanced section.
; 
; akActors - A list of all the actors that are part of the animation.
; akEntries - A list of zbfSexLabBaseEntries from which a random entry will be selected and played.
; Victim - Point this to the "victim" in the animation. Works the same as the parameter with the same name in SexLabFramework::StartSex.
; CenterOn - Animation center point. Works the same as the parameter with the same name in SexLabFramework::StartSex.
; AllowBed - Should a bed be used if available and nearby?
; Hook -  Works the same as the parameter with the same name in SexLabFramework::StartSex.
; abUseOverrides - If set to true, voice and expression will be overriden on gagged actors, as well as any other bondage specific adjustments.  
;                  This is the recommended behavior.
; 
Int Function StartSex(Actor[] akActors, zbfSexLabBaseEntry[] akEntries, Actor Victim = None, ObjectReference CenterOn = None, Bool AllowBed = True, String Hook = "", Bool abUseOverrides = True)
	String options = ""
	Int i

	If !AllowBed
		options += ", NoBed"
	EndIf
	If !abUseOverrides
		options += ", NoOverrides"
	EndIf
	
	i = akActors.Length
	While i > 0
		i -= 1
		If akActors[i] == Victim
			options += ", Vic" + (i + 1)
		EndIf
	EndWhile
	
	Return StartSexEx(akActors, akEntries, options, CenterOn = CenterOn, Hook = Hook)
EndFunction

; Starts a SexLab thread based on settings.
; 
; Adds and changes parameters compared to ::StartSex which is maintained because of backward compatibility and ease of integration with SexLab code.
; 
; Future proofing adds a generic parameter asOptions which is a comma delimited list of extra options to use instead of the parameters normally sent to SexLab.
; 
; For this reason, parameters AllowBed, Hook and abUseOverrides have been removed and replaced by options instead.
; NoBed - Works like the AllowBed parameter in ::StartSex set to False.
; NoOverrides - Works like the abUseOverrides set to False.
; VicN - Sets the nth actor as victim. (eg. Vic1 sets akActors[0], as a victim).
; NoStart - Does not start the thread after setting up, allowing further customization.
; NoUndress - All actors will use minimal undressing.
; Forced - Same as Vic1 (just easier to remember)
; 
; Example:  
; StartSexEx(actors, list, zbfUtil.ArgString("AllowBed, UseOverrides"))  
; StartSexEx(actors, list, zbfUtil.ArgString(",, AllowBed,UseOverrides")) ; equivalent to line above - zbfUtil::ArgString will handle empty entries, and surrounding whitespace is ignored  
; 
Int Function StartSexEx(Actor[] akActors, zbfSexLabBaseEntry[] akEntries, String asOptions = "", ObjectReference CenterOn = None, String Hook = "")
	Int i
	String[] options = zbfUtil.ArgString(asOptions)
	Bool allowBed = (options.Find("NoBed") == -1)
	Bool useOverrides = (options.Find("NoOverrides") == -1)
	Bool[] victims = New Bool[4]
	victims[0] = (options.Find("Vic1") != -1) || (options.Find("Forced") != -1)
	victims[1] = (options.Find("Vic2") != -1)
	victims[2] = (options.Find("Vic3") != -1)
	victims[3] = (options.Find("Vic4") != -1)
	Bool noUndress = (options.Find("NoUndress") != -1)

	Log("StartSexEx", "Options " + asOptions)
	Log("StartSexEx", "Options parse to AllowBed = " + allowBed + ", UseOverrides = " + useOverrides + ", victims = " + victims + ", no undress = " + noUndress)

	zbfSexLabBaseEntry entry = GetRandomEntry(akEntries)
	sslBaseAnimation anim = None
	sslThreadModel thread = None
	Int iActorCount = zbfUtil.CountActorList(akActors)

	thread = SexLab.NewThread()
	If thread != None
		anim = NewAnimation("ZapStartSex")
		Log("StartSexEx", "anim was None.", abCondition = (anim == None))
	EndIf

	If anim == None || thread == None
		Log("StartSexEx", "Failed to start sex. Try restarting ZaZ Animation Pack and see if the problem persists.", aiLevel = iError)
		Return -1
	EndIf

	; At this point, both thread and animation are set up.
	DefineAnimationEx(entry, anim, akActors)

	; Push into an array
	sslBaseAnimation[] Animations = New sslBaseAnimation[1]
	Animations[0] = anim

	; Set up the thread
	thread.SetAnimations(Animations)
	thread.DisableLeadIn(disabling = True)
	thread.DisableBedUse(!allowBed)
	If CenterOn != None
		thread.CenterOnObject(CenterOn)
	EndIf
	thread.SetHook(Hook)

	i = 0
	While i < akActors.Length
		Actor a = akActors[i]
		If a != None
			thread.AddActor(a, isVictim = victims[i])
			thread.DisableRagdollEnd(a, disabling = True)
			If noUndress || (entry != None && entry.HasTagForActor(i + 1, "NoStrip"))
				thread.SetStrip(a, NoStripSlots)
			Else
				thread.SetStrip(a, DefaultStripSlots)
			EndIf
			thread.DisableUndressAnimation(a, disabling = True)
		EndIf
		i += 1
	EndWhile

	If useOverrides
		Log("StartSexEx", "Adjusting actor aliases for gagged effects.")
		AdjustActorAliases(thread)
	EndIf

	; Return before starting?
	If options.Find("NoStart") != -1
		Return thread.tid
	EndIf

	Log("StartSexEx", "Starting the thread .... .")
	If thread.StartThread()
		Return thread.tid
	EndIf

	; Something failed, clean up
	ReleaseAnimation(anim)
	Return -1	
EndFunction


; 
; @section: Advanced
; 
; In this section, several new functions are introduced to allow more fine grained control of animation selection.
; 
; Many of the consepts in this section requires reading through ::Intro as well as looking at the contents of zbfSexLabBaseEntry::
; 

; Retrieves all base animation entries
; 
; Regular animations are animations that do not require any special pillories, milking machines or other exotic
; circumstances or cases. These are safe to pick up and filter based on bindings (gags, chastity belts, etc).
; 
; Special entries generally require something special to make sense. They may pop up pillories, devices, or require
; very special kinds of gear to make sense. These should generally be hand picked or carefully selected (possibly further 
; filtered, based on circumstances).
; 
; This division is set up to make sure that items like pillories and so on do not pop up randomly when new animations are added.
; 
; The regular entries should only contain sex animations in various state of bondage.
; 
zbfSexLabBaseEntry[] Function GetEntries(Bool abRegularEntries = True, Bool abSpecialEntries = False)
	Int i
	Int j
	zbfSexLabBaseEntry[] filtered = GetEmptyEntries() ; No dynamic allocation of required size
	j = 0
	i = Entries.Length
	While (i > 0) && (abRegularEntries)
		i -= 1
		filtered[j] = Entries[i]
		j += 1
	EndWhile
	i = SpecialEntries.Length
	While (i > 0) && (abSpecialEntries)
		i -= 1
		filtered[j] = SpecialEntries[i]
		j += 1
	EndWhile
	Return filtered
EndFunction

; Retrieves all creature related entries
; 
; This function will return all entries that match creatures of some kind. Further filtering is needed on the type of
; creature to figure out something that works.
; 
zbfSexLabBaseEntry[] Function GetCreatureEntries()
	Return CreatureEntries
EndFunction

; Creates a copy of a list of zbfSexLabBaseEntry:: records.
; 
; The list may be up to the size of the list that ::GetEntries allocates, but no longer.
; 
zbfSexLabBaseEntry[] Function CloneEntriesList(zbfSexLabBaseEntry[] akList)
	zbfSexLabBaseEntry[] list = GetEmptyEntries()
	Log("CloneEntriesList", "Can't copy because the list of entries was too long.", aiLevel = iError, abCondition = (akList.Length > list.Length))

	Int i = akList.Length
	While i > 0
		i -= 1
		list[i] = akList[i]
	EndWhile
	Return list
EndFunction

; Filters a list of entries on the specified actor id.
; 
; Typically this function is called multiple times on a base list to arrive at the final filtered result.
; 
; If aiActorId is set to 0, the global list of tags (for that entry) is filtered. Otherwise the
; specified actor position is filtered.
; 
; For a walkthrough of what to filter, please see zbfSexLabEntryBase:: which explains this in more
; detail.
; 
Function FilterEntries(zbfSexLabBaseEntry[] akList, Int aiActorId, String[] asRequired, String[] asForbidden)
	Log("FilterEntries", "Filtering on " + aiActorId + " require: " + asRequired + ", blocked: " + asForbidden)
	Int i = akList.Length
	While i > 0
		i -= 1
		If akList[i] != None
			If !akList[i].IsValidTags(aiActorId, asRequired, asForbidden)
				akList[i] = None
			EndIf
		EndIf
	EndWhile
EndFunction

; Keeps entries where at least one keyword in asAny is present for the global tag.
; 
; Code: Keeps entries which are "aggressive", and either "doggystyle", "missionary", or both.
; zbfSexLabBaseEntry[] list = GetEntriesByTags(actors, "aggressive")
; FilterEntriesAny(list, zbfUtil.ArgString("doggystyle,missionary"))
; 
Function FilterEntriesAny(zbfSexLabBaseEntry[] akList, String[] asAny)
	Log("FilterEntries", "Filtering entries that contain some of " + asAny + " keywords.")
	Int i = akList.Length
	While i > 0
		i -= 1
		If akList[i] != None
			If !akList[i].HasAnyTag(0, asAny)
				akList[i] = None
			EndIf
		EndIf
	EndWhile
EndFunction

; Filters a list of entries to remove entries with an unmatched actor count
; 
; Only entries with the specified actor count range  remain in the list after filtering.
; 
; For a walkthrough of what to filter, please see zbfSexLabEntryBase:: which explains this in more
; detail.
; 
Function FilterEntriesOnActorCount(zbfSexLabBaseEntry[] akList, Int aiMinActors, Int aiMaxActors)
	Log("FilterEntries", "Removing entries with less than " + aiMinActors + " or more than " + aiMaxActors + ".")
	Int i = akList.Length
	While i > 0
		i -= 1
		zbfSexLabBaseEntry entry = akList[i]
		If entry != None
			If (entry.NumActors < aiMinActors) || (entry.NumActors > aiMaxActors)
				akList[i] = None
			EndIf
		EndIf
	EndWhile
EndFunction

; Searches the list of entries for a vanilla id
; 
; Useful if you want to find an animation to replace a vanilla entry with something else.
; 
; If this function fails to find an animation, then None is returned. An empty string will
; always fail this function.
; 
zbfSexLabBaseEntry Function GetEntryByVanillaId(String asId)
	Int i = Entries.Length
	While (i > 0) && (asId != "")
		i -= 1
		If (Entries[i] != None) && (Entries[i].VanillaBaseId == asId)
			Return Entries[i]
		EndIf
	EndWhile
	Return None ; Failure
EndFunction

; Fetches a random entry from a list of entries.
; 
; The list of entries need not be sorted or otherwise arranged in any way. None entries are ignored
; and a random zbfSexLabBaseEntry:: is returned, assuming that there exists at least one entry in the array.
; 
; If no entry can be provided, None is returned.
; 
zbfSexLabBaseEntry Function GetRandomEntry(zbfSexLabBaseEntry[] akEntries)
	Int[] iFoundIndex = New Int[20] ; All found entry indices are stored here, then referenced again
	Int iActive = 0
	Int i = akEntries.Length
	While i > 0
		i -= 1
		If akEntries[i] != None
			iFoundIndex[iActive] = i
			iActive += 1
		EndIf
	EndWhile
	If iActive < 1
		Return None
	EndIf

	Return akEntries[iFoundIndex[Utility.RandomInt(0, iActive - 1)]]
EndFunction

; Returns a list of all the bind types used in this scene.
; 
; For a two actor scene where just the primary actor is bound this may look something like: 
; [1, -1, -1, -1], where 1 == iBindWrists and -1 == iBindUnbound
; 
; See zbfBondageShell::EnumBindType
; 
Int[] Function GetBindTypes(Actor[] akList)
	Int[] bindTypes = New Int[4]
	bindTypes[0] = zbf.GetBindTypeFromWornKeywords(akList[0])
	bindTypes[1] = zbf.GetBindTypeFromWornKeywords(akList[1])
	bindTypes[2] = zbf.GetBindTypeFromWornKeywords(akList[2])
	bindTypes[3] = zbf.GetBindTypeFromWornKeywords(akList[3])
	Return bindTypes
EndFunction

; Retrieves the full animation names for each actor.
; 
; For each actor, an entry is returned in the form _ZapWriBlowjob01_, so the animation definition function only
; has to add the actor number and the stage number for each entry.
; 
; A fully qualified SexLab animation event looks like _ZapWriBlowjob01_A2_S3_, so this function only partially 
; defines the animation name.
; 
String[] Function GetSexLabAnimationNames(zbfSexLabBaseEntry akEntry, Int[] aiBindTypes)
	String[] animNames = New String[4]
	If akEntry != None
		animNames[0] = zbf.GetSexLabAnimationName(akEntry, aiBindTypes[0])
		animNames[1] = zbf.GetSexLabAnimationName(akEntry, aiBindTypes[1])
		animNames[2] = zbf.GetSexLabAnimationName(akEntry, aiBindTypes[2])
		animNames[3] = zbf.GetSexLabAnimationName(akEntry, aiBindTypes[3])
	EndIf
	Return animNames
EndFunction

; Creates a new SexLab thread.
; 
; Uses SexLab internally to create the new thread. SexLab is also responsible for cleaning up the
; newly created thread.
; 
sslThreadModel Function NewThread(String asModName)
	Log("NewThread", "Created by " + asModName)
	Return SexLab.NewThread()
EndFunction

; Fetches a new animation to set up
; 
; This returns a new animation that can be sent to ::DefineAnimation or similar.
; Note that sslBaseAnimations returned in this manner are supposed to be played in short
; order. Skyrim can not actually dynamically allocate animations, and the available empty
; slots can run out.
; 
; If this function fails to run correctly, None is returned.
;
; Note that an animation created in this way will automatically be returned to the pool of
; available animations after playing.
; 
sslBaseAnimation Function NewAnimation(String asModName)
	Log("NewAnimation", "Created by " + asModName)

	sslBaseAnimation anim = None
	Int i = BorrowModNames.Find("")
	If i != -1
		Log("NewAnimation", "Found free slot " + i + " for " + asModName)

		BorrowModNames[i] = asModName
		anim = BorrowSlots[i]
		anim.Initialize()
	EndIf
	Return anim
EndFunction

; Returns an animation to the animation pool.
; 
; This function will only act on animations created with NewAnimation.
; 
; Note that this function should almost never be called. Animations are automatically 
; disposed after playing. Only if the animation is not played after getting allocated 
; (ie. for some reason the caller changed his/her mind) should this function be called 
; to "manually" return the animation slot to the pool.
; 
Function ReleaseAnimation(sslBaseAnimation akAnim)
	Int i = BorrowSlots.Find(akAnim)
	If i != -1
		Log("ReleaseAnimation", "Releasing animation slot " + i + " registered to \"" + BorrowModNames[i] + "\"")
		BorrowModNames[i] = ""
	EndIf
EndFunction

; Defines an animation given a base entry
; 
; This function can be used to set up dynamic animations to support combinations of bindings not already specified in the 
; SexLab registrations. The function can optionally close (save) the animation. This is default behavior, and if it is turned
; off, then the animation needs to be manually saved to work with SexLab.
; 
; Optionally, the animation can also be named to something informative. By default, the name is selected as Zap + BaseId. This
; will give names similar to ZapMissionary01, ZapBoobJob01 and so on.
; 
; Animation base names need to be provided. See function GetSexLabAnimationNames on how to retrieve those names. zbfSexLabBaseEntry::
; has further information.
; 
; Example:  
; * DefineAnimation(akEntry, akAnim, zbfUtil.StrList("ZapWri" + akEntry.BaseName, akEntry.VanillaBaseName))  
;    Will set up an animation based on akEntry in the akAnim variable. Actor 1 is bound at the wrists, and Actor 2 will
;    use the vanilla animations.
; * DefineAnimation(akEntry, akAnim, zbfUtil.StrList("ZapYoke" + akEntry.BaseName, "ZapArmb" + akEntry.BaseName))  
;    Will set up an animation in the akAnim variable. Actor 1 is bound with a yoke, and Actor 2 is bound with an armbinder.
; 
; It is necessary to first filter suitable animation entries using the other support functions in this class, since not
; all animations are defined for every situation. If animation string names are provided that are not found in the animation
; repository, then these animations will fail to play, and the actor will stay in the previous animation or idle.
; 
Function DefineAnimation(zbfSexLabBaseEntry akEntry, sslBaseAnimation akAnim, String[] asAnims, String asName = "", Bool abSaveAnim = True)
	Log("DefineAnimation", "Empty animation created. This is almost always a mistake. (akEntry was None and abSaveAnim was True)", aiLevel = iWarning, abCondition = (akEntry == None && abSaveAnim))
	Log("DefineAnimation", "Called on (" + asAnims + ")")
	akAnim.Initialize()

	If akEntry != None
		String sName = asName
		If sName == ""
			sName = "Zap" + akEntry.BaseId
		EndIf

		DefineAnimationFromId(akEntry, akAnim, sName, asAnims)
		akAnim.AddTags(akEntry.GetTags(0))
		akAnim.AddTag("NoSwap")
		akAnim.AddTag("ZaZ")
	EndIf

	If abSaveAnim
		akAnim.Save(-1)
	EndIf
EndFunction

; Defines an animation to play
; 
; See ::DefineAnimation for a longer description.
; 
; This function does away with many unnecessary steps in setting up animations. Simply send it a list of actors, and it will
; set up the animation according to default rules.
; 
; If the entry is not big enough to hold all defined actors, solos will be set up according to actor gender.
; 
; asOptions is a new parameter which is a comma separated list of extra options to use. Currently the following options are used:  
;   - NoSave: Does not save the animation after setting it up.
;   - NoAutoTags: Does not automatically provide tags for the animation.
;   - NoSolo: If too many actors, does not put them in solo animations, and does not add those actors to the animation.
; 
Function DefineAnimationEx(zbfSexLabBaseEntry akEntry, sslBaseAnimation akAnim, Actor[] akActors, String asOptions = "")
	Log("DefineAnimationEx", "")
	If akEntry == None
		Log("DefineAnimationEx", "Forcing entry to AllSolo01.")
		akEntry = AllSoloEntry
	EndIf

	Int i
	String[] optionList = zbfUtil.ArgString(asOptions)
	Bool allowSolos = (optionList.Find("noSolo") == -1)
	Bool allowAutoTags = (optionList.Find("noAutoTags") == -1)
	Bool allowSave = (optionList.Find("noSave") == -1)
	Log("DefineAnimationEx", "solos = " + allowSolos + ", auto tag = " + allowAutoTags + ", save = " + allowSave)

	Int[] bindTypes = GetBindTypes(akActors)
	String[] animationNames = GetSexLabAnimationNames(akEntry, bindTypes)
	ObjectReference center = akActors[0]

	akAnim.Initialize()
	DefineAnimationFromId(akEntry, akAnim, "ZapEx_" + akEntry.BaseId, animationNames)

	If allowSolos
		Int maxActors = zbfUtil.CountActorList(akActors)
		i = akEntry.NumActors
		While i < maxActors
			AppendSolo01(akAnim, akAnim.StageCount, bindTypes[i], akActors[i], center)
			i += 1
		EndWhile
	EndIf

	; Auto append all tags from the entry
	If allowAutoTags
		akAnim.AddTags(akEntry.GetTags(0))
		akAnim.AddTag("NoSwap")
		akAnim.AddTag("ZaZ")
	EndIf

	If allowSave
		akAnim.Save(-1)
	EndIf
EndFunction

; Tag helper functions
; 
; These functions help with tag selection for actors.
; 

; Returns the SexLab animation tag connected to the bind type
; 
; Always returns an array of strings. Strings are empty if no tags were found, or if the function fails.
; 
; Example:  
; Wearing iBindWrists will return ["Wrists"]  
; Wearing iBindArmbinder will return ["Armbinder"]  
; Wearing nothing will return [""]  
; 
String[] Function GetRequiredTags(Actor akActor)
	String[] list = New String[1]
	If akActor != None
		Int iBindType = zbf.GetBindTypeFromWornKeywords(akActor)
		If iBindType == zbf.iBindWrists
			list[0] = "Wrists"
		ElseIf iBindType == zbf.iBindArmbinder
			list[0] = "Armbinder"
		ElseIf iBindType == zbf.iBindYoke
			list[0] = "Yoke"
		EndIf
	EndIf
	Return list
EndFunction

; Returns a list of blocked SexLab tags based on worn keywords
; 
; Always returns an array of strings. Strings are empty if no tags were found, or if the function fails.
; 
; Example:  
; Wearing zbfWornGag (only) will return ["Oral"]  
; Wearing zbfWornGag, zbfPermitOral will return []  
; Wearing zbfWornBelt, zbfWornHood will return ["Oral", "Vaginal", "Anal"]  
; Wearing nothing will return [""]  
; 
; Corner case is zbfWornGag, zbfPermitOral, zbfWornHood which returns ["Oral"] - permit oral only affects gags
; 
String[] Function GetBlockedTags(Actor akActor)
	If akActor == None
		Return New String[1]
	EndIf

	Int j = 0
	String[] list = New String[4]
	If IsBlockedAnal(akActor)
		list[j] = "Anal"
		j += 1
	EndIf

	If IsBlockedVaginal(akActor)
		list[j] = "Vaginal"
		j += 1
	EndIf

	If IsBlockedOral(akActor)
		list[j] = "Oral"
		j += 1
	EndIf
	
	If IsBlockedBreast(akActor)
		list[j] = "Breast"
		j += 1
	EndIf

	If IsMale(akActor)
		list[j] = "Female"	; Males are blocked from "female only" slots
		j += 1
	EndIf

	If IsFemale(akActor)
		list[j] = "Male"	; Females are blocked from "male only" slots
		j += 1
	EndIf

	Return list
EndFunction

; Returns the number of non-empty strings in a list of strings.
; 
Int Function CountTags(String[] asTags)
	Int iCount = 0
	Int i = asTags.Length
	While i > 0
		i -= 1
		If asTags[i] != ""
			iCount += 1
		EndIf
	EndWhile
	Return iCount
EndFunction

; Is anal sex blocked on this actor?
; 
Bool Function IsBlockedAnal(Actor akActor)
	Return akActor.WornHasKeyword(zbf.zbfWornBelt)
EndFunction

; Is vaginal (or crotch) blocked on this actor?
; 
Bool Function IsBlockedVaginal(Actor akActor)
	Return akActor.WornHasKeyword(zbf.zbfWornBelt)
EndFunction

; Is oral sex blocked on this actor?
; 
Bool Function IsBlockedOral(Actor akActor)
	Return akActor.WornHasKeyword(zbf.zbfWornHood) || (akActor.WornHasKeyword(zbf.zbfWornGag) && !akActor.WornHasKeyword(zbf.zbfWornPermitOral))
EndFunction

; Is sex with breasts blocked on this actor?
; 
Bool Function IsBlockedBreast(Actor akActor)
	;Return akActor.WornHasKeyword(zbf.zbfWornBra)
	Return False
EndFunction

; Is the actor a male? (No actor is both male and female, but Actors like creatures or critters may be neither.)
; 
Bool Function IsMale(Actor akActor)
	Return akActor.GetLeveledActorBase().GetSex() == 0
EndFunction

; Is the actor a female? (No actor is both male and female, but Actors like creatures or critters may be neither.)
; 
Bool Function IsFemale(Actor akActor)
	Return akActor.GetLeveledActorBase().GetSex() == 1
EndFunction

; Retrieves a set of strip slots
; 
; This set does not depend on the actor, and is statically allocated. This means that it will always ignore the slots
; where ZAP places it's items. This is usually enough in any case, and at least ensures that no items are stripped that
; should normally remain on the actor.
; 
; ::GetDefaultStripSlots will retrive the default set of strip slots for the actor. This includes all worn items.  
; ::GetMinimumStripSlots will only strip items that occupy the expected "big" body parts: head, feet, body etc
; ::GetNoStripSlots will not strip anything. Used with the NoStrip keyword on animations.
; 
Bool[] DefaultStripSlots
Bool[] MinimumStripSlots
Bool[] NoStripSlots
Bool[] Function GetDefaultStripSlots()
	Return DefaultStripSlots
EndFunction
Bool[] Function GetMinimumStripSlots()
	Return MinimumStripSlots
EndFunction
Bool[] Function GetNoStripSlots()
	Return NoStripSlots
EndFunction




; @section: Private
; 
; These functions, properties and events are not part of the public api and should not be referenced directly 
; by modders. Functions describe instead what you should use in their documentation.
; 

; Helper function used to define animation.
; 
; This function may add further parameters in the future, so avoid calling this function directly. Use instead ::DefineAnimation to 
; set up animations to be used.
; 
Bool Function DefineAnimationFromId(zbfSexLabBaseEntry akEntry, sslBaseAnimation akAnim, String asName, String[] asAnims)
	String baseId = akEntry.BaseId
	Log("DefineAnimationFromId", "Called on " + baseId + ", as " + asName + " and with bases (" + asAnims +")")

	If baseId == "SkullFuck01"
		DefineSkullFuck01(akAnim, asName, asAnims[0], asAnims[1])
	ElseIf baseId == "BoobJob01"
		DefineBoobJob01(akAnim, asName, asAnims[0], asAnims[1])
	ElseIf baseId == "Missionary01"
		DefineMissionary01(akAnim, asName, asAnims[0], asAnims[1])
	ElseIf baseId == "Doggy01"
		DefineDoggy01(akAnim, asName, asAnims[0], asAnims[1])
	ElseIf baseId == "Lesbian01"
		DefineLesbian01(akAnim, asName, asAnims[0], asAnims[1])
	ElseIf baseId == "PilloryLick01"
		DefinePilloryLick01(akAnim, asName, asAnims[0], asAnims[1])
	ElseIf baseId == "PillorySex01"
		DefinePillorySex01(akAnim, asName, asAnims[0], asAnims[1])
	ElseIf baseId == "Missionary02"
		DefineMissionary02(akAnim, asName, asAnims[0], asAnims[1])
	ElseIf baseId == "MilkMachine01"
		DefineMilkMachine01(akAnim, asAnims[0], asAnims[1])
	ElseIf baseId == "Furo01"
		DefineFuro01(akAnim, asName, asAnims[0])
	ElseIf baseId == "Spank01"
		DefineSpank01(akAnim, asName, asAnims[0], asAnims[1])
	ElseIf baseId == "Kissing01"
		DefineKissing01(akAnim, asName, asAnims[0], asAnims[1])
	ElseIf baseId == "Blowjob01"
		DefineBlowjob01(akAnim, asName, asAnims[0], asAnims[1])
	ElseIf baseId == "Missionary03"
		DefineMissionary03(akAnim, asName, asAnims[0], asAnims[1])
	ElseIf baseId == "Foreplay01"
		DefineForeplay01(akAnim, asName, asAnims[0], asAnims[1])
	ElseIf baseId == "FemaleSolo01"
		DefineFemaleSolo01(akAnim, asName, asAnims[0])
	ElseIf baseId == "XcrossLick01"
		DefineXCrossLick01(akAnim, asName, asAnims[0], asAnims[1])
	ElseIf baseId == "Lick01"
		DefineLick01(akAnim, asName, asAnims[0], asAnims[1])
	ElseIf baseId == "CreatureFalmer01"
		DefineCreatureFalmer01(akAnim, asName)
	ElseIf baseId == "Missionary04"
		DefineMissionary04(akAnim, asName, akEntry.VanillaBaseName, akEntry.VanillaBaseName)
	ElseIf baseId == "Blowjob02"
		DefineBlowjob02(akAnim, asName, akEntry.VanillaBaseName, akEntry.VanillaBaseName)
	ElseIf baseId == "Doggy02"
		DefineDoggy02(akAnim, asName, akEntry.VanillaBaseName, akEntry.VanillaBaseName)
	ElseIf baseId == "Fisting01"
		DefineFisting01(akAnim, asName, akEntry.VanillaBaseName, akEntry.VanillaBaseName)
	ElseIf baseId == "Missionary05"
		DefineMissionary05(akAnim, asName, akEntry.VanillaBaseName, akEntry.VanillaBaseName)
	ElseIf baseId == "Doggy03"
		DefineDoggy03(akAnim, asName, akEntry.VanillaBaseName, akEntry.VanillaBaseName)
	ElseIf baseId == "Threesome01"
		DefineThreesome01(akAnim, asName, akEntry.VanillaBaseName, akEntry.VanillaBaseName, akEntry.VanillaBaseName)
	ElseIf baseId == "Threesome02"
		DefineThreesome02(akAnim, asName, akEntry.VanillaBaseName, akEntry.VanillaBaseName, akEntry.VanillaBaseName)
	ElseIf baseId == "Threesome03"
		DefineThreesome03(akAnim, asName, akEntry.VanillaBaseName, akEntry.VanillaBaseName, akEntry.VanillaBaseName)
	ElseIf baseId == "Spank02"
		DefineSpank02(akAnim, asName, akEntry.VanillaBaseName, akEntry.VanillaBaseName)
	ElseIf baseId == "Spank03"
		DefineSpank03(akAnim, asName, akEntry.VanillaBaseName, akEntry.VanillaBaseName)
	ElseIf baseId == "AllSolo01"
		DefineAllSolo(akAnim, asName)
	Else
		Log("DefineAnimationFromId", "BaseId(" + baseId + ") was not found in the repository.", iError)
		Return False
	EndIf

	Return True
EndFunction

; Returns number of non-None entries in an array of zbfSexLabEntry::.
; 
; Since filtering will just remove entries from a list, this function can be used to tell you how many entries are still active
; with the filtering already done.
; 
Int Function CountActiveEntries(zbfSexLabBaseEntry[] akEntries)
	Int iActive = 0
	Int i = akEntries.Length
	While i > 0
		i -= 1
		If akEntries[i] != None
			iActive += 1
		EndIf
	EndWhile
	Return iActive
EndFunction

; Helper function to set up stuff on each actor.
; 
; Use ::SetupSexLabActors instead. See that function for documentation.
; 
Function SetupSexLabActor(sslThreadModel akThread, Actor akActor, Bool abIsVictim = False)
	If akActor != None
		Log("SetupSexLabActor", "Setting up actor " + akActor + ", victim = " + abIsVictim  + ".")

		akThread.AddActor(akActor, isVictim = abIsVictim)
		akThread.DisableRagdollEnd(akActor, disabling = True)
		akThread.SetStrip(akActor, GetDefaultStripSlots())
		akThread.DisableUndressAnimation(akActor, disabling = True)
	EndIf
EndFunction

; Helper function to create an array of strings.
; 
; Use zbfUtil::StrList instead. Using this function is safe, as it is very unlikely to change.
; 
String[] Function StrList(String asS1 = "", String asS2 = "", String asS3 = "", String asS4 = "", String asS5 = "", String asS6 = "")
	String[] list
	If asS1 == ""
		Return list ; Just an empty list then ....
	ElseIf asS2 == ""
		list = New String[1]
		list[0] = asS1
	ElseIf asS3 == ""
		list = New String[2]
		list[0] = asS1
		list[1] = asS2
	ElseIf asS4 == ""
		list = New String[3]
		list[0] = asS1
		list[1] = asS2
		list[2] = asS3
	ElseIf asS5 == ""
		list = New String[4]
		list[0] = asS1
		list[1] = asS2
		list[2] = asS3
		list[3] = asS4
	ElseIf asS6 == ""
		list = New String[5]
		list[0] = asS1
		list[1] = asS2
		list[2] = asS3
		list[3] = asS4
		list[4] = asS5
	Else
		list = New String[6]
		list[0] = asS1
		list[1] = asS2
		list[2] = asS3
		list[3] = asS4
		list[4] = asS5
		list[5] = asS6
	EndIf
	Return list
EndFunction

; Dynamic linking method.
; 
; Used internally to make sure this script can interact with SexLab.
; 
Function LinkDependency()
	SexLab = SexLabUtil.GetAPI()
	If SexLab != None
		PrepareFactory()
	EndIf
EndFunction

; Returns true if dynamic linking succeeded. Attempts to link if it has previously failed.
; 
Bool Function HasSexLab()
	If SexLab == None
		InitializeModule()
	EndIf
	Return SexLab != None
EndFunction

; Returns registered SexLab version
Int Function GetVersion()
	If SexLab != None
		Return SexLabUtil.GetVersion()
	EndIf
	Return 0
EndFunction

; Returns registered SexLab version
String Function GetStringVer()
	Return SexLabUtil.GetStringVer()
EndFunction

String Function GetAnimName(Int i)
	Return sAnimList[i]
EndFunction

Int Function GetAnimCount()
	Return sAnimList.Length
EndFunction

Bool Function GetAnimRegistered(Int i)
	Return (SexLab.FindAnimationByName(sAnimList[i]) != -1)
EndFunction

Bool Function IsFullyRegistered()
	If SexLab == None
		Return False
	EndIf

	Int i = sAnimList.Length - 1
	While i >= 0
		If SexLab.FindAnimationByName(sAnimList[i]) == -1
			Return False
		EndIf
		i -= 1
	EndWhile
	Return True
EndFunction

Function InitializeModule()
	; RegisterForSexLab() - registering is optional
	LinkDependency()

	RebuildBaseAnimations()
	RebuildVoices()
	RebuildExpressions()
	RegisterForSexLabEvents()

	DefaultStripSlots = New Bool[33]
	Int i = DefaultStripSlots.Length
	While i > 0
		i -= 1
		DefaultStripSlots[i] = True
	EndWhile
	zbf.ModifySexLabStripSlots(DefaultStripSlots) ; Keep all binding slots
	DefaultStripSlots[35 - 30] = False ; Amulets
	DefaultStripSlots[36 - 30] = False ; Rings
	DefaultStripSlots[42 - 30] = False ; Circlet
	DefaultStripSlots[40 - 30] = False ; Tail
	DefaultStripSlots[43 - 30] = False ; Ears

	MinimumStripSlots = New Bool[33]
	MinimumStripSlots[30 - 30] = True ; Head
	MinimumStripSlots[31 - 30] = True ; Hair
	MinimumStripSlots[32 - 30] = True ; Body
	MinimumStripSlots[33 - 30] = True ; Hands
	MinimumStripSlots[34 - 30] = True ; Forearms
	MinimumStripSlots[37 - 30] = True ; Feet
	MinimumStripSlots[38 - 30] = True ; Calves
	MinimumStripSlots[39 - 30] = True ; Shield
	MinimumStripSlots[62 - 30] = True ; Weapons

	NoStripSlots = New Bool[33]
	NoStripSlots[39 - 30] = True ; Shield
	NoStripSlots[62 - 30] = True ; Weapons
EndFunction

Function RegisterForSexLab()
	Log("RegisterForSexLab", "Registering SexLab animations.")
	Log("RegisterForSexLab", "SexLab connection was not set up. Registration will do nothing.", iError, SexLab == None)

	; Retrieve SexLab Integration
	If SexLab != None
		RegisterAnimation("PilloryBoundSex01")
		RegisterAnimation("PilloryBoundSex02")
		RegisterAnimation("PillorySex01")
		RegisterAnimation("PillorySex02")
		RegisterAnimation("PilloryTorment01")
		RegisterAnimation("PilloryTorment02")

		RegisterAnimation("BoundDoggyStyle")
		RegisterAnimation("ArmbinderDoggyStyle")
		RegisterAnimation("BothBoundDoggyStyle")
		RegisterAnimation("BothArmbinderDoggyStyle")

		RegisterAnimation("BoundMissionary")
		RegisterAnimation("ArmbinderMissionary")

		RegisterAnimation("BoundSkullFuck")
		RegisterAnimation("ArmbinderSkullFuck")

		RegisterAnimation("BoundLesbian")
		RegisterAnimation("BothBoundLesbian")
		RegisterAnimation("ArmbinderLesbian")
		RegisterAnimation("BothArmbinderLesbian")

		RegisterAnimation("ArmbinderArrokBoobjob")
		RegisterAnimation("BoundArrokBoobjob")
	EndIf

	Log("RegisterForSexLab", "Done!")
EndFunction

Function RebuildBaseAnimations()
	Int i
	Int j

	i = BaseSlots.Length
	While i > 0
		i -= 1
		BaseSlots[i].SetDefaults()
	EndWhile

	; Distribute slots between the special and regular entries
	Entries = New zbfSexLabBaseEntry[25]
	j = 0
	i = Entries.Length
	While i > 0
		i -= 1
		Entries[i] = BaseSlots[j]
		j += 1
	EndWhile
	SpecialEntries = New zbfSexLabBaseEntry[6]
	i = SpecialEntries.Length
	While i > 0
		i -= 1
		SpecialEntries[i] = BaseSlots[j]
		j += 1
	EndWhile
	CreatureEntries = New zbfSexLabBaseEntry[1]
	i = CreatureEntries.Length
	While i > 0
		i -= 1
		CreatureEntries[i] = BaseSlots[j]
		j += 1
	EndWhile

	Int definedEntries = 0

	; Define the solo entry
	DefineAllSoloBase(AllSoloEntry)

	; Define all the base animations
	DefineMissionary01Base(Entries[0])
	DefineSkullfuck01Base(Entries[1])
	DefineBoobJob01Base(Entries[2])
	DefineLesbian01Base(Entries[3])
	DefineDoggy01Base(Entries[4])
	DefineMissionary02Base(Entries[5])
	DefineFemaleSolo01Base(Entries[6])
	DefineMissionary03Base(Entries[7])
	DefineForeplay01Base(Entries[8])
	DefineLick01Base(Entries[9])
	DefineKissing01Base(Entries[10])
	definedEntries += 11

	; NSAP animations added here
	If zbfEx.GetNsapVersion() >= 2000
		DefineBlowjob01Base(Entries[definedEntries + 0])
		definedEntries += 1
	EndIf

	If zbfEx.GetNsapVersion() >= 3000
		DefineMissionary04Base(Entries[definedEntries + 0])
		DefineBlowjob02Base(Entries[definedEntries + 1])
		DefineDoggy02Base(Entries[definedEntries + 2])
		DefineFisting01Base(Entries[definedEntries + 3])
		DefineMissionary05Base(Entries[definedEntries + 4])
		DefineDoggy03Base(Entries[definedEntries + 5])
		DefineThreesome01Base(Entries[definedEntries + 6])
		DefineThreesome02Base(Entries[definedEntries + 7])
		DefineThreesome03Base(Entries[definedEntries + 8])
		DefineSpank02Base(Entries[definedEntries + 9])
		DefineSpank03Base(Entries[definedEntries + 10])
		definedEntries += 11
	EndIf

	DefinePilloryLick01Base(SpecialEntries[0])
	DefinePillorySex01Base(SpecialEntries[1])
	DefineMilkMachine01Base(SpecialEntries[2])
	DefineFuro01Base(SpecialEntries[3])
	DefineSpank01Base(SpecialEntries[4])
	DefineXcrossLick01Base(SpecialEntries[5])
	definedEntries = 6

	DefineCreatureFalmer01Base(CreatureEntries[0])
	definedEntries = 1

	i = BaseSlots.Length
	While i > 0
		i -= 1
		BaseSlots[i].Finalize()
	EndWhile

	Log("RebuildBaseAnimations", "Animation entries defined.")
	LogEntries("RebuildBaseAnimations", "Entries", Entries)
	LogEntries("RebuildBaseAnimations", "Special entries", SpecialEntries)
EndFunction

Function RebuildVoices()
	DefineFemaleGagVoice01(FemaleGagVoice01)
	DefineMaleGagVoice01(MaleGagVoice01)
EndFunction

Function RebuildExpressions()
	DefineGagExpressionAfraid(GagExpression[0])
	DefineGagExpressionShy(GagExpression[1])
	DefineGagExpressionHappy(GagExpression[2])
	DefineGagExpressionSad(GagExpression[3])
	DefineGagExpressionAngry(GagExpression[4])
EndFunction

Function RegisterForSexLabEvents()
	RegisterForModEvent("HookAnimationStart", "OnAnimationStart")
	RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
EndFunction

Faction Function GetAnimatingFaction()
	return Game.GetFormFromFile(0xE50F , "SexLab.esm") as Faction
EndFunction

; Replaces gag sounds instead of regular moans.
; 
Function AdjustActorAliasVoice(sslActorAlias akActorAlias, Actor akActor)
	If akActor != None
		sslBaseVoice voice = akActorAlias.GetVoice()
		sslBaseVoice newVoice

		If akActor.WornHasKeyword(zbf.zbfWornGag)
			If (voice != None) && (voice.HasTag("NoSwap"))
				Return
			EndIf

			ActorBase base = akActor.GetLeveledActorBase()
			If base.GetSex() == 1 ; Female
				newVoice = FemaleGagVoice01
			ElseIf base.GetSex() == 0 ; Male
				newVoice = MaleGagVoice01
			EndIf

			Log("AdjustActorAliasVoice", "Replacing voice on " + zbfUtil.GetActorName(akActor) + " with " + newVoice.Name)
			akActorAlias.SetVoice(newVoice, ForceSilence = bForceSilenceSexLabSound)
		EndIf
	EndIf
EndFunction

Function AdjustActorAliasExpression(sslActorAlias akActorAlias, Actor akActor)
	If akActor != None
		sslBaseExpression expression = akActorAlias.GetExpression()
		sslBaseExpression newExpression

		If akActor.WornHasKeyword(zbf.zbfWornGag)
			If (expression != None) && expression.HasTag("NoSwap")
				Return ; No action, expression is marked as NoSwap
			EndIf

			Int iExpression = Utility.RandomInt(0, 4)
			newExpression = GagExpression[iExpression]
			Log("AdjustActorAliasExpression", "Replacing expression (" + iExpression + ") on " + zbfUtil.GetActorName(akActor) + " with " + newExpression.Name)
			akActorAlias.SetExpression(newExpression)
		EndIf
	EndIf
EndFunction

; Checks that all actor aliases are correctly set up for SexLab.
; 
; * Replaces gag sounds instead of regular moans.
; * Replaces expressions with gagged expressions
; 
Function AdjustActorAliases(sslThreadModel akModel)
	Actor[] animActors = akModel.Positions
	Int i = animActors.Length
	While i > 0
		i -= 1
		sslActorAlias actorAlias = akModel.PositionAlias(i)

		If bOverrideSexLabExpression
			AdjustActorAliasExpression(actorAlias, animActors[i])
		EndIf
		If bOverrideSexLabSound
			AdjustActorAliasVoice(actorAlias, animActors[i])
		EndIf
	EndWhile
EndFunction

; Returns a float indicating how closely the animation and base entry match. Higher numbers means better match.
; 
; This function considers:
; * Vanilla base name							(automatically returns the base entry as "the best")
; * Position/style tags (eg missionary)			(10p for each match)
; * Actor count									(-5p for each mismatch)
; * Aggressive/Loving							(-20p for mismatch, 5p for match)
; * Foreplay/Sex								(-10p for mismatch)
; 
Int Function GetAnimBaseEntryMatch(sslBaseAnimation akAnim, zbfSexLabBaseEntry akEntry, Int aiMatchedActors)
	Int iPoints = 0

	If akAnim.Name == akEntry.VanillaBaseId
		Return 10000
	EndIf

	If akAnim.HasTag("Aggressive")
		If akEntry.HasTag("Aggressive")
			iPoints += 5
		ElseIf akEntry.HasTag("Loving")
			iPoints -= 20
		EndIf
	EndIf

	If akAnim.HasTag("Loving")
		If akEntry.HasTag("Aggressive")
			iPoints -= 20
		ElseIf akEntry.HasTag("Loving")
			iPoints += 5
		EndIf
	EndIf

	If akEntry.HasTag("Boobjob") && akAnim.HasTag("Boobjob")
		iPoints += 10
	EndIf
	If akEntry.HasTag("Blowjob") && akAnim.HasTag("Blowjob")
		iPoints += 10
	EndIf
	If akEntry.HasTag("Missionary") && akAnim.HasTag("Missionary")
		iPoints += 10
	EndIf
	If akEntry.HasTag("Doggystyle") && (akAnim.HasTag("Doggy") || akAnim.HasTag("Doggystyle"))
		iPoints += 10
	EndIf
	If akEntry.HasTag("Spank") && (akAnim.HasTag("Spank") || akAnim.HasTag("Spanking"))
		iPoints += 10
	EndIf
	If akEntry.HasTag("Cowgirl") && akAnim.HasTag("Cowgirl")
		iPoints += 10
	EndIf

	If akEntry.HasTag("Lying") && (akAnim.HasTag("Lying") || akAnim.HasTag("Laying"))
		iPoints += 5
	EndIf
	If akEntry.HasTag("Standing") && akAnim.HasTag("Standing")
		iPoints += 5
	EndIf

	If akEntry.HasTag("Sex") && akAnim.HasTag("Foreplay")
		iPoints -= 10
	EndIf
	If akEntry.HasTag("Foreplay") && akAnim.HasTag("Sex")
		iPoints -= 10
	EndIf

	iPoints -= 5 * (Math.Abs(aiMatchedActors - akEntry.NumActors) As Int)

	Return iPoints
EndFunction

; Returns the best matched base entry to the provided sslBaseAnimation.
; 
; If the entry has the same vanilla name, then the match is directly returned.
; 
; akAnim is the base animation that will be built.
; akList is the primary list to match.
; akBackup is a backup list of entries, typically selected from a larger subset (filtered on fewer actors, or less restrictions).
; aiMatchedActors is the number of actors that have been found in the animation.
; 
zbfSexLabBaseEntry Function SelectBestBaseEntry(sslBaseAnimation akAnim, zbfSexLabBaseEntry[] akList, zbfSexLabBaseEntry[] akBackup, Int aiMatchedActors)
	zbfSexLabBaseEntry[] akTemp = New zbfSexLabBaseEntry[20]

	Int iBest = 0
	Int iBestCount = 0
	Int iCurrent
	zbfSexLabBaseEntry entry

	; Merge the two lists now and fetch the best of both worlds.
	Int i = akList.Length
	While i > 0
		i -= 1
		If (akList[i] != akBackup[i]) && (akList[i] != None) && (akBackup[i] != None)
			Log("SelectBestBaseEntry", "Woah, akList and akBackup had exclusive unique entries.")
			LogEntries("SelectBestBaseEntry", "akList", akList)
			LogEntries("SelectBestBaseEntry", "akBackup", akBackup)
			Return akList[i]	; Just something ... 
		EndIf

		entry = akList[i]
		If entry == None
			entry = akBackup[i]
		EndIf

		If entry != None
			iCurrent = GetAnimBaseEntryMatch(akAnim, akList[i], aiMatchedActors)
			Log("SelectBestBaseEntry", "(" + akAnim.Name + ", " + akList[i].BaseName + ") gave a score of " + iCurrent + ".")

			If iCurrent > 1000
				Return akList[i]
			EndIf

			If iCurrent > iBest
				iBestCount = 0
				iBest = iCurrent
			EndIf

			If iCurrent == iBest
				akTemp[iBestCount] = akList[i]
				iBestCount += 1
			EndIf
		EndIf
	EndWhile
	
	If iBestCount > 0
		i = Utility.RandomInt(0, iBestCount)
		Log("SelectBestBaseEntry", "Found " + iBestCount + " entries and selected " + i + ".")
		Return akTemp[i]
	EndIf
	Return None
EndFunction

; Helper function for the animation replacer system. Returns the number of filtering keywords.
; 
Int Function FilterActorAliasTags(zbfSexLabBaseEntry[] akList, Int aiSlot, Actor akActor)
	String[] sRequiredTags = GetRequiredTags(akActor)
	String[] sBlockedTags = GetBlockedTags(akActor)
	Int iTagCount = CountTags(sRequiredTags) + CountTags(sBlockedTags)

	FilterEntries(akList, aiSlot, sRequiredTags, sBlockedTags)
	Return iTagCount - 1 ; -1 for the gender tag, which is always included
EndFunction

; Checks if the SexLab animation currently playing should be replaced.
; 
; Filters out all worn gear on actors, and makes sure that the animation playing is relevant. For instance it automatically
; will replace oral sex when an actor is gagged.
; 
; It will attempt to match the new animation with the old one to the best of its ability. Missionary animations will be replaced 
; by another missionary if possible.
; 
; If there are no worn items on the actor, the animation will just continue playing as normal.
; 
Function AdjustAnimationSelection(sslThreadController akController)
	sslBaseAnimation anim = akController.Animation
	Actor[] rawActs = akController.Positions

	If !anim.HasTag("NoSwap") && bOverrideSexLabAnimation && !anim.HasTag("Creature")
		Log("AdjustAnimationSelection", "Filtering animation " + anim.Name)
		Int iTagCount = 0
		Actor[] actors = New Actor[4]

		zbfSexLabBaseEntry[] list = GetEntries()

		; First extract a set of matching animations if only the first two actors are involved.
		; Backup the result in a fall back list of entries.
		Int i = 0
		While i < rawActs.Length && i < 2	; Filter at most two actors, then backup the result
			actors[i] = rawActs[i]
			iTagCount += FilterActorAliasTags(list, i + 1, actors[i])
			i += 1
		EndWhile
		zbfSexLabBaseEntry[] backup = CloneEntriesList(list)
		FilterEntriesOnActorCount(backup, i, i)
		LogEntries("AdjustAnimationSelection", "Backup after " + i + " actors.", backup)

		; Filter the rest of the actors and save the result in the primary list.
		While i < rawActs.Length
			actors[i] = rawActs[i]
			iTagCount += FilterActorAliasTags(list, i + 1, actors[i])
			i += 1
		EndWhile
		FilterEntriesOnActorCount(list, 2, i)
		LogEntries("AdjustAnimationSelection", "List entries remaining.", list)

		If iTagCount <= 0
			Log("AdjustAnimationSelection", "No tags were found on any of the involved actors. Bailing out.... ", abCondition = (iTagCount <= 0))
			Return	; No further actions are needed, because no filtering was done.
		EndIf

		; Fetch the best matched entry, primarily from "list" but fall back to "backup" if needed.
		; See ::SelectBestBaseEntry for description on what "best entry" means.
		zbfSexLabBaseEntry entry = SelectBestBaseEntry(anim, list, backup, rawActs.Length)

		; If an entry can't be found, there's nothing to be done. Just return in that case.
		If entry == None
			Log("AdjustAnimationSelection", "Entry was still None.", abCondition = (entry == None))
			Return
		EndIf

		Log("AdjustAnimationSelection", "Entry was " + entry.BaseId)

		sslBaseAnimation[] Animations = New sslBaseAnimation[1]
		Animations[0] = NewAnimation("ZapReplacer")

		; Setup the new animation, fill with solos as needed
		Int[] iBindTypes = GetBindTypes(actors)
		DefineAnimation(entry, Animations[0], GetSexLabAnimationNames(entry, iBindTypes), abSaveAnim = False)
		AppendSolos(entry, Animations[0], actors, iBindTypes, rawActs.Length, akController.CenterRef)
		Animations[0].Save(-1)

		akController.SetForcedAnimations(Animations)
		akController.SetAnimation()
		;akController.RealignActors()
	EndIf
EndFunction

Actor[] Function GetActorsFromThread(sslThreadController akController)
	Actor[] actors = New Actor[4]
	Int i = akController.positions.Length
	While i > 0
		i -= 1
		actors[i] = akController.positions[i]
	EndWhile
	Return actors
EndFunction

Event OnAnimationStart(Int aiThreadId, Bool abHasPlayer)
	Log("OnAnimationStart", "aiThreadId == " + aiThreadId)
	sslThreadController controller = SexLab.ThreadSlots.GetController(aiThreadId)
	Int iEvent = ModEvent.Create("ZapSexLabAnimationStart")
	If iEvent > 0
		String[] tags = controller.Animation.GetTags()
		Actor[] actors = GetActorsFromThread(controller)
		String tagStr = tags[0]
		Int i = 1
		While i < tags.Length
			tagStr += ", " + tags[i]
			i += 1
		EndWhile

		ModEvent.PushForm(iEvent, controller)
		ModEvent.PushString(iEvent, tagStr)
		ModEvent.PushForm(iEvent, actors[0])
		ModEvent.PushForm(iEvent, actors[1])
		ModEvent.PushForm(iEvent, actors[2])
		ModEvent.PushForm(iEvent, actors[3])
		ModEvent.Send(iEvent)
	EndIf

	AdjustAnimationSelection(controller)
	AdjustActorAliases(controller)
EndEvent

Event OnAnimationEnd(Int aiThreadId, Bool abHasPlayer)
	Log("OnAnimationEnd", "aiThreadId == " + aiThreadId)
	sslThreadController controller = SexLab.ThreadSlots.GetController(aiThreadId)
	Int iEvent = ModEvent.Create("ZapSexLabAnimationEnd")
	If iEvent > 0
		String[] tags = controller.Animation.GetTags()
		Actor[] actors = GetActorsFromThread(controller)
		String tagStr = tags[0]
		Int i = 1
		While i < tags.Length
			tagStr += ", " + tags[i]
			i += 1
		EndWhile

		ModEvent.PushForm(iEvent, controller)
		ModEvent.PushString(iEvent, tagStr)
		ModEvent.PushForm(iEvent, actors[0])
		ModEvent.PushForm(iEvent, actors[1])
		ModEvent.PushForm(iEvent, actors[2])
		ModEvent.PushForm(iEvent, actors[3])
		ModEvent.Send(iEvent)
	EndIf

	ReleaseAnimation(controller.Animation)
EndEvent

Function SetAnimationDefaults(sslBaseAnimation akAnim, String asName, Sound akSound, Int aiContentType)
	akAnim.Registry = asName
	akAnim.Name = asName
	
	akAnim.SetContent(aiContentType)
	akAnim.SoundFX = akSound
EndFunction

Function AppendAllIdles(sslBaseAnimation akAnim, Int aiActor, String asPre, String asPost, String[] asIdles, Float afDistance = -45.0, Int aiSos = 0, Bool abStrapOn = False)
	Int i = 0
	While i < asIdles.Length
		String sFullName = asPre + asIdles[i] + asPost
		akAnim.AddPositionStage(aiActor, sFullName, afDistance, sos = aiSos, strapon = abStrapOn, silent = false, openMouth = false)
		i += 1
	EndWhile
EndFunction

Function SetPilloryDefaults(sslBaseAnimation akAnim, String asName, Sound akSound, Int aiContentType, String[] asIdles)
	SetAnimationDefaults(akAnim, asName, akSound, aiContentType)

	Int B = akAnim.AddPosition(Female)
	AppendAllIdles(akAnim, B, "ZazAPPill", "B", asIdles, afDistance = 0, aiSos = 0)

	Int A = akAnim.AddPosition(Male)
	AppendAllIdles(akAnim, A, "ZazAPPill", "A", asIdles, afDistance = -45.0, aiSos = 3, abStrapOn = True)

	akAnim.AddTag("Pillory")
EndFunction

Function SetVoiceDefaults(sslBaseVoice akVoice, String asName, Bool abFemale)
	akVoice.Initialize()

	akVoice.Registry = "Zap" + asName
	akVoice.Name = asName
	akVoice.Gender = (abFemale as Int)
	akVoice.Enabled = False
EndFunction

Function FinalizeVoiceDefaults(sslBaseVoice akVoice)
	akVoice.AddTag("ZaZ")
	akVoice.AddTag("NoSwap")
	akVoice.Save(-1)
EndFunction

Function DefineFemaleGagVoice01(sslBaseVoice akVoice)
	SetVoiceDefaults(akVoice, "Female Gagged", abFemale = True)

	akVoice.Mild = Female01[0]
	akVoice.Medium = Female01[1]
	akVoice.Hot = Female01[2]

	akVoice.AddTag("Gagged")
	FinalizeVoiceDefaults(akVoice)
EndFunction

Function DefineMaleGagVoice01(sslBaseVoice akVoice)
	SetVoiceDefaults(akVoice, "Male Gagged", abFemale = False)

	akVoice.Mild = Male01[0]
	akVoice.Medium = Male01[1]
	akVoice.Hot = Male01[2]

	akVoice.AddTag("Gagged")
	FinalizeVoiceDefaults(akVoice)
EndFunction

Function SetExpressionDefaults(sslBaseExpression akExpression, String asName)
	akExpression.Initialize()
	
	akExpression.Registry = "Zap" + asName
	akExpression.Name = asName
EndFunction

Function FinalizeExpressionDefaults(sslBaseExpression akExpression)
	akExpression.AddTag("ZaZ")
	akExpression.AddTag("NoSwap")
	akExpression.Save(-1)
EndFunction

Function DefineGagExpression01Part(sslBaseExpression akExpression, Int aiPhase, Int aiMaleFemale)
	; Sets up just the gagged part of the expression. Using gag expression 01.
	akExpression.SetPhoneme(aiPhase, aiMaleFemale, 1, 100)
	akExpression.SetPhoneme(aiPhase, aiMaleFemale, 11, 70)
EndFunction

Function DefineGagMood01Part(sslBaseExpression akExpression, Int aiPhase, Int aiMaleFemale)
	; Defines the gag part of the expression using moods
	akExpression.SetMood(aiPhase, aiMaleFemale, 16, 100)
EndFunction

Function DefineGagExpressionAfraid(sslBaseExpression akExpression)
	SetExpressionDefaults(akExpression, "Afraid Gagged")

	akExpression.AddTag("Afraid")
	akExpression.AddTag("Pain")
	akExpression.AddTag("Negative")
	akExpression.AddTag("Gagged")

	; Male + Female
	akExpression.SetMood(1, MaleFemale, 3, 100)
	akExpression.SetModifier(1, MaleFemale, 2, 10)
	akExpression.SetModifier(1, MaleFemale, 3, 10)
	akExpression.SetModifier(1, MaleFemale, 6, 50)
	akExpression.SetModifier(1, MaleFemale, 7, 50)
	akExpression.SetModifier(1, MaleFemale, 1, 30)
	akExpression.SetModifier(1, MaleFemale, 12, 30)
	akExpression.SetModifier(1, MaleFemale, 13, 30)
	If KeepExpressionPhoneme
		akExpression.SetPhoneme(1, MaleFemale, 0, 20)
	EndIf
	DefineGagExpression01Part(akExpression, 1, MaleFemale)

	akExpression.SetMood(2, MaleFemale, 8, 100)
	akExpression.SetModifier(2, MaleFemale, 0, 100)
	akExpression.SetModifier(2, MaleFemale, 1, 100)
	akExpression.SetModifier(2, MaleFemale, 2, 100)
	akExpression.SetModifier(2, MaleFemale, 3, 100)
	akExpression.SetModifier(2, MaleFemale, 4, 100)
	akExpression.SetModifier(2, MaleFemale, 5, 100)
	If KeepExpressionPhoneme
		akExpression.SetPhoneme(2, MaleFemale, 2, 100)
		akExpression.SetPhoneme(2, MaleFemale, 2, 100)
		akExpression.SetPhoneme(2, MaleFemale, 5, 40)
	EndIf
	DefineGagExpression01Part(akExpression, 2, MaleFemale)

	akExpression.SetMood(3, MaleFemale, 3, 100)
	akExpression.SetModifier(3, MaleFemale, 11, 50)
	akExpression.SetModifier(3, MaleFemale, 13, 40)
	If KeepExpressionPhoneme
		akExpression.SetPhoneme(3, MaleFemale, 2, 50)
		akExpression.SetPhoneme(3, MaleFemale, 13, 20)
		akExpression.SetPhoneme(3, MaleFemale, 15, 40)
	EndIf
	DefineGagExpression01Part(akExpression, 3, MaleFemale)

	akExpression.SetMood(4, MaleFemale, 9, 100)
	akExpression.SetModifier(4, MaleFemale, 2, 100)
	akExpression.SetModifier(4, MaleFemale, 3, 100)
	akExpression.SetModifier(4, MaleFemale, 4, 100)
	akExpression.SetModifier(4, MaleFemale, 5, 100)
	akExpression.SetModifier(4, MaleFemale, 11, 90)
	If KeepExpressionPhoneme
		akExpression.SetPhoneme(4, MaleFemale, 0, 30)
		akExpression.SetPhoneme(4, MaleFemale, 2, 30)
	EndIf
	DefineGagExpression01Part(akExpression, 4, MaleFemale)

	FinalizeExpressionDefaults(akExpression)
EndFunction

Function DefineGagExpressionShy(sslBaseExpression akExpression)
	SetExpressionDefaults(akExpression, "Shy Gagged")

	akExpression.AddTag("Consensual")
	akExpression.AddTag("Nervous")
	akExpression.AddTag("Sad")
	akExpression.AddTag("Shy")
	akExpression.AddTag("Normal")
	akExpression.AddTag("Neutral")
	akExpression.AddTag("Gagged")

	; Male + Female
	akExpression.SetMood(1, MaleFemale, 4, 90)
	akExpression.SetModifier(1, MaleFemale, 11, 20)
	If KeepExpressionPhoneme
		akExpression.SetPhoneme(1, MaleFemale, 1, 10)
		akExpression.SetPhoneme(1, MaleFemale, 11, 10)
	EndIf
	DefineGagExpression01Part(akExpression, 1, MaleFemale)

	akExpression.SetMood(2, MaleFemale, 3, 50)
	akExpression.SetModifier(2, MaleFemale, 8, 50)
	akExpression.SetModifier(2, MaleFemale, 9, 40)
	akExpression.SetModifier(2, MaleFemale, 12, 30)
	DefineGagExpression01Part(akExpression, 2, MaleFemale)

	akExpression.SetMood(3, MaleFemale, 3, 50)
	akExpression.SetModifier(3, MaleFemale, 8, 50)
	akExpression.SetModifier(3, MaleFemale, 9, 40)
	akExpression.SetModifier(3, MaleFemale, 12, 30)
	If KeepExpressionPhoneme
		akExpression.SetPhoneme(3, MaleFemale, 1, 10)
		akExpression.SetPhoneme(3, MaleFemale, 11, 10)
	EndIf
	DefineGagExpression01Part(akExpression, 3, MaleFemale)

	FinalizeExpressionDefaults(akExpression)
EndFunction

Function DefineGagExpressionHappy(sslBaseExpression akExpression)
	SetExpressionDefaults(akExpression, "Happy Gagged")

	akExpression.AddTag("Happy")
	akExpression.AddTag("Consensual")
	akExpression.AddTag("Normal")
	akExpression.AddTag("Positive")
	akExpression.AddTag("Gagged")

	; Male + Female
	akExpression.SetMood(1, MaleFemale, 2, 50)
	akExpression.SetModifier(1, MaleFemale, 12, 50)
	akExpression.SetModifier(1, MaleFemale, 13, 50)
	If KeepExpressionPhoneme
		akExpression.SetPhoneme(1, MaleFemale, 5, 50)
	EndIf
	DefineGagExpression01Part(akExpression, 1, MaleFemale)

	akExpression.SetMood(2, MaleFemale, 2, 70)
	akExpression.SetModifier(2, MaleFemale, 12, 70)
	akExpression.SetModifier(2, MaleFemale, 13, 70)
	If KeepExpressionPhoneme
		akExpression.SetPhoneme(2, MaleFemale, 5, 50)
		akExpression.SetPhoneme(2, MaleFemale, 8, 50)
	EndIf
	DefineGagExpression01Part(akExpression, 2, MaleFemale)

	akExpression.SetMood(3, MaleFemale, 2, 80)
	akExpression.SetModifier(3, MaleFemale, 12, 80)
	akExpression.SetModifier(3, MaleFemale, 13, 80)
	If KeepExpressionPhoneme
		akExpression.SetPhoneme(3, MaleFemale, 5, 50)
		akExpression.SetPhoneme(3, MaleFemale, 11, 60)
	EndIf
	DefineGagExpression01Part(akExpression, 3, MaleFemale)

	FinalizeExpressionDefaults(akExpression)
EndFunction

Function DefineGagExpressionSad(sslBaseExpression akExpression)
	; Sad is currently a copy of afraid except for the tags.
	SetExpressionDefaults(akExpression, "Sad Gagged")

	akExpression.AddTag("Sad")
	akExpression.AddTag("Negative")
	akExpression.AddTag("Victim")
	akExpression.AddTag("Gagged")

	; Male + Female
	akExpression.SetMood(1, MaleFemale, 3, 100)
	akExpression.SetModifier(1, MaleFemale, 2, 10)
	akExpression.SetModifier(1, MaleFemale, 3, 10)
	akExpression.SetModifier(1, MaleFemale, 6, 50)
	akExpression.SetModifier(1, MaleFemale, 7, 50)
	akExpression.SetModifier(1, MaleFemale, 1, 30)
	akExpression.SetModifier(1, MaleFemale, 12, 30)
	akExpression.SetModifier(1, MaleFemale, 13, 30)
	If KeepExpressionPhoneme
		akExpression.SetPhoneme(1, MaleFemale, 0, 20)
	EndIf
	DefineGagExpression01Part(akExpression, 1, MaleFemale)

	akExpression.SetMood(2, MaleFemale, 8, 100)
	akExpression.SetModifier(2, MaleFemale, 0, 100)
	akExpression.SetModifier(2, MaleFemale, 1, 100)
	akExpression.SetModifier(2, MaleFemale, 2, 100)
	akExpression.SetModifier(2, MaleFemale, 3, 100)
	akExpression.SetModifier(2, MaleFemale, 4, 100)
	akExpression.SetModifier(2, MaleFemale, 5, 100)
	If KeepExpressionPhoneme
		akExpression.SetPhoneme(2, MaleFemale, 2, 100)
		akExpression.SetPhoneme(2, MaleFemale, 2, 100)
		akExpression.SetPhoneme(2, MaleFemale, 5, 40)
	EndIf
	DefineGagExpression01Part(akExpression, 2, MaleFemale)

	akExpression.SetMood(3, MaleFemale, 3, 100)
	akExpression.SetModifier(3, MaleFemale, 11, 50)
	akExpression.SetModifier(3, MaleFemale, 13, 40)
	If KeepExpressionPhoneme
		akExpression.SetPhoneme(3, MaleFemale, 2, 50)
		akExpression.SetPhoneme(3, MaleFemale, 13, 20)
		akExpression.SetPhoneme(3, MaleFemale, 15, 40)
	EndIf
	DefineGagExpression01Part(akExpression, 3, MaleFemale)

	akExpression.SetMood(4, MaleFemale, 9, 100)
	akExpression.SetModifier(4, MaleFemale, 2, 100)
	akExpression.SetModifier(4, MaleFemale, 3, 100)
	akExpression.SetModifier(4, MaleFemale, 4, 100)
	akExpression.SetModifier(4, MaleFemale, 5, 100)
	akExpression.SetModifier(4, MaleFemale, 11, 90)
	If KeepExpressionPhoneme
		akExpression.SetPhoneme(4, MaleFemale, 0, 30)
		akExpression.SetPhoneme(4, MaleFemale, 2, 30)
	EndIf
	DefineGagExpression01Part(akExpression, 4, MaleFemale)

	FinalizeExpressionDefaults(akExpression)
EndFunction

Function DefineGagExpressionAngry(sslBaseExpression akExpression)
	SetExpressionDefaults(akExpression, "Angry Gagged")

	akExpression.AddTag("Mad")
	akExpression.AddTag("Angry")
	akExpression.AddTag("Upset")
	akExpression.AddTag("Negative")
	akExpression.AddTag("Victim")
	akExpression.AddTag("Gagged")

	; Male + Female
	akExpression.SetMood(1, MaleFemale, 0, 40)
	akExpression.SetModifier(1, MaleFemale, 12, 30)
	akExpression.SetModifier(1, MaleFemale, 13, 30)
	If KeepExpressionPhoneme
		akExpression.SetPhoneme(1, MaleFemale, 4, 40)
	EndIf
	DefineGagExpression01Part(akExpression, 1, MaleFemale)

	akExpression.SetMood(2, MaleFemale, 0, 55)
	akExpression.SetModifier(2, MaleFemale, 12, 50)
	akExpression.SetModifier(2, MaleFemale, 13, 50)
	If KeepExpressionPhoneme
		akExpression.SetPhoneme(2, MaleFemale, 4, 40)
	EndIf
	DefineGagExpression01Part(akExpression, 2, MaleFemale)

	akExpression.SetMood(3, MaleFemale, 0, 100)
	akExpression.SetModifier(3, MaleFemale, 12, 65)
	akExpression.SetModifier(3, MaleFemale, 13, 65)
	If KeepExpressionPhoneme
		akExpression.SetPhoneme(3, MaleFemale, 4, 50)
		akExpression.SetPhoneme(3, MaleFemale, 3, 40)
	EndIf
	DefineGagExpression01Part(akExpression, 3, MaleFemale)

	FinalizeExpressionDefaults(akExpression)
EndFunction

Function DefinePillorySex01(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Squishing, Sexual)

	Int B = akAnim.AddPosition(Female, AddCum = Vaginal)
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S1")
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S2")
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S3")
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S4")
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S5")
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S6")

	Int A = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S1", -45.0, sos = 3, strapOn = True)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S2", -45.0, sos = 3, strapOn = True)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S3", -45.0, sos = 3, strapOn = True)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S4", -45.0, sos = 3, strapOn = True)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S5", -45.0, sos = 3, strapOn = True)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S6", -45.0, sos = 3, strapOn = True)

	akAnim.AddTag("Pillory")
	akAnim.AddTag("Vaginal")
	akAnim.AddTag("Aggressive")
EndFunction

Function PilloryBoundSex01(Int aiId)
	sslBaseAnimation anim = Create(aiId)
	DefinePillorySex01(anim, "$ZazAP_PilloryBoundSex01", "ZapPillorySex01", "ZapWriPillorySex01")
	anim.AddTag("SubSub")
	anim.Save(aiId)
EndFunction

Function DefinePilloryLick01(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Sucking, Sexual)

	Int B = akAnim.AddPosition(Female)
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S1")
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S1")
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S1")

	Int A = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S1", Distance, sos = 5, strapOn = False, silent = True)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S1", Distance, sos = 5, strapOn = False, silent = True)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S1", Distance, sos = 7, strapOn = False, silent = True)

	akAnim.AddTag("Pillory")
	akAnim.AddTag("Vaginal")
	akAnim.AddTag("Oral")
EndFunction

Function PilloryBoundSex02(Int aiId)
	sslBaseAnimation anim = Create(aiId)
	DefinePilloryLick01(anim, "$ZazAP_PilloryBoundSex02", "ZapPilloryLick01", "ZapWriPilloryLick01")
	anim.AddTag("SubSub")
	anim.Save(aiId)
EndFunction

Function PillorySex01(Int aiId)
	sslBaseAnimation anim = Create(aiId)

	String[] sIdles = New String[7]
	sIdles[0] = "SXEnter"
	sIdles[1] = "SXHold01"
	sIdles[2] = "SXHold02"
	sIdles[3] = "SXSpank01"
	sIdles[4] = "SXHip03"
	sIdles[5] = "SXEND01"
	sIdles[6] = "SXExit"

	SetPilloryDefaults(anim, "$ZazAP_PillorySex01", Squishing, Sexual, sIdles)

	anim.AddTag("Aggressive")
	anim.AddTag("Vaginal")
	anim.AddTag("DomSub")
	anim.AddTag("Sex")

	anim.Save(aiId)
EndFunction

Function PillorySex02(Int aiId)
	sslBaseAnimation anim = Create(aiId)
	SetAnimationDefaults(anim, "$ZazAP_PillorySex02", Squishing, Sexual)

	Int B = anim.AddPosition(Female, AddCum = Vaginal)
	anim.AddPositionStage(B, "ZazAPPillSXEnterB")
	anim.AddPositionStage(B, "ZazAPPillSXHold02B")
	anim.AddPositionStage(B, "ZazAPPillSXHip02B")
	anim.AddPositionStage(B, "ZazAPPillSXHip03B")
	anim.AddPositionStage(B, "ZazAPPillSXSpank01B")
	anim.AddPositionStage(B, "ZazAPPillSXEnterB")
	anim.AddPositionStage(B, "ZazAPPillSXExitB")

	Int A = anim.AddPosition(Male)
	anim.AddPositionStage(A, "ZazAPPillSXEnterA", Distance, sos = 3, strapOn = True, silent = False)
	anim.AddPositionStage(A, "ZazAPPillSXHold02A", Distance, sos = 3, strapOn = True, silent = False)
	anim.AddPositionStage(A, "ZazAPPillSXHip02A", Distance, sos = 3, strapOn = True, silent = False)
	anim.AddPositionStage(A, "ZazAPPillSXHip03A", Distance, sos = 3, strapOn = True, silent = False)
	anim.AddPositionStage(A, "ZazAPPillSXSpank01A", Distance, sos = 3, strapOn = True, silent = False)
	anim.AddPositionStage(A, "ZazApPillSxEND01A", Distance, sos = 3, strapOn = True, silent = False)
	anim.AddPositionStage(A, "ZazAPPillSXExitA", Distance, sos = 3, strapOn = True, silent = False)

	anim.AddTag("Pillory")
	anim.AddTag("Aggressive")
	anim.AddTag("Vaginal")
	anim.AddTag("DomSub")
	anim.AddTag("Sex")

	anim.Save(aiId)
EndFunction

Function PilloryTorment01(Int aiId)
	sslBaseAnimation anim = Create(aiId)
	SetAnimationDefaults(anim, "$ZazAP_PilloryTorment01", Silent, Sexual)

	Int B = anim.AddPosition(Female)
	anim.AddPositionStage(B, "ZazAPPillSXEnterB")
	anim.AddPositionStage(B, "ZazAPPillTorButtRub1B")
	anim.AddPositionStage(B, "ZazAPPillTorPussRub1B")
	anim.AddPositionStage(B, "ZazAPPillTorButtLick1B")
	anim.AddPositionStage(B, "ZazAPPillSXEND01B")

	Int A = anim.AddPosition(Male)
	anim.AddPositionStage(A, "ZazAPPillTorButtLick1A", Distance, strapOn = False, silent = True)
	anim.AddPositionStage(A, "ZazAPPillTorButtRub1A", Distance, strapOn = False, silent = True)
	anim.AddPositionStage(A, "ZazAPPillTorPussRub1A", Distance, strapOn = False, silent = True)
	anim.AddPositionStage(A, "ZazAPPillTorButtLick1A", Distance, strapOn = False, silent = True)
	anim.AddPositionStage(A, "ZazAPPillTorButtLick1A", Distance, strapOn = False, silent = True)

	anim.AddTag("Pillory")
	anim.AddTag("Oral")
	anim.AddTag("DomSub")
	anim.AddTag("Aggressive")

	anim.Save(aiId)
EndFunction

Function PilloryTorment02(Int aiId)
	sslBaseAnimation anim = Create(aiId)
	SetAnimationDefaults(anim, "$ZazAP_PilloryTorment02", Squishing, Sexual)

	Int B = anim.AddPosition(Female)
	anim.AddPositionStage(B, "ZazAPPillTorSpank1B")
	anim.AddPositionStage(B, "ZazAPPillTorSpank2B")
	anim.AddPositionStage(B, "ZazAPPillTorPusBroom1B")
	anim.AddPositionStage(B, "ZazAPPillTorButtBroom1B")
	anim.AddPositionStage(B, "ZazAPPillTorPusBroom1B")

	Int A = anim.AddPosition(Male)
	anim.AddPositionStage(A, "ZazAPPillTorSpank1A", Distance)
	anim.AddPositionStage(A, "ZazAPPillTorSpank2A", Distance)
	anim.AddPositionStage(A, "ZazAPPillTorPusBroom1A", Distance)
	anim.AddPositionStage(A, "ZazAPPillTorButtBroom1A", Distance)
	anim.AddPositionStage(A, "ZazAPPillTorPusBroom1A", Distance)

	anim.AddTag("Pillory")
	anim.AddTag("Anal")
	anim.AddTag("Vaginal")
	anim.AddTag("DomSub")
	anim.AddTag("Aggressive")

	anim.Save(aiId)
EndFunction

Function DefineDoggy01(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Squishing, Sexual)

	Int B = akAnim.AddPosition(Female, addCum = Anal)
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S3")
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S4")
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S3")
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S4")

	Int A = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S3", -100, sos = 5)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S4", -100, sos = 5)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S3", -100, sos = 7)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S4", -100, sos = 5)

	akAnim.AddTag("Doggystyle")
	akAnim.AddTag("Anal")
	akAnim.AddTag("Aggressive")
EndFunction

Function BoundDoggyStyle(Int aiId)
	sslBaseAnimation anim = Create(aiId)
	DefineDoggy01(anim, "$ZazAP_SexLabDoggyStyle", "ZapWriDoggy01", "AggrDoggyStyle")
	anim.AddTag("Wrists")
	anim.AddTag("DomSub")
	anim.Save(aiId)
EndFunction

Function BothBoundDoggyStyle(Int aiId)
	sslBaseAnimation anim = Create(aiId)
	DefineDoggy01(anim, "$ZazAP_SexLabDoggyStyleBoth", "ZapWriDoggy01", "ZapWriDoggy01")
	anim.AddTag("Wrists")
	anim.AddTag("SubSub")
	anim.Save(aiId)
EndFunction

Function ArmbinderDoggyStyle(Int aiId)
	sslBaseAnimation anim = Create(aiId)
	DefineDoggy01(anim, "$Zap_Armb_Doggy01", "ZapArmbDoggy01", "AggrDoggyStyle")
	anim.AddTag("Armbinder")
	anim.AddTag("DomSub")
	anim.Save(aiId)
EndFunction

Function BothArmbinderDoggyStyle(Int aiId)
	sslBaseAnimation anim = Create(aiId)
	DefineDoggy01(anim, "$Zap_Armb_Doggy01_SS", "ZapArmbDoggy01", "ZapArmbDoggy01")
	anim.AddTag("Armbinder")
	anim.AddTag("SubSub")
	anim.Save(aiId)
EndFunction

Function DefineMissionary01(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Squishing, Sexual)

	Int B = akAnim.AddPosition(Female, addCum = Vaginal)
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S1")
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S2")
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S3")
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S4")
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S4")

	Int A = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S1", -86, sos = 4)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S2", -86, sos = 4)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S3", -86, sos = 3)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S4", -86, sos = 3)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S4", -86, sos = 3)

	akAnim.AddTag("Missionary")
	akAnim.AddTag("Lying")
	akAnim.AddTag("Vaginal")
	akAnim.AddTag("Aggressive")
	akAnim.AddTag("Sex")
EndFunction

Function BoundMissionary(Int aiId)
	sslBaseAnimation anim = Create(aiId)
	DefineMissionary01(anim, "$ZazAP_SexLabRoughMissionary", "ZapWriMissionary01", "AggrMissionary")
	anim.AddTag("Wrists")
	anim.AddTag("DomSub")
	anim.Save(aiId)
EndFunction

Function ArmbinderMissionary(Int aiId)
	sslBaseAnimation anim = Create(aiId)
	DefineMissionary01(anim, "$Zap_Armb_Missionary01", "ZapArmbMissionary01", "AggrMissionary")
	anim.AddTag("DomSub")
	anim.AddTag("Armbinder")
	anim.Save(aiId)
EndFunction

Function DefineSkullFuck01(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Sucking, Sexual)

	Int B = akAnim.AddPosition(Female, addCum = Oral)
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S1", 0, silent = True, openMouth = True)
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S2", 0, silent = True, openMouth = True)
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S3", 0, silent = True, openMouth = True)
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S4", 0, silent = True, openMouth = True)
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S5", 0, silent = True, openMouth = True)
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S5", 0, silent = True, openMouth = True)

	Int A = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S1", 49, rotate = 180, sos = 1)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S2", 49, rotate = 180, sos = 1)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S3", 49, rotate = 180, sos = 2)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S4", 49, rotate = 180, sos = 2)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S5", 49, rotate = 180, sos = 2)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S5", 49, rotate = 180, sos = 2)

	akAnim.AddTag("AP")
	akAnim.AddTag("Blowjob")
	akAnim.AddTag("Oral")
	akAnim.AddTag("Aggressive")
	akAnim.AddTag("Knees")
EndFunction

Function BoundSkullFuck(Int aiId)
	sslBaseAnimation anim = Create(aiId)
	DefineSkullFuck01(anim, "$ZazAP_SexLabSkullFuck", "ZapWriSkullFuck01", "AP_SkullFuck")
	anim.AddTag("DomSub")
	anim.AddTag("Wrists")
	anim.Save(aiId)
EndFunction

Function ArmbinderSkullFuck(Int aiId)
	sslBaseAnimation anim = Create(aiId)
	DefineSkullFuck01(anim, "$Zap_Armb_Blowjob01", "ZapArmbSkullFuck01", "AP_SkullFuck")
	anim.AddTag("DomSub")
	anim.AddTag("Armbinder")
	anim.Save(aiId)
EndFunction

Function DefineLesbian01(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Sucking, Sexual)

	Int B = akAnim.AddPosition(Female)
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S1", 0, silent = True)
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S2", 0, silent = False)
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S3", 0, silent = False, openMouth = True)
	akAnim.AddPositionStage(B, asAnim1 + "_A1_S4", 0, silent = False, openMouth = True)

	Int A = akAnim.AddPosition(Female)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S1", -110, silent = True)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S2", -105, silent = True, openMouth = True)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S3", -100, silent = False, openMouth = True)
	akAnim.AddPositionStage(A, asAnim2 + "_A2_S4", -100, silent = False, openMouth = True)

	akAnim.SetStageTimer(4, 10.0)

	akAnim.AddTag("Arrok")
	akAnim.AddTag("Oral")
	akAnim.AddTag("Vaginal")
	akAnim.AddTag("Lying")
	akAnim.AddTag("Loving")
EndFunction

Function BoundLesbian(Int aiId)
	sslBaseAnimation anim = Create(aiId)
	DefineLesbian01(anim, "$ZazAP_SexLabLesbian", "ZapWriLesbian01", "Arrok_Lesbian")
	anim.AddTag("Wrists")
	anim.AddTag("DomSub")
	anim.Save(aiId)
EndFunction

Function BothBoundLesbian(Int aiId)
	sslBaseAnimation anim = Create(aiId)
	DefineLesbian01(anim, "$ZazAP_SexLabLesbianBoth", "ZapWriLesbian01", "ZapWriLesbian01")
	anim.AddTag("Wrists")
	anim.AddTag("SubSub")
	anim.Save(aiId)
EndFunction

Function ArmbinderLesbian(Int aiId)
	sslBaseAnimation anim = Create(aiId)
	DefineLesbian01(anim, "$Zap_Armb_Lesbian01", "ZapArmbLesbian01", "Arrok_Lesbian")
	anim.AddTag("Armbinder")
	anim.AddTag("SubSub")
	anim.Save(aiId)
EndFunction

Function BothArmbinderLesbian(Int aiId)
	sslBaseAnimation anim = Create(aiId)
	DefineLesbian01(anim, "$Zap_Armb_Lesbian01_SS", "ZapArmbLesbian01", "ZapArmbLesbian01")
	anim.AddTag("Armbinder")
	anim.AddTag("SubSub")
	anim.Save(aiId)
EndFunction

Function DefineBoobJob01(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, SexMix, Sexual)

	Int a1 = akAnim.AddPosition(Female, addCum = Oral)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S1", 0)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S2", 0)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S3", 0)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S4", 0, silent = true, openMouth = true)

	Int a2 = akAnim.AddPosition(Male) ; 102
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S1", -119, sos = 2)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S2", -119, sos = 3)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S3", -119, sos = -2)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S4", -119, sos = -2)

	akAnim.AddTag("Arrok")
	akAnim.AddTag("Boobjob")
	akAnim.AddTag("Breast")
	akAnim.AddTag("Foreplay")
	akAnim.AddTag("Knees")
EndFunction

Function BoundArrokBoobjob(Int id)
	sslBaseAnimation anim = Create(id)
	DefineBoobJob01(anim, "$Zap_Wri_Boobjob01", "ZapWriBoobJob01", "Arrok_Boobjob")
	anim.AddTag("Wrists")
	anim.AddTag("DomSub")
	anim.Save(id)
EndFunction

Function ArmbinderArrokBoobjob(Int id)
	sslBaseAnimation anim = Create(id)
	DefineBoobJob01(anim, "$Zap_Armb_Boobjob01", "ZapArmbBoobJob01", "Arrok_Boobjob")
	anim.AddTag("Armbinder")
	anim.AddTag("DomSub")
	anim.Save(id)
EndFunction

Function DefineMissionary02(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Squishing, Sexual)

	Int A1 = akAnim.AddPosition(Female, addCum = VaginalOral)
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S1")
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S2")
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S3")
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S4")
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S5")

	int A2 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(A2, asAnim2 + "_A2_S1", -105)
	akAnim.AddPositionStage(A2, asAnim2 + "_A2_S2", -105)
	akAnim.AddPositionStage(A2, asAnim2 + "_A2_S3", -105, sos = 3)
	akAnim.AddPositionStage(A2, asAnim2 + "_A2_S4", -105, sos = 7)
	akAnim.AddPositionStage(A2, asAnim2 + "_A2_S5", -105, sos = 7)

	akAnim.AddTag("Zyn")
	akAnim.AddTag("Sex")
	akAnim.AddTag("Lying")
	akAnim.AddTag("Missionary")
	akAnim.AddTag("Vaginal")
EndFunction

Function DefineMilkMachine01(sslBaseAnimation akAnim, String asName, String asAnim1)
	Log("DefineMilkMachine01", "With base " + asAnim1)

	SetAnimationDefaults(akAnim, asName, Squishing, Misc)

	Int A1 = akAnim.AddPosition(Female)
	;akAnim.AddPositionStage(A1, asAnim1 + "_A1_S1")
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S2")
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S3", openMouth = True)
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S4", openMouth = True)
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S5", openMouth = True)
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S6", openMouth = False)
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S7")
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S8")
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S9")
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S10")
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S11")
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S12")
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S13")
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S14")

	akAnim.AddTag("Milk")
	akAnim.AddTag("Vaginal")
	akAnim.AddTag("Anal")
	akAnim.AddTag("Oral")
	akAnim.AddTag("Aggressive")
EndFunction

Function DefineFuro01(sslBaseAnimation akAnim, String asName, String asAnim1)
	Log("DefineFuro01", "With base " + asAnim1)

	SetAnimationDefaults(akAnim, asName, Squishing, Sexual)

	Int A1 = akAnim.AddPosition(Female)
	;akAnim.AddPositionStage(A1, asAnim1 + "_A1_S1")
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S2")
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S3")
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S4")
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S5")
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S6")

	akAnim.AddTag("Furo")
	akAnim.AddTag("Vaginal")
	akAnim.AddTag("Anal")
	akAnim.AddTag("Oral")
	akAnim.AddTag("Aggressive")
EndFunction

Function DefineSpank01(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	Log("DefineSpank01", "With bases 1: " + asAnim1 + ", 2: " + asAnim2)

	SetAnimationDefaults(akAnim, asName, Silent, Misc)

	Int A1 = akAnim.AddPosition(Female)
	;akAnim.AddPositionStage(A1, asAnim1 + "_A1_S1")
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S2", rotate = -90.0, forward = 45.0, up = -4.0)
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S3", rotate = -90.0, forward = 45.0, up = -4.0)
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S4", rotate = -90.0, forward = 45.0, up = -4.0)
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S4", rotate = -90.0, forward = 45.0, up = -4.0)
	akAnim.AddPositionStage(A1, asAnim1 + "_A1_S5", rotate = -90.0, forward = 45.0, up = -4.0)

	Int A2 = akAnim.AddPosition(Male)
	;akAnim.AddPositionStage(A2, asAnim2 + "_A2_S1", strapon = False, silent = True, sos = 0, openMouth = False)
	akAnim.AddPositionStage(A2, asAnim2 + "_A2_S2", strapon = False, silent = True, sos = 0)
	akAnim.AddPositionStage(A2, asAnim2 + "_A2_S3", strapon = False, silent = True, sos = 0)
	akAnim.AddPositionStage(A2, asAnim2 + "_A2_S4", strapon = False, silent = True, sos = 0)
	akAnim.AddPositionStage(A2, asAnim2 + "_A2_S4", strapon = False, silent = True, sos = 0)
	akAnim.AddPositionStage(A2, asAnim2 + "_A2_S5", strapon = False, silent = True, sos = 0)

	akAnim.AddTag("Spank")
	akAnim.AddTag("Sitting")
EndFunction

Function DefineKissing01(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Sucking, Foreplay)

	Int a1 = akAnim.AddPosition(Female)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S1", silent = True)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S2", silent = True)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S3", silent = True)

	Int a2 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S1", strapon = False, silent = True)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S2", strapon = False, silent = True)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S3", strapon = False, silent = True)

	; akAnim.SetStageTimer(1, 1.8)
	; akAnim.SetStageTimer(2, 15.0)
	akAnim.SetStageTimer(3, 0.7)

	akAnim.AddTag("Leito")
	akAnim.AddTag("Foreplay")
	akAnim.AddTag("Kissing")
	akAnim.AddTag("Loving")
	akAnim.AddTag("Standing")
EndFunction

Function DefineBlowjob01(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Sucking, Sexual)

	Int a1 = akAnim.AddPosition(Female, addCum = Oral)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S1", 0.0, silent = True)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S2", 0.0, silent = True, openMouth = True)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S3", 0.0, silent = True, openMouth = True)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S4", 0.0, silent = True, openMouth = True)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S5", 0.0, silent = True, openMouth = True)

	Int a2 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S1", sos = 1)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S2", sos = 3)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S3", sos = 2)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S4", sos = 2)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S5", sos = -1)

	akAnim.SetStageSoundFX(1, None)

	akAnim.AddTag("Leito")
	akAnim.AddTag("Oral")
	akAnim.AddTag("Blowjob")
	akAnim.AddTag("Knees")
EndFunction

Function DefineMissionary03(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Squishing, Sexual)

	Int a1 = akAnim.AddPosition(Female, addCum = Vaginal)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S1", 0)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S2", 0)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S3", 0)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S4", 0)

	Int a2 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S1", -105)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S2", -105)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S3", -105, sos = 3)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S4", -107, sos = 7)

	akAnim.AddTag("Arrok")
	akAnim.AddTag("Sex")
	akAnim.AddTag("Missionary")
	akAnim.AddTag("Lying")
	akAnim.AddTag("Vaginal")
EndFunction

Function DefineForeplay01(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Silent, Foreplay)

	Int a1 = akAnim.AddPosition(Female)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S1", 0)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S2", 0)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S3", 0)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S4", 0)

	Int a2 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S1", 0, strapon = False, sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S2", 0, strapon = False, sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S3", 0, strapon = False, sos = 5)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S4", 0, strapon = False, sos = 5)

	akAnim.AddTag("Arrok")
	akAnim.AddTag("Foreplay")
	akAnim.AddTag("Lying")
	akAnim.AddTag("Loving")
	akAnim.AddTag("Oral")
EndFunction

Function DefineFemaleSolo01(sslBaseAnimation akAnim, String asName, String asAnim1)
	Int a1 = akAnim.AddPosition(Female)
	If asAnim1 == "AP_FemaleSolo"
		SetAnimationDefaults(akAnim, asName, Squishing, Sexual)
		AppendVanillaSolo01(akAnim, a1, "AP_FemaleSolo", aiStageCount = 6, aiMaxStages = 6)

		akAnim.AddTag("AP")
		akAnim.AddTag("Lying")
	Else
		SetAnimationDefaults(akAnim, asName, Silent, Sexual)
		AppendBoundSolo01(akAnim, a1, asAnim1 + "Horny0", aiStageCount = 4)
	EndIf

	akAnim.AddTag("Masturbation")
EndFunction

Function DefineLick01(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, SexMix, Sexual)

	Int a1 = akAnim.AddPosition(Female)
	akAnim.AddPositionStage(a1, asAnim1 + "_A2_S1", 35.0, strapOn = False, silent = True, rotate = 180.0)
	akAnim.AddPositionStage(a1, asAnim1 + "_A2_S1", 35.0, strapOn = False, silent = True, rotate = 180.0)
	akAnim.AddPositionStage(a1, asAnim1 + "_A2_S1", 35.0, strapOn = False, silent = True, rotate = 180.0)

	Int a2 = akAnim.AddPosition(Female)
	akAnim.AddPositionStage(a2, "Zyn_Licking_A1_S1", 0)
	akAnim.AddPositionStage(a2, "Zyn_Licking_A1_S1", 0)
	akAnim.AddPositionStage(a2, "Zyn_Licking_A1_S1", 0)

	akAnim.AddTag("Zyn")
	akAnim.AddTag("Vaginal")
	akAnim.AddTag("Oral")
	akAnim.AddTag("Licking")
	akAnim.AddTag("Knees")
EndFunction

Function DefineXCrossLick01(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Sucking, Sexual)

	Int a1 = akAnim.AddPosition(Female)
	akAnim.AddPositionStage(a1, "ZapXCrossPose01")
	akAnim.AddPositionStage(a1, "ZapXCrossPose01")
	akAnim.AddPositionStage(a1, "ZapXCrossPose01")

	Int a2 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S1", 38.0, strapOn = False, silent = True, rotate = 180.0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S1", 38.0, strapOn = False, silent = True, rotate = 180.0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S1", 38.0, strapOn = False, silent = True, rotate = 180.0)
EndFunction

Function DefineCreatureFalmer01(sslBaseAnimation akAnim, String asName)
	SetAnimationDefaults(akAnim, asName, Squishing, Sexual)

	Int a1 = akAnim.AddPosition(Female, addCum = Vaginal)
	akAnim.AddPositionStage(a1, "Falmer_Doggystyle_A2_S1")
	akAnim.AddPositionStage(a1, "Falmer_Doggystyle_A2_S2")
	akAnim.AddPositionStage(a1, "Falmer_Doggystyle_A2_S3")
	akAnim.AddPositionStage(a1, "Falmer_Doggystyle_A2_S4")

	Int a2 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(a2, "Falmer_Doggystyle_A2_S1", 35.0, rotate = 180.0)
	akAnim.AddPositionStage(a2, "Falmer_Doggystyle_A2_S2", 35.0, rotate = 180.0)
	akAnim.AddPositionStage(a2, "Falmer_Doggystyle_A2_S3", 35.0, rotate = 180.0)
	akAnim.AddPositionStage(a2, "Falmer_Doggystyle_A2_S4", 35.0, rotate = 180.0)

	akAnim.AddTag("Creature")
	akAnim.AddTag("Bestiality")
	akAnim.AddTag("Dirty")
	akAnim.AddTag("Doggystyle")
	akAnim.AddTag("Falmer")
	akAnim.AddTag("Anal")
EndFunction

Function DefineMissionary04(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Squishing, Sexual)

	Int a1 = akAnim.AddPosition(Female, addCum = Vaginal)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S1")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S2")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S3")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S4")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S5")

	Int a2 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S1", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S2", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S3", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S4", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S5", sos = 0)

	akAnim.SetStageSoundFX(1, none)
EndFunction

Function DefineBlowjob02(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Sucking, Sexual)

	Int a1 = akAnim.AddPosition(Female, addCum = Oral)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S1")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S2")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S3", silent = true, openMouth = true)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S4", silent = true, openMouth = true)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S5", silent = true, openMouth = true)

	Int a2 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S1", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S2", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S3", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S4", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S5", sos = 0)

	akAnim.SetStageSoundFX(1, none)
	akAnim.SetStageSoundFX(2, none)
EndFunction

Function DefineDoggy02(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Squishing, Sexual)

	Int a1 = akAnim.AddPosition(Female, addCum = Vaginal)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S1")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S2")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S3")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S4")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S5")

	Int a2 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S1", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S2", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S3", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S4", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S5", sos = 0)
EndFunction

Function DefineFisting01(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Squishing, Sexual)

	Int a1 = akAnim.AddPosition(Female, addCum = Vaginal)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S1")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S2")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S3")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S4")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S5")

	Int a2 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S1", sos = 0, strapon = False)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S2", sos = 0, strapon = False)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S3", sos = 0, strapon = False)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S4", sos = 0, strapon = False)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S5", sos = 0, strapon = False)
EndFunction

Function DefineMissionary05(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Squishing, Sexual)

	Int a1 = akAnim.AddPosition(Female, addCum = Vaginal)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S1")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S2")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S3")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S4")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S5")

	Int a2 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S1", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S2", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S3", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S4", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S5", sos = 0)

	akAnim.SetStageSoundFX(1, None)
EndFunction

Function DefineDoggy03(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Squishing, Sexual)

	Int a1 = akAnim.AddPosition(Female, addCum = Anal)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S1")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S2")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S3")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S4")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S5")

	Int a2 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S1", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S2", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S3", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S4", sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S5", sos = 0)

	akAnim.SetStageSoundFX(1, None)
EndFunction

Function DefineThreesome01(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2, String asAnim3)
	SetAnimationDefaults(akAnim, asName, Squishing, Sexual)

	Int a1 = akAnim.AddPosition(Female, addCum = VaginalAnal)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S1")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S2")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S3")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S4")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S5")

	Int a2 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S1", 0, sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S2", 0, sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S3", 0, sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S4", 0, sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S5", 0, sos = 0)

	Int a3 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(a3, asAnim3 + "_A3_S1", 0, sos = 0)
	akAnim.AddPositionStage(a3, asAnim3 + "_A3_S2", 0, sos = 0)
	akAnim.AddPositionStage(a3, asAnim3 + "_A3_S3", 0, sos = 0)
	akAnim.AddPositionStage(a3, asAnim3 + "_A3_S4", 0, sos = 0)
	akAnim.AddPositionStage(a3, asAnim3 + "_A3_S5", 0, sos = 0)

	akAnim.SetStageSoundFX(1, None)
EndFunction

Function DefineThreesome02(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2, String asAnim3)
	SetAnimationDefaults(akAnim, asName, Squishing, Sexual)

	Int a1 = akAnim.AddPosition(Female, addCum = VaginalAnal)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S1")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S2")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S3")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S4")
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S5")

	Int a2 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S1", 0, sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S2", 0, sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S3", 0, sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S4", 0, sos = 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S5", 0, sos = 0)

	Int a3 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(a3, asAnim3 + "_A3_S1", 0, sos = 0)
	akAnim.AddPositionStage(a3, asAnim3 + "_A3_S2", 0, sos = 0)
	akAnim.AddPositionStage(a3, asAnim3 + "_A3_S3", 0, sos = 0)
	akAnim.AddPositionStage(a3, asAnim3 + "_A3_S4", 0, sos = 0)
	akAnim.AddPositionStage(a3, asAnim3 + "_A3_S5", 0, sos = 0)

	akAnim.SetStageSoundFX(1, Sucking)
EndFunction

Function DefineThreesome03(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2, String asAnim3)
	SetAnimationDefaults(akAnim, asName, Sucking, Sexual)

	Int a1 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(a1, asAnim3 + "_A3_S1", 0, sos = 0)
	akAnim.AddPositionStage(a1, asAnim3 + "_A3_S2", 0, sos = 0)
	akAnim.AddPositionStage(a1, asAnim3 + "_A3_S3", 0, sos = 0)
	akAnim.AddPositionStage(a1, asAnim3 + "_A3_S4", 0, sos = 0)
	akAnim.AddPositionStage(a1, asAnim3 + "_A3_S5", 0, sos = 0)

	Int a2 = akAnim.AddPosition(Female, addCum = Vaginal)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S1", 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S2", 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S3", 0)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S4", 0, openMouth = True)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S5", 0, openMouth = True)

	Int a3 = akAnim.AddPosition(Female, addCum = Oral)
	akAnim.AddPositionStage(a3, asAnim1 + "_A1_S1", 0, silent = True, openMouth = True)
	akAnim.AddPositionStage(a3, asAnim1 + "_A1_S2", 0)
	akAnim.AddPositionStage(a3, asAnim1 + "_A1_S3", 0)
	akAnim.AddPositionStage(a3, asAnim1 + "_A1_S4", 0, silent = True, openMouth = True)
	akAnim.AddPositionStage(a3, asAnim1 + "_A1_S5", 0, silent = True, openMouth = True)

	akAnim.SetStageSoundFX(2, Squishing)
	akAnim.SetStageSoundFX(3, SexMix)
EndFunction

Function DefineSpank02(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Silent, Misc)

	Int a1 = akAnim.AddPosition(Female)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S1", 0)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S2", 0)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S3", 0)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S4", 0)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S5", 0)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S6", 0, silent = True)

	Int a2 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S1", 0, strapon = False, silent = True)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S2", 0, strapon = False, silent = True)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S3", 0, strapon = False, silent = True)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S4", 0, strapon = False, silent = True)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S5", 0, strapon = False, silent = True)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S6", 0, strapon = False, silent = True)
EndFunction

Function DefineSpank03(sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2)
	SetAnimationDefaults(akAnim, asName, Silent, Misc)

	Int a1 = akAnim.AddPosition(Female)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S1", 0)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S2", 0)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S3", 0)
	akAnim.AddPositionStage(a1, asAnim1 + "_A1_S4", 0, silent = True)

	Int a2 = akAnim.AddPosition(Male)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S1", 0, strapon = False, silent = True)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S2", 0, strapon = False, silent = True)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S3", 0, strapon = False, silent = True)
	akAnim.AddPositionStage(a2, asAnim2 + "_A2_S4", 0, strapon = False, silent = True)
EndFunction

Function DefineAllSolo(sslBaseAnimation akAnim, String asName)
	SetAnimationDefaults(akAnim, asName, Silent, Sexual)
EndFunction

; Appends a number of masturbations to the animation
; 
; This function works like the AppendSolo01 function, but applies a random solo (if/when there are several to choose from)
; and does so for all the "remaining" actors in the selected animation. Since each entry reports the number of defined actors
; it is quite possible to figure out how many are remaining to be slotted, and the required number of stages.
; 
; This function can by itself fully define an animation, in which case all actors will be soloing. Setting akEntry to None will enable
; this behavior as that is the expected condition for not having something else defined.
; 
; Note that there are some things that this function does not do. It does not do any of the items below, and these must be manually
; performed for the animation to work.
; * Initialize animations: akAnim.Initialize()
; * Save animations: akAnim.Save(-1)
; 
; If CenterOn is left empty, then akActors[0] is selected as the center.
; 
Function AppendSolos(zbfSexLabBaseEntry akEntry, sslBaseAnimation akAnim, Actor[] akActors, Int[] aiBindTypes, Int aiActorCount, ObjectReference akCenterOn = None)
	Int i = 0
	Int iStageCount = 4

	ObjectReference center = akCenterOn
	If center == None
		center = akActors[0]
	EndIf

	If akEntry == None
		SetAnimationDefaults(akAnim, "ZapAllSolo", Silent, Sexual)
	Else
		i = akEntry.NumActors
		iStageCount = akAnim.StageCount
	EndIf

	Log("AppendSolos", "Appending " + (aiActorCount - i) + " solo actors.")
	While i < aiActorCount
		AppendSolo01(akAnim, iStageCount, aiBindTypes[i], akActors[i], center)
		i += 1
	EndWhile

	If akEntry == None
		akAnim.AddTag("NoSwap")
		akAnim.AddTag("ZaZ")
	EndIf
EndFunction

; Dynamically appends an actor as masturbating to an existing animation
; 
; Example use:
; AppendSolo01(anim, "MyAnimation", anim.StageCount, "ZapWri", Female) ; Will append a female bound masturbation animation
; AppendSolo01(anim, "MyAnimation", anim.StageCount, "", Male) ; Will append a male masturbation animation
; 
Function AppendSolo01(sslBaseAnimation akAnim, Int aiStageCount, Int aiBindType, Actor akActor, ObjectReference CenterOn)
	Int iMaxStages = 6
	String sAnimEvent = "AP_FemaleSolo"
	Int iGender = SexLab.GetGender(akActor)

	If iGender == Male
		sAnimEvent = "Arrok_MaleMasturbation"
		iMaxStages = 4
	EndIf

	Int iSlot = akAnim.AddPosition(iGender)
	If aiBindType >= 0
		AppendBoundSolo01(akAnim, iSlot, "Zap" + zbf.GetBindTypeSubString(aiBindType) + "Horny0", aiStageCount, afForward = 100.0, afSide = 0.0, afRotate = Utility.RandomFloat(0.0, 360.0))
	Else
		AppendVanillaSolo01(akAnim, iSlot, sAnimEvent, aiStageCount, iMaxStages, afForward = 100.0, afSide = 0.0, afRotate = Utility.RandomFloat(0.0, 360.0))
	EndIf

	akAnim.AddTag("Masturbation")
EndFunction

Function AppendVanillaSolo01(sslBaseAnimation akAnim, Int aiSlot, String asAnimEvent, Int aiStageCount, Int aiMaxStages, Float afForward = 0.0, Float afSide = 0.0, Float afUp = 0.0, Float afRotate = 0.0)
	Int i = 0
	String sEvent
	While i < aiStageCount - 2
		i += 1
		sEvent = asAnimEvent + "_A1_S" + Utility.RandomInt(1, aiMaxStages - 2)
		Log("AppendVanillaSolo01", "AddPositionStage(" + aiSlot + ", " + sEvent + ", ...)")
		akAnim.AddPositionStage(aiSlot, sEvent, strapon = False, sos = 3, forward = afForward, side = afSide, up = afUp, rotate = afRotate)
	EndWhile
	If i < aiStageCount - 1
		i += 1
		sEvent = asAnimEvent + "_A1_S" + (aiMaxStages - 1)
		Log("AppendVanillaSolo01", "AddPositionStage(" + aiSlot + ", " + sEvent + ", ...)")
		akAnim.AddPositionStage(aiSlot, sEvent, strapon = False, sos = 3, forward = afForward, side = afSide, up = afUp, rotate = afRotate)
	EndIf
	If i < aiStageCount
		i += 1
		sEvent = asAnimEvent + "_A1_S" + aiMaxStages
		Log("AppendVanillaSolo01", "AddPositionStage(" + aiSlot + ", " + sEvent + ", ...)")
		akAnim.AddPositionStage(aiSlot, sEvent, strapon = False, sos = 3, forward = afForward, side = afSide, up = afUp, rotate = afRotate)
	EndIf
EndFunction

Function AppendBoundSolo01(sslBaseAnimation akAnim, Int aiSlot, String asAnimEvent, Int aiStageCount, Float afForward = 0.0, Float afSide = 0.0, Float afUp = 0.0, Float afRotate = 0.0)
	Int i = aiStageCount
	While i > 0
		i -= 1
		String sEvent = asAnimEvent + Utility.RandomInt(1, 2)
		Log("AppendBoundSolo01", "AddPositionStage(" + aiSlot + ", " + sEvent + ", ...)")
		akAnim.AddPositionStage(aiSlot, sEvent, strapon = False, sos = 3, forward = afForward, side = afSide, up = afUp, rotate = afRotate)
	EndWhile
EndFunction

; Define animation bases
; 
; All these functions set up properties on zbfSexLabBaseEntry:: objects. During the registration, ::SetDefaults is called on the
; object before being initialized with these functions. It is only necessary to set up the changes compared to the defaults.
; 
; All fields are documented in zbfSexLabBaseEntry::.
;

Function DefineMissionary01Base(zbfSexLabBaseEntry akEntry)
	Log("DefineMissionary01Base", "")

	akEntry.Actor1 = StrList("Wrists", "Armbinder", "Yoke", "Vaginal")
	akEntry.Actor2 = StrList("Vaginal")
	akEntry.BaseId = "Missionary01"
	akEntry.VanillaBaseId = "Rough Missionary"
	akEntry.BaseName = "Missionary01"
	akEntry.Name = "Missionary"
	akEntry.Registrations = StrList("BoundMissionary", "ArmbinderMissionary")
	akEntry.RegNames = StrList("$ZazAP_SexLabRoughMissionary", "$Zap_Armb_Missionary01")
	akEntry.Tags = StrList("Aggressive", "Missionary", "Lying", "Vaginal", "Sex")
	akEntry.VanillaBaseName = "AggrMissionary"
EndFunction

Function DefineSkullfuck01Base(zbfSexLabBaseEntry akEntry)
	Log("DefineSkullfuck01Base", "")

	akEntry.Actor1 = StrList("Wrists", "Armbinder", "Yoke", "Oral")
	akEntry.Actor2 = StrList("Vaginal")
	akEntry.BaseId = "SkullFuck01"
	akEntry.VanillaBaseId = "AP Skull Fuck"
	akEntry.BaseName = "SkullFuck01"
	akEntry.Name = "Blowjob"
	akEntry.Registrations = StrList("BoundSkullFuck", "ArmbinderSkullFuck")
	akEntry.RegNames = StrList("$ZazAP_SexLabSkullFuck", "$Zap_Armb_Blowjob01")
	akEntry.Tags = StrList("Aggressive", "AP", "Blowjob", "Knees", "Oral")
	akEntry.VanillaBaseName = "AP_SkullFuck"
EndFunction

Function DefineBoobJob01Base(zbfSexLabBaseEntry akEntry)
	Log("DefineBoobJob01Base", "")

	akEntry.Actor1 = StrList("Wrists", "Armbinder", "Breast", "Female")
	akEntry.Actor2 = StrList("Vaginal")
	akEntry.BaseId = "BoobJob01"
	akEntry.VanillaBaseId = "Arrok Boobjob"
	akEntry.BaseName = "BoobJob01"
	akEntry.Name = "Boob job"
	akEntry.Registrations = StrList("BoundArrokBoobjob", "ArmbinderArrokBoobjob")
	akEntry.RegNames = StrList("$Zap_Wri_Boobjob01", "$Zap_Armb_Boobjob01")
	akEntry.Tags = StrList("Arrok", "Boobjob", "Knees", "Breast", "Foreplay")
	akEntry.VanillaBaseName = "Arrok_Boobjob"
EndFunction

Function DefineLesbian01Base(zbfSexLabBaseEntry akEntry)
	Log("DefineLesbian01Base", "")

	akEntry.Actor1 = StrList("Wrists", "Armbinder", "Yoke", "Oral", "Vaginal", "Female")
	akEntry.Actor2 = StrList("Wrists", "Armbinder", "Yoke", "Oral", "Vaginal", "Female")
	akEntry.BaseId = "Lesbian01"
	akEntry.VanillaBaseId = "Arrok Lesbian"
	akEntry.BaseName = "Lesbian01"
	akEntry.Name = "Lesbian"
	akEntry.Registrations = StrList("BoundLesbian", "BothBoundLesbian", "ArmbinderLesbian", "BothArmbinderLesbian")
	akEntry.RegNames = StrList("$ZazAP_SexLabLesbian", "$ZazAP_SexLabLesbianBoth", "$Zap_Armb_Lesbian01", "$Zap_Armb_Lesbian01_SS")
	akEntry.Tags = StrList("Arrok", "Oral", "Vaginal", "Lying", "Loving")
	akEntry.VanillaBaseName = "Arrok_Lesbian"
EndFunction

Function DefineDoggy01Base(zbfSexLabBaseEntry akEntry)
	Log("DefineDoggy01Base", "")

	akEntry.Actor1 = StrList("Wrists", "Armbinder", "Anal")
	akEntry.Actor2 = StrList("Wrists", "Armbinder", "Vaginal")
	akEntry.BaseId = "Doggy01"
	akEntry.VanillaBaseId = "Rough Doggy Style"
	akEntry.BaseName = "Doggy01"
	akEntry.Name = "Doggy Style"
	akEntry.Registrations = StrList("BoundDoggyStyle", "BothBoundDoggyStyle", "ArmbinderDoggyStyle", "BothArmbinderDoggyStyle")
	akEntry.RegNames = StrList("$ZazAP_SexLabDoggyStyle", "$ZazAP_SexLabDoggyStyleBoth", "$Zap_Armb_Doggy01", "$Zap_Armb_Doggy01_SS")
	akEntry.Tags = StrList("Aggressive", "Doggystyle", "Anal", "Sex")
	akEntry.VanillaBaseName = "AggrDoggyStyle"
EndFunction

Function DefinePillorySex01Base(zbfSexLabBaseEntry akEntry)
	Log("DefinePillorySex01Base", "")

	akEntry.Actor1 = StrList("Vaginal")
	akEntry.Actor2 = StrList("Wrists", "Vaginal")
	akEntry.BaseId = "PillorySex01"
	akEntry.VanillaBaseId = ""
	akEntry.BaseName = "PillorySex01"
	akEntry.Name = "Pillory Sex"
	akEntry.Tags = StrList("Pillory", "Vaginal", "Sex", "Aggressive")
	akEntry.VanillaBaseName = "ZapPillorySex01"
EndFunction

Function DefinePilloryLick01Base(zbfSexLabBaseEntry akEntry)
	Log("DefinePilloryLick01Base", "")

	akEntry.Actor1 = StrList("Vaginal")
	akEntry.Actor2 = StrList("Wrists", "Yoke", "Oral", "NoStrip")
	akEntry.BaseId = "PilloryLick01"
	akEntry.VanillaBaseId = ""
	akEntry.BaseName = "PilloryLick01"
	akEntry.Name = "Pillory Lick"
	akEntry.Tags = StrList("Pillory", "Vaginal", "Oral")
	akEntry.VanillaBaseName = "ZapPilloryLick01"
EndFunction

Function DefineMissionary02Base(zbfSexLabBaseEntry akEntry)
	Log("DefineMissionary02Base", "")

	akEntry.Actor1 = StrList("Yoke", "Vaginal", "Female")
	akEntry.Actor2 = StrList("Vaginal")
	akEntry.BaseId = "Missionary02"
	akEntry.VanillaBaseId = "Zyn Missionary"
	akEntry.BaseName = "Missionary02"
	akEntry.Name = "Zyn Missionary"
	akEntry.Tags = StrList("Zyn", "Sex", "Lying", "Missionary", "Vaginal")
	akEntry.VanillaBaseName = "Zyn_Missionary"
EndFunction

Function DefineMilkMachine01Base(zbfSexLabBaseEntry akEntry)
	Log("DefineMilkMachine01Base", "")

	akEntry.Actor1 = StrList("Vaginal", "Oral", "Anal", "Female")
	akEntry.BaseId = "MilkMachine01"
	akEntry.VanillaBaseId = ""
	akEntry.BaseName = "MilkMachine01"
	akEntry.Name = "Milking Machine"
	akEntry.Tags = StrList("Milk", "Vaginal", "Anal", "Oral")
	akEntry.VanillaBaseName = "ZapMilkMachine01"
	akEntry.NumActors = 1
EndFunction

Function DefineFuro01Base(zbfSexLabBaseEntry akEntry)
	Log("DefineMilkMachine01Base", "")

	akEntry.Actor1 = StrList("Vaginal", "Oral", "Anal")
	akEntry.BaseId = "Furo01"
	akEntry.VanillaBaseId = ""
	akEntry.BaseName = "Furo01"
	akEntry.Name = "Furo Tub Monster"
	akEntry.Tags = StrList("Furo", "Vaginal", "Anal", "Oral", "Aggressive")
	akEntry.VanillaBaseName = "ZapFuro01"
	akEntry.NumActors = 1
EndFunction

Function DefineSpank01Base(zbfSexLabBaseEntry akEntry)
	Log("DefineSpank01Base", "")

	akEntry.Actor1 = StrList()
	akEntry.Actor2 = StrList("NoStrip")
	akEntry.BaseId = "Spank01"
	akEntry.VanillaBaseId = ""
	akEntry.BaseName = "Spank01"
	akEntry.Name = "Spanking"
	akEntry.Tags = StrList("Spank", "Sitting")
	akEntry.VanillaBaseName = "ZapSpank01"
EndFunction

Function DefineKissing01Base(zbfSexLabBaseEntry akEntry)
	Log("DefineKissing01Base", "")

	akEntry.Actor1 = StrList("Oral", "Wrists", "Armbinder", "Yoke", "NoStrip")
	akEntry.Actor2 = StrList("Oral", "NoStrip")
	akEntry.BaseId = "Kissing01"
	akEntry.VanillaBaseId = "Leito Kissing"
	akEntry.BaseName = "Kissing01"
	akEntry.VanillaBaseName = "ZapKissing01"
	akEntry.Name = "Leito Kissing"
	akEntry.Tags = StrList("Leito", "Foreplay", "Kissing", "Loving", "Oral", "Standing")
EndFunction

Function DefineBlowjob01Base(zbfSexLabBaseEntry akEntry)
	Log("DefineBlowjob01Base", "")

	akEntry.Actor1 = StrList("Oral", "Wrists", "Yoke", "Armbinder", "NoStrip")
	akEntry.Actor2 = StrList("Vaginal")
	akEntry.BaseId = "Blowjob01"
	akEntry.VanillaBaseId = "Leito Blowjob"
	akEntry.BaseName = "Blowjob01"
	akEntry.VanillaBaseName = "Leito_Blowjob"
	akEntry.Name = "Leito Blowjob 1"
	akEntry.Tags = StrList("Leito", "Oral", "Blowjob", "Knees")
EndFunction

Function DefineMissionary03Base(zbfSexLabBaseEntry akEntry)
	Log("DefineMissionary03Base", "")

	akEntry.Actor1 = StrList("Wrists", "Yoke", "Vaginal", "Female")
	akEntry.Actor2 = StrList("Vaginal")
	akEntry.BaseId = "Missionary03"
	akEntry.VanillaBaseId = "Arrok Missionary"
	akEntry.BaseName = "Missionary03"
	akEntry.Name = "Arrok Missionary"
	akEntry.Tags = StrList("Arrok", "Sex", "Missionary", "Lying", "Vaginal")
	akEntry.VanillaBaseName = "Arrok_Missionary"
EndFunction

Function DefineForeplay01Base(zbfSexLabBaseEntry akEntry)
	Log("DefineForeplay01Base", "")

	akEntry.Actor1 = StrList("Wrists", "Oral")
	akEntry.Actor2 = StrList("Yoke", "Oral")
	akEntry.BaseId = "Foreplay01"
	akEntry.VanillaBaseId = "Arrok Foreplay"
	akEntry.BaseName = "Foreplay01"
	akEntry.Name = "Arrok Foreplay"
	akEntry.Tags = StrList("Arrok", "Foreplay", "Loving", "Lying")
	akEntry.VanillaBaseName = "Arrok_Foreplay"
EndFunction

Function DefineFemaleSolo01Base(zbfSexLabBaseEntry akEntry)
	Log("DefineFemaleSolo01Base", "")

	akEntry.Actor1 = StrList("Wrists", "Yoke", "Armbinder", "Female")
	akEntry.BaseId = "FemaleSolo01"
	akEntry.VanillaBaseId = "AP Female Masturbation"
	akEntry.BaseName = ""	; Will return names in the shape of "ZapWri" and "ZapYoke" onto which "Horny01" or "Horny02" is appended.
	akEntry.VanillaBaseName = "AP_FemaleSolo"
	akEntry.Name = "Female Masturbation"
	akEntry.Tags = StrList("AP", "Masturbation")
	akEntry.NumActors = 1
EndFunction

Function DefineXcrossLick01Base(zbfSexLabBaseEntry akEntry)
	Log("DefineXcrossLick01Base", "")

	akEntry.Actor1 = StrList("Vaginal")
	akEntry.Actor2 = StrList("Wrists", "Yoke", "Oral", "Female", "NoStrip")
	akEntry.BaseId = "XcrossLick01"
	akEntry.VanillaBaseId = ""
	akEntry.BaseName = "PilloryLick01"
	akEntry.VanillaBaseName = "ZapPilloryLick01"
	akEntry.Name = "X-Cross Lick"
	akEntry.Tags = StrList("Pillory", "Vaginal", "Oral", "Licking")
	akEntry.NumActors = 2
EndFunction

Function DefineLick01Base(zbfSexLabBaseEntry akEntry)
	Log("DefineLick01Base", "")

	akEntry.Actor1 = StrList("Wrists", "Yoke", "Oral", "NoStrip")
	akEntry.Actor2 = StrList("Vaginal")
	akEntry.BaseId = "Lick01"
	akEntry.VanillaBaseId = ""
	akEntry.BaseName = "PilloryLick01"
	akEntry.VanillaBaseName = "Zyn_Licking"
	akEntry.Name = "Licking"
	akEntry.Tags = StrList("Zyn", "Vaginal", "Oral", "Licking", "Knees")
	akEntry.NumActors = 2
EndFunction

Function DefineCreatureFalmer01Base(zbfSexLabBaseEntry akEntry)
	Log("DefineCreatureFalmer01Base", "")

	akEntry.Actor1 = StrList("Wrists", "Vaginal")
	akEntry.Actor2 = StrList("Vaginal")
	akEntry.BaseId = "CreatureFalmer01"
	akEntry.VanillaBaseId = ""
	akEntry.BaseName = "Falmer_Doggystyle"
	akEntry.VanillaBaseName = "Falmer_Doggystyle"
	akEntry.Name = "Falmer Doggystyle"
	akEntry.Tags = StrList("Creature", "Falmer", "Vaginal")
	akEntry.NumActors = 2
EndFunction

Function DefineMissionary04Base(zbfSexLabBaseEntry akEntry)
	Log("DefineMissionary04Base", "")

	akEntry.Actor1 = StrList("Wrists", "Anal")
	akEntry.Actor2 = StrList("Vaginal")
	akEntry.BaseId = "Missionary04"
	akEntry.VanillaBaseId = ""
	akEntry.BaseName = "leito_nc_bound_anal_missionary"
	akEntry.VanillaBaseName = "leito_nc_bound_anal_missionary"
	akEntry.Name = "Leito Anal Missionary"
	akEntry.Tags = zbfUtil.ArgString("Vaginal, Anal, Missionary, Aggressive, Leito, Lying, Forced")
	akEntry.NumActors = 2
EndFunction

Function DefineBlowjob02Base(zbfSexLabBaseEntry akEntry)
	Log("DefineBlowjob02Base", "")

	akEntry.Actor1 = StrList("Wrists", "Oral", "NoStrip")
	akEntry.Actor2 = StrList("Vaginal")
	akEntry.BaseId = "Blowjob02"
	akEntry.VanillaBaseId = ""
	akEntry.BaseName = "leito_nc_bound_bj"
	akEntry.VanillaBaseName = "leito_nc_bound_bj"
	akEntry.Name = "Leito Blowjob 2"
	akEntry.Tags = zbfUtil.ArgString("Oral, Aggressive, Blowjob, Knees, Leito, Forced")
	akEntry.NumActors = 2
EndFunction

Function DefineDoggy02Base(zbfSexLabBaseEntry akEntry)
	Log("DefineDoggy02Base", "")

	akEntry.Actor1 = StrList("Wrists", "Vaginal")
	akEntry.Actor2 = StrList("Vaginal")
	akEntry.BaseId = "Doggy02"
	akEntry.VanillaBaseId = ""
	akEntry.BaseName = "leito_nc_bound_doggy"
	akEntry.VanillaBaseName = "leito_nc_bound_doggy"
	akEntry.Name = "Leito Doggystyle"
	akEntry.Tags = zbfUtil.ArgString("Vaginal, Aggressive, Doggystyle, Lying, Leito, Forced")
	akEntry.NumActors = 2
EndFunction

Function DefineFisting01Base(zbfSexLabBaseEntry akEntry)
	Log("DefineFisting01Base", "")

	akEntry.Actor1 = StrList("Wrists", "Vaginal", "Female")
	akEntry.Actor2 = StrList("NoStrip")
	akEntry.BaseId = "Fisting01"
	akEntry.VanillaBaseId = ""
	akEntry.BaseName = "leito_nc_bound_fisting"
	akEntry.VanillaBaseName = "leito_nc_bound_fisting"
	akEntry.Name = "Leito Fisting"
	akEntry.Tags = zbfUtil.ArgString("Vaginal, Aggressive, Fisting, Lying, Leito, Forced")
	akEntry.NumActors = 2
EndFunction

Function DefineMissionary05Base(zbfSexLabBaseEntry akEntry)
	Log("DefineMissionary05Base", "")

	akEntry.Actor1 = StrList("Wrists", "Vaginal")
	akEntry.Actor2 = StrList("Vaginal")
	akEntry.BaseId = "Missionary05"
	akEntry.VanillaBaseId = ""
	akEntry.BaseName = "leito_nc_bound_missionary"
	akEntry.VanillaBaseName = "leito_nc_bound_missionary"
	akEntry.Name = "Leito Missionary"
	akEntry.Tags = zbfUtil.ArgString("Vaginal, Aggressive, Missionary, Lying, Leito, Forced")
	akEntry.NumActors = 2
EndFunction

Function DefineDoggy03Base(zbfSexLabBaseEntry akEntry)
	Log("DefineDoggy03Base", "")

	akEntry.Actor1 = StrList("Wrists", "Anal")
	akEntry.Actor2 = StrList("Vaginal")
	akEntry.BaseId = "Doggy03"
	akEntry.VanillaBaseId = ""
	akEntry.BaseName = "leito_nc_bound_anal_rear_entry"
	akEntry.VanillaBaseName = "leito_nc_bound_anal_rear_entry"
	akEntry.Name = "Leito Rear Entry"
	akEntry.Tags = zbfUtil.ArgString("Anal, Aggressive, Doggystyle, Lying, Leito, Forced")
	akEntry.NumActors = 2
EndFunction

Function DefineThreesome01Base(zbfSexLabBaseEntry akEntry)
	Log("DefineThreesome01Base", "")

	akEntry.Actor1 = StrList("Wrists", "Anal", "Vaginal", "Female")
	akEntry.Actor2 = StrList("Vaginal")
	akEntry.Actor3 = StrList("Vaginal")
	akEntry.BaseId = "Threesome01"
	akEntry.VanillaBaseId = "leitoAggressiveBoundThreesomeMMF1"
	akEntry.BaseName = "leito_nc_bound_mmf_1"
	akEntry.VanillaBaseName = "leito_nc_bound_mmf_1"
	akEntry.Name = "Leito Aggressive Bound Threesome MMF 1"
	akEntry.Tags = zbfUtil.ArgString("Anal, Vaginal, Aggressive, Doggystyle, Lying, Leito, Forced")
	akEntry.NumActors = 3
EndFunction

Function DefineThreesome02Base(zbfSexLabBaseEntry akEntry)
	Log("DefineThreesome02Base", "")

	akEntry.Actor1 = StrList("Wrists", "Anal", "Vaginal", "Female")
	akEntry.Actor2 = StrList("Vaginal", "Oral")
	akEntry.Actor3 = StrList("Vaginal")
	akEntry.BaseId = "Threesome02"
	akEntry.VanillaBaseId = "leitoAggressiveBoundThreesomeMMF2"
	akEntry.BaseName = "leito_nc_bound_mmf_2"
	akEntry.VanillaBaseName = "leito_nc_bound_mmf_2"
	akEntry.Name = "Leito Aggressive Bound Threesome MMF 2"
	akEntry.Tags = zbfUtil.ArgString("Anal, Vaginal, Oral, Aggressive, Doggystyle, Lying, Leito, Forced")
	akEntry.NumActors = 3
EndFunction

Function DefineThreesome03Base(zbfSexLabBaseEntry akEntry)
	Log("DefineThreesome03Base", "")

	akEntry.Actor1 = StrList("Vaginal", "Male")
	akEntry.Actor2 = StrList("Vaginal", "Oral", "Female")
	akEntry.Actor3 = StrList("Vaginal", "Oral", "Female")
	akEntry.BaseId = "Threesome03"
	akEntry.VanillaBaseId = "leitoAggressiveBoundThreesomeFFM1"
	akEntry.BaseName = "leito_nc_bound_ffm_1"
	akEntry.VanillaBaseName = "leito_nc_bound_ffm_1"
	akEntry.Name = "Leito Aggressive Bound Threesome FFM"
	akEntry.Tags = zbfUtil.ArgString("Oral, Vaginal, Aggressive, Lying, Leito, Forced")
	akEntry.NumActors = 3
EndFunction

Function DefineSpank02Base(zbfSexLabBaseEntry akEntry)
	Log("DefineSpank02Base", "")

	akEntry.Actor1 = StrList()
	akEntry.Actor2 = StrList("NoStrip")
	akEntry.BaseId = "Spank02"
	akEntry.VanillaBaseId = "rydinOverlapSpanking"
	akEntry.BaseName = "rydin_overlap_spanking"
	akEntry.VanillaBaseName = "rydin_overlap_spanking"
	akEntry.Name = "Rydin Overlap Spanking"
	akEntry.Tags = StrList("Spank", "Sitting", "Rydin")
	akEntry.NumActors = 2
EndFunction

Function DefineSpank03Base(zbfSexLabBaseEntry akEntry)
	Log("DefineSpank03Base", "")

	akEntry.Actor1 = StrList()
	akEntry.Actor2 = StrList("NoStrip")
	akEntry.BaseId = "Spank03"
	akEntry.VanillaBaseId = "rydinUnderarmSpanking"
	akEntry.BaseName = "rydin_underarm_spanking"
	akEntry.VanillaBaseName = "rydin_underarm_spanking"
	akEntry.Name = "Rydin Underarm Spanking"
	akEntry.Tags = StrList("Spank", "Standing", "Rydin")
	akEntry.NumActors = 2
EndFunction

Function DefineAllSoloBase(zbfSexLabBaseEntry akEntry)
	Log("DefineAllSoloBase", "")

	akEntry.BaseId = "AllSolo01"
	akEntry.VanillaBaseId = ""
	akEntry.BaseName = ""
	akEntry.VanillaBaseName = ""
	akEntry.Name = "All Solo"
	akEntry.Tags = StrList("Masturbation")
	akEntry.NumActors = 0
EndFunction

; 
; @section: Deprecated
; 
; All these functions should no longer be used. In each case, there is documentation describing what should be used instead.
; 


; Sets up automatic settings on all actors on the specified thread.
; 
; Automatic settings are:
; * RagDollEnding (always disabled)
; * Strip (naked except for any bindings)
; * Undress animation (always disabled)
; 
; See ::SetupSexLabActor for more details.
; 
Function SetupSexLabActors(sslThreadModel akThread, Actor[] akActors, Actor akVictim = None)
	SetupSexLabActor(akThread, akActors[0], akActors[0] == akVictim)
	SetupSexLabActor(akThread, akActors[1], akActors[1] == akVictim)
	SetupSexLabActor(akThread, akActors[2], akActors[2] == akVictim)
	SetupSexLabActor(akThread, akActors[3], akActors[3] == akVictim)
EndFunction

String Function GetBoundTag(Int aiBindType)
	If aiBindType == zbf.iBindWrists
		Return "Wrists"
	ElseIf aiBindType == zbf.iBindArmbinder
		Return "Armbinder"
	ElseIf aiBindType == zbf.iBindYoke
		Return "Yoke"
	EndIf
	Return ""
EndFunction

; Configures the SexLab thread with basic settings.
; 
; Basic settings include
; * Animations to use
; * Bedding (always off)
; * LeadIn (always disabled)
; * BedUse (always disabled)
; * Optionally centers on a specific object
; 
; Each setting can be optionally changed again afterwards, but these settings normally make sense to use.
; 
Function SetupSexLabThread(sslThreadModel akThread, sslBaseAnimation akAnim, ObjectReference akCenter = None)
	Log("SetupSexLabThread", "No thread specified.", abCondition = (akThread == None))
	Log("SetupSexLabThread", "No animation specified.", abCondition = (akAnim == None))

	sslBaseAnimation[] Animations = New sslBaseAnimation[1]
	Animations[0] = akAnim

	akThread.SetAnimations(Animations)
	akThread.SetBedFlag(0)
	akThread.DisableLeadIn(disabling = True)
	akThread.DisableBedUse(disabling = True)
	If akCenter != None
		akThread.CenterOnObject(akCenter)
	EndIf
EndFunction

; Filters a list of entries using a set of default rules.
; 
; See the functions GetRequiredTags and GetBlockedTags for a thorough description of what keywords are 
; detected and handled. Basically, based on worn keywords, the list of entries is filtered to only retain
; animations that make sense for the number of actors and their current bindings.
; 
Function FilterEntriesAuto(zbfSexLabBaseEntry[] akList, Actor[] akActors, Int[] aiBindTypes)
	Log("FilterEntriesAuto", "No list, or zero length list, specified.", abCondition = (akList.Length < 1))
	Log("FilterEntriesAuto", "akActors array must be four elements.", abCondition = (akActors.Length != 4))
	Log("FilterEntriesAuto", "aiBindTypes array must be four elements.", abCondition = (aiBindTypes.Length != 4))

	Int numActors = 0
	numActors += (akActors[0] != None) As Int
	numActors += (akActors[1] != None) As Int
	numActors += (akActors[2] != None) As Int
	numActors += (akActors[3] != None) As Int
	Log("FilterEntriesList", "Number of selected actors: " + numActors)

	; Filter entries - Required and Blocked calls work equally well on "None" Actors (returning an empty list)
	FilterEntriesOnActorCount(akList, numActors, numActors)
	FilterEntries(akList, 1, GetRequiredTags(akActors[0]), GetBlockedTags(akActors[0]))
	FilterEntries(akList, 2, GetRequiredTags(akActors[1]), GetBlockedTags(akActors[1]))
	FilterEntries(akList, 3, GetRequiredTags(akActors[2]), GetBlockedTags(akActors[2]))
	FilterEntries(akList, 4, GetRequiredTags(akActors[3]), GetBlockedTags(akActors[3]))
EndFunction

; Searches the registered animation base entries for the specified id.
; 
; Returns None if the Id could not be found.
; 
zbfSexLabBaseEntry Function GetEntryById(String asId)
	Int i = Entries.Length
	While i > 0
		i -= 1
		If (Entries[i] != None) && (Entries[i].BaseId == asId)
			Return Entries[i]
		EndIf
	EndWhile
	i = SpecialEntries.Length
	While i > 0
		i -= 1
		If (SpecialEntries[i] != None) && (SpecialEntries[i].BaseId == asId)
			Return SpecialEntries[i]
		EndIf
	EndWhile

	Return None ; Failure
EndFunction

; Deprecated function. Also initializes and saves the animation before returning.
; 
; It is necessary to be able to further set up and customize the animation, hence why this function has been deprecated. Use instead ::DefineAnimation to 
; simply define a new animation, or ::DefineAnimationFromId to allow further customization.
; 
Function DefineAnimationFromEntry(String asBaseId, sslBaseAnimation akAnim, String asName, String asAnim1, String asAnim2 = "", String asAnim3 = "", String asAnim4 = "")
	Log("DefineAnimationFromEntry", "Called on " + asBaseId + ", as " + asName + " and with bases (" + asAnim1 + ", " + asAnim2 +")")
	Log("DefineAnimationFromEntry", "Function is deprecated. Use DefineAnimtionEx instead.", iError)
	zbfSexLabBaseEntry entry = GetEntryById(asBaseId)

	akAnim.Initialize()
	DefineAnimationFromId(entry, akAnim, asName, zbfUtil.StrList(asAnim1, asAnim2, asAnim3, asAnim4))
	akAnim.AddTags(entry.GetTags(0))
	akAnim.AddTag("NoSwap")
	akAnim.AddTag("ZaZ")
	akAnim.Save(-1)
EndFunction

; Creates and returns an array of all the specified actors.
; 
Actor[] Function ActorList(Actor akActor1, Actor akActor2 = None, Actor akActor3 = None, Actor akActor4 = None)
	Log("ActorList", ">>> Function is deprecated! Use zbfUtil::ActorList instead. <<<", aiLevel = iWarning)
	Return zbfUtil.ActorList(akActor1, akActor2, akActor3, akActor4)
EndFunction

; Sets up a new SexLab thread with automatic filtering to play animations from.
; 
; This function will completely prepare a SexLab thread to play animations from. Strip slots, bedding, actor positions,
; actual animation and all other objects are automatically set up.
; 
; Animation is created dynamically based on actor restraints.
; 
; Returns None if no suitable animation could be set up, or if an error occured.
; Returns a sslThreadController for the new thread if successful.
; 
sslThreadModel Function CreateThreadAuto(Actor akActor1, Actor akActor2 = None, Actor akActor3 = None, Actor akActor4 = None, String asAnimBaseId = "", Bool abEnableFiltering = True)
	Log("CreateThreadAuto", ">>> Function is deprecated! Use zbfSexLab::StartSex and zbfSexLab::GetEntriesByTags instead. <<<", aiLevel = iWarning)

	Actor[] actors = zbfUtil.ActorList(akActor1, akActor2, akActor3, akActor4)
	Int[] iBindTypes = GetBindTypes(actors)
	zbfSexLabBaseEntry entry = None
	sslBaseAnimation anim = None
	sslThreadModel thread = None

	; Create a list of entries to further filter. Normally, one would just get all the entries, but it's possible to specify for this function,
	; just a specific animation to play.
	zbfSexLabBaseEntry[] list
	If asAnimBaseId != ""
		list = New zbfSexLabBaseEntry[1]
		list[0] = GetEntryById(asAnimBaseId)
	Else
		list = GetEntries()
	EndIf
	LogEntries("CreateThreadAuto", "Entries before filtering.", list)

	If abEnableFiltering
		; Filter all entries according to default method
		FilterEntriesAuto(list, actors, iBindTypes)
	EndIf
	LogEntries("CreateThreadAuto", "Entries after filtering.", list)

	; Select random entry from the remains in the list.
	entry = GetRandomEntry(list)
	Log("CreateThreadAuto", "Failed to find suitable animation under constraint (" + asAnimBaseId + ")", iWarning, (entry == None))

	; Make sure an entry was found.
	If entry != None
		; Create a new base animation and set it up.
		anim = NewAnimation("ZaZ Animation Pack")
		Log("CreateThreadAuto", "Failed to fetch a new base animation to set up.", aiLevel = iError, abCondition = (anim == None))
	EndIf

	; Make sure a new animation could be created.
	If anim != None
		String[] animNames = GetSexLabAnimationNames(entry, iBindTypes)
		DefineAnimation(entry, anim, animNames)

		; Set up the SexLab thread
		thread = SexLab.NewThread()
		Log("CreateThreadAuto", "Failed to create SexLab thread.", aiLevel = iError, abCondition = (thread == None))
	EndIf

	; Make sure a new thread could be created.
	If thread != None
		SetupSexLabThread(thread, anim)
		SetupSexLabActors(thread, actors, akVictim = akActor1)
	EndIf

	; Clean up if needed.
	If thread == None
		ReleaseAnimation(anim)
	EndIf

	Return thread
EndFunction







; 
; HELPERS
; ----------------------------
; 
; Helper functions, just no better place to put them .... These are either not documented or poorly documented. Do not use these 
; functions as part of the api.
; 
; 

zbfSexLabBaseEntry[] Function GetEmptyEntries()
	Return New zbfSexLabBaseEntry[35]
EndFunction

; Just to make sure the examples compile
Function Example1()
	Actor SexActor1
	Actor SexActor2

	zbfSexLab zbfSL = zbfSexLab.GetApi()
	Actor[] actors = zbfUtil.ActorList(SexActor1, SexActor2)
	zbfSexLabBaseEntry[] list = zbfSL.GetEntriesByTags(actors, "Missionary, Aggressive", aiMinActorCount = 2)
	Int success = zbfSL.StartSex(actors, list, Victim = SexActor1, Hook = "MyHook")
EndFunction

Function Example2()
	zbfSexLab zbfSL ; ok, because uses from previous example it was set up above
	zbfSexLabBaseEntry[] list
	Actor[] actors

	zbfSexLabBaseEntry entry = zbfSL.GetRandomEntry(list)
	sslBaseAnimation anim = zbfSL.NewAnimation("Module name")
	DefineAnimationEx(entry, anim, actors)
EndFunction

Function Example3()
	zbfSexLab zbfSL
	sslBaseAnimation anim
	Actor PlayerRef
	Actor[] actors

	sslThreadModel thread = SexLab.NewThread()
	sslBaseAnimation[] Animations = New sslBaseAnimation[1]
	Animations[0] = anim

	thread.SetAnimations(Animations)
	thread.SetBedFlag(0)
	thread.DisableLeadIn(disabling = True)
	thread.DisableBedUse(disabling = True)

	Int i = 0
	While i < actors.Length
		Actor a = actors[i]
		If a != None
			thread.AddActor(a, isVictim = (a == PlayerRef))
			thread.DisableRagdollEnd(a, disabling = True)
			thread.SetStrip(a, zbfSL.GetDefaultStripSlots())
			thread.DisableUndressAnimation(a, disabling = True)
		EndIf
		i += 1
	EndWhile
EndFunction

Int Property iDebugLevel Auto Hidden
Int iError = 0
Int iWarning = 1
Int iInfo = 2
String sFilePrefix = "zbfSexLab"
Function Log(String asMethod, String asMessage, Int aiLevel = 2, Bool abCondition = True)
	If abCondition && (aiLevel <= iDebugLevel)
		Debug.Trace(sFilePrefix + " (" + asMethod + "): " + asMessage)
	EndIf
EndFunction

Function LogEntries(String asMethod, String asMessage, zbfSexLabBaseEntry[] akList, Int aiLevel = 2, Bool abCondition = True)
	If abCondition && (aiLevel <= iDebugLevel)
		Log(asMethod, asMessage, aiLevel)
		Int i = akList.Length
		While i > 0
			i -= 1
			If (akList[i] != None) && (akList[i].BaseId != "")
				Log(asMethod, akList[i].BaseId, aiLevel)
			EndIf
		EndWhile
	EndIf
EndFunction
