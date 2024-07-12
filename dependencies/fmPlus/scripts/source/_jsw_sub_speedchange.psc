Scriptname	_JSW_SUB_SpeedChange	extends		ActiveMagicEffect

ammo		Property		TokenTrue		Auto	; used to force recalculation of speed

event	OnEffectStart(Actor akTarget, Actor akCaster)

	if akTarget
		akTarget.AddItem(TokenTrue as form, 1, true)
;		RegisterforSingleupdate(1.0)
		Utility.Wait(1.0)
		while akTarget.GetItemCount(TokenTrue as form) > 0
			akTarget.RemoveItem(TokenTrue as form, 1, true)
		endWhile
	endIf

endEvent
;/
event	OnUpdate()

	; 2.15 - remove any/all found tokens
	while thisActor.GetItemCount(TokenTrue as form) > 0
		thisActor.RemoveItem(TokenTrue as form, 1, true)
	endWhile

endEvent/;

;/	Due to a quirk in the game, it doesn't calculate speed changes unless the player's carry weight changes.
	When adding/removing a ME that changes player speed, attach this to it.   It adds a 0.1 weight invisible
	"ammo" then removes it 1 second later to force the speed recalculation	/;
