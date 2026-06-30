Scriptname FWAddOn_Misc extends FWAddOnBase Hidden

bool property HasCamera = false auto


; Check if this AddOn is active
bool function IsActive()
	return true
endFunction

; Raised when the player loads the game
function OnGameLoad()
endFunction


; Raised when this AddOn was activated / enabled
function OnAddOnActivate()
endFunction

; raised when this AddOn was deaktivated
function OnAddOnDeactivate()
endFunction


; Starting a birth camera
function StartCamera()
endFunction


; End a birth camera
function StopCamera()
endFunction


; Raised when a state was enterd
function OnEnterState(actor akFemale, int iState)
endFunction


; Raised when exit a state
function OnExitState(actor akFemale, int iState)
endFunction


; raised every Game-hour
function OnUpdateFunction(actor akFemale, int iState, float StatePercentage)
endFunction


; raised when a man cames inside a woman
function OnCameInside(actor akFemale, actor akMale)
endFunction


; Returns the amount of sperm when a male cames inside a woman
float function getSpermAmount(actor akFemale, actor akMale, float amount)
	return amount
endFunction

; Raised when the woman had some labor pains
function OnLaborPain(actor akFemale)
endFunction


; raised when the birth began
function OnGiveBirth(actor akMother, int iChildCount)
endFunction


; raised when Birth animation begin
function OnGiveBirthStart(actor akMother)
endFunction


; raised when the birth animation ends
function OnGiveBirthEnd(actor akMother)
endFunction


; raised when the the woman has pains
bool function OnPainSound(actor akMother)
endFunction


; raised when a baby was spawn
function OnBabySpawn(actor akMother, actor akFather)
endFunction


; raised when a potion was drank
function OnPotionDrink(actor akMother, potion akPotion)
endFunction


; raised when a spell was casted
function OnSpellCast(actor akMother, spell akSpell)
endFunction




; Damage Type:								Optional Argument
;  0	Unknown
;  1	Mittelschmerz / Ovulation pains		strength of the pains
;  2	PMS pains							
;  3	Menstruation cramps					strength of the pains
;  4	Pregnancy 1. sickness
;  5	Pregnancy 2. sickness
;  6	Pregnancy 3. sickness
;  7	premonitory pains
;  8	first stage pains
;  9	Child-Pressing pains
; 10	bearing-down pains
; 11	afterpains
; 12	baby milk drinking pains
; 13	infection pains
; 14	abortus pains
;
; The amount is a percentage value based on the players max health. 0.0 = 0 Damage; 100.0 = instant death
; Raised when the mod based menstrual/pragnancy damage was called
float function OnDoDamage(actor Woman, float Amount, int DamageType, float OptionalArgument)
	return Amount
endfunction


; Raised when the stack of pains begin
function OnDoDamageStart(actor a, float Amount, int DamageType, float OptionalArgument)
endFunction


; Raised when the stack of pains end
function OnDoDamageEnd(actor Woman, float Amount, int DamageType, float OptionalArgument)
endFunction


; Raised when the women uses a contraception fluid
function OnContraception(Actor Woman, float Amount, float ValueBefore, float ValueAfter, float TimeAgo)
endFunction


; Raised when the women become pregnant
function OnImpregnate(actor Woman, int NumChildren, Actor[] ChildFathers)
endfunction


; Raised when a magic effect was applied
function OnMagicEffectApply(Actor akWoman, ObjectReference akCaster, MagicEffect akEffect)
endFunction


; Check for a condome. When this function returns true, there won't be any sperm added
bool function CheckForCondome(actor Woman, actor Man)
	return false
endfunction


; Raised when this AddOn was unsinstalled
function OnUninstall()
endfunction


; not used anymore
function OnRegisterChildPerk(FWChildSettings childSettings)
endFunction


; Raised when the women undress
Form[] function OnStripActor(Actor ActorRef)
	Form[] fAll
	return fAll
endfunction


; Raised when the women mimik changes
function OnMimik(actor ActorRef, string ExpressionName = "", int Strength = 50, bool bClear = true)
endfunction


; Raised when searching a bed
ObjectReference function OnGetBedRef(Actor ActorRef)
	return none
endfunction


; Raised when a pain sound should appear. Return false when this AddOn don't handle the pain sound
bool function OnPlayPainSound(actor ActorRef, float Strength)
	return false
endfunction


; Raised when check for Female/Female cum
bool function OnAllowFFCum(Actor WomanToAdd, Actor denor)
	return false
endfunction


; Raised when the player beginn sleeping, overwriting the sex partner that is used
actor function OnSleepSexStart(actor p, actor aSexPartner)
	return aSexPartner
endFunction


; Raised when the player stop sleeping, overwriting the sex partner that is used
actor function OnSleepSexStop(actor p, actor aSexPartner)
	return aSexPartner
endFunction









;-----------------------------
;   Static Functions
;-----------------------------
string sAddOnName=""
string property AddOnName hidden
	string function Get()
		if sAddOnName==""
			int fID=GetFormID() ; FormID
			int bID=fID % 0x1000000 ; Form Base ID
			int mID=(fID-bID)/0x1000000 ; Mod ID
			string ModName=Game.GetModName(mID)
			Debug.Notification(ModName+"; mID:"+mID+"; bID:"+bID)
			int c=FWUtility.GetFileCount("AddOn","ini")
			while c>0
				c-=1
				string n=FWUtility.GetFileName("AddOn","ini",c)
				if FWUtility.GetIniCString("AddOn",n,"AddOn","modFile")==ModName
					if FWUtility.GetIniCInt("AddOn",n,"AddOn","form")==bID
						SetAddOnName(n)
						return n
					endif
				endif
			endWhile
		endif
		return sAddOnName
	endFunction
endProperty
function SetAddOnName(string s)
	sAddOnName = s
endFunction

;---------------------------------
;  Read / Write Mod Settings
;---------------------------------

string function GetString(string name, string Default="")
	if AddOnName==""
		return Default
	else
		return FWUtility.GetIniCString("AddOn",sAddOnName,"Settings",name,Default)
	endif
endFunction
function SetString(string name, string value)
	if AddOnName!=""
		FWUtility.SetIniCString("AddOn",sAddOnName,"Settings",name,value)
	endif
endFunction

bool function GetBool(string name, bool Default=false)
	if AddOnName==""
		return Default
	else
		return FWUtility.GetIniCBool("AddOn",sAddOnName,"Settings",name,Default)
	endif
endFunction
function SetBool(string name, bool value)
	if AddOnName!=""
		FWUtility.SetIniCBool("AddOn",sAddOnName,"Settings",name,value)
	endif
endFunction

int function GetInt(string name, int Default=0)
	if AddOnName==""
		return Default
	else
		return FWUtility.GetIniCInt("AddOn",sAddOnName,"Settings",name,Default)
	endif
endFunction
function SetInt(string name, int value)
	if AddOnName!=""
		FWUtility.SetIniCInt("AddOn",sAddOnName,"Settings",name,value)
	endif
endFunction

float function GetFloat(string name, float Default=0.0)
	if AddOnName==""
		return Default
	else
		return FWUtility.GetIniCFloat("AddOn",sAddOnName,"Settings",name,Default)
	endif
endFunction
function SetFloat(string name, float value)
	if AddOnName!=""
		FWUtility.SetIniCFloat("AddOn",sAddOnName,"Settings",name,value)
	endif
endFunction

FWSystem function GetSystem()
	return Game.GetFormFromFile(0xD62,"BeeingFemale.esm") as FWSystem
endFunction

FWSystemConfig function GetConfig()
	return Game.GetFormFromFile(0x1828,"BeeingFemale.esm") as FWSystemConfig
endFunction

FWController function GetController()
	return Game.GetFormFromFile(0x182a,"BeeingFemale.esm") as FWController
endFunction
