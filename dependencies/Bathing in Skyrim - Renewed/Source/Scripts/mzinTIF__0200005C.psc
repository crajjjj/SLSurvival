;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname mzinTIF__0200005C Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if UI.IsMenuOpen("Dialogue Menu")
    UI.InvokeString("Dialogue Menu", "_global.skse.CloseMenu", "Dialogue Menu")
endIf

BatheQuest.TryWashActor(akSpeaker, None)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

mzinBatheQuest Property BatheQuest Auto
