;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlaveGuards_Towns_1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_GetMoreSubmissive(false,1)

if MCMMenu.SlaveGuardsEquipDevices
	myScripts.SLV_DeviousProgressiveEquipActor(PlayerRef ,false)
endif

myScripts.SLV_SexlabStripNPC(PlayerRef )
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_MCMMenu Property MCMMenu Auto
Actor Property PlayerRef Auto
