;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__05024808 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
StorageUtil.UnSetIntValue(akSpeaker, "SLS_Begging_NpcWants")
Init.BegSwallowDeal = 0
Debug.Notification("He tosses a handful of coins at your feet")
Debug.SendAnimationEvent(akSpeaker, "IdleTake")
_SLS_TossCoinsMarker.Play(PlayerRef)
ObjectReference Coins
Int i = 0
While i < 5
	_SLS_TossedCoinsMarker.MoveTo(PlayerRef, Utility.RandomInt(-128, 128) * Math.Sin(PlayerRef.GetAngleZ()), Utility.RandomInt(-128, 128) * Math.Cos(PlayerRef.GetAngleZ()), PlayerRef.GetHeight() - 20.0)
	Coins = _SLS_TossedCoinsMarker.PlaceAtMe(_SLS_TossedCoins01, 1)
	Coins.SetActorOwner(Player)
	i += 1
EndWhile
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SLS_Init Property Init Auto
Actor Property PlayerRef Auto
ActorBase Property Player Auto
Sound Property _SLS_TossCoinsMarker Auto
MiscObject Property _SLS_TossedCoins01 Auto
ObjectReference Property _SLS_TossedCoinsMarker Auto
