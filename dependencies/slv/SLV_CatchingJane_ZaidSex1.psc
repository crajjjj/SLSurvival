;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CatchingJane_ZaidSex1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_Play2Sex( SLV_Ivana.getActorRef(), SLV_Constantine.getActorRef(),"Blowjob", true)
Utility.wait(2.0)

myScripts.SLV_PlaySex2Synchron( Game.GetPlayer(), SLV_Jane.getActorRef(),"Lesbian, Sex", true)
SLV_SexIsRunning.setvalue(0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
debug.SendAnimationEvent(Game.getPlayer(), "ZazAPC058")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_SexIsRunning Auto 

ReferenceAlias Property SLV_Jane Auto
ReferenceAlias Property SLV_Ivana Auto
ReferenceAlias Property SLV_Constantine Auto
