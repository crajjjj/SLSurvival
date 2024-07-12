;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiterunDeliverPlugs8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
getowningquest().setstage(1000)

Game.GetPlayer().RemoveItem(DeviousItem1,5)
Game.GetPlayer().RemoveItem(DeviousItem2,5)
akSpeaker.AddItem(DeviousItem1,5)
akSpeaker.AddItem(DeviousItem2,5)

if ThisMenu.skipCreatureSex
	Game.FadeOutGame(false, true, 5.0, 10.0)
	debug.messagebox("When you regain consciousness, you body hurts as hell and you a drenched in cum.")
else
	myScripts.SLV_Play2Sex(Game.GetPlayer(),Dog, "", true)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
Actor Property Dog  Auto  
SLV_MCMMenu Property ThisMenu auto
Armor Property DeviousItem1  Auto 
Weapon Property DeviousItem2  Auto 
