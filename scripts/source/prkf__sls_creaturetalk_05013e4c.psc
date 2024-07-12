;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname PRKF__SLS_CreatureTalk_05013E4C Extends Perk Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
;/
;Reset first in case it didn't terminate right last time
(CreatureForceGreet.GetNthAlias(0) as ReferenceAlias).Clear()
CreatureForceGreet.Stop()
(akTargetRef as Actor).EvaluatePackage()

Debug.Notification(akTargetRef.GetBaseObject().GetName() + " arousal level: " + (akTargetRef as Actor).GetFactionRank(Game.GetFormFromFile(0x03FC36, "SexLabAroused.esm") as Faction))

; begin
TalkingCreature.ForceRefTo(akTargetRef)
CreatureForceGreet.Start()
ActorUtil.AddPackageOverride((akTargetRef as Actor), _SLS_CreatureForceGreetPackage, 100) ; For Untamed
(akTargetRef as Actor).EvaluatePackage()
Util.SetupCreatureSex(akTargetRef as Actor)
Debug.Notification("Weighing them in your hands you guess his balls are " + Util.GetCumFullnessString(akTargetRef as Actor))

; Remove papyrusutil package later just in case.
Utility.Wait (3.0)
ActorUtil.RemovePackageOverride((akTargetRef as Actor), _SLS_CreatureForceGreetPackage)
/;

Friend.Fondle(akTargetRef as Actor)

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SLS_AnimalFriend Property Friend Auto
