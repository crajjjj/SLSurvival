;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiverwoodAlvor7 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2000)
getowningquest().setstage(3500)

if ThisMenu.SkipScenes
	return
endif

Game.getPlayer().additem(Whip)
akSpeaker.SetOutfit(SlaveOutfit)

Int newItems = newItemEnabling.Length
While newItems 
	newItems -= 1
	newItemEnabling[newItems].Enable()
EndWhile

Actor AlvorAct = Alvor.getRef() as Actor
ActorUtil.AddPackageOverride(akSpeaker, useCross ,100)
akSpeaker.evaluatePackage()
ActorUtil.AddPackageOverride(AlvorAct , followplayer ,100)
AlvorAct.evaluatePackage()

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
PunishScene.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ObjectReference[] Property newItemEnabling Auto
Scene Property PunishScene  Auto  
Weapon Property Whip Auto
ReferenceAlias Property Alvor Auto
Package Property followplayer Auto
Package Property useCross Auto
Outfit Property SlaveOutfit auto
SlV_MCMMenu Property ThisMenu auto
