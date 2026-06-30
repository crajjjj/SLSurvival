Scriptname BFA_BathingInSkyrim extends FWAddOn_Misc

bool bIsInstalled=false
int TryRegisterCount=0
FWSystem property System auto
MagicEffect property sBathingEffect auto
MagicEffect property sBathingEffectSoap auto
MagicEffect property sBathingEffectSoapAnim = none auto hidden
bool bActive = false

FWController property Controller auto

function OnGameLoad()
	if System==none
		System=GetSystem()
	endif
	bIsInstalled = false
	sBathingEffect = none
	sBathingEffectSoap = none
	TryRegisterCount=0
	RegisterForSingleUpdate(5)
endFunction

event OnUpdate()
;	int idx = Game.GetModCount()
;	string modName = ""
;	while idx > 0
;		idx -= 1
;		modName = Game.GetModName(idx)
;		if modName == "Bathing in Skyrim - Main.esp" || modName == "Bathing in Skyrim - Main.esm"
;			sBathingEffect = Game.GetFormFromFile(0x28a3b,modName) as MagicEffect
;			sBathingEffectSoap = Game.GetFormFromFile(0x228ff,modName) as MagicEffect
;			bIsInstalled = sBathingEffect!=none && sBathingEffectSoap!=none
;			TryRegisterCount=0
;			return
;		endif
;	endwhile

	FW_log.WriteLog("BFA_BathingInSkyrim - checking whether Bathing in Skyrim is installed...")
	string modName = FWUtility.ModFile("Bathing in Skyrim - Main")
	if modName != ""
		FW_log.WriteLog("BFA_BathingInSkyrim - BFA_BathingInSkyrim - Bathing in Skyrim is installed. Its plugin name is " + modName)
		sBathingEffect = Game.GetFormFromFile(0x28a3b, modName) as MagicEffect
		sBathingEffectSoap = Game.GetFormFromFile(0x228ff, modName) as MagicEffect
		sBathingEffectSoapAnim = sBathingEffectSoap
		bIsInstalled = ((sBathingEffect != none) && (sBathingEffectSoap != none))
		FW_log.WriteLog("BFA_BathingInSkyrim - BFA_BathingInSkyrim - bIsInstalled is " + bIsInstalled)
		TryRegisterCount=0
		return
	else
		FW_log.WriteLog("BFA_BathingInSkyrim - BFA_BathingInSkyrim - checking whether Bathing in Skyrim - Renewed is installed...")
		modName = FWUtility.ModFile("Bathing in Skyrim")
		if modName != ""
			FW_log.WriteLog("BFA_BathingInSkyrim - BFA_BathingInSkyrim - Bathing in Skyrim - Renewed is installed. Its plugin name is " + modName)
			sBathingEffect = Game.GetFormFromFile(0x00002C, modName) as MagicEffect
			sBathingEffectSoap = Game.GetFormFromFile(0x00002A, modName) as MagicEffect
			sBathingEffectSoapAnim = Game.GetFormFromFile(0x00002B, modName) as MagicEffect
			bIsInstalled = ((sBathingEffect != none) && (sBathingEffectSoap != none) && (sBathingEffectSoapAnim != none))
			FW_log.WriteLog("BFA_BathingInSkyrim - BFA_BathingInSkyrim - bIsInstalled is " + bIsInstalled)
			TryRegisterCount=0
			return
		endif
	endIf

		
	if !(TryRegisterCount>10)
		TryRegisterCount+=1
		RegisterForSingleUpdate(5)
	endif
endEvent

function OnMagicEffectApply(Actor akWoman, ObjectReference akCaster, MagicEffect akEffect)
	if bIsInstalled && bActive
		if akEffect==sBathingEffect
			Controller.WashOutSperm(akWoman, 1, 0.6)
		;elseif akEffect==sBathingEffectSoap
		elseif((akEffect == sBathingEffectSoap) || (akEffect == sBathingEffectSoapAnim))
			Controller.WashOutSperm(akWoman, 1, 0.8)
		endif
	endif
endfunction

function OnAddOnActivate()
	if bActive==false
		bActive=true
	endif
endFunction

function OnAddOnDeactivate()
	if bActive==true
		bActive=false
	endif
endFunction

bool function IsActive()
	if System==none
		GetSystem()
		return false
	endif
	if sBathingEffect==none
		RegisterForSingleUpdate(5)
		return false
	endif
;	if sBathingEffectSoap==none
	if((sBathingEffectSoap == none) || (sBathingEffectSoapAnim == none))
		RegisterForSingleUpdate(5)
		return false
	endif
	return true
endFunction

;function OnCameInside(actor akFemale, actor akMale)
;	if bActive
;		if akFemale==Game.GetPlayer()
;			TODO - make woman dirty
;		endif
;	endif
;endFunction

;function OnGiveBirth(actor akMother, int iChildCount)
;	if bActive
;		if akMother==Game.GetPlayer()
;			TODO - make woman dirty
;		endif
;	endif
;endFunction
