Scriptname _DAddtoHitListEffect extends activemagiceffect  

FormList Property hitlist Auto
Actor Property playerref Auto
Faction Property _DCalm Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Actor t = akTarget
	if t != playerref
		if !hitlist.HasForm(t)	
			hitlist.addForm(t)			
			t.StopCombat()
			t.StopCombatAlarm()
			t.SheatheWeapon()
			t.AddToFaction(_DCalm)
			t.SetFactionRank(_DCalm, 100)	
			Armor a = t.GetWornForm(0x00000002) as Armor
			Armor b = t.GetWornForm(0x00000004) as Armor
			Armor c = t.GetWornForm(0x00000008) as Armor
			Armor d = t.GetWornForm(0x00000080) as Armor


			
			t.RemoveItem(a)
         


t.RemoveItem(c)



t.RemoveItem(d)


t.RemoveItem(b)

		endif
	endif
EndEvent

; This should everyone hit to a list and calm them down.
;