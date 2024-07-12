;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 22
Scriptname QF__DflowGames_0A0110DC Extends Quest Hidden

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SceneYOU
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SceneYOU Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Follower
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Follower Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Jarl
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Jarl Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
libs.RemoveDevice(libs.PlayerRef, CollarI , CollarR, libs.zad_DeviousCollar, skipevents = false, skipmutex = true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
Q.Reset()
Q.SetStage(10)
QQ.Debtm((QQ.Debt.Getvalue()*0.5))
QQ.Etimerreset()
QQ.ReduceBoredom(3)
Reset()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN CODE
Q.Reset()
Q.SetStage(10)
QQ.Debtm((QQ.Debt.Getvalue()*0.5))
QQ.Etimerreset()
QQ.ReduceBoredom(5)
Reset()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
QQ.ReduceBoredom()
Q.Reset()
Q.SetStage(10)
Libs.ManipulateGenericDeviceByKeyword(libs.PlayerRef,libs.zad_Deviousgag,false)
QQ.ETimerReset()
Reset()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
libs.RemoveDevice(libs.PlayerRef, BinderI , BinderR, libs.zad_DeviousArmbinder, skipevents = false, skipmutex = true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
Q.SetStage(200)
libs.EquipDevice(libs.PlayerRef, HarnI , HarnR, libs.zad_DeviousHarness, skipevents = false, skipmutex = true)
libs.EquipDevice(libs.PlayerRef, BinderI , BinderR, libs.zad_DeviousArmbinder, skipevents = false, skipmutex = true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
libs.removeDevice(libs.PlayerRef, HI , HR, libs.zad_DeviousHarness, skipevents = false, skipmutex = true)
libs.removeDevice(libs.PlayerRef, HGI , HGR, libs.zad_Deviousgag, skipevents = false, skipmutex = true)
libs.removeDevice(libs.PlayerRef, HTI , HTR, libs.zad_DeviousPlugAnal, skipevents = false, skipmutex = true)
libs.removeDevice(libs.PlayerRef, HOOFI , HOOFR, libs.zad_DeviousGloves, skipevents = false, skipmutex = true)
setstage(0)
reset()
QQ.ReduceBoredom()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
libs.removeDevice(libs.PlayerRef, HOOFI , HOOFR, libs.zad_DeviousGloves, skipevents = false, skipmutex = true)
Utility.wait(5)
libs.equipDevice(libs.PlayerRef, HTI , HTR, libs.zad_DeviousPlugAnal, skipevents = false, skipmutex = true)
libs.equipDevice(libs.PlayerRef, HI , HR, libs.zad_DeviousHarness, skipevents = false, skipmutex = true)
libs.equipDevice(libs.PlayerRef, HGI , HGR, libs.zad_Deviousgag, skipevents = false, skipmutex = true)

Utility.wait(1)
libs.equipDevice(libs.PlayerRef, HOOFI , HOOFR, libs.zad_DeviousGloves, skipevents = false, skipmutex = true)

Armor a = PlayerRef.GetWornForm(0x00000002) as Armor
Armor b = PlayerRef.GetWornForm(0x00000004) as Armor
Armor c = PlayerRef.GetWornForm(0x00000008) as Armor
Armor d = PlayerRef.GetWornForm(0x00000080) as Armor


If a && !a.HasKeyword(zad_lockable)
PlayerRef.UnequipItem(a)

endif

If c && !c.HasKeyword(zad_lockable)
PlayerRef.UnequipItem(c)
endif

If d && !d.HasKeyword(zad_lockable)
PlayerRef.UnequipItem(d)
endif

If b && !b.HasKeyword(zad_lockable)
PlayerRef.UnequipItem(b)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
qq.tool.UnequipGear()
libs.equipDevice(libs.PlayerRef, Xlibs2.zadx_PetSuit_Black_Inventory, xlibs2.zadx_PetSuit_Black_Rendered, libs.zad_DeviousPetSuit, skipevents = false, skipmutex = true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
libs.RemoveDevice(libs.PlayerRef, HarnI , HarnR, libs.zad_DeviousHarness, skipevents = false, skipmutex = true)
libs.EquipDevice(libs.PlayerRef, CollarI , CollarR, libs.zad_DeviousCollar, skipevents = false, skipmutex = true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Function AdvanceCommentTimer(Float seconds)

    seconds /= (86400.0/20.0) ; Convert seconds to game time in days... at 20x normal time-rate ... would be better if I got the time rate properly ... but even then player can change before timer is used.
    Float current = _DFGameCommentTimer.GetValue()
    Float now = Utility.GetCurrentGameTime()
    Float offset = now - current
    Float adjustBy = seconds + offset
    
    ; While the Get above defeats atomicity, I'm hoping this call will ensure that other code gets the updated value and doesn't hold onto the old one.
    _DFGameCommentTimer.Mod(adjustBy)

EndFunction

Armor Property HI  Auto  

Armor Property HR  Auto  

Armor Property HGI  Auto  

Armor Property HGR  Auto  

Armor Property HTI  Auto  

Armor Property HTR  Auto  
  

Armor Property HarnR  Auto  

Armor Property HarnI  Auto  

Armor Property CollarR  Auto  

Armor Property CollarI  Auto  
Armor Property BinderR  Auto  

Armor Property BinderI  Auto  
Armor Property HOOFR  Auto  

Armor Property HOOFI  Auto  

zadlibs Property  libs Auto  

actor Property Playerref auto

keyword Property zad_lockable auto

Quest Property Q  Auto  
QF__Gift_09000D62 Property QQ auto
  

zadxlibs2 Property xlibs2  Auto  

; this simply didn't work... tests seemed to use old stale values. Possibly caused by script missing Conditional tag.
; Wrote global replacement before noticing the likely error/cause.
Float Property CommentTimer  Auto  Conditional

GlobalVariable Property _DFGameCommentTimer Auto

