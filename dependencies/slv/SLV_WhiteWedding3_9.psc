;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding3_9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3500)
GetOwningQuest().SetStage(4000)

ActorUtil.ClearPackageOverride(SLV_Bellamy.GetActorRef())
SLV_Bellamy.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Bellamy.GetActorRef(), SLV_DragonsreachWedding ,100)
SLV_Bellamy.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Murphy.GetActorRef())
SLV_Murphy.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Murphy.GetActorRef(), SLV_WalkToDragonsreachLeft ,100)
SLV_Murphy.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Pike.GetActorRef())
SLV_Pike.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Pike.GetActorRef(), SLV_WalkToDragonsreachLeft ,100)
SLV_Pike.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Eric.GetActorRef())
SLV_Eric.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Eric.GetActorRef(), SLV_WalkToDragonsreachLeft ,100)
SLV_Eric.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Maria.GetActorRef())
SLV_Maria.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Maria.GetActorRef(), SLV_WalkToDragonsreachLeft ,100)
SLV_Maria.GetActorRef().evaluatePackage()

myScripts.SLV_SexlabStripNPC(Game.GetPlayer())

bool equipGag = true
bool equipPlugs = true
bool equipHarness = true
bool equipBelt = true
bool equipBra = true
bool equipCollar = true
bool equipCuffs = true
bool equipArmbinder = true
bool equipYoke = true
bool equipBlindfold = true
bool equipNPiercings = true
bool equipVPiercings = true
bool equipBoots = true
bool equipGloves = true
bool equipCorset = true
bool equipMittens = true
bool equipHood = true
bool equipClamps = true
bool equipSuit = true
bool equipShackles = true
bool equipHobblesSkirt = true
bool equipHobblesSkirtRelaxed = true

myScripts.SLV_DeviousUnEquipActor2(Game.GetPlayer(),equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens, equipHood, equipClamps, equipSuit, equipShackles, equipHobblesSkirt, equipHobblesSkirtRelaxed)

equipGag = false
equipPlugs = true
equipHarness = false
equipBelt = false
equipBra = false
equipCollar = true
equipCuffs = true
equipArmbinder = false
equipYoke = false
equipBlindfold = false
equipNPiercings = true
equipVPiercings = true
equipBoots = true
equipGloves = true
equipCorset = true
myScripts.SLV_DeviousEquipActorColor(Game.getplayer(), ",white", "",equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto

ReferenceAlias Property SLV_Bellamy Auto 
ReferenceAlias Property SLV_Murphy Auto 
ReferenceAlias Property SLV_Pike Auto 
ReferenceAlias Property SLV_Eric Auto
ReferenceAlias Property SLV_Maria Auto 

Package Property SLV_WalkToDragonsreachLeft Auto
Package Property SLV_DragonsreachWedding Auto
