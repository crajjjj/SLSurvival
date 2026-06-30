Scriptname FWStateWidget extends FWWidgetBase  

FWTextContents property Content auto
GlobalVariable Property GameDaysPassed Auto
FWController property Controller auto
FWAddOnManager property Manager auto

string iFillDirection = "left"
string property CFG_FillDirection
	string function get()
		return iFillDirection
	endFunction
	function set(string dir)
		iFillDirection = DirFormat(dir)
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setFillDirection", dir)
	endFunction
endProperty

int iColor = 0x880044
int property CFG_Color
	int function get()
		return iColor
	endFunction
	function set(int col)
		iColor = col
		UI.InvokeInt(HUD_MENU, WidgetRoot + ".setColor", col)
	endFunction
endProperty

int iDarkColor = 0x880044
int property CFG_DarkColor
	int function get()
		return iDarkColor
	endFunction
	function set(int col)
		iDarkColor = col
		UI.InvokeInt(HUD_MENU, WidgetRoot + ".setDarkColor", col)
	endFunction
endProperty

int iFlashColor = 0xFF55CC
int property CFG_FlashColor
	int function get()
		return iFlashColor
	endFunction
	function set(int col)
		iFlashColor = col
		UI.InvokeInt(HUD_MENU, WidgetRoot + ".setFlashColor", col)
	endFunction
endProperty

string iIconPosition = "left"
string property CFG_IconPosition
	string function get()
		return iIconPosition
	endFunction
	function set(string pos)
		iIconPosition = DirFormat(pos)
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setIconPosition", pos)
	endFunction
endProperty



bool function AllowWidgetFor(actor a)
	return System.IsValidateActor(a)>0 && cfg.Messages<System.MSG_Immersive
endfunction

function Upgrade(int oldVersion, int newVersion)
	if oldVersion<9
		X = CFG_PosX
		Y = CFG_PosY
		HAnchor = CFG_HAnchor
		VAnchor = CFG_VAnchor
	endif
endFunction

function UpdateContent()
	X = CFG_PosX
	Y = CFG_PosY
	HAnchor = CFG_HAnchor
	VAnchor = CFG_VAnchor

	if (Ready)
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setFillDirection", iFillDirection)
		UI.InvokeInt(HUD_MENU, WidgetRoot + ".setColor", iColor)
		UI.InvokeInt(HUD_MENU, WidgetRoot + ".setDarkColor", iDarkColor)
		UI.InvokeInt(HUD_MENU, WidgetRoot + ".setFlashColor", iFlashColor)
		
		if System.IsValidateFemaleActor(Target)>0
			if(System.IsActorPregnantByChaurus(Target))
				; Chaurus
				UI.InvokeString(HUD_MENU, WidgetRoot + ".setPhase", Content.StateID21)
				UI.InvokeInt(HUD_MENU, WidgetRoot + ".setIcon", 21)
				UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPercent", 0)
				UI.InvokeString(HUD_MENU, WidgetRoot + ".setDuration", cfg.GetTimeString(GameDaysPassed.GetValue() - StorageUtil.GetFloatValue(Target, "FW.PauseTime",0),true))
			else
				int stateID = Controller.GetFemaleState(Target)
				float xStateDelay = GameDaysPassed.GetValue() - Controller.GetStateEnterTime(Target)
				string since = cfg.GetTimeString(xStateDelay,true)
				string s=""
				if stateID >= 0
					if stateID < 8
						if stateID < 4
							if stateID < 2
								if stateID==0
									s=Content.StateID0
								else;if stateID==1
									s=Content.StateID1
								endIf
							else
								if stateID==2
									s=Content.StateID2
								else;if stateID==3
									s=Content.StateID3
								endIf
							endIf
						else
							if stateID < 6
								if stateID==4
									s=Content.StateID4
								else;if stateID==5
									s=Content.StateID5
								endIf
							else
								if stateID==6
									s=Content.StateID6
								else;if stateID==7
									s=Content.StateID7
								endIf
							endIf
						endIf
					else
						if stateID==8
							s=Content.StateID8
						else
							s=Content.StateUnknown
						endIf
					endIf
				else
					s=Content.StateUnknown
				endIf
				float statePerc=Controller.GetStatePercentage(Target)
				UI.InvokeString(HUD_MENU, WidgetRoot + ".setPhase", s)
				UI.InvokeInt(HUD_MENU, WidgetRoot + ".setIcon", stateID)
				UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPercent", statePerc)
				if StorageUtil.GetFloatValue(Target, "FW.PauseTime",0)>0
					UI.InvokeString(HUD_MENU, WidgetRoot + ".setDuration", Content.StateUnknown)
				else
					UI.InvokeString(HUD_MENU, WidgetRoot + ".setDuration", since)
				endif
			endif
		elseif System.IsValidateMaleActor(Target)>0
			float virility=Controller.GetVirility(Target)
			float dur = (cfg.MaleVirilityRecovery * Manager.ActorMaleRecoveryScale(Target)) - Controller.GetDaysSinceLastSex(Target)
			UI.InvokeInt(HUD_MENU, WidgetRoot + ".setIcon", 50)
			UI.InvokeString(HUD_MENU, WidgetRoot + ".setPhase", FWUtility.StringReplace(Content.InfoSpell_SpermVirility,"{0}", Math.Floor(virility*100)) + "%")
			if dur<0
				UI.InvokeString(HUD_MENU, WidgetRoot + ".setDuration","")
			else
				UI.InvokeString(HUD_MENU, WidgetRoot + ".setDuration",cfg.GetTimeString(dur,true))
			endif
			UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPercent", virility)
		endif
	endif
endFunction