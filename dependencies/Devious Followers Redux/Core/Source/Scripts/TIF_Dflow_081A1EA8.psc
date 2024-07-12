;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname TIF_Dflow_081A1EA8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
libs.equipDevice(libs.PlayerRef, I , R, libs.zad_DeviousCollar, skipevents = false, skipmutex = true)

If _Dtats.getValue() > 0
        Int t = Utility.RandomInt(1, _Dtats.getvalue() as int)
        int n = 0
       while n < t
              SendModEvent("RapeTattoos_addTattoo")
              Utility.wait(2)
              n += 1
       endwhile

endif
(GetowningQuest() as QF__Gift_09000D62).tool.ResumeALL()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
libs.ManipulateGenericDeviceByKeyword(PlayerRef,libs.zad_DeviousCollar,false)
Utility.wait(2)
libs.ManipulateGenericDeviceByKeyword(PlayerRef,libs.zad_Deviousarmcuffs,false)
Utility.wait(2)
libs.ManipulateGenericDeviceByKeyword(PlayerRef,libs.zad_Deviouslegcuffs,false)
Utility.wait(2)
libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousYoke,False)
Utility.wait(2)
libs.ManipulateGenericDeviceByKeyword(libs.Playerref, libs.zad_DeviousArmbinder,False)
Utility.wait(2)
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
