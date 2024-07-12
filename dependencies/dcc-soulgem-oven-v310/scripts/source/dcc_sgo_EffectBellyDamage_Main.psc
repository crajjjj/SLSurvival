Scriptname dcc_sgo_EffectBellyDamage_Main extends ActiveMagicEffect

dcc_sgo_QuestController Property SGO Auto
Actor Property Who Auto

Event OnEffectStart(Actor Target, Actor From)
	self.Who = Target
	Return
EndEvent

Event OnHit(ObjectReference Who, Form What, Projectile Bullet, Bool Power, Bool Sneak, Bool Bash, Bool Blocked)
{handle the breaking down of gems when you get hit.}

	;; if you blocked the attack then that is what we call being pro.

	If(Blocked)
		Return
	EndIf

	;;;;;;;;
	;;;;;;;;

	;; determine what type of attack this was and the chance that it may have
	;; broken a gem.

	Float Chance = SGO.OptBellyDamageChance
	Float Damage = SGO.OptBellyDamageMax

	If(Power || Bash)
		Chance = SGO.OptBellyDamageChancePower
		Damage = SGO.OptBellyDamageMaxPower
	EndIf

	;;;;;;;;
	;;;;;;;;

	;; so will it blend?

	If(Utility.RandomInt(1,100) > Chance)
		Return
	EndIf

	;;;;;;;;
	;;;;;;;;

	;; ding a random gem for a random value.

	SGO.Print("A gem within " + self.Who.GetDisplayName() + " has been damaged.")
	SGO.ActorGemAdjustValue(self.Who, Utility.RandomInt(0,(SGO.ActorGemGetCount(self.Who) - 1)), (Utility.RandomFloat(0.0,Damage) * -1))

	Return
EndEvent
