;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 9
Scriptname TIF_Dflow_0A020E9A Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_7
Function Fragment_7(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Tool.SexOral(akspeaker)
int n = 0
While (tool.insex()  &&  n < 60)
       Utility.wait(3)
      n += 1
Endwhile
libs.ManipulateGenericDeviceByKeyword(playerref, Libs.Zad_Deviousgag, True)
(GetOwningQuest() as _DDeal).Triggered = True
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
