ScriptName iDDeEffPowerPunchScr Extends ActiveMagicEffect  

iDDeMain Property iDDe Auto

Sound[] Property soPows Auto

GlobalVariable Property iDDePowArmSnd Auto
GlobalVariable Property iDDePowArmPow Auto

Actor Property PlayerRef Auto 

;Variables 

BOOL _bIsOn = False
BOOL _bBusyOnConD = False

;Events 
Event OnEffectStart(Actor Target, Actor Caster)	
	If (!_bBusyOnConD && Target && Target.Is3DLoaded() && !Target.IsDead())
		_bBusyOnConD = True
		INT iPowMax = (soPows.Length - 1)
		INT i = iDDePowArmSnd.GetValueInt()
			If ((i < 0) || (i > iPowMax))
				i = Utility.RandomInt(1, iPowMax)
			EndIf
			If (i && soPows[i])
				soPows[i].Play(Target)
			EndIf
		Caster.PushActorAway(Target, iDDePowArmPow.GetValueInt()) 
		_bBusyOnConD = False
	EndIf
EndEvent

Event OnAnimationEvent(ObjectReference akSource, string asEventName)
	
EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)
	
EndEvent	


