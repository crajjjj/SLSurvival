;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaFight_Sex3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor[] sexActors
Actor PlayerRef = Game.getPlayer()

Actor[] gangbangsexActors = new actor[4]
int gangbangcount = 0
if SLV_Fighter1 != none
	if SLV_Fighter1.getActorRef() != none
		if !SLV_Fighter1.getActorRef().isDead() && SLV_Fighter1.getActorRef() != PlayerRef
			gangbangsexActors[gangbangcount] = SLV_Fighter1.getActorRef()
			gangbangcount = gangbangcount + 1
		endif
	endif
endif
if SLV_Fighter2 != none
	if SLV_Fighter2.getActorRef() != none
		if !SLV_Fighter2.getActorRef().isDead() && SLV_Fighter2.getActorRef() != PlayerRef
			gangbangsexActors[gangbangcount] = SLV_Fighter2.getActorRef()
			gangbangcount = gangbangcount + 1
		endif
	endif
endif
if SLV_Fighter3 != none
	if SLV_Fighter3.getActorRef() != none
		if !SLV_Fighter3.getActorRef().isDead() && SLV_Fighter3.getActorRef() != PlayerRef
			gangbangsexActors[gangbangcount] = SLV_Fighter3.getActorRef()
			gangbangcount = gangbangcount + 1
		endif
	endif
endif
if SLV_Fighter4 != none
	if SLV_Fighter4.getActorRef() != none
		if !SLV_Fighter4.getActorRef().isDead() && SLV_Fighter4.getActorRef() != PlayerRef
			gangbangsexActors[gangbangcount] = SLV_Fighter4.getActorRef()
			gangbangcount = gangbangcount + 1
		endif
	endif
endif

if gangbangsexActors[3]
	sexActors = new actor[5]
elseif gangbangsexActors[2]
	sexActors = new actor[4]
elseif gangbangsexActors[1]
	sexActors = new actor[3]
else
	sexActors = new actor[2]
endif

if gangbangcount>1
	sexActors[0] = SLV_DeadPlayer.getActorRef()
	sexActors[1] = gangbangsexActors[0]
	if gangbangsexActors[1]
		sexActors[2] = gangbangsexActors[1]
	endif
	if gangbangsexActors[2]
		sexActors[3] = gangbangsexActors[2]
	endif
	if gangbangsexActors[3]
		sexActors[4] = gangbangsexActors[3]
	endif

	myScripts.SLV_Gangbang(sexActors)
else
	;Amputee.SLV_ProgressiveAmputeeActor(SLV_DeadPlayer.getActorRef())	
	;Amputee.SLV_ProgressiveAmputeeActor(SLV_DeadPlayer.getActorRef())

	actor[] sexActors2 = new actor[2]
	sexActors2[0] = SLV_DeadPlayer.getActorRef()
	sexActors2[1] = gangbangsexActors[0]

	;myScripts.SLV_PlaySex2AnimationSynchron(SLV_DeadPlayer.getActorRef(),  gangbangsexActors[0], "FunnyBizness Necrophilia Rape", "Anal", true)
	;myScripts.SLV_PlaySex2AnimationSynchron(SLV_DeadPlayer.getActorRef(),  gangbangsexActors[0], "FunnyBizness Necro Ass Worship", "Anal", true)
	myScripts.SLV_PlaySex2AnimationSynchron(SLV_DeadPlayer.getActorRef(),  gangbangsexActors[0], "FunnyBizness Guro Lust Anal Prone", "Anal", true)
endif

SLV_SexIsRunning.setvalue(0)
;deadPlayer.KillDeadPlayer()

;game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
;game.SetPlayerAIDriven(true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_SexIsRunning Auto 
SLV_Utilities Property myScripts auto
SLV_PrepareDeadPlayer Property deadPlayer Auto

ReferenceAlias Property SLV_DeadPlayer Auto
ReferenceAlias Property SLV_Fighter1 Auto
ReferenceAlias Property SLV_Fighter2 Auto
ReferenceAlias Property SLV_Fighter3 Auto
ReferenceAlias Property SLV_Fighter4 Auto

SLV_Amputee Property Amputee Auto


