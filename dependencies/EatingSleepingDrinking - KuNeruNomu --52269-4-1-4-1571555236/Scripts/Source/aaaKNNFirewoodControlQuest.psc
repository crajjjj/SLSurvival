Scriptname aaaKNNFirewoodControlQuest extends Quest  

;ReferenceAlias Property heatSource auto
GlobalVariable Property IsNoCameAnim auto
MiscObject Property campFirewood auto
Furniture Property campfireCooking auto
Furniture Property campfireCookingNoCame auto
Message Property aaaKNNCantUseItems auto
GlobalVariable Property aaaKNNIsEnableMessage auto
;Static Property CampfireHeatsourceOverrideNormal auto
bool IsFrostfallInstalled = false

int heatSourceIndex = 0

int Property heatIndex
	int Function Get()
		int newValue = heatSourceIndex
		heatSourceIndex += 1
		if 4 < heatSourceIndex || 0 > heatSourceIndex
			heatSourceIndex = 0
		endIf
		return newValue
	EndFunction
	Function Set(int value)
		heatSourceIndex = value
	EndFunction
EndProperty

bool Function CheckModInstalled()
	if 0xFF != Game.GetModByName("Frostfall.esp")
		IsFrostfallInstalled = true
	endIf
	return IsFrostfallInstalled
	;Debug.Trace("Frostfall.esp -> " + KNNPlugin_Utility.GetModInstalled("Frostfall.esp"))
EndFunction
Event OnInIt()
	CheckModInstalled()
EndEvent
Event KNNOnLoadGame()
	CheckModInstalled()
EndEvent
Furniture Function GetCampfire()
	if 0 == IsNoCameAnim.GetValueInt()
		return campfireCookingNoCame
	endIf
	return campfireCooking
EndFunction
bool Function SetCampfire(ObjectReference firewoodACTI)
	;Actor player = Game.GetPlayer()	
	if 30.0 < Math.abs(firewoodACTI.GetAngleX()) ||  30.0 < Math.abs(firewoodACTI.GetAngleY())
		if 0 != aaaKNNIsEnableMessage.GetValueInt()
			aaaKNNCantUseItems.Show()
		endIf
		return false
	endIf
	ObjectReference campRef = firewoodACTI.PlaceAtMe(GetCampfire())
	if campRef
		campRef.MoveTo(firewoodACTI, 0.0, 0.0, 0.0, true)
		;Debug.Trace("SetCampfire -> " + campRef)
		campRef.SetScale(0.8)
		if IsFrostfallInstalled
			ReferenceAlias heatAlias = GetAlias(heatIndex) as ReferenceAlias
			if heatAlias
				ObjectReference ref = heatAlias.GetReference()
				ref.MoveTo(campRef)
				;Debug.Trace(ref)
			endIf
		endIf
		firewoodACTI.Disable()
		firewoodACTI.Delete()
		return true
	endIf
	return false
EndFunction

Function AddCampfirewood(ObjectReference firewoodACTI, ObjectReference akActionRef)
	akActionRef.AddItem(campFirewood, 1, true)
	firewoodACTI.Disable()
	firewoodACTI.Delete()
EndFunction