;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaFightRezzing1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
ReanimateCorpse.RemoteCast(akSpeaker, akSpeaker, SLV_DeadPlayer.getActorRef())
Utility.wait(1.0)
ReanimateCorpse.RemoteCast(akSpeaker, akSpeaker, SLV_DeadPlayer.getActorRef())
Utility.wait(1.0)
ReanimateCorpse.RemoteCast(akSpeaker, akSpeaker, SLV_DeadPlayer.getActorRef())
Utility.wait(1.0)
ReanimateCorpse.RemoteCast(akSpeaker, akSpeaker, SLV_DeadPlayer.getActorRef())
Utility.wait(1.0)
ReanimateCorpse.RemoteCast(akSpeaker, akSpeaker, SLV_DeadPlayer.getActorRef())
Utility.wait(1.0)
ReanimateCorpse.RemoteCast(akSpeaker, akSpeaker, SLV_DeadPlayer.getActorRef())
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Spell Property ReanimateCorpse Auto 
ReferenceAlias Property SLV_DeadPlayer Auto
