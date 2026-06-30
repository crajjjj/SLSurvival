Scriptname _SLS_SenseArousalAlias extends ReferenceAlias  

Event OnInit()
	ObjectReference ObjRef = Self.GetReference()
	If ObjRef
		Actor ActorRef = ObjRef as Actor
		Int Arousal
		If ActorRef.GetFactionRank(SenseArousal.SlAroused.sla_Arousal) < 0 ; never seeded by SLA: give it a starting value
			Arousal = SenseArousal.SlAroused.SeedArousal(ActorRef, Utility.RandomInt(0, 100))
			;SenseArousal.SlStats.SeedActor(ActorRef) ; Seeding SL Stats doesn't do what I want - init arousal
		Else
			Arousal = SenseArousal.SlAroused.GetActorArousal(ActorRef) ; actual live arousal, not the faction rank
		EndIf
		ShaderUsed = StorageUtil.FormListGet(None, "_SLS_EffectShaderPercentiles", GetIndexForPercentile(Arousal)) as EffectShader
		If ShaderUsed
			ShaderUsed.Play(ObjRef)
		Else
			Debug.Trace("_SLS_: _SLS_SenseArousalAlias: OnInit(): Invalid shader for: " + GetIndexForPercentile(Arousal))
		EndIf
	EndIf
EndEvent

Int Function GetIndexForPercentile(Float Percent)
	If Percent >= 100.0
		Return 10
	Else
		Return PapyrusUtil.ClampInt(Math.Floor(Percent / 10.0), 0, 9)
	EndIf
EndFunction

Function Shutdown()
	If ShaderUsed
		ShaderUsed.Stop(Self.GetReference())
	Else
		Debug.Trace("_SLS_: _SLS_SenseArousalAlias: Shutdown(): Invalid shader")
	EndIf
EndFunction

EffectShader ShaderUsed

_SLS_SenseArousal Property SenseArousal Auto
