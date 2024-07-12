Scriptname _SLS_BodyInflationTracking extends Quest  

Event OnInit()
	If Self.IsRunning()
		;RegisterForModEvent("HookStageStart", "OnStageStart")
		RegisterForEvents()
		SetInflationVar()
		RegisterForSingleUpdateGameTime(1.0)
	EndIf
EndEvent

Function RegisterForEvents()
	UnRegisterForAllModEvents()
	RegisterForModEvent("HookAnimationStarting", "OnAnimationStarting")
EndFunction

Event OnUpdateGameTime()
	Utility.Wait(2.0) ; Wait to let inflate potion do it's thing first on long waits.
	SetInflationVar()
	RegisterForSingleUpdateGameTime(1.0)
EndEvent

Function SetInflationVar()
	; Use whichever breast scaling is bigger, inflate or morph
	Float BreastInflateVar = Slif.GetTotalInflateValue(PlayerRef, "slif_breast") - 1.0
	;Float BreastMorphVar =  (Slif.GetTotalMorphValue(PlayerRef, "BreastsFantasy") / 0.3) * Slif.ScaleMaxBreasts ; / 0.3 => because inflate scale is multiplied by 0.3 in _SLS_InflatePotion when using morphs instead of inflate
	Float BreastMorphVar =  (StorageUtil.GetFloatValue(PlayerRef, "slif_" + "BreastsFantasy") / 0.3) ; / 0.3 => because inflate scale is multiplied by 0.3 in _SLS_InflatePotion when using morphs instead of inflate
	If BreastMorphVar > BreastInflateVar
		BreastInflateVar = BreastMorphVar
	EndIf
	_SLS_BodyInflationScale.SetValue(((BreastInflateVar/Slif.ScaleMaxBreasts) * 0.3333) + \
	((Slif.GetTotalInflateValue(PlayerRef, "slif_belly") / Slif.ScaleMaxBelly) * 0.3333) + \
	((Slif.GetTotalInflateValue(PlayerRef, "slif_butt") / Slif.ScaleMaxAss) * 0.3333))
	
	;/
	Debug.Messagebox("Inflate: " + Slif.GetTotalInflateValue(PlayerRef, "slif_breast") + \
	"\nMorph: " + StorageUtil.GetFloatValue(PlayerRef, "slif_" + "BreastsFantasy") + \	
	"\nStUtil: " + StorageUtil.GetFloatValue(PlayerRef, "slif_" + "BreastsFantasy") + \
	"\n\nBreast: " + ((BreastInflateVar/Slif.ScaleMaxBreasts) * 0.3333) + \
	"\nBelly: " + ((Slif.GetTotalInflateValue(PlayerRef, "slif_belly") / Slif.ScaleMaxBelly) * 0.3333) + \
	"\nAss: " + ((Slif.GetTotalInflateValue(PlayerRef, "slif_butt") / Slif.ScaleMaxAss) * 0.3333))
	/;
	
	Debug.Trace("_SLS_: Inflate: " + Slif.GetTotalInflateValue(PlayerRef, "slif_breast") + \
	". Morph: " + StorageUtil.GetFloatValue(PlayerRef, "slif_" + "BreastsFantasy") + \	
	". StUtil: " + StorageUtil.GetFloatValue(PlayerRef, "slif_" + "BreastsFantasy") + \
	". Breast: " + ((BreastInflateVar/Slif.ScaleMaxBreasts) * 0.3333) + \
	". Belly: " + ((Slif.GetTotalInflateValue(PlayerRef, "slif_belly") / Slif.ScaleMaxBelly) * 0.3333) + \
	". Ass: " + ((Slif.GetTotalInflateValue(PlayerRef, "slif_butt") / Slif.ScaleMaxAss) * 0.3333))
EndFunction

Event OnAnimationStarting(int tid, bool HasPlayer)
	If HasPlayer && _SLS_BodyInflationScale.GetValue() >= 0.3
		SexActors = SexLab.GetController(tid).Positions
		If SexActors.Length > 1
			RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
			RegisterForModEvent("HookStageStart", "OnStageStart")
			IsCreatureSex = Sexlab.CreatureCount(SexActors) as Bool
			If SexActors.Length == 2
				Int i = 0
				While i < SexActors.Length
					If SexActors[i] != PlayerRef
						Debug.Notification(SexActors[i].GetLeveledActorBase().GetName() + " is going to enjoy your jiggling")
						Return
					EndIf
					i += 1
				EndWhile
			Else
				Debug.Notification("They are going to enjoy your jiggling")
			EndIf
		EndIf
	EndIf
EndEvent

Event OnStageStart(int tid, bool HasPlayer)
	Utility.Wait(1.5)
	If HasPlayer
		Float Jigglyness = _SLS_BodyInflationScale.GetValue()
		Int i = 0
		If DoImod
			Game.ShakeCamera(akSource = None, afStrength = 0.2, afDuration = 1.5)
			_SLS_JigglesImod.Apply()
		EndIf
		;Debug.Messagebox(SexLab.GetController(tid).Stage)
		While i < SexActors.Length
			If SexActors[i] != PlayerRef
				Slso.ModEnjoyment(tid, SexActors[i], Enjoyment = (Jigglyness * 6) as Int)
				If !IsCreatureSex
					Sexlab.GetVoice(ActorRef = SexActors[i]).Moan(SexActors[i], Strength = (Jigglyness * 100) as Int, IsVictim = false)
				EndIf
				;Debug.Notification(ActorList[i].GetLeveledActorBase().GetName() + " is enjoying your jiggling")
			EndIf
			i += 1
		EndWhile
		Debug.Trace("_SLS_: Jiggles Bonus Enjoyment: " + ((Jigglyness * 6) as Int))
	EndIf
EndEvent

Event OnAnimationEnd(int tid, bool HasPlayer)
	If HasPlayer
		UnRegisterForModEvent("HookAnimationEnd")
		UnRegisterForModEvent("HookStageStart")
	EndIf
EndEvent

Function ToggleJiggles(Bool DoEnable)
	If DoEnable
		RegisterForEvents()
		PlayerRef.AddSpell(Game.GetFormFromFile(0x0CF9B0, "SL Survival.esp") as Spell)
	Else
		UnRegisterForModEvent("HookAnimationStarting")
		UnRegisterForModEvent("HookAnimationEnd")
		UnRegisterForModEvent("HookStageStart")
		PlayerRef.RemoveSpell(Game.GetFormFromFile(0x0CF9B0, "SL Survival.esp") as Spell)
	EndIf
EndFunction

Bool Property DoImod = true Auto Hidden
Bool IsCreatureSex

Actor[] SexActors

Actor Property PlayerRef Auto

GlobalVariable Property _SLS_BodyInflationScale Auto

ImageSpaceModifier Property _SLS_JigglesImod Auto

_SLS_InterfaceSlso Property Slso Auto
SexLabFramework Property Sexlab Auto
_SLS_InterfaceSlif Property Slif Auto
