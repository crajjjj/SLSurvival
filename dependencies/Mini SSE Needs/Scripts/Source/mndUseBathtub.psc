Scriptname mndUseBathtub extends ObjectReference

mndController Property mnd Auto
Form[] Property clothes Auto
Sound Property mndShowerSound Auto
EffectShader Property mndWetShader Auto
Activator Property mndWater Auto

Event OnActivate(ObjectReference akActionRef)
	Actor PlayerRef = Game.getPlayer()
	int oldCameraState = 0
	; Stop the actor (lock AI if player)
	if akActionRef!=PlayerRef
		return
	endIf
	mnd.playingAnim(true)
	PlayerRef.evaluatePackage()
	PlayerRef.stopCombat()
	PlayerRef.SheatheWeapon()
	Form leftHand = PlayerRef.GetEquippedObject(0)
	if leftHand
		PlayerRef.UnequipItemEX(leftHand, 2, false)
	endIf
	Form rightHand = PlayerRef.GetEquippedObject(1)
	if rightHand
		PlayerRef.UnequipItemEX(rightHand, 1, false)
	endIf
	Utility.wait(0.1)
	Game.setPlayerAIDriven(true)
	oldCameraState = Game.getCameraState()
	; 3D camera if player
	if oldCameraState==0
		Game.forceThirdPerson()
	endIf
	PlayerRef.evaluatePackage()
	Utility.wait(0.1)
	Game.DisablePlayerControls(true, true, false, false, false, false, false, false, 0)

	; ((- Stripping
	clothes[2] = PlayerRef.GetWornForm(Armor.GetMaskForSlot(32))
	Form[] items
	
	if clothes[2] && (mnd.stripMode==0 || mnd.stripMode==1) ; Not animated
		int i = 44
		while i>30
			i-=1
			clothes[i - 30] = PlayerRef.GetWornForm(Armor.GetMaskForSlot(i))
			if clothes[i - 30]
				PlayerRef.UnequipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf clothes[2] && (mnd.stripMode==2 || mnd.stripMode==3) ; Animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		int i = 44
		while i>30
			i-=1
			clothes[i - 30] = PlayerRef.GetWornForm(Armor.GetMaskForSlot(i))
			if clothes[i - 30]
				PlayerRef.UnequipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf mnd.stripMode==4 || mnd.stripMode==5 ; SexLab not animated
		items = mnd.StripActor(false, true)
	elseIf mnd.stripMode==6 || mnd.stripMode==7 ; SexLab animated
		items = mnd.StripActor(true, true)
	endIf
	; -))
	
	; Put some water
	ObjectReference water = Self.PlaceAtme(mndWater)
	water.setPosition(Self.X, Self.Y, Self.Z - 30.0)
	water.setAngle(0.0, 0.0, Self.getAngleZ())
	water.TranslateTo(self.X, self.Y, self.Z, 0.0, 0.0, Self.getAngleZ(), 10.0, 95.0)

	; Walk to the bathtub, and align the position/angle
	PlayerRef.setAngle(0.0, 0.0, Self.getAngleZ() + 180.0)
	PlayerRef.TranslateTo(self.X + Math.Sin(self.getAngleZ()+90.0) * 33.0, self.Y + Math.Cos(self.getAngleZ()+90.0) * 33.0, self.Z, 0.0, 0.0, Self.getAngleZ() + 180.0, 200.0, 95.0)
	Utility.wait(1.0)
	Debug.SendAnimationEvent(PlayerRef, "mndBathtubEnter")
	Utility.wait(9.0)

	mnd.lastTimeBath = Utility.getCurrentGameTime()
	int showerSound = mndShowerSound.play(PlayerRef)

	; Play shower anims
	Utility.wait(1.0)
	mndWetShader.Play(PlayerRef)
	PlayerRef.stopTranslation()
	PlayerRef.TranslateTo(self.X + Math.Sin(self.getAngleZ()+90.001) * 33.001, self.Y + Math.Cos(self.getAngleZ()+90.001) * 33.0, self.Z, 0.0, 0.0, Self.getAngleZ() + 180.0, 0.01, 0.01)
	int anim = Utility.randomInt(0, 2)
	mnd.mndDirtShader4.Stop(PlayerRef)
	float elapsed = 1.0
	while elapsed < mnd.bathDuration
		if anim==0
			Debug.SendAnimationEvent(PlayerRef, "mndBathtubFace")
			anim=Utility.randomInt(0, 1)+1
		elseIf anim==1
			Debug.SendAnimationEvent(PlayerRef, "mndBathtubArms")
			anim=Utility.randomInt(0, 1)*2
		else
			Debug.SendAnimationEvent(PlayerRef, "mndBathtubLegs")
			anim=Utility.randomInt(0, 1)
		endIf
		float time = Utility.randomFloat(7.2, 8.3)
		elapsed += time
		Utility.wait(time)
		mnd.removeCum()
		mnd.mndDirtShader3.Stop(PlayerRef)
		mnd.mndDirtShader2.Stop(PlayerRef)
		mnd.mndDirtShader1.Stop(PlayerRef)
	endWhile
	
	Utility.wait(1.0)
	Sound.StopInstance(showerSound)
	Debug.SendAnimationEvent(PlayerRef, "mndBathtubExit")
	water.TranslateTo(self.X, self.Y, self.Z - 40.0, 0.0, 0.0, Self.getAngleZ(), 25.0, 95.0)
	Utility.wait(7.0)
	mndWetShader.Stop(PlayerRef)
	Utility.wait(2.0)

	PlayerRef.stopTranslation()
	Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
	Utility.wait(0.1)
	
	; ((- Redressing
	if clothes[2] && (mnd.stripMode==0 || mnd.stripMode==1) ; No anim
		int i = 44
		while i>30
			i-=1
			if clothes[i - 30]
				PlayerRef.equipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf clothes[2] && (mnd.stripMode==2 || mnd.stripMode==3) ; Animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		int i = 44
		while i>30
			i-=1
			if clothes[i - 30]
				PlayerRef.equipItem(clothes[i - 30], false, true)
			endIf
		endWhile
	elseIf mnd.stripMode==4 || mnd.stripMode==5 ; SexLab no anim
		mnd.UnStripActor(items)
	elseIf mnd.stripMode==6 || mnd.stripMode==7 ; SexLab animated
		Debug.SendAnimationEvent(PlayerRef, "mndUndress")
		Utility.wait(2.5)
		mnd.UnStripActor(items)
	endIf
	; -))
	
	water.stopTranslation()
	water.delete()
	
	; Regain controls
	Utility.wait(0.5)
	if leftHand
		PlayerRef.EquipItemEX(leftHand, 2, false)
	endIf
	if rightHand
		PlayerRef.EquipItemEX(rightHand, 1, false)
	endIf
	PlayerRef.evaluatePackage()
	PlayerRef.SheatheWeapon()
	Utility.wait(0.1)
	Game.EnablePlayerControls(true, true, false, false, false, false, false, false, 0)
	Game.setPlayerAIDriven(false)
	Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
	if oldCameraState==0
		Game.forceFirstPerson()
	endIf	
	Utility.wait(1.0)
	mnd.playingAnim(false)
EndEvent
