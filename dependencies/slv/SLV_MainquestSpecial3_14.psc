;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial3_14 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(500)
GetOwningQuest().SetStage(1000)

ActorUtil.ClearPackageOverride(slave)
slave.evaluatePackage()

; Slave or free, we take the weapons and shields away
Weapon EW = akSpeaker.GetEquippedWeapon()
if EW != None
	akSpeaker.UnEquipitem(EW, True, True)
endif
Armor ES = akSpeaker.GetEquippedShield()
if ES != None
	akSpeaker.UnEquipitem(ES, True, True)
endif
myScripts.SLV_enslavementNPC(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Actor Property slave Auto
SLV_Utilities Property myScripts auto