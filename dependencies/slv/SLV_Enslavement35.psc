;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Enslavement35 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_EnforcerIgnorePC.setvalue(0)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Sven.getactorref())
SLV_Sven.getactorref().evaluatePackage()

ActorUtil.ClearPackageOverride(SLV_Dog.getactorref())
SLV_Dog.getactorref().evaluatePackage() 

SLV_Dog.getactorref().moveto(doghome) 

GetOwningQuest().SetObjectiveCompleted(6500)
GetOwningQuest().SetStage(7000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Sven Auto 
ReferenceAlias Property SLV_Dog Auto 
GlobalVariable Property SLV_EnforcerIgnorePC  Auto
ObjectReference Property doghome auto
