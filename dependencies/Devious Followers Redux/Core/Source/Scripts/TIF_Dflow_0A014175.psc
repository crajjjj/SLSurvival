;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 12
Scriptname TIF_Dflow_0A014175 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_11
Function Fragment_11(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
libs.removeDevice(PlayerRef, D , DE, libs.zad_DeviousPiercingsNipple, skipevents = false, skipmutex = true)
libs.removeDevice(PlayerRef, D2 , DE2, libs.zad_DeviousStraitJacket, skipevents = false, skipmutex = true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
float startDebt = Debt.GetValue()
GetowningQuest().Reset()
GameQ.Reset()
GameQ.SetStage(10)
Q.ETimerReset()

Utility.Wait(2)

Debt.SetValue(startDebt / 2.0)
Q.ReduceBoredom()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

zadlibs Property libs  Auto  
QF__Gift_09000D62 Property q  Auto  


Actor Property PlayerRef  Auto  

Armor Property D  Auto  

Armor Property DE  Auto  

Armor Property D2  Auto  

Armor Property DE2  Auto  


Quest Property GameQ  Auto  
_Dftools property tool auto

GlobalVariable Property TEMP  Auto  
GlobalVariable Property debt  Auto  
