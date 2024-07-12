;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF__0007A50B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
_df_follower.DialogDismissFollower(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

quest Property pDialogueFollower  Auto  

Faction Property DismissedFollowerFaction  Auto  
;UDBP 1.0.3 - Restoring generic follower line for vanilla game.

_DflowFollowerController Property _df_follower Auto
