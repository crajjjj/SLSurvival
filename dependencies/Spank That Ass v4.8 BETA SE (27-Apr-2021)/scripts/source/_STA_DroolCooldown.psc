Scriptname _STA_DroolCooldown extends activemagiceffect  

_STA_SexDialogUtil Property SexDialog Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	RegisterForSingleUpdate(SexDialog.DroolCooldown)
EndEvent

Event OnUpdate()
	SexDialog.RemoveDrool()
	Self.Dispel()
EndEvent