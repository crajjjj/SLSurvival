;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 11
Scriptname TIF_Dflow_0A014176 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_8
Function Fragment_8(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;WARNING: Unable to load fragment source from function Fragment_8 in script TIF_DFlow_08003E08
;Source NOT loaded
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
libs.removeDevice(PlayerRef, D , DE, libs.zad_DeviousPiercingsNipple, skipevents = false, skipmutex = true)
libs.removeDevice(PlayerRef, D2 , DE2, libs.zad_DeviousPiercingsNipple, skipevents = false, skipmutex = true)
float a = Debt.getvalue()

GetowningQuest().reset()
GameQ.reset()
GameQ.setstage(10)
Utility.wait(2)
a = a*1.5+200
Debt.setvalue(a)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  

Actor Property PlayerRef  Auto  

Armor Property D  Auto  

Armor Property DE  Auto  

Armor Property D2  Auto  

Armor Property DE2  Auto  


Quest Property GameQ  Auto  
_Dftools property tool auto

GlobalVariable Property TEMP  Auto  
GlobalVariable Property debt  Auto  
