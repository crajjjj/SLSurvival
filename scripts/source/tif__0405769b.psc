;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF__0405769B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
_SLS_RestrictTradeCooldownSpell.Cast(akSpeaker, akSpeaker)
akSpeaker.ShowBarterMenu()
Utility.WaitMenuMode(0.5)
Utility.Wait(1.0)
PlayerRef.RemovePerk(_SLS_TradeRestrictionPerk)
_SLS_LicenceTradersQuest.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If !akSpeaker.HasMagicEffect(_SLS_RestrictTradeCooldownMgef)
	PlayerRef.RemoveItem(Gold001, aiCount = _SLS_RestrictTradeBribe.GetValueInt(), abSilent = false, akOtherContainer = akSpeaker)
EndIf
PlayerRef.AddPerk(_SLS_TradeRestrictionPerk)
_SLS_LicenceTradersQuest.Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property Gold001 Auto

Actor Property PlayerRef Auto

Perk Property _SLS_TradeRestrictionPerk Auto

Spell Property _SLS_RestrictTradeCooldownSpell Auto

MagicEffect Property _SLS_RestrictTradeCooldownMgef Auto

Quest Property _SLS_LicenceTradersQuest Auto

GlobalVariable Property _SLS_RestrictTradeBribe Auto
