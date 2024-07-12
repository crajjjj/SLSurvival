;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeFashionEnd2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
solitudemain.SetObjectiveCompleted(3500)
solitudemain.setStage(4000)

ActorUtil.ClearPackageOverride(Falk.getactorref())
Falk.getactorref().evaluatePackage()
ActorUtil.ClearPackageOverride(Taarie.getactorref())
Taarie.getactorref().evaluatePackage()
ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()

myScripts.SLV_DeviousUnEquipActor(Taarie.getactorref(),true,false,false,true,true,false,false,false,true,true,false,false,false,false,false)
Utility.wait(2.0)

GetOwningQuest().SetObjectiveCompleted(6000)
GetOwningQuest().SetStage(6500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Quest Property solitudemain Auto
SLV_Utilities Property myScripts auto
ReferenceAlias Property Taarie Auto 
ReferenceAlias Property Falk Auto 


