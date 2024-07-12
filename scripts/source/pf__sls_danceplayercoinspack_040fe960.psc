;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PF__SLS_DancePlayerCoinsPack_040FE960 Extends Package Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(Actor akActor)
;BEGIN CODE
;Game.GetPlayer().AddItem(Game.GetFormFromFile(0xf, "Skyrim.esm"), 10)
;/
(Game.GetFormFromFile(0xFC90D, "SL Survival.esp") as _SLS_Dance).ThrowGold()
akActor.RemoveFromFaction(Game.GetFormFromFile(0x0FE961, "SL Survival.esp") as Faction)
Debug.Notification(akActor.GetLeveledActorBase().GetName() + ": Here you go honey")
akActor.EvaluatePackage()
/;
(Game.GetFormFromFile(0xFC90D, "SL Survival.esp") as _SLS_Dance).GetItem(akActor)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
