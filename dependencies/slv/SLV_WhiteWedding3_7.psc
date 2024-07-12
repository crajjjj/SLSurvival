;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding3_7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2500)
GetOwningQuest().SetStage(3000)

ActorUtil.ClearPackageOverride(SLV_Aden.GetActorRef())
SLV_Aden.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Aden.GetActorRef(), SLV_WalkToDragonsreachRight ,100)
SLV_Aden.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Raven.GetActorRef())
SLV_Raven.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Raven.GetActorRef(), SLV_WalkToDragonsreachRight ,100)
SLV_Raven.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Octavia.GetActorRef())
SLV_Octavia.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Octavia.GetActorRef(), SLV_WalkToDragonsreachRight ,100)
SLV_Octavia.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Marcus.GetActorRef())
SLV_Marcus.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Marcus.GetActorRef(), SLV_WalkToDragonsreachRight ,100)
SLV_Marcus.GetActorRef().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Abigail.GetActorRef())
SLV_Abigail.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Abigail.GetActorRef(), SLV_WalkToDragonsreachRight ,100)
SLV_Abigail.GetActorRef().evaluatePackage()

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

myScripts.SLV_DeviousUnEquipActor2(SLV_Abigail.GetActorRef(),equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens, equipHood, equipClamps, equipSuit, equipShackles, equipHobblesSkirt, equipHobblesSkirtRelaxed)
myScripts.SLV_DeviousUnEquipActor2(SLV_Octavia.GetActorRef(),equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens, equipHood, equipClamps, equipSuit, equipShackles, equipHobblesSkirt, equipHobblesSkirtRelaxed)
myScripts.SLV_DeviousUnEquipActor2(SLV_Raven.GetActorRef(),equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens, equipHood, equipClamps, equipSuit, equipShackles, equipHobblesSkirt, equipHobblesSkirtRelaxed)

SLV_Abigail.GetActorRef().removeallitems()
SLV_Octavia.GetActorRef().removeallitems()
SLV_Raven.GetActorRef().removeallitems()

SLV_Abigail.GetActorRef().setOutfit(SLV_WeddingRed)
SLV_Octavia.GetActorRef().setOutfit(SLV_WeddingRed)
SLV_Raven.GetActorRef().setOutfit(SLV_WeddingRed)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Marcus Auto 
ReferenceAlias Property SLV_Abigail Auto 
ReferenceAlias Property SLV_Aden Auto 
ReferenceAlias Property SLV_Raven Auto 
ReferenceAlias Property SLV_Octavia Auto 

Package Property SLV_WalkToDragonsreachRight Auto

Outfit Property SLV_WeddingRed auto
