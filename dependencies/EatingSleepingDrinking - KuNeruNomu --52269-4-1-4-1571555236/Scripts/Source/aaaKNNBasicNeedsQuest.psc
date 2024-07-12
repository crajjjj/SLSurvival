Scriptname aaaKNNBasicNeedsQuest extends Quest  

GlobalVariable Property aaaKNNIsEnableMessage auto
int IsShowMessage = 0

Event OnInIt()
	InIt()
EndEvent

Function InIt()
	IsShowMessage = aaaKNNIsEnableMessage.GetValueInt()
EndFunction

Function ShowMessage(Message MessageForm)
	if IsShowMessage == 1
		MessageForm.Show()
	endIf
EndFunction

Event OnShowMessage(Message msg)
	if msg
		ShowMessage(msg)
	endIf
EndEvent

Event OnChangeDrityBody(Actor player, Spell dirtyBodySpell, bool IsAddedSpell)
	;Debug.Notification("OnChangeDrityBody")
	if IsAddedSpell && dirtyBodySpell
		player.AddSpell(dirtyBodySpell, false)
	elseIf !IsAddedSpell && dirtyBodySpell
		player.RemoveSpell(dirtyBodySpell)
	endIf
EndEvent

Event OnPlaySoundBasicNeeds(Actor player, Spell[] soundSpell)
	int i = 0
	while i < soundSpell.Length
		if soundSpell[i]
			soundSpell[i].Cast(player)
		endIf
		i += 1
	endwhile
EndEvent

Event OnPlayerDrunk(Actor player, Spell drunkSpell, bool IsAdded)
	if IsAdded
		;Debug.Notification("Added Drunk Spell")
		player.AddSpell(drunkSpell, false)
	else
		;Debug.Notification("Removed Drunk Spell")
		player.RemoveSpell(drunkSpell)
	endIf
EndEvent

;Bedroll Activator
Event OnDroppedMiscObject(ObjectReference droppedRef, Form relpaceForm, int count)
	if droppedRef && relpaceForm && 0 < count
		int i = 0
		while i < count
			droppedRef.PlaceAtMe(relpaceForm, 1)
			i += 1
		endwhile
		droppedRef.Disable()
		droppedRef.Delete()
	endIf
EndEvent

Event SetBasicNeedsDamage(Actor player, spell[] spells)
	int i = 0
	while i < spells.Length
		if 0 < spells[i].GetNthEffectDuration(0)
			spells[i].Cast(player)
			;debug.trace("cast : " + spells[i].GetName())
		else
			player.AddSpell(spells[i], false)
			;debug.trace("add spell : " + spells[i].GetName())
		endIf
		i += 1
	endwhile
EndEvent

Event OnPlayerDie(Actor player)
	;Debug.Notification("OnPlayerDied")
	player.Kill()
EndEvent