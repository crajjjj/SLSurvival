Scriptname EFFPluginSandbox extends EFFPlugin Conditional

Keyword Property PlayerFollowerSandboxing Auto

ReferenceAlias[] Property XFL_Sandboxers Auto 
ReferenceAlias[] Property XFL_Markers Auto 

Message Property FollowerSandbox Auto

Float Property XFL_MessageMod_State Auto Conditional

bool isGroup = false

int Function GetIdentifier()
	return 0x1004
EndFunction

string Function GetPluginName()
	return "$EFF_Residence"
EndFunction

; akCmd 0 - Start Sandbox
; akCmd 1 - Clear Sandbox
; akForm1 - Receiving Actor
Event OnActionEvent(int akCmd, Form akForm1 = None, Form akForm2 = None, int aiValue1 = 0, int aiValue2 = 0)
	If akCmd == 0
		XFL_StartSandboxing(akForm1 as Actor)
	Elseif akCmd == 1
		XFL_ClearAlias(akForm1 as Actor)
	Endif
EndEvent

; Sets the followers sandbox location, relocates it if they are already sandboxing
Function XFL_StartSandboxing(Actor follower)
	If follower.HasKeyword(PlayerFollowerSandboxing)
		XFL_Markers[XFL_GetIndex(follower)].GetRef().MoveTo(follower)
	Else
		XFL_SetAlias(follower)
	Endif
EndFunction

int Function XFL_GetIndex(Actor follower)
	int i = 0
	While i < XFL_Sandboxers.Length
		If (XFL_Sandboxers[i].GetReference() as Actor) == follower
			return i
		EndIf
		i += 1
	EndWhile
	return -1
EndFunction

; Sets the followers sandbox location
Function XFL_SetAlias(Actor follower)
	int i = 0
	While i < XFL_Sandboxers.Length
		If XFL_Sandboxers[i].ForceRefIfEmpty(follower)
			XFL_Markers[i].GetReference().MoveTo(follower)
			return
		EndIf
		i += 1
	EndWhile
EndFunction

; Clears the alias by actor
Function XFL_ClearAlias(Actor follower)
	int i = 0
	While i < XFL_Sandboxers.Length
		If (XFL_Sandboxers[i].GetReference() as Actor) == follower
			XFL_Sandboxers[i].Clear()
			return
		EndIf
		i += 1
	EndWhile
EndFunction

Function XFL_ForceClearAll()
	int i = 0
	While i < XFL_Sandboxers.Length
		If XFL_Sandboxers[i]
			XFL_Sandboxers[i].TryToClear()
		EndIf
		i += 1
	EndWhile
EndFunction

Event OnDisabled()
	XFL_ForceClearAll()
EndEvent

; All of these plugin events will stop the follower from collecting
Event OnPluginEvent(int akType, ObjectReference akRef1 = None, ObjectReference akRef2 = None, int aiValue1 = 0, int aiValue2 = 0)
	If akType == -1 ; Clearall happens before the actual event
		XFL_ForceClearAll()
	Endif
EndEvent

; Menu hierarchy
Function activateMenu(int page, Form akForm) ; Re-implement
	isGroup = false
	XFL_TriggerMenu(akForm, FollowerMenu.GetMenuState("MenuSandbox"), FollowerMenu.GetMenuState("PluginMenu"), page)
EndFunction

Function activateGroupMenu(int page, Form akForm) ; Re-implement
	isGroup = true
	XFL_TriggerMenu(akForm, FollowerMenu.GetMenuState("MenuSandbox"), FollowerMenu.GetMenuState("PluginMenu"), page)
EndFunction

Bool Function showMenu(Form akForm) ; Re-implement
	return true
EndFunction

Bool Function showGroupMenu() ; Re-implement
	return true
EndFunction

Function activateSubMenu(Form akForm, string previousState = "", int page = 0)
	; Do nothing in blank state
EndFunction

Function XFL_TriggerMenu(Form akForm, string menuState = "", string previousState = "", int page = 0)
	GoToState(menuState)
	activateSubMenu(akForm, previousState, page)
EndFunction

State MenuSandbox_Classic
	Function activateSubMenu(Form akForm, string previousState = "", int page = 0)
		Int Sandbox_Set = 0
		Int Sandbox_Clear = 1
		Int Sandbox_Back = 2
		Int Sandbox_Exit = 3
		
		If previousState != ""
			FollowerMenu.XFL_MessageMod_Back = 1
		EndIf
		
		Actor actorRef = None
		If !isGroup
			actorRef = akForm as Actor
		Endif
		
		If actorRef != None
			XFL_MessageMod_State = actorRef.HasKeyword(PlayerFollowerSandboxing) as Int
		Else
			XFL_MessageMod_State = 0
		Endif
		
		int ret = FollowerSandbox.Show()
		If ret < Sandbox_Back
			FollowerMenu.OnFinishMenu()
			XFLMain.XFL_SendActionEvent(GetIdentifier(), ret, actorRef)
		Elseif ret == Sandbox_Back
			FollowerMenu.XFL_TriggerMenu(akForm, FollowerMenu.GetMenuState("PluginMenu"), FollowerMenu.GetParentState("PluginMenu"), page) ; Force a back all the way to the plugin menu
		Elseif ret == Sandbox_Exit
			FollowerMenu.OnFinishMenu()
		EndIf
		
		GoToState("")
	EndFunction
EndState

; New menu system info
string[] Function GetMenuEntries(Form akForm)
	string[] entries = new string[3]
	int itemOffset = GetIdentifier() * 100
	entries[0] = GetPluginName() + ";;" + -1 + ";;" + GetIdentifier() + ";;" + 0 + ";;1"
	entries[1] = "$EFF_Set" + ";;" + GetIdentifier() + ";;" + (itemOffset + 0) + ";;" + 0 + ";;0"
	entries[2] = "$EFF_Clear" + ";;" + GetIdentifier() + ";;" + (itemOffset + 1) + ";;" + 1 + ";;0"
	return entries
EndFunction

Event OnMenuEntryTriggered(Form akForm, int itemId, int callback)
	XFLMain.XFL_SendActionEvent(GetIdentifier(), callback, akForm)
EndEvent