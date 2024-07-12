;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSoftEvent5 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;Game.GetPlayer().equipitem(Game.GetFormFromFile(0x343F2, "MilkModNEW.esp"))

int MME_AddMilkMaid = ModEvent.Create("MME_AddMilkMaid")
ModEvent.PushForm(MME_AddMilkMaid, Game.getPlayer())
ModEvent.Send(MME_AddMilkMaid)

Utility.wait(5.0)

int MME_SlaveToggle = ModEvent.Create("MME_SlaveToggle")
ModEvent.PushForm(MME_SlaveToggle,  Game.getPlayer())
ModEvent.Send(MME_SlaveToggle)
;EndIf
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
