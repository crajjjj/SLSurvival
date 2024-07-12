;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_FalkreathSolaf5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ActorUtil.ClearPackageOverride(SLV_Bolund.GetActorRef())
SLV_Bolund.GetActorRef().evaluatePackage()

int count = falkreathCount.getValue() as Int
count+=1
falkreathCount.setValue(count)
if count >= 3
	falkreathmain.SetObjectiveCompleted(3500)
	falkreathmain.setStage(4000)
endif

GetOwningQuest().SetObjectiveCompleted(3000)
getowningquest().setstage(3500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property falkreathmain Auto
GlobalVariable Property falkreathCount Auto
ReferenceAlias Property SLV_Bolund Auto