;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiterunDeliverSlave1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(500)

ActorUtil.AddPackageOverride(akSpeaker , SLV_FollowPlayer,100)
akSpeaker.evaluatePackage()
if Game.GetModByName("CFTO.esp") != 255
   	Actor driver = Game.GetFormFromFile(0x0bbf6d, "CFTO.esp") as Actor
	SLV_CarriageDriver.ForceRefTo(driver)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_CarriageDriver Auto
Package Property SLV_FollowPlayer Auto