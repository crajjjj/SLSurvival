;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaShowSex_3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor[] sexActors
int count =  SLV_ColosseumBeastsNumber.getValue() as int
if count>= 8
	sexActors = new actor[5]
elseif  count>= 7
	sexActors = new actor[4]
elseif  count>= 6
	sexActors = new actor[3]
else
	sexActors = new actor[2]
endif

sexActors[0] =Game.getplayer()
sexActors[1] = SLV_Animal5.getActorRef() 

if count>= 6
	sexActors[2] = SLV_Animal6.getActorRef()
endif
if count>= 7
	sexActors[3] = SLV_Animal7.getActorRef()
endif
if count>= 8
	sexActors[4] = SLV_Animal8.getActorRef()
endif

myScripts.SLV_CreatureGangbang(sexActors, "", false)
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
ReferenceAlias Property SLV_Animal5 Auto
ReferenceAlias Property SLV_Animal6 Auto
ReferenceAlias Property SLV_Animal7 Auto
ReferenceAlias Property SLV_Animal8 Auto


