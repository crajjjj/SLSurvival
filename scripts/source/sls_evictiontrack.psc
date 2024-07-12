Scriptname SLS_EvictionTrack extends Quest Conditional 

Faction Property CrimeFactionWhiterun Auto ; Whiterun
Faction Property CrimeFactionEastmarch Auto ; Windhelm
Faction Property CrimeFactionHaafingar Auto ; Solitude
Faction Property CrimeFactionReach Auto ; Markarth
Faction Property CrimeFactionRift Auto ; Riften

; Hearthfires
;Faction Property CrimeFactionFalkreath Auto ; Falkreath
;Faction Property CrimeFactionHjaalmarch Auto ; Morthal
;Faction Property CrimeFactionPale Auto ; Dawnstart

; Kip
;Faction Property CrimeFactionWinterhold Auto ; Winterhold

Bool Property IsLicenceEvicted = false Auto Hidden Conditional

Bool Property OwnsWhiterun = false Auto Hidden Conditional
Bool Property OwnsSolitude = false Auto Hidden Conditional
Bool Property OwnsMarkarth = false Auto Hidden Conditional
Bool Property OwnsWindhelm = false Auto Hidden Conditional
Bool Property OwnsRiften = false Auto Hidden Conditional

FormList Property _SLS_BarObjsWhiterun Auto
FormList Property _SLS_BarObjsRiften Auto
FormList Property _SLS_BarredObjsWindhelm Auto
FormList Property _SLS_BarObjsMarkarth Auto
FormList Property _SLS_BarObjsSolitude Auto

ObjectReference Property WhiterunDoor Auto
ObjectReference Property RiftenDoor01  Auto 
ObjectReference Property RiftenDoor02  Auto 
ObjectReference Property WindhelmDoor  Auto  
ObjectReference Property MarkarthDoor  Auto  
ObjectReference Property SolitudeDoor01  Auto  
ObjectReference Property SolitudeDoor02  Auto 
ObjectReference Property SolitudeDoor03  Auto 

Bool Property IsBarredWhiterun = false Auto Hidden
Bool Property IsBarredSolitude = false Auto Hidden
Bool Property IsBarredMarkarth = false Auto Hidden
Bool Property IsBarredWindhelm = false Auto Hidden
Bool Property IsBarredRiften = false Auto Hidden

SLS_Mcm Property Menu Auto
_SLS_LicenceUtil Property LicUtil Auto
_SLS_InterfaceSlaverun Property Slaverun Auto
_SLS_InterfacePaySexCrime Property Psc Auto

Function ToggleBarObjects(FormList FlSelect, Bool Show)
	Int i = 0
	If Show
		While i < FlSelect.GetSize()
			(FlSelect.GetAt(i) as ObjectReference).Enable()
			i+=1
		EndWhile
	Else
		While i < FlSelect.GetSize()
			(FlSelect.GetAt(i) as ObjectReference).Disable()
			i+=1
		EndWhile
	EndIf
EndFunction

Function StartUp()
	;Debug.Notification("_SLS_: Eviction quest started")
	RegisterForSingleUpdateGameTime(1.0)
	If LicUtil.LicPropertyEnable
		(Game.GetFormFromFile(0x0D1F95, "SL Survival.esp") as Quest).Start() ; _SLS_LicencePropertyQuest
	EndIf
EndFunction

Event OnUpdateGameTime()
	UpdateEvictions()
	
	; Update evictions at 3am
	float Time = Utility.GetCurrentGameTime()
	Time -= Math.Floor(Time) ; Remove "previous in-game days passed" bit
	Time *= 24
	
	If Time < 2.5 ; 2.5 & !3.0 to allow for error in calc causing update spam
		Debug.trace("SLS_: Evictions Updating in " + (3.0 - Time))
		RegisterForSingleUpdateGameTime(3.0 - Time)
	Else
		Debug.trace("SLS_: Evictions Updating in " + (27.0 - Time))
		RegisterForSingleUpdateGameTime(27.0 - Time)
	Endif
EndEvent

Function UpdateEvictions(Bool DoImmediately = false)
	Debug.trace("_SLS_: Update evictions" + "\nLicUtil.LicPropertyEnable: " + LicUtil.LicPropertyEnable + "\nLicUtil.HasValidPropertyLicence: " + LicUtil.HasValidPropertyLicence + "\nIsBarredWhiterun: " + IsBarredWhiterun)
	Int TotalBounty
	Float EvictionLimit
	If !DoImmediately
		Utility.Wait(5.0) ; Wait for licences to expire first. Otherwise update here runs before licence expires when WAITing (skipping) through expiry. 
	EndIf
	; Whiterun
	If OwnsWhiterun
		If Slaverun.IsFreeTownWhiterun()
			EvictionLimit = Menu.EvictionLimit 
		Else
			EvictionLimit = Menu.SlaverunEvictionLimit
		EndIf
		TotalBounty = Psc.GetPscBountyWhiterun() + CrimeFactionWhiterun.GetCrimeGold()
		If !IsBarredWhiterun; && (TotalBounty >= EvictionLimit || (LicUtil.LicPropertyEnable && !LicUtil.HasValidPropertyLicence) || StorageUtil.FormListCount(Self, "EvictFormsWhiterun") > 0)
			If (LicUtil.LicPropertyEnable && !LicUtil.HasValidPropertyLicence) || StorageUtil.FormListCount(Self, "EvictFormsWhiterun") > 0 ; Evict immediately
				IsBarredWhiterun = true
				EvictWhiterun(true)
			ElseIf  TotalBounty >= EvictionLimit ; Don't evict immediately if based on bounty. Wait til sleeping and throw out.
				IsBarredWhiterun = true
			EndIf
			
		ElseIf IsBarredWhiterun && (TotalBounty < EvictionLimit && ((LicUtil.LicPropertyEnable && LicUtil.HasValidPropertyLicence && !IsLicenceEvicted) || !LicUtil.LicPropertyEnable) && StorageUtil.FormListCount(Self, "EvictFormsWhiterun") <= 0)
			; reinstate player home
			IsBarredWhiterun = false
			EvictWhiterun(false)
		EndIf
	EndIf
	
	; Windhelm
	If OwnsWindhelm
		If Slaverun.IsFreeTownWindhelm()
			EvictionLimit = Menu.EvictionLimit
		Else
			EvictionLimit = Menu.SlaverunEvictionLimit
		EndIf
		TotalBounty = Psc.GetPscBountyWindhelm() + CrimeFactionEastmarch.GetCrimeGold()
		If !IsBarredWindhelm; && (TotalBounty >= EvictionLimit || (LicUtil.LicPropertyEnable && !LicUtil.HasValidPropertyLicence) || StorageUtil.FormListCount(Self, "EvictFormsWindhelm") > 0)
			If (LicUtil.LicPropertyEnable && !LicUtil.HasValidPropertyLicence) || StorageUtil.FormListCount(Self, "EvictFormsWindhelm") > 0 ; Evict immediately
				IsBarredWindhelm = true
				EvictWindhelm(true)
			ElseIf TotalBounty >= EvictionLimit
				IsBarredWindhelm = true
			EndIf
			
		ElseIf IsBarredWindhelm && (TotalBounty < EvictionLimit && ((LicUtil.LicPropertyEnable && LicUtil.HasValidPropertyLicence && !IsLicenceEvicted) || !LicUtil.LicPropertyEnable) && StorageUtil.FormListCount(Self, "EvictFormsWindhelm") <= 0)
			; reinstate player home
			IsBarredWindhelm = false
			EvictWindhelm(false)
		EndIf
	EndIf
	
	; Solitude
	If OwnsSolitude
		If Slaverun.IsFreeTownSolitude()
			EvictionLimit = Menu.EvictionLimit
		Else
			EvictionLimit = Menu.SlaverunEvictionLimit
		EndIf
		TotalBounty = Psc.GetPscBountySolitude() + CrimeFactionHaafingar.GetCrimeGold()
		If !IsBarredSolitude; && (TotalBounty >= EvictionLimit || (LicUtil.LicPropertyEnable && !LicUtil.HasValidPropertyLicence) || StorageUtil.FormListCount(Self, "EvictFormsSolitude") > 0)
			If (LicUtil.LicPropertyEnable && !LicUtil.HasValidPropertyLicence) || StorageUtil.FormListCount(Self, "EvictFormsSolitude") > 0 ; Evict immediately
				IsBarredSolitude = true
				EvictSolitude(true)
			ElseIf TotalBounty >= EvictionLimit
				IsBarredSolitude = true
			EndIf
	
		ElseIf IsBarredSolitude && (TotalBounty < EvictionLimit && ((LicUtil.LicPropertyEnable && LicUtil.HasValidPropertyLicence && !IsLicenceEvicted) || !LicUtil.LicPropertyEnable) && StorageUtil.FormListCount(Self, "EvictFormsSolitude") <= 0)
			; reinstate player home
			IsBarredSolitude = false
			EvictSolitude(false)
		EndIf
	EndIf
	
	; Markarth
	If OwnsMarkarth
		If Slaverun.IsFreeTownMarkarth()
			EvictionLimit = Menu.EvictionLimit
		Else
			EvictionLimit = Menu.SlaverunEvictionLimit
		EndIf
		TotalBounty = Psc.GetPscBountyMarkarth() + CrimeFactionReach.GetCrimeGold()
		If !IsBarredMarkarth; && (TotalBounty >= EvictionLimit || (LicUtil.LicPropertyEnable && !LicUtil.HasValidPropertyLicence) || StorageUtil.FormListCount(Self, "EvictFormsMarkarth") > 0)
			If (LicUtil.LicPropertyEnable && !LicUtil.HasValidPropertyLicence) || StorageUtil.FormListCount(Self, "EvictFormsMarkarth") > 0
				IsBarredMarkarth = true
				EvictMarkarth(true)
			ElseIf TotalBounty >= EvictionLimit
				IsBarredMarkarth = true
			EndIf

		ElseIf IsBarredMarkarth && (TotalBounty < EvictionLimit && ((LicUtil.LicPropertyEnable && LicUtil.HasValidPropertyLicence && !IsLicenceEvicted) || !LicUtil.LicPropertyEnable) && StorageUtil.FormListCount(Self, "EvictFormsMarkarth") <= 0)
			; reinstate player home
			IsBarredMarkarth = false
			EvictMarkarth(false)
		EndIf
	EndIf
	
	; Riften
	If OwnsRiften
		If Slaverun.IsFreeTownRiften()
			EvictionLimit = Menu.EvictionLimit
		Else
			EvictionLimit = Menu.SlaverunEvictionLimit
		EndIf
		TotalBounty = Psc.GetPscBountyRiften() + CrimeFactionRift.GetCrimeGold()
		If !IsBarredRiften; && (TotalBounty >= EvictionLimit || (LicUtil.LicPropertyEnable && !LicUtil.HasValidPropertyLicence) || StorageUtil.FormListCount(Self, "EvictFormsRiften") > 0)
			If (LicUtil.LicPropertyEnable && !LicUtil.HasValidPropertyLicence) || StorageUtil.FormListCount(Self, "EvictFormsRiften") > 0
				IsBarredRiften = true
				EvictRiften(true)
			ElseIf TotalBounty >= EvictionLimit
				IsBarredRiften = true
			EndIf

		ElseIf IsBarredRiften && (TotalBounty < EvictionLimit && ((LicUtil.LicPropertyEnable && LicUtil.HasValidPropertyLicence && !IsLicenceEvicted) || !LicUtil.LicPropertyEnable) && StorageUtil.FormListCount(Self, "EvictFormsRiften") <= 0)
			; reinstate player home
			IsBarredRiften = false
			EvictRiften(false)
		EndIf
	EndIf
EndFunction

Function EvictWhiterun(Bool Evicted, Bool Notify = true) ; Evicted: True - Set eviction, False - Unset eviction
	If Evicted
		WhiterunDoor.Disable()
		ToggleBarObjects(_SLS_BarObjsWhiterun, true)
		Debug.Trace("SLS_: You've been evicted from your home in Whiterun")
		;Debug.Notification("You've been evicted from your home in Whiterun")
	Else
		WhiterunDoor.Enable()
		ToggleBarObjects(_SLS_BarObjsWhiterun, false)
		Debug.Trace("SLS_: The eviction on your home in Whiterun has been lifted")
		If Notify
			Debug.Notification("The eviction on your home in Whiterun has been lifted")
		EndIf
	EndIf
EndFunction

Function EvictWindhelm(Bool Evicted, Bool Notify = true) ; Evicted: True - Set eviction, False - Unset eviction
	If Evicted
		WindhelmDoor.Disable()
		ToggleBarObjects(_SLS_BarredObjsWindhelm, true)
		Debug.Trace("SLS_: You've been evicted from your home in Windhelm")
		;Debug.Notification("You've been evicted from your home in Windhelm")
	Else
		WindhelmDoor.Enable()
		ToggleBarObjects(_SLS_BarredObjsWindhelm, false)
		Debug.Trace("SLS_: The eviction on your home in Windhelm has been lifted")
		If Notify
			Debug.Notification("The eviction on your home in Windhelm has been lifted")
		EndIf
	EndIf
EndFunction

Function EvictSolitude(Bool Evicted, Bool Notify = true) ; Evicted: True - Set eviction, False - Unset eviction
	If Evicted
		SolitudeDoor01.Disable()
		SolitudeDoor02.Disable()
		SolitudeDoor03.Disable()
		ToggleBarObjects(_SLS_BarObjsSolitude, true)
		Debug.Trace("SLS_: You've been evicted from your home in Solitude")
		;Debug.Notification("You've been evicted from your home in Solitude")
	Else
		SolitudeDoor01.Enable()
		SolitudeDoor02.Enable()
		SolitudeDoor03.Enable()
		ToggleBarObjects(_SLS_BarObjsSolitude, false)
		Debug.Trace("SLS_: The eviction on your home in Solitude has been lifted")
		If Notify
			Debug.Notification("The eviction on your home in Solitude has been lifted")
		EndIf
	EndIf
EndFunction

Function  EvictMarkarth(Bool Evicted, Bool Notify = true); Evicted: True - Set eviction, False - Unset eviction
	If Evicted
		MarkarthDoor.Disable()
		ToggleBarObjects(_SLS_BarObjsMarkarth, true)
		Debug.Trace("SLS_: You've been evicted from your home in Markarth")
		;Debug.Notification("You've been evicted from your home in Markarth")
	Else
		MarkarthDoor.Enable()
		ToggleBarObjects(_SLS_BarObjsMarkarth, false)
		Debug.Trace("SLS_: The eviction on your home in Markarth has been lifted")
		If Notify
			Debug.Notification("The eviction on your home in Markarth has been lifted")
		EndIf
	EndIf
EndFunction

Function EvictRiften(Bool Evicted, Bool Notify = true) ; Evicted: True - Set eviction, False - Unset eviction
	If Evicted
		RiftenDoor01.Disable()
		RiftenDoor02.Disable()
		ToggleBarObjects(_SLS_BarObjsRiften, true)
		Debug.Trace("SLS_: You've been evicted from your home in Riften")
		;Debug.Notification("You've been evicted from your home in Riften")
	Else
		RiftenDoor01.Enable()
		RiftenDoor02.Enable()
		ToggleBarObjects(_SLS_BarObjsRiften, false)
		Debug.Trace("SLS_: The eviction on your home in Riften has been lifted")
		If Notify
			Debug.Notification("The eviction on your home in Riften has been lifted")
		EndIf
	EndIf
EndFunction
