Scriptname sr_InfEventManager extends Quest

sr_inflateQuest property inflater auto
sr_inflateConfig property config auto
sr_InfEventBase[] Property events Auto hidden ; All events
String[] Property index auto hidden		; Index of event names
float Property interval Auto hidden

sr_InfEventBase[] stack		; Queued event stack
int top = 0

int intervalSplit = 1

Event OnInit()
	events = new sr_InfEventBase[128]
	stack = new sr_InfEventBase[128]
	index = new String[128]
	top = 0
EndEvent

Function Maintenance()
	RegisterForModEvent("fhu.ForceEventRegister", "ForceEventRegister")
EndFunction

Function DoRegister()
	RegisterForSingleUpdateGameTime((interval / (intervalSplit as float)))
EndFunction

Event ForceEventRegister(string eventName, string strArg, float numArg, Form sender)
	RegisterAllEvents()
EndEvent

Function RegisterAllEvents()
	inflater.log("Registering all events...")
	SendModEvent("fhu.EventRegister")
EndFunction 

Function StartEvents()
	DoRegister()
EndFunction

Function StopEvents()
	UnregisterForUpdateGameTime()
EndFunction

bool Function RegisterEvent(sr_InfEventBase evnt)
	If index.Find(evnt.eventName) >= 0
		; event already registered
		; just using the event itself would return true here even if the script is different,
		; as long as they're on the same alias, so, use the event name instead
		return true
	EndIf
	int i = index.Find("")
	If i != -1
		index[i] = evnt.eventName
		events[i] = evnt
		inflater.log("[" + evnt.eventName + "|" + evnt.chance + "%] registered at " + i)
		return true
	endIf 
	return false 
EndFunction

sr_InfEventBase Function GetEventByName(String name)
	int i = index.Find(name)
	if 1 != -1
		return events[i]
	endIf
	return none
EndFunction

bool Function IsStackEmpty()
	return top == 0
EndFunction

Function Push(sr_InfEventBase evnt)
	stack[top] = evnt
	if top < 127
		top += 1
	Else
		inflater.error("Event stack overflow!")
	EndIf
;	inflater.log("Pushed " + evnt.eventName)
EndFunction

sr_InfEventBase Function Pop()
	top -= 1
	if top < 0
		inflater.warn("Tried to pop from an empty stack!")
		top = 0
		return none
	EndIf
	sr_InfEventBase popped = stack[top]
	stack[top] = none
;	inflater.log("Popped " + popped.eventName)
	return popped
EndFunction


int Function QueueAll()
	int i = 0
	int queued = 0
	while i < 128 && events[i] != none
		If events[i].Filter()
			Push(events[i])
			queued += 1
		EndIf
		i += 1
	endWhile
	return queued
EndFunction

Event OnUpdateGameTime()
;	inflater.log("Event OnUpdateGameTime(), stack top: " + top)
	if inflater.GetInflation(inflater.player) > 0.0
		; Only process events if player is inflated
		If IsStackEmpty() ; Stack is empty, iterate through all events and see if any are queued
			intervalSplit = QueueAll()
			if intervalSplit < 1 ; See how many events got queued and execute all of them inside one config interval
				intervalSplit = 1
			EndIf
		EndIf
		If !IsStackEmpty() ; If events are queued, pop and execute the first one
			Pop().Execute()
		EndIf
	ElseIf !IsStackEmpty() ; Events to process when player is not inflated, empty the stack
		inflater.log("Tried to process events without player cum, emptying stack.")
		stack = new sr_InfEventBase[128]
		top = 0
	EndIf 
	DoRegister()
EndEvent 