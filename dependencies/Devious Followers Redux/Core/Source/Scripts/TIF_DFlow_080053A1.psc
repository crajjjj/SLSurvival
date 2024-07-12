;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF_DFlow_080053A1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; This was set to only trigger on _DFlow
; stage == -1, which made < 100 redundant
; which is correct?
;
libs.ManipulateGenericDeviceByKeyword(PlayerRef,libs.zad_DeviousCollar,false)
libs.ManipulateGenericDeviceByKeyword(PlayerRef,libs.zad_Deviousarmcuffs,false)
libs.ManipulateGenericDeviceByKeyword(PlayerRef,libs.zad_Deviouslegcuffs,false)
libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousYoke,False)
libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousArmbinder,False)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If _Dtats.getValue() > 0
    Int toAdd = Utility.RandomInt(1, _Dtats.getvalue() as int)
    Int nn = 0
    While nn < toAdd
        nn += 1
        SendModEvent("RapeTattoos_addTattoo")
        Utility.wait(2)
    EndWhile
EndIf
Utility.wait(2)
; Equip prisoner chains
libs.equipDevice(libs.PlayerRef, I , R, libs.zad_DeviousCollar, skipevents = false, skipmutex = true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

QF__Gift_09000D62 Property q  Auto  

zadlibs Property libs  Auto  
Actor Property PlayerRef  Auto  
Armor Property Collar  Auto  
Armor Property Mitts  Auto  
Armor Property boots  Auto
Message Property msg  Auto  
GlobalVariable Property FreedomCost Auto

MiscObject Property Gold001  Auto  

GlobalVariable Property _Dtats  Auto  

GlobalVariable Property SSO  Auto  

GlobalVariable Property _DflowEndlessMode Auto  
Armor Property I  Auto
Armor Property R  Auto
