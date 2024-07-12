;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingIvana15 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
GetOwningQuest().SetStage(1000)

if MCMMenu.skipScenes
	SLV_Valentina.getactorref().removeallitems()
	Utility.wait(2.0)

	SLV_Valentina.getactorref().additem(Torch,1)

	myScripts.SLV_enslavementChains(SLV_Valentina.getactorref())
	Utility.wait(2.0)

	myScripts.SLV_DeviousEquipActor(SLV_Valentina.getActorRef(),false,false,false,false,false,false,false,false,false,false,true,false,false,false,true)
	Utility.wait(2.0)

	myScripts.SLV_enslavementChains(SLV_Valentina.getactorref())
	Utility.wait(2.0)
else
	myScripts.SLV_PlayScene(PunishScene)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property PunishScene  Auto
SLV_Utilities Property myScripts auto

SLV_MCMMenu Property MCMMenu Auto
ReferenceAlias Property SLV_Valentina Auto 
Light Property Torch Auto
