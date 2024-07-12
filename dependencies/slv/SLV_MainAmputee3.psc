;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainAmputee3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int bodypart = SLV_AmputeePlayer.getValue() as int
int bodypart2 = 0

if bodypart > 6
	bodypart2 = bodypart - 6	
	bodypart = 6
endif

SLV_AmputeePlayer.setValue(1)

myScripts.SLV_PlayScene(PunishScene)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_AmputeePlayer Auto
SLV_Utilities Property myScripts auto
Scene Property PunishScene Auto 
