;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiteWedding1_29 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if ThisMenu.SlaveShaving  == true
	mainquest.hairshaveble= true
else
	mainquest.hairshaveble= false
endif

if Game.GetModByName("SlaveTats.esp")!= 255 && ThisMenu.SlaveTatoos == true
	mainquest.slaveTatoos = true
else
	mainquest.slaveTatoos = false  
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_SoftDependency Property mainquest auto
SLV_MCMMenu Property ThisMenu auto
