;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial4_Sex2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_PlaySex2Synchron(Game.GetPlayer(),akSpeaker, "Anal", true)
SLV_SexIsRunning.setValue(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_SexIsRunning Auto 