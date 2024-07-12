;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname TIF_Dflow_0B01FE5A Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_7
Function Fragment_7(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Tool.Sex(akspeaker)
int n = 0
While (tool.insex()  &&  n < 60)
       Utility.wait(3)
      n += 1
Endwhile
if Belt
	libs.ManipulateGenericDeviceByKeyword(playerref, Libs.Zad_Deviousbelt, True)
elseif Harness	
	libs.ManipulateGenericDeviceByKeyword(playerref, Libs.Zad_Deviousharness, True)
else
	libs.ManipulateGenericDeviceByKeyword(playerref, Libs.Zad_Deviousbelt, True)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Belt = libs.ManipulateGenericDeviceByKeyword(playerref, Libs.Zad_Deviousbelt, False)
Harness = libs.ManipulateGenericDeviceByKeyword(playerref, Libs.Zad_Deviousharness, False)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  

Actor Property PlayerRef  Auto  

Armor Property D  Auto  

Armor Property DE  Auto  


Quest Property GameQ  Auto  
_Dftools property tool auto

GlobalVariable Property TEMP  Auto  
Bool Belt
Bool Harness