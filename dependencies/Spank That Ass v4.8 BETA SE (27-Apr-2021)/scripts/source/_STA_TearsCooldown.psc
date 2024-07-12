Scriptname _STA_TearsCooldown extends activemagiceffect  

_STA_SexDialogUtil Property SexDialog Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForSingleUpdate(SexDialog.TearsCooldownInterval)
EndEvent

Event OnUpdate()
	SexDialog.ModifyTears(false)
	If SexDialog.CurrentTears != -1
		RegisterForSingleUpdate(SexDialog.TearsCooldownInterval)
	Else
		Self.Dispel()
	EndIf
EndEvent