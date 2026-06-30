Scriptname BFA_Ostim extends FWAddOn_Misc
import FWUtility

OSexIntegrationMain OStim
bool bOstim = false
FWSystem property System auto

int TryRegisterCount = 0

FWSystemConfig property cfg auto
Spell Property BeeingFemaleSpell Auto
FWController property Controller auto
FWAddOnManager property Manager auto
FWTextContents property Content auto
Actor Property PlayerRef Auto

function OnGameLoad()
	if !System
		System=GetSystem()
	endif
	bOstim = false
	UnregisterForAllModEvents()
	TryRegisterCount = 0
	RegisterForSingleUpdate(5)
endFunction

event OnUpdate()
	If Game.GetModByName("Ostim.esp")!= 255
		if registerOstimEventHandlers() > 0
			bOstim = true
		endif
	endif
	If !bOstim && (TryRegisterCount < 10)
		;UnregisterForUpdate()
		RegisterForSingleUpdate(5)
		TryRegisterCount+=1
	endif
endEvent

int function registerOstimEventHandlers()
    OStim = OUtils.GetOStim()
    if (OStim == none || OStim.GetAPIVersion() < 23)
        return 0
    endif
	RegisterForModEvent("ostim_start", "OStimStart")
	RegisterForModEvent("FertilityModeAddSperm", "OnFertilityModeAddSperm")
    return 2
endFunction

Event OStimStart(String EventName, String sceneId, Float index, Form Sender)
	OStim = OUtils.GetOStim()
	if !OStim
		return
	endif

	Actor[] actors = OStim.GetActors()
	if actors.Length <= 0
		return
	endif

	int i = actors.Length
	while i > 0
		i -= 1
		Actor a = actors[i]
		if a && StorageUtil.FormListHas(none, "FW.Babys", a) && StorageUtil.GetIntValue(a, "FW.Child.GrownUp", 0) != 1
			; Grown-up children stay in FW.Babys but are eligible adults
			OStim.ForceStop()
			return
		endif
	endWhile
EndEvent

Event OnFertilityModeAddSperm(Form impregnatedForm, string fatherName, Form fatherForm)
	Actor impregnated = impregnatedForm as Actor
	Actor father = fatherForm as Actor
	if impregnated && father
		processPair(impregnated, father)
	endIf
EndEvent

function Refresh(string strArg, FWAddOnManager sender)
	;parent.Refresh(strArg, sender)
	OnGameLoad()
endFunction

bool function IsOstimActive()
	return bOstim
endFunction

bool function IsActive()
	return bOstim
endFunction

Function processPair(Actor female, Actor Male)
	If !Female || !Male
		return
	endif
	bool bCondom = System.CheckForCondome(Female, Male)
	If bCondom
		return
	endif
	float amount = 1.0
	;Trace("6. Male and Female are relevant for now")

	int maleSex = Male.getLeveledActorBase().GetSex()
	if maleSex == 0
		if System.IsValidateMaleActor(Male)<0
			;Trace("   Male is not a validate Male Actor: "+System.IsValidateMaleActor(Male))
			;Trace("[/SexLabOrgasmEvent]")
			return
		endif
	else
		if !cfg.AllowFFCum
			return
		endif
		if System.IsValidateFemaleActor(Male)<0
			;Trace("   Male is not a validate Female Actor: "+System.IsValidateFemaleActor(Male))
			;Trace("[/SexLabOrgasmEvent]")
			return
		endif
	endif

	int femaleSex = Female.getLeveledActorBase().GetSex()
	if femaleSex == 0
		if System.IsValidateMaleActor(Female)<0
			;Trace("   Female is not a validate Male Actor: "+System.IsValidateMaleActor(Female))
			;Trace("[/SexLabOrgasmEvent]")
			return
		endif
	elseif System.IsValidateFemaleActor(Female)<0
			;Trace("   Female is not a validate Female Actor: "+System.IsValidateFemaleActor(Female))
			;Trace("[/SexLabOrgasmEvent]")
			return
	endif

		;Trace("8. Add sperm")

		;Trace("   Raise AddOn Event 'OnCameInside'")
		;Manager.OnCameInside(Female,Male)

		;If Female.HasSpell(BeeingFemaleSpell)==false && System.IsValidateFemaleActor(Female)>0
		If Female.HasSpell(BeeingFemaleSpell) ;Tkc (Loverslab): optimization
		else;If Female.HasSpell(BeeingFemaleSpell)==false
		 if System.IsValidateFemaleActor(Female)>0
			;Trace("   Female doesn't had BF Spell - apply spell")
			System.ActorAddSpellOpt(Female,BeeingFemaleSpell)
		 endif
		endif

		float virility = Controller.GetVirility(Male)
		amount = Utility.RandomFloat(virility * 0.75, virility*1.1)
		if amount>1.0
			amount=1.0
		endif

		amount = Manager.getSpermAmount(Female,Male,amount)
		;Trace("   Calculated Sperm-Amount is " + amount)

		if Female.HasSpell(BeeingFemaleSpell) ;Tkc (Loverslab): optimization
		else;if Female.HasSpell(BeeingFemaleSpell)==false
			;Trace("   Female still don't got the BF Spell - ignore and continue")
			System.Message( FWUtility.StringReplace( Content.NoBeeingFemaleSpell , "{0}",Female.GetLeveledActorBase().GetName()), System.MSG_Immersive)
		endif
		actor p = PlayerRef
		If Male == p
			;self.Message("You came inside " + Female.GetLeveledActorBase().GetName() + ".", self.MSG_Immersive)
			System.Message( FWUtility.StringReplace( Content.YouCameInsideNPC , "{0}",Female.GetLeveledActorBase().GetName()), System.MSG_Immersive)
		ElseIf Female == p
			;self.Message(Male.GetLeveledActorBase().GetName() + " came inside you.", self.MSG_Immersive)
			System.Message( FWUtility.StringReplace( Content.NPCCameInsideYou , "{0}",Male.GetLeveledActorBase().GetName()), System.MSG_Immersive)
		Else
			;self.Message(Male.GetLeveledActorBase().GetName() + " came inside " + Female.GetLeveledActorBase().GetName() + ".", self.Msg_High)
			string[] astring = new string[2]
			astring[0] = Male.GetLeveledActorBase().GetName()
			astring[1] = Female.GetLeveledActorBase().GetName()
			System.Message( FWUtility.ArrayReplace(Content.NPCCameInsideNPC,astring), System.Msg_High)
		EndIf

		if amount>0.0
			;Trace("   Finaly add " + amount + " sperm from "+Male.GetLeveledActorBase().GetName() + " to " +Female.GetLeveledActorBase().GetName())
			Controller.AddSperm(Female, Male, amount)				
		endif
endfunction

bool function OnAllowFFCum(Actor WomanToAdd, Actor denor)
	if !OStim ;Tkc (Loverslab): optimization
		return false
	endif
	if cfg && !cfg.AllowFFCum
		return false
	endif
	return true
endFunction