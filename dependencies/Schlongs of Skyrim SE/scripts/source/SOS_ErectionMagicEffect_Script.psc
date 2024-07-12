Scriptname SOS_ErectionMagicEffect_Script extends ActiveMagicEffect  

;----------PROPERTIES----------
SOS_Config Property config Auto
SOS_SetupQuest_Script Property SOS_Quest Auto

FormList Property SOS_ConcealingArmors Auto         ; DEPRECATED
Spell Property SOS_ErectionSpell Auto
Spell Property SOS_ErectionExaustionSpell Auto
Keyword Property SOS_Genitals Auto
Keyword Property SOS_Merchant Auto

;----------ARMOR PROPERTIES----------
; (actually those don't need to be properties, should probably be changed)
Armor Property SOSEquipped Auto
Armor Property HeadEquipped Auto
Armor Property RevealingBodyEquipped Auto
Armor Property ConcealingBodyEquipped Auto
Armor Property HandsEquipped Auto
Armor Property AmuletEquipped Auto
Armor Property RingEquipped Auto
Armor Property FeetEquipped Auto
Armor Property ShieldEquipped Auto
Armor Property CircletEquipped Auto
Weapon Property LeftEquipped Auto
Weapon Property RightEquipped Auto

;----------MISC PROPERTIES------------
Actor Property ActorRef Auto
int iUndressDepth

;----------EVENTS----------

Event OnEffectStart(Actor akTarget, Actor akCaster)

	ActorRef = akTarget
	SOSEquipped = akTarget.GetWornForm(0x00400000) as Armor ; 52 or (32 + 52)
	HeadEquipped = akTarget.GetWornForm(0x00000001) as Armor
	RevealingBodyEquipped = akTarget.GetWornForm(0x00000004) as Armor ; 32 or (32 + 52)
	ConcealingBodyEquipped = akTarget.GetWornForm(0x00400004) as Armor ; 32 + 52: vanilla body armors and custom armors marked as concealing
	HandsEquipped = akTarget.GetWornForm(0x00000008) as Armor
	AmuletEquipped = akTarget.GetWornForm(0x00000020) as Armor
	RingEquipped = akTarget.GetWornForm(0x00000040) as Armor
	FeetEquipped = akTarget.GetWornForm(0x00000080) as Armor
	CircletEquipped = akTarget.GetWornForm(0x00001000) as Armor
	ShieldEquipped = akTarget.GetWornForm(0x00000200) as Armor
	LeftEquipped = akTarget.GetEquippedWeapon(true) as Weapon
	RightEquipped = akTarget.GetEquippedWeapon() as Weapon
	
	iUndressDepth = Utility.RandomInt(1,5)
	
	if ConcealingBodyEquipped
		Debug.Trace("erection effect will unequip " + akTarget.GetLeveledActorBase().GetName() + " to depth " + iUndressDepth)
		if(iUndressDepth == 5)
			akTarget.UnequipAll()
		else
			SafeUnequipItem(akTarget, ConcealingBodyEquipped, 0)
			SafeUnequipItem(akTarget, LeftEquipped, 0)
			SafeUnequipItem(akTarget, RightEquipped, 0)
			SafeUnequipItem(akTarget, ShieldEquipped, 0)
			SafeUnequipItem(akTarget, HeadEquipped, 1)
			SafeUnequipItem(akTarget, CircletEquipped, 1)
			SafeUnequipItem(akTarget, HandsEquipped, 2)
			SafeUnequipItem(akTarget, AmuletEquipped, 3)
			SafeUnequipItem(akTarget, RingEquipped, 3)
			SafeUnequipItem(akTarget, FeetEquipped, 4)
		endif
	endif

	if(SOSEquipped && !SOSEquipped.HasKeyword(SOS_Genitals))
		; SOSEquipped = just slot 52 or (32 + 52) vanilla body armors and concealing armors
		akTarget.UnequipItem(SOSEquipped, false, true)
	endif
	
	akTarget.DispelSpell(SOS_ErectionExaustionSpell)

	Utility.Wait(3)
	Debug.SendAnimationEvent(akTarget, "SOSSlowErect")

EndEvent

Event OnEffectFinish(Actor akTarget, Actor akCaster)

	Debug.SendAnimationEvent(akTarget, "SOSFlaccid")
	Utility.Wait(15)

	if(!akTarget.IsDead())
		if(SOSEquipped && !SOSEquipped.HasKeyword(SOS_Genitals))
			; SOSEquipped = just slot 52 or (32 + 52) vanilla body armors and concealing armors
			akTarget.EquipItem(SOSEquipped, false, true)
		endIf

		if ConcealingBodyEquipped
			Debug.Trace("erection effect is over and will re-equip " + akTarget.GetLeveledActorBase().GetName() + " from depth " + iUndressDepth)
			SafeEquipItem(akTarget, ConcealingBodyEquipped, 0)
			SafeEquipItem(akTarget, LeftEquipped, 0)
			SafeEquipItem(akTarget, RightEquipped, 0)
			SafeEquipItem(akTarget, ShieldEquipped, 0)
			SafeEquipItem(akTarget, HeadEquipped, 1)
			SafeEquipItem(akTarget, CircletEquipped, 1)
			SafeEquipItem(akTarget, HandsEquipped, 2)
			SafeEquipItem(akTarget, AmuletEquipped, 3)
			SafeEquipItem(akTarget, RingEquipped, 3)
			SafeEquipItem(akTarget, FeetEquipped, 4)
			
		endIf

		if(akTarget.Is3DLoaded())
			akTarget.DispelSpell(SOS_ErectionSpell)	; maybe it could also work with a simple Dispel()
			if (!akTarget.GetLeveledActorBase().HasKeyword(SOS_Merchant))
				SOS_ErectionExaustionSpell.cast(akTarget, akTarget)
			endIf
		endif
	endif

EndEvent

Event OnDying(Actor akKiller)
	Dispel()
EndEvent

Function SafeUnequipItem(Actor akActor, Form akItem, int aiDepthLimit)
	if(akItem && iUndressDepth >= aiDepthLimit)
		akActor.UnequipItem(akItem, false, true)
	endif
EndFunction

Function SafeEquipItem(Actor akActor, Form akItem, int aiDepthLimit)
	if(akItem && iUndressDepth >= aiDepthLimit)
		akActor.EquipItem(akItem, false, true)
	endif
EndFunction
