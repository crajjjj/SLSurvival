;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SolitudeBardsCollege9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(4000)
getowningquest().setstage(4500)

ActorUtil.AddPackageOverride(Ildi.getActorRef(), SLV_Idle,100)
Ildi.getActorRef().evaluatePackage()

Form ArmorOrClothes = Ildi.getActorRef().GetWornForm(Armor.GetMaskForSlot(32)) 
if ArmorOrClothes 
	Ildi.getActorRef().RemoveItem(ArmorOrClothes , 1)
endif
myScripts.SLV_SexlabStripNPC(Game.GetPlayer())
myScripts.SLV_SexlabStripNPC(Ildi.getActorRef())

if ThisMenu.SkipScenes
	return
endif

Giraurd.getActorRef().addItem(Whip)
Viarmo.getActorRef().addItem(Whip)

SendModEvent("dhlp-Suspend")

game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

bool equipGag = true
bool equipPlugs = true
bool equipHarness = true
bool equipBelt = true
bool equipBra = true
bool equipCollar = true
bool equipCuffs = true
bool equipArmbinder = true
bool equipYoke = true
bool equipBlindfold = true
bool equipNPiercings = true
bool equipVPiercings = true
bool equipBoots = true
bool equipGloves = true
bool equipCorset = true

myScripts.SLV_DeviousUnEquipActor(Game.GetPlayer(),true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)
myScripts.SLV_DeviousUnEquipActor(Ildi.getActorRef(),true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)
;Utility.wait(2.0)

Punishment.Start()
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property Punishment  Auto 
SLV_Utilities Property myScripts auto
SlV_MCMMenu Property ThisMenu auto
Package Property SLV_Idle Auto
ReferenceAlias Property Ildi Auto 
ReferenceAlias Property Giraurd Auto 
ReferenceAlias Property Viarmo Auto
Weapon Property Whip Auto
