;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__040AC91F Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
(Game.GetFormFromFile(0x0420BB, "SL Survival.esp") as _SLS_LicenceUtil).AwardLicence("magic", DoMessagebox = false)
Game.GetPlayer().RemoveItem(Game.GetFormFromFile(0xf, "Skyrim.esm"), (Game.GetFormFromFile(0x0AC928, "SL Survival.esp") as GlobalVariable).GetValueInt())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
