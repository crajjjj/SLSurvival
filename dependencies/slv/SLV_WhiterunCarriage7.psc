;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiterunCarriage7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(500)
Horse.enable()

Slave.enable()
Slave.moveto(Game.getPlayer())

ActorUtil.AddPackageOverride(Slave,followPlayer,100)
Slave.evaluatePackage()

if Game.GetModByName("CFTO.esp") != 255
   	Actor driver = Game.GetFormFromFile(0x0bbf6d, "CFTO.esp") as Actor
	SLV_CarriageDriver.ForceRefTo(driver)
endif
SLV_UseSlaverAsSlave.setValue(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_UseSlaverAsSlave auto
Actor Property Horse  Auto  
ReferenceAlias Property SLV_CarriageDriver Auto
Actor Property Slave  Auto  
Package Property FollowPlayer Auto
