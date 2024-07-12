;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SuccubusEnd Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;StorageUtil.SetIntValue(Game.getPlayer(), "PSQ_SpellON", 1)
;SendModEvent("SLHisSuccubus")
;ModEvent.Send(ModEvent.Create("HoSLDD_GivePlayerPowers"))

Prisoner.GetActorRef().disable()
Prisoner.GetActorRef().resurrect()
;Prisoner.GetActorRef().disable()

Utility.wait(3.0)
Spell succubus = Game.GetFormFromFile(0x001241, "PSQ PlayerSuccubusQuest.esm") as Spell
succubus.cast(Game.getPlayer())

myUtilities.SLV_miniLevelUp()

GetOwningQuest().SetObjectiveCompleted(3500)
GetOwningQuest().SetStage(9500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myUtilities auto
ReferenceAlias Property Prisoner Auto 
