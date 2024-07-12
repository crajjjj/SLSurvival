;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining2_17 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(8000)
GetOwningQuest().SetStage(8500)

actor[] sexActors = new actor[2]
sexActors[0] = Game.GetPlayer()
sexActors[1] = akSpeaker

myScripts.SLV_PlaySexAnimationSynchron(sexActors,"FunnyBizness Molag Snuff Vamp","Sex", true)

int counter = 0
Game.GetPlayer().RemoveSpell(WerewolfImmunity)
While (Game.GetPlayer().HasMagicEffect(DisDamageHealthVampire)) == False && counter < 20
	Game.GetPlayer().AddSpell(DiseaseSanguinareVampiris, abVerbose = False)
	counter = counter + 1
EndWhile
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Spell Property DiseaseSanguinareVampiris Auto
MagicEffect Property DisDamageHealthVampire Auto
Spell Property WerewolfImmunity Auto
