;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial5_6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2500)
GetOwningQuest().SetStage(3000)
SexTourist2a.getactorref().enable()
SexTourist2b.getactorref().enable()

myScripts.SLV_DeviousEquip(false,false,false,false,false,true,true,false,false,false,true,true,true,false,false)

SexTourist1a.getactorref().moveto(SexTourist2a.getactorref())
ActorUtil.ClearPackageOverride(SexTourist1a.getactorref())
SexTourist1a.getactorref().evaluatePackage()
SexTourist1a.getactorref().disable()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SexTourist1a Auto 
ReferenceAlias Property SexTourist2a Auto 
ReferenceAlias Property SexTourist2b Auto 
SLV_Utilities Property myScripts auto

