Scriptname _SLS_SteepFallHorse extends Quest  

Event OnInit()
	If Self.IsRunning()
		RegisterForAnimationEvent(PlayerRef, "tailHorseMount")
	EndIf
EndEvent

Event OnBeginState()
	RegisterForAnimationEvent(PlayerRef, "tailHorseMount")
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	;Debug.Messagebox("asEventName: " + asEventName)
	GoToState(asEventName)
EndEvent

Function RecordHeight()
	LastHeight = Horsey.GetPositionZ()
EndFunction

Event OnUpdate()
	If Math.Abs(LastHeight - Horsey.GetPositionZ()) > JsonUtil.GetFloatValue("SL Survival/SteepFall.json", "horsefallheight", Missing = 250.0) ; Up or down
		HorseFall()
	Else
		RecordHeight()
	EndIf
	;Debug.Messagebox("LastHeight: " + LastHeight)
	RegisterForSingleUpdate(1.0)
EndEvent

Function HorseFall()
	Debug.SendAnimationEvent(PlayerRef, "MountedSwimStop")
	Utility.Wait(0.1)
	Debug.SendAnimationEvent(Horsey, "StandingRearUp")
	Fallen = true

	(Game.GetForm(0x000388f7) as sound).Play(PlayerRef)
	Utility.Wait(0.8)

	SteepFall.HorseTrip(Horsey)
	SteepFall.Trip(true)
	GoToState("HorseFall")
EndFunction

State tailHorseMount
	Event OnBeginState()
		RegisterForAnimationEvent(PlayerRef, "StopHorseCamera")
		UnRegisterForAnimationEvent(PlayerRef, "tailHorseMount")
		_SLS_SteepFallQuest.Stop()
		;Horsey = Game.GetPlayersLastRiddenHorse() ; In traditional Bethesda fashion GetPlayersLastRiddenHorse() is a half-working, piece of shit and doesn't return stolen horses...
		_SLS_SteepFallHorseScan.Stop()
		_SLS_SteepFallHorseScan.Start()
		Utility.Wait(0.1)
		Horsey = (_SLS_SteepFallHorseScan.GetNthAlias(0) as ReferenceAlias).GetReference() as Actor
		If Horsey
			RecordHeight()
			RegisterForSingleUpdate(1.0)
		EndIf
	EndEvent

	Event OnAnimationEvent(ObjectReference akSource, string asEventName)
		GoToState("")
	EndEvent

	Event OnEndState()
		UnRegisterForUpdate()
		UnRegisterForAnimationEvent(PlayerRef, "StopHorseCamera")
		If !Fallen
			_SLS_SteepFallQuest.Start()
			Horsey = None
		EndIf
	EndEvent
EndState

State HorseFall
	Event OnUpdate()
	EndEvent
	
	Event OnBeginState()
		RegisterForAnimationEvent(PlayerRef, "getupend") ; Player fell off the horse/horse died and the player has gotten up off the ground
		RegisterForAnimationEvent(PlayerRef, "FootRight")
	EndEvent
	
	Event OnAnimationEvent(ObjectReference akSource, string asEventName)
		GoToState("")
	EndEvent
	
	Event OnEndState()
		UnRegisterForAnimationEvent(PlayerRef, "getupend") ; Player fell off the horse/horse died and the player has gotten up off the ground
		UnRegisterForAnimationEvent(PlayerRef, "FootRight")
		Fallen = false
		_SLS_SteepFallQuest.Start()
		Horsey = None
	EndEvent
EndState

Bool Fallen = false

Float LastHeight

Actor Property PlayerRef Auto
Actor Horsey

Quest Property _SLS_SteepFallQuest Auto
Quest Property _SLS_SteepFallHorseScan Auto

_SLS_SteepFall Property SteepFall Auto

