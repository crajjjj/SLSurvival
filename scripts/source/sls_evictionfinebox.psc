Scriptname SLS_EvictionFineBox extends ObjectReference  

ObjectReference Property LinkedChest Auto
String Property MyLocation Auto
Actor Property PlayerRef Auto
MiscObject Property Gold001 Auto

Faction Property CrimeFactionWhiterun Auto ; Whiterun
Faction Property CrimeFactionEastmarch Auto ; Windhelm
Faction Property CrimeFactionHaafingar Auto ; Solitude
Faction Property CrimeFactionReach Auto ; Markarth
Faction Property CrimeFactionRift Auto ; Riften

SLS_Mcm Property Menu Auto
_SLS_InterfaceSlaverun Property Slaverun Auto
_SLS_InterfacePaySexCrime Property Psc Auto

Event OnActivate(ObjectReference akActionRef)
	If akActionRef == PlayerRef
		Int PscBounty
		Int SkyrimBounty
		Bool IsFree
		
		If MyLocation == "Whiterun"
			PscBounty = Psc.GetPscBountyWhiterun()
			SkyrimBounty = CrimeFactionWhiterun.GetCrimeGold()
			IsFree = Slaverun.IsFreeTownWhiterun()
		ElseIf MyLocation == "Solitude"
			PscBounty = Psc.GetPscBountySolitude()
			SkyrimBounty = CrimeFactionHaafingar.GetCrimeGold()
			IsFree = Slaverun.IsFreeTownSolitude()
		ElseIf MyLocation == "Markarth"
			PscBounty = Psc.GetPscBountyMarkarth()
			SkyrimBounty = CrimeFactionReach.GetCrimeGold()
			IsFree = Slaverun.IsFreeTownMarkarth()
		ElseIf MyLocation == "Windhelm"
			PscBounty = Psc.GetPscBountyWindhelm()
			SkyrimBounty = CrimeFactionEastmarch.GetCrimeGold()
			IsFree = Slaverun.IsFreeTownWindhelm()
		Else ; Riften
			PscBounty = Psc.GetPscBountyRiften()
			SkyrimBounty = CrimeFactionRift.GetCrimeGold()
			IsFree = Slaverun.IsFreeTownRiften()
		EndIf
		
		Int ProcessingFee
		If IsFree
			ProcessingFee = Menu.ConfiscationFine
		Else
			ProcessingFee = Menu.ConfiscationFineSlaverun
		EndIf
		
		
		If PscBounty > 0
			Debug.Notification("You have unpaid bribe bounty - PSC")
		ElseIf SkyrimBounty > 0
			Debug.Notification("You have outstanding fines")
		ElseIf PlayerRef.GetItemCount(Gold001) < ProcessingFee
			Debug.Notification("You can not afford to pay the processing fee - " + ProcessingFee + " gold")
		Else
			LinkedChest.Lock(false)
			PlayerRef.RemoveItem(Gold001, ProcessingFee)
		EndIf
	EndIf

	; Close strongbox again
	Utility.Wait(1.0)
	int openState = Self.GetOpenState()
	If (openState == 1 || openState == 2)
		Self.SetOpen(false)
	EndIf
EndEvent
