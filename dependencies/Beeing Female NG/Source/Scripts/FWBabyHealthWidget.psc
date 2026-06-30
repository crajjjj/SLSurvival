Scriptname FWBabyHealthWidget extends FWWidgetBase

FWController property Controller auto

; Cache for getRelativePregnancyChance — the function runs a multi-day cycle
; simulation, so recompute only on phase change or at most once per game hour
; (the chance ramps with time inside a state: egg travel, sperm decay).
Actor lastChanceTarget
int lastChanceStateID = -1
float lastChanceStateEnterTime = -1.0
int lastChanceHour = -1
int lastChanceFertility = -1
float lastChanceValue = 0.0

bool function AllowToHide()
	if Controller.GetFemaleState(Target)<4
		return true
	endif
	return Target!=PlayerRef || StorageUtil.GetFloatValue(Target, "FW.UnbornHealth",100.0)>8
endFunction

bool function AllowWidgetFor(actor a)
	if CFG_Enabled && System.IsValidateFemaleActor(a)>0
		if Controller.GetFemaleState(Target)<4 && cfg.Messages>=System.MSG_Immersive
			return false
		endif
		return true
	endif
	return false
endfunction

event OnWidgetReset()
	parent.OnWidgetReset()
	X = CFG_PosX
	Y = CFG_PosY
	HAnchor = CFG_HAnchor
	VAnchor = CFG_VAnchor
endEvent

function UpdateContent()
	X = CFG_PosX
	Y = CFG_PosY
	HAnchor = CFG_HAnchor
	VAnchor = CFG_VAnchor
	if (Ready)
		int stateID=Controller.GetFemaleState(Target)
		if stateID<4
			UI.InvokeInt(HUD_MENU, WidgetRoot + ".setState",1) ; Set Cycle state
			float curStateEnter = StorageUtil.GetFloatValue(Target, "FW.StateEnterTime", -1.0)
			int curHour = Math.Floor(Utility.GetCurrentGameTime() * 24.0)
			; Drinking a Fertility Tonic changes the chance mid-hour (Gate 2 boost
			; and, for potent/mild, the Gate 1 flag), so include fertility in the
			; cache key - quantized to int so the slow decay doesn't recompute the
			; multi-day simulation every tick (the hourly key already covers decay).
			int curFertility = Controller.getFertility(Target) as int
			if Target != lastChanceTarget || stateID != lastChanceStateID || curStateEnter != lastChanceStateEnterTime || curHour != lastChanceHour || curFertility != lastChanceFertility
				lastChanceTarget = Target
				lastChanceStateID = stateID
				lastChanceStateEnterTime = curStateEnter
				lastChanceHour = curHour
				lastChanceFertility = curFertility
				lastChanceValue = Controller.getRelativePregnancyChance(Target)
			endif
			UI.InvokeInt(HUD_MENU, WidgetRoot + ".setValue", Math.Floor(lastChanceValue))
		else
			UI.InvokeInt(HUD_MENU, WidgetRoot + ".setState",2) ; Set Pregnancy state
			
			if StorageUtil.GetIntValue(Target, "FW.Abortus",0)>1
				; Abortus has already been started
				UI.InvokeInt(HUD_MENU, WidgetRoot + ".setValue",0)
				return
			endif
			float hp = StorageUtil.GetFloatValue(Target, "FW.UnbornHealth",100.0)
			UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setValue",hp)
		endif
	endif
endFunction
