Scriptname _SLS_InflatePotion extends Quest  

Event OnInit()
	If Self.IsRunning()
		;Util.SlifScale(PlayerRef, NodeName = "slif_butt", ScaleAmount = 2.3, ModNameAppend = "")
		;Util.SlifScale(PlayerRef, NodeName = "slif_breast", ScaleAmount = 3.3, ModNameAppend = "")
		;Util.SlifScale(PlayerRef, NodeName = "slif_belly", ScaleAmount = 5.5, ModNameAppend = "")

		;Util.SlifScale(PlayerRef, NodeName = "NippleSize", ScaleAmount = 10.0, ModNameAppend = "")
		;Util.SlifScale(PlayerRef, NodeName = "slif_thigh", ScaleAmount = 1.5, ModNameAppend = "")
		;Util.SlifScale(PlayerRef, NodeName = "slif_calf", ScaleAmount = 1.5, ModNameAppend = "")
		LastScale = -1.0
		;_SLS_InflatePotionScale.SetValue(0.0)
		BeginTime = Utility.GetCurrentGameTime()
		Debug.Notification("There's a small tingling all over my body that quickly subsides")
		RegisterForSingleUpdateGameTime(1.0) ; Begin effect 1 hour after consumption
	EndIf
EndEvent

Event OnUpdateGameTime()
	;If LastScale == -1.0
	;	Debug.Messagebox("BEGIN")
	;EndIf

	Float x = (Utility.GetCurrentGameTime() - BeginTime) * 24.0
	Float y = 7.895093 * Math.Pow(2.71828, -(Math.Pow(x - 22.07231, 2)) / 93.8692231629) ; https://www.desmos.com/calculator/x7f5sajaj4

	;/
	Int i = 0
	While i < 48
		Debug.Trace("_SLS_: Graph: x: " + i + ". y: " + 7.895093 * Math.Pow(2.71828, -(Math.Pow(i - 22.07231, 2)) / 93.8692231629))
		i += 1
	EndWhile
/;

	Float ScaleMod = PapyrusUtil.ClampFloat(y, 0.0, 1.0)
	;_SLS_InflatePotionScale.SetValue(ScaleMod)
	If ScaleMod != LastScale		
		Slif.Inflate(PlayerRef, ModNameAppend = " Inflate", Node = "slif_butt", ScaleAmount = ScaleMod * Slif.ScaleMaxAss)
		Slif.Inflate(PlayerRef, ModNameAppend = " Inflate", Node = "slif_belly", ScaleAmount = ScaleMod * Slif.ScaleMaxBelly)
		
		Slif.Morph(PlayerRef, ModNameAppend = " Inflate", MorphName = "BreastsFantasy", Value = 0.3 * (ScaleMod * Slif.ScaleMaxBreasts))
		Slif.Morph(PlayerRef, ModNameAppend = " Inflate", MorphName = "BreastsSmall", Value = 0.3 * -(ScaleMod * Slif.ScaleMaxBreasts))
		Slif.Morph(PlayerRef, ModNameAppend = " Inflate", MorphName = "BreastPerkiness", Value = 0.3 * (ScaleMod * Slif.ScaleMaxBreasts) * 0.25)
		Slif.Morph(PlayerRef, ModNameAppend = " Inflate", MorphName = "NippleLength", Value = 0.25 * (ScaleMod * Slif.ScaleMaxBreasts) * 0.5)
		Slif.Morph(PlayerRef, ModNameAppend = " Inflate", MorphName = "BreastsSSH", Value = 0.3 * (ScaleMod * Slif.ScaleMaxBreasts) * 0.75)
		Slif.Morph(PlayerRef, ModNameAppend = " Inflate", MorphName = "DoubleMelon", Value = 0.3 * (ScaleMod * Slif.ScaleMaxBreasts) * 0.25)

		Debug.Trace("_SLS_: _SLS_InflatePotion: ScaleMod: " + ScaleMod)
	EndIf
	
	If ScaleMod < 0.06
		StopEffect()
	Else
		If LastScale == ScaleMod ; Slow change
			LastScale = ScaleMod
			;Debug.Messagebox("Slow change")				
			RegisterForSingleUpdateGameTime(1.0)
		Else ; rapid change
			LastScale = ScaleMod
			;Debug.Messagebox("Fast change")
			RegisterForSingleUpdateGameTime(0.10)
		EndIf
	EndIf
EndEvent

Function StopEffect()
	;Debug.Messagebox("Stop")	
	Slif.UnRegisterActor(PlayerRef, ModNameAppend = " Inflate")
	Self.Stop()
EndFunction

Float BeginTime
Float LastScale

;Float Property ScaleMaxAss = 2.3 Auto Hidden
;Float Property ScaleMaxBreasts = 3.3 Auto Hidden
;Float Property ScaleMaxBelly = 5.5 Auto Hidden

Actor Property PlayerRef Auto

;GlobalVariable Property _SLS_InflatePotionScale Auto

SLS_Utility Property Util Auto
_SLS_InterfaceSlif Property Slif Auto
