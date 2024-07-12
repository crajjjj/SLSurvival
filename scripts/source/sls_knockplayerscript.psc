Scriptname SLS_KnockPlayerScript extends ReferenceAlias  

Event OnInit()
	RegisterForSleep()
	Main = PlayerAliasMain as SLS_Main
EndEvent

state InKnockedCell
	Event OnBeginState()
		AddInventoryEventFilter(_SLS_Bedroll)
		WIEventsEnabled.SetValueInt(0) ; Stops NPCs picking up your dropped shit and handing it back to you.
		Main = PlayerAliasMain as SLS_Main
	EndEvent

	Event OnSleepStart(float afSleepStartTime, float afDesiredSleepEndTime)
		ObjectReference Bedroll = Game.FindClosestReferenceOfTypeFromRef(_SLS_BedrollFurn, PlayerRef, 200.0)
		Form MilkMachineForm = Game.GetFormFromFile(0x00034955, "MilkModNEW.esp")
		Form Lactacid = Game.GetFormFromFile(0x0343F2, "MilkModNEW.esp")
		ObjectReference MilkMachine = Bedroll.PlaceAtMe(MilkMachineForm)
		Bedroll.Disable()
		PlayerRef.Additem(Lactacid, 5, true)
		Utility.Wait(1)
		MilkMachine.Activate(PlayerRef)
		Game.DisablePlayerControls()
	EndEvent

	Event OnSleepStop(bool abInterrupted)
		SleepyTimeFadeIn.Apply(1.0)
		_SLS_KnockForceGreet.SetCurrentStageID(10)
		KnockHostAlias.ForceRefTo(Main.KnockHost)
		Utility.wait(30)
		Game.EnablePlayerControls()
	EndEvent


	Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)
	  
	endEvent
	
	
	Event OnEndState()
		WIEventsEnabled.SetValueInt(1)
		RemoveInventoryEventFilter(_SLS_Bedroll)
	EndEvent
endState

; Seems kind of silly to get SLS_Main this way but adding it directly as a property results in the below error. Timing problem? =======================================
;ERROR: Property Main on script sls_knockplayerscript attached to alias _SLS_KnockQuestPlayerAlias on quest _SLS_KnockQuest (23008907) cannot be bound because alias PlayerRef on quest _SLS_Main (23000D64) is not the right type
SLS_Main Main
ReferenceAlias Property PlayerAliasMain Auto
; =========================================================================================================

GlobalVariable Property WIEventsEnabled Auto
Actor Property PlayerRef Auto
Furniture Property _SLS_BedrollFurn  Auto  
ImageSpaceModifier Property SleepyTimeFadeIn  Auto  
MiscObject Property _SLS_Bedroll Auto
Quest Property _SLS_KnockForceGreet Auto
ReferenceAlias Property KnockHostAlias  Auto  

