Scriptname _SNShelterDetect extends ObjectReference  

_SNQuestScript Property _SNQuest Auto

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	_SNQuest.UnderShelter = False
	Utility.Wait(0.25)
	_SNQuest.UnderShelter = True
EndEvent