;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0007A50F Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
_df_follower.DialogDismissFollower(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

; Use _df_follower.DialogDismissFollower(akSpeaker)
_DflowFollowerController Property _df_follower Auto

Quest Property pDialogueFollower Auto  

Faction Property DismissedFollowerFaction Auto  
