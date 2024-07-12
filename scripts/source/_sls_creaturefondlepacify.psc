Scriptname _SLS_CreatureFondlePacify extends Quest  

Event OnInit()
	If Self.IsRunning()
		RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
	EndIf
EndEvent

Event OnAnimationEnd(int tid, bool HasPlayer)
	If HasPlayer
		_SLS_FondlePacifySpell.SetNthEffectDuration(0, 10 + Util.CreatureFondleCount as Int)
		Actor[] actorList = SexLab.HookActors(tid as string)
		Int i = actorList.Length
		Actor akTarget
		While i > 0
			i -= 1
			akTarget = actorList[i]
			If akTarget && akTarget != PlayerRef
				_SLS_FondlePacifySpell.Cast(akTarget, akTarget)
			EndIf
		EndWhile
		Self.Stop()
	EndIf
EndEvent

Spell Property _SLS_FondlePacifySpell Auto

Actor Property PlayerRef Auto

SLS_Utility Property Util Auto
SexlabFramework Property Sexlab Auto