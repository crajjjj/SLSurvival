Scriptname aaaKNNPlayStumbleQuest extends Quest  

Spell Property aaaKNNPlayStumbleBearTrapSpell auto
Event OnPlayerStumbleBearTrap(Actor player, ObjectReference bearTrap, bool hasLightFoodPerk)
	aaaKNNPlayStumbleBearTrapSpell.Cast(player)
	if hasLightFoodPerk
		bearTrap.Activate(player)
	endIf
EndEvent

Event OnPlayerStumblePressurePlate(Actor player, ObjectReference trapPlate)
	trapPlate.Activate(trapPlate)
EndEvent

Spell Property aaaKNNBackstabSpell auto
Event OnBackstabPlayer(Actor player, Actor attacker)
	aaaKNNBackstabSpell.Cast(attacker, player)
EndEvent