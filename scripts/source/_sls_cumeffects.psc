Scriptname _SLS_CumEffects extends ReferenceAlias  

Event OnInit()
	RegisterForModEvent("_SLS_PlayerSwallowedCum", "On_SLS_PlayerSwallowedCum")
EndEvent

Event On_SLS_PlayerSwallowedCum(Form akSource, Bool Swallowed, Float LoadSize, Float LoadSizeBase, Bool IsCumPotion)
	If Swallowed
		If akSource as Actor
			VoiceType CumVoice = (akSource as Actor).GetVoiceType()
			Int Index = _SLS_CumEffectVoices.Find(CumVoice)
			If Index > -1
				BeginEffect(akSource as Actor, _SLS_CumEffectSpells.GetAt(Index) as Spell)
			EndIf
		EndIf
	EndIf
EndEvent

Function BeginEffect(Actor CumActor, Spell CumSpell)
	Debug.Trace("_SLS_: Applying cum effect spell: " + CumSpell + " - " + CumSpell.GetName() + " from actor: " + CumActor + ", Race: " + CumActor.GetRace())
	;Utility.Wait(5.0)
	While InProc
		Utility.Wait(1.0)
	EndWhile
	InProc = true
	If !Menu.CumEffectsStack
		PlayerRef.DispelSpell(CumSpell)
	EndIf
	SaveEffects(CumSpell)
	SetEffects(CumSpell)
	Utility.Wait(1.0)
	CumSpell.Cast(PlayerRef, PlayerRef)
	ReloadEffects(CumSpell)
	InProc = false
EndFunction

Function SaveEffects(Spell CumSpell)
	MagicEffect CurEffect
	Int i = CumSpell.GetNumEffects()
	While i > 0
		i -= 1
		CurEffect = CumSpell.GetNthEffectMagicEffect(i)
		StorageUtil.SetFloatValue(CurEffect, "_SLS_CumEffectMag", CumSpell.GetNthEffectMagnitude(i))
		StorageUtil.SetIntValue(CurEffect, "_SLS_CumEffectDur", CumSpell.GetNthEffectDuration(i))
	EndWhile
EndFunction

Function SetEffects(Spell CumSpell)
	MagicEffect CurEffect
	Int i = CumSpell.GetNumEffects()
	While i > 0
		i -= 1
		;Debug.Messagebox("GetNthEffectMagnitude(i): " + CumSpell.GetNthEffectMagnitude(i) + ". Menu.CumEffectsMagMult: " + Menu.CumEffectsMagMult))
		CumSpell.SetNthEffectMagnitude(i, CumSpell.GetNthEffectMagnitude(i) * Menu.CumEffectsMagMult)
		CumSpell.SetNthEffectDuration(i, Math.Ceiling((CumSpell.GetNthEffectDuration(i) / TimeScale.GetValueInt()) * Menu.CumEffectsDurMult))
	EndWhile
EndFunction

Function ReloadEffects(Spell CumSpell)
	MagicEffect CurEffect
	Int i = CumSpell.GetNumEffects()
	While i > 0
		i -= 1
		CurEffect = CumSpell.GetNthEffectMagicEffect(i)
		CumSpell.SetNthEffectMagnitude(i, StorageUtil.GetFloatValue(CurEffect, "_SLS_CumEffectMag"))
		CumSpell.SetNthEffectDuration(i, StorageUtil.GetIntValue(CurEffect, "_SLS_CumEffectDur"))
		
		StorageUtil.UnSetFloatValue(CurEffect, "_SLS_CumEffectMag")
		StorageUtil.UnSetIntValue(CurEffect, "_SLS_CumEffectDur")
	EndWhile
EndFunction

Bool InProc = false

Formlist Property _SLS_CumEffectVoices Auto
Formlist Property _SLS_CumEffectSpells Auto

GlobalVariable Property TimeScale Auto

Actor Property PlayerRef Auto

SLS_Mcm Property Menu Auto
