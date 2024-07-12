;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF_Dflow_09095FE6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(GetowningQuest() as _DDeal).Delayhr()
_DFlowDealPMsgFail.show()
libs.ForceEquipDevice(Game.getplayer(), i1, r1, libs.zad_DeviousPiercingsNipple )
libs.ForceEquipDevice(Game.getplayer(), i2, r2, libs.zad_DeviousPiercingsVaginal )
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_DfTools Property tool auto
Message Property _DFlowDealPMsgFail  Auto  

zadlibs Property libs  Auto  

Armor Property I1  Auto  
Armor Property I2  Auto
Armor Property R1  Auto
Armor Property R2  Auto
