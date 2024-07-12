;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 296
Scriptname _snperkrefill Extends Perk Hidden

;BEGIN FRAGMENT Fragment_101
Function Fragment_101(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
;rain container
ObjectReference Detector = akTargetRef.PlaceAtMe(_SNShelterDetector)
Detector.MoveTo(akTargetRef, 0.0, 0.0, 1000.0, false)
Utility.Wait(0.25)
_SNShelterDetectSpell.Cast(akTargetRef, Detector)
Utility.Wait(0.25)
If !_SNQuest.UnderShelter
_SNWaterskinRefillLP.PlayandWait(akTargetRef)
_SNQuest.PlayerRef.RemoveItem(_SNQuest._SNWaterskin_0, 1, true)
_SNQuest.PlayerRef.AddItem(_SNQuest._SNWaterskin_3)
Else
Debug.Notification(_SNQuest.NoWaterText)
EndIf
Detector.Disable()
Detector.Delete()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_217
Function Fragment_217(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
;refill wells
_SNWellUseLP.PlayandWait(akTargetRef)
_SNWaterskinRefillLP.PlayandWait(akTargetRef)
_SNQuest.Refill(_SNQuest.PlayerRef)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_66
Function Fragment_66(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
;add follower needs
(akTargetRef as Actor).AddSpell(_SNFollowerSpell)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_193
Function Fragment_193(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
If _SNQuest.DFSInstalled && (akTargetRef.GetBaseObject() as Activator) == _SNQuest.DFSFountain
_SNQuest.DFSInstalled = False
_SNQuest.Drink(_SNQuest.PlayerRef)
_SNWaterskinRefillLP.PlayandWait(akTargetRef)
_SNQuest.Refill(_SNQuest.PlayerRef)
Utility.Wait(1.0)
_SNQuest.DFSInstalled = True
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_141
Function Fragment_141(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
;disassemble water barrel
_SNDisassemblingLP.Play(akTargetRef)
akTargetRef.Disable()
akTargetRef.Delete()
_SNQuest.PlayerRef.AddItem(_SNWaterBarrelKit)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_261
Function Fragment_261(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
;disassemble water keg
_SNTakeLP.Play(akTargetRef)
akTargetRef.Disable()
akTargetRef.Delete()
_SNQuest.PlayerRef.AddItem(_SNWaterKegKit)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_284
Function Fragment_284(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
_SNQuest.IsBedRoll = True
Utility.Wait(5.0)
_SNQuest.IsBedRoll = False
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_165
Function Fragment_165(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
;drink well
_SNWellUseLP.PlayandWait(akTargetRef)
_SNQuest.Drink(_SNQuest.PlayerRef)
Utility.Wait(1.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_106
Function Fragment_106(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
;drink from rain container
ObjectReference Detector = akTargetRef.PlaceAtMe(_SNShelterDetector)
Detector.MoveTo(akTargetRef, 0.0, 0.0, 1000.0, false)
Utility.Wait(0.25)
_SNShelterDetectSpell.Cast(akTargetRef, Detector)
Utility.Wait(0.25)
If !_SNQuest.UnderShelter
_SNQuest.Drink(_SNQuest.PlayerRef)
Utility.Wait(1.0)
Else
Debug.Notification(_SNQuest.NoWaterText)
EndIf
Detector.Disable()
Detector.Delete()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_275
Function Fragment_275(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
Int OriginalStat = Game.QueryStat("Necks Bitten")
Utility.Wait(3.0)
If Game.QueryStat("Necks Bitten") > OriginalStat
_SNQuest.ModFatigue(110.0)
_SNQuest.ModThirst(110.0)
_SNQuest.ModHunger(110.0)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_139
Function Fragment_139(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
;water barrel
_SNFaucetLP.PlayandWait(akTargetRef)
_SNWaterskinRefillLP.PlayandWait(akTargetRef)
_SNQuest.Refill(_SNQuest.PlayerRef)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_158
Function Fragment_158(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
;drink from water barrel
_SNFaucetLP.PlayandWait(akTargetRef)
_SNWaterskinRefillLP.PlayandWait(akTargetRef)
_SNQuest.Drink(_SNQuest.PlayerRef)
Utility.Wait(1.0)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_126
Function Fragment_126(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
;carriage fast travel check
_SNQuest.CarriageFastTravel = True
Utility.Wait(12.0)
_SNQuest.CarriageFastTravel = False
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_233
Function Fragment_233(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
_SNQuest.CheckLoc()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_287
Function Fragment_287(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
_SNQuest.PlayerRef.AddItem(_SNQuest._SNSnowPile, Utility.RandomInt(1, 2))
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_200
Function Fragment_200(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
;disassemble water bucket
_SNTakeLP.Play(akTargetRef)
akTargetRef.Disable()
akTargetRef.Delete()
_SNQuest.PlayerRef.AddItem(_SNWellBucketKit)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_173
Function Fragment_173(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
_SNQuest.PlayerRef.StartCannibal(akTargetRef as Actor)
Utility.Wait(1.0)
FXMeleeClawSmallVsFlesh.PlayandWait(akTargetRef)
(akTargetRef as Actor).PlayImpactEffect(BloodSprayImpactSetRed, "SkirtFBone01")
(akTargetRef as Actor).PlayImpactEffect(BloodSprayImpactSetRed, "NPC L Clavicle [LClv]")
(akTargetRef as Actor).PlayImpactEffect(BloodSprayImpactSetRed, "NPC R Clavicle [RClv]")
(akTargetRef as Actor).PlayImpactEffect(BloodSprayImpactSetRed, "SkirtFBone01")
FXMeleeClawSmallVsFlesh.PlayandWait(akTargetRef)
_SNQuest.ModThirst(25.0)
_SNQuest.ModHunger(35.0)
FXMeleeClawSmallVsFlesh.PlayandWait(akTargetRef)
_SNQuest.PlayerRef.AddItem(_SNHumanLoot)
_SNQuest.PlayerRef.AddItem(HumanHeart)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_56
Function Fragment_56(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
;feed mount
If _SNQuest.AutoEatHorse(_SNQuest.PlayerRef)
_SNHorseEatLP.Play(akTargetRef)
(akTargetRef as Actor).AddItem(_SNDummyHorseFood)
Utility.Wait(0.1)
(akTargetRef as Actor).EquipItem(_SNDummyHorseFood)
EndIf
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_187
Function Fragment_187(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
;werewolf feed
_SNQuest.ModThirst(45.0)
_SNQuest.ModHunger(55.0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SNQuestScript Property _SNQuest Auto
MiscObject Property _SNWaterBarrelKit Auto
MiscObject Property _SNWaterKegKit Auto
MiscObject Property _SNWellBucketKit Auto
Sound Property _SNHorseEatLP Auto
Sound Property _SNWaterskinRefillLP Auto
Sound Property _SNDisassemblingLP Auto
Sound Property _SNTakeLP Auto
Sound Property _SNWellUseLP Auto
Sound Property _SNFaucetLP Auto
Sound Property FXMeleeClawSmallVsFlesh Auto
Spell Property _SNFollowerSpell Auto
Spell Property _SNShelterDetectSpell Auto
Potion Property _SNDummyHorseFood Auto
Activator Property _SNShelterDetector Auto
LeveledItem Property _SNHumanLoot Auto
Ingredient Property HumanHeart Auto
ImpactDataSet Property BloodSprayImpactSetRed Auto
