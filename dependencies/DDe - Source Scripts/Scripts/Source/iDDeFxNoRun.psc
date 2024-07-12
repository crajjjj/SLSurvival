Scriptname iDDeFxNoRun Extends ActiveMagicEffect  

Import Utility

iDDeMain Property iDDe Auto

Actor Property PlayerRef Auto 
Actor _aSlave

Keyword[] _kwdRes

INT _i = 0
INT _iMax = 0
FLOAT _fDamSM = 0.0
BOOL _bRun = False

Event OnEffectStart(Actor Target, Actor Caster)	
	_aSlave = Target
		If (_aSlave && _aSlave.Is3DLoaded())
			_bRun = True
		Else
			_bRun = False
		EndIf
		If (_bRun)
			_kwdRes = NEW Keyword[3]
				_kwdRes[0] = iDDe.ZadLib.zad_DeviousBoots
				_kwdRes[1] = iDDe.ZadLib.zad_DeviousLegCuffs
				_kwdRes[2] = iDDe.ZadLib.zad_DeviousAnkleShackles
			_iMax = _kwdRes.Length
				If (_aSlave != PlayerRef)
					iDDe.ZadLib.RepopulateNpcs()
				EndIf
			iDDe.ZadLib.StartBoundEffects(akTarget = _aSlave)
			RegisterForSingleUpdate(iDDe.fDDeRefreshRate)
		EndIf
EndEvent

Event OnUpdate()
		If (_bRun && CanRun() && (HasKeywordWorn() || iDDe.iDDeIsAnimating(_aSlave))) 
			RegisterForSingleUpdate(iDDe.fDDeRefreshRate)
		Else
			iDDe.iDDeEqpMagicalAnkles(_aSlave, 0, 0)
			Self.Dispel()
			UnregisterForUpdate()
		EndIf
EndEvent

;Event OnCellLoad()
;		If (_bRun && CanRun() && (HasKeywordWorn() || iDDe.iDDeIsAnimating(_aSlave)))
;			Game.EnableFastTravel(False)
;		EndIf
;EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)
	iDDe.iDDeEqpMagicalAnkles(_aSlave, 0, 2)
	iDDe.ZadLib.StopBoundEffects(akTarget = _aSlave)
EndEvent		

BOOL Function HasKeywordWorn()
	_i = 0
		While (_i < _iMax)
			If (_aSlave.WornHasKeyword(_kwdRes[_i]))
				RETURN True
			EndIf
			_i += 1
		EndWhile
	RETURN False
EndFunction
BOOL Function CanRun()
	RETURN (StorageUtil.GetIntValue(_aSlave, "iDDeAnklesEff", 0) || \
					StorageUtil.GetIntValue(_aSlave, "iDDeAnklesEffBypass", 0))
EndFunction