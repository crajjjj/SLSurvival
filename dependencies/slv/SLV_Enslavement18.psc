;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Enslavement18 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3500)
GetOwningQuest().SetStage(4000)

;zbfSlaveControl zbs = zbfSlaveControl.getApi()
;zbs.setPlayerMaster(akSpeaker, "Slaverun Reloaded")

;zbfSlaveLeash leash = zbfSlaveLeash.GetApi()
;leash.SetMaster(akSpeaker ) 
;leash.TravelTo(waypoint ) 
;zbl.TravelTo(waypointtest , akSpeaker , SLV_Sven.getActorRef(), SLV_Dog.getActorRef() , "You are forced to enter Slaverun.")

if ThisMenu.SkipScenes
	GetOwningQuest().SetObjectiveCompleted(3500)
	GetOwningQuest().SetStage(4000)
	return
endif

ActorUtil.AddPackageOverride(akSpeaker, IdleNPC,100)
akSpeaker.evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Sven.GetActorRef(), IdleNPC,100)
SLV_Sven.GetActorRef().evaluatePackage()
ActorUtil.AddPackageOverride(SLV_Dog.GetActorRef(), IdleNPC,100)
SLV_Dog.GetActorRef().evaluatePackage()

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
SLV_EnforcerIgnorePC.setValue(1)
PunishScene.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property ThisMenu auto
SLV_Utilities Property myScripts auto
Scene Property PunishScene  Auto 
ReferenceAlias Property SLV_Sven Auto
ReferenceAlias Property SLV_Dog Auto
ObjectReference Property waypoint Auto
GlobalVariable Property SLV_EnforcerIgnorePC  Auto  
Package Property IdleNPC Auto


;zbfSlaveControl Property zbs auto
;zbfSlaveLeash Property zbl auto 
;zbfBondageShell Property zbf Auto





