Scriptname _SLS_PushActionCooloff extends ReferenceAlias  

Event OnInit()
	If Self.GetOwningQuest().IsRunning()
		RegisterForModEvent("HookAnimationEnding", "OnAnimationEnding")
		RegisterForModEvent("_SLS_PlayerCombatChange", "On_SLS_PlayerCombatChange")
		_SLS_PushActionCooloffVar.SetValueInt(0)
	EndIf
EndEvent

Event OnAnimationEnding(int tid, bool HasPlayer)
	If HasPlayer
		BeginTimeout()
	EndIf
EndEvent

Event On_SLS_PlayerCombatChange(Bool InCombat)
	BeginTimeout()
EndEvent

Event OnEnterBleedout()
	BeginTimeout()
EndEvent

Function BeginTimeout()
	_SLS_PushActionCooloffVar.SetValueInt(1)
	;Debug.Messagebox("Begin push action cooloff")
	RegisterForSingleUpdate(60.0)
EndFunction

Event OnUpdate()
	;Debug.Messagebox("End push action cooloff")
	_SLS_PushActionCooloffVar.SetValueInt(0)
EndEvent

GlobalVariable Property _SLS_PushActionCooloffVar Auto
