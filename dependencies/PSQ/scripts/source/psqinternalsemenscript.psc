Scriptname PSQInternalSemenScript Extends ActiveMagicEffect  

;仕様変更
;精液を体内に溜める
;溜まった精液を消化するパワーを付ける
;体内に排出するなんてとんでもない！

PlayerSuccubusQuestScript Property PSQ Auto
Import StorageUtil

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If PSQ.CumInflationIncrement < 5
		PSQ.CumInflationIncrement = 10
	EndIf
	
	Float SemenValue = PSQ.CumInflationValue
	Float Increment = PSQ.CumInflationIncrement
	
	While SemenValue > 0  && PSQ.PlayerRef.HasKeywordString("SexLabActive")
		;あまりに試行回数が多くなる場合は強制的に切る
		If SemenValue / Increment > 500
			Increment = SemenValue / 100
		EndIf
		If Increment > SemenValue
			Increment = SemenValue
		EndIf
		SetFloatValue(PSQ.PlayerRef, "PSQ_InternalSemen", GetFloatValue(PSQ.PlayerRef, "PSQ_InternalSemen") + Increment)
		PSQ.SetBellyScale()
		SemenValue -= Increment
	EndWhile
EndEvent
