Scriptname FWAddOnBase extends Quest  

FWAddOnManager property AddOnManager Auto hidden
String Property AddOnDescription = "" Auto
Bool Property AddOnVisible = True Auto
Bool Property AddOnLocked = False Auto
string property AddOnAuthor = "" auto


;event OnInit()
;	GetAddOnManager()
;	;SendModEvent("BeeingFemale", "FWRefreshAddOns")
;	RegisterForModEvent("FWAddOnRefresh","RefreshAddOns")
;endEvent

;event RefreshAddOns(string eventName, string strArg, float numArg, Form sender)
;	if eventName == "FWAddOnRefresh"
;		Refresh(strArg, (sender as FWAddOnManager))
;	endIf
;endEvent

;function Refresh(string strArg, FWAddOnManager sender)
	;Debug.Notification("Empty Refresh called")
;endFunction

;function GetAddOnManager()
;	if !AddOnManager || AddOnManager==none
;		int idx = Game.GetModCount()
;		string modName = ""
;		while idx > 0
;			idx -= 1
;			modName = Game.GetModName(idx)
;			if modName == "BeeingFemale.esp" || modName == "BeeingFemale.esm"
;				AddOnManager = Game.GetFormFromFile(0x00001829, modName) as FWAddOnManager
;				idx = 0
;			endIf
;		endWhile
;	endIf
;endFunction