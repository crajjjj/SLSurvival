;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiterunVampireCattle3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
GetOwningQuest().SetStage(1000)

actor[] sexActors = new actor[2]
sexActors[0] = Game.GetPlayer()
sexActors[1] = akSpeaker

myScripts.SLV_PlaySexAnimationSynchron(sexActors,"FunnyBizness Molag Necro Miss","Sex", true)

;Game.GetPlayer().AddSpell(DiseaseSanguinareVampiris, abVerbose = False)
Game.GetPlayer().RemoveSpell(WerewolfImmunity)
While (Game.GetPlayer().HasMagicEffect(DisDamageHealthVampire)) == False
	Game.GetPlayer().AddSpell(DiseaseSanguinareVampiris, abVerbose = False)
EndWhile
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Spell Property DiseaseSanguinareVampiris Auto
MagicEffect Property DisDamageHealthVampire Auto
Spell Property WerewolfImmunity Auto
