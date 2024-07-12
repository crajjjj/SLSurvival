;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 8
Scriptname sr_FTUFavorRetryScene Extends Scene Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
game.disablePlayerControls()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
Game.EnablePlayerControls()
StartTimer()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
FillStart()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

sr_FTUDeliveryFrame Property ftu Auto
sr_inflateQuest Property inflater auto
GlobalVariable Property sr_FTUFavorFinish auto


Function FillStart()
	inflater.log("Favor retry fill start")
	If ftu.playerInPump == 1
		Debug.SendAnimationEvent(inflater.player, "ZaZMOMFreeFurn_06")
	Else
		Debug.SendAnimationEvent(inflater.player, "ZaZMOMBoundFurn_06")
	EndIf
	ftu.StartMoanLoop(inflater.player)
	RegisterForModEvent("ftu-favor-retryscene", "FillCont")
	inflater.InflateTo(inflater.player, 1, 30.0, targetLevel = -1.0, callback = "ftu-favor-retryscene")
EndFunction

Event FillCont(Form akActor, float startVag, float startAn)
	inflater.log("Favor retry fill continue")
	UnregisterForModEvent("ftu-favor-retryscene")
	RegisterForModEvent("ftu-favor-retryscene2", "FillFinish")
	
	float target = (inflater.config.maxInflation - inflater.GetOriginalScale(inflater.player)) * 0.2 ; Fill anal pool 20%, not quite enough to trigger bursting which in reality is around ~126% of pool size
	
	inflater.InflateTo(inflater.player, 2, 10.0, target, callback = "ftu-favor-retryscene2")
EndEvent

Event FillFinish(Form akActor, float startVag, float startAn)
	inflater.log("Favor retry fill finish")
	UnregisterForModEvent("ftu-favor-retryscene2")
	ftu.aroused.UpdateActorExposure(inflater.player, 15, "getting flooded with cum")
	If ftu.playerInPump == 1
		Debug.SendAnimationEvent(inflater.player, "ZaZMOMFreeFurn_02")
	Else
		Debug.SendAnimationEvent(inflater.player, "ZaZMOMBoundFurn_02")
	EndIf
	ftu.StopMoanLoop(inflater.player)
	ftu.EquipUniform(true, true, false)
	(GetOwningQuest() as sr_FTUConditionals).FavorRetryFillDone = true
EndEvent

Function StartTimer()
	sr_FTUFavorFinish.SetValue(Utility.GetCurrentGameTime() + Utility.RandomFloat(5.0, 8.0))
EndFunction
