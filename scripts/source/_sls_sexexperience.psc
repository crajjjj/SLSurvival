Scriptname _SLS_SexExperience extends Quest  

Event OnInit()
	If Self.IsRunning()
		RegisterForEvents()
	EndIf
EndEvent

Function RegisterForEvents()
	UnRegisterForAllModEvents()
	RegisterForModEvent("HookAnimationStarting", "OnAnimationStarting")
	RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
EndFunction

Event OnAnimationStarting(int tid, bool HasPlayer)
	If HasPlayer
		CurrentTid = tid
		RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
		RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
		NormalizeAvs()
		
		IsPlayerVictim = Sexlab.IsVictim(CurrentTid, PlayerRef)
		
		Form akStorageForm
		Actor[] ActorList = SexLab.HookActors(tid as string)
		Actor akActor = GetSexPartner(ActorList)
		IsMasturbation = false
		IsDremora = false
		Int Experience
		EnjBonus = 0
		If akActor
			If Sexlab.CreatureCount(actorList) > 0 ; Creature animation
				IsCreatureAnim = true
				RegisterForModEvent("_SLS_PlayerSwallowedCum", "On_SLS_PlayerSwallowedCum")
				StorageUtil.AdjustIntValue(None, "_SLS_CreatureSexCount", 1)
				akStorageForm = akActor.GetVoiceType() ; Store exp info on voice form
				StorageUtil.FormListAdd(None, "_SLS_CreatureSexForms", akStorageForm, allowDuplicate = false)
				;PlayerEnjoymentMult = PapyrusUtil.ClampFloat((StorageUtil.GetIntValue(None, "_SLS_CreatureSexOrgasmCount", Missing = 0) - StorageUtil.GetIntValue(None, "_SLS_HumanSexOrgasmCount", Missing = 0)), -100.0, 100.0)
				Experience = StorageUtil.AdjustIntValue(akStorageForm, "_SLS_SexExperience", 1) - 1
				BeginCockSizeBonusEnjoyment(akActor, GetCockCount(ActorList, IsCreatureAnim))
			
			Else ; Human animation
				IsCreatureAnim = false
				akStorageForm = akActor.GetRace() ; Store exp info on race form
				If (akStorageForm as Race).IsRaceFlagSet(0x00000001) ; Playable race
					StorageUtil.AdjustIntValue(None, "_SLS_HumanSexCount", 1)
					StorageUtil.FormListAdd(None, "_SLS_HumanSexForms", akStorageForm, allowDuplicate = false)
					If akActor.GetLeveledActorBase().GetSex() == 1
						Experience = StorageUtil.AdjustIntValue(akStorageForm, "_SLS_SexExperienceFemale", 1) - 1
					Else
						Experience = StorageUtil.AdjustIntValue(akStorageForm, "_SLS_SexExperienceMale", 1) - 1
					EndIf
				
				Else ; Non playable race
					If akStorageForm as Race == DremoraRace
						IsDremora = true
						If akActor.GetLeveledActorBase().GetSex() == 1
							Experience = StorageUtil.AdjustIntValue(akStorageForm, "_SLS_SexExperienceFemale", 1) - 1
						Else
							Experience = StorageUtil.AdjustIntValue(akStorageForm, "_SLS_SexExperienceMale", 1) - 1
							BeginCockSizeBonusEnjoyment(akActor, GetCockCount(ActorList, IsCreatureAnim))
						EndIf
						
					
					Else ; Something else - Custom follower race probably
						StorageUtil.AdjustIntValue(None, "_SLS_HumanSexCount", 1)
						If akActor.GetLeveledActorBase().GetSex() == 1
							Experience = StorageUtil.AdjustIntValue(None, "_SLS_SexExperienceGenericFemale", 1) - 1
						Else
							Experience = StorageUtil.AdjustIntValue(None, "_SLS_SexExperienceGenericMale", 1) - 1
						EndIf
					EndIf
				EndIf
				;PlayerEnjoymentMult = PapyrusUtil.ClampFloat((StorageUtil.GetIntValue(None, "_SLS_HumanSexOrgasmCount", Missing = 0) - StorageUtil.GetIntValue(None, "_SLS_CreatureSexOrgasmCount", Missing = 0)), -100.0, 100.0) ; Human Vs Creature corruption....
				;PlayerEnjoymentMult = PapyrusUtil.ClampInt(StorageUtil.GetIntValue(None, "_SLS_CreatureSexOrgasmCount", Missing = 0) - StorageUtil.GetIntValue(None, "_SLS_CleansedCorruption", Missing = 0), 0, 100)
				PlayerEnjoymentMult = PapyrusUtil.ClampFloat(StorageUtil.GetFloatValue(None, "_SLS_CreatureCorruption", Missing = 0.0), 0.0, 100.0)
				
				EnjBonus = -(Math.Floor(15 * (PlayerEnjoymentMult / 100.0)))
				
			EndIf
			
			; Rape
			If IsPlayerVictim
				; Forced drugs
				If !IsCreatureAnim && Menu.RapeForcedSkoomaChance >= Utility.RandomFloat(0.0, 100.0)
					;PlayerRef.AddItem(Skooma, 1, true)
					;PlayerRef.EquipItem(Skooma, abSilent = true)
					ForceDrug.DoRapeDrugs(akTarget = PlayerRef, Quantity = 1, Silent = true)
					Debug.Notification("I'm forced to drink something")
				EndIf
				
				; Minimum arousal
				DoMinimumArousal(ActorList)
			EndIf

			Int ExpRank = GetSexExpRank(Experience)
			ToggleSexExperienceSpells(Rank = ExpRank)
			Debug.Trace("_SLS_: SexExperience: akStorageForm: " + akStorageForm + ". Experience: " + Experience + ". ExpRank: " + ExpRank + ". IsCreatureAnim: " + IsCreatureAnim + ". IsDremora: " + IsDremora + ". PlayerEnjoymentMult: " + PlayerEnjoymentMult)
			If (!IsCreatureAnim && !IsDremora) && Menu.SexExpCorruption != 0
				OnUpdate()
			EndIf
		
		Else ; Masturbation
			IsCreatureAnim = false
			IsMasturbation = true
			StorageUtil.AdjustIntValue(PlayerRef, "_SLS_SexExperience", 1)
		EndIf
	EndIf
EndEvent

Event OnUpdate()
	;Int EnjBonus = Math.Floor(15 * (PlayerEnjoymentMult / 100.0))
	If EnjBonus != 0
		If Init.DebugMode
			Debug.Notification("Bonus Enjoyment: " + EnjBonus)
		EndIf
		Slso.ModEnjoyment(CurrentTid, PlayerRef, EnjBonus)
		RegisterForSingleUpdate(2.0 + (10.0 - (10.0 * (PlayerEnjoymentMult/100.0))))
	EndIf
EndEvent

Event OnAnimationEnd(int tid, bool HasPlayer)
	If HasPlayer
		UnRegisterForUpdate()
		_SLS_SexCockSizeQuest.Stop()
		ToggleSexExperienceSpells(Rank = -1)
		UnRegisterForModEvent("HookAnimationEnd")
		UnRegisterForModEvent("SexLabOrgasmSeparate")
		UnRegisterForModEvent("_SLS_PlayerSwallowedCum")
		
		RemoveMinAvBuffs()
		
		If Menu.RapeDrainsAttributes && IsPlayerVictim
			PlayerRef.DamageActorValue("Stamina", PlayerRef.GetAv("Stamina"))
			PlayerRef.DamageActorValue("Magicka", PlayerRef.GetAv("Magicka"))
		EndIf
		;/
		If StartingArousal != -100.0
			StorageUtil.SetFloatValue(PlayerRef, "SLAroused.ActorExposure", StartingArousal)
			;Util.ModArousal(PlayerRef, Amount = -100.0)
			;Utility.Wait(1.0)
			Util.ModArousal(PlayerRef, Amount = 1.0)
		EndIf
		/;
	EndIf
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int tid)
	If ActorRef == PlayerRef
		;StartingArousal = -100.0 ; Cancel reverting to original arousal on animation end if the player managed to orgasm
		If IsMasturbation
			StorageUtil.AdjustIntValue(PlayerRef, "_SLS_MasturbationOrgasmCount", 1)
		Else		
			If IsCreatureAnim
				StorageUtil.AdjustIntValue(None, "_SLS_CreatureSexOrgasmCount", 1)
				Util.IncreamentCreatureCorruption()
			ElseIf IsDremora
				StorageUtil.AdjustIntValue(None, "_SLS_DremoraSexOrgasmCount", 1)
				If Menu.DremoraCorruption
					StorageUtil.AdjustFloatValue(None, "_SLS_CreatureCorruption", 1.0)
				EndIf
			Else
				StorageUtil.AdjustIntValue(None, "_SLS_HumanSexOrgasmCount", 1)
			EndIf
		EndIf
	EndIf
EndEvent

Int Function GetSexExpRank(Int Experience)
	If Experience == 0
		Return 0
	ElseIf Experience <= 1
		Return 1
	ElseIf Experience <= 2
		Return 2
	ElseIf Experience <= 5
		Return 3
	ElseIf Experience <= 10
		Return 4
	ElseIf Experience <= 20
		Return 5
	ElseIf Experience <= 50
		Return 6
	ElseIf Experience > 50
		Return 7
	EndIf
EndFunction

Function ToggleSexExperienceSpells(Int Rank)
	If Rank == -1 ; RemoveSpells
		Int i = SexExpSpells.Length
		While i > 0
			i -= 1
			PlayerRef.RemoveSpell(SexExpSpells[i])
		EndWhile
	Else
		PlayerRef.AddSpell(SexExpSpells[Rank], true)
	EndIf
EndFunction

Actor Function GetSexPartner(Actor[] ActorList)
	Int i = ActorList.Length
	While i > 0
		i -= 1
		If ActorList[i] != PlayerRef
			Return ActorList[i]
		EndIf
	EndWhile
	Return None
EndFunction

Int Function GetCockCount(Actor[] ActorList, Bool CreatureAnim)
	If CreatureAnim
		Return ActorList.Length - 1
	Else
		Int i = ActorList.Length
		Int CockCount
		While i > 0
			i -= 1
			If ActorList[i].GetLeveledActorBase().GetSex() == 0
				CockCount += 1
			EndIf
		EndWhile
		Return CockCount
	EndIf
EndFunction

Function HealCorruption(Actor akSpeaker)
	_SLS_AmpHealEffectSpell.Cast(akSpeaker, PlayerRef)
	StorageUtil.SetFloatValue(None, "_SLS_CreatureCorruption", 0.0)
	PlayerRef.RemoveItem(Gold001, 5000)
EndFunction

Function DoMinimumArousal(Actor[] SexActors)
	Float Arousal
	Int i = SexActors.Length
	Actor akActor
	While i > 0
		i -= 1
		akActor = SexActors[i]
		If akActor != PlayerRef
			Arousal = akActor.GetFactionRank(Game.GetFormFromFile(0x03FC36, "SexLabAroused.esm") as Faction)
			If Arousal < Menu.RapeMinArousal
				Util.ModArousal(akActor, (((Menu.RapeMinArousal + Utility.RandomFloat(0.0, 10.0)) - Arousal) / StorageUtil.GetFloatValue(akActor, "SLAroused.ExposureRate", Missing = 2.0)))
			EndIf
		EndIf
	EndWhile
EndFunction

Function NormalizeAvs()
	If Menu.SexMinStamMagRates
		Float StaminaRateAV = PlayerRef.GetActorValue("StaminaRate")
		Float StaminaRatemultAV = PlayerRef.GetActorValue("StaminaRateMult")
		
		Float MagickaRateAV = PlayerRef.GetActorValue("MagickaRate")
		Float MagickaRatemultAV = PlayerRef.GetActorValue("MagickaRateMult")
		
		If StaminaRateAV < Menu.SexMinStaminaRate
			_SLS_SexMinStaminaRateSpell.SetNthEffectMagnitude(0, (Menu.SexMinStaminaRate - StaminaRateAV))
			PlayerRef.AddSpell(_SLS_SexMinStaminaRateSpell, false)
		EndIf
		If StaminaRatemultAV < Menu.SexMinStaminaMult
			_SLS_SexMinStaminaRateMultSpell.SetNthEffectMagnitude(0, (Menu.SexMinStaminaMult - StaminaRatemultAV))
			PlayerRef.AddSpell(_SLS_SexMinStaminaRateMultSpell, false)
		EndIf
		
		If MagickaRateAV < Menu.SexMinMagickaRate
			_SLS_SexMinMagickaRateSpell.SetNthEffectMagnitude(0, (Menu.SexMinMagickaRate - MagickaRateAV))
			PlayerRef.AddSpell(_SLS_SexMinMagickaRateSpell, false)
		EndIf
		If MagickaRatemultAV < Menu.SexMinMagickaMult
			_SLS_SexMinMagickaRateMultSpell.SetNthEffectMagnitude(0, (Menu.SexMinMagickaMult - MagickaRatemultAV))
			PlayerRef.AddSpell(_SLS_SexMinMagickaRateMultSpell, false)
		EndIf
	EndIf
EndFunction

Function RemoveMinAvBuffs()
	PlayerRef.RemoveSpell(_SLS_SexMinStaminaRateSpell)
	PlayerRef.RemoveSpell(_SLS_SexMinStaminaRateMultSpell)
	PlayerRef.RemoveSpell(_SLS_SexMinMagickaRateSpell)
	PlayerRef.RemoveSpell(_SLS_SexMinMagickaRateMultSpell)
EndFunction

Function BeginCockSizeBonusEnjoyment(Actor akActor, Int CockCount)
	If Menu.CockSizeBonusEnjFreq > 0.0
		_SLS_SexCockSizeQuest.Start()
		CockSize.BeginBonusEnjoyment(akActor, CurrentTid, CockCount)
	EndIf
EndFunction

Event On_SLS_PlayerSwallowedCum(Form akSource, Bool DidSwallow, Float CumAmount, Float LoadSizeBase, Bool IsCumPotion)
	If DidSwallow
		Util.IncreamentCreatureCorruption()
	EndIf
EndEvent

Bool IsCreatureAnim
Bool IsMasturbation
Bool IsPlayerVictim
Bool IsDremora

Int CurrentTid
Int EnjBonus

Float PlayerEnjoymentMult

MiscObject Property Gold001 Auto

Spell[] Property SexExpSpells Auto

Spell Property _SLS_AmpHealEffectSpell Auto
Spell Property _SLS_SexMinStaminaRateSpell Auto
Spell Property _SLS_SexMinStaminaRateMultSpell Auto
Spell Property _SLS_SexMinMagickaRateSpell Auto
Spell Property _SLS_SexMinMagickaRateMultSpell Auto

Potion Property Skooma Auto

Actor Property PlayerRef Auto

Race Property DremoraRace Auto

Quest Property _SLS_SexCockSizeQuest Auto

SexlabFramework Property Sexlab Auto

SLS_Mcm Property Menu Auto
SLS_Init Property Init Auto
SLS_Utility Property Util Auto
_SLS_SexCockSize Property CockSize Auto
_SLS_ForcedDrugging Property ForceDrug Auto 
_SLS_InterfaceSlso Property Slso Auto
