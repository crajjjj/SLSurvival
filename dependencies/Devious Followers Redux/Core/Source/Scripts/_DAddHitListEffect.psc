Scriptname _DAddHitListEffect extends activemagiceffect  

FormList Property hitlist Auto
Actor Property Playerref Auto
Faction Property _DCalm Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	If akTarget != playerref
    
		If !hitlist.HasForm(akTarget)	
        
			hitlist.addForm(akTarget)			
			akTarget.StopCombat()
			akTarget.StopCombatAlarm()
			akTarget.SheatheWeapon()
			akTarget.AddToFaction(_DCalm)
			akTarget.SetFactionRank(_DCalm, 100)	
            
		EndIf
        
	EndIf
    
EndEvent
