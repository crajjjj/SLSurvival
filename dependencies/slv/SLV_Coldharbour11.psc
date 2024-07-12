;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Coldharbour11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5000)
GetOwningQuest().SetStage(5500)

myScripts.SLV_PlaySex2Synchron(Game.GetPlayer(),SLV_Deathhound.getActorRef(), "Sex", true)

int amputation = 9
SLV_AmputeePlayer.setValue(amputation)
if amputation > 6
	Amputee.SLV_AmputeeActor(Game.GetPlayer(),6)
	Utility.wait(2.0)
	amputation = amputation - 6	
	Amputee.SLV_AmputeeActor(Game.GetPlayer(), amputation)
else	
	Amputee.SLV_AmputeeActor(Game.GetPlayer(),amputation)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Amputee Property Amputee Auto
GlobalVariable Property SLV_AmputeePlayer Auto 
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Deathhound Auto
