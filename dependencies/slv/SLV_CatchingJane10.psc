;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJane10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_Jane.getactorref().removeallitems()
Utility.wait(2.0)

SLV_Jane.getactorref().additem(Torch,1)

myScripts.SLV_enslavementChains(SLV_Jane.getactorref())
Utility.wait(2.0)

myScripts.SLV_DeviousEquipActor(SLV_Jane.getActorRef(),false,false,false,false,false,false,false,false,false,false,true,false,false,false,true)
Utility.wait(2.0)

myScripts.SLV_enslavementChains(SLV_Jane.getactorref())
Utility.wait(2.0)
myScripts.SLV_SexlabStripNPC(akspeaker)

GetOwningQuest().SetObjectiveCompleted(3500)
getowningquest().setstage(4000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Jane Auto 
Light Property Torch Auto
