;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0405D37F Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
pFDS.Persuade(akSpeaker)
; The _SLS_LicInspFgPack force-greet stays valid while _SLS_LicTownViolation is 1, so a won
; persuade must clear it or the enforcer re-greets in an endless loop. By FormID because adding
; a CK property to this fragment would need an ESP edit; recomputed on next town entry.
(Game.GetFormFromFile(0x058C90, "SL Survival.esp") as GlobalVariable).SetValueInt(0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

FavorDialogueScript Property pFDS  Auto  
