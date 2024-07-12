;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_EnforcerSex4 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
String AnimationTags = "Sex"
if MCMMenu.AggressiveFuckForSlaves
	AnimationTags = AnimationTags + ",Aggressive"
endif
if MCMMenu.AnalFuckForSlaves
	AnimationTags = AnimationTags + ",Anal"
endif

myScripts.SLV_PlaySex2Synchron(Game.getplayer(), SLV_Raper1.getActorRef(), AnimationTags , true)
SLV_SexIsRunning.setvalue(0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_SexIsRunning Auto 
ReferenceAlias Property SLV_Raper1 Auto
SLV_MCMMenu Property MCMMenu Auto


