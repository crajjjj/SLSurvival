;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiverwoodSlavery6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(1500)
if game.getplayer().IsInFaction(SlaverunSlaveFaction)
	GetOwningQuest().SetStage(2000)
else
	GetOwningQuest().SetStage(2500)
endif

Actor delphineact = delphine.getRef() as Actor
delphineact.moveto(akSpeaker)

myScripts.SLV_enslavementNPC(delphineact)
myScripts.SLV_Play2Sex(delphine.getActorRef(),akSpeaker ,"Blowjob", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property delphine auto
Faction Property SlaverunSlaveFaction auto
