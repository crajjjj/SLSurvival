ScriptName sr_FTUCumPumpActivator extends ObjectReference

sr_FTUPumpAlias Property patient auto
sr_inflateQuest Property inflater auto
sr_FTUDeliveryFrame Property ftu auto 
int property pumpNum auto
bool property bound = false auto

; 0 = no change, -1 = empty, 1 = fill
int analTo = 0
int vagTo = 0 

int POOL_TIME = 20

Event OnInit()
	GoToState("Inactive")
EndEvent


State Inactive
	Event onActivate (objectReference triggerRef)
		If analTo != 0  || vagTo != 0
			GoToState("Active")
		EndIf
	EndEvent
EndState

State Active
	Event OnBeginState()
		inflater.log("Pump activator state active starting")
		If Patient.GetActorReference() == none 
			inflater.notify("Pump "+pumpNum+" will activate in 15s")
			RegisterForSingleUpdate(15.0)
		Else
			ProcessPatient()
		EndIf
	EndEvent
	
	Event onActivate (objectReference triggerRef)
		; Processing actor don't do anything
	EndEvent
	
	Event OnUpdate()
		If Patient.GetActorReference() == none 
			; Alias still empty, reset
			inflater.notify("Pump "+pumpNum+" is still empty and resets")
			GoToState("Inactive")
		Else
			ProcessPatient()
		EndIf
	EndEvent
	
	Event OnEndState()
		inflater.log("Pump activator state active ending")
	EndEvent
EndState

Function ProcessPatient()
;	inflater.notify("Pump "+pumpNum+" starting")
	inflater.log("Pump "+pumpNum+" starting - analTo: " +analTo+", vagTo: " +vagTo)
	
	Actor p = patient.GetActorReference()
	
	If p.IsInFaction(inflater.inflaterAnimatingFaction)
		inflater.warn("Tried to use cum pump while already animating!")
		GoToState("Inactive")
		return
	EndIf
	
	If p.GetCurrentScene() != none
		inflater.warn("Tried to use cum pump during a scene!")
		GoToState("Inactive")
		return
	EndIf
	
	If p.WornHasKeyword(inflater.zad_DeviousBelt)
		inflater.notify("$FTU_PUMP_BLOCKED")
		GoToState("Inactive")
		return
	EndIf
	
	
	if p == inflater.player
		Game.DisablePlayerControls()
	EndIf
	ftu.startMoanLoop(p)
	ftu.playPumpAnim(p, bound)
	
;	QueueActor(Actor a, bool inflate, int poolmask, float amount, float time = 6.0, String callback = "", int animate = 0)
	If vagTo != 0
		float time = inflater.getVaginalPercentage(p) * POOL_TIME
		RegisterForModEvent("sr.ftu.pump"+pumpNum, "ProcessCont")
		If vagTo == 1
			time = POOL_TIME - time
			If time > 0
				float amount = inflater.GetPoolSize(p) - inflater.GetVaginalCum(p)
				If amount > 0
					inflater.QueueActor(p, true, inflater.VAGINAL, amount, time, "sr.ftu.pump"+pumpNum)
				Else
					ProcessPatient2()
				EndIf
			EndIf
		ElseIf vagTo == -1
			If time > 0
				If inflater.GetVaginalCum(p) > 0
					inflater.QueueActor(p, false, inflater.VAGINAL, inflater.GetVaginalCum(p), time, "sr.ftu.pump"+pumpNum, -1)
				Else
					ProcessPatient2()
				EndIf
			EndIf
		EndIf
		inflater.InflateQueued()
	Else
		ProcessPatient2()
	EndIf

EndFunction

Event ProcessCont(Form akActor, float startVag, float startAn)
	UnregisterForModEvent("sr.ftu.pump"+pumpNum)
	ProcessPatient2()
EndEvent

Function ProcessPatient2()

	Actor p = patient.GetActorReference()
	
	If analTo != 0
		float time = inflater.getAnalPercentage(p) * POOL_TIME
		RegisterForModEvent("sr.ftu.pump"+pumpNum, "ProcessCont2")
		If analTo == 1
			time = POOL_TIME - time
			If time > 0
				float amount = inflater.GetPoolSize(p) - inflater.GetAnalCum(p)
				If amount >  0
					inflater.QueueActor(p, true, inflater.ANAL, amount, time, "sr.ftu.pump"+pumpNum)
				Else
					ProcessPatient3()
				EndIf
			EndIf
		ElseIf analTo == -1
			If time > 0
				If inflater.GetAnalCum(p) > 0
					inflater.QueueActor(p, false, inflater.ANAL, inflater.GetAnalCum(p), time, "sr.ftu.pump"+pumpNum, -1)
				Else
					ProcessPatient3()
				EndIf
			EndIf
		EndIf	
		inflater.InflateQueued()
	Else
		ProcessPatient3()
	EndIf
EndFunction

Event ProcessCont2(Form akActor, float startVag, float startAn)
	UnregisterForModEvent("sr.ftu.pump"+pumpNum)
	ProcessPatient3()
EndEvent

Function ProcessPatient3()
	Actor p = patient.GetActorReference()
	ftu.StopMoanLoop(p)
	ftu.StopPumpAnim(p, bound)
	if p == inflater.player
		Game.EnablePlayerControls()
	EndIf
	
	
;	inflater.notify("Pump "+pumpNum+" finished")
	GoToState("Inactive")
EndFunction

Function SetPool(bool isAnal, int to)
	If to >= -1 && to <= 1
		If isAnal
			analTo = to
		Else
			vagTo = to
		EndIf
	EndIf
EndFunction
