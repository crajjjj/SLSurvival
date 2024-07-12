;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSoftEvent11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;SendModEvent("yps-LipstickEvent", "Dark Red", 0x8b0000)  
SendModEvent("yps-LipstickEvent", "Black" , 0)  
Utility.wait(2.0)
    
SendModEvent("yps-EyeshadowEvent","Black" , 0)    
; apply makeup: send name of color as string (e.g. "red"), and ColorRGBCode as a 0xRRGGBB value.
Utility.wait(2.0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
