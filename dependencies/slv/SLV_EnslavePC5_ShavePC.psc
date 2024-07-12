;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_EnslavePC5_ShavePC Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
shaveScripts.Shave(Game.GetPlayer())

;shaveScripts.ShaveNPC(SLV_Valentina.getactorref())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_HeadShaving Property shaveScripts auto
ReferenceAlias Property SLV_Valentina Auto 

