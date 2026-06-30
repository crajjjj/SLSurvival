Scriptname FWContraceptionWidget extends FWWidgetBase  

GlobalVariable Property GameDaysPassed Auto
FWController property Controller auto
FWTextContents property Content auto

string iFillDirection = "right"
string property CFG_FillDirection
	string function get()
		return iFillDirection
	endFunction
	function set(string dir)
		iFillDirection = DirFormat(dir)
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setFillDirection", dir)
	endFunction
endProperty

int iColor = 0x440088
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

int iFlashColor = 0xCC55FF
int property CFG_FlashColor
	int function get()
		return iFlashColor
	endFunction
	function set(int col)
		iFlashColor = col
		UI.InvokeInt(HUD_MENU, WidgetRoot + ".setFlashColor", col)
	endFunction
endProperty

string iIconPosition = "right"
string property CFG_IconPosition
	string function get()
		return iIconPosition
	endFunction
	function set(string pos)
		iIconPosition = DirFormat(pos)
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setIconPosition", pos)
	endFunction
endProperty



event OnWidgetReset()
	parent.OnWidgetReset()
	if GetType()==77
		RegisterForUpdateGameTime(0.25)
	endif
endEvent

function Upgrade(int oldVersion, int newVersion)
	System.UpdateState=0x41
	if oldVersion<9
		X = CFG_PosX
		Y = CFG_PosY
		HAnchor = CFG_HAnchor
		VAnchor = CFG_VAnchor
	endif
	System.UpdateState=0x42
endFunction

event OnUpdateGameTime()
	if AllowToHide()==false
		showTargeTimed(Target)
	endif
endEvent

bool function AllowWidgetFor(actor a)
	return StorageUtil.GetFloatValue(a,"FW.ContraceptionTime",0)>0 && StorageUtil.GetFloatValue(a,"FW.ContraceptionTime",0) - 8 < GameDaysPassed.GetValue() && System.IsValidateFemaleActor(a)>0
endfunction

bool function AllowToHide()
	if Target!=PlayerRef
		return true
	endif
	float ct =StorageUtil.GetFloatValue(Target,"FW.ContraceptionTime",0)
	if ct>0
		float gt =GameDaysPassed.GetValue() - System.GetPillDuration(Target)
		return gt - ct < -0.5 || gt-ct > 0.5
	else
		return true
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
			float Contraception = Controller.GetContraception(Target)
			float lastC = StorageUtil.GetFloatValue(Target,"FW.ContraceptionTime",0)
			if(Contraception>0.02 && lastC>0)
				float fsince = System.GetPillDuration(Target) - ( GameDaysPassed.GetValue() - lastC)
				string since = cfg.GetTimeString(fsince, True, Content.InfoSpell_Overdue, false)
				UI.InvokeString(HUD_MENU, WidgetRoot + ".setDuration", since)
			else
				UI.InvokeString(HUD_MENU, WidgetRoot + ".setDuration", "")
			endif
			UI.InvokeString(HUD_MENU, WidgetRoot + ".setValue", FWUtility.StringReplace(content.InfoSpell_Contraception,"{0}", Math.Ceiling(Contraception)))
			UI.InvokeFloat(HUD_MENU, WidgetRoot + ".setPercent", Contraception / 100)
		endif
	endif
endFunction
