;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiverwoodLucan4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_DeviousUnEquip(false,true,true,true,true,false,true,true,true,true,true,true,false,false,true)

int count = riverwoodCount.getValue() as Int
count+=1
riverwoodCount.setValue(count)
if count >= 3
	riverwoodmain.SetObjectiveCompleted(1000)
	riverwoodmain.setStage(1500)
endif

GetOwningQuest().SetObjectiveCompleted(3500)
getowningquest().setstage(4000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property riverwoodCount Auto
Quest Property riverwoodmain Auto
SLV_Utilities Property myScripts auto

