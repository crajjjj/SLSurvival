;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MarkarthOrcSmith8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ActorUtil.ClearPackageOverride(OrcSister.getactorref())
OrcSister.getactorref().evaluatePackage()

markarthmain.SetObjectiveCompleted(1000)
markarthmain.setStage(1500)

GetOwningQuest().SetObjectiveCompleted(3500)
GetOwningQuest().SetStage(4000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property markarthmain Auto
ReferenceAlias Property OrcSister Auto 
