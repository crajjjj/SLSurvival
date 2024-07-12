Scriptname sr_inflateExternalEventController extends Quest  

Actor Property PlayerRef Auto
sr_inflateQuest Property inflater Auto
formlist property sr_InjectorFormlist Auto

Event OnInit()
	RegisterModEvent()
EndEvent

Event SRInflateEvent(Form akSpeakerform, Bool Inflation, int poolmask, float amount, int time, string callback)
Actor ActorInflater = akspeakerform as actor
	inflater.InflateDeflate(ActorInflater, Inflation, poolmask, amount, time, callback)
	;Inflation - True(Inflate), False(Deflate) / poolmask - 1(Vaginal), 2(Anal), 3(Vaginal + Anal), 4(Oral), / amount - the cum amount you want to add or remove / time - literally required time for deflating. / callback - Just type "" It will ignore additional event call
EndEvent

Event SRInflateEventWithInjector(Form akSpeakerform, Form akInjectorform, Bool Inflation, int poolmask, float amount, int time, string callback)
Actor ActorInflater = akspeakerform as actor
Actor ActorInjector = akInjectorform as actor
	inflater.InflateDeflate(ActorInflater, Inflation, poolmask, amount, time, callback)
	sr_InjectorFormlist.addform(ActorInjector)
	;Inflation - True(Inflate), False(Deflate) / poolmask - 1(Vaginal), 2(Anal), 4(Oral)/ amount - the cum amount you want to add or remove / time - literally required time for deflating. / callback - Just type "" It will ignore additional event call
EndEvent

Event SRAbsorbEvent(Form akSpeakerform, int poolmask, float amount, int time, string callback)
Actor ActorInflater = akspeakerform as actor
	inflater.Absorbto(ActorInflater, poolmask, amount, time, callback)
	;poolmask - 1(Vaginal), 2(Anal) / amount - the cum amount you want to add or remove / time - literally required time for deflating. / callback - Just type "" It will ignore additional event call
EndEvent


Function RegisterModEvent()
	RegisterForModEvent("SR_InflateEvent", "SRInflateEvent")
	RegisterForModEvent("SR_InflateInjectorEvent", "SRInflateEventWithInjector")
	RegisterForModEvent("SR_AbsorbEvent", "SRAbsorbEvent")
EndFunction

;################Example###############	
;	Function SendFHUInflationEvent(form inflater, Bool Inflation, int poolmask, float amount, int time, string callback)
;		Int handle = ModEvent.Create("SR_InflateEvent")
;		ModEvent.PushForm(handle, inflater)
;		ModEvent.PushBool(handle, Inflation)
;		ModEvent.PushInt(handle, poolmask)
;		ModEvent.PushFloat(handle, amount)
;		ModEvent.PushInt(handle, time)
;		ModEvent.PushString(handle, callback)
;		ModEvent.Send(handle)
;	EndFunction

;	Function SendFHUAbsorptionEvent(form inflater, int poolmask, float amount, int time, string callback)
;		Int handle = ModEvent.Create("SR_AbsorbEvent")
;		ModEvent.PushForm(handle, inflater)
;		ModEvent.PushInt(handle, poolmask)
;		ModEvent.PushFloat(handle, amount)
;		ModEvent.PushInt(handle, time)
;		ModEvent.PushString(handle, callback)
;		ModEvent.Send(handle)
;	EndFunction
