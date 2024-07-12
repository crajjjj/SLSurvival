Scriptname sslEffectCircleOfIntimacy extends ActiveMagicEffect


Package[] property SexLabKeepDistanceFrom auto

Actor Target

event OnEffectStart(Actor TargetRef, Actor CasterRef)
	Target = TargetRef
	If Target && Target.IsEnabled() && !Target.IsDead()
		int i = SexLabKeepDistanceFrom.Length
		While i
			i -= 1
			ActorUtil.AddPackageOverride(Target, SexLabKeepDistanceFrom[i], 65, 1)
		EndWhile
		Target.EvaluatePackage()
	endIf
endEvent

event OnEffectFinish(Actor TargetRef, Actor CasterRef)
	If Target
		int i = SexLabKeepDistanceFrom.Length
		While i
			i -= 1
			ActorUtil.RemovePackageOverride(Target, SexLabKeepDistanceFrom[i])
		EndWhile
		Target.EvaluatePackage()
	endIf
endEvent

;/-----------------------------------------------\;
;|	Debug Utility Functions                      |;
;\-----------------------------------------------/;

function Log(string log)
	; Debug.Notification(log)
	Debug.Trace(log)
	Debug.TraceUser("SexLabDebug", log)
	SexLabUtil.PrintConsole(log)
endfunction
