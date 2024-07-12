Scriptname _SLS_SenseCumAlias extends ReferenceAlias  

Event OnInit()
	ObjectReference ObjRef = Self.GetReference()
	If ObjRef
		Float CumFullness
		If (ObjRef as Actor).GetLeveledActorBase().GetSex() == 0 ; Male
			CumFullness = SenseCum.Util.GetLoadFullnessMod(ObjRef as Actor) * 100.0
		Else
			CumFullness = SenseCum.Util.GetCumStuffedFactor(ObjRef as Actor) * 100.0
		EndIf
		
		ShaderUsed = StorageUtil.FormListGet(None, "_SLS_EffectShaderPercentiles", GetIndexForPercentile(CumFullness)) as EffectShader
		If ShaderUsed
			ShaderUsed.Play(ObjRef)
		Else
			Debug.Trace("_SLS_: _SLS_SenseCumAlias: OnInit(): Invalid shader for: " + GetIndexForPercentile(CumFullness))
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
		Debug.Trace("_SLS_: _SLS_SenseCumAlias: Shutdown(): Invalid shader")
	EndIf
EndFunction

EffectShader ShaderUsed

_SLS_SenseCum Property SenseCum Auto
