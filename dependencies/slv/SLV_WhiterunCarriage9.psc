;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiterunCarriage9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1000)
getowningquest().setstage(2500)
Game.getPlayer().additem(Gold, 1000)

Actor follower
if MCMMenu.slavefollower
	follower = MCMMenu.slavefollower
else
	follower = slave
endif

myScripts.SLV_Play3Sex(follower, akSpeaker,Game.GetPlayer(), "FMM", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property MCMMenu auto
SLV_Utilities Property myScripts auto
Actor Property Slave Auto
MiscObject Property Gold Auto
