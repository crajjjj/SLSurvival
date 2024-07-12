;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_WhiterunEnslaveDominate1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
; Slave or free, we take the weapons and shields away
Weapon EW = akSpeaker.GetEquippedWeapon()
if EW != None
	akSpeaker.UnEquipitem(EW, True, True)
endif
Armor ES = akSpeaker.GetEquippedShield()
if ES != None
	akSpeaker.UnEquipitem(ES, True, True)
endif
akSpeaker.AddToFaction(SlaverunSlaveFaction)
akSpeaker.SetOutfit(SlaveOutfit)

myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker, "", false)

GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(1000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto 
Faction Property SlaverunSlaveFaction auto
Outfit Property SlaveOutfit auto
