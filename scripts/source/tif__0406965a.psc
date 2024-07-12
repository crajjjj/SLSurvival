;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0406965A Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor PlayerRef = Game.GetPlayer()
(Game.GetFormFromFile(0x000D64, "SL Survival.esp") as SLS_Utility).DoCreatureSex(Receiver = PlayerRef, akSpeaker = akSpeaker, SexType = "4P", Victim = None, IsCreatureFondle = true)
Debug.SendAnimationEvent(PlayerRef, "IdleStop")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
