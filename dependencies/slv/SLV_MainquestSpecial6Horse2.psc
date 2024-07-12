;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial6Horse2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if MCMMenu.skipCreatureSex	
	;Game.FadeOutGame(false, true, 5.0, 10.0)
	;debug.messagebox("When you regain consciousness, you body hurts as hell and you a drenched in cum.")
	debug.notification("Creature sex was skipped")
	return
endif

ActorUtil.AddPackageOverride(Horse2.getActorRef(), SLV_FollowPlayer ,100)
Horse2.getActorRef().evaluatePackage()

if Game.getplayer().isinfaction(zbfSlaveFaction)
	myScripts.SLV_PlaySex2Synchron(Game.GetPlayer(),Horse2.getActorRef() , "Anal", true)
elseif MCMMenu.slavefollower
	myScripts.SLV_PlaySex2Synchron(MCMMenu.slavefollower,Horse2.getActorRef() , "Anal", true)
endif

ActorUtil.ClearPackageOverride(Horse2.getActorRef())
Horse2.getActorRef( ).evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property Horse2 Auto 
SLV_MCMMenu Property MCMMenu Auto
Package Property SLV_FollowPlayer Auto
Faction Property zbfSlaveFaction Auto
