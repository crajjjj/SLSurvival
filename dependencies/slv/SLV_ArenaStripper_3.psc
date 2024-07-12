;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaStripper_3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(500)

bool equipGag = false
bool equipPlugs = false
bool equipHarness = false
bool equipBelt = false
bool equipBra = false
bool equipCollar = false
bool equipCuffs = false
bool equipArmbinder = false
bool equipYoke = false
bool equipBlindfold = false
bool equipNPiercings = false
bool equipVPiercings = false
bool equipBoots = false
bool equipGloves = false
bool equipCorset = false
bool equipMittens=false
bool equipHood=false
bool equipClamps=false
bool equipSuit=false
bool equipShackles=false
bool equipHobblesSkirt=false
bool equipHobblesSkirtRelaxed=true

myScripts.SLV_DeviousEquipActor2(Game.getPlayer(), equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset, equipMittens, equipHood, equipClamps, equipSuit, equipShackles,equipHobblesSkirt, equipHobblesSkirtRelaxed)

myScripts.SLV_PlayScene(PunishScene)

ActorUtil.ClearPackageOverride(SLV_Watcher1.getActorRef())
SLV_Watcher1.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Watcher1.getActorRef(), SLV_WalkToStripperBefore ,100)
SLV_Watcher1.getActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Watcher2.getActorRef())
SLV_Watcher2.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Watcher2.getActorRef(), SLV_WalkToStripperBefore ,100)
SLV_Watcher2.getActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Watcher3.getActorRef())
SLV_Watcher3.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Watcher3.getActorRef(), SLV_WalkToStripperBefore ,100)
SLV_Watcher3.getActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Watcher4.getActorRef())
SLV_Watcher4.getActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Watcher4.getActorRef(), SLV_WalkToStripperBefore ,100)
SLV_Watcher4.getActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property SLV_WalkToStripperBefore Auto
ReferenceAlias Property SLV_Watcher1 Auto
ReferenceAlias Property SLV_Watcher2 Auto
ReferenceAlias Property SLV_Watcher3 Auto
ReferenceAlias Property SLV_Watcher4 Auto

SLV_Utilities Property myScripts auto
Scene Property PunishScene  Auto
