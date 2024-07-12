;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaShowSex_2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor[] sexActors
int count =  SLV_ColosseumBeastsNumber.getValue() as int
if count>= 4
	sexActors = new actor[5]
else
	sexActors = new actor[4]
endif

sexActors[0] =Game.getplayer()
sexActors[1] = SLV_Animal3.getActorRef() 

if count>= 4
	sexActors[2] = SLV_Animal4.getActorRef()
	sexActors[3] = SLV_Animal1.getActorRef()
	sexActors[4] = SLV_Animal2.getActorRef()
else
	sexActors[2] = SLV_Animal1.getActorRef()
	sexActors[3] = SLV_Animal2.getActorRef()
endif

bool splitsex = false
if count <= 4
	splitsex = true
endif
myScripts.SLV_CreatureGangbang(sexActors, "", splitsex )
SLV_SexIsRunning.setvalue(0)

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto 
GlobalVariable Property SLV_ColosseumBeastsNumber Auto 

SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_Animal1 Auto
ReferenceAlias Property SLV_Animal2 Auto
ReferenceAlias Property SLV_Animal3 Auto
ReferenceAlias Property SLV_Animal4 Auto


