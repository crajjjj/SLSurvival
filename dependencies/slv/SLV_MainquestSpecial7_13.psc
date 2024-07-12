;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial7_13 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5500)
GetOwningQuest().SetStage(6000)

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()

myScripts.SLV_SexlabStripNPC(Game.GetPlayer())
myScripts.SLV_SexlabStripNPC(Camilla.getActorRef())

myScripts.SLV_DeviousEquip(true,true,true,false,true,true,true,true,false,true,true,true,true,true,true)
Utility.wait(2.0)

myScripts.SLV_DeviousEquipActor(Camilla.getActorRef(),false,true,true,false,true,true,true,true,false,true,true,true,true,true,true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property Camilla Auto 
