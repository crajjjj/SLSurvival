Scriptname _SLS_TollDodgeHunt extends Quest Conditional

Event OnInit()
	;RegisterForControl("Activate")
	;Debug.Messagebox("QUEST STARTED")
	If Self.IsRunning()
		DoUpdate()
	EndIf
	RegisterForMenu("Journal Menu")
	RefreshSettings()
EndEvent

Event OnUpdate()
	DoUpdate()
EndEvent

Event OnMenuClose(String MenuName)
	RefreshSettings()
EndEvent

Function Shutdown()
	IsShuttingDown = true
	While IsUpdateRunning
		Utility.Wait(2.0)
	EndWhile
	Self.Stop()
EndFunction

Function RefreshSettings()
	TollDodgeHuntFreq = Menu.TollDodgeHuntFreq
	MaxGuards = Menu.TollDodgeMaxGuards
EndFunction

;/
Event OnControlDown(string control)
	ObjectReference TransDoor = Game.GetCurrentCrosshairRef()
	If TransDoor.GetBaseObject() as Door
		Debug.Messagebox("Is door")
	Else
		Debug.Messagebox("Is NOT door")
	EndIf
	Utility.Wait(2.0) ; Wait for door to animate

	
EndEvent
/;

Function DoUpdate()
	If !IsShuttingDown
		IsUpdateRunning = true
		GetIsPlayerSpotted()
		GetDetectionCountHighest()
		TollDodge.UpdateHunterPackage()
		RegisterForSingleUpdate(TollDodgeHuntFreq)
		IsUpdateRunning = false
	EndIf
EndFunction

Function GetDetectionCountHighest()
	Int i = Self.GetNumAliases()
	Int HighestCount = 0
	Int HunterDetection
	While i > 0
		i -= 1
		If (Self.GetNthAlias(i) as ReferenceAlias).GetReference()
			HunterDetection = (Self.GetNthAlias(i) as _SLS_DodgeHuntHunterAlias).DetectionCount
			If HunterDetection > HighestCount
				DetectionCount = HunterDetection
			EndIf
		EndIf
	EndWhile
	;Debug.Messagebox("HighestDetectionCount: " + DetectionCount)
EndFunction

Function AssignHunterSlot(ObjectReference Hunter)
	;Debug.Messagebox("HunterSlotUsage: " + HunterSlotUsage + "\nMaxGuards: " + MaxGuards)
	If HunterSlotUsage < MaxGuards
		Int i = Self.GetNumAliases()
		If HunterSlotUsage < i
			Int j = 0
			ReferenceAlias CurAlias
			While j < i
				CurAlias = Self.GetNthAlias(j) as ReferenceAlias
				If CurAlias.GetReference() == None
					;Debug.Messagebox("AssignHunterSlot: " + Hunter + "\nHunterSlotUsage: " + HunterSlotUsage + "\nMaxGuards: " + MaxGuards)
					If Self.IsRunning()
						HunterSlotUsage += 1
						CurAlias.ForceRefTo(Hunter)
						(CurAlias as _SLS_DodgeHuntHunterAlias).SetupHunter()
					EndIf
					Return
				EndIf
				j += 1
			EndWhile
		EndIf
	EndIf
EndFunction

Function GetIsPlayerSpotted()
	;Debug.Messagebox("Hunting begins")
	;DetectionCount = 0
	_SLS_TollDodgeGuardSearch.Stop()
	_SLS_TollDodgeGuardSearch.Start()
	
	Int i = 0
	Int AliasCount = _SLS_TollDodgeGuardSearch.GetNumAliases()
	Actor Hunter
	While i < AliasCount
		Hunter = (_SLS_TollDodgeGuardSearch.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If Hunter && PlayerRef.IsDetectedBy(Hunter)
			AssignHunterSlot(Hunter)
		EndIf
		i += 1
	EndWhile
	;RegisterForSingleUpdate(3.0)
EndFunction

Bool IsUpdateRunning = false
Bool IsShuttingDown = false

Int Property DetectionCount = 0 Auto Hidden Conditional
Int Property DetectionAtZeroCount = 0 Auto Hidden
Int Property HunterSlotUsage = 0 Auto Hidden

Bool Property SawPlayerChangeCell = false Auto Hidden Conditional

Float TollDodgeHuntFreq = 1.5

Int MaxGuards = 6

Quest Property _SLS_TollDodgeGuardSearch Auto

Actor Property PlayerRef Auto

ObjectReference Property _SLS_TollDodgeLastKnownPos Auto

ReferenceAlias Property ObserveAlias Auto

_SLS_TollDodge Property TollDodge Auto
SLS_Mcm Property Menu Auto
