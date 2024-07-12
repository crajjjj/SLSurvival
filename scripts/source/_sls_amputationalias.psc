Scriptname _SLS_AmputationAlias extends ReferenceAlias  

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	If abPowerAttack && !abHitBlocked && !abBashAttack
		If Amp.IsDismemberWeapon(akSource, akAggressor as Actor)
			Float DismemberActual
			Float PlayerArmor = PlayerRef.GetActorValue("DamageResist")
			If PlayerArmor > 0.0 ; Avoid divide by zero
				DismemberActual = (Menu.DismemberChance - ((PlayerArmor / 10.0) * Menu.DismemberArmorBonus))
			Else
				DismemberActual = Menu.DismemberChance
			EndIf
			If Utility.RandomFloat(0.0, 100.0) < DismemberActual
				GoToState("Off")
				RegisterForSingleUpdateGameTime(Menu.DismemberCooldown)
				Amp.PowerAttacked()
			EndIf
		EndIf
	EndIf
EndEvent

State Off
	Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	EndEvent
EndState

Event OnUpdateGameTime()
	GoToState("")
EndEvent

Actor Property PlayerRef Auto

_SLS_Amputation Property Amp Auto
SLS_Mcm Property Menu Auto
