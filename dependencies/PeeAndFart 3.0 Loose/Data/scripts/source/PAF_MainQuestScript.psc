Scriptname PAF_MainQuestScript extends Quest

import Utility

; Female Animations (Credit to Leito, ZAZ, Arrok)
Idle property PAF_Pee01_Start auto
Idle property PAF_Pee01 auto
Idle property PAF_Pee01_End auto
Idle property PAF_Pee02_Start auto
Idle property PAF_Pee02 auto
Idle property PAF_Pee02_End auto
Idle property PAF_Pee03_Start auto
Idle property PAF_Pee03 auto
Idle property PAF_Pee03_End auto
Idle property PAF_Pee04_Start auto
Idle property PAF_Pee04 auto
Idle property PAF_Pee04_End auto
Idle property ZAZAPC203 auto
Idle property ZAZAPC204 auto
Idle property ZAZAPC211 auto
Idle property ZAZAPC205 auto
Idle property PAF_Birthing_Full auto
Idle property PAF_Aroused01 auto
Idle property PAF_Aroused02 auto
Idle property PAF_Stripping01 auto
Idle property PAF_Stripping02 auto
Idle property PAF_Stripping03 auto
Idle property PAF_Stripping04 auto
Idle property PAF_Stripping05 auto
Idle property PAF_Stripping06 auto
Idle property PAF_Bendover01 auto
Idle property PAF_Bendover02 auto
Idle property PAF_Dancing auto
Idle property PAF_Tease auto
Idle property PAF_BottleUpPee auto
Idle property PAF_BottleUpPee02 auto
Idle property PAF_BottleUpPee03 auto
Idle property PAF_BottleUpPee04 auto
Idle property PAF_BottleUpPee05 auto
Idle property PAF_BottleUpPee06 auto
Idle property PAF_BottleUpPoop auto
Idle property PAF_BottleUpPoop02 auto
Idle property PAF_BottleUpPoop03 auto
Idle property PAF_BottleUpPoop04 auto
Idle property PAF_BottleUpPoop05 auto
Idle property PAF_BottleUpPoop06 auto
Idle property PAF_Clean auto
Idle property PAF_Pose0 auto
Idle property PAF_Pose1 auto

; male animations (Credit to Leito, ZAZ, Arrok)
Idle property PAF_Pee05_Start auto
Idle property PAF_Pee05 auto
Idle property PAF_Pee05_End auto
Idle property PAF_Pee06 auto
Idle property PAF_Pee07 auto
Idle property ZAZAPC207 auto
Idle property ZAZAPC208 auto

; gender invariant animations
Idle property ZAZAPC201 auto
Idle property ZAZAPC202 auto
Idle property ZAZAPC209 auto
Idle property ZAZAPC210 auto

; idle reset (Credit to ZAZ and XAZ)
Idle property zbfIdleForceReset auto
Idle property PAF_BladderPressure01 auto
Idle property PAF_BladderPressure02 auto

; Pee streams (Credit to ZAZ and XAZ)
Armor property ZaZAPEF2Pee01 auto
Armor property ZaZAPEF2Pee02 auto
Armor property PAF_ZaZAPEF2Pee01 auto ;gender invariant male
Armor property PAF_ZaZAPEF2Pee02 auto ;gender invariant male
Armor property PAF_ZaZAPEF2Pee01_M auto ;gender invariant female
Armor property PAF_ZaZAPEF2Pee02_M auto ;gender invariant female
Armor property PAF_DiaperArmor auto
Armor property PAF_DiaperDirtyArmor auto
ImpactDataSet property PAF_PeeImpactDataSet auto
ImpactDataSet property PAF_PeeMidImpactDataSet auto
ImpactDataSet property PAF_PeeHighImpactDataSet auto

; Spells for mod functions
Spell property PAF_Spell auto
Spell property PAF_NPCSpell auto
Spell property PAF_PeeSpell auto
Spell property PAF_PoopSpell auto
Spell property PAF_MenuSpell auto

; Debuff spells
Spell property PAF_NoBladderSpell auto
Spell property PAF_LowBladderSpell auto
Spell property PAF_MidBladderSpell auto
Spell property PAF_HighBladderSpell auto
Spell property PAF_LeakBladderSpell auto
Spell property PAF_NoBowelsSpell auto
Spell property PAF_LowBowelsSpell auto
Spell property PAF_MidBowelsSpell auto
Spell property PAF_HighBowelsSpell auto
Spell property PAF_LeakBowelsSpell auto
Spell property PAF_NoDirtSpell auto
Spell property PAF_LowDirtSpell auto
Spell property PAF_MidDirtSpell auto
Spell property PAF_HighDirtSpell auto

; Sounds
Sound property AMBWaterfallSplatterLarge auto
Sound property PAF_FartSoundMarker auto; Credit to Jonx0r
Sound property zbfSoundGagFrustrated auto; Credit to ZAZ
Sound property zbfSoundGagMale01 auto; Credit to ZAZ

; Poop Items
Potion property PAF_PoopPotion auto; Credit to Jonx0r
MiscObject property PAF_ToiletPaperMiscItem auto
Static property XMarker auto

Static property ZaZAPEPeePuddleSmall auto
Static property ZaZAPEPeePuddleLarge auto

; Bottles
MiscObject property WineBottle01AEmpty auto
MiscObject property WineBottle01BEmpty auto
MiscObject property WineBottle02AEmpty auto
MiscObject property WineBottle02BEmpty auto
MiscObject property WineSolitudeSpicedBottleEmpty auto

Form property RND_EmptyBottle01 auto
Form property RND_EmptyBottle02 auto
Form property RND_EmptyBottle03 auto

; Locations
Keyword property LocTypeInn auto
Keyword property LocTypeCastle auto
Keyword property LocTypeStore auto
Keyword property LocTypeTemple auto

Static property PAF_BottleStatic auto
Potion property PAF_PoopPotionPotion auto
Potion property PAF_PeePotionPotion auto

; Message
Message property PAF_MenuMessage auto
Message property PAF_MenuMoreMessage auto
Message property PAF_MenuKinkMessage auto
Message property PAF_ToiletMessage auto
Message property PAF_BottleMessage auto

; Dependencies
PAF_MCMQuestScript property PAF_MCMQuest auto
PAF_NPCQuestScript property PAF_NPCQuest auto
PAF_ToiletQuestScript property PAF_ToiletQuest auto
PAF_DDQuestScript property PAF_DDQuest auto

SexLabFramework property Sexlab auto

ReferenceAlias property PlayerRefAlias auto
Actor property PlayerREF auto
Actor property VictimActor auto

int property DirtState auto
int property PeeState auto
int property PoopState auto
int property DiaperState auto

float last_pee
float last_poop

PAF_MainQuestScript function GetAPI() global
	return Game.GetFormFromFile(0x000012C8, "PeeAndFart.esp") as PAF_MainQuestScript
endFunction

event OnUpdate()
	UpdateNeeds()
	RegisterForSingleUpdate(4)
endEvent

bool isRelieving
bool isAnimating
int last_animation_check
function UpdateNeeds()

	CalculateStates()
	AutoLeak()
	if (PlayerREF.IsSwimming())
		DirtState = 0
	endif

	CheckToiletUse()
	UpdateDiaper()
	ScaleBelly(PlayerREF)
	AddPeeDebuffs(PeeState)
	AddPoopDebuffs(PoopState)
	AddDirtDebuffs(DirtState)

	if (PAF_MCMQuest.PAF_GuardPenalty)
		CheckGuards()
		CheckArrest()
		CheckDiaperPenalty()
		if (!isRelieving && diaper_received_bounty)
			diaper_received_bounty = false
		endif
	endif

	if (!isAnimating)
		ApplyDirtOverlay(PlayerREF, DirtState)
	endif

endfunction



bool diaper_bounty_timer
float diaper_bounty_start
bool diaper_bounty_active
bool diaper_received_bounty
bool diaper_dialog_delayed
function CheckGuards()
	if (isRelieving)
		Actor guard = none
		int i = 0
		while (i < 10)
			if (guard == none)
				guard = Game.FindRandomActorFromRef(PlayerREF, 1500)
			endif
			bool isIllegalLocation = IsLegalLocation(PlayerREF.GetCurrentLocation())
			if (guard != none && (guard.IsGuard() || isIllegalLocation || !guard.IsDead()))
				if (guard.HasLOS(PlayerREF) && !diaper_received_bounty)
					Faction crimeFaction = guard.GetCrimeFaction()
					if (crimeFaction != none)
						crimeFaction.SetCrimeGold(crimeFaction.GetCrimeGold() + PAF_MCMQuest.PAF_CrimeValue)
						DisplayMessage("Someone saw you relieving yourself in public!")
						if (PAF_MCMQuest.PAF_DiaperPenalty)
							diaper_received_bounty = true
							diaper_bounty_active = true
						else
							diaper_received_bounty = false
							diaper_bounty_active = false
						endif
					endif
				endif
			endif
			guard = none
			i += 1
		endwhile
	endif
endFunction

bool function IsLegalLocation(Location loc)
	if (loc.HasKeyword(LocTypeCastle) || loc.HasKeyword(LocTypeInn) || loc.HasKeyword(LocTypeStore) || loc.HasKeyword(LocTypeTemple))
		return true
	endif
	return false
endFunction

function CheckArrest()
	if (diaper_bounty_active)
		Actor guard = GetPlayerDialogueTarget()
		if (guard != none)
			if (GetPlayerDialogueTarget().IsGuard())
				if (!isAnimating)
					PlayerREF.EquipItem(PAF_DiaperArmor, true, true)
					DisplayMessage("The guard forces you to wear a diaper")
					diaper_bounty_timer = true
					diaper_bounty_active = false
					diaper_bounty_start = GetCurrentGameTime()
				else
					diaper_dialog_delayed = true
					diaper_bounty_active = false
				endif
			endif
		endif
	endif
	if (diaper_dialog_delayed && !isAnimating)
		PlayerREF.EquipItem(PAF_DiaperArmor, true, true)
		DisplayMessage("The guard forced you to wear a diaper")
		diaper_bounty_timer = true
		diaper_dialog_delayed = false
		diaper_bounty_start = GetCurrentGameTime()
	endif
endFunction

function CheckDiaperPenalty()
	if (diaper_bounty_timer)
		if ((GetCurrentGameTime() - diaper_bounty_start) >= (PAF_MCMQuest.PAF_DiaperPenaltyTime / 24))
			diaper_bounty_timer = false
		endif
		if (!HasDiaper(PlayerREF))
			PlayerREF.EquipItem(PAF_DiaperArmor, true, true)
		endif
		if (!diaper_bounty_timer)
			UnequipDiaper(PlayerREF)
			DisplayMessage("You do not need to wear a diaper anymore")
		endif
	endif
endFunction

Actor function GetPlayerDialogueTarget()
	Actor target
	int i = 0
	while i < 10
		i += 1
		target = Game.FindRandomActorFromRef(PlayerREF , 1000)
		if (target != PlayerREF && target.IsInDialogueWithPlayer())
			return target
		endIf
	endWhile
    return none
endFunction

bool function PlayerReady()
	return !(PlayerREF.IsInCombat() || PlayerREF.GetSitState() != 0 || PlayerREF.GetSleepState() != 0 || PlayerREF.IsOnMount() || PlayerREF.IsSneaking() || PlayerREF.IsSwimming())
endFunction

bool function ReadyToAnimate(Actor a_actor)
	return PlayerReady() && SexLab.ValidateActor(a_actor) == 1 && !isAnimating && !IsInMenuMode()
endFunction

function UpdateDiaper()
	if (!HasDiaper(PlayerREF))
		ScaleButt(PlayerREF, 1.0)
		DiaperState = 0
	else
		if (DiaperState == 1 && !HasDiaper(PlayerREF, true) && !isAnimating)
			DisplayMessage("Your diaper begins to reek...")
			PlayerREF.UnequipItem(PAF_DiaperArmor, false, true)
			PlayerREF.RemoveItem(PAF_DiaperArmor, 1, absilent = true)
			if (diaper_bounty_timer)
				PlayerRef.EquipItem(PAF_DiaperDirtyArmor, true, true)
			else
				PlayerRef.EquipItem(PAF_DiaperDirtyArmor, false, true)
			endif
			DiaperState = 0
		endif
	endif
endFunction

function CheckToiletUse()
	if (PlayerREF.GetSitState() != 3)
		_toilet_state = 0
	endif

	if ((PeeState >= 1 || PoopState >= 1) && _toilet_state != 0 && !isAnimating)
		UseToilet()
	endif
endFunction

function AutoLeak()

	if ((PeeState > 3 || PoopState > 3) && !isAnimating && ReadyToAnimate(PlayerREF))
		if (last_animation_check <= 10)
			last_animation_check += 1
		else
			last_animation_check = 0
		endif
		if (last_animation_check == 1)
			if (PeeState > 3 && PoopState > 3)
				DisplayMessage("You have to relieve yourself urgently!")
			elseif (PeeState > 3)
				DisplayMessage("You have to pee urgently!")
			elseif (PoopState > 3)
				DisplayMessage("You have to poop urgently!")
			endif
			if (!PAF_DDQuest.HasArmbinder(PlayerREF) && PAF_MCMQuest.PAF_PressureAnimation && !isAnimating)
				ApplyFacialExpressions(PlayerREF, 9)
				isAnimating = true
				Game.DisablePlayerControls(true, true, false, false, true, true, false)				
				PlayerREF.PlayIdle(PAF_Aroused01)				
				Wait(6)
				Game.EnablePlayerControls()
				PlayerREF.PlayIdle(zbfIdleForceReset)
				isAnimating = false
				ClearFacialExpressions(PlayerREF)
			endif
		elseif (last_animation_check == 10 && ReadyToAnimate(PlayerREF) && !isAnimating)
			isAnimating = true
			if (!PAF_MCMQuest.PAF_AutoLeak)
				last_animation_check = 0
			elseif (PeeState > 3 && PoopState > 3)
				LeakAndPoop()
			elseif (PeeState > 3)
				Leak()
			elseif (PoopState > 3)
				PoopPanty()
			endif
			isAnimating = false
			CalculateStates()
			last_animation_check = 0
		endif
	else
		last_animation_check = 0
	endif
endFunction

event OnKeyUp(Int KeyCode, Float HoldTime)
	if (IsInMenuMode())
		return
	endif
	UnregisterForKey(KeyCode)
	Actor target = Game.GetCurrentCrosshairRef() as Actor
	if (KeyCode == PAF_MCMQuest.PAF_InfoKey)
		DisplayNeeds(target)
	elseif (KeyCode == PAF_MCMQuest.PAF_ActionKey)
		if (PlayerReady())
			if (HoldTime > 1.0 && !PAF_MCMQuest.PAF_Disable_Fart)
				PoopSensual()
			else
				Pee()
			endif
		endif
	elseif (KeyCode == PAF_MCMQuest.PAF_MenuKey)
		int result = PAF_MenuMessage.Show()
		if (result == 0)
			if (PAF_NPCQuest.PeeAsync(target) == -1)
				Pee()
			endif
		elseif (result == 1)
			if (PAF_NPCQuest.PeeAsync(target, true) == -1)
				Pee(true)
			endif
		elseif (result == 2)
			if (PAF_NPCQuest.PoopAsync(target) == -1)
				PoopSensual()
			endif
		elseif (result == 3)
			int result_more = PAF_MenuMoreMessage.Show()
			if (result_more == 0)
				int result_bottle = PAF_BottleMessage.Show()
				if (result_bottle == 0)
					PeeInBottle(PlayerREF)
				elseif (result_bottle == 1)
					PoopInBottle(PlayerREF)
				endif
			elseif (result_more == 1)
				UseToiletPaper(animate = true)
			elseif (result_more == 2)
				ObjectReference ref = Game.GetCurrentCrosshairRef()
				if (ref != none)
					PAF_ToiletQuest.PlaceToilet(ref)
				else
					int result_toilet = PAF_ToiletMessage.Show()
					if (result_toilet == 0)
						PAF_ToiletQuest.PlaceToilet(ref, true)
					elseif (result_toilet == 1)
						PAF_ToiletQuest.PlaceToilet(ref)
					endif
				endif
			elseif (result_more == 3)
				Actor ref = Game.GetCurrentCrosshairRef() as Actor
				if (ref != none)
					PAF_NPCQuest.AddActor(ref)
				else
					DisplayMessage("There was no valid actor in your sight")
				endif
			elseif (result_more == 4)
				Actor ref = Game.GetCurrentCrosshairRef() as Actor
				if (ref != none)
					VictimActor = ref
					DisplayMessage("NPC toilet set")
				else
					DisplayMessage("There was no valid actor in your sight")
				endif
			elseif (result_more == 5)
				int result_kink = PAF_MenuKinkMessage.Show()
				if (result_kink == 0)
					Masturbate()
				elseif (result_kink == 1)
					PeeInMouth()
				elseif (result_kink == 2)
					PeeInMouthPlayer()
				elseif (result_kink == 3)
					PoopInMouth()
				elseif (result_kink == 4)
					PoopInMouthPlayer()
				endif
			endif
		endif
	endif
	RegisterForKey(KeyCode)
endEvent

; ############ Pee and Fart ##############
int function Pee(bool peeOnly = false)
	if (PAF_MCMQuest.PAF_Disable_Pee)
		return -1
	endif
	if (PeeState > 0 && ReadyToAnimate(PlayerREF))
		if (PAF_DDQuest.HasArmbinder(PlayerREF))
			DisplayMessage("Your arms are locked. You have no means to undress yourself")
			return -1
		endif
		if (ReadyToAnimate(PlayerREF) && !isAnimating)
			isAnimating = true
			last_pee = GetCurrentGameTime()
			Game.DisablePlayerControls(true, true, false, false, true, true, false)
			Form[] equipment = StripActor(PlayerRef)
			int result = -1
			if (SexLab.GetGender(PlayerREF) == 0)
				result = PeeMale(peeOnly)
			else
				result = PeeFemale(peeOnly)
			endif
			if (result == 0)
				UseToiletPaper(animate = true)
			endif
			ClearFacialExpressions(PlayerREF)
			UnstripActor(PlayerREF, equipment)
			Game.EnablePlayerControls()
			isAnimating = false
			isRelieving = false
			return 0
		else
			DisplayMessage("You are not ready to do that now")
			return -1
		endif
	else
		DisplayMessage("You do not have to pee")
		return -1
	endif
	return -1
endfunction

int function PeeFemale(bool peeOnly = false)
	int style = GetRandomAnimation(PAF_MCMQuest.PAF_Animation_F)
	PlayPeeIdleStart(PlayerREF, style, true)
	ApplyFacialExpressions(PlayerREF, 10)
	Wait(5)
	if (style == 0)
		EquipTinke(PlayerREF, true)
	else
		EquipTinke(PlayerREF)
	endif
	StartPeeSound(PlayerREF)
	if (HasDiaper(PlayerREF))
		DisplayMessage("You pee in your diaper")
	else
		isRelieving = true
	endif
	Wait(2)
	PlacePeePuddle(PlayerREF, style, true)
	Wait(5)
	int result = -1
	if (!peeOnly)
		result = poop()
	endif
	ApplyFacialExpressions(PlayerREF, 10)
	Wait(5)
	if (style == 0)
		UnequipTinke(PlayerREF, true)
	else
		UnequipTinke(PlayerREF)
	endif
	UnequipTinke(PlayerREF)
	StopPeeSound()
	Wait(1.5)
	PlayPeeIdleStop(PlayerREF, style, true)
	ClearFacialExpressions(PlayerREF)
	DisplayMessage("You feel relieved")
	return result
endfunction

int function PeeMale(bool peeOnly = false)
	int style = GetRandomAnimation(PAF_MCMQuest.PAF_Animation_M)
	PlayPeeIdleStart(PlayerREF, style, false)
	PlayerREF.AddToFaction(SexLab.AnimatingFaction)
	Debug.SendAnimationEvent(Playerref, "SOSFastErect")
	Wait(5)
	EquipTinke(PlayerREF)
	StartPeeSound(PlayerREF)
	if (HasDiaper(PlayerREF))
		DisplayMessage("You pee in your diaper")
	else
		isRelieving = true
	endif
	Wait(2)
	PlacePeePuddle(PlayerREF, style, false)
	Wait(5)
	int result = -1
	if (!peeOnly)
		result = poop()
	endif
	ApplyFacialExpressions(PlayerREF, 10)
	Wait(5)
	UnequipTinke(PlayerREF)
	StopPeeSound()
	Wait(1.5)
	PlayPeeIdleStop(PlayerREF, style, false)
	ClearFacialExpressions(PlayerREF)
	DisplayMessage("You feel relieved")
	Debug.SendAnimationEvent(Playerref, "SOSFlaccid")
	PlayerREF.RemoveFromFaction(SexLab.AnimatingFaction)
	return result
endfunction

int function PoopSensual()
	if (PAF_MCMQuest.PAF_Disable_Fart)
		return -1
	endif
	int result = -1
	if (SexLab.GetGender(PlayerREF) == 0)
		result = PoopAnimatedMale()
	else
		result = PoopAnimatedFemale()
	endif
	return result
endFunction

int function PoopAnimatedFemale()
	int style = GetRandomAnimation(PAF_MCMQuest.PAF_AnimationPoop_F)
	if (PoopState > 0 && !PAF_MCMQuest.PAF_Disable_Fart)
		if (PAF_DDQuest.HasArmbinder(PlayerREF))
			DisplayMessage("Your armbinder prevents you from stripping your clothing")
			return PoopPanty()
		endif
		if (ReadyToAnimate(PlayerREF) && !isAnimating)
			isAnimating = true
			Game.DisablePlayerControls(true, true, false, false, true, true, false)
			Form[] equipment = StripActor(PlayerREF)
			Wait(3)
			PlayPeeIdleStart(PlayerREF, style, true)
			Wait(5)
			int result = Poop()
			Wait(5)
			PlayPeeIdleStop(PlayerREF, style, true)
			PlayerREF.PlayIdle(zbfIdleForceReset)
			if (result == 0)
				UseToiletPaper(animate = true)
			endif
			UnstripActor(PlayerREF, equipment)
			Game.EnablePlayerControls()
			isAnimating = false
			isRelieving = false
			return 0
		else
			return -1
		endif
	else
		DisplayMessage("You do not have to poop")
	endif
	return -1
endfunction

int function PoopAnimatedMale()
	int style = GetRandomAnimation(PAF_MCMQuest.PAF_AnimationPoop_M)
	if (PoopState > 0 && !PAF_MCMQuest.PAF_Disable_Fart)
		if (PAF_DDQuest.HasArmbinder(PlayerREF))
			DisplayMessage("Your armbinder prevents you from stripping your clothing")
			return PoopPanty()
		endif
		if (ReadyToAnimate(PlayerREF) && !isAnimating)
			isAnimating = true
			Game.DisablePlayerControls(true, true, false, false, true, true, false)
			Form[] equipment = StripActor(PlayerREF)
			Wait(3)
			PlayPeeIdleStart(PlayerREF, style, false)
			Wait(5)
			int result = Poop()
			Wait(5)
			PlayPeeIdleStop(PlayerREF, style, false)
			if (result == 0)
				UseToiletPaper(animate = true)
			endif
			UnstripActor(PlayerREF, equipment)
			Game.EnablePlayerControls()
			isAnimating = false
			isRelieving = false
			return 0
		else
			return -1
		endif
	else
		DisplayMessage("You do not have to poop")
	endif
	return -1
endfunction

int function Poop(bool dirty = false, bool bottle = false)
	if (PoopState > 0 && !PAF_MCMQuest.PAF_Disable_Fart)
		if (PAF_DDQuest.IsAnalPlugged(PlayerREF))
			DisplayMessage("An anal plug prevents you from pooping")
			return -1
		endif
		if (PAF_DDQuest.HasDeviousBelt(PlayerREF))
			DisplayMessage("An devious mechanism prevents you from pooping")
			return -1
		endif
		if (HasDiaper(PlayerREF))
			DisplayMessage("You poop in your diaper")
		endif
		int i = 0
		int len = 4
		ApplyFacialExpressions(PlayerREF, 14)
		while i < len
			if (_toilet_state != 2 && !HasDiaper(PlayerREF))
				if (!bottle)
					ObjectReference poop = PlayerRef.PlaceAtme(PAF_PoopPotion)
					poop.moveToNode(Playerref, "SkirtBBone02")
					poop.SetActorOwner(PlayerREF.GetActorBase())
					if (_toilet_state == 0)
						isRelieving = true
					endif
				endif
			else
				if (HasDiaper(PlayerREF))
					ScaleButtStage(PlayerREF, i)
				endif
			endif
			ApplyFacialExpressions(PlayerREF, 12)
			PlayPoopSound(PlayerREF)
			if (!dirty)
				if (i == 0)
					IncreaseDirtState(PlayerREF, false, true)
				endif
			else
				if (i < 3)
					IncreaseDirtState(PlayerREF, false, true)
				endif
			endif
			ApplyFacialExpressions(PlayerREF, 14)
			Utility.Wait(Utility.RandomInt(2, 3))
			i += 1
		endWhile
		ClearFacialExpressions(PlayerREF)
		last_poop = GetCurrentGameTime()
		CalculateStates()
		ScaleBelly(PlayerREF)
		if (HasDiaper(PlayerREF) && DiaperState == 0)
			DiaperState = 1
		endif
		return 0
	endif
	return -1
endfunction

int function Leak()
	if (HasDiaper(PlayerREF))
		DisplayMessage("You pee in your diaper")
	else
		DisplayMessage("You are wetting yourself")
		isRelieving = true
	endif
	bool animate = PAF_MCMQuest.PAF_LeakAnimation
	if (animate)
		isAnimating = true
		ApplyFacialExpressions(PlayerREF, 9)
		Game.DisablePlayerControls(true, true, false, false, true, true, false)
		PlayerREF.PlayIdle(PAF_Aroused01)
	endif
	ApplyFacialExpressions(PlayerREF, 12)
	EquipTinke(PlayerREF, leak = true)
	StartPeeSound(PlayerREF)
	Wait(2)
	PlacePuddle(PlayerREF, 0, 0, 1)
	CheckGuards()
	Wait(5)
	PlacePuddle(PlayerREF, 0, 0, 1)
	Wait(10)
	PlacePuddle(PlayerREF, 0, 0, 1)
	UnequipTinke(PlayerREF, leak = true)
	StopPeeSound()
	if (animate)
		Game.EnablePlayerControls()
		PlayerREF.PlayIdle(zbfIdleForceReset)
		isAnimating = false
	endif
	isRelieving = false
	last_pee = GetCurrentGameTime()
	ApplyDirtOverlay(PlayerREF, DirtState)
	ClearFacialExpressions(PlayerREF)
	return 0
endfunction

int function PoopPanty()
	bool animate = PAF_MCMQuest.PAF_LeakAnimation
	if (animate)
		isAnimating = true
		ApplyFacialExpressions(PlayerREF, 9)
		Game.DisablePlayerControls(true, true, false, false, true, true, false)
		PlayerREF.PlayIdle(PAF_Aroused01)
	endif
	if (poop(dirty = true) == 0)
		CheckGuards()
		DisplayMessage("You had to release your bowels")
		ApplyDirtOverlay(PlayerREF, DirtState)
		if (animate)
			Game.EnablePlayerControls()
			PlayerREF.PlayIdle(zbfIdleForceReset)
			isAnimating = false
		endif
		isRelieving = false
		return 0
	endif
	if (animate)
		Game.EnablePlayerControls()
		PlayerREF.PlayIdle(zbfIdleForceReset)
		isAnimating = false
	endif
	return -1
endfunction

int function LeakAndPoop()
	if (HasDiaper(PlayerREF))
		DisplayMessage("You pee in your diaper")
	else
		DisplayMessage("You are wetting yourself")
		isRelieving = true
	endif
	bool animate = PAF_MCMQuest.PAF_LeakAnimation
	if (animate)
		isAnimating = true
		ApplyFacialExpressions(PlayerREF, 9)
		Game.DisablePlayerControls(true, true, false, false, true, true, false)
		PlayerREF.PlayIdle(PAF_Aroused01)
	endif
	ApplyFacialExpressions(PlayerREF, 12)
	EquipTinke(PlayerREF, leak = true)
	StartPeeSound(PlayerREF)
	Wait(2)
	PlacePuddle(PlayerREF, 0, 0, 1)
	Wait(2)
	if (poop(dirty = true) == 0)
		DisplayMessage("You had to release your bowels")
	endif
	CheckGuards()
	PlacePuddle(PlayerREF, 0, 0, 1)
	Wait(5)
	PlacePuddle(PlayerREF, 0, 0, 1)
	Wait(5)
	UnequipTinke(PlayerREF, leak = true)
	StopPeeSound()
	ApplyDirtOverlay(PlayerREF, DirtState)
	ClearFacialExpressions(PlayerREF)
	last_pee = GetCurrentGameTime()
	if (animate)
		Game.EnablePlayerControls()
		PlayerREF.PlayIdle(zbfIdleForceReset)
		isAnimating = false
	endif
	isRelieving = false
	return 0
endfunction

function PeeVirtual()
	last_pee = GetCurrentGameTime()
	UseToiletPaper()
endFunction

function PoopVirtual()
	last_poop = GetCurrentGameTime()
	UseToiletPaper()
endFunction

; ################# Toilet Use ##############

int _toilet_state
int function GetToiletState()
	return _toilet_state
endFunction

function SetToiletState(int a_state)
	_toilet_state = a_state
endfunction

function UseToilet()
	bool pee = PeeState > 0
	bool poop = PoopState > 0 && !PAF_MCMQuest.PAF_Disable_Fart
	Form[] equipment
	if (HasDiaper(PlayerREF))
		DisplayMessage("As long as you are weaing a diaper, there is not need for a toilet")
		return
	endif
	isAnimating = true
	Game.DisablePlayerControls(true, true, false, false, true, true, false)
	if (pee || poop)
		equipment = StripActor(PlayerREF, false)
	endif
	if (pee)
		EquipTinke(PlayerREF)
		StartPeeSound(PlayerREF)
		PlacePuddle(PlayerREF, 0, 0, 3)
		Wait(10)
	endif
	if (PAF_DDQuest.IsAnalPlugged(PlayerREF))
		DisplayMessage("An anal plug prevents you from pooping")
		poop = false
	endif
	if (PAF_DDQuest.HasDeviousBelt(PlayerREF))
		DisplayMessage("A devious mechanism prevents you from pooping")
		poop = false
	endif
	int result = -1
	if (poop)
		result = poop()
	endif
	if (pee)
		UnequipTinke(PlayerREF)
		StopPeeSound()
		last_pee = Utility.GetCurrentGameTime()
	endif
	if (result == 0)
		UseToiletPaper(PlayerREF)
	endif
	if (pee || poop)
		UnstripActor(PlayerREF, equipment)
		DisplayMessage("You have relieved yourself")
	endif
	Game.EnablePlayerControls()
	isAnimating = false
endfunction

; #################### Dirt #################

function UseToiletPaper(bool isPeeing = false, bool animate = false)
	if (HasDiaper(playerREF))
		DisplayMessage("You are weaing a diaper. No way to clean yourself")
		return
	endif
	if (PAF_DDQuest.HasArmbinder(PlayerREF))
		DisplayMessage("Your arms are locked. You are not able to clean yourself")
		return
	endif
	if (HasToiletPaper(PlayerREF))
		RemoveToiletPaper(PlayerREF)
		DirtState = 0
		if (animate && PAF_MCMQuest.PAF_PlayCleanAnimation)
			isAnimating = true
			Wait(1)
			PlayerREF.PlayIdle(PAF_Clean)
			Wait(5)
			isAnimating = false
		endif
		Bathe(PlayerREF)
		DisplayMessage("You cleaned yourself with some toilet paper")
	else
		DisplayMessage("You have no toilet paper to wipe yourself clean")
	endif
endfunction

bool function HasToiletPaper(Actor a_actor)
	return a_actor.GetItemCount(PAF_ToiletPaperMiscItem) > 0
endfunction

bool function RemoveToiletPaper(Actor a_actor)
	a_actor.RemoveItem(PAF_ToiletPaperMiscItem, 1, true)
endFunction

function ApplyDirtOverlay(Actor a_actor, int a_dirt_state)
	if (PAF_MCMQuest.PAF_Dirt)
		bool syncOverlay = RemoveInvalidOverlay(a_actor, a_dirt_state)
		if (a_dirt_state == 1 && !HasTattooApplied(a_actor, "Dirt 1"))
			SlaveTats.simple_add_tattoo(a_actor, "PAF", "Dirt 1", last = false)
			syncOverlay = true
		elseif(a_dirt_state == 2 && !HasTattooApplied(a_actor, "Dirt 2"))
			SlaveTats.simple_add_tattoo(a_actor, "PAF", "Dirt 2", last = false)
			syncOverlay = true
		elseif(a_dirt_state == 3 && !HasTattooApplied(a_actor, "Dirt 3"))
			SlaveTats.simple_add_tattoo(a_actor, "PAF", "Dirt 3", last = false)
			syncOverlay = true
		endif
		if (syncOverlay)
			bool controls_locked = !Game.IsMovementControlsEnabled() && a_actor == PlayerREF
			SlaveTats.synchronize_tattoos(a_actor, silent = true)
			if (controls_locked)
				Game.DisablePlayerControls(true, true, false, false, true, true, false)
			endif
		endif
	endif
endfunction

bool function RemoveInvalidOverlay(Actor a_actor, int a_dirt_state, bool last = false)
	bool removedOverlay = false
	if (HasTattooApplied(a_actor, "Dirt 1") && a_dirt_state != 1)
		SlaveTats.simple_remove_tattoo(a_actor, "PAF", "Dirt 1", last)
		removedOverlay = true
	endif
	if (HasTattooApplied(a_actor, "Dirt 2") && a_dirt_state != 2)
		SlaveTats.simple_remove_tattoo(a_actor, "PAF", "Dirt 2", last)
		removedOverlay = true
	endif
	if (HasTattooApplied(a_actor, "Dirt 3") && a_dirt_state != 3)
		SlaveTats.simple_remove_tattoo(a_actor, "PAF", "Dirt 3", last)
		removedOverlay = true
	endif
	return removedOverlay
endfunction

bool function HasTattooApplied(Actor a_actor, string dirtLevel)
	bool dirt_applied = false
	int template = JValue.addToPool(JMap.object(), "PAF_Tattoo_JMAP")
	int matches = JValue.addToPool(JArray.object(), "PAF_Tattoo_JMAP")
	JMap.setStr(template, "section", "PAF")
	JMap.setStr(template, "name", dirtLevel)
	JArray.clear(matches)
	if (SlaveTats.query_applied_tattoos(a_actor, template, matches))
		JValue.cleanPool("PAF_Tattoo_JMAP")
		return false
	endif
	if JArray.count(matches) > 0
		JValue.cleanPool("PAF_Tattoo_JMAP")
		dirt_applied = true
	endif
	JValue.cleanPool("PAF_Tattoo_JMAP")
	return dirt_applied
endfunction

function IncreaseDirtState(Actor a_actor, bool isPeeing = false, bool syncDirt)
	if (!PAF_MCMQuest.PAF_PeeToiletPaper && isPeeing)
		return
	endif
	if (a_actor == PlayerREF)
		DirtState = MinInt(DirtState + 1, 3)
		if (syncDirt)
			ApplyDirtOverlay(a_actor, DirtState)
		endif
	else
		int i = PAF_NPCQuest.IsTrackedActor(a_actor)
		if (i != -1)
			PAF_NPCQuest.NPC_DirtState[i] = MinInt(PAF_NPCQuest.NPC_DirtState[i] + 1, 3)
			if (syncDirt)
				ApplyDirtOverlay(a_actor, PAF_NPCQuest.NPC_DirtState[i])
			endif
		endif
	endif
endFunction

function Bathe(Actor a_actor)
	if (a_actor == PlayerREF)
		DirtState = 0
		ApplyDirtOverlay(a_actor, 0)
	else
		int i = PAF_NPCQuest.IsTrackedActor(a_actor)
		if (i != -1)
			PAF_NPCQuest.NPC_DirtState[i] = 0
			ApplyDirtOverlay(a_actor, 0)
		endif
	endif
endfunction

; ######################### Alchemy/Eat/Drink ##########################

function CalculateStates()
	if (PAF_MCMQuest.PAF_DiablePlayerNeeds || (PAF_MCMQuest.PAF_Disable_Pee && PAF_MCMQuest.PAF_Disable_Fart))
		PoopState = 0
		PeeState = 0
		return
	endif

	float currentTime = GetCurrentGameTime()
	int hoursPassedPee = Math.Floor((currentTime - last_pee) * 24)
	int hoursPassedPoop = Math.Floor((currentTime - last_poop) * 24)

	if (PAF_MCMQuest.PAF_Disable_Fart)
		PoopState = 0
	else
		PoopState = Math.Floor(hoursPassedPoop / PAF_MCMQuest.PAF_PoopRate)
	endif
	if (PAF_MCMQuest.PAF_Disable_Pee)
		PeeState = 0
	else
		PeeState = Math.Floor(hoursPassedPee / PAF_MCMQuest.PAF_PeeRate)
	endif

endFunction

function IncreaseBladderState()
	last_pee = last_pee - ((PAF_MCMQuest.PAF_PeeRate as float) / 24.0)
	CalculateStates()
endFunction

function IncreaseBowelsState()
	last_poop = last_poop - ((PAF_MCMQuest.PAF_PoopRate as float) / 24.0)
	CalculateStates()
endfunction

Form function GetEmptyBottle(Actor a_actor)
	if (a_actor.GetItemCount(WineBottle01AEmpty) > 0)
		return WineBottle01AEmpty
	elseif (a_actor.GetItemCount(WineBottle01BEmpty) > 0)
		return WineBottle01BEmpty
	elseif (a_actor.GetItemCount(WineBottle02AEmpty) > 0)
		return WineBottle02AEmpty
	elseif (a_actor.GetItemCount(WineBottle02BEmpty) > 0)
		return WineBottle02BEmpty
	elseif (a_actor.GetItemCount(WineSolitudeSpicedBottleEmpty) > 0)
		return WineSolitudeSpicedBottleEmpty
	elseif (RND_EmptyBottle01 != none && a_actor.GetItemCount(RND_EmptyBottle01) > 0)
		return WineSolitudeSpicedBottleEmpty
	elseif (RND_EmptyBottle02 != none && a_actor.GetItemCount(RND_EmptyBottle02) > 0)
		return WineSolitudeSpicedBottleEmpty
	elseif (RND_EmptyBottle03 != none && a_actor.GetItemCount(RND_EmptyBottle03) > 0)
		return WineSolitudeSpicedBottleEmpty
	endif
	return none
endFunction

function RemoveEmptyBottle(Actor a_actor, Form a_bottle)
	a_actor.RemoveItem(a_bottle, 1, true)
endFunction

ObjectReference targetBottle
function PeeInBottle(Actor a_actor)
	Form bottle = GetEmptyBottle(a_actor)
	if (bottle != none)
		if (PeeState == 0)
			DisplayMessage("You do not have to pee")
			return
		endif
		if (HasDiaper(a_actor))
			DisplayMessage("As long as you are weaing a diaper you cannot pee into bottles")
			return
		endif
		Game.DisablePlayerControls(true, true, false, false, true, true, false)
		isAnimating = true
		Form[] equipment = StripActor(a_actor, false)
		RemoveEmptyBottle(a_actor, bottle)
		if (SexLab.GetGender(a_actor) == 0)
			Debug.SendAnimationEvent(a_actor, "SOSFastErect")
			a_actor.AddToFaction(SexLab.AnimatingFaction)
			a_actor.PlayIdle(PAF_Pee05_Start)
			Wait(3)
			PlaceBottle(a_actor, 75, 20)
			EquipTinke(a_actor)
			StartPeeSound(a_actor)
			Wait(15)
			UnequipTinke(a_actor)
			StopPeeSound()
			a_actor.PlayIdle(PAF_Pee05_End)
			a_actor.RemoveFromFaction(SexLab.AnimatingFaction)
			Debug.SendAnimationEvent(a_actor, "SOSFlaccid")
			targetBottle.Disable()
			targetBottle.Delete()
		else
			a_actor.playIdle(PAF_BottleUpPee)
			Wait(6)
			EquipTinke(a_actor)
			StartPeeSound(a_actor)
			a_actor.playIdle(PAF_BottleUpPee03)
			Wait(6)
			a_actor.playIdle(PAF_BottleUpPee04)
			Wait(6)
			a_actor.playIdle(PAF_BottleUpPee05)
			UnequipTinke(a_actor)
			StopPeeSound()
			Wait(6)
			a_actor.playIdle(PAF_BottleUpPee06)
		endif
		UnstripActor(a_actor, equipment)
		last_pee = GetCurrentGameTime()
		a_actor.AddItem(PAF_PeePotionPotion, 1)
		isAnimating = false
		Game.EnablePlayerControls()
	else
		DisplayMessage("You do not have any empty bottle")
	endif
endFunction

function PoopInBottle(Actor a_actor)
	Form bottle = GetEmptyBottle(a_actor)
	if (bottle != none)
		if (PoopState == 0)
			DisplayMessage("You do not have to poop")
			return
		endif
		if (HasDiaper(a_actor))
			DisplayMessage("As long as you are weaing a diaper you cannot poop into bottles")
			return
		endif
		if (PAF_DDQuest.IsAnalPlugged(a_actor))
			DisplayMessage("An anal plug prevents you from pooping")
			return
		endif
		if (PAF_DDQuest.HasDeviousBelt(a_actor))
			DisplayMessage("A devious mechanism prevents you from pooping")
			return
		endif
		isAnimating = true
		Form[] equipment = StripActor(a_actor, false)
		Game.DisablePlayerControls(true, true, false, false, true, true, false)
		RemoveEmptyBottle(a_actor, bottle)
		a_actor.playIdle(PAF_BottleUpPoop)
		Wait(6)
		a_actor.playIdle(PAF_BottleUpPoop02)
		Wait(6)
		a_actor.playIdle(PAF_BottleUpPoop03)
		Wait(6)
		a_actor.playIdle(PAF_BottleUpPoop04)
		poop(false, true)
		a_actor.playIdle(PAF_BottleUpPoop05)
		Wait(6)
		a_actor.playIdle(PAF_BottleUpPoop06)
		a_actor.AddItem(PAF_PoopPotionPotion, 1)
		UnstripActor(a_actor, equipment)
		Game.EnablePlayerControls()
		isAnimating = false
		UseToiletPaper(a_actor)
	else
		DisplayMessage("You do not have any empty bottle")
	endif
endFunction

function PlaceBottle(Actor a_actor, float dist, float angle_offset)
	float z_actor = a_actor.GetAngleZ() + angle_offset
	float x_pos = a_actor.GetPositionX() + Math.Sin(z_actor) * dist
	float y_pos = a_actor.GetPositionY() + Math.Cos(z_actor) * dist
	targetBottle = a_actor.PlaceAtMe(PAF_BottleStatic)
	targetBottle.SetAngle(0, 0, 0)
	targetBottle.SetPosition(x_pos, y_pos, a_actor.GetPositionZ())
endfunction

; ######################### Restraints ###########################

bool function HasDiaper(Actor a_actor, bool isDirty = false)
	if (isDirty)
		return a_actor.GetWornForm(0x00400000) as Armor == PAF_DiaperDirtyArmor
	endif
	if (a_actor.GetWornForm(0x00400000) as Armor == PAF_DiaperArmor || a_actor.GetWornForm(0x00400000) as Armor == PAF_DiaperDirtyArmor)
		return true
	else
		return false
	endif
endFunction

function UnequipDiaper(Actor a_actor)
	if (HasDiaper(a_actor, true))
		a_actor.UnequipItem(PAF_DiaperDirtyArmor, abPreventEquip = true)
	elseif (HasDiaper(a_actor))
		a_actor.UnequipItem(PAF_DiaperArmor, abPreventEquip = true)
	endif
endfunction

; ######################### Utility ######################

int function PlayPeeIdleStart(Actor a_actor, int style, bool female)
	if (female)
		if (style == 0)
			a_actor.PlayIdle(PAF_Pee01_Start)
		elseif (style == 1)
			a_actor.PlayIdle(PAF_Pee02_Start)
		elseif (style == 2)
			a_actor.PlayIdle(PAF_Pee03_Start)
		elseif (style == 3)
			a_actor.PlayIdle(PAF_Pee04_Start)
		elseif (style == 4)
			a_actor.PlayIdle(ZAZAPC201)
		elseif (style == 5)
			a_actor.PlayIdle(ZAZAPC202)
		elseif (style == 6)
			a_actor.PlayIdle(ZAZAPC203)
		elseif (style == 7)
			a_actor.PlayIdle(ZAZAPC204)
		elseif (style == 8)
			a_actor.PlayIdle(ZAZAPC209)
		elseif (style == 9)
			a_actor.PlayIdle(PAF_Pose0)
		elseif (style == 10)
			a_actor.PlayIdle(ZAZAPC205)
		elseif (style == 11)
			a_actor.PlayIdle(PAF_Pose1)
		elseif (style == 12)
			a_actor.PlayIdle(PAF_Bendover01)
		endif
	else
		if (style == 0)
			a_actor.PlayIdle(PAF_Pee05_Start)
		elseif (style == 1)
			a_actor.PlayIdle(PAF_Pee06)
		elseif (style == 2)
			a_actor.PlayIdle(PAF_Pee07)
		elseif (style == 3)
			a_actor.PlayIdle(PAF_Pee04_Start)
		elseif (style == 4)
			a_actor.PlayIdle(ZAZAPC207)
		elseif (style == 5)
			a_actor.PlayIdle(ZAZAPC208)
		elseif (style == 6)
			a_actor.PlayIdle(ZAZAPC209)
		elseif (style == 7)
			a_actor.PlayIdle(ZAZAPC210)
		elseif (style == 8)
			a_actor.PlayIdle(PAF_Pose0)
		elseif (style == 9)
			a_actor.PlayIdle(ZAZAPC211)
		elseif (style == 10)
			a_actor.PlayIdle(PAF_Pose1)
		elseif (style == 11)
			a_actor.PlayIdle(PAF_Bendover01)
		endif
	endif
endFunction

function PlacePeePuddle(Actor a_actor, int style, bool female)
	if (female)
		if (style == 0)
			PlacePuddle(a_actor, 65, 0, 3)
		elseif (style == 1)
			PlacePuddle(a_actor, 0, 0, 3)
		elseif (style == 2)
			PlacePuddle(a_actor, 0, 0, 3)
		elseif (style == 3)
			PlacePuddle(a_actor, 0, 0, 3)
		elseif (style == 4)
			PlacePuddle(a_actor, 10, 0, 3)
		elseif (style == 5)
			PlacePuddle(a_actor, 15, 0, 3)
		elseif (style == 6)
			PlacePuddle(a_actor, 10, 0, 3)
		elseif (style == 7)
			PlacePuddle(a_actor, 10, 0, 3)
		elseif (style == 8)
			PlacePuddle(a_actor, -15, 0, 3)
		elseif (style == 9)
			PlacePuddle(a_actor, -45, 0, 3)
		elseif (style == 10)
			PlacePuddle(a_actor, -25, 0, 3)
		elseif (style == 11)
			PlacePuddle(a_actor, 25, 0, 3)
		elseif (style == 12)
			PlacePuddle(a_actor, -75, 0, 3)
		endif
	else
		if (style == 0)
			PlacePuddle(a_actor, 85, 20, 3)
		elseif (style == 1)
			PlacePuddle(a_actor, 85, 0, 3)
		elseif (style == 2)
			PlacePuddle(a_actor, 80, 0, 3)
		elseif (style == 3)
			PlacePuddle(a_actor, 60, 0, 3)
		elseif (style == 4)
			PlacePuddle(a_actor, 70, 0, 3)
		elseif (style == 5)
			PlacePuddle(a_actor, 70, 0, 3)
		elseif (style == 6)
			PlacePuddle(a_actor, 65, 0, 3)
		elseif (style == 7)
			PlacePuddle(a_actor, 60, 0, 3)
		elseif (style == 8)
			PlacePuddle(a_actor, -10, -40, 3)
		elseif (style == 9)
			PlacePuddle(a_actor, 30, 30, 3)
		elseif (style == 10)
			PlacePuddle(a_actor, 25, 30, 3)
		elseif (style == 11)
			PlacePuddle(a_actor, -10, 30, 3)
		endif
	endif
endFunction

function PlayPeeIdleStop(Actor a_actor, int style, bool female)
	if (female)
		if (style == 0)
			a_actor.PlayIdle(PAF_Pee01_End)
		elseif (style == 1)
			a_actor.PlayIdle(PAF_Pee02_End)
		elseif (style == 2)
			a_actor.PlayIdle(PAF_Pee03_End)
		elseif (style == 3)
			a_actor.PlayIdle(PAF_Pee04_End)
		elseif (style == 4)
			a_actor.PlayIdle(zbfIdleForceReset)
		elseif (style == 5)
			a_actor.PlayIdle(zbfIdleForceReset)
		elseif (style == 6)
			a_actor.PlayIdle(zbfIdleForceReset)
		elseif (style == 7)
			a_actor.PlayIdle(zbfIdleForceReset)
		elseif (style == 8)
			a_actor.PlayIdle(zbfIdleForceReset)
		elseif (style == 9)
			a_actor.PlayIdle(zbfIdleForceReset)
		elseif (style == 10)
			a_actor.PlayIdle(zbfIdleForceReset)
		elseif (style == 11)
			a_actor.PlayIdle(zbfIdleForceReset)
		elseif (style == 12)
			a_actor.PlayIdle(zbfIdleForceReset)
		endif
	else
		if (style == 0)
			a_actor.PlayIdle(PAF_Pee05_End)
		elseif (style == 1)
			a_actor.PlayIdle(zbfIdleForceReset)
		elseif (style == 2)
			a_actor.PlayIdle(zbfIdleForceReset)
		elseif (style == 3)
			a_actor.PlayIdle(zbfIdleForceReset)
		elseif (style == 4)
			a_actor.PlayIdle(zbfIdleForceReset)
		elseif (style == 5)
			a_actor.PlayIdle(zbfIdleForceReset)
		elseif (style == 6)
			a_actor.PlayIdle(zbfIdleForceReset)
		elseif (style == 7)
			a_actor.PlayIdle(zbfIdleForceReset)
		elseif (style == 8)
			a_actor.PlayIdle(zbfIdleForceReset)
		elseif (style == 9)
			a_actor.PlayIdle(zbfIdleForceReset)
		elseif (style == 10)
			a_actor.PlayIdle(zbfIdleForceReset)
		elseif (style == 11)
			a_actor.PlayIdle(zbfIdleForceReset)
		endif
	endif
endFunction

function PlacePuddle(Actor a_actor, float dist, float angle_offset, int stages)
	if (PAF_MCMQuest.PAF_PlacePuddles && !HasDiaper(a_actor))
		float z_actor = a_actor.GetAngleZ() + angle_offset
		float x_pos = a_actor.GetPositionX() + Math.Sin(z_actor) * dist
		float y_pos = a_actor.GetPositionY() + Math.Cos(z_actor) * dist
		ObjectReference target = a_actor.PlaceAtMe(XMarker)
		target.SetPosition(x_pos, y_pos, a_actor.GetPositionZ() + 35)
		if (stages >= 1)
			target.PlayImpactEffect(PAF_PeeImpactDataSet)
		endif
		if (stages >= 2)
			Wait(3)
			target.PlayImpactEffect(PAF_PeeMidImpactDataSet)
		endif
		if (stages >= 3)
			Wait(3)
			target.PlayImpactEffect(PAF_PeeHighImpactDataSet)
		endif
		target.Delete()
	endif
endfunction

function InitPAF()
	DirtState = 0
	PeeState = 0
	PoopState = 0
	isAnimating = false
	isRelieving = false
	diaper_bounty_timer = false
	diaper_bounty_start = 0.0
	diaper_bounty_active = false
	diaper_received_bounty = false
	diaper_dialog_delayed = false
	soundID = 0
	last_pee = GetCurrentGameTime()
	last_poop = GetCurrentGameTime()
	last_animation_check = 0
	VictimActor = none
	_toilet_state = 0
	RegisterForKey(PAF_MCMQuest.PAF_ActionKey)
	RegisterForKey(PAF_MCMQuest.PAF_InfoKey)
	RegisterForKey(PAF_MCMQuest.PAF_MenuKey)
	PAF_MCMQuest.AddMenuSpell()
	PAF_NPCQuest.ResetActors()
	PAF_NPCQuest.RegisterForSingleUpdate(15)
	PAF_ToiletQuest.ResetToilets()
	PAF_ToiletQuest.RegisterForSingleUpdate(15)
	PAF_DDQuest.InitDDQuest()
	SexLab = SexLabUtil.GetApi()
	RegisterForSingleUpdate(10)
	RegisterSexlabHooks()
	DisplayMessage("PAF: Ready")
endfunction

function DeinitPAF()
	UnregisterForUpdate()
	DisplayMessage("PAF: Uninstalling")
	DirtState = 0
	PeeState = 0
	PoopState = 0
	isAnimating = false
	isRelieving = false
	diaper_bounty_timer = false
	diaper_bounty_start = 0.0
	diaper_received_bounty = false
	diaper_bounty_active = true
	UnequipDiaper(PlayerREF)
	diaper_bounty_active = false
	diaper_dialog_delayed = false
	if (soundID != 0)
		Sound.StopInstance(soundID)
	endif
	last_pee = GetCurrentGameTime()
	last_poop = GetCurrentGameTime()
	last_animation_check = 0
	VictimActor = none
	_toilet_state = 0
	UnregisterForKey(PAF_MCMQuest.PAF_ActionKey)
	UnregisterForKey(PAF_MCMQuest.PAF_InfoKey)
	UnregisterForKey(PAF_MCMQuest.PAF_MenuKey)
	PAF_MCMQuest.RemoveSpells()
	PlayerREF.RemoveSpell(PAF_NoBladderSpell)
	PlayerREF.RemoveSpell(PAF_LowBladderSpell)
	PlayerREF.RemoveSpell(PAF_MidBladderSpell)
	PlayerREF.RemoveSpell(PAF_HighBladderSpell)
	PlayerREF.RemoveSpell(PAF_LeakBladderSpell)
	PlayerREF.RemoveSpell(PAF_NoBowelsSpell)
	PlayerREF.RemoveSpell(PAF_LowBowelsSpell)
	PlayerREF.RemoveSpell(PAF_MidBowelsSpell)
	PlayerREF.RemoveSpell(PAF_HighBowelsSpell)
	PlayerREF.RemoveSpell(PAF_LeakBowelsSpell)
	PAF_ToiletQuest.UnregisterForUpdate()
	PAF_ToiletQuest.DeleteToilets()
	PAF_NPCQuest.UnregisterForUpdate()
	PAF_NPCQuest.ReleaseActors()
	SexLab = none
	ScaleBelly(PlayerREF)
	ScaleButt(PlayerREF, 1.0)
	NiOverride.RemoveAllReferenceNodeOverrides(PlayerREF)
	RemoveInvalidOverlay(PlayerREF, 0)
	UnregisterSexlabHooks()
endfunction

function DisplayMessage(string msg)
	Debug.Notification(msg)
endFunction

int function MaxInt(int a, int b)
	if (a > b)
		return a
	endif
	return b
endfunction

int function MinInt(int a, int b)
	if (a < b)
		return a
	endif
	return b
endfunction

float function MinFloat(float a, float b)
	if (a < b)
		return a
	endif
	return b
endfunction

float function MaxFloat(float a, float b)
	if (a > b)
		return a
	endif
	return b
endfunction

int function GetRandomAnimation(bool[] animations)
	int animationCount = GetAnimationCount(animations)
	int random = Utility.RandomInt(0, animationCount - 1)
	int i = 0
	int hits = 0
	while (i < Animations.length)
		if (animations[i])
			if (random == hits)
				random = i
				i = Animations.length
			else
				hits += 1
			endif
		endif
		i += 1
	endWhile
	return random
endfunction

int function GetAnimationCount(bool[] animations)
	int i = 0
	int count = 0
	while(i < animations.length)
		if (animations[i])
			count += 1
		endif
		i += 1
	endWhile
	if (count == 0)
		return animations.length
	else
		return count
	endif
endfunction

function DisplayNeeds(Actor a_actor)

	if (!PAF_MCMQuest.PAF_DiablePlayerNeeds)
		if(PeeState == 0)
			DisplayMessage("You do not have to pee")
		elseif(PeeState == 1)
			DisplayMessage("There is very little pressure in your bladder")
		elseif(PeeState == 2)
			DisplayMessage("There is pressure in your bladder")
		elseif(PeeState == 3)
			DisplayMessage("There is huge pressure in your bladder")
		elseif(PeeState >= 4)
			DisplayMessage("You are about to wet yourself")
		endif
		if (!PAF_MCMQuest.PAF_Disable_Fart)
			if(PoopState == 0)
				DisplayMessage("You do not have to poop")
			elseif(PoopState == 1)
				DisplayMessage("There is very little pressure in your bowels")
			elseif(PoopState == 2)
				DisplayMessage("There is pressure in your bowels")
			elseif(PoopState == 3)
				DisplayMessage("There is huge pressure in your bowels")
			elseif(PoopState >= 4)
				DisplayMessage("You are about to poo in your panties")
			endif
		endif
	endif

	if (a_actor != none)
		int i = PAF_NPCQuest.IsTrackedActor(a_actor)
		if (i != -1)
			string Name = PAF_NPCQuest.GetNPCName(a_actor)
			string pronoun = PAF_NPCQuest.GetNPCReflexivePronoun(a_actor)
			if(PAF_NPCQuest.NPC_PeeState[i] == 0)
				DisplayMessage(Name + " does not have to pee")
			elseif(PAF_NPCQuest.NPC_PeeState[i] == 1)
				DisplayMessage("There is very little pressure in " + Name +"s bladder")
			elseif(PAF_NPCQuest.NPC_PeeState[i] == 2)
				DisplayMessage("There is pressure in " + Name +"s bladder")
			elseif(PAF_NPCQuest.NPC_PeeState[i] == 3)
				DisplayMessage("There is huge pressure in " + Name +"s bladder")
			elseif(PAF_NPCQuest.NPC_PeeState[i] >= 4)
				DisplayMessage(Name + " is about to wet " + pronoun)
			endif
			if (!PAF_MCMQuest.PAF_Disable_Fart)
				if(PAF_NPCQuest.NPC_PoopState[i] == 0)
					DisplayMessage(Name + " does not have to poop")
				elseif(PAF_NPCQuest.NPC_PoopState[i] == 1)
					DisplayMessage("There is very litte pressure in " + Name +"s bowels")
				elseif(PAF_NPCQuest.NPC_PoopState[i] == 2)
					DisplayMessage("There is pressure in " + Name +"s bowels")
				elseif(PAF_NPCQuest.NPC_PoopState[i] == 3)
					DisplayMessage("There is huge pressure in " + Name +"s bowels")
				elseif(PAF_NPCQuest.NPC_PoopState[i] >= 4)
					DisplayMessage(Name + " is about to poop " + pronoun)
				endif
			endif
		endif
	endif
endFunction

function AddPeeDebuffs(int pstate)
	PlayerREF.RemoveSpell(PAF_NoBladderSpell)
	PlayerREF.RemoveSpell(PAF_LowBladderSpell)
	PlayerREF.RemoveSpell(PAF_MidBladderSpell)
	PlayerREF.RemoveSpell(PAF_HighBladderSpell)
	PlayerREF.RemoveSpell(PAF_LeakBladderSpell)
	if (!PAF_MCMQuest.PAF_DisablePeeDebuff)
		if (pstate == 0)
			PlayerREF.AddSpell(PAF_NoBladderSpell, false)
		elseif (pstate == 1)
			PlayerREF.AddSpell(PAF_LowBladderSpell, false)
		elseif (pstate == 2)
			PlayerREF.AddSpell(PAF_MidBladderSpell, false)
		elseif (pstate == 3)
			PlayerREF.AddSpell(PAF_HighBladderSpell, false)
		elseif (pstate == 4)
			PlayerREF.AddSpell(PAF_LeakBladderSpell, false)
		endif
	endif
endFunction

function AddPoopDebuffs(int pstate)
	PlayerREF.RemoveSpell(PAF_NoBowelsSpell)
	PlayerREF.RemoveSpell(PAF_LowBowelsSpell)
	PlayerREF.RemoveSpell(PAF_MidBowelsSpell)
	PlayerREF.RemoveSpell(PAF_HighBowelsSpell)
	PlayerREF.RemoveSpell(PAF_LeakBowelsSpell)
	if (!PAF_MCMQuest.PAF_DisablePoopDebuff)
		if (pstate == 0)
			PlayerREF.AddSpell(PAF_NoBowelsSpell, false)
		elseif (pstate == 1)
			PlayerREF.AddSpell(PAF_LowBowelsSpell, false)
		elseif (pstate == 2)
			PlayerREF.AddSpell(PAF_MidBowelsSpell, false)
		elseif (pstate == 3)
			PlayerREF.AddSpell(PAF_HighBowelsSpell, false)
		elseif (pstate == 4)
			PlayerREF.AddSpell(PAF_LeakBowelsSpell, false)
		endif
	endif
endFunction

function AddDirtDebuffs(int pstate)
	PlayerREF.RemoveSpell(PAF_NoDirtSpell)
	PlayerREF.RemoveSpell(PAF_LowDirtSpell)
	PlayerREF.RemoveSpell(PAF_MidDirtSpell)
	PlayerREF.RemoveSpell(PAF_HighDirtSpell)
	if (!PAF_MCMQuest.PAF_DisableDirtDebuff)
		if (pstate == 0)
			PlayerREF.AddSpell(PAF_NoDirtSpell, false)
		elseif (pstate == 1)
			PlayerREF.AddSpell(PAF_LowDirtSpell, false)
		elseif (pstate == 2)
			PlayerREF.AddSpell(PAF_MidDirtSpell, false)
		elseif (pstate == 3)
			PlayerREF.AddSpell(PAF_HighDirtSpell, false)
		endif
	endif
endFunction

function ScaleBelly(Actor a_actor)
	if (PAF_MCMQuest.PAF_Scaling && a_actor.GetActorBase().GetSex() == 1)		
		NiOverride.AddNodeTransformScale(a_actor, false, true, "NPC Belly", "PAF_Belly_Scale", MaxFloat((MaxInt((MinInt(PoopState, 3) + 1), 1) * PAF_MCMQuest.PAF_ScalingFactor), 1.0))
		NiOverride.UpdateNodeTransform(a_actor, false, true, "NPC Belly")
	endif
endfunction

function ScaleButtStage(Actor a_actor, int stage)
	if (PAF_MCMQuest.PAF_Scaling && a_actor.GetActorBase().GetSex() == 1)
		if (stage < 3 && ButtScaled(a_actor) < 1.0 + 3.0 * PAF_MCMQuest.PAF_ButtScalingFactor)
			ScaleButt(a_actor, 1.0 + (stage + 1) * PAF_MCMQuest.PAF_ButtScalingFactor)
		endif
	endif
endfunction

function ScaleButt(Actor a_actor, float buttscale)
	if (a_actor.GetActorBase().GetSex() == 1)
		NiOverride.AddNodeTransformScale(a_actor, false, true, "Butt", "PAF_Butt_Scale", buttscale)
		NiOverride.UpdateNodeTransform(a_actor, false, true, "Butt")
	endif
endfunction

float function ButtScaled(Actor a_actor)
	return NiOverride.GetNodeTransformScale(a_actor, false, SexLab.GetGender(a_actor) == 1, "Butt", "PAF_Butt_Scale")
endFunction


function ApplyFacialExpressions(Actor a_actor, int expression)
	if (PAF_MCMQuest.PAF_FacialExpression)
		a_actor.SetExpressionOverride(expression, 100)
	endif
endfunction

function ClearFacialExpressions(Actor a_actor)
	a_actor.ClearExpressionOverride()
endfunction

; #################### Sounds ###############

function PlayPoopSound(Actor a_actor)
	if (PAF_MCMQuest.PAF_PlayMoaningSounds)
		if (a_actor.GetActorBase().GetSex() == 0)
			zbfSoundGagMale01.Play(a_actor)
		else
			zbfSoundGagFrustrated.Play(a_actor)
		endif
	endif
	Wait(0.3)
	PAF_FartSoundMarker.Play(a_actor)
endFunction

int soundID
function StartPeeSound(Actor a_actor)
	if (soundID != 0)
		Sound.StopInstance(soundID)
	endif
	soundID = AMBWaterfallSplatterLarge.play(a_actor)
endFunction

function StopPeeSound()
	if (soundID != 0)
		Sound.StopInstance(soundID)
	endif
	soundid = 0
endfunction

; #################### Stripping ############

Form[] function StripActor(Actor a_actor, bool animate = true)
	if (PAF_MCMQuest.PAF_Stripping)
		if (PAF_MCMQuest.PAF_PlayUndressAnim && animate)
			if (PAF_MCMQuest.PAF_UndressAnim == 0)
				a_actor.PlayIdle(PAF_Stripping01)
			elseif  (PAF_MCMQuest.PAF_UndressAnim == 1)
				a_actor.PlayIdle(PAF_Stripping02)
			elseif  (PAF_MCMQuest.PAF_UndressAnim == 2)
				a_actor.PlayIdle(PAF_Stripping05)
			elseif  (PAF_MCMQuest.PAF_UndressAnim == 3)
				a_actor.PlayIdle(PAF_Stripping06)
			endif
			Wait(5)
		endif
		if (PAF_MCMQuest.PAF_LimitedStripping)
			return Sexlab.StripSlots(a_actor, PAF_MCMQuest.PAF_StrippingSlots)
		else
			return Sexlab.StripActor(a_actor, none, false, false)
		endif
	endif
endFunction

function UnstripActor(Actor a_actor, Form[] equipment)
	if (PAF_MCMQuest.PAF_Stripping)
		SexLab.UnstripActor(a_actor, equipment, false)
	endif
endFunction

function EquipTinke(Actor a_actor, bool parabolic = false, bool leak = false)
	if (HasDiaper(a_actor))
		return
	elseif (leak)
		a_actor.EquipItem(PAF_ZaZAPEF2Pee01_M, true, true)
	elseif ((a_actor.GetBaseObject() as ActorBase).GetSex() == 0)
		a_actor.EquipItem(ZaZAPEF2Pee01, true, true)
	else
		if (SexLab.GetGender(a_actor) == 0)
			a_actor.EquipItem(PAF_ZaZAPEF2Pee01, true, true)
		else
			if (parabolic)
				a_actor.EquipItem(ZaZAPEF2Pee02, true, true)
			else
				a_actor.EquipItem(ZaZAPEF2Pee01, true, true)
			endif
		endif
	endif
endfunction

function UnequipTinke(Actor a_actor, bool parabolic = false, bool leak = false)	
	a_actor.RemoveItem(ZaZAPEF2Pee01, 1, true)
	a_actor.RemoveItem(ZaZAPEF2Pee02, 1, true)
	a_actor.RemoveItem(PAF_ZaZAPEF2Pee01, 1, true)
	a_actor.RemoveItem(PAF_ZaZAPEF2Pee01_M, 1, true)
endFunction

; ############# SexLab #####################

int function PeeInMouth()
	return StartSexlabAnimation(playerREF, VictimActor, true, false);
endfunction

int function PeeInMouthPlayer()
	return StartSexlabAnimation(VictimActor, playerREF, true, false);
endFunction

int function PoopInMouth()
	return StartSexlabAnimation(playerREF, VictimActor, false, true);
endfunction

int function PoopInMouthPlayer()
	return StartSexlabAnimation(VictimActor, playerREF, false, true);
endFunction

int function Masturbate()
	return StartSexlabAnimation(playerREF, none, false, true);
endFunction

function RegisterSexlabHooks()
	RegisterForModEvent("HookStageStart", "SexlabStageChange")
	RegisterForModEvent("HookAnimationEnd", "SexlabEnd")
endFunction

function UnregisterSexlabHooks()
	UnregisterForModEvent("HookStageStart")
	UnregisterForModEvent("HookAnimationEnd")
endFunction

;###################################################

Actor sexlabDom
Actor sexlabSub
bool sexlabPee
bool sexlabFart
int sexlabPeeStage
int sexlabPoopStage
bool sexlabBothAct

int function StartSexlabAnimation(Actor dom, Actor sub, bool pee, bool fart, int peeStage = 2, int poopStage = 3, bool switchRoles = false, bool bothAct = false)

	if (dom != none)

		if (Sexlab.ValidateActor(dom) != 1 || isAnimating)
			return -1
		endif
		if (sub != none)
			if (Sexlab.ValidateActor(sub) != 1)
				return -1
			endif
		endif

		PAF_NPCQuest.NPC_Sexlab_Active = true

		sslThreadModel Thread = SexLab.NewThread()
		sslBaseAnimation anim

		if (sub == none)
			; solo
			Thread.AddActor(dom)

			if (pee && fart)
				if (PAF_DDQuest.IsAnalPlugged(dom) || PAF_DDQuest.hasDeviousBelt(dom))
					if (dom == PlayerREF)
						DisplayMessage("You are wearing an anal plug and therefore cannot relieve your bowels")
					else
						DisplayMessage(PAF_NPCQuest.GetNPCName(dom) + " is wearing an anal plug and therefore cannot relieve " + PAF_NPCQuest.GetNPCPronoun(dom) + " bowels")
					endif
					return -1
				endif
				if (SexLab.GetGender(dom) == 0)
					anim = SexLab.GetAnimationByName(PAF_MCMQuest.PAF_AnimationM_Both)
				else
					anim = SexLab.GetAnimationByName(PAF_MCMQuest.PAF_AnimationF_Both)
				endif
			elseif (fart)
				if (PAF_DDQuest.IsAnalPlugged(dom) || PAF_DDQuest.hasDeviousBelt(dom))
					if (dom == PlayerREF)
						DisplayMessage("You are wearing an anal plug and therefore cannot relieve your bowels")
					else
						DisplayMessage(PAF_NPCQuest.GetNPCName(dom) + " is wearing an anal plug and therefore cannot relieve " + PAF_NPCQuest.GetNPCPronoun(dom) + " bowels")
					endif
					return -1
				endif
				if (SexLab.GetGender(dom) == 0)
					anim = SexLab.GetAnimationByName(PAF_MCMQuest.PAF_AnimationM_Fart)
				else
					anim = SexLab.GetAnimationByName(PAF_MCMQuest.PAF_AnimationF_Fart)
				endif
			elseif (pee)
				if (SexLab.GetGender(dom) == 0)
					anim = SexLab.GetAnimationByName(PAF_MCMQuest.PAF_AnimationM_Pee)
				else
					anim = SexLab.GetAnimationByName(PAF_MCMQuest.PAF_AnimationF_Pee)
				endif
			endif
		else
			; not solo
			if (switchRoles)
				Thread.AddActor(dom)
				Thread.AddActor(sub)
			else
				Thread.AddActor(sub)
				Thread.AddActor(dom)
			endif

			if (pee && fart)

				if (PAF_DDQuest.IsAnalPlugged(dom) || PAF_DDQuest.hasDeviousBelt(dom))
					if (dom == PlayerREF)
						DisplayMessage("You are wearing an anal plug and therefore cannot relieve your bowels")
					else
						DisplayMessage(PAF_NPCQuest.GetNPCName(dom) + " is wearing an anal plug and therefore cannot relieve " + PAF_NPCQuest.GetNPCPronoun(dom) + " bowels")
					endif
					return -1
				endif

				if (Sexlab.GetGender(dom) == 0)
					if (Sexlab.GetGender(sub) == 0)
						anim = SexLab.GetAnimationByName(PAF_MCMQuest.PAF_AnimationPeeMM_Both)
					else
						anim = SexLab.GetAnimationByName(PAF_MCMQuest.PAF_AnimationPeeMF_Both)
					endif
				else
					if (Sexlab.GetGender(sub) == 0)
						anim = SexLab.GetAnimationByName(PAF_MCMQuest.PAF_AnimationPeeFM_Both)
					else
						anim = SexLab.GetAnimationByName(PAF_MCMQuest.PAF_AnimationPeeFF_Both)
					endif
				endif
			elseif (fart)

				if (PAF_DDQuest.IsAnalPlugged(dom) || PAF_DDQuest.hasDeviousBelt(dom))
					if (dom == PlayerREF)
						DisplayMessage("You are wearing an anal plug and therefore cannot relieve your bowels")
					else
						DisplayMessage(PAF_NPCQuest.GetNPCName(dom) + " is wearing an anal plug and therefore cannot relieve " + PAF_NPCQuest.GetNPCPronoun(dom) + " bowels")
					endif
					return -1
				endif

				if (Sexlab.GetGender(dom) == 0)
					if (Sexlab.GetGender(sub) == 0)
						anim = SexLab.GetAnimationByName(PAF_MCMQuest.PAF_AnimationPeeMM_Fart)
					else
						anim = SexLab.GetAnimationByName(PAF_MCMQuest.PAF_AnimationPeeMF_Fart)
					endif
				else
					if (Sexlab.GetGender(sub) == 0)
						anim = SexLab.GetAnimationByName(PAF_MCMQuest.PAF_AnimationPeeFM_Fart)
					else
						anim = SexLab.GetAnimationByName(PAF_MCMQuest.PAF_AnimationPeeFF_Fart)
					endif
				endif
			elseif (pee)
				if (Sexlab.GetGender(dom) == 0)
					if (Sexlab.GetGender(sub) == 0)
						anim = SexLab.GetAnimationByName(PAF_MCMQuest.PAF_AnimationPeeMM_Pee)
					else
						anim = SexLab.GetAnimationByName(PAF_MCMQuest.PAF_AnimationPeeMF_Pee)
					endif
				else
					if (Sexlab.GetGender(sub) == 0)
						anim = SexLab.GetAnimationByName(PAF_MCMQuest.PAF_AnimationPeeFM_Pee)
					else
						anim = SexLab.GetAnimationByName(PAF_MCMQuest.PAF_AnimationPeeFF_Pee)
					endif
				endif
			endif
		endif

		Thread.AddAnimation(anim)
		UnregisterSexlabHooks()

		sexlabDom = dom
		sexlabSub = sub
		sexlabPee = pee
		sexlabFart = fart
		sexlabPeeStage = 2
		sexlabPoopStage = 3
		sexlabBothAct = bothAct

		Thread.SetHook("PAFGEN")
		RegisterForModEvent("HookStageStart_PAFGEN", "PAFGEN_SexlabStageChange")
		RegisterForModEvent("HookAnimationEnd_PAFGEN", "PAFGEN_SexlabEnd")
		Thread.StartThread()
	endif
	return 0
endFunction

Event PAFGEN_SexlabStageChange(int tid, bool HasPlayer)
	sslThreadController Thread = SexLab.GetController(tid)
	if (sexlabPee)
		if (Thread.Stage == sexlabPeeStage)
			SexlabPee(sexlabDom, sexlabSub)
		endif
	endif
	if (sexlabFart)
		if (Thread.Stage == sexlabPoopStage)
			SexlabPoop(sexlabDom, sexlabSub)
		endif
	endif
EndEvent

Event PAFGEN_SexlabEnd(int tid, bool HasPlayer)
	UnequipTinke(sexlabDom)
	last_pee = GetCurrentGameTime()
	last_poop = GetCurrentGameTime()
	PAF_NPCQuest.NPC_Sexlab_Active = false
	RegisterSexlabHooks()
EndEvent
;###################################################

int function PlaySexlabAnimation(Actor a_actor_1, Actor a_actor_2)
	if (!PAF_MCMQuest.PAF_SexlabIntegration)
		return -1
	endif
	if (a_actor_1 != none && a_actor_2 != none)
		sslThreadModel Thread = SexLab.NewThread()
		Thread.AddActor(a_actor_1)
		Thread.AddActor(a_actor_2)
		Thread.StartThread()
	endif
	PAF_NPCQuest.NPC_Sexlab_Active = true
endFunction

Event SexlabStageChange(int tid, bool HasPlayer)
	if (!PAF_MCMQuest.PAF_SexlabIntegration)
		return
	endif

	sslThreadController Thread = SexLab.GetController(tid)
	Actor[] Positions = Thread.Positions

	; player only
	if (PAF_MCMQuest.PAF_SexlabTarget == 0 && hasPlayer)
		int i = 0
		while (i < Positions.length)
			if (Positions[i] == PlayerREF)
				if (Thread.Stage == PAF_MCMQuest.PAF_SexlabStagePee)
					SexlabPee(Positions[i])
				endif
				if (Thread.Stage == PAF_MCMQuest.PAF_SexlabStagePoop)
					SexlabPoop(Positions[i])
				endif
			endif
			i += 1
		endwhile
	endif

	; NPC only
	if (PAF_MCMQuest.PAF_SexlabTarget == 1)
		int i = 0
		while (i < Positions.length)
			if (Positions[i] != PlayerREF)
				if (Thread.Stage == PAF_MCMQuest.PAF_SexlabStagePee)
					SexlabPee(Positions[i])
				endif
				if (Thread.Stage == PAF_MCMQuest.PAF_SexlabStagePoop)
					SexlabPoop(Positions[i])
				endif
			endif
			i += 1
		endwhile
	endif

	; Everyone
	if (PAF_MCMQuest.PAF_SexlabTarget == 2)
		int i = 0
		while (i < Positions.length)
			if (Thread.Stage == PAF_MCMQuest.PAF_SexlabStagePee)
				SexlabPee(Positions[i])
			endif
			if (Thread.Stage == PAF_MCMQuest.PAF_SexlabStagePoop)
				SexlabPoop(Positions[i])
			endif
			i += 1
		endwhile
	endif

	; Male Only
	if (PAF_MCMQuest.PAF_SexlabTarget == 3)
		int i = 0
		while (i < Positions.length)
			if (Sexlab.GetGender(Positions[i]) == 0)
				if (Thread.Stage == PAF_MCMQuest.PAF_SexlabStagePee)
					SexlabPee(Positions[i])
				endif
				if (Thread.Stage == PAF_MCMQuest.PAF_SexlabStagePoop)
					SexlabPoop(Positions[i])
				endif
			endif
			i += 1
		endwhile
	endif

	; Female Only
	if (PAF_MCMQuest.PAF_SexlabTarget == 4)
		int i = 0
		while (i < Positions.length)
			if (Sexlab.GetGender(Positions[i]) != 0)
				if (Thread.Stage == PAF_MCMQuest.PAF_SexlabStagePee)
					SexlabPee(Positions[i])			
				endif
				if (Thread.Stage == PAF_MCMQuest.PAF_SexlabStagePoop)
					SexlabPoop(Positions[i])
				endif
			endif
			i += 1
		endwhile
	endif

EndEvent

Event SexlabEnd(int tid, bool HasPlayer)
	if (!PAF_MCMQuest.PAF_SexlabIntegration)
		return
	endif
	sslThreadController Thread = SexLab.GetController(tid)
	Actor[] Positions = Thread.Positions
	int i = 0
	while (i < Positions.length)
		UnequipTinke(Positions[i])
		i += 1
	endwhile
	PAF_NPCQuest.NPC_Sexlab_Active = false
EndEvent

function SexlabPoop(Actor a_actor, Actor a_target = none)
	if (PAF_MCMQuest.PAF_Disable_Fart_Sex)
		return
	endif
	
	if (PAF_DDQuest.IsAnalPlugged(a_actor))
		if (a_actor == PlayerREF)
			DisplayMessage("You are wearing an anal plug and therefore cannot relieve your bowels")
		else
			DisplayMessage(PAF_NPCQuest.GetNPCName(a_actor) + " is wearing an anal plug and therefore cannot relieve " + PAF_NPCQuest.GetNPCPronoun(a_actor) + " bowels")
		endif
		return
	endif

	if (PAF_DDQuest.HasDeviousBelt(a_actor))
		if (a_actor == PlayerREF)
			DisplayMessage("A devious device prevents you from releasing the contents of your bowels")
		else
			DisplayMessage("A devious device prevents + " + PAF_NPCQuest.GetNPCName(a_actor) + " + from releasing the contents of " + PAF_NPCQuest.GetNPCPronoun(a_actor) + " bowels")
		endif
		return
	endif
	
	if (!HasDiaper(a_actor))	
		if (a_actor == PlayerREF)
			if (a_target != none)
				DisplayMessage("You are relieving yourself on " + PAF_NPCQuest.GetNPCName(a_target))
			else
				DisplayMessage("You are relieving yourself")
			endif
		else
			if (a_target != none)
				DisplayMessage(PAF_NPCQuest.GetNPCName(a_actor) + " is relieving " + PAF_NPCQuest.GetNPCReflexivePronoun(a_actor) + " on " + PAF_NPCQuest.GetNPCName(a_target))
			else
				DisplayMessage(PAF_NPCQuest.GetNPCName(a_actor) + " is relieving " + PAF_NPCQuest.GetNPCReflexivePronoun(a_actor) + " on " + PAF_NPCQuest.GetNPCName(a_target))
			endif
		endif	
	else
		if (a_actor == PlayerREF)
			DisplayMessage("You fill your diaper")
		else
			DisplayMessage(PAF_NPCQuest.GetNPCName(a_actor) + " fills " + PAF_NPCQuest.GetNPCPronoun(a_actor) + " diaper")
		endif
	endif
	
	int j = PAF_NPCQuest.IsTrackedActor(a_actor)
	int i = 0
	int len = 4
	ApplyFacialExpressions(a_actor, 14)	
	
	while i < len
		if (!HasDiaper(a_actor))
			ObjectReference poop = a_actor.PlaceAtme(PAF_PoopPotion)
			poop.moveToNode(a_actor, "SkirtBBone02")
			poop.SetActorOwner(PlayerREF.GetActorBase())
		else
			if (a_actor == PlayerREF || j != -1)
				ScaleButtStage(a_actor, i)
			endif
		endif
		ApplyFacialExpressions(a_actor, 12)
		PlayPoopSound(a_actor)
		if (i < 3)
			if (a_actor == playerREF)
				IncreaseDirtState(PlayerREF, false, true)
				last_poop = GetCurrentGameTime()
			else
				if (j != -1)
					IncreaseDirtState(a_actor, false, true)
					PAF_NPCQuest.NPC_last_poop[j] = GetCurrentGameTime()
				endif
			endif
		endif
		ApplyFacialExpressions(a_actor, 14)
		Utility.Wait(Utility.RandomInt(1, 2))
		i += 1
	endWhile
	ClearFacialExpressions(a_actor)
endfunction

function SexlabPee(Actor a_actor, Actor a_target = none)
	if (PAF_MCMQuest.PAF_Disable_Pee_Sex)
		return
	endif
	if (HasDiaper(a_actor))
		if (a_actor == PlayerREF)
			DisplayMessage("You pee in your diaper")
		else
			DisplayMessage(PAF_NPCQuest.GetNPCName(a_actor) + " pees in " + PAF_NPCQuest.GetNPCPronoun(a_actor) + " diaper")
		endif
	else
		if (a_target != none)
			if (a_actor == PlayerREF)
				DisplayMessage("You pee on " + PAF_NPCQuest.GetNPCName(a_target))
			else
				DisplayMessage(PAF_NPCQuest.GetNPCName(a_actor) + " pees on " + PAF_NPCQuest.GetNPCName(a_target))				
			endif		
		else
			if (a_actor == PlayerREF)
				DisplayMessage("You pee on youself")
			else
				DisplayMessage(PAF_NPCQuest.GetNPCName(a_actor) + " pees on " + PAF_NPCQuest.GetNPCReflexivePronoun(a_actor))
			endif		
		endif
	endif
	EquipTinke(a_actor)
endFunction