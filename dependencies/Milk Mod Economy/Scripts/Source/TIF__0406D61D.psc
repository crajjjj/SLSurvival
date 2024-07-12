;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0406D61D Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
AKSpeaker.AddToFaction(Game.GetFormFromFile(0x6D620, "MilkModNEW.esp") as faction)
AKSpeaker.ShowBarterMenu()
utility.wait(1)
AKSpeaker.RemoveFromFaction(Game.GetFormFromFile(0x6D620, "MilkModNEW.esp") as faction)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
