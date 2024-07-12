ScriptName mzinBathePlayerAlias Extends ReferenceAlias

mzinBatheQuest Property BatheQuest Auto
Spell Property GetDirtyOverTimeReactivatorCloakSpell Auto

Actor Player
Bool Reapplying

Event OnPlayerLoadGame()
	BatheQuest.UpdateDangerousWater()
	Player = Game.GetPlayer()
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	If Reapplying == False
		Reapplying = True
		Player.RemoveSpell(GetDirtyOverTimeReactivatorCloakSpell)
		Utility.Wait(1)
		Player.AddSpell(GetDirtyOverTimeReactivatorCloakSpell, False)
		Reapplying = False
	EndIf
EndEvent