;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial7_21 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3500)
GetOwningQuest().SetStage(4000)
ActorUtil.AddPackageOverride(akSpeaker,SLV_Followplayer ,100)
akSpeaker.evaluatePackage()

akSpeaker.moveto(Game.getplayer())
SLV_UseFollowerSex.setvalue(0)

myScripts.SLV_Play3Sex(Camilla.getActorRef() ,akSpeaker, Game.GetPlayer(), "Blowjob", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property Camilla Auto 
Package Property SLV_Followplayer Auto
GlobalVariable Property SLV_UseFollowerSex Auto 
