Scriptname FWWidgetBase extends ski_widgetbase  
FWSystem Property System auto

int property CFG_PosX auto hidden
int property CFG_PosY auto hidden
bool property CFG_Enabled auto hidden
int property CFG_Alpha auto hidden
float property CFG_Scale = 1.0 auto hidden

;string sCFG_HAnchor
string property CFG_HAnchor
	string function get()
		return HAnchor
	endFunction
	function set(string value)
		HAnchor = DirFormat(value)
		UpdateWidgetHAnchor()
	endFunction
endProperty

;string sCFG_VAnchor
string property CFG_VAnchor
	string function get()
		return VAnchor
	endFunction
	function set(string value)
		VAnchor = DirFormat(value)
		UpdateWidgetVAnchor()
	endFunction
endProperty


bool _shown = false
int _widgetAlpha = 100
int _displayTime = 1
string _swfName = ""
string _scriptName = ""
bool _AllowHotkey = true
int iTime=0
float startTime = 0.0
float VisibilityStart = 0.0
bool StayVisible = false
float property UpdateDelay = 5.0 auto

FWSystemConfig property cfg auto
Actor Property PlayerRef Auto

float DefaultWidgetFadeOutTime = 3.0
float DefaultWidgetFlashShowTime = 0.01
float DefaultWidgetNoFlashShowTime = 0.2

float WidgetFadeOutTime
float WidgetFlashShowTime
float WidgetNoFlashShowTime

string function DirFormat(string value)
	if value=="Left"||value=="LEFT"
		return "left"
	endif
	if value=="Right"||value=="RIGHT"
		return "right"
	endif
	if value=="Top"||value=="TOP"
		return "top"
	endif
	if value=="Bottom"||value=="BOTTOM"
		return "bottom"
	endif
	if value=="Both"||value=="BOTH"
		return "both"
	endif
	if value=="Center"||value=="CENTER"
		return "center"
	endif
	if value=="True"||value=="TRUE"
		return "true"
	endif
	if value=="False"||value=="False"
		return "false"
	endif
	return value
endFunction

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

bool property Shown
	{Set to true to show the widget}
	bool function get()
		return _shown
	endFunction

	function set(bool value)
		if value;/==true/; && _shown==false && CFG_Enabled;/==true/;
			ShowWidget()
			_shown = value
		else;if value == false && _shown;/==true/;
			if value ;Tkc (Loverslab) optimization
			else;if value == false
				if _shown;/==true/;
					HideWidget()
					_shown = value
				endif
			endif
		endif
	endFunction
endProperty

int property WidgetAlpha
	{Set the alpha value of the widget (in percent 0 ... 100)}
	int function get()
		return _widgetAlpha
	endFunction

	function set(int value)
		_widgetAlpha = value
	endFunction
endProperty

int property Hotkey hidden
	{The hotkey used to display the widget.}
	int function get()
		return cfg.KeyStateWidget
	endFunction
	
	function set(int value)
		cfg.KeyStateWidget = value
		updateConfig()
	endFunction
endProperty

int property DisplayTime
	{The time the widget is displayed if control mode is set to "timedHotkey".}
	int function get()
		return _displayTime
	endFunction
	
	function set(int time)
		_displayTime = time
	endFunction
endProperty

bool property AllowHotkey
	bool function get()
		return _AllowHotkey
	endFunction
	
	function set(bool bAllow)
		_AllowHotkey = bAllow
		updateConfig()
	endFunction
endProperty

actor property Target auto hidden



bool function AllowToHide()
	return true
endFunction

bool function AllowWidgetFor(actor a)
	return CFG_Enabled
endfunction


function Upgrade(int oldVersion, int newVersion)
endFunction

event OnWidgetReset()
	parent.OnWidgetReset()
	_shown = false
	_AllowHotkey = true
	iTime=0
	startTime = 0.0
	updateConfig()
	UpdateContent()
	UpdateWidgetScale()
	if cfg && cfg.WidgetAlwaysActive && CFG_Enabled
		showWidget()
	else
		FadeTo(0, 0.0) ; parent.OnWidgetReset() restores alpha to _widgetAlpha=100; re-enforce hidden state
	endIf
endEvent

event OnWidgetLoad()
	_shown = false
	iTime=0
	startTime = 0.0
	parent.OnWidgetLoad()
	OnWidgetReset()
endEvent

event OnKeyUp(int keyCode, float holdTime)
	; If the key was pressed on loading-screen and released after, 
	; make sure the widget is visible
	;OnKeyDown(keyCode)
	;Debug.Notification("Widget3")
	
	;startTime = Utility.GetCurrentRealTime()
	;if holdTime>3
		; The key was pressed for above 3 seconds - the widget has to stay visible
		;StayVisible = true
		;Debug.Notification("Widget4")
	;elseif Utility.GetCurrentRealTime() - VisibilityStart > _displayTime && VisibilityStart>0.0
		; The widget was already visible hide it atain
		;hideWidget()
		;StayVisible = false
		;Debug.Notification("Widget5")
	;else
		; Show widget for a few seconds, then hide it again
		;StayVisible = false
		;Debug.Notification("Widget6")
	;endif
endEvent

function updateConfig()
	if GetType()==77
		UnregisterForAllKeys()
		UnregisterForModEvent("BeeingFemale")
		RegisterForModEvent("BeeingFemale", "BeeingFemaleEvent")
	endif
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

Event BeeingFemaleEvent(string eventName, string strArg, float numArg, Form sender)
	if eventName=="BeeingFemale" && strArg=="ResetWidgets"
		UnregisterForUpdate()
		
		WidgetFadeOutTime = StorageUtil.GetFloatValue(none, "FW.AddOn.Global_WidgetFadeOutTime", DefaultWidgetFadeOutTime)
		if(WidgetFadeOutTime > 0.0)
		else
			WidgetFadeOutTime = DefaultWidgetFadeOutTime
		endIf
		
		if(Ready)
;			FadeTo(0, 3.0)
			FadeTo(0, WidgetFadeOutTime)
		endIf
		_shown = false
		iTime=0
		startTime = 0.0
		updateConfig()
		UpdateContent()
		if cfg && cfg.WidgetAlwaysActive && CFG_Enabled
			showWidget()
		endIf
	endif
endEvent


function showWidget(bool Flash = false)
	if(Ready && !_shown) && CFG_Enabled
		_shown = true
		if AllowWidgetFor(PlayerRef) ;Tkc (Loverslab) optimization
		else;if AllowWidgetFor(System.PlayerRef)==false
			return
		endif
		Target = PlayerRef
		if Flash;/==true/;
			WidgetFlashShowTime = StorageUtil.GetFloatValue(none, "FW.AddOn.Global_WidgetFlashShowTime", DefaultWidgetFlashShowTime)
			if(WidgetFlashShowTime > 0.0)
			else
				WidgetFlashShowTime = DefaultWidgetFlashShowTime
			endIf
		
;			FadeTo(CFG_Alpha,0.01)
			FadeTo(CFG_Alpha, WidgetFlashShowTime)
			Flash()
		else
			WidgetNoFlashShowTime = StorageUtil.GetFloatValue(none, "FW.AddOn.Global_WidgetNoFlashShowTime", DefaultWidgetNoFlashShowTime)
			if(WidgetNoFlashShowTime > 0.0)
			else
				WidgetNoFlashShowTime = DefaultWidgetNoFlashShowTime
			endIf
		
;			FadeTo(CFG_Alpha, 0.2)
			FadeTo(CFG_Alpha, WidgetNoFlashShowTime)
		endif
		RegisterForUpdate(UpdateDelay)
	elseif(Ready && Flash)
		Flash()
	endIf
endFunction

function showTimed(bool Flash = false)
	WidgetFadeOutTime = StorageUtil.GetFloatValue(none, "FW.AddOn.Global_WidgetFadeOutTime", DefaultWidgetFadeOutTime)
	if(WidgetFadeOutTime > 0.0)
	else
		WidgetFadeOutTime = DefaultWidgetFadeOutTime
	endIf

	showWidget(Flash)
;	Utility.Wait(3)
	Utility.Wait(WidgetFadeOutTime)
	hideWidget()
endFunction

function showTargetWidget(actor A, bool Flash = false)
	if(Ready && !_shown) && CFG_Enabled
		_shown = true
		if AllowWidgetFor(PlayerRef) ;Tkc (Loverslab) optimization
		else;if AllowWidgetFor(System.PlayerRef)==false
			return
		endif
		Target = A
		if Flash;/==true/;
			WidgetFlashShowTime = StorageUtil.GetFloatValue(none, "FW.AddOn.Global_WidgetFlashShowTime", DefaultWidgetFlashShowTime)
			if(WidgetFlashShowTime > 0.0)
			else
				WidgetFlashShowTime = DefaultWidgetFlashShowTime
			endIf

;			FadeTo(CFG_Alpha,0.01)
			FadeTo(CFG_Alpha, WidgetFlashShowTime)
			Flash()
		else
			WidgetNoFlashShowTime = StorageUtil.GetFloatValue(none, "FW.AddOn.Global_WidgetNoFlashShowTime", DefaultWidgetNoFlashShowTime)
			if(WidgetNoFlashShowTime > 0.0)
			else
				WidgetNoFlashShowTime = DefaultWidgetNoFlashShowTime
			endIf

;			FadeTo(CFG_Alpha, 0.2)
			FadeTo(CFG_Alpha, WidgetNoFlashShowTime)
		endif
		RegisterForUpdate(UpdateDelay)
	elseif(Ready && Flash)
		Flash()
	endIf
endFunction

function showTargeTimed(actor A,bool Flash = false)
	if CFG_Enabled
		WidgetFadeOutTime = StorageUtil.GetFloatValue(none, "FW.AddOn.Global_WidgetFadeOutTime", DefaultWidgetFadeOutTime)
		if(WidgetFadeOutTime > 0.0)
		else
			WidgetFadeOutTime = DefaultWidgetFadeOutTime
		endIf

		showTargetWidget(a,Flash)
;		Utility.Wait(3)
		Utility.Wait(WidgetFadeOutTime)
		hideWidget()
	endif
endFunction

event OnUpdate()
	UpdateContent()
endEvent

function Flash()
	UI.Invoke(HUD_MENU, WidgetRoot + ".startFlash")
endFunction

function hideWidget()
	if cfg && cfg.WidgetAlwaysActive && CFG_Enabled
		return
	endIf
	if self.GetType() == 77
		UnregisterForUpdate()
	endif
	if(Ready)
		WidgetFadeOutTime = StorageUtil.GetFloatValue(none, "FW.AddOn.Global_WidgetFadeOutTime", DefaultWidgetFadeOutTime)
		if(WidgetFadeOutTime > 0.0)
		else
			WidgetFadeOutTime = DefaultWidgetFadeOutTime
		endIf

;		FadeTo(0, 3.0)
		FadeTo(0, WidgetFadeOutTime)
	endIf
	_shown = false
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

function UpdateContent()
endFunction

; 04.06.2019 Tkc (Loverslab) optimizations:  System.PlayerRef replaced by PlayerRef(it already was in attached properties but didnt used). Other changes marked with "Tkc (Loverslab)" comment
