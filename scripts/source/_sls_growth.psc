Scriptname _SLS_Growth extends Quest  

Event OnInit()
	If Self.IsRunning()
		RegisterForSingleUpdateGameTime(24.0)
	EndIf
EndEvent

Event OnUpdateGameTime()
	Float OldWeight = Player.GetWeight()
	Float NewWeight = OldWeight + StorageUtil.GetFloatValue(Menu, "WeightGainPerDay", Missing = 0.0)
	;Float NeckDelta = (OldWeight / 100.0) - (NewWeight / 100.0)
	
	Player.SetWeight(NewWeight)
	PlayerRef.UpdateWeight((OldWeight / 100.0) - (NewWeight / 100.0))
	;Debug.Messagebox("OldWeight: " + OldWeight + "\nNewWeight: " + NewWeight)
	RegisterForSingleUpdateGameTime(24.0)
EndEvent

ActorBase Property Player Auto
Actor Property PlayerRef Auto

SLS_Mcm Property Menu Auto
