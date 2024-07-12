Scriptname _MA_MilkDump extends ObjectReference  

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	Int i = 0
	Main.FreshAddictivenessMult = Menu.FreshAddictivenessMult
	Main.FreshLactacidMult = Menu.FreshLactacidMult
	While i < aiItemCount
		PlayerRef.AddItem(akBaseItem, 1, false)
		PlayerRef.EquipItem(akBaseItem, false, true)
		self.RemoveItem(akBaseItem, 1)
		i += 1
	EndWhile
	Debug.Notification(aiItemCount + " x " + akBaseItem.GetName() + " was equipped")

	Utility.Wait(3) ; Wait for main to update stats before changing mults back. Need something more concrete here
	Main.FreshAddictivenessMult = 1.0
	Main.FreshLactacidMult = 1.0
	
EndEvent

Actor Property PlayerRef Auto
_MA_Mcm Property Menu Auto
_MA_Main Property Main Auto