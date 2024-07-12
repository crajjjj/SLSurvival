Scriptname SLV_Sexlab extends Quest  

bool function SLV_isZAPAnimating(Actor ActorRef)
return zadQuest.IsAnimating(ActorRef)
endFunction


bool function SLV_AllowedCreature(Actor ActorRef)
return SexLabQuestFramework.AllowedCreature(ActorRef.GetRace())
endFunction

int function SLV_GetGender(Actor ActorRef)
return SexLabQuestFramework.GetGender(ActorRef)
endFunction

int function SLV_ValidateActor(Actor ActorRef)
return SexLabQuestFramework.ValidateActor(ActorRef)
endFunction

bool function SLV_IsActorActive(Actor ActorRef)
return SexLabQuestFramework.IsActorActive(ActorRef)
endFunction

int function SLV_SexCount(Actor ActorRef)
return SexLabQuestFramework.SexCount(ActorRef)
endFunction

int function SLV_CountCum(Actor ActorRef, bool Vaginal = true, bool Oral = true, bool Anal = true)
return SexLabQuestFramework.CountCum(ActorRef, Vaginal, Oral, Anal)
EndFunction

function SLV_FullCumShot(Actor ActorRef)
SexLabQuestFramework.AddCum(ActorRef, true, false, false)
Utility.wait(1.0)
SexLabQuestFramework.AddCum(ActorRef, false, true, false)
Utility.wait(1.0)
SexLabQuestFramework.AddCum(ActorRef, false, false, true)
Utility.wait(1.0)

if Game.GetModByName("ScocLB.esm")!= 255
	Spell bukakkeSpell = Game.GetFormFromFile(0x001DA1, "ScocLB.esm") as Spell
	bukakkeSpell.cast(ActorRef)
endif


EndFunction


function SLV_Cum(Actor ActorRef, bool Vaginal = true, bool Oral = true, bool Anal = true)
SexLabQuestFramework.AddCum(ActorRef, Vaginal, Oral, Anal)
EndFunction


bool function SLV_TestCreatureAnimation2(Actor ActorCreature, int ActorCount, string Tags)
sslBaseAnimation[] anims = SexLabQuestFramework.GetCreatureAnimationsByRaceTags(ActorCount, ActorCreature.GetRace(), Tags, "", true)
if anims
	if anims.length > 0
		return true
	else
		return false
	endif
else
	return false
endif
endFunction


Bool function SLV_TestCreatureAnimation(int ActorCount, string RaceKey)
sslBaseAnimation[] anims =SexLabQuestFramework.GetCreatureAnimationsByRaceKey(ActorCount, RaceKey)
if anims
	if anims.length > 0
		return true
	else
		return false
	endif
else
	return false
endif
EndFunction


function SLV_PlaySexKissingSynchron(actor sexActor1, actor sexActor2)
if SLV_Menu2.SkipSexScenes
	return
endif

SLV_sexRunning = true

int result;

sslThreadModel thread = SexLabQuestFramework.NewThread()

;note that the order matters here, the first added actor will occupy the female position on 2-actor anims
thread.AddActor(sexActor1)
thread.AddActor(sexActor2)
thread.setHook("SexEnds")

; // Register our custom One-off event to StageStart
RegisterForModEvent("AnimationEnd_SexEnds", "SLV_PlayerSatiate")

sslBaseAnimation[] anims
anims = new sslBaseAnimation[1]
anims[0] = SexLabQuestFramework.AnimSlots.GetbyRegistrar("LeitoKissing")
thread.SetAnimations(anims)

bool[] nullMask = new bool[33]
nullMask[0] = true
thread.SetStrip(sexActor1, nullMask)
thread.SetStrip(sexActor2, nullMask)

thread.StartThread()

if result == -1
	UnregisterForModEvent("AnimationEnd_SexEnds")
	return
endif

while SLV_sexRunning
	Utility.wait(2.0)
	;Debug.Notification("You continue fucking...")
	;MiscUtil.PrintConsole("You continue fucking...")
endwhile	
endFunction

sslActorStats Stats

Bool function SLV_PlayerIsAVirgin()
Form SexLabQuestFramework2  = Game.GetFormFromFile(0xD62, "SexLab.esm")
if SexLabQuestFramework2
	Stats  = SexLabQuestFramework2 as sslActorStats
endif

bool isNoVirgin = Stats.HadSex(PlayerRef)

;MiscUtil.PrintConsole("Player had sex: " + isNoVirgin )
return !isNoVirgin
EndFunction



int function SLV_GetPlayerSexSkill(String skillname)
Form SexLabQuestFramework2  = Game.GetFormFromFile(0xD62, "SexLab.esm")
if SexLabQuestFramework2
	Stats  = SexLabQuestFramework2 as sslActorStats
endif

int skill = Stats.GetSkill(PlayerRef,skillname) as int
;MiscUtil.PrintConsole("Player skill: " + skillname + " : " + skill)
return skill
EndFunction


bool SLV_sexRunning

function SLV_SexlabStrip(Actor NPCActor, bool animate= true)
SexLabQuestFramework.ActorLib.StripActor(NPCActor, DoAnimate=animate )
EndFunction

Bool function SLV_CheckForSexAnimation(string animation)
sslBaseAnimation singleanim =SexLabQuestFramework.GetAnimationByName(animation)
if singleanim
	return true
else
	return false
endif
endFunction


Bool function SLV_CheckForSexTag(int ActorCount, string tags)
sslBaseAnimation[] anims = SexLabQuestFramework.GetAnimationsByTags(ActorCount, tags)
if anims
	return true
else
	return false
endif
endFunction


function SLV_PlaySexAnimationSynchron(actor[] sexActors, string animation, string tag, bool rape=true)
if SLV_Menu2.SkipSexScenes
	;a fadout to hide the "magic"
	Game.FadeOutGame(false, true, 5.0, 1.0)
	Utility.wait(2.0)
	debug.Notification("You have closed your eyes in disgust as humans had sex near you.")
	return
endif

if SLV_Menu2.SkipCreatureSex && SexLabQuestFramework.CreatureCount(sexActors) > 0
	;a fadout to hide the "magic"
	Game.FadeOutGame(false, true, 5.0, 1.0)
	Utility.wait(2.0)
	debug.Notification("You have closed your eyes in disgust as animals had sex near you.")
	return
endif

sslBaseAnimation singleanim
if SexLabQuestFramework.CreatureCount(sexActors) == 0
	singleanim = SexLabQuestFramework.GetAnimationByName(animation)
else
	singleanim =SexLabQuestFramework.GetCreatureAnimationByName(animation)
endif

sslBaseAnimation[] anims

if singleanim
	anims = new sslBaseAnimation[1]
	anims[0] = singleanim
	MiscUtil.PrintConsole("Animation:" + animation + " found")
elseif tag != ""
	MiscUtil.PrintConsole("Animation:" + animation + " not found")
	
	if SexLabQuestFramework.CreatureCount(sexActors) == 0
		anims =SexLabQuestFramework.GetAnimationsByTags(sexActors.Length, tag)
	else
		anims =SexLabQuestFramework.GetCreatureAnimationsByTags(sexActors.Length, tag)
	endif
endif

SLV_IncreasePlayerSex(sexActors)

SLV_sexRunning = true
; // Register our custom One-off event to StageStart
RegisterForModEvent("AnimationEnd_SexEnds", "SLV_PlayerSatiate")

int result;

; // Start the animation with our custom hook, which is identified by PlayerSatiate
if rape
	result=SexLabQuestFramework.StartSex(sexActors, anims, victim=sexActors[0], hook="SexEnds", allowBed=false)
else	
	result=SexLabQuestFramework.StartSex(sexActors, anims, hook="SexEnds", allowBed=false)
endif

if result == -1
	UnregisterForModEvent("AnimationEnd_SexEnds")
	return
endif

while SLV_sexRunning
	Utility.wait(2.0)
	;Debug.Notification("You continue fucking...")
endwhile	
endFunction






function SLV_PlaySexSynchron(actor[] sexActors, string tag, bool rape=true)
if SLV_Menu2.SkipSexScenes
	;a fadout to hide the "magic"
	Game.FadeOutGame(false, true, 5.0, 1.0)
	Utility.wait(2.0)
	debug.Notification("You have closed your eyes in disgust as humans had sex near you.")
	return
endif

if SLV_Menu2.SkipCreatureSex && SexLabQuestFramework.CreatureCount(sexActors) > 0
	;a fadout to hide the "magic"
	Game.FadeOutGame(false, true, 5.0, 1.0)
	Utility.wait(2.0)
	debug.Notification("You have closed your eyes in disgust as animals had sex near you.")
	return
endif

sslBaseAnimation[] anims
if tag != ""
	if SexLabQuestFramework.CreatureCount(sexActors) == 0
		anims =SexLabQuestFramework.GetAnimationsByTags(sexActors.Length, tag)
	else
		anims =SexLabQuestFramework.GetCreatureAnimationsByTags(sexActors.Length, tag)
	endif
	;anims =SexLabQuestFramework.GetAnimationsByTags(sexActors.Length, tag)
endif

SLV_IncreasePlayerSex(sexActors)

SLV_sexRunning = true
; // Register our custom One-off event to StageStart
RegisterForModEvent("AnimationEnd_SexEnds", "SLV_PlayerSatiate")

int result;

; // Start the animation with our custom hook, which is identified by SLV_PlayerSatiate
if rape
	result=SexLabQuestFramework.StartSex(sexActors, anims, victim=sexActors[0], hook="SexEnds", allowBed=false)
else	
	result=SexLabQuestFramework.StartSex(sexActors, anims, hook="SexEnds", allowBed=false)
endif

if result == -1
	UnregisterForModEvent("AnimationEnd_SexEnds")
	return
endif

while SLV_sexRunning
	Utility.wait(2.0)
	;Debug.Notification("You continue fucking...")
endwhile	
endFunction

; // Our callback we registered onto the global event AnimationEnd
event SLV_PlayerSatiate(string eventName, string argString, float argNum, form sender)
SLV_sexRunning = false

; // From this point we don't need the event hook anymore, so lets free up the resource
UnregisterForModEvent("AnimationEnd_SexEnds")
endEvent






function SLV_PlaySex(actor[] sexActors, string tag, bool rape=true)
if SLV_Menu2.SkipSexScenes
	;a fadout to hide the "magic"
	Game.FadeOutGame(false, true, 5.0, 1.0)
	Utility.wait(2.0)
	debug.Notification("You have closed your eyes in disgust as humans had sex near you.")
	return
endif

if SLV_Menu2.SkipCreatureSex && SexLabQuestFramework.CreatureCount(sexActors) > 0
	;a fadout to hide the "magic"
	Game.FadeOutGame(false, true, 5.0, 1.0)
	Utility.wait(2.0)
	debug.Notification("You have closed your eyes in disgust as animals had sex near you.")
	return
endif

sslBaseAnimation[] anims
if tag != ""
	if SexLabQuestFramework.CreatureCount(sexActors) == 0
		anims =SexLabQuestFramework.GetAnimationsByTags(sexActors.Length, tag)
	else
		anims =SexLabQuestFramework.GetCreatureAnimationsByTags(sexActors.Length, tag)
	endif
	;anims =SexLabQuestFramework.GetAnimationsByTags(sexActors.Length, tag)
endif

Int numberOfActors = sexActors.Length
While numberOfActors 
	numberOfActors -= 1
	if  !SLV_IsReadyForSex(sexActors[numberOfActors])
		return
	endif
EndWhile

SLV_IncreasePlayerSex(sexActors)

if rape
	SexLabQuestFramework.StartSex(sexActors, anims, victim=sexActors[0], allowBed=false)
else
	SexLabQuestFramework.StartSex(sexActors, anims, allowBed=false)
endif
endFunction





function SLV_PlaySexAnimation(actor[] sexActors, string animation, string tag, bool rape=true)
if SLV_Menu2.SkipSexScenes
	;a fadout to hide the "magic"
	Game.FadeOutGame(false, true, 5.0, 1.0)
	Utility.wait(2.0)
	debug.Notification("You have closed your eyes in disgust as humans had sex near you.")
	return
endif

if SLV_Menu2.SkipCreatureSex && SexLabQuestFramework.CreatureCount(sexActors) > 0
	;a fadout to hide the "magic"
	Game.FadeOutGame(false, true, 5.0, 1.0)
	Utility.wait(2.0)
	debug.Notification("You have closed your eyes in disgust as animals had sex near you.")
	return
endif

sslBaseAnimation singleanim
if SexLabQuestFramework.CreatureCount(sexActors) == 0
	singleanim = SexLabQuestFramework.GetAnimationByName(animation)
else
	singleanim =SexLabQuestFramework.GetCreatureAnimationByName(animation)
endif

sslBaseAnimation[] anims

if singleanim
	anims = new sslBaseAnimation[1]
	anims[0] = singleanim
	MiscUtil.PrintConsole("Animation:" + animation + " found")
elseif tag != ""	
	MiscUtil.PrintConsole("Animation:" + animation + " not found")

	if SexLabQuestFramework.CreatureCount(sexActors) == 0
		anims =SexLabQuestFramework.GetAnimationsByTags(sexActors.Length, tag)
	else
		anims =SexLabQuestFramework.GetCreatureAnimationsByTags(sexActors.Length, tag)
	endif
	;anims =SexLabQuestFramework.GetAnimationsByTags(sexActors.Length, tag)
endif

Int numberOfActors = sexActors.Length
While numberOfActors 
	numberOfActors -= 1
	if !  SLV_IsReadyForSex(sexActors[numberOfActors])
		return
	endif
EndWhile

SLV_IncreasePlayerSex(sexActors)

if rape
	SexLabQuestFramework.StartSex(sexActors, anims, victim=sexActors[0], allowBed=false)
else
	SexLabQuestFramework.StartSex(sexActors, anims, allowBed=false)
endif
endFunction



Bool Function SLV_IsReadyForSex(Actor NPCActor)
int isvalid = SexLabQuestFramework.ValidateActor(NPCActor)
bool isAnimating =  false ; zadQuest.IsAnimating(NPCActor)
if SexLabQuestFramework.IsActorActive(NPCActor) || !isvalid || isAnimating
	MiscUtil.PrintConsole("NPC is already animating, sex aborted")
	return false	;	That cock is already occupied
endif

if !SLV_IsActorInSameLocCheck(NPCActor)
	MiscUtil.PrintConsole("NPC is not in player cell, sex aborted")
	return false	;
endif
return true	; Passed all our tests, he is available for sex
; we skip the tests for now

if (NPCActor.IsInDialogueWithPlayer())
	MiscUtil.PrintConsole("NPC is in dialog with player, sex aborted")
	return false	;	in dialogue with player
endIf
if (NPCActor.GetDialogueTarget() == PlayerRef)
	MiscUtil.PrintConsole("NPC is in dialog with player, sex aborted")
	return false	;	in dialogue with player
endIf
return true	; Passed all our tests, he is available for sex
EndFunction



Bool Function SLV_IsActorInSameLocCheck(Actor NPCActor)
if !NPCActor.getCurrentLocation() || !PlayerRef.getCurrentLocation()
	return true
endif
if NPCActor.getCurrentLocation().IsSameLocation(PlayerRef.getCurrentLocation())
	return true
endif
return false
EndFunction



Function SLV_IncreasePlayerSex(actor[] sexActors)
if !PlayerRef.IsInFaction(SlaverunSlaveFaction)
	return
endif

Int numberOfSexLabActors = sexActors.Length
While numberOfSexLabActors 
	numberOfSexLabActors -= 1
	if PlayerRef == sexActors[numberOfSexLabActors ]
		SLV_SlaveSexCounter.setValue(SLV_SlaveSexCounter.getValue() + 1)
		SendModEvent( "SXP",  "GainXP", 100 )
	endif
EndWhile
EndFunction


zadLibs Property zadQuest Auto
SexLabFramework property SexLabQuestFramework auto
SLV_MCMMenu Property SLV_Menu2 auto
Actor Property PlayerRef Auto
GlobalVariable Property SLV_SlaveSexCounter Auto
Faction Property SlaverunSlaveFaction auto

function Setup()
; init function Libraries - SexLabQuestFramework

if Game.GetModByName("SexLab.esm")!= 255
	Form SexLabQuestFramework2 = Game.GetFormFromFile(0xD62, "SexLab.esm")
	if SexLabQuestFramework2
		SexLabQuestFramework = SexLabQuestFramework2 as SexLabFramework
	endIf
endIf
EndFunction
