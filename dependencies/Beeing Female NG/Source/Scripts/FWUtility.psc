Scriptname FWUtility

; Time functions
; Formats a duration into a human-readable string ("" when akTime is 0, akNegativeText when akTime < 0 and provided).
String Function GetTimeString(Float akTime, Bool akShortFormat = True, String akNegativeText = "") Global native

; Returns true when every non-empty name resolves to an installed plugin (false if DataHandler is unavailable).
bool function AreModsInstalled(string[] ModNames) global native

bool function IsModInstalled(string ModName) global
	if ModFile(ModName); Tkc: ModFile(ModName) will be true if name will be not equal ""
		;debug.trace("BF: Utility > IsModInstalled ModFile(ModName) is true")	
		return true
	endif
	return false
endFunction

; Returns the plugin filename for ModName ("" if not found).
string function ModFile(string ModName) global
	return GetModFromString(ModName, true)
endFunction

string function GetJsonFile(form frm) global
	if !frm
		return ""
	endif
	;if frm as actor != none
	;	return GetJsonFileCombine(GetModFromID(frm,false), Hex((frm as actor).GetLeveledActorBase().GetFormID(), 6))
	;else
		return GetJsonFileCombine(GetModFromID(frm,false), Hex(frm.GetFormID(), 6))
	;endif
endFunction

string function GetJsonFileCombine(string Mod, string Hex) global
	return Mod + "_" + Hex + ".json"
endFunction

string function GetIniFile(form frm) global
	return GetIniFileCombine(GetModFromID(frm,false), Hex(frm.GetFormID(), 6))
endFunction

string function GetIniFileCombine(string Mod, string Hex) global
	return Mod + "_" + Hex + ".ini"
endFunction

actor function GetRandomAutoCouplesDonor(string jsonFile) global
	actor[] donors
	actor h = JsonUtil.GetFormValue(jsonFile, "husband") as actor
	if h
		donors = FWUtility.ActorArrayAppend(donors, h)
	endif
	int c = JsonUtil.FormListCount(jsonFile, "partners")
	while c>0
		c-=1
		actor a = JsonUtil.FormListGet(jsonFile, "partners", c) as actor
		if a
			donors = FWUtility.ActorArrayAppend(donors, a)
		endif
	endWhile
	c = JsonUtil.FormListCount(jsonFile, "affairs")
	while c>0
		c-=1
		actor a2 = JsonUtil.FormListGet(jsonFile, "affairs", c) as actor
		if a2
			donors = FWUtility.ActorArrayAppend(donors, a2)
		endif
	endWhile
	if donors.length>0
		return donors[Utility.RandomInt(0, donors.length - 1)]
	endif
	return none
endFunction

; Returns the plugin name for the given form (optionally without extension, "unknown" when form has no file).
string function GetModFromID(Form frm, bool bFileExtention = true) global native
actor function FindFemaleFromJsonFileName(string fileName) global native


string function GetDirectoryHash(string dir) native global
;string function GetDirectoryHash(string dir) global
;	return "000"
;endfunction

; Generates a Hex Value out of integer with the Given number of digits
; Hex( 500 , 4 ) = "01F4"
string function Hex(int value, int Digits) native global

string function toLower(string str) global native
string function toUpper(string str) global native

bool function ScriptHasString(string script, string str) global native
int function ScriptStringCount(string script) global native
string function ScriptStringGet(string script, int num) global native
string function ScriptUser(string script) global native
string function ScriptSource(string script) global native
string function ScriptMashine(string script) global native


; Returns file count (0 when no matches).
int function GetFileCount(string argPath, string extention="json") global native
; Returns file name by index ("" when not found).
string function GetFileName(string argPath, string extention="json", int fileID=0) global native
; Returns file names (empty array when no matches).
string[] function GetFileNames(string argPath, string extention="json") global native
bool function FileExists(string FilePath) global native
string function getNextAutoFile(string Directory, string FileName, string Ext) global native

string function getTypeString(int fileID=0) global native

string function getIniPath(string Type, string File) global native

string function getIniString(string Type, string File, string Variable, string Default="") global native
bool function getIniBool(string Type, string File, string Variable, bool Default=false) global native
int function getIniInt(string Type, string File, string Variable, int Default=0) global native
float function getIniFloat(string Type, string File, string Variable, float Default=0.0) global native
string function getIniCString(string Type, string File, string Categorie, string Variable, string Default="") global native
bool function getIniCBool(string Type, string File, string Categorie, string Variable, bool Default=false) global native
int function getIniCInt(string Type, string File, string Categorie, string Variable, int Default=0) global native
float function getIniCFloat(string Type, string File, string Categorie, string Variable, float Default=0.0) global native

function setIniString(string Type, string File, string Variable, string Value) global native
function setIniBool(string Type, string File, string Variable, bool Value) global native
function setIniInt(string Type, string File, string Variable, int Value) global native
function setIniFloat(string Type, string File, string Variable, float Value) global native
function setIniCString(string Type, string File, string Categorie, string Variable, string Value) global native
function setIniCBool(string Type, string File, string Categorie, string Variable, bool Value) global native
function setIniCInt(string Type, string File, string Categorie, string Variable, int Value) global native
function setIniCFloat(string Type, string File, string Categorie, string Variable, float Value) global native


form function GetFormFromString(string s) global native ; returns the Form of a string ("Mod:Hex" only), returns none on failure.

Form Function GetFormFromStringSE(string s) global
	Form result = GetFormFromString(s)
	if !result
		FW_log.WriteLog("FWUtility - GetFormFromStringSE : Failed to get form from the string " + s + ". Please check whether it is correctly separated by colon (:)...")
	endif
	return result
endFunction

string function GetModFromString(string s, bool bExtension = false) global native ; returns the plugin name for s (example: GetModFromString("BFACreatureChildActorsSE_ESPFE:848") -> "BFACreatureChildActorsSE_ESPFE.esp")
int function GetFormIDFromString(string s) global native ; returns the numeric FormID from "Mod:Hex" (0 if not found)
string function GetStringFromForm(form frm) global native ; returns the Form String from a form ("" if frm/file missing)
string function GetModFromForm(form frm, bool bExtension = false) global native ; returns the mod File from a form ("" if frm missing, "-3" if no file)
string function GetStringFromForms(Form[] frms) global
	int i=0
	string s=""
	int c=frms.Length
	while i<c
		string tmp=GetStringFromForm(frms[i])
		if tmp;/!=""/; ;Tkc (Loverslab): optimization
			if i>0
				s+=","
			endif
			s+=tmp
		endif
		i+=1
	endWhile
	return s
endFunction

;--------------------------------------------------------------------------------
; Mirrored list helpers (ChildFather / Sperm)
;--------------------------------------------------------------------------------
function AddChildFather(actor Mother, actor Father, race FatherRace = none) global
	if !Mother
		return
	endif
	; Allow None fathers (unloaded creature actors) — store entries so list
	; counts stay consistent with FW.NumChilds. Birth flow handles None gracefully.
	StorageUtil.FormListAdd(Mother, "FW.ChildFather", Father)
	if Father
		StorageUtil.StringListAdd(Mother, "FW.ChildFatherStr", GetStringFromForm(Father))
		StorageUtil.FormListAdd(Mother, "FW.ChildFatherRace", Father.GetRace())
	else
		StorageUtil.StringListAdd(Mother, "FW.ChildFatherStr", "")
		StorageUtil.FormListAdd(Mother, "FW.ChildFatherRace", FatherRace)
	endif
endFunction

function RemoveChildFatherAt(actor Mother, int Index) global
	if !Mother
		return
	endif
	if StorageUtil.FormListCount(Mother, "FW.ChildFather") > Index
		StorageUtil.FormListRemoveAt(Mother, "FW.ChildFather", Index)
	endif
	if StorageUtil.StringListCount(Mother, "FW.ChildFatherStr") > Index
		StorageUtil.StringListRemoveAt(Mother, "FW.ChildFatherStr", Index)
	endif
	if StorageUtil.FormListCount(Mother, "FW.ChildFatherRace") > Index
		StorageUtil.FormListRemoveAt(Mother, "FW.ChildFatherRace", Index)
	endif
endFunction

function ClearChildFathers(actor Mother) global
	if !Mother
		return
	endif
	StorageUtil.FormListClear(Mother, "FW.ChildFather")
	StorageUtil.StringListClear(Mother, "FW.ChildFatherStr")
	StorageUtil.FormListClear(Mother, "FW.ChildFatherRace")
endFunction

; Baby-item identity lists (FW.BabyItem*) - written at birth in ChildItemSetup,
; consumed FIFO when an item hatches. Parallel lists; always modify together.
function AddBabyItemIdentity(actor Mother, Form ArmorBase, string BabyName, int Sex, race ParentRace, actor Father) global
	if !Mother || !ArmorBase
		return
	endif
	StorageUtil.FormListAdd(Mother, "FW.BabyItemArmor", ArmorBase)
	StorageUtil.StringListAdd(Mother, "FW.BabyItemName", BabyName)
	StorageUtil.IntListAdd(Mother, "FW.BabyItemSex", Sex)
	StorageUtil.FormListAdd(Mother, "FW.BabyItemRace", ParentRace)
	StorageUtil.FormListAdd(Mother, "FW.BabyItemFather", Father)
	StorageUtil.FloatListAdd(Mother, "FW.BabyItemDOB", Utility.GetCurrentGameTime())
endFunction

function RemoveBabyItemIdentityAt(actor Mother, int Index) global
	if !Mother
		return
	endif
	if StorageUtil.FormListCount(Mother, "FW.BabyItemArmor") > Index
		StorageUtil.FormListRemoveAt(Mother, "FW.BabyItemArmor", Index)
	endif
	if StorageUtil.StringListCount(Mother, "FW.BabyItemName") > Index
		StorageUtil.StringListRemoveAt(Mother, "FW.BabyItemName", Index)
	endif
	if StorageUtil.IntListCount(Mother, "FW.BabyItemSex") > Index
		StorageUtil.IntListRemoveAt(Mother, "FW.BabyItemSex", Index)
	endif
	if StorageUtil.FormListCount(Mother, "FW.BabyItemRace") > Index
		StorageUtil.FormListRemoveAt(Mother, "FW.BabyItemRace", Index)
	endif
	if StorageUtil.FormListCount(Mother, "FW.BabyItemFather") > Index
		StorageUtil.FormListRemoveAt(Mother, "FW.BabyItemFather", Index)
	endif
	if StorageUtil.FloatListCount(Mother, "FW.BabyItemDOB") > Index
		StorageUtil.FloatListRemoveAt(Mother, "FW.BabyItemDOB", Index)
	endif
endFunction

function ClearBabyItemIdentity(actor Mother) global
	if !Mother
		return
	endif
	StorageUtil.FormListClear(Mother, "FW.BabyItemArmor")
	StorageUtil.StringListClear(Mother, "FW.BabyItemName")
	StorageUtil.IntListClear(Mother, "FW.BabyItemSex")
	StorageUtil.FormListClear(Mother, "FW.BabyItemRace")
	StorageUtil.FormListClear(Mother, "FW.BabyItemFather")
	StorageUtil.FloatListClear(Mother, "FW.BabyItemDOB")
endFunction

; Reconcile identity entries against how many of each baby-item base the carrier actually holds.
; Keeps the oldest GetItemCount(base) entries per base (FIFO) and prunes the surplus. Heals orphan
; entries left behind when a baby item is sold/dropped/destroyed without hatching (twins on a shared
; base, or the whole stack removed). The caller must only invoke this when the carrier's inventory
; read is trustworthy (player, or an NPC that Is3DLoaded) - an unloaded actor can report a false zero
; count and wrongly prune a valid baby.
; Note: this does NOT touch FW.Babys. That global list stores armor BASE forms shared across all
; mothers, so removing "one" by base could delete another mother's live entry. Stale FW.Babys armor
; entries are harmless (the hatch gate skips bases the carrier no longer holds) and are cleaned by the
; game-load FW.Babys purge.
function PruneOrphanBabyIdentities(actor Carrier) global
	if !Carrier
		return
	endif
	int i = StorageUtil.FormListCount(Carrier, "FW.BabyItemArmor")
	while i > 0
		i -= 1
		Form armBase = StorageUtil.FormListGet(Carrier, "FW.BabyItemArmor", i)
		if armBase
			; rank = how many entries with this same base occur at indices <= i (1-based)
			int rank = 0
			int j = 0
			while j <= i
				if StorageUtil.FormListGet(Carrier, "FW.BabyItemArmor", j) == armBase
					rank = rank + 1
				endif
				j = j + 1
			endwhile
			; Going downward, the newest surplus entry is pruned first; the oldest are kept.
			if rank > Carrier.GetItemCount(armBase)
				RemoveBabyItemIdentityAt(Carrier, i)
			endif
		endif
	endwhile
endFunction

race function GetLastChildFatherRace(actor Mother) global
	if !Mother
		return none
	endif
	int c = StorageUtil.FormListCount(Mother, "FW.ChildFatherRace")
	if c > 0
		return StorageUtil.FormListGet(Mother, "FW.ChildFatherRace", c - 1) as race
	endif
	return none
endFunction

function AddSpermMirror(actor Woman, actor Father) global
	if !Woman || !Father
		return
	endif
	StorageUtil.FormListAdd(Woman, "FW.SpermName", Father)
	StorageUtil.FormListAdd(Woman, "FW.SpermRace", Father.GetRace())
endFunction

function RemoveSpermMirrorAt(actor Woman, int Index) global
	if !Woman
		return
	endif
	if StorageUtil.FloatListCount(Woman, "FW.SpermTime") > Index
		StorageUtil.FloatListRemoveAt(Woman, "FW.SpermTime", Index)
	endif
	if StorageUtil.FormListCount(Woman, "FW.SpermName") > Index
		StorageUtil.FormListRemoveAt(Woman, "FW.SpermName", Index)
	endif
	if StorageUtil.FloatListCount(Woman, "FW.SpermAmount") > Index
		StorageUtil.FloatListRemoveAt(Woman, "FW.SpermAmount", Index)
	endif
	if StorageUtil.FormListCount(Woman, "FW.SpermRace") > Index
		StorageUtil.FormListRemoveAt(Woman, "FW.SpermRace", Index)
	endif
endFunction

function ClearSpermMirror(actor Woman) global
	if !Woman
		return
	endif
	StorageUtil.FloatListClear(Woman, "FW.SpermTime")
	StorageUtil.FormListClear(Woman, "FW.SpermName")
	StorageUtil.FloatListClear(Woman, "FW.SpermAmount")
	StorageUtil.FormListClear(Woman, "FW.SpermRace")
endFunction
string function GetStringFromRaces(Race[] frms) global
	int i=0
	string s=""
	int c=frms.Length
	while i<c
		string tmp=GetStringFromForm(frms[i])
		if tmp;/!=""/; ;Tkc (Loverslab): optimization
			if i>0
				s+=","
			endif
			s+=tmp
		endif
		i+=1
	endWhile
	return s
endFunction
string function GetStringFromSpells(Spell[] frms) global
	int i=0
	string s=""
	int c=frms.Length
	while i<c
		string tmp=GetStringFromForm(frms[i])
		if tmp;/!=""/; ;Tkc (Loverslab): optimization
			if i>0
				s+=","
			endif
			s+=tmp
		endif
		i+=1
	endWhile
	return s
endFunction

quest function GetQuestObject(string ModName, int index) global native
int function GetQuestObjectCount(string ModName) global native


string function getObjectListNames(ObjectReference[] objs, bool PrefareDisplayName=false) global
	if objs.length==0
		return ""
	else
		int c=objs.length
		int i=0
		string str=""
		bool bFirst=true
		while i<c
			if objs[i];/!=none/;
				if bFirst;/==true/;
					bFirst=false
				else
					str+=", "
				endif
				actor a = objs[i] as actor
				; Actors are handles different
				if a;/!=none/; && PrefareDisplayName==false
					if a.GetLeveledActorBase();/!=none/;
						str+=a.GetLeveledActorBase().GetName()
					else
						str+=a.GetDisplayName()
					endif
				else
					if PrefareDisplayName;/==true/; && objs[i].GetDisplayName();/!=""/; ;Tkc (Loverslab): optimization
						str+=objs[i].GetDisplayName()
					else
						str+=objs[i].GetName()
					endif
				endif
			endif
			i+=1
		endWhile
		return str
	endIf
endFunction

string function getRandomName(int iSex) Global
	;FW_log.WriteLog("BeeingFemale - getRandomName("+iSex+")")
	string lang = Utility.GetINIString("sLanguage:General")
	string path = "../../../BeeingFemale/Names/"
	string Full = path + "BeeingFemaleNames_" + lang + ".json"
	string ssex = ""
	;FW_log.WriteLog("- Use Language: '"+lang+"'")
	;FW_log.WriteLog("- Name File: '" + Full + "'")
	
	if iSex == 0
		ssex = "male"
	elseif iSex == 1
		ssex = "female"
	endif
	;FW_log.WriteLog("- ssex: '" + ssex + "'")
	int Count = JsonUtil.StringListCount(Full, ssex)
	;FW_log.WriteLog("- Name Count: '" + Count + "'")
	;JsonUtil.StringListAdd(Full, ssex, "Alex", false)
	int id = Utility.RandomInt(0, Count - 1)
	;FW_log.WriteLog("- Random ID: '" + id + "'")
	string sName = JsonUtil.StringListGet(Full, ssex, id)
	;FW_log.WriteLog("- Result: '" + sName+"'")
	return sName
endFunction

; Builds a comma-separated list of actor names, optionally preferring display names.
string function getActorListNames(Actor[] objs, bool PrefareDisplayName=false) global native

bool function OpenChildMenu(FWChildActor Child) Global
	if Child ;Tkc (Loverslab): optimization
	else;if Child==none
		return false
	endif
	Child.OpenSkillMenu()
endFunction

; Formats percentage with optional decimal precision.
string Function GetPercentage(float percentage, int Decimal=0, bool bDecimalBase=true) global native


string function StringReplace(string Text, string Find, string Replace) global native

; Replaces {0},{1}... placeholders in Text using Replace array entries.
string function ArrayReplace(string Text, string[] Replace) global native

string function MultiStringReplace(string Text, string Replace0="", string Replace1="", string Replace2="", string Replace3="", string Replace4="", string Replace5="") global native

string function getIniValue(string iniContent, string Variable, string default="")
	int pos=0
	int varLen=StringUtil.GetLength(Variable)+2
	pos = StringUtil.Find(iniContent, "$"+Variable+"=",pos)
	if pos>=0
		int len1=StringUtil.Find(iniContent, StringUtil.AsChar(13),pos)
		int len2=StringUtil.Find(iniContent, StringUtil.AsChar(10),pos)
		int len=0
		if len1<len2 && len1>=0
			len=len1
		else
			len=len2
		endif
		if len==-1
			return StringUtil.Substring(iniContent,pos+varLen)
		else
			return StringUtil.Substring(iniContent,pos+varLen, len - varLen - pos)
		endif
	endIf
	return ""
endfunction

string function _getStateName_(int StateID) Global
	if StateId >= 0
		if StateId < 9
			if StateId < 8
				if StateId < 4
					if StateId < 2
						if StateID==0
							return "Follicular Phase"
						else;if StateID==1
							return "Ovulation"
						endIf
					else
						if StateID==2
							return "Luteal Phase"
						else;if StateID==3
							return "Menstruation"
						endIf
					endIf
				else
					if StateId < 6
						if StateID==4
							return "1st Pregnancy State"
						else;if StateID==5
							return "2nd Pregnancy State"
						endIf
					else
						if StateID==6
							return "3rd Pregnancy State"
						else;if StateID==7
							return "LaborPains"
						endIf
					endIf
				endIf
			else;if StateID==8
				return "Recovery Phase"
			endIf
		else
			if StateID==20
				return "Pregnant"
			elseif StateID==21
				return "Pregnant by chaurus"
			endIf
		endIf
	endIf
endFunction

string function getStateNameTranslated(int StateID) Global
	return "$FW_MENU_INFO_StateName"+StateID
endFunction


; Numeric functions

Float Function ClampFloat(Float a, Float min, Float max) Global
	If a < min
		Return min
	ElseIf a > max
		Return max
	EndIf
	Return a
EndFunction

Float Function MaxFloat(Float a, Float b) Global
	If b < a
		Return a
	EndIf
	Return b
EndFunction

Float Function MinFloat(Float a, Float b) Global
	If a < b
		Return a
	EndIf
	Return b
EndFunction

float function RangedFloat(float value, float Min, float Max) global
	if value <Min
		return Min
	elseif value>Max
		return Max
	else
		return value
	endif
endFunction

Float Function SwitchFloat(Bool cond, Float a, Float b) Global
	If cond
		Return a
	EndIf
	Return b
EndFunction

Int Function ClampInt(Int a, Int min, Int max) Global
	If a < min
		Return min
	ElseIf a > max
		Return max
	EndIf
	Return a
EndFunction

Int Function MaxInt(Int a, Int b) Global
	If b < a
		Return a
	EndIf
	Return b
EndFunction

Int Function MinInt(Int a, Int b) Global
	If a < b
		Return a
	EndIf
	Return b
EndFunction

int function RangedInt(int value, int Min, int Max) global
	if value <Min
		return Min
	elseif value>Max
		return Max
	else
		return value
	endif
endFunction

Int Function SwitchInt(Bool cond, Int a, Int b) Global
	If cond
		Return a
	EndIf
	Return b
EndFunction


; String functions

String Function SwitchString(Bool cond, String a="true", String b="false") Global
	If cond
		Return a
	EndIf
	Return b
EndFunction

function UnequipItem(actor a, form item) Global
	;if item;/!=none/; && a;/!=none/;
	if item ;Tkc (Loverslab): optimization
	  if a
		if a.IsEquipped(item)
			a.UnequipItem(item, true, true)
		endif
		a.RemoveItem(item, 1, true)
	  endIf 
	endIf 
endFunction

function EquipItem(actor a, form item) Global
	;if item;/!=none/; && a;/!=none/;
	if item ;Tkc (Loverslab): optimization
	  if a
		a.addItem(item, 1, true)
		if a.IsEquipped(item) ;Tkc (Loverslab): optimization
		else;if !a.IsEquipped(item)
			a.EquipItem(item, false, true)	
		endif
	  endIf 
	endIf 
endFunction

function ActorAddSpell(actor a,Spell s, bool PlayerOnly = false, bool bIsCast = false, bool ShowMsg = true) Global ;Bane --> Edited to allow Spells to be cast in None Locations (Mostly Widerness)
	;if s;/!=none/; && a;/!=none/;
	if s ;Tkc (Loverslab): optimization
	  if a
		;if ( !PlayerOnly || Game.GetPlayer() == a ) && !a.HasSpell(s)
		if ( !PlayerOnly || Game.GetPlayer() == a )
		 if a.HasSpell(s) ;Tkc (Loverslab): optimization
		 else;if !a.HasSpell(s)
			if bIsCast
				if a.Is3DLoaded() ;Tkc (Loverslab): just Is3DLoaded is not enough here
					Cell acell = a.GetParentCell()
					if acell && acell.IsAttached() ;Tkc (Loverslab): offered by dldrzz000. None error for IsAttached(). Possible here is will be enough of if a.Is3DLoaded() check
						s.Cast(a,a)
					endif
				endif
			else
				a.addSpell(s, ShowMsg) ;Tkc (Loverslab): added ShowMsg parameter to not show messages when Innmersion or None Messages mode
			endif
		 endIf
		endIf
	  endif
	endif
endFunction

function ActorRemoveSpell(actor a, Spell s) Global
	;if s;/!=none/; && a;/!=none/;
	if s ;Tkc (Loverslab): optimization
	  if a
		if a.HasSpell(s)
			a.RemoveSpell(s)
		endIf
	  endIf
	endIf
endFunction

function ActorAddSpells(actor a,Spell[] sa, bool PlayerOnly=false, bool bIsCast = false) Global
	if a ;Tkc (Loverslab): optimization
	else;if a==none
		return
	endif
	int i=0
	int c=sa.length
	while i < c
		ActorAddSpell(a,sa[i],PlayerOnly,bIsCast,False;/Tkc (Loverslab): Set spell add notification to false/;) 
		i+=1
	endWhile
endFunction

function ActorAddSpellsS(actor a,string sa, bool PlayerOnly=false, bool bIsCast = false) Global
	if a ;Tkc (Loverslab): optimization
	else;if a==none
		return
	endif
	int c=StorageUtil.FormListCount(none,"FW.AddOn."+sa)
	while c>0
		c-=1
		spell s = StorageUtil.FormListGet(none,"FW.AddOn."+sa,c) as spell
		if s;/!=none/;
			ActorAddSpell(a,s,PlayerOnly,bIsCast,False;/Tkc (Loverslab): Set spell add notification to false/;)
		endif
	endWhile
endFunction

function ActorRemoveSpells(actor a,Spell[] sa) Global
	if a ;Tkc (Loverslab): optimization
	else;if a==none
		return
	endif
	int i=0
	int c=sa.length
	while i < c
		ActorRemoveSpell(a,sa[i])
		i+=1
	endWhile
endFunction

function ActorRemoveSpellsS(actor a,string sa) Global
	if a ;Tkc (Loverslab): optimization
	else;if a==none
		return
	endif
	int c=StorageUtil.FormListCount(none,"FW.AddOn."+sa)
	while c>0
		c-=1
		spell s = StorageUtil.FormListGet(none,"FW.AddOn."+sa,c) as spell
		ActorRemoveSpell(a,s)
	endWhile
endFunction

function LockPlayer() global
	;actor PlayerRef=Game.GetPlayer() ;Tkc (Loverslab): optimization. next lines was commented
	Game.ForceThirdPerson()
	Game.SetPlayerAIDriven(true)
	Game.SetInChargen(true, true, false)
	;PlayerRef.SetDontMove(true)
	;PlayerRef.SetRestrained(true)
endFunction

function UnlockPlayer() global
	;actor PlayerRef=Game.GetPlayer() ;Tkc (Loverslab): optimization. next lines was commented
	Game.SetPlayerAIDriven(false)
	;PlayerRef.SetDontMove(false)
	;PlayerRef.SetRestrained(false)
	Game.SetInChargen(false, false, false)
endFunction


; Builds a comma-separated list of actor base names.
string function GetNames(actor[] Actors) global native

; Returns Value mod Mod (positive mod required).
float function floatModulo(float Value, float Mod) global native

; Concatenates two form arrays (capped to 128).
Form[] function FormArrayConcat(Form[] f1, Form[] f2) global
	return PapyrusUtil.MergeFormArray(f1, f2)
endFunction

; Removes duplicate actors while preserving order.
Actor[] function removeDuplicatedActors(Actor[] list) global
	return PapyrusUtil.RemoveDupeActor(list)
endFunction


; Appends Count copies of Append to OldArray (capped to 128).
Actor[] function ActorArrayAppend(Actor[] OldArray, actor Append, int Count=1) global
	if Count < 1
		return OldArray
	endif
	Actor[] res = OldArray
	while Count > 0
		Count -= 1
		res = PapyrusUtil.PushActor(res, Append)
	endWhile
	return res
endFunction

; Resizes an actor array to NewSize (clamped to 1..128).
Actor[] function ActorArrayResize(Actor[] OldArray, int NewSize) global
	return PapyrusUtil.ResizeActorArray(OldArray, NewSize)
endFunction

; Appends Count copies of each actor in a StorageUtil form list (Owner/ListKey) to OldArray (capped at 128).
Actor[] function ActorArrayAppendStorageList(Actor[] OldArray, Form Owner, string ListKey, int Count=1) global
	Actor[] res = OldArray
	int i = StorageUtil.FormListCount(Owner, ListKey)
	while i > 0
		i -= 1
		res = ActorArrayAppend(res, StorageUtil.FormListGet(Owner, ListKey, i) as Actor, Count)
	endWhile
	return res
endFunction

; Appends Count copies of each actor in a JsonUtil form list (JsonFile/ListKey) to OldArray (capped at 128).
Actor[] function ActorArrayAppendJsonList(Actor[] OldArray, string JsonFile, string ListKey, int Count=1) global
	Actor[] res = OldArray
	int i = JsonUtil.FormListCount(JsonFile, ListKey)
	while i > 0
		i -= 1
		res = ActorArrayAppend(res, JsonUtil.FormListGet(JsonFile, ListKey, i) as Actor, Count)
	endWhile
	return res
endFunction

; Removes duplicate actors in-place style and returns a compacted array.
Actor[] function ActorArrayUnique(Actor[] a) global
	return PapyrusUtil.RemoveDupeActor(a)
endFunction


; Appends Append to a float array (capped to 128).
Float[] function FloatArrayAppend(Float[] OldArray, Float Append) global
	return PapyrusUtil.PushFloat(OldArray, Append)
endFunction

; Resizes a float array to NewSize (clamped to 1..128).
Float[] function FloatArrayResize(Float[] OldArray, int NewSize) global
	return PapyrusUtil.ResizeFloatArray(OldArray, NewSize)
endFunction

; Appends Append to an int array (capped to 128).
int[] function IntArrayAppend(int[] OldArray, int Append) global
	return PapyrusUtil.PushInt(OldArray, Append)
endFunction

int[] function IntArrayResize(int[] OldArray, int NewSize) global
	return PapyrusUtil.ResizeIntArray(OldArray, NewSize)
endFunction


; Array Functions

; Allocates an actor array of the requested size (clamped to 1..128).
Actor[] Function ActorArray(Int size) Global
	return PapyrusUtil.ActorArray(size)
endFunction

; Allocates a bool array of the requested size (clamped to 1..128).
Bool[] Function BoolArray(Int size) Global
	return PapyrusUtil.BoolArray(size)
endFunction
; Allocates a float array of the requested size (clamped to 1..128).
Float[] Function FloatArray(Int size) Global
	return PapyrusUtil.FloatArray(size)
endFunction
; Allocates an int array of the requested size (clamped to 1..128).
Int[] Function IntArray(Int size) Global
	return PapyrusUtil.IntArray(size)
endFunction
; Allocates a string array of the requested size (clamped to 1..128).
String[] Function StringArray(Int size) Global
	return PapyrusUtil.StringArray(size)
endFunction
bool function IsNumber(string Char) global
	if StringUtil.GetLength(Char) != 1
		return false
	endif
	return StringUtil.Find("0123456789", Char, 0) >= 0
endfunction

; Extracts a version string from a mod description (e.g., "Version 1.2", "Undefined" if not found).
string function GetVersionString(string modDesc) global native




; Allocates a form array of the requested size (clamped to 1..128).
Form[] Function FormArray(Int size) Global
	return PapyrusUtil.FormArray(size)
endFunction

; 03.06.2019 Tkc (Loverslab) optimizations: Changes marked with "Tkc (Loverslab)" comment
