;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainAmputeePlayer2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int amputation = SLV_AmputeePlayer.getValue() as int

if amputation > 6
	Amputee.SLV_AmputeeActor(Game.GetPlayer(),6)
	Utility.wait(2.0)
	amputation = amputation - 6	
	Amputee.SLV_AmputeeActor(Game.GetPlayer(), amputation)
else	
	Amputee.SLV_AmputeeActor(Game.GetPlayer(),amputation)
endif
Utility.wait(2.0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Amputee Property Amputee Auto
GlobalVariable Property SLV_AmputeePlayer Auto 
