;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CelebrateRoastSex Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_SexlabStripNPC(Elisif.getActorRef())
; Slave or free, we take the weapons and shields away
Weapon EW = Elisif.getActorRef().GetEquippedWeapon()
if EW != None
	Elisif.getActorRef().UnEquipitem(EW, True, True)
endif
Armor ES = Elisif.getActorRef().GetEquippedShield()
if ES != None
	Elisif.getActorRef().UnEquipitem(ES, True, True)
endif
myScripts.SLV_enslavementNPC(Elisif.getActorRef())

ActorUtil.AddPackageOverride(Game.GetPlayer(), CelebrateRoasting ,100)
Game.GetPlayer().evaluatePackage()
actor[] sexActors = new actor[2]
sexActors[0] = Elisif.getActorRef()
sexActors[1] = akSpeaker 

myScripts.SLV_Play2Sex( Elisif.getActorRef(),akSpeaker, "Anal", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto  
ReferenceAlias Property Elisif auto

Package Property CelebrateRoasting Auto
