;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname mzinTIF__02000058 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
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
