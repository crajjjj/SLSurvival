Scriptname FWProgressWidget extends SKI_WidgetBase

int property CFG_PosX auto hidden
int property CFG_PosY auto hidden
bool property CFG_Enabled auto hidden
int property CFG_Alpha auto hidden
float property CFG_Scale = 1.0 auto hidden
string property CFG_HAnchor auto hidden
string property CFG_VAnchor auto hidden


string property ICN_AddOn = "AddOn" autoreadonly
string property ICN_Animation = "Animation" autoreadonly
string property ICN_Compatibility = "Compatibility" autoreadonly
string property ICN_Drip = "Drip" autoreadonly
string property ICN_File = "File" autoreadonly
string property ICN_FileCheck = "FileCheck" autoreadonly
string property ICN_Folicular = "Folicular" autoreadonly
string property ICN_Init = "Init" autoreadonly
string property ICN_Pregnancy = "Pregnancy" autoreadonly
string property ICN_Pregnancy2 = "Pregnancy2" autoreadonly
string property ICN_Pregnancy3 = "Pregnancy3" autoreadonly
string property ICN_Pregnancy4 = "Pregnancy4" autoreadonly
string property ICN_Progress = "Progress" autoreadonly
string property ICN_Replanish = "Replanish" autoreadonly
string property ICN_Search = "Search" autoreadonly
string property ICN_Sound = "Sound" autoreadonly
string property ICN_Sperm = "Sperm" autoreadonly
string property ICN_Text = "Text" autoreadonly
string property ICN_Update = "Update" autoreadonly
string property ICN_Utherus = "Utherus" autoreadonly
string property ICN_Utherus2 = "Utherus2" autoreadonly
string property ICN_Voice = "Voice" autoreadonly
string property ICN_Wait = "Wait" autoreadonly
string property ICN_Checked = "Checked" autoreadonly
string property ICN_Failed = "Failed" autoreadonly

string _swfName = ""
string _scriptName = ""
int _widgetAlpha = 100
bool _shown = false
bool _bAboutToClose=false
bool _bAboutToShow = false

string lastIcon=""
string lastMessage=""
int lastPercent=0

string property SWF_Name
	{Set the SWF Filename like 'Widget.swf'}
	string function get()
		return _swfName
	endFunction

	function set(string value)
		_swfName = value
	endFunction
endProperty

string property Script_Name
	{Set this script name}
	string function get()
		return _scriptName
	endFunction

	function set(string value)
		_scriptName = value
	endFunction
endProperty

bool property Shown hidden
	{Set to true to show the widget}
	bool function get()
		return _shown
	endFunction

	function set(bool value)
		;if(Ready)
			if value == true && CFG_Enabled==true
				X = CFG_PosX
				Y = CFG_PosY
				HAnchor = CFG_HAnchor
				VAnchor = CFG_VAnchor
				_bAboutToClose = false
				_bAboutToShow = true
				;FadeTo(_widgetAlpha,0.5)
				Alpha = CFG_Alpha
				_shown = value
			elseif value == false
				_bAboutToClose=true
				_bAboutToShow = false
				FadeTo(0,1.5)
				_shown = value
			endif
		;elseif value==true
		;	FW_log.WriteLog("fwprogresswidget::Shown = true; Widget not ready jet - wait")
		;	_bAboutToShow = true
		;	RegisterForSingleUpdate(1)
		;endif
	endFunction
endProperty

bool property AboutToClose hidden
	bool function get()
		return _bAboutToClose
	endFunction
	function set(bool value)
		if value==true && _bAboutToClose==false
			Flash()
			RegisterForSingleUpdate(3)
		elseif value==false && _bAboutToClose==true
			UnregisterForUpdate()
		endif
		_bAboutToClose = value
	endFunction
endproperty

string property Icon hidden
	string function get()
		return UI.GetString(HUD_MENU, WidgetRoot + ".getIcon")
	endFunction
	function set(string value)
		;if (Ready)
			;FW_log.WriteLog("fwprogresswidget::Icon = "+value)
			UI.InvokeString(HUD_MENU, WidgetRoot + ".setIcon", value)
			lastIcon = value
		;endif
	endFunction
endProperty

string property Job hidden
	string function get()
		return UI.GetString(HUD_MENU, WidgetRoot + ".getPhase")
	endFunction
	function set(string value)
		;if (Ready)
			;FW_log.WriteLog("fwprogresswidget::Job = "+value)
			UI.InvokeString(HUD_MENU, WidgetRoot + ".setPhase", value)
			lastMessage = value
		;endif
	endFunction
endProperty

int property Percent hidden
	int function get()
		return UI.GetInt(HUD_MENU, WidgetRoot + ".getPercent")
	endFunction
	function set(int value)
		;if (Ready)
			;FW_log.WriteLog("fwprogresswidget::Percent = "+value)
			UI.InvokeInt(HUD_MENU, WidgetRoot + ".setPercent", value)
			lastPercent = value
		;endif
	endFunction
endProperty

event OnWidgetLoad()
	_bAboutToClose=true
	_bAboutToShow = false
	_shown = false
	parent.OnWidgetLoad()
	OnWidgetReset()
	FadeTo(0.0, 0.0) ; parent callbacks may restore alpha to _widgetAlpha=100; re-enforce hidden state
endEvent

function Set(string sJob="", int iPercent=-1, string sIcon="", bool bClose = false)
	if sJob!=""
		Job = sJob
	endif
	if iPercent>=0
		Percent = iPercent
	endif
	if sIcon!=""
		Icon = sIcon
	endif
	if bClose==true
		AboutToClose=true
	elseif _shown==false
		Shown = true
	endif
endFunction

event OnWidgetReset()
	X = CFG_PosX
	Y = CFG_PosY
	HAnchor = CFG_HAnchor
	VAnchor = CFG_VAnchor
	parent.OnWidgetReset()
	UpdateWidgetScale()
	;if _shown==true
	;	Alpha = 100.0
	;else
	;	Alpha = 50.0
	;endif
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setPhase", lastMessage)
	UI.InvokeString(HUD_MENU, WidgetRoot + ".setIcon", lastIcon)
	UI.InvokeInt(HUD_MENU, WidgetRoot + ".setPercent", lastPercent)
	if !_shown
		FadeTo(0, 0.0) ; parent.OnWidgetReset() restores alpha to _widgetAlpha=100; re-enforce hidden state
	endIf
endEvent

function showWidget()
	if CFG_Enabled
		Shown = true
	endif
endFunction

function Flash()
	;if (Ready)
		UI.Invoke(HUD_MENU, WidgetRoot + ".startFlash")
	;endif
endFunction

function hideWidget()
	Shown = false
endFunction

function UpdateWidgetScale()
	if Ready
		float scale = CFG_Scale
		if scale <= 0.0
			scale = 1.0
		endif
		UI.SetFloat(HUD_MENU, WidgetRoot + "._xscale", scale * 100.0)
		UI.SetFloat(HUD_MENU, WidgetRoot + "._yscale", scale * 100.0)
	endIf
endFunction

float function GetWidth()
	if (Ready)
		return UI.GetFloat(HUD_MENU, WidgetRoot + ".Width")
	endIf
	return 0.0
endFunction

float function GetHeight()
	if (Ready)
		return UI.GetFloat(HUD_MENU, WidgetRoot + ".Height")
	endIf
	return 0.0
endFunction

float[] function GetDimensions()
	{Return the dimensions of the widget (width,height).}
	float[] dim = new float[2]
	dim[0] = GetWidth()
	dim[1] = GetHeight()
	return dim
endFunction

String Function GetWidgetSource()
	return "BeeingFemale/"+_swfName
EndFunction

String Function GetWidgetType()
	return _scriptName
EndFunction

event OnUpdate()
	if _bAboutToClose==true
		Shown = false
	elseif _bAboutToShow==true
		Shown = true
	endif
endEvent
