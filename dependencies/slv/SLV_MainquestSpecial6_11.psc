;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial6_11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1000)
getowningquest().setstage(1500)

Horse1.getActorRef().enable()
Horse2.getActorRef().enable()

Alfhild.getActorRef().moveto(farmwaypoint)
ActorUtil.AddPackageOverride(Alfhild.getActorRef(), SLV_Idle,100)
Alfhild.getActorRef().evaluatePackage()

if ThisMenu.SkipScenes
	ActorUtil.ClearPackageOverride(akSpeaker )
	akSpeaker.evaluatePackage()
	return
endif

SendModEvent("dhlp-Suspend")
;game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
;game.SetPlayerAIDriven(true)
PunishScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property Horse1 Auto 
ReferenceAlias Property Horse2 Auto 

SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto 

ReferenceAlias Property Alfhild Auto 
ObjectReference Property farmwaypoint Auto
Package Property SLV_Idle Auto

