;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CelebrateWelcomeMaven Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_SexlabStripNPC(akSpeaker)
myScripts.SLV_SexlabStripNPC(JarlMorthal.getActorRef())

; Slave or free, we take the weapons and shields away
Weapon EW = akSpeaker.GetEquippedWeapon()
if EW != None
	akSpeaker.UnEquipitem(EW, True, True)
endif
Armor ES = akSpeaker.GetEquippedShield()
if ES != None
	akSpeaker.UnEquipitem(ES, True, True)
endif
akSpeaker.RemoveFromFaction(SlaverunMasterFaction )
myScripts.SLV_enslavementNPC(akSpeaker)

; Slave or free, we take the weapons and shields away
EW = JarlMorthal.getActorRef().GetEquippedWeapon()
if EW != None
	JarlMorthal.getActorRef().UnEquipitem(EW, True, True)
endif
ES = JarlMorthal.getActorRef().GetEquippedShield()
if ES != None
	JarlMorthal.getActorRef().UnEquipitem(ES, True, True)
endif
myScripts.SLV_enslavementNPC(JarlMorthal.getActorRef())

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()

ActorUtil.AddPackageOverride(akSpeaker, UseDragonsreachCross1 ,100)
akSpeaker.evaluatePackage()

ActorUtil.ClearPackageOverride(JarlMorthal.getactorref())
JarlMorthal.getactorref().evaluatePackage()

ActorUtil.AddPackageOverride(JarlMorthal.GetActorRef(), UseDragonsreachCross2 ,100)
JarlMorthal.GetActorRef().evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property JarlMorthal auto
Faction Property SlaverunMasterFaction auto
SLV_Utilities Property myScripts auto

Package Property UseDragonsreachCross1 Auto
Package Property UseDragonsreachCross2 Auto
