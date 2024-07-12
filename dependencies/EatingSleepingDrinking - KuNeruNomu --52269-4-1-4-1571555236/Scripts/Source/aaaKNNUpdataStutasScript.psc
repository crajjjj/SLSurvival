Scriptname aaaKNNUpdataStutasScript extends Quest

;Actor Property player auto
;Potion Property dummyPotion auto
Spell Property DummySpell auto

Event KNNOnLoadGame()
	;Debug.Trace("KNNOnLoadGame -> aaaKNNUpdataStutasScript")
	UpdateStutas(none)
EndEvent

Function UpdateStutas(Actor thePlayer)
	;Debug.Notification("UpdateStutas")
	if !thePlayer
		thePlayer = Game.GetPlayer()
	endIf
	DummySpell.Cast(thePlayer)
	;player.AddItem(dummyPotion, 1, true)
	;Utility.Wait(0.1)
	;Debug.Trace("Before Potions Used : " + Game.QueryStat("Potions Used"))
	;player.EquipItem(dummyPotion, false, true)
	;Debug.Trace("After Potions Used : " + Game.QueryStat("Potions Used"))
	;Game.IncrementStat("Potions Used", -1)
	;Debug.Trace("Potions Used : " + Game.QueryStat("Potions Used"))
EndFunction