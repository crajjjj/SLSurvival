;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Enslavement33 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if Game.GetModByName("BrandingDeviceOfDoom.esp")!= 255
	mainquest.brandingDevice = true
else
	mainquest.brandingDevice = false
endif

if Game.GetModByName("SlaveTats.esp")!= 255
	mainquest.slaveTatoos = true
else
	mainquest.slaveTatoos = false  
endif

mainquest.slaveTatoos = false 
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_SoftDependency Property mainquest auto
SLV_MCMMenu Property ThisMenu auto
