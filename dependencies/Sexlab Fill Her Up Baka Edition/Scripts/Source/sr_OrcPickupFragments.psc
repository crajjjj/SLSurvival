;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 24
Scriptname sr_OrcPickupFragments Extends Quest Hidden

;BEGIN ALIAS PROPERTY Chief
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Chief Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY PlayerRef
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_PlayerRef Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Odall
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Odall Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CourierStart
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CourierStart Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY MiddlePump
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_MiddlePump Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Stronghold
;ALIAS PROPERTY TYPE LocationAlias
LocationAlias Property Alias_Stronghold Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY CourierSpawn
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_CourierSpawn Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY ImperialCourier
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_ImperialCourier Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY FirstPump
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_FirstPump Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE sr_OrcPickup
Quest __temp = self as Quest
sr_OrcPickup kmyQuest = __temp as sr_OrcPickup
;END AUTOCAST
;BEGIN CODE
SetStage(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN AUTOCAST TYPE sr_OrcPickup
Quest __temp = self as Quest
sr_OrcPickup kmyQuest = __temp as sr_OrcPickup
;END AUTOCAST
;BEGIN CODE
; Getting filled, positive
SetObjectiveDisplayed(20)
kmyQuest.ftu.UnequipUniform(belt = true, collar = false)
kmyQuest.StartSceneProfessional()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_17
Function Fragment_17()
;BEGIN CODE
; Returned to Odall, transfer here
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE sr_OrcPickup
Quest __temp = self as Quest
sr_OrcPickup kmyQuest = __temp as sr_OrcPickup
;END AUTOCAST
;BEGIN CODE
kmyQuest.inflater.ResetActor(Alias_ImperialCourier.GetActorReference())
Alias_ImperialCourier.GetActorReference().Delete()
kmyQuest.DisablePump(false)
kmyQuest.sr_OPUPercentage.SetValueInt(0)
kmyQuest.CompleteAndWaitForReset(0.5)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_22
Function Fragment_22()
;BEGIN AUTOCAST TYPE sr_OrcPickup
Quest __temp = self as Quest
sr_OrcPickup kmyQuest = __temp as sr_OrcPickup
;END AUTOCAST
;BEGIN CODE
; Forced filling done
kmyQuest.RemoveFaction()
SetObjectiveCompleted(20)
Alias_ImperialCourier.GetReference().MoveTo(Alias_CourierStart.GetReference())
kmyQuest.ftu.EquipUniform(belt = false, collar = true, open = true, courier = Alias_ImperialCourier.GetActorReference())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN AUTOCAST TYPE sr_OrcPickup
Quest __temp = self as Quest
sr_OrcPickup kmyQuest = __temp as sr_OrcPickup
;END AUTOCAST
;BEGIN CODE
kmyQuest.RemoveItems()
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN AUTOCAST TYPE sr_OrcPickup
Quest __temp = self as Quest
sr_OrcPickup kmyQuest = __temp as sr_OrcPickup
;END AUTOCAST
;BEGIN CODE
; Getting filled, negative
SetObjectiveDisplayed(20)
kmyQuest.ManipulateArmbinder(true)
kmyQuest.ftu.UnequipUniform(belt = true, collar = false)
kmyQuest.MakeArmbinderInescapable(true)
kmyQuest.FactionCheck()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN CODE
; Transfer done, courier leaves
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
; Met the chief
SetObjectiveCompleted(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN AUTOCAST TYPE sr_OrcPickup
Quest __temp = self as Quest
sr_OrcPickup kmyQuest = __temp as sr_OrcPickup
;END AUTOCAST
;BEGIN CODE
SetObjectiveCompleted(20)
SetObjectiveDisplayed(30)
Alias_ImperialCourier.GetReference().MoveTo(Alias_CourierStart.GetReference())
kmyQuest.ftu.EquipUniform(belt = false, collar = true, open = true, courier = Alias_ImperialCourier.GetActorReference())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN AUTOCAST TYPE sr_OrcPickup
Quest __temp = self as Quest
sr_OrcPickup kmyQuest = __temp as sr_OrcPickup
;END AUTOCAST
;BEGIN CODE
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
; Mid Scene interrupt
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_21
Function Fragment_21()
;BEGIN CODE
; Chief keeps the player as a pet for a while
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
