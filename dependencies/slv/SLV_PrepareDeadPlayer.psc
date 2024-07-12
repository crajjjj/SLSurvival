Scriptname SLV_PrepareDeadPlayer extends Quest  



Function FakeKillPlayer( ObjectReference GhostPos, ObjectReference BodyPos)
KillDeadPlayer()

Utility.Wait(0.5)
actualizeDeadPlayer()
Utility.Wait(0.5)

; move the body
SLV_DeadPlayer.getActorRef().Disable(false)
Utility.Wait( 0.2)

SLV_DeadPlayer.getActorRef().MoveTo(BodyPos)

SLV_DeadPlayer.getActorRef().Enable(false)
Utility.Wait( 0.2)
EndFunction


Function MakePlayerAGhost()
; make player a ghost
SLV_Player.getActorRef().SetGhost()

game.setplayeraidriven(false)
Game.EnablePlayerControls()
Game.DisablePlayerControls( abMovement = false,  abFighting = true,  abCamSwitch = false, abLooking = false,  abSneaking = true,  abMenu = true,  abActivate = true,  abJournalTabs = true,  aiDisablePOVType = 0)

; now look like a ghost
SLV_Player.getActorRef().AddSpell(GhostVisualFx, false)
EndFunction



Function ReviveDeadPlayer()
; clear the ghost flag
SLV_Player.getActorRef().SetGhost(false)

; free player of any restrainers or disabled capacity
Game.EnablePlayerControls()

;move player to the corpse
SLV_Player.getActorRef().MoveTo(SLV_DeadPlayer.getActorRef())

SLV_DeadPlayer.getActorRef().resurrect()
; hide the corpse
SLV_DeadPlayer.getActorRef().Disable(true)
Utility.Wait( 1.5)

SLV_DeadPlayer.getActorRef().MoveTo(SLV_DeadBodyMarker)

SLV_DeadPlayer.getActorRef().Enable(false)
Utility.Wait( 0.2)


; disable the fx
SLV_Player.getActorRef().DispelSpell(GhostVisualFx)
SLV_Player.getActorRef().SetAlpha(1.0)

; remove player essentiel flag
SLV_Player.getActorRef().GetActorBase().SetEssential(false)
SLV_Player.getActorRef().SetNoBleedoutRecovery(true)

if MCMMenu.Breastgrowing
	myScripts.SLV_RestorePlayerJugs()
endif

int doAmputation = Utility.RandomInt(1,100)		
if doAmputation <= MCMMenu.arenaAmputationProbabilty
	myScripts.SLV_DisplayInformation("You notice that a limb got lost during your resurrection")
	Amputee.SLV_ProgressiveAmputeeActor(SLV_Player.getActorRef())
endif
EndFunction


Function RepairAlivePlayer()
myScripts.SLV_DisplayInformation("Player health: " + SLV_Player.getActorRef().GetActorValue("Health"))

while SLV_Player.getActorRef().GetActorValue("Health") < 10
	myScripts.SLV_DisplayInformation("Player health: " + SLV_Player.getActorRef().GetActorValue("Health"))
	SLV_Player.getActorRef().RestoreAV("Health", 20)
endwhile

game.setplayeraidriven(false)
Game.EnablePlayerControls()

myScripts.SLV_DisplayInformation("Player health: " + SLV_Player.getActorRef().GetActorValue("Health"))
; remove player essentiel flag
SLV_Player.getActorRef().GetActorBase().SetEssential(false)
SLV_Player.getActorRef().SetNoBleedoutRecovery(true)
EndFunction





Function actualizeDeadPlayer()
prepareDeadPlayer()

; copy name
SLV_DeadPlayer.getActorRef().getActorBase().setName(Game.getplayer().getActorBase().getName())

; copy weight
SLV_DeadPlayer.getActorRef().getActorBase().setWeight(SLV_Player.getActorRef().getActorBase().getWeight())

; copy items
CopyBodySlot(0x00000001 )
CopyBodySlot(0x00000004 )
CopyBodySlot(0x00000008 )
CopyBodySlot(0x00000010 )
CopyBodySlot(0x00000020 )
CopyBodySlot(0x00000040 )
CopyBodySlot(0x00000080 )
CopyBodySlot(0x00000100 )
CopyBodySlot(0x00001000 )
CopyBodySlot(0x00002000 )

;remove helmet
Form Helmet = SLV_DeadPlayer.getActorRef().GetWornForm(Armor.GetMaskForSlot(31)) 
if Helmet != none
	myScripts.SLV_StripThisArmor(Helmet, SLV_DeadPlayer.getActorRef())
endif
EndFunction


Function prepareDeadPlayer()
if SLV_DeadPlayer.getActorRef() == Game.GetPlayer()
	myScripts.SLV_DisplayInformation("DeadPlayer is now Game.getplayer()??")
	return
endif
shaving.ShaveDeadPlayer(SLV_DeadPlayer.getActorRef())

if MCMMenu.arenaBeheading
	SlaveTats.remove_tattoos(SLV_DeadPlayer.getActorRef(), 0, true, true)
endif

;Amputee.SLV_CopyAmputees(SLV_Player.getActorRef(),SLV_DeadPlayer.getActorRef())

myScripts.SLV_InflationFramework(SLV_DeadPlayer.getActorRef(), SLV_BreastSize.getValue())
EndFunction
GlobalVariable Property SLV_BreastSize auto


Function CopyBodySlot(int slotMask)
Armor equipedItem =  SLV_Player.getActorRef().GetWornForm(slotMask) as Armor
		
If equipedItem != NONE
	 SLV_DeadPlayer.getActorRef().EquipItem(equipedItem, false, true)
EndIf
EndFunction



Function KillDeadPlayer()
SLV_DeadPlayer.getActorRef().RemoveAllItems()

SLV_DeadPlayer.getActorRef().SetUnconscious()
SLV_DeadPlayer.getActorRef().KillEssential()
EndFunction

Function ResurrectDeadPlayer()
SLV_DeadPlayer.getActorRef().Resurrect()
SLV_DeadPlayer.getActorRef().SetUnconscious(false)
SLV_DeadPlayer.getActorRef().RemoveAllItems()

actualizeDeadPlayer()
EndFunction

Function ResurrectDeadPlayer2()
SLV_DeadPlayer.getActorRef().Resurrect()
SLV_DeadPlayer.getActorRef().SetUnconscious(false)
EndFunction


SLV_Utilities Property myScripts auto
SLV_HeadShaving Property shaving Auto
SLV_Amputee Property Amputee auto
ReferenceAlias Property SLV_Player Auto
ReferenceAlias Property SLV_DeadPlayer Auto

ObjectReference Property SLV_DeadBodyMarker  Auto
Spell Property GhostVisualFx  Auto
VisualEffect Property DraugrMaleEyeGlowFX Auto
SLV_MCMMenu Property MCMMenu Auto
