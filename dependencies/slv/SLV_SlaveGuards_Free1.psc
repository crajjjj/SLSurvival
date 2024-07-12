;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveGuards_Free1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE

myScripts.SLV_FreeSubmissiveChange(true,1)

if MCMMenu.SlaveGuardsEquipDevices
	myScripts.SLV_DeviousProgressiveEquipActor(Game.GetPlayer(),false)
endif

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker,"Boobjob", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property MCMMenu Auto
