Scriptname BFA_ssl extends FWAddOn_Misc
import FWHentairimUtils

SexLabFramework Property SexLab Auto
sslThreadLibrary Lib
bool bSexLab = false
FWSystem property System auto

int TryRegisterCount=0

FWSystemConfig property cfg auto
Spell Property BeeingFemaleSpell Auto
FWController property Controller auto
FWAddOnManager property Manager auto
FWTextContents property Content auto
Actor Property PlayerRef Auto

bool bZad = false
bool bSexLabPP = false

Keyword zad_DeviousPlugAnal
Keyword zad_DeviousPlugVaginal
Keyword zad_DeviousBelt

function OnGameLoad()
	if !System
		System = GetSystem()
	endif
	bSexLab = false
	bSexLabPP = false
	bZad=false
	UnregisterForAllModEvents()
	TryRegisterCount = 0
	RegisterForSingleUpdate(5)
endFunction

event OnUpdate()
	if Game.GetModByName("SexLab.esm") != 255
		SexLab = Game.GetFormFromFile(0x00000D62, "SexLab.esm") as SexLabFramework
		; Lib = Game.GetFormFromFile(0x00000D62, "SexLab.esm") as sslThreadLibrary
		if SexLab ;&& Lib
			bSexLab = true
			; SexLab P+ 2.17.1+ packs version as (major<<24)|(minor<<16)|(patch<<4)|build
			; 2.17.1.0 = (2<<24)|(17<<16)|(1<<4) = 34668560
			if SKSE.GetPluginVersion("SexLabUtil") >= 34668560
				bSexLabPP = true
				RegisterForModEvent("SexLabApplyCumFX", "OnSexLabApplyCumFX")
			else
				RegisterForModEvent("OrgasmStart", "OnSexLabOrgasm")
				RegisterForModEvent("HookOrgasmStart", "OnSexLabOrgasm")
				RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
			endif
			If Game.GetModByName("Devious Devices - Assets.esm") != 255
				bZad = true
				zad_DeviousPlugAnal		= Game.GetFormFromFile(0x0001DD7D, "Devious Devices - Assets.esm") as Keyword
				zad_DeviousPlugVaginal	= Game.GetFormFromFile(0x0001DD7C, "Devious Devices - Assets.esm") as Keyword
				zad_DeviousBelt			= Game.GetFormFromFile(0x00003330, "Devious Devices - Assets.esm") as Keyword
			EndIf
		endif
	endif
	if !bSexLab && (TryRegisterCount < 10)
		RegisterForSingleUpdate(5)
		TryRegisterCount+=1
	endif
endEvent

function Refresh(string strArg, FWAddOnManager sender)
	;parent.Refresh(strArg, sender)
	OnGameLoad()
endFunction

bool function IsSSLActive() ;Edit by BAne
	return bSexLab
endFunction

bool function IsActive()
	return bSexLab
endFunction


function OnGiveBirthStart(actor Mother)
	if bSexLab;/==true/;
		Mother.SetFactionRank(SexLab.AnimatingFaction, 1)
	endif
endfunction

function OnGiveBirthEnd(actor Mother)
	if bSexLab;/==true/;
		Mother.RemoveFromFaction(SexLab.AnimatingFaction)
	endif
endfunction

bool function OnPainSound(actor Mother)
	return false
endfunction

bool function OnAllowFFCum(Actor WomanToAdd, Actor denor)
	if !bSexLab ;Tkc (Loverslab): optimization
		return false
	endif
	if cfg && !cfg.AllowFFCum
		return false
	endif
	return true
endFunction


bool function FixSexLab()
	if bSexLab ;Tkc (Loverslab): optimization
	else;if bSexLab==false
		return false
	endif
	if SexLab ;Tkc (Loverslab): optimization
	else;if SexLab==none
		SexLab = Game.GetFormFromFile(0x00000D62, "SexLab.esm") as SexLabFramework
		if SexLab ;Tkc (Loverslab): optimization
		else;if SexLab == none
			return false
		endif
	endif
	return true
endFunction

Event OnSexLabOrgasm(string hookName, string argString, float argNum, form sender)
	;Trace("BFA_ssl::onSexLabOrgasm("+hookName+", "+argString+", "+argNum+", "+sender.GetName()+")")
	;Trace("[SexLabOrgasmEvent]")
	;Trace("0. Precheck")
	if SexLab ;Tkc (Loverslab): optimization
	else;if(SexLab==none)
		;Trace("   SexlLab is not defined - try to fix")
		if FixSexLab() ;Tkc (Loverslab): optimization
		else;if(FixSexLab()==false)
			;Trace("   Unable to fix SexLab")
			;Trace("[/SexLabOrgasmEvent]")
			return
		endif
	endif
	;Trace("1. Check for ThreadController")
	int thread_id = argString as int
	sslThreadController ssl_controller = SexLab.GetController(thread_id)
	if ssl_controller ;Tkc (Loverslab): optimization
	else;if ssl_controller==none
		;Trace("   Error: No sslThreadController found")
		;Trace("[SexLabOrgasmEvent]")
		return
	endif
	;Trace("2. Check for BaseAnimation")
	sslBaseAnimation animation = ssl_controller.Animation
	if animation ;Tkc (Loverslab): optimization
	else;if animation==none
		;Trace("   Error: No sslBaseAnimation found")
		;Trace("[SexLabOrgasmEvent]")
		return
	endif
	if (animation.PositionCount > 1)
		;Find first male actor and proceed as with Separate orgasm
		Actor firstOrgasmingDonor = GetSpermDonorFromList(ssl_controller.Positions)
		If (firstOrgasmingDonor)
			OrgasmSeparate(ssl_controller, animation, firstOrgasmingDonor)
		EndIf
	endIf
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int thread)
	;Trace("BFA_ssl::OnSexLabOrgasmSeparate("+ActorRef+", "+thread+")")
	;Trace("[SexLabOrgasmEvent]")
	;Trace("0. Precheck")
	if SexLab ;Tkc (Loverslab): optimization
	else;if(SexLab==none)
		;Trace("   SexlLab is not defined - try to fix")
		if FixSexLab() ;Tkc (Loverslab): optimization
		else;if(FixSexLab()==false)
			;Trace("   Unable to fix SexLab")
			;Trace("[/SexLabOrgasmEvent]")
			return
		endif
	endif
	;Trace("1. Check for ThreadController")
	sslThreadController ssl_controller = SexLab.GetController(thread)
	if ssl_controller ;Tkc (Loverslab): optimization
	else;if ssl_controller==none
		;Trace("   Error: No sslThreadController found")
		;Trace("[SexLabOrgasmEvent]")
		return
	endif
	;Trace("2. Check for BaseAnimation")
	sslBaseAnimation animation = ssl_controller.Animation
	if animation ;Tkc (Loverslab): optimization
	else;if animation==none
		;Trace("   Error: No sslBaseAnimation found")
		;Trace("[SexLabOrgasmEvent]")
		return
	endif
	Actor akActor = ActorRef as actor
	if (akActor)
		if (animation.PositionCount > 1 && ssl_controller.Positions.Find(akActor) >= 0)
			OrgasmSeparate(ssl_controller, animation, akActor)
		endIf
	endIf
EndEvent

; SexLab P+ 2.17.1+ cum effect event — more precise than legacy orgasm events
; aiType: 0 = vaginal, 1 = anal, 2 = oral
Event OnSexLabApplyCumFX(Form TargetRef, Form SourceRef, int aiType)
	if aiType == 2
		return
	endif
	Actor Female = TargetRef as Actor
	Actor Male = SourceRef as Actor
	if !Female || !Male
		return
	endif
	if aiType == 1
		if Utility.RandomInt(1, 100) > cfg.NoVaginalCumChance
			return
		endif
	endif
	if sexlab.ActorLib.IsCreature(Male) && !cfg.CreatureSperm
		FW_log.WriteLog("BFA_ssl.OnSexLabApplyCumFX: blocked — creature donor but CreatureSperm=false")
		return
	endif
	FW_log.WriteLog("BFA_ssl.OnSexLabApplyCumFX: processing pair Female=" + Female + ", Male=" + Male + ", type=" + aiType)
	processPair(Female, Male, aiType == 1)
EndEvent

Actor Function GetSpermDonorFromList(Actor[] actorList)
	Int i = 0
	While i < actorList.Length
		Actor cur = actorList[i]
		int gender = SexLab.GetGender(cur)
		if gender == 0 || gender == 2
			return cur
		endif
		i += 1
	EndWhile
	return none
EndFunction

Function OrgasmSeparate(sslThreadController ssl_controller, sslBaseAnimation animation, Actor currentOrgasmingActor)

	if !currentOrgasmingActor
		return
	endif

	Actor[] actors = ssl_controller.Positions
	sslBaseAnimation anim = animation
	int Stage = ssl_controller.Stage
	
 	int pos = GetActorPositionFromList(actors, currentOrgasmingActor)
    ;String stageTagsAll = GetStageTagsAsString(animation, Stage)
    String penetrationLabel = FWHentairimUtils.PenetrationLabel(anim, Stage, pos)
    String oralLabel = FWHentairimUtils.OralLabel(anim, Stage, pos)
    String stimulationLabel = FWHentairimUtils.StimulationLabel(anim, Stage, pos)
    String penisActionLabel = FWHentairimUtils.PenisActionLabel(anim, Stage, pos)
    String endingLabel = FWHentairimUtils.EndingLabel(anim, Stage, pos)
    ;log(">>Penetration:" + penetrationLabel + ".Oral:" + oralLabel + ".Stimul:" + stimulationLabel + ".Penis:" + penisActionLabel + ".Ending:" + endingLabel  )
   	
	Bool inseminationTrigger = false
	Bool legacyCondition = anim.hasTag("Vaginal") || anim.hasTag("Anal")

    Bool isVaginalInside = true
    Bool isAnalInside = true

    if isAnimationHentairimTaggedStrings(penetrationLabel, oralLabel, stimulationLabel, endingLabel, penisActionLabel)
		;logAndPrint(">>Actor:" + akActor.GetLeveledActorBase().GetName() + ":p[" + pos + "],s["+ stage + "]. Penetration:" + penetrationLabel + ".Oral:" + oralLabel + ".Stimul:" + stimulationLabel + ".Penis:" + penisActionLabel + ".Ending:" + endingLabel)
    	isVaginalInside = IsGivingVaginalPenetration(penisActionLabel) 
    	isAnalInside =  IsGivingAnalPenetration(penisActionLabel) 
		inseminationTrigger = legacyCondition && (isVaginalInside || isAnalInside)
    Else
		;logAndPrint(">>Actor:" + akActor.GetLeveledActorBase().GetName() + ":p[" + pos + "],s["+ stage + "]. No hentairim stage tags detected. Fallback to regular tags")
		inseminationTrigger = legacyCondition
    endif

	If !inseminationTrigger
		FW_log.WriteLog("BFA_ssl.OrgasmSeparate: no insemination trigger — vaginal=" + anim.hasTag("Vaginal") + ", anal=" + anim.hasTag("Anal") + ", hentairimVag=" + isVaginalInside + ", hentairimAnal=" + isAnalInside)
		return
	endif

	if sexlab.ActorLib.IsCreature(currentOrgasmingActor) && !cfg.CreatureSperm
		FW_log.WriteLog("BFA_ssl.OrgasmSeparate: blocked — creature donor but CreatureSperm=false")
		return
	endif

	If (!sexlab.config.allowFFCum && sexlab.MaleCount(actors) < 1 && sexlab.CreatureCount(actors) < 1)
		FW_log.WriteLog("BFA_ssl.OrgasmSeparate: blocked — FF scene and allowFFCum=false")
		return
	EndIf

	;process receiving actors
	bool bool_cameInsideAnal = anim.hasTag("Anal") && isAnalInside && Utility.RandomInt(1, 100) <= cfg.NoVaginalCumChance
	If !((anim.hasTag("Vaginal") && isVaginalInside) || bool_cameInsideAnal)
		FW_log.WriteLog("BFA_ssl.OrgasmSeparate: no vaginal/anal cum path matched")
		return
	EndIf
	int i = actors.length
	while i > 0
			i -= 1
			int cumSpot = anim.GetCum(i)
			int actorGender = sexlab.GetGender(actors[i])
		;	log(anim.name + " - cumSpot for position " + i + ": " + cumSpot)
			If currentOrgasmingActor != actors[i]
				; only inseminate if the actor is female (or male pretending to be female!) and the animation position has cum effect set
				If ((actorGender == 1) && cumSpot != -1)
					processPair(actors[i], currentOrgasmingActor, bool_cameInsideAnal)
				EndIf
			EndIf
		EndWhile
EndFunction

Function processPair(Actor Female, Actor Male, bool bool_cameInsideAnal)
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
	elseif System.IsValidateFemaleActor(Male)<0
			;Trace("   Male is not a validate Female Actor: "+System.IsValidateFemaleActor(Male))
			;Trace("[/SexLabOrgasmEvent]")
			return
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

		if bZad;/==true/;
			;Trace("7. Check for Device")
			if(Female.WornHasKeyword(zad_DeviousBelt) || Female.WornHasKeyword(zad_DeviousPlugVaginal) || (bool_cameInsideAnal && Female.WornHasKeyword(zad_DeviousPlugAnal)))
				;Trace("   A Device-Belt was detected")
				;Trace("[/SexLabOrgasmEvent]")
				return
			;else
				;Trace("   No device was detected")
			endif
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
		;If cfg.MaleVirilityRecovery > 0.0
		;	float virility = FWUtility.ClampFloat(Controller.GetDaysSinceLastSex(Male) / cfg.MaleVirilityRecovery, 0.02, 1.0)
		;	amount = Utility.RandomFloat(virility * 0.75, virility*1.1)
		;	if amount>1.0
		;		amount=1.0
		;	endif
		;	System.Trace("   Base Sperm-Amount is " + amount)
		;EndIf

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

bool function OnPlayPainSound(actor ActorRef, float Strength)
	; Disabled: SexLab's voice.Moan pain sound never actually played here ("it is not
	; working", per the original author). Return false so FWSystem.PlayPainSound falls
	; back to BF's own bundled female pain sound, which works for SexLab and non-SexLab
	; (OStim) setups alike. (Old SexLab path kept below, commented, for reference.)
	return false
	;/
	if bSexLab ;Tkc (Loverslab): optimization
	else;if bSexLab==false
		return false
	endif
	sslBaseVoice voice = SexLab.PickVoice(ActorRef)
	if voice
		voice.Moan(ActorRef, Strength as int, true);it is not working
		return true
	endif
	return false
	/;
endFunction

;/sslBaseVoice property SSLVoice auto hidden ;Tkc (Loverslab): sexlab sslBaseVoice module
bool property SexlabPainSounds auto ;Tkc (Loverslab): to be possible to disable it
function PlayPainSound(Actor A,float Strength=30.0)
	if bSexLab
		if SexlabPainSounds
			if SSLVoice
				;sslBaseVoice: PlayMoan(Actor ActorRef, int Strength = 30, bool IsVictim = false, bool UseLipSync = false)
				SSLVoice.PlayMoan(A, Strength as int, true, true) ; Tkc: tested in game and when Sexlab is active will be using pain sound from saved voices from Sexlab
			endif
		endif
	endif
endFunction/;

ObjectReference function OnGetBedRef(Actor ActorRef)
	if bSexLab ;Tkc (Loverslab): optimization
	else;if bSexLab==false
		return none
	endif
	return Game.FindClosestReferenceOfAnyTypeInListFromRef(SexLab.Config.BedsList, ActorRef, 600.0)
endFunction

function OnMimik(actor ActorRef, string ExpressionName = "", int Strength = 50, bool bClear = true)
	if bSexLab ;Tkc (Loverslab): optimization
	else;if bSexLab==false
		return
	endif
	if bClear
		SexLab.ClearMFG(ActorRef)
	endif
	if ExpressionName;/!=""/; ;Tkc (Loverslab): optimization
		if SexLab.GetExpressionByName(ExpressionName);/!=none/;
			SexLab.GetExpressionByName(ExpressionName).Apply(ActorRef, Strength,1)
		endif
	endif
endFunction

Form[] function OnStripActor(Actor ActorRef)
	if bSexLab;/==true/;
		return SexLab.StripActor(ActorRef)
	endif
endFunction

; 02.06.2019 Tkc (Loverslab) optimizations: Changes marked with "Tkc (Loverslab)" comment. Added Sexlab pain sound when Sexlab is active(for example for giving birth)
