;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeBardsCollegeEnd Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
solitudemain.SetObjectiveCompleted(4500)
solitudemain.setStage(5000)

ActorUtil.ClearPackageOverride(Giraurd.getactorref())
Giraurd.getactorref().evaluatePackage()
ActorUtil.ClearPackageOverride(Viarmo.getactorref())
Viarmo.getactorref().evaluatePackage()
ActorUtil.ClearPackageOverride(Illdi.getactorref())
Illdi.getactorref().evaluatePackage()
ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()
if SLV_Slave
	ActorUtil.ClearPackageOverride(SLV_Slave.getactorref())
	SlV_Slave.getactorref().evaluatePackage()
endif

GetOwningQuest().SetObjectiveCompleted(6000)
GetOwningQuest().SetStage(6500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property solitudemain Auto
ReferenceAlias Property Giraurd Auto 
ReferenceAlias Property Viarmo Auto 
ReferenceAlias Property Illdi Auto 
ReferenceAlias Property SLV_Slave Auto 


