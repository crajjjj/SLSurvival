;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RavenRockNelothSex1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if !Game.getplayer().isInFaction(SlaverunSlaverFaction) || (SLV_UseSlaverAsSlave.getValue() == 1)
	myScripts.SLV_PlaySex2Synchron( Game.GetPlayer(),SLV_Frea.getActorRef(),"Anal", true)
else
	myScripts.SLV_PlaySex2Synchron( SLV_SlaveFollower.getActorRef(),SLV_Frea.getActorRef(),"Anal", true)
endif
SLV_SexIsRunning.setvalue(0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_SexIsRunning Auto 
ReferenceAlias Property SLV_Frea Auto
GlobalVariable Property SLV_UseSlaverAsSlave auto
ReferenceAlias Property SLV_SlaveFollower Auto
Faction Property SlaverunSlaverFaction Auto


