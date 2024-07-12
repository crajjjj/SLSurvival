;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 50
Scriptname aaaKNNPerkPlayAnim Extends Perk Hidden

Quest Property PerkAnimCtrl auto

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkFloraAnimQuest).HarvestFlora(akTargetRef, akActor, 0)		;harvest plants tree
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkFloraAnimQuest).HarvestFlora(akTargetRef, akActor, 1)		;harvest insect
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkCritterAquaticAnimQuest).HarvestCritterAquatic(akTargetRef, akActor)	;harvest fish
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkDoorAnimQuest).ActivateDoor(akTargetRef, akActor, 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkDoorAnimQuest).ActivateDoor(akTargetRef, akActor, 3)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkDoorBoltAnimQuest).ActivateDoorBolt(akTargetRef, akActor, 3)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkDoorBoltAnimQuest).ActivateDoorBolt(akTargetRef, akActor, 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkPuzzlePillarAnimQuest).ActivatePuzzlePillar(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkContainerAnimQuest).ActivateChest(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkContainerAnimQuest).ActivateBarrel(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkContainerAnimQuest).ActivateCupBoard(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkContainerAnimQuest).ActivateEndTable(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkContainerAnimQuest).ActivateWardrobe(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkContainerAnimQuest).ActivateMisc(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_18
Function Fragment_18(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkPullChainAnimQuest).ActivatePullChain(akTargetRef, akActor, false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkPullChainAnimQuest).ActivatePullChain(akTargetRef, akActor, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_21
Function Fragment_21(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkPullBarAnimQuest).ActivatePullBar(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_22
Function Fragment_22(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkTrapAnimQuest).ActivateTraps(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkPuzzleWheelAnimQuest).ActivatePuzzleWheel(akTargetRef, akActor, 3)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkPuzzleWheelAnimQuest).ActivatePuzzleWheel(akTargetRef, akActor, 2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkPuzzleWheelAnimQuest).ActivatePuzzleWheel(akTargetRef, akActor, 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkAnimCageQuest).ActivateCageGate(akTargetRef, akActor, 3)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_27
Function Fragment_27(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkAnimCageQuest).ActivateCageGate(akTargetRef, akActor, 1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_28
Function Fragment_28(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkContainerAnimQuest).ActivateLoot(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_29
Function Fragment_29(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkContainerAnimQuest).ActivateLoot(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_30
Function Fragment_30(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkLeverAnimQuest).ActivateLever(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_33
Function Fragment_33(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkBedAnimQuest).ActivateBed(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_34
Function Fragment_34(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkShrineAnimQuest).ActivateShrine(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_35
Function Fragment_35(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkBedAnimQuest).ActivateBedroll(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_36
Function Fragment_36(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkContainerAnimQuest).ActivateSack(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_37
Function Fragment_37(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkDweBottonAnimQuest).ActivateDweBotton(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_38
Function Fragment_38(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkTrapAnimQuest).ActivateTraps(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_39
Function Fragment_39(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkDoorAnimQuest).ActivateDoorLoad(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_40
Function Fragment_40(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkLeverAnimQuest).ActivateFurnitureLever(akTargetRef, akActor)		;Furniture Lever　実装してない
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_41
Function Fragment_41(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkFloraAnimQuest).HarvestFlora(akTargetRef, akActor, 2)		;harvest plants flora
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_42
Function Fragment_42(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkDisplayCaseAnimQuest).ActivateDisplayCase(akTargetRef, akActor)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_43
Function Fragment_43(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkDoorAnimQuest).ActivateDoor(akTargetRef, akActor, 3)		;perk door legacy
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_44
Function Fragment_44(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkDoorAnimQuest).ActivateDoor(akTargetRef, akActor, 1)		;perk door legacy
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_45
Function Fragment_45(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkDoorAnimQuest).ActivateDoorLoad(akTargetRef, akActor)		;perk door legacy
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_46
Function Fragment_46(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkDisplayCaseAnimQuest).ActivateDisplayCase(akTargetRef, akActor)		;perk door legacy
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_47
Function Fragment_47(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkFloraAnimQuest).HarvestFlora(akTargetRef, akActor, 0)			;plants nirnroot
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_48
Function Fragment_48(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
(PerkAnimCtrl as aaaKNNPlayPerkPuzzleWheelAnimQuest).ActivatePuzzleWheel(akTargetRef, akActor, 4)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
