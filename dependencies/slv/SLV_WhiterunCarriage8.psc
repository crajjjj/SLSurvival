;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiterunCarriage8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
getowningquest().setstage(1000)

ActorUtil.ClearPackageOverride(slave)
slave.evaluatePackage()

myScripts.SLV_PikeMoodChange(false,1)

Actor follower
if MCMMenu.slavefollower
	follower = MCMMenu.slavefollower
else
	follower = slave
endif

follower.moveto(Dog)
myScripts.SLV_Play2Sex(follower,Dog , "", true)
SLV_UseSlaverAsSlave.setValue(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property MCMMenu auto

GlobalVariable Property SLV_UseSlaverAsSlave auto
SLV_Utilities Property myScripts auto 
Actor Property Dog Auto  
Actor Property Slave Auto  
