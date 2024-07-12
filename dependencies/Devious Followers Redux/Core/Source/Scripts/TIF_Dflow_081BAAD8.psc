;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF_Dflow_081BAAD8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.GetPlayer().RemoveItem(gold001, 50)
MCM.Lives.SetValue(MCM.LivesM.GetValue())

Float targetTime
If GameHour.GetValue() < 16.0
    targetTime = GameHour.GetValue() + 8.0
else
    targetTime = GameHour.GetValue() + 8.0 - 24.0
    GameHour.SetValue(23.99)
    Utility.Wait(3)
EndIf
GameHour.SetValue(targetTime)
Wait4Follower.Show()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject Property gold001 Auto
_DFlowMCM Property MCM Auto 
Message Property Wait4Follower Auto
GlobalVariable Property GameHour Auto
