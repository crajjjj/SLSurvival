Scriptname aaaKNNPlayPerkContainerAnimQuest extends Quest

;Quest Property POV auto
Quest Property animCtrl auto
;Quest Property PerkAnimUtility auto
;Spell Property aaaKNNPlayPerkChestCrouchingSpell auto
;Spell Property aaaKNNPlayPerkChestHunchingSpell auto
;Spell Property aaaKNNPlayPerkChestStandingSpell auto
;Spell Property aaaKNNPlayPerkChestOnTipToeSpell auto

Function ActivateChest(ObjectReference akTargetRef, Actor akActor)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	float angleZ = akActor.GetHeadingAngle(akTargetRef)
	if angleZ >= -45.0 && angleZ <= 45.0
		float posZ = ((Self as Quest) as aaaKNNPlayPerkAnimUtilityQuest).GetOffsetPosZ(akTargetRef, akActor)
		PlayStandardChest(akTargetRef, akActor, posZ)
	else
		akTargetRef.Activate(akActor)
	endIf
EndFunction


Function PlayStandardChest(ObjectReference akTargetRef, Actor akActor, float offsetPosZ)	
	;Debug.sendAnimationEvent(akActor, "idleStop")
	(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
	;Utility.wait(0.1)
	if offsetPosZ < 29
		PlayChestLoot(akTargetRef, akActor, 0)
	elseIf offsetPosZ < 50
		PlayChestLoot(akTargetRef, akActor, 1)
	elseIf offsetPosZ <= 75
		PlayChestLoot(akTargetRef, akActor, 2)
	else
		PlayChestLoot(akTargetRef, akActor, 3)
	endIf
	(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
EndFunction

Function PlayChestLoot(ObjectReference akTargetRef, Actor akActor, int animType)
	float[] waitTime = new float[2]
	string animEvent = ""
	if  1 == animType
		;aaaKNNPlayPerkChestHunchingSpell.Cast(akActor)
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)	
			animEvent = "KNNOpenChestHunching"
		else
			animEvent = "KNNOpenChestHunching_M"
		endIf
		waitTime[0] = 1.0
		waitTime[1] = 1.2
	elseIf 2 == animType
		;aaaKNNPlayPerkChestStandingSpell.Cast(akActor)
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)	
			animEvent = "KNNOpenChestStanding"
		else
			animEvent = "KNNOpenChestStanding_M"
		endIf
		waitTime[0] = 0.73
		waitTime[1] = 1.17
	elseIf 3 == animType
		;aaaKNNPlayPerkChestOnTipToeSpell.Cast(akActor)
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)	
			animEvent = "KNNOpenChestStandingOnTiptoe"
		else
			animEvent = "KNNOpenChestStandingOnTiptoe_M"
		endIf
		waitTime[0] = 0.8
		waitTime[1] = 1.2
	elseIf 4 == animType
		;aaaKNNPlayPerkCupBoardSpell.Cast(akActor)
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			animEvent = "KNNOpenCupBoard"
		else
			animEvent = "KNNOpenCupBoard_M"
		endIf
		waitTime[0] = 0.76
		waitTime[1] = 1.54
	elseIf 5 == animType
		;aaaKNNPlayPerkEndTableSpell.Cast(akActor)
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			animEvent = "KNNOpenEndtable"
		else
			animEvent = "KNNOpenEndtable_M"
		endIf
		waitTime[0] = 0.7
		waitTime[1] = 1.6
	elseIf 6 == animType
		;aaaKNNPlayPerkWardrobeSpell.Cast(akActor)
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)
			animEvent = "KNNOpenWardrobe"
		else
			animEvent = "KNNOpenWardrobe_M"
		endIf
		waitTime[0] = 0.8
		waitTime[1] = 1.5
	else ; 0 == animType
		;aaaKNNPlayPerkChestCrouchingSpell.Cast(akActor)	
		if (animCtrl as aaaKNNAnimControlQuest).GetGender(akActor)	
			animEvent = "KNNOpenChestCrouching"
		else
			animEvent = "KNNOpenChestCrouching_M"
		endIf
		waitTime[0] = 0.83
		waitTime[1] = 1.37
	endIf
	Debug.SendAnimationEvent(akActor, animEvent)
	Utility.wait(waitTime[0])
	akTargetRef.Activate(akActor)
	Utility.wait(waitTime[1])
EndFunction

Function ActivateBarrel(ObjectReference akTargetRef, Actor akActor)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	float angleZ = akActor.GetHeadingAngle(akTargetRef)
	if angleZ >= -45.0 && angleZ <= 45.0
		(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
		float chestAngleX = akTargetRef.GetAngleX()
		float chestAngleY = akTargetRef.GetAngleY()
		if chestAngleX > 10 || chestAngleX < -10 || chestAngleY > 10 || chestAngleY < -10
			;Debug.Notification("Horizontal barrel")
			float posZ = ((Self as Quest) as aaaKNNPlayPerkAnimUtilityQuest).GetOffsetPosZ(akTargetRef, akActor)
			if posZ > -49
				PlayChestLoot(akTargetRef, akActor, 0)
			elseIf posZ >= -95
				PlayChestLoot(akTargetRef, akActor, 2)
			else
				PlayChestLoot(akTargetRef, akActor, 3)
			endIf
		else
			float posZ = ((Self as Quest) as aaaKNNPlayPerkAnimUtilityQuest).GetOffsetPosZ(akTargetRef, akActor) + akTargetRef.GetHeight() * akTargetRef.GetScale()
			float actorHeight = ((Self as Quest) as aaaKNNPlayPerkAnimUtilityQuest).GetActorHeight(akActor)
			if posZ <= 0 || posZ / actorHeight < 0.3125
				PlayChestLoot(akTargetRef, akActor, 0)
			elseIf posZ / actorHeight < 0.50
				PlayChestLoot(akTargetRef, akActor, 1)
				Utility.wait(1.2)
			elseIf posZ / actorHeight < 1.05
				PlayChestLoot(akTargetRef, akActor, 2)
			else				
				PlayChestLoot(akTargetRef, akActor, 3)
			endIf
		endIf
		(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
	else
		akTargetRef.Activate(akActor)
	endIf
EndFunction

;Spell Property aaaKNNPlayPerkCupBoardSpell auto
Function ActivateCupBoard(ObjectReference akTargetRef, Actor akActor)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	float angleZ = akActor.GetHeadingAngle(akTargetRef)
	if angleZ >= -45.0 && angleZ <= 45.0
		float posZ = ((Self as Quest) as aaaKNNPlayPerkAnimUtilityQuest).GetOffsetPosZ(akTargetRef, akActor)
		float chestAngleX = akTargetRef.GetAngleX()
		float chestAngleY = akTargetRef.GetAngleY()
		if chestAngleX > 10 || chestAngleX < -10 || chestAngleY > 10 || chestAngleY < -10
			PlayStandardChest(akTargetRef, akActor, posZ)
		else
			(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
			PlayChestLoot(akTargetRef, akActor, 4)
			(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
		endIf
	else
		akTargetRef.Activate(akActor)
	endIf
EndFunction

;Spell Property aaaKNNPlayPerkEndTableSpell auto
Function ActivateEndTable(ObjectReference akTargetRef, Actor akActor)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	float angleZ = akActor.GetHeadingAngle(akTargetRef)
	if angleZ >= -45.0 && angleZ <= 45.0
		float posZ = ((Self as Quest) as aaaKNNPlayPerkAnimUtilityQuest).GetOffsetPosZ(akTargetRef, akActor)
		float chestAngleX = akTargetRef.GetAngleX()
		float chestAngleY = akTargetRef.GetAngleY()
		if chestAngleX > 10 || chestAngleX < -10 || chestAngleY > 10 || chestAngleY < -10
			PlayStandardChest(akTargetRef, akActor, posZ)
		else	
			(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()		
			PlayChestLoot(akTargetRef, akActor, 5)
			(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
		endIf
	else
		akTargetRef.Activate(akActor)
	endIf
EndFunction

;Spell Property aaaKNNPlayPerkWardrobeSpell auto
Function ActivateWardrobe(ObjectReference akTargetRef, Actor akActor)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	float angleZ = akActor.GetHeadingAngle(akTargetRef)
	if angleZ >= -45.0 && angleZ <= 45.0
		float posZ = ((Self as Quest) as aaaKNNPlayPerkAnimUtilityQuest).GetOffsetPosZ(akTargetRef, akActor)
		float chestAngleX = akTargetRef.GetAngleX()
		float chestAngleY = akTargetRef.GetAngleY()
		if chestAngleX > 10 || chestAngleX < -10 || chestAngleY > 10 || chestAngleY < -10
			PlayStandardChest(akTargetRef, akActor, posZ)
		else
			(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
			PlayChestLoot(akTargetRef, akActor, 6)
			(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
		endIf
	else
		akTargetRef.Activate(akActor)
	endIf
EndFunction

Function ActivateSack(ObjectReference akTargetRef, Actor akActor)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	float angleZ = akActor.GetHeadingAngle(akTargetRef)
	if angleZ >= -45.0 && angleZ <= 45.0
		(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
		float offsetPosZ = ((Self as Quest) as aaaKNNPlayPerkAnimUtilityQuest).GetOffsetPosZ(akTargetRef, akActor)
		if offsetPosZ > 120.0
			PlayChestLoot(akTargetRef, akActor, 3)
		elseIf offsetPosZ > 70.0
			PlayChestLoot(akTargetRef, akActor, 2)
		elseIf offsetPosZ > 15.0
			PlayChestLoot(akTargetRef, akActor, 1)
		else
			PlayChestLoot(akTargetRef, akActor, 0)
		endIf
		(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
	else
		akTargetRef.Activate(akActor)
	endIf
EndFunction
;金庫/焼死体/ノルドの小骨壷?
Function ActivateMisc(ObjectReference akTargetRef, Actor akActor)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf
	float angleZ = akActor.GetHeadingAngle(akTargetRef)
	if angleZ >= -45.0 && angleZ <= 45.0
		(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
		float offsetPosZ = ((Self as Quest) as aaaKNNPlayPerkAnimUtilityQuest).GetOffsetPosZ(akTargetRef, akActor)
		if offsetPosZ > 120.0
			PlayChestLoot(akTargetRef, akActor, 3)
		elseIf offsetPosZ > 70.0
			PlayChestLoot(akTargetRef, akActor, 2)
		elseIf offsetPosZ > 15.0
			PlayChestLoot(akTargetRef, akActor, 1)
		else
			PlayChestLoot(akTargetRef, akActor, 0)
		endIf
		(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
	else
		akTargetRef.Activate(akActor)
	endIf
EndFunction

Function ActivateLoot(ObjectReference akTargetRef, Actor akActor)
	if KNNPlugin_Utility.IsTeammateFavor()
		akTargetRef.Activate(akActor)
		return
	endIf	
	float angleZ = akActor.GetHeadingAngle(akTargetRef)
	if angleZ >= -45.0 && angleZ <= 45.0
		(animCtrl as aaaKNNAnimControlQuest).SetThirdPersonCameraState()
		float ObjHeight = akTargetRef.GetHeight()
		float offsetPosZ = ((Self as Quest) as aaaKNNPlayPerkAnimUtilityQuest).GetOffsetPosZ(akTargetRef, akActor)
		;Debug.Notification("ObjHeight : " + ObjHeight + ", offsetPosZ : " + offsetPosZ)
		;Debug.sendAnimationEvent(akActor, "idleStop")
		;Utility.wait(0.1)
		if ObjHeight > 200.0
			if offsetPosZ >= 40.0
				PlayChestLoot(akTargetRef, akActor, 0)
			elseIf offsetPosZ >= -15.0
				PlayChestLoot(akTargetRef, akActor, 2)
			else				
				PlayChestLoot(akTargetRef, akActor, 3)
			endIf
		elseIf ObjHeight >= 80.0
			if offsetPosZ < 15.0
				PlayChestLoot(akTargetRef, akActor, 1)
			elseIf offsetPosZ <= 75.0
				PlayChestLoot(akTargetRef, akActor, 2)
			else
				PlayChestLoot(akTargetRef, akActor, 3)
			endIf
		else
			if offsetPosZ < 15.0
				PlayChestLoot(akTargetRef, akActor, 0)
			elseIf offsetPosZ < 30.0
				PlayChestLoot(akTargetRef, akActor, 1)		
			elseIf offsetPosZ <= 65.0
				PlayChestLoot(akTargetRef, akActor, 2)
			else
				PlayChestLoot(akTargetRef, akActor, 3)
			endIf
		endIf
		(animCtrl as aaaKNNAnimControlQuest).ReturnCameraState()
	else
		akTargetRef.Activate(akActor)
	endIf
EndFunction