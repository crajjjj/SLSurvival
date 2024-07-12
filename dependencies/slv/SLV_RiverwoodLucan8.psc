;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiverwoodLucan8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int count = riverwoodCount.getValue() as Int
count+=1
riverwoodCount.setValue(count)
if count >= 3
	riverwoodmain.SetObjectiveCompleted(1000)
	riverwoodmain.setStage(1500)
endif

myScripts.SLV_Play2Sex(Slave02.GetActorRef() , akSpeaker, "Anal", true)

GetOwningQuest().SetObjectiveCompleted(3500)
getowningquest().setstage(4000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property riverwoodCount Auto
Quest Property riverwoodmain Auto
ReferenceAlias Property Slave02 Auto
