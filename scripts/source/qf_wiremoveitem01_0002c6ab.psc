;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname QF_WIRemoveItem01_0002C6AB Extends Quest Hidden

;BEGIN ALIAS PROPERTY Item
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Item Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Owner
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Owner Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Guard
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Guard Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
;condition on dialogue
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE WIRemoveItem01Script
Quest __temp = self as Quest
WIRemoveItem01Script kmyQuest = __temp as WIRemoveItem01Script
;END AUTOCAST
;BEGIN CODE
kmyquest.SetNextEventGlobals()	;lives in parent script WorldInteractionsScript
_SLS_GuardWarnTypeAndCooldown.SetValueInt(5)
_SLS_GuardWarnDoApproach.SetValueInt(0)
Actor Guard = Alias_Guard.GetReference() as Actor
If Guard.IsInFaction(_SLS_GuardBehaviourWarningFact)
	;(Game.GetFormFromFile(0x000D64, "SL Survival.esp") as SLS_Utility).FillWarnedGuardAlias(Guard)
	(Game.GetFormFromFile(0x000D64, "SL Survival.esp") as SLS_Utility).SendBeginGuardWarnPunishEvent(Self, Guard)
EndIf
_SLS_GuardWarnDoApproach.SetValueInt(1)
Guard.EvaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property _SLS_GuardBehaviourWarningFact  Auto  

GlobalVariable Property _SLS_GuardWarnDoApproach Auto
GlobalVariable Property _SLS_GuardWarnTypeAndCooldown  Auto
