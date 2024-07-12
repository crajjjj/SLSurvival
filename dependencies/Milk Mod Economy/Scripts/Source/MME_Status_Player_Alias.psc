Scriptname MME_Status_Player_Alias extends ReferenceAlias Hidden
{MME check script Player_Alias}
;Should (re)launch MME_Status script on every player load game

Event OnPlayerLoadGame()
	Quest.GetQuest("mme_StatusCheck").stop()
	;Quest.GetQuest("mme_StatusCheck").reset()	;reset interrupts script, so we don't use it here
	Quest.GetQuest("mme_StatusCheck").start()
EndEvent