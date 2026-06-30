Scriptname FWCoupleWidget extends ski_widgetbase

int property CFG_PosX auto hidden
int property CFG_PosY auto hidden
bool property CFG_Enabled auto hidden
int property CFG_Alpha auto hidden
float property CFG_Scale = 0.5 auto hidden
string property CFG_HAnchor auto hidden
string property CFG_VAnchor auto hidden

string _swfName = ""
string _scriptName = ""
int _widgetAlpha = 0;100
FWSystem property System auto
;AssociationType spouse
bool bIsInUpdate=false
bool bEnabled = false

AssociationType Property Spouse Auto
Actor Property PlayerRef Auto

bool property enabled
	bool function get()
		return bEnabled
	endFunction
	function set(bool val)
		bEnabled = val
		if val==false
			FadeTo(0, 0)
			_widgetAlpha=0
		else
			_widgetAlpha=100
		endif
		updateConfig()
	endFunction
endProperty

actor _female = none
string _name = ""
string _file = ""
string _mod = ""
string _id = ""

actor property Female
	actor function get()
		return _female
	endFunction

	function set(actor value)
		if bIsInUpdate
			UnregisterForUpdate()
			bIsInUpdate=false
		endif
		if value!=none
			if value==_female
				return
			elseif value.GetLeveledActorBase().GetSex()==1
				_female = value
				_name = value.GetLeveledActorBase().GetName()
				_file = GetWomanID()
				findSpouse()
				RefreshAll()
				showWidget()
				if JsonUtil.HasStringValue(JsonFile, "Name")==false
					JsonUtil.SetStringValue(JsonFile, "Name", _name)
				endif
				;Debug.Notification("NPC selected: "+_name)
				if JsonUtil.HasFormValue(JsonFile, "Husband")==false
					RegisterForUpdate(5)
					bIsInUpdate = true
				elseif JsonUtil.GetFormValue(JsonFile, "Husband")==none
					RegisterForUpdate(5)
					bIsInUpdate = true
				endif
			else
				;Debug.Notification("Not a female char")
				hideWidget()
			endif
		else
			;Debug.Notification("Char was none")
			hideWidget()
		endif
	endFunction
endProperty

string property JsonFile
	string function get()
		if _file==""
			return ""
		else
			string path = "../../../BeeingFemale/Couples/"
			string Full = path + _file
			return full
		endif
	endFunction
endProperty

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

event OnWidgetReset()
	X = CFG_PosX
	Y = CFG_PosY
	HAnchor = CFG_HAnchor
	VAnchor = CFG_VAnchor
	female = none
	_name=""
	;spouse = Game.GetFormFromFile(0x142CA,"Skyrim.esm") as AssociationType
	parent.OnWidgetReset()
	updateConfig()
	UpdateContent()
	UpdateWidgetScale()
endEvent

event OnWidgetLoad()
	parent.OnWidgetLoad()
	OnWidgetReset()
endEvent

string function GetWomanID()
	_mod = FWUtility.GetModFromID(_female,false)
	_id = FWUtility.Hex(_female.GetFormID(), 6)
	return FWUtility.GetJsonFileCombine(_mod,_id)
endFunction

function hideWidget()
	if(Ready)
		;Debug.Notification("Hide Widget")
		FadeTo(0, 3.0)
	endIf
endFunction

function showWidget()
	if(Ready && CFG_Enabled)
		;Debug.Notification("Show Widget")
		X = CFG_PosX
		Y = CFG_PosY
		HAnchor = CFG_HAnchor
		VAnchor = CFG_VAnchor
		UI.InvokeBool(HUD_MENU, WidgetRoot + ".setVisible", true)
		FadeTo(CFG_Alpha, 0.2)
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

Event OnUpdate()
	findSpouse()
endEvent

function findSpouse()
	if _female==false
		return
	endif
	if JsonUtil.HasFormValue(JsonFile, "Husband")
		if JsonUtil.GetFormValue(JsonFile, "Husband") != none
			if bIsInUpdate
				bIsInUpdate=false
				UnregisterForUpdate()
			endif
			return
		endif
	endif
	; Search for Spouse
	actor a1 = Game.FindClosestActorFromRef(PlayerRef, 1000)
	actor a2 = Game.FindClosestActorFromRef(_female, 1000)
	actor a3 = Game.FindRandomActorFromRef(_female, 1000)
	actor a4 = Game.FindRandomActorFromRef(_female, 1000)
	actor a5 = Game.FindRandomActorFromRef(_female, 1000)
	if IsSpouse(a1)
		JsonUtil.SetFormValue(JsonFile, "Husband", a1)
		if(Ready)
			UI.InvokeString(HUD_MENU, WidgetRoot + ".setHusband", a1.GetLeveledActorBase().GetName())
		endif
	elseif IsSpouse(a2)
		JsonUtil.SetFormValue(JsonFile, "Husband", a2)
		if(Ready)
			UI.InvokeString(HUD_MENU, WidgetRoot + ".setHusband", a2.GetLeveledActorBase().GetName())
		endif
	elseif IsSpouse(a3)
		JsonUtil.SetFormValue(JsonFile, "Husband", a3)
		if(Ready)
			UI.InvokeString(HUD_MENU, WidgetRoot + ".setHusband", a3.GetLeveledActorBase().GetName())
		endif
	elseif IsSpouse(a4)
		JsonUtil.SetFormValue(JsonFile, "Husband", a4)
		if(Ready)
			UI.InvokeString(HUD_MENU, WidgetRoot + ".setHusband", a4.GetLeveledActorBase().GetName())
		endif
	elseif IsSpouse(a5)
		JsonUtil.SetFormValue(JsonFile, "Husband", a5)
		if(Ready)
			UI.InvokeString(HUD_MENU, WidgetRoot + ".setHusband", a5.GetLeveledActorBase().GetName())
		endif
	endif
endFunction

bool function IsSpouse(actor a)
	; 4 - Lover
	; 3 - Ally
	; 2 - Confidant
	; 1 - Friend
	; 0 - Acquaintance
	; -1 - Rival
	; -2 - Foe
	; -3 - Enemy
	; -4 - Archnemesis
	; int Function GetRelationshipRank(Actor akOther)
	; bool Function HasAssociation(AssociationType akAssociation, Actor akOther = None)
	if _female!=none
		if a!=none
			if (a.GetRelationshipRank(_female) >= 4 || _female.GetRelationshipRank(a) >=4) && a.IsChild()==false
				return true
			elseif a.HasAssociation(spouse, _female) || _female.HasAssociation(spouse, a)
				return true
			endif
		endif
	endif
	return false
endFunction

function updateConfig()
	if GetType()==77
		UnregisterForAllKeys()
		
		if(bEnabled)
			RegisterForKey(0x12) ; E
			RegisterForKey(0x23) ; H
			RegisterForKey(0x22) ; G
			RegisterForKey(0x19) ; P
			Debug.Notification("Couple Widget Key-Events registrated")
		endif
	endif
endFunction

actor xTarget = none
event OnKeyDown(int keyCode)
	if bEnabled==true
		if keyCode == 0x12
			xTarget = Game.GetCurrentCrosshairRef() as Actor
		endif
	endif
endEvent

function ConvertAllFromActorBase()
	int c = StorageUtil.FormListCount(none, "FW.SavedNPCs")
	Debug.Notification("Start converting: " + c+ " NPCs")
	string xp1 = "../../../BeeingFemale/Couples/ActorBase/"
	string xp2 = "../../../BeeingFemale/Couples/"
	while c>0
		c-=1
		actor a = StorageUtil.FormListGet(none, "FW.SavedNPCs",c) as actor
		string _m = FWUtility.GetModFromID(a,false)
		string _h = FWUtility.Hex(a.GetLeveledActorBase().GetFormID(),6)
		string _h1 = xp1 + FWUtility.GetJsonFileCombine(_m,_h)
		;Debug.Notification(FWUtility.GetJsonFileCombine(_m,_h))
		if JsonUtil.HasFormValue(_h1,"Husband") || JsonUtil.FormListCount(_h1,"Affairs")>0 || JsonUtil.FormListCount(_h1,"Partners")>0
			Debug.Notification("convert " + a.GetLeveledActorBase().GetName())
			string _h2 = xp2 + FWUtility.GetJsonFileCombine(_m,FWUtility.Hex(a.GetFormID(),6))
			
			; Convert Husband
			JsonUtil.SetFormValue(_h2, "Husband", JsonUtil.GetFormValue(_h1,"Husband"))
			
			; Convert Affair
			int c2 = JsonUtil.FormListCount(_h1, "Affairs")
			while c2>0
				c2-=1
				JsonUtil.FormListAdd(_h2, "Affairs", JsonUtil.FormListGet(_h1, "Affairs", c2))
			endWhile
			
			; Convert Partners
			c2 = JsonUtil.FormListCount(_h1, "Partners")
			while c2>0
				c2-=1
				JsonUtil.FormListAdd(_h2, "Partners", JsonUtil.FormListGet(_h1, "Partners", c2))
			endWhile
			
			; Save
			JsonUtil.Save(_h2)
		endif
	endWhile
	Debug.MessageBox("Convert done")
endFunction



event OnKeyUp(int keyCode, float holdTime)
	if bEnabled==false
		return
	endif
	actor targetNpc = Game.GetCurrentCrosshairRef() as Actor
	if targetNpc == none
		if xTarget != none
			targetNpc =xTarget
		endif
	endif
	xTarget = none
	if targetNpc==none ; unselect the woman, when the keywas E
		if keyCode == 0x12
			if holdTime > 1.5
				female = none
			endif
		endif
		return
	endif
	if JsonUtil.HasFormValue(JsonFile, "Husband")==false
		if IsSpouse(targetNpc)
			if bIsInUpdate
				bIsInUpdate=false
				UnregisterForUpdate()
			endif
			JsonUtil.SetFormValue(JsonFile, "Husband", targetNpc)
			if(Ready)
				UI.InvokeString(HUD_MENU, WidgetRoot + ".setHusband", targetNpc.GetLeveledActorBase().GetName())
			endif
		endif
	elseif JsonUtil.GetFormValue(JsonFile, "Husband")==none
		if IsSpouse(targetNpc)
			if bIsInUpdate
				bIsInUpdate=false
				UnregisterForUpdate()
			endif
			JsonUtil.SetFormValue(JsonFile, "Husband", targetNpc)
			if(Ready)
				UI.InvokeString(HUD_MENU, WidgetRoot + ".setHusband", targetNpc.GetLeveledActorBase().GetName())
			endif
		endif
	endif
	
	
	if keyCode == 0x12
		;Debug.Notification("KeyPressEvent raised: E")
		if holdTime > 1.5 && targetNpc!=none && System.IsValidateFemaleActor(targetNpc)
			female = targetNpc
		elseif holdTime > 1.0
			female = none
		endif
	elseif keyCode== 0x23 && holdTime>1.5 && _name!="" && targetNpc!=none
		;Debug.Notification("KeyPressEvent raised: H")
		if System.IsValidateMaleActor(targetNpc) && _female.GetRelationshipRank(targetNpc)>=0
			if JsonUtil.GetFormValue(JsonFile, "Husband") == targetNpc
				if bIsInUpdate==false
					bIsInUpdate=true
					RegisterForUpdate(5)
				endif
				JsonUtil.UnsetFormValue(JsonFile, "Husband")
			else
				if bIsInUpdate
					bIsInUpdate=false
					UnregisterForUpdate()
				endif
				JsonUtil.SetFormValue(JsonFile, "Husband", targetNpc)
				if(Ready)
					UI.InvokeString(HUD_MENU, WidgetRoot + ".setHusband", targetNpc.GetLeveledActorBase().GetName())
				endif
			endif
		elseif !System.IsValidateMaleActor(targetNpc) && _female.GetRelationshipRank(targetNpc)>=0
			JsonUtil.UnsetFormValue(JsonFile, "Husband")
		endif
	elseif keyCode== 0x22 && holdTime>1.5 && _name!="" && targetNpc!=none
		;Debug.Notification("KeyPressEvent raised: A")
		if System.IsValidateActor(targetNpc) && _female.GetRelationshipRank(targetNpc)>=0
			if JsonUtil.FormListHas(JsonFile, "Affairs", targetNpc)
				JsonUtil.FormListRemove(JsonFile, "Affairs", targetNpc)
				RefreshAffair()
			else
				JsonUtil.FormListAdd(JsonFile, "Affairs", targetNpc)
				if(Ready)
					UI.InvokeString(HUD_MENU, WidgetRoot + ".addAffair", targetNpc.GetLeveledActorBase().GetName())
				endif
			endif
		endif
	elseif keyCode== 0x19 && holdTime>1.5 && _name!="" && targetNpc!=none
		;Debug.Notification("KeyPressEvent raised: P")
		if System.IsValidateActor(targetNpc) && _female.GetRelationshipRank(targetNpc)>=0
			if JsonUtil.FormListHas(JsonFile, "Partners", targetNpc)
				JsonUtil.FormListRemove(JsonFile, "Partners", targetNpc)
				RefreshPartner()
			else
				JsonUtil.FormListAdd(JsonFile, "Partners", targetNpc)
				if(Ready)
					UI.InvokeString(HUD_MENU, WidgetRoot + ".addPartner", targetNpc.GetLeveledActorBase().GetName())
				endif
			endif
		endif
	endif
endEvent

function RefreshAll()
	if(Ready)
		if _name!=""
			; NPC Name
			string[] s = new String[3]
			s[0] = _name
			s[1] = _id
			s[2] = _mod
			UI.InvokeStringA(HUD_MENU, WidgetRoot + ".setNPC", s)
		endif
	endif
	RefreshHusband()
	RefreshAffair()
	RefreshPartner()
endFunction

function RefreshHusband()
	if(Ready)
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setHusband", "")
		if _name!=""
			actor Husband = JsonUtil.GetFormValue(JsonFile, "Husband") as actor
			if Husband!=none
				UI.InvokeString(HUD_MENU, WidgetRoot + ".setHusband", Husband.GetLeveledActorBase().GetName())
			endif
		endif
	endif
endFunction

function RefreshAffair()
	if(Ready)
		; Clear
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setAffair", "")
		if _name!=""
			int i=JsonUtil.FormListCount(JsonFile, "Affairs")
			while i>0
				i-=1
				actor Affair=JsonUtil.FormListGet(JsonFile, "Affairs",i) as actor
				if Affair!=none
					UI.InvokeString(HUD_MENU, WidgetRoot + ".addAffair", Affair.GetLeveledActorBase().GetName())
				endif
			endwhile
		endif
	endif
endFunction

function RefreshPartner()
	if(Ready)
		; Clear
		UI.InvokeString(HUD_MENU, WidgetRoot + ".setPartner", "")
		if _name!=""
			int i=JsonUtil.FormListCount(JsonFile, "Partners")
			while i>0
				i-=1
				actor Partner=JsonUtil.FormListGet(JsonFile, "Partners",i) as actor
				if Partner!=none
					UI.InvokeString(HUD_MENU, WidgetRoot + ".addPartner", Partner.GetLeveledActorBase().GetName())
				endif
			endwhile
		endif
	endif
endFunction

function UpdateContent()
	if(Ready)
		RefreshAll()
	endif
endFunction
