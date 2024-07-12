Scriptname PAF_NPCQuestScript extends Quest

import Utility

PAF_MainQuestScript property PAF_MainQuest auto
PAF_DDQuestScript property PAF_DDQuest auto

ReferenceAlias property PAF_StayPutAlias auto

Actor[] property PAF_TrackedActors auto
int[] property NPC_PeeState auto
int[] property NPC_PoopState auto
int[] property NPC_DirtState auto
int[] property NPC_DiaperState auto
float[] property NPC_last_pee auto
float[] property NPC_last_poop auto

int _actor_index
bool _lock_actors
bool property NPC_Sexlab_Active auto

Actor property PAF_DummyNPC auto

int MAX_ACTOR_COUNT

Event OnUpdate()

	if (_lock_actors == true)
		RegisterForSingleUpdate(10)
		return
	endif

	UpdateNeeds()
	RegisterForSingleUpdate(10)

EndEvent

function UpdateNeeds()

	if (_lock_actors)
		return
	endif
	_lock_actors = true
	NPCRelieve()
	_lock_actors = false

endfunction

function UpdateDiapers(int i)
	if (PAF_TrackedActors[i] != none)
		if (!PAF_MainQuest.HasDiaper(PAF_TrackedActors[i]))
			PAF_MainQuest.ScaleButt(PAF_TrackedActors[i], 1.0)
			NPC_DiaperState[i] = 0
		else
			if (NPC_DiaperState[i] == 1 && !PAF_MainQuest.HasDiaper(PAF_TrackedActors[i], true))
				PAF_MainQuest.DisplayMessage(GetNPCName(PAF_TrackedActors[i]) + " diaper begins to reek...")
				PAF_TrackedActors[i].UnequipItem(PAF_MainQuest.PAF_DiaperArmor, false, true)
				PAF_TrackedActors[i].RemoveItem(PAF_MainQuest.PAF_DiaperArmor, 1, absilent = true)
				PAF_TrackedActors[i].EquipItem(PAF_MainQuest.PAF_DiaperDirtyArmor, false, true)
				NPC_DiaperState[i] = 0
			endif
		endif
	endif
endFunction

Actor function GetOtherNPC(Actor a_actor)
	int i = 0
	while (i < MAX_ACTOR_COUNT)
		if (PAF_TrackedActors[i] != none && PAF_TrackedActors[i] != a_actor)
			return PAF_TrackedActors[i]
		endif
		i += 1
	endwhile
	return none
endFunction

function NPCRelieve()

	int i = 0
	while (i < MAX_ACTOR_COUNT)

		if (PAF_TrackedActors[i] != none)

			CalculateStates(i)

			bool mustPee = false
			bool mustPoop = false
			bool inCell = PAF_MainQuest.PlayerREF.GetParentCell() == PAF_TrackedActors[i].GetParentCell() || PAF_TrackedActors[i].Is3dLoaded()

			bool actor_ready = PAF_MainQuest.Sexlab.ValidateActor(PAF_TrackedActors[i]) == 1 && !PAF_TrackedActors[i].IsInCombat() || PAF_TrackedActors[i].GetSleepState() != 0 || !PAF_TrackedActors[i].IsOnMount() || !PAF_TrackedActors[i].IsSneaking() || !PAF_TrackedActors[i].IsSwimming()
			bool player_ready = PAF_MainQuest.ReadyToAnimate(PAF_MainQuest.PlayerREF)

			bool victim_ready = false

			Actor otherNPC = GetOtherNPC(PAF_TrackedActors[i])
			if (otherNPC != none)
				victim_ready = PAF_MainQuest.SexLab.ValidateActor(otherNPC) == 1 && !PAF_TrackedActors[i].IsInCombat() || PAF_TrackedActors[i].GetSleepState() != 0 || !PAF_TrackedActors[i].IsOnMount() || !PAF_TrackedActors[i].IsSneaking() || !PAF_TrackedActors[i].IsSwimming()
			endif

			if (NPC_PeeState[i] > 0)
				mustPee = true
			endif

			if (NPC_PoopState[i] > 0)
				mustPoop = true
			endif

			int sexlab_result = -2
			
			if (mustPee && mustPoop)
				if (inCell)
					if (actor_ready)
						if (PAF_MainQuest.PAF_MCMQuest.PAF_NPCToilet && victim_ready && !NPC_Sexlab_Active  && !(PAF_MainQuest.PAF_MCMQuest.PAF_Disable_Fart_Sex || PAF_MainQuest.PAF_MCMQuest.PAF_Disable_Pee_Sex))
						
							sexlab_result = PAF_MainQuest.StartSexlabAnimation(PAF_TrackedActors[i], otherNPC, true, true)
							
							mustPee = false
							mustPoop = false
						elseif (PAF_MainQuest.PAF_MCMQuest.PAF_PlayerToilet && player_ready && !NPC_Sexlab_Active  && !(PAF_MainQuest.PAF_MCMQuest.PAF_Disable_Fart_Sex || PAF_MainQuest.PAF_MCMQuest.PAF_Disable_Pee_Sex))
							
							sexlab_result = PAF_MainQuest.StartSexlabAnimation(PAF_TrackedActors[i], PAF_MainQuest.PlayerREF, true, true)
							
							NPC_last_pee[i] = GetCurrentGameTime()
							NPC_last_poop[i] = GetCurrentGameTime()
							mustPee = false
						else
							if (!NPC_Sexlab_Active)
								if (NPC_PeeState[i] > 3 && NPC_PoopState[i] > 3)
									LeakAndPoop(PAF_TrackedActors[i])
									mustPee = false
									mustPoop = false
								elseif (NPC_PeeState[i] >= 3 || NPC_PoopState[i] >= 3)
									int foundToilet = -1
									if (!PAF_MainQuest.HasDiaper(PAF_TrackedActors[i]))
										foundToilet = PAF_MainQuest.PAF_ToiletQuest.GetToilet(PAF_TrackedActors[i])
									endif
									if (foundToilet != 0)
										PAF_StayPutAlias.ForceRefTo(PAF_TrackedActors[i])
										Pee(PAF_TrackedActors[i])
										PAF_StayPutAlias.ForceRefTo(PAF_DummyNPC)
									endif
									mustPee = false
									mustPoop = false
								endif
							endif
						endif
					endif
				else
					PeeVirtual(PAF_TrackedActors[i])
					PoopVirtual(PAF_TrackedActors[i])
					mustPee = false
					mustPoop = false
				endif
			endif

			if (mustPee)
				if (inCell)
					if (actor_ready)
						if (PAF_MainQuest.PAF_MCMQuest.PAF_NPCToilet && victim_ready && !NPC_Sexlab_Active && !PAF_MainQuest.PAF_MCMQuest.PAF_Disable_Pee_Sex)
							
							sexlab_result = PAF_MainQuest.StartSexlabAnimation(PAF_TrackedActors[i], otherNPC, true, false)
							
						elseif (PAF_MainQuest.PAF_MCMQuest.PAF_PlayerToilet && player_ready && !NPC_Sexlab_Active && !PAF_MainQuest.PAF_MCMQuest.PAF_Disable_Pee_Sex)
							
							sexlab_result = PAF_MainQuest.StartSexlabAnimation(PAF_TrackedActors[i], PAF_MainQuest.PlayerREF, true, false)							
							
						else
							if (!NPC_Sexlab_Active)
								if (NPC_PeeState[i] > 3)
									Leak(PAF_TrackedActors[i])
								elseif (NPC_PeeState[i] >= 3)
									int foundToilet = -1
									if (!PAF_MainQuest.HasDiaper(PAF_TrackedActors[i]))
										foundToilet = PAF_MainQuest.PAF_ToiletQuest.GetToilet(PAF_TrackedActors[i])
									endif
									if (foundToilet != 0)
										PAF_StayPutAlias.ForceRefTo(PAF_TrackedActors[i])
										Pee(PAF_TrackedActors[i], true)
										PAF_StayPutAlias.ForceRefTo(PAF_DummyNPC)
									endif
								endif
							endif
						endif
					endif
				else
					PeeVirtual(PAF_TrackedActors[i])
				endif
			endif

			if (mustPoop)
				if (inCell)
					if (actor_ready)
						if (PAF_MainQuest.PAF_MCMQuest.PAF_NPCToilet && victim_ready && !NPC_Sexlab_Active && PAF_MainQuest.PAF_DDQuest.HasDeviousBelt(PAF_TrackedActors[i]) && PAF_MainQuest.PAF_DDQuest.IsAnalPlugged(PAF_TrackedActors[i]) && !PAF_MainQuest.PAF_MCMQuest.PAF_Disable_Fart_Sex)
							
							sexlab_result = PAF_MainQuest.StartSexlabAnimation(PAF_TrackedActors[i], otherNPC, false, true)
							
						elseif (PAF_MainQuest.PAF_MCMQuest.PAF_PlayerToilet && player_ready && !NPC_Sexlab_Active && !PAF_MainQuest.PAF_MCMQuest.PAF_Disable_Fart_Sex)
							
							sexlab_result = PAF_MainQuest.StartSexlabAnimation(PAF_TrackedActors[i], PAF_MainQuest.PlayerREF, false, true)
							
						else
							if (!NPC_Sexlab_Active && !PAF_MainQuest.PAF_DDQuest.HasDeviousBelt(PAF_TrackedActors[i]) && !PAF_MainQuest.PAF_DDQuest.IsAnalPlugged(PAF_TrackedActors[i]))
								if (NPC_PoopState[i] > 3)
									PAF_StayPutAlias.ForceRefTo(PAF_TrackedActors[i])
									PoopPanty(PAF_TrackedActors[i])
									PAF_StayPutAlias.ForceRefTo(PAF_DummyNPC)
								elseif (NPC_PoopState[i] >= 3)
									int foundToilet = -1
									if (!PAF_MainQuest.HasDiaper(PAF_TrackedActors[i]))
										foundToilet = PAF_MainQuest.PAF_ToiletQuest.GetToilet(PAF_TrackedActors[i])
									endif
									if (foundToilet != 0)
										PoopSensual(PAF_TrackedActors[i])
									endif
								endif
							endif
						endif
					endif
				else
					PoopVirtual(PAF_TrackedActors[i])
				endif
			endif
			if (PAF_TrackedActors[i].IsSwimming())
				NPC_DirtState[i] = 0
			endif
			if (NPC_DirtState[i] >= 1 && PAF_MainQuest.HasToiletPaper(PAF_TrackedActors[i]))
				UseToiletPaper(PAF_TrackedActors[i])
			endif
			PAF_MainQuest.ApplyDirtOverlay(PAF_TrackedActors[i], NPC_DirtState[i])
			UpdateDiapers(i)
			CalculateStates(i)
			ScaleBelly(i)
		endif

		i += 1
	endWhile

endFunction


function RelieveActor()


endFunction

function ResetActors()
	_lock_actors = true
	MAX_ACTOR_COUNT = 5 ; amount of supported actors
	PAF_TrackedActors = new Actor[5]
	NPC_PeeState = new int[5]
	NPC_PoopState = new int[5]
	NPC_DirtState = new int[5]
	NPC_last_pee = new float[5]
	NPC_last_poop = new float[5]
	NPC_DiaperState = new int[5]
	_actor_index = 0
	_lock_actors = false
endfunction

function ReleaseActors()

	PAF_MainQuest.DisplayMessage("PAF: Resetting actors...")
	int i = 0;
	while i < MAX_ACTOR_COUNT
		if (PAF_TrackedActors[i] != none)
			PAF_TrackedActors[i].PlayIdle(PAF_MainQuest.zbfIdleForceReset)
			NPC_DirtState[i] = 0
			NPC_DiaperState[i] = 0
			PAF_MainQuest.Bathe(PAF_TrackedActors[i])
			SlaveTats.synchronize_tattoos(PAF_TrackedActors[i], silent = true)
			if (PAF_MainQuest.PAF_MCMQuest.PAF_Scaling && PAF_TrackedActors[i].GetActorBase().GetSex() == 1)
				NiOverride.AddNodeTransformScale(PAF_TrackedActors[i], false, true, "Belly", "PAF_Belly_Scale", 1.0)
				NiOverride.UpdateNodeTransform(PAF_TrackedActors[i], false, true, "Belly")
				NiOverride.AddNodeTransformScale(PAF_TrackedActors[i], false, true, "Butt", "PAF_Butt_Scale", 1.0)
				NiOverride.UpdateNodeTransform(PAF_TrackedActors[i], false, true, "Butt")
				NiOverride.RemoveAllReferenceNodeOverrides(PAF_TrackedActors[i])
			endif
		endif
		PAF_TrackedActors[i] = none
		i += 1
	endwhile
	_actor_index = 0
	_lock_actors = false

endfunction

function CalculateStates(int i)
	float currentTime = Utility.GetCurrentGameTime()
	int hoursPassedPee = Math.Floor((currentTime - NPC_last_pee[i]) * 24)
	int hoursPassedPoop = Math.Floor((currentTime - NPC_last_poop[i]) * 24)
	if (PAF_MainQuest.PAF_MCMQuest.PAF_Disable_Pee)
		NPC_PeeState[i] = 0
	else
		NPC_PeeState[i] = Math.Floor(hoursPassedPee / PAF_MainQuest.PAF_MCMQuest.PAF_PeeRate)
	endif
	if (PAF_MainQuest.PAF_MCMQuest.PAF_Disable_Fart)
		NPC_PoopState[i] = 0
	else
		NPC_PoopState[i] = Math.Floor(hoursPassedPoop / PAF_MainQuest.PAF_MCMQuest.PAF_PoopRate)
	endif
endfunction

function ScaleBelly(int i)
	if (PAF_MainQuest.PAF_MCMQuest.PAF_Scaling && PAF_TrackedActors[i].GetActorBase().GetSex() == 1)
		NiOverride.AddNodeTransformScale(PAF_TrackedActors[i], false, true, "Belly", "PAF_Belly_Scale", PAF_MainQuest.MaxFloat((PAF_MainQuest.MaxInt((PAF_MainQuest.MinInt(NPC_PoopState[i], 3) + 1), 1) * PAF_MainQuest.PAF_MCMQuest.PAF_ScalingFactor), 1.0))
		NiOverride.UpdateNodeTransform(PAF_TrackedActors[i], false, true, "Belly")
	endif
endfunction

string function GetNPCReflexivePronoun(Actor a_actor)
	if (a_actor.GetActorBase().GetSex() == 0)
		return "himself"
	else
		return "herself"
	endif
endfunction

string function GetNPCPronoun(Actor a_actor)
	if (a_actor.GetActorBase().GetSex() == 0)
		return "his"
	else
		return "her"
	endif
endfunction

string function GetNPCName(Actor a_actor)
	return a_actor.GetActorBase().GetName()
endfunction

int function WaitLockedActors()
	int j = 0;
	while(_lock_actors || j >= 120)
		j += 1
		Utility.Wait(1)
	endWhile
	if (j == 120)
		_lock_actors = false
		return -1
	endif
	_lock_actors = true
	return 0
endfunction

function AddActor(Actor a_actor)
	if (WaitLockedActors() == -1)
		PAF_MainQuest.DisplayMessage("PAF: Could not process actor")
		return
	endif
	int i = IsTrackedActor(a_actor)
	if (i != -1)
		RemoveActor(i)
	else
		if (_actor_index <= MAX_ACTOR_COUNT - 1)
			PAF_TrackedActors[_actor_index] = a_actor
			NPC_PeeState[_actor_index] = 0
			NPC_PoopState[_actor_index] = 0
			NPC_DirtState[_actor_index] = 0
			NPC_last_pee[_actor_index] = Utility.GetCurrentGameTime()
			NPC_last_poop[_actor_index] = Utility.GetCurrentGameTime()
			_actor_index += 1
			PAF_MainQuest.DisplayMessage("PAF: Adding actor")
		else
			PAF_MainQuest.DisplayMessage("PAF: You cannot track more actors! Please release someone...")
		endif
	endif
	_lock_actors = false
endfunction

function RemoveActor(int i)
	if (_actor_index == 1) ; one actor
		PAF_MainQuest.Bathe(PAF_TrackedActors[0])
		PAF_TrackedActors[0] = none
		NPC_PeeState[0] = 0
		NPC_PoopState[0] = 0
		NPC_DirtState[0] = 0
	else
		if (i == _actor_index - 1) ; last actor
			PAF_MainQuest.Bathe(PAF_TrackedActors[0])
			PAF_TrackedActors[i] = none
			NPC_PeeState[i] = 0
			NPC_PoopState[i] = 0
			NPC_DirtState[i] = 0
		else ; switch actor with last
			PAF_MainQuest.Bathe(PAF_TrackedActors[0])
			PAF_TrackedActors[i] = PAF_TrackedActors[_actor_index - 1]
			NPC_PeeState[i] = NPC_PeeState[_actor_index - 1]
			NPC_PoopState[i] = NPC_PoopState[_actor_index - 1]
			NPC_DirtState[i] = NPC_DirtState[_actor_index - 1]
			NPC_last_pee[_actor_index] = NPC_last_pee[_actor_index - 1]
			NPC_last_poop[_actor_index] = NPC_last_poop[_actor_index - 1]
			PAF_TrackedActors[_actor_index - 1] = none
			NPC_PeeState[_actor_index - 1] = 0
			NPC_PoopState[_actor_index - 1] = 0
			NPC_DirtState[_actor_index - 1] = 0
		endif
	endif
	_actor_index -= 1
	PAF_MainQuest.DisplayMessage("PAF: Actor removed")
endfunction

int function IsTrackedActor(Actor a_actor)
	int i = 0
	while (i < MAX_ACTOR_COUNT)
		if (PAF_TrackedActors[i] != none)
			if (PAF_TrackedActors[i] == a_actor)
				return i
			endif
		endif
		i += 1
	endwhile
	return -1
endfunction

; ############################ Pee ###########################

function Pee(Actor a_actor, bool peeOnly = false)
	int i = IsTrackedActor(a_actor)
	if (i == -1)
		return
	endif

	if (NPC_PeeState[i] > 0)

		if (PAF_DDQuest.HasArmbinder(a_actor))
			PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) + " arms are locked!")
			Leak(a_actor)
			return
		endif

		PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) + " relieves " + GetNPCReflexivePronoun(a_actor) + "...")
		Form[] equipment = PAF_MainQuest.StripActor(a_actor)
		Wait(3)

		int result = -1
		if (PAF_MainQuest.SexLab.GetGender(a_actor) == 0)
			result = PeeMale(a_actor, peeOnly)
		else
			result = PeeFemale(a_actor, peeOnly)
		endif
		if (result == 0)
			UseToiletPaper(a_actor)
		endif
		PAF_MainQuest.UnstripActor(a_actor, equipment)
		NPC_last_pee[i] = Utility.GetCurrentGameTime()
		PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) + " relieved " + GetNPCReflexivePronoun(a_actor) + ".")
	endif
endfunction

int function PeeFemale(Actor a_actor, bool peeOnly = false)
	int style = PAF_MainQuest.GetRandomAnimation(PAF_MainQuest.PAF_MCMQuest.PAF_Animation_F)
	PAF_MainQuest.PlayPeeIdleStart(a_actor, style, true)
	PAF_MainQuest.ApplyFacialExpressions(a_actor, 10)
	Wait(5)
	if (style == 0)
		PAF_MainQuest.EquipTinke(a_actor, true)
	else
		PAF_MainQuest.EquipTinke(a_actor)
	endif
	StartPeeSound(a_actor)
	if (PAF_MainQuest.HasDiaper(a_actor))
		PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) + " pees in " + GetNPCPronoun(a_actor) + " diaper")
	endif
	Wait(2)
	PAF_MainQuest.PlacePeePuddle(a_actor, style, true)
	Wait(5)
	int result = -1
	if (!peeOnly)
		result = poop(a_actor)
	endif
	PAF_MainQuest.ApplyFacialExpressions(a_actor, 10)
	Wait(5)
	if (style == 0)
		PAF_MainQuest.UnequipTinke(a_actor, true)
	else
		PAF_MainQuest.UnequipTinke(a_actor)
	endif
	PAF_MainQuest.UnequipTinke(a_actor)
	StopPeeSound()
	Wait(1.5)
	PAF_MainQuest.PlayPeeIdleStop(a_actor, style, true)
	PAF_MainQuest.ClearFacialExpressions(a_actor)
	PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) + " feels relieved")
	return result
endfunction

int function PeeMale(Actor a_actor, bool peeOnly = false)
	int style = PAF_MainQuest.GetRandomAnimation(PAF_MainQuest.PAF_MCMQuest.PAF_Animation_M)
	PAF_MainQuest.PlayPeeIdleStart(a_actor, style, false)
	a_actor.AddToFaction(PAF_MainQuest.SexLab.AnimatingFaction)
	Debug.SendAnimationEvent(a_actor, "SOSFastErect")
	Wait(5)
	PAF_MainQuest.EquipTinke(a_actor)
	StartPeeSound(a_actor)
	if (PAF_MainQuest.HasDiaper(a_actor))
		PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) + " pees in " + GetNPCPronoun(a_actor) + " diaper")
	endif
	Wait(2)
	PAF_MainQuest.PlacePeePuddle(a_actor, style, false)
	Wait(5)
	int result = -1
	if (!peeOnly)
		result = poop(a_actor)
	endif
	PAF_MainQuest.ApplyFacialExpressions(a_actor, 10)
	Wait(5)
	PAF_MainQuest.UnequipTinke(a_actor)
	StopPeeSound()
	Wait(1.5)
	PAF_MainQuest.PlayPeeIdleStop(a_actor, style, false)
	PAF_MainQuest.ClearFacialExpressions(a_actor)
	PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) + " feels relieved")
	Debug.SendAnimationEvent(a_actor, "SOSFlaccid")
	a_actor.RemoveFromFaction(PAF_MainQuest.SexLab.AnimatingFaction)
	return result
endfunction

function PeeVirtual(Actor a_actor)
	int i = IsTrackedActor(a_actor)
	if (i == -1)
		return
	endif
	NPC_last_pee[i] = Utility.GetCurrentGameTime();
	;PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) + " peed somewhere")
endfunction

function PoopVirtual(Actor a_actor)
	int i = IsTrackedActor(a_actor)
	if (i == -1)
		return
	endif
	NPC_last_poop[i] = Utility.GetCurrentGameTime();
	;PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) + " pooped somewhere")
endfunction

int function PeeAsync(Actor a_actor, bool peeOnly = false)
	int i = IsTrackedActor(a_actor)
	if (i == -1)
		return -1
	endif
	if (WaitLockedActors() == -1)
		PAF_MainQuest.DisplayMessage("Actors are busy")
	endif
	Pee(a_actor, peeOnly)
	_lock_actors = false
	return 1
endfunction

int function PoopAsync(Actor a_actor)
	int i = IsTrackedActor(a_actor)
	if (i == -1)
		return - 1
	endif
	if (WaitLockedActors() == -1)
		PAF_MainQuest.DisplayMessage("Actors are busy")
	endif
	PoopSensual(a_actor)
	_lock_actors = false
	return 1
endfunction

function Leak(Actor a_actor)
	int i = IsTrackedActor(a_actor)
	if (i == -1)
		return
	endif
	if (PAF_MainQuest.HasDiaper(a_actor))
		PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) +" leaks in " + GetNPCPronoun(a_actor) + " diaper")
	else
		PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) +" is leaking!")
	endif
	PAF_MainQuest.EquipTinke(a_actor)
	StartPeeSound(a_actor)
	Wait(10)
	PAF_MainQuest.UnequipTinke(a_actor)
	StopPeeSound()
	NPC_last_pee[i] = Utility.GetCurrentGameTime()
	PAF_MainQuest.IncreaseDirtState(a_actor, true, true)
	PAF_MainQuest.ApplyDirtOverlay(a_actor, NPC_DirtState[i])
endfunction

int function PoopPanty(Actor a_actor)
	int i = IsTrackedActor(a_actor)
	if (i == -1)
		return -1
	endif
	int result = poop(a_actor, dirty = true)
	if (result == 0)
		PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) + " needed to evacuate " +  GetNPCReflexivePronoun(a_actor))
	endif
	NPC_last_poop[i] = Utility.GetCurrentGameTime()
	return result
endfunction

int function LeakAndPoop(Actor a_actor)
	int i = IsTrackedActor(a_actor)
	if (i == -1)
		return -1
	endif
	if (PAF_MainQuest.HasDiaper(a_actor))
		PAF_MainQuest.DisplayMessage(GetNPCName(a_actor)+ " pees in " + GetNPCPronoun(a_actor) + " diaper")
	else
		PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) +" is leaking")
	endif
	PAF_MainQuest.ApplyFacialExpressions(a_actor, 12)
	PAF_MainQuest.EquipTinke(a_actor, leak = true)
	StartPeeSound(a_actor)
	Wait(2)
	PAF_MainQuest.PlacePuddle(a_actor, 0, 0, 1)
	Wait(2)
	if (poop(a_actor, dirty = true) == 0)
		PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) + " had to release the content of " + GetNPCPronoun(a_actor) +" bowels")
		NPC_last_poop[i] = Utility.GetCurrentGameTime()
	endif
	PAF_MainQuest.PlacePuddle(a_actor, 0, 0, 1)
	Wait(5)
	PAF_MainQuest.PlacePuddle(a_actor, 0, 0, 1)
	Wait(5)
	PAF_MainQuest.UnequipTinke(a_actor, leak = true)
	StopPeeSound()
	PAF_MainQuest.ClearFacialExpressions(a_actor)
	NPC_last_pee[i] = Utility.GetCurrentGameTime()
	return 0
endfunction

function UseToilet(Actor a_actor, bool createPoop = false)
	int i = IsTrackedActor(a_actor)
	if (i == -1)
		return
	endif

	bool pee = NPC_PeeState[i] > 0
	bool poop = NPC_PoopState[i] > 0 && !PAF_MainQuest.PAF_MCMQuest.PAF_Disable_Fart
	Form[] equipment

	if (pee || poop)
		equipment = PAF_MainQuest.StripActor(a_actor, false)
	endif
	if (pee)
		PAF_MainQuest.EquipTinke(a_actor)
		StartPeeSound(a_actor)
		PAF_MainQuest.PlacePuddle(a_actor, 0, 0, 3)
		Wait(10)
	endif
	if (PAF_DDQuest.IsAnalPlugged(a_actor))
			PAF_MainQuest.DisplayMessage("An anal plug prevents " + GetNPCName(a_actor) + " from pooping...")
		poop = false
	endif
	if (PAF_DDQuest.HasDeviousBelt(a_actor))
		PAF_MainQuest.DisplayMessage("A devious mechanism prevents " + GetNPCName(a_actor) + " from pooping...")
		poop = false
	endif
	int result = -1
	if (poop)
		result = poop(a_actor, createPoop)
	endif
	if (pee)
		PAF_MainQuest.UnequipTinke(a_actor)
		StopPeeSound()
		NPC_last_pee[i] = Utility.GetCurrentGameTime()
	endif
	if (result == 0)
		UseToiletPaper(a_actor)
	endif
	if (pee || poop)
		PAF_MainQuest.UnstripActor(a_actor, equipment)
		PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) +" relieved " + GetNPCReflexivePronoun(a_actor))
	endif
endfunction

int function poop(Actor a_actor, bool createPoop = true, bool dirty = false)
	int i = IsTrackedActor(a_actor)
	if (i == -1)
		return -1
	endif
	if (NPC_PoopState[i] > 0 && !PAF_MainQuest.PAF_MCMQuest.PAF_Disable_Fart)
		if (PAF_DDQuest.IsAnalPlugged(a_actor))
			PAF_MainQuest.DisplayMessage("An anal plug prevents " + GetNPCName(a_actor) + " from pooping...")
			return -1
		endif
		if (PAF_DDQuest.HasDeviousBelt(a_actor))
			PAF_MainQuest.DisplayMessage("A devious mechanism prevents " + GetNPCName(a_actor) + " from pooping...")
			return -1
		endif
		if (PAF_MainQuest.HasDiaper(a_actor))
			PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) + " poops in " + GetNPCPronoun(a_actor) + " diaper")
		else
			;PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) + "s anal muscles relax...")
		endif
		int j = 0
		int len = 4
		while j < len
			if (!PAF_MainQuest.HasDiaper(a_actor) && createPoop)
				a_actor.PlaceAtme(PAF_MainQuest.PAF_PoopPotion).moveToNode(a_actor, "SkirtBBone02")
			else
				PAF_MainQuest.ScaleButtStage(a_actor, j)
			endif
			PAF_MainQuest.PlayPoopSound(a_actor)
			if (!dirty)
				if (j == 0)
					PAF_MainQuest.IncreaseDirtState(PAF_TrackedActors[i], false, true)
				endif
			else
				if (j < 3)
					PAF_MainQuest.IncreaseDirtState(PAF_TrackedActors[i], false, true)
				endif
			endif
			Utility.Wait(Utility.RandomInt(2, 3))
			j += 1
		endWhile
		NPC_last_poop[i] = Utility.GetCurrentGameTime()
		if (PAF_MainQuest.HasDiaper(a_actor) && NPC_DiaperState[i] == 0)
			NPC_DiaperState[i] = 1
		endif
	endif
	return 0
endfunction

int function PoopSensual(Actor a_actor)
	int result = -1
	if (PAF_MainQuest.SexLab.GetGender(a_actor) == 0)
		result = PoopAnimatedMale(a_actor)
	else
		result = PoopAnimatedFemale(a_actor)
	endif
	return result
endFunction

int function PoopAnimatedFemale(Actor a_actor)
	if (!PAF_MainQuest.PAF_MCMQuest.PAF_Disable_Fart)
		int i = IsTrackedActor(a_actor)
		if (i == -1)
			return -1
		endif
		if (NPC_PoopState[i] > 0)
			if (PAF_MainQuest.PAF_DDQuest.HasArmbinder(a_actor))
				PAF_MainQuest.DisplayMessage("An armbinder prevents " + GetNPCName(a_actor) + " from stripping...")
				return PoopPanty(a_actor)
			endif
			int style = PAF_MainQuest.GetRandomAnimation(PAF_MainQuest.PAF_MCMQuest.PAF_AnimationPoop_F)
			Form[] equipment = PAF_MainQuest.StripActor(a_actor)
			Wait(3)
			PAF_MainQuest.PlayPeeIdleStart(a_actor, style, true)
			Wait(5)
			int result = Poop(a_actor)
			Wait(5)
			PAF_MainQuest.PlayPeeIdleStop(a_actor, style, true)
			if (result == 0)
				UseToiletPaper(a_actor)
			endif
			PAF_MainQuest.UnstripActor(a_actor, equipment)
			return result
		else
			PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) + " does not have to poop")
		endif
	endif
	return -1
endfunction

int function PoopAnimatedMale(Actor a_actor)
	if (!PAF_MainQuest.PAF_MCMQuest.PAF_Disable_Fart)
		int i = IsTrackedActor(a_actor)
		if (i == -1)
			return -1
		endif
		if (NPC_PoopState[i] > 0)
			if (PAF_MainQuest.PAF_DDQuest.HasArmbinder(a_actor))
				PAF_MainQuest.DisplayMessage("An armbinder prevents " + GetNPCName(a_actor) + " from stripping...")
				return PoopPanty(a_actor)
			endif
			int style = PAF_MainQuest.GetRandomAnimation(PAF_MainQuest.PAF_MCMQuest.PAF_AnimationPoop_M)
			Form[] equipment = PAF_MainQuest.StripActor(a_actor)
			Wait(3)
			PAF_MainQuest.PlayPeeIdleStart(a_actor, style, false)
			Wait(5)
			int result = Poop(a_actor)
			Wait(5)
			PAF_MainQuest.PlayPeeIdleStop(a_actor, style, false)
			if (result == 0)
				UseToiletPaper(a_actor)
			endif
			PAF_MainQuest.UnstripActor(a_actor, equipment)
			return result
		else
			PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) + " does not have to poop")
		endif
	endif
	return -1
endfunction

; ###################### Dirt ###############################

function UseToiletPaper(Actor a_actor)
	int i = IsTrackedActor(a_actor)
	if (i == -1)
		return
	endif
	if (PAF_MainQuest.HasDiaper(a_actor))
		PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) + " is weaing a diaper. No way to clean " + GetNPCReflexivePronoun(a_actor))
		return
	endif
	if (PAF_DDQuest.HasArmbinder(a_actor))
		PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) + " arms are locked and cannot use toilet paper")
		return
	endif
	if (PAF_MainQuest.HasToiletPaper(a_actor))
		PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) + " cleaned " + GetNPCReflexivePronoun(a_actor) + " with some toilet paper")
		PAF_MainQuest.Bathe(a_actor)
		PAF_MainQuest.RemoveToiletPaper(a_actor)
	else
		PAF_MainQuest.DisplayMessage(GetNPCName(a_actor) + " has no toilet paper")
	endif
endfunction

; #################### Sound ################################

function PlayPoopSound(Actor a_actor)
	if (PAF_MainQuest.PAF_MCMQuest.PAF_PlayMoaningSounds)
		if (a_actor.GetActorBase().GetSex() == 0)
			PAF_MainQuest.zbfSoundGagMale01.Play(a_actor)
		else
			PAF_MainQuest.zbfSoundGagFrustrated.Play(a_actor)
		endif
	endif
	Wait(0.3)
	PAF_MainQuest.PAF_FartSoundMarker.Play(a_actor)
endFunction

int soundID
function StartPeeSound(Actor a_actor)
	if (soundID != 0)
		Sound.StopInstance(soundID)
	endif
	soundID = PAF_MainQuest.AMBWaterfallSplatterLarge.play(a_actor)
endFunction

function StopPeeSound()
	if (soundID != 0)
		Sound.StopInstance(soundID)
	endif
	soundid = 0
endfunction

