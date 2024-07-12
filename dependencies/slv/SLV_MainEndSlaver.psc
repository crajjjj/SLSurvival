;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainEndSlaver Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_SexlabStripNPC(game.getplayer())

myScripts.SLV_EndPlayerSlaver()

slaveprogress.StartProgressForFreeWoman()
SLV_FactionFreeSubmissive.setValue(SLV_FactionSlaverSubmissive.getValue())
myScripts.SLV_FreeSubmissiveChange(false,5)

SLV_WhiterunTasksDone.setvalue(0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
SLV_EnslavingProgress Property slaveprogress auto

GlobalVariable Property SLV_FactionFreeSubmissive auto
GlobalVariable Property SLV_FactionSlaverSubmissive auto
GlobalVariable Property SLV_WhiterunTasksDone auto

