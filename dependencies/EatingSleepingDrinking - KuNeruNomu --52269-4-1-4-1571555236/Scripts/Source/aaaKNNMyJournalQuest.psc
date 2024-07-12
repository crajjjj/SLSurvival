Scriptname aaaKNNMyJournalQuest extends Quest

GlobalVariable Property aaaKNNWashBodyInterval auto Conditional
GlobalVariable Property aaaKNNBodyHealth auto Conditional
GlobalVariable Property aaaKNNThirsty auto Conditional
GlobalVariable Property aaaKNNHungry auto Conditional
GlobalVariable Property aaaKNNSleepiness auto Conditional
ReferenceAlias Property Journal auto

Function UpdateMyJournal()
	Debug.Notification("UpdateMyJournal")
	aaaKNNBodyHealth.SetValue(KNNPlugin_Utility.GetBasicNeeds("Bodyhealth"))
	if !UpdateCurrentInstanceGlobal(aaaKNNBodyHealth)
		Debug.Trace("[KuNeruNomu] Failed to update physical condition jurnal value for quest")
	endIf
	aaaKNNThirsty.SetValue(KNNPlugin_Utility.GetBasicNeeds("Thirsty"))
	if !UpdateCurrentInstanceGlobal(aaaKNNThirsty)
		Debug.Trace("[KuNeruNomu] Failed to update physical condition jurnal value for quest")
	endIf
	aaaKNNHungry.SetValue(KNNPlugin_Utility.GetBasicNeeds("Hungry"))
	if !UpdateCurrentInstanceGlobal(aaaKNNHungry)
		Debug.Trace("[KuNeruNomu] Failed to update physical condition jurnal value for quest")
	endIf
	aaaKNNSleepiness.SetValue(KNNPlugin_Utility.GetBasicNeeds("Sleepiness"))
	if !UpdateCurrentInstanceGlobal(aaaKNNSleepiness)
		Debug.Trace("[KuNeruNomu] Failed to update physical condition jurnal value for quest")
	endIf
	if !UpdateCurrentInstanceGlobal(aaaKNNWashBodyInterval)
		Debug.Trace("[KuNeruNomu] Failed to update physical condition jurnal value for quest")
	endIf
EndFunction

;Spell Property aaaKNNPlayJurnalSpell auto

Event OnPlayJurnal(Actor player, MiscObject[] removeItems)
	if !Journal.GetRef()
		return
	endIf
	UpdateMyJournal()
	if removeItems.length == 2
		player.RemoveItem(removeItems[0])
		player.RemoveItem(removeItems[1])
	endIf
	;aaaKNNPlayJurnalSpell.Cast(player)
EndEvent

