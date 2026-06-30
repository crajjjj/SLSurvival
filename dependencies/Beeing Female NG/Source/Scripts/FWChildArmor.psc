Scriptname FWChildArmor extends ObjectReference
import Armor
import FW_log

spell property BabyCry auto
spell property BabyFear auto
spell property BabyTalk auto
spell property BabyDrink auto
spell property BabyHappy auto
spell property BabyLaugh auto
spell property BabyAmuse auto
spell property BabyGiggle auto
spell property BabyHiccup auto
spell property BabySupprised auto

FormList property ItemListHappy auto
FormList property ItemListFear auto
FormList property ItemListSupprised auto

FWTextContents property Content auto
Actor Property PlayerRef Auto
GlobalVariable Property GameDaysPassed Auto

actor User

actor property Mother hidden
	actor function get()
		return _Mother
	endFunction
endProperty

actor property Father hidden
	actor function get()
		return _Father
	endFunction
endProperty

float property Age hidden
	float function get()
		return GameDaysPassed.GetValue() - dob
	endFunction
endProperty

float property DayOfBirth hidden
	float function get()
		return dob
	endFunction
endProperty

race property ChildRace hidden
	race function get()
		return StorageUtil.GetFormValue(self, "FW.Child.Race" ) as race
	endFunction
	
	function set(race value)
		StorageUtil.SetFormValue(self, "FW.Child.Race", value )
	endFunction
endProperty

bool bUseFathersLastName
bool property UseFathersLastName hidden
	bool function get()
		return bUseFathersLastName
	endFunction
	function set(bool value)
		int xflag = StorageUtil.GetIntValue(self, "FW.Child.Flag", 0)
		if value;/==true/;
			StorageUtil.SetIntValue(self, "FW.Child.Flag", Math.LogicalOr(xflag,32) )
		else
			if (Math.LogicalAnd(xflag,32) == 32)
				StorageUtil.SetIntValue(self, "FW.Child.Flag", Math.LogicalXor(xflag,32) )
			endif
		endif
		if Name ;Tkc (Loverslab): optimization
		else;if Name==""
			return
		endif
		string LastName = GetLastName()
		;Debug.Notification("UseFathersLastName: 1. '"+_Name+"' 2. '"+LastName+"'")
		SetName(Name)
		bUseFathersLastName = value
	endFunction
endProperty

string _xName = ""
string property Name hidden
	string function get()
		return _xName
	endFunction
	function set(string value)
		if value ;Tkc (Loverslab): optimization
		else;if value==""
			return
		endif
		string LastName = GetLastName()
		StorageUtil.SetStringValue(self,"FW.Child.Name",value)
		if value==_xName
			return
		endif
		_xName=value
		;Debug.Notification("Name: 1. '"+_Name+"' 2. '"+LastName+"'")
		SetName(_xName)
		string _lName = LastName
		if(_xName=="" && _lName=="")
			SetDisplayName(Content.BabyBlankName)
		elseif(_xName=="")
			SetDisplayName(FWUtility.MultiStringReplace(Content.BabyName, _lName, ""))
		elseif(_lName=="")
			SetDisplayName(FWUtility.MultiStringReplace(Content.BabyName, _xName, ""))
		else
			SetDisplayName(FWUtility.MultiStringReplace(Content.BabyName, _xName, _lName))
		endif
	endFunction
endProperty

bool bInitFromStorage = false

bool property IsFemale hidden
	bool function get()
		return iSex==1
	endFunction
	function Set(bool value)
		if value;/==true/;
			iSex=1
		else
			iSex=0
		endif
	endFunction
endProperty

bool property IsMale hidden
	bool function get()
		return iSex==0
	endFunction
	function Set(bool value)
		if value;/==true/;
			iSex=0
		else
			iSex=1
		endif
	endFunction
endProperty


actor _Mother
actor _Father
ColorForm HairColor
bool bIsVampire = false
int iSex
float dob = 0.0 ; Day of birth

float property SmallSizeScale = 0.6 auto
float property SizeDuration = 30.0 auto

; Flags
;  1 IsVampire
;  2 Hair from Father (all consumers read bit 2 as father's hair color)
;  4 IsFemale
;  8 Eyes from Mother
; 16 Nose from Mother

Bool Function IsVampire()
	return bIsVampire
EndFunction

Function SetVampire(bool bVamp)
	int xflag = StorageUtil.GetIntValue(self, "FW.Child.Flag", 0)
	if (Math.LogicalAnd(xflag,1) == 1) && bVamp==false
		StorageUtil.SetIntValue(self, "FW.Child.Flag", Math.LogicalXor(xflag,1) )
	elseif (Math.LogicalAnd(xflag,1) == 0) && bVamp;/==true/;
		StorageUtil.SetIntValue(self, "FW.Child.Flag", Math.LogicalOr(xflag,1) )
	endif
	bIsVampire = bVamp
EndFunction

int function GetSex()
	return iSex
endFunction

function SetSex(int Sex)
	int xflag = StorageUtil.GetIntValue(self, "FW.Child.Flag", 0)
	if Sex == 1
		if (Math.LogicalAnd(xflag,4) == 0) ;&& Sex==1
			StorageUtil.SetIntValue(self, "FW.Child.Flag", Math.LogicalOr(xflag,4) )
		endif
		iSex=1
	else
		if (Math.LogicalAnd(xflag,4) == 4) && Sex==0
			StorageUtil.SetIntValue(self, "FW.Child.Flag", Math.LogicalXor(xflag,4) )
		endif
		iSex=0
	endif
endfunction

ColorForm Function GetHairColor()
	return HairColor
EndFunction

Function SetHairColor(ColorForm color)
	 HairColor = color
EndFunction

String Function GetName()
	return Name
EndFunction

Function SetName(string newName)
	Parent.SetName(newName + " " + GetLastName())
	Name = newName
EndFunction

;this likely is not called - duplicated  onequip to be safe
Event OnLoad()
	WriteLog("FWChildArmor::OnLoad()")
EndEvent

Function InitFromStorage(Actor akActor)
	if bInitFromStorage
		WriteLog("FWChildArmor::InitFromStorage skipped - already done")
		return
	endif
	WriteLog("FWChildArmor::InitFromStorage name" + name)

	If (dob <= 0.0)
		float newDob = GameDaysPassed.GetValue()
		StorageUtil.SetFloatValue(self,"FW.Child.DOB", newDob)
		WriteLog("FWChildArmor::InitFromStorage FW.Child.DOB" + newDob)
		dob = newDob
	EndIf

	if akActor && akActor == PlayerRef
		;playerref values (persistant cause added to actor)
		StorageUtil.SetFormValue(PlayerRef, "FW.ChildArmor.Mother", akActor)
		StorageUtil.SetFormValue(PlayerRef, "FW.ChildArmor.Father", _Father)
		StorageUtil.SetFloatValue(PlayerRef, "FW.ChildArmor.dob", dob)
	endif

	bInitFromStorage = true
EndFunction

function SetParent(actor m, actor f)
	FW_log.WriteLog("FWChildArmor::SetParent Mother=" + m + " Father=" + f)
	StorageUtil.SetFormValue(self,"FW.Child.Father",f)
	StorageUtil.SetFormValue(self,"FW.Child.Mother",m)
	StorageUtil.SetFloatValue(self,"FW.Child.LastUpdate",GameDaysPassed.GetValue())
	_Father=f
	_Mother=m
endFunction

; Function discardItem()
; 	StorageUtil.FormListRemove(none,"FW.Babys", self)
; 	Delete()
; 	self.Disable(true)
; 	parent.Delete()
; EndFunction

; Function unequipItem()
; 	if _Mother != none
; 		_Mother.UnequipItem(self.GetBaseObject())
; 		_Mother.RemoveItem(self, 1, true)
; 	endif
; EndFunction

function Delete()
	; Drop the birth-time identity entry recorded on the mother
	actor m = StorageUtil.GetFormValue(self, "FW.Child.Mother", none) as Actor
	Form myBase = GetBaseObject()
	if m && myBase
		int idx = StorageUtil.FormListFind(m, "FW.BabyItemArmor", myBase)
		if idx >= 0
			FWUtility.RemoveBabyItemIdentityAt(m, idx)
		endif
	endif
	StorageUtil.UnsetFloatValue(self,"FW.Child.LastUpdate")
	StorageUtil.UnsetFormValue(self, "FW.Child.Father")
	StorageUtil.UnsetFormValue(self, "FW.Child.Mother")
	StorageUtil.UnsetStringValue(self, "FW.Child.Name")
	StorageUtil.UnsetIntValue(self, "FW.Child.Flag")
	StorageUtil.UnsetIntValue(self, "FW.Child.GrownToActor")
	; FW.Babys stores the armor BASE form, not this reference - removing self
	; never matched anything. Remove one base entry (twins keep theirs).
	if myBase
		StorageUtil.FormListRemove(none, "FW.Babys", myBase, false)
	endif
endFunction

string Function GetLastName()
	string LastName = ""
	int xflag = StorageUtil.GetIntValue(self, "FW.Child.Flag", 0)
	if Mother==PlayerRef || Father==PlayerRef
		return " Dovahkiir"
	endif
	
	if (Math.LogicalAnd(xflag,32) == 32)
		LastName = GetActorsLastName(Father)
	endif
	
	if LastName==""
		LastName = GetActorsLastName(Mother)
	endif
	return LastName
endFunction

string function GetActorsLastName(actor a)
	if a ;Tkc (Loverslab): optimization
	else;if a==none
		return ""
	endif
	string Name1 = a.GetName()
	string Name2 = a.GetDisplayName()
	ActorBase ab = a.GetLeveledActorBase()
	if ab;/!=none/;
		if StringUtil.GetLength(ab.GetName())>StringUtil.GetLength(Name1)
			Name1 = ab.GetName()
		endif
	endif
	int lName1 = StringUtil.GetLength(Name1)
	int lName2 = StringUtil.GetLength(Name2)
	if lName1 > lName2
		return StringUtil.Substring(Name1,lName2)
	elseif lName1 < lName2
		return StringUtil.Substring(Name2,lName1)
	endif
	return ""
endFunction

; Event received when this object is equipped by an actor
Event OnEquipped(Actor akActor)
	FW_log.WriteLog("FWChildArmor::OnEquipped("+akActor.GetLeveledActorBase().GetName()+")")
	InitFromStorage(akActor)
endEvent

; Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
; 	if akNewContainer == none
; 		FW_log.WriteLog("FWChildArmor::OnContainerChanged - dropped, cleaning tracking")
; 		StorageUtil.FormListRemove(none, "FW.Babys", self)
; 		discardItem()
; 	endif
; endEvent

; 02.06.2019 Tkc (Loverslab) optimizations: Changes marked with "Tkc (Loverslab)" comment. Very little changed..
