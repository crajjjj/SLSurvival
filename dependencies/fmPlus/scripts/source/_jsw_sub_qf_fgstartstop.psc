;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 21
scriptName	_JSW_SUB_QF_FGStartStop	extends	quest	hidden

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
; stage 10
	if theRef
		theRef.ForceRefTo(playerRef)
	endIf
	Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN CODE
; stage 20
	Reset()
	Stop()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property theRef Auto

actor	Property	playerRef	Auto

;/	Three properties:
	theRef		: leave null if the quest doesn't use an alias
	playerRef	: should be self-evident
	clearAlias	: bool for whether or not to clear the alias at shutdown.  If the alias is always the player, set to false.   If it can
					change each time the quest starts, set to true.  If the quest doesn't have an alias, set to false. /;
