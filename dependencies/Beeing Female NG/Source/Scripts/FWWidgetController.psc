Scriptname FWWidgetController extends Quest  

FWSystem Property System auto

FWWidgetBase property StateWidget auto
FWWidgetBase property BabyHealthWidget auto
FWWidgetBase property ContraceptionWidget auto

bool _AllowHotkey = true

float KeyPressTime = 0.0
bool _shown = false
float iTime=0.0

FWSystemConfig property cfg auto
FWController property Controller auto
Actor Property PlayerRef Auto

bool property AllowHotkey
	bool function get()
		return _AllowHotkey
	endFunction
	
	function set(bool bAllow)
		_AllowHotkey = bAllow
		updateConfig()
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


function updateConfig()
	UnregisterForAllKeys()
	if _AllowHotkey==true
		RegisterForKey(HotKey)
	endif
endFunction

Event OnPlayerLoadGame()
	_shown = false
	updateConfig()
EndEvent



function updatePositions()
	StateWidget.UpdateWidgetHAnchor()
	StateWidget.UpdateWidgetVAnchor()
	StateWidget.UpdateWidgetPositionX()
	StateWidget.UpdateWidgetPositionY()
	
	BabyHealthWidget.UpdateWidgetHAnchor()
	BabyHealthWidget.UpdateWidgetVAnchor()
	BabyHealthWidget.UpdateWidgetPositionX()
	BabyHealthWidget.UpdateWidgetPositionY()
	
	ContraceptionWidget.UpdateWidgetHAnchor()
	ContraceptionWidget.UpdateWidgetVAnchor()
	ContraceptionWidget.UpdateWidgetPositionX()
	ContraceptionWidget.UpdateWidgetPositionY()
endFunction

event OnKeyDown(int keyCode)
	;Debug.Notification("Widget1 " + !_shown + " / " + AllowWidgetFor(PlayerRef))
	if !_shown && !Utility.IsInMenuMode() ;Patched by qotsafan
		iTime=0
		updatePositions()
		StateWidget.UpdateContent()
		BabyHealthWidget.UpdateContent()
		ContraceptionWidget.UpdateContent()
	endif
endEvent

event OnKeyUp(int keyCode, float holdTime)
	if !Utility.IsInMenuMode() ;Patched by qotsafan
		if holdTime>5
			Controller.showRankedInfoBox(PlayerRef,100)
		elseif holdTime>1.2 && _shown==false
			; The key was pressed for above 1.2 seconds - the widget has to stay visible
			showWidgets()
		elseif _shown==true
			; The widget was already visible hide it atain
			hideWidgets()
		else
			; Show widget for a few seconds, then hide it again
			showWidgets()
			RegisterForSingleUpdate(5)
		endif
	endif
endEvent

function showWidgets()
	_shown = true
	StateWidget.showWidget()
	BabyHealthWidget.showWidget()
	ContraceptionWidget.showWidget()
endFunction

function hideWidgets()
	_shown = false
	StateWidget.hideWidget()
	BabyHealthWidget.hideWidget()
	ContraceptionWidget.hideWidget()
endFunction

event OnUpdate()
	hideWidgets()
endEvent