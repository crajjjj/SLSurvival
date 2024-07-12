;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_FalkreathLod22 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3800)
GetOwningQuest().SetStage(4000)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()

int count = falkreathCount.getValue() as Int
count+=1
falkreathCount.setValue(count)
if count >= 3
	falkreathmain.SetObjectiveCompleted(3500)
	falkreathmain.setStage(4000)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property falkreathmain Auto
GlobalVariable Property falkreathCount Auto
