Scriptname SLTTTMCoreData

Idle Function setAnimation(Actor act, int gender, int index, int randNormal, int randAhegao) global
	;...........................................................................................
	; ADD, EDIT, OR REMOVE FEMALE ANIMATIONS HERE.
	;...........................................................................................

	string[] animsForFemale = new string[10]
	animsForFemale[0] = "SLTTTMAnimF1"
	animsForFemale[1] = "SLTTTMAnimF2"
	animsForFemale[2] = "SLTTTMAnimF3"
	animsForFemale[3] = "SLTTTMAnimF4"
	animsForFemale[4] = "SLTTTMAnimF5"
	animsForFemale[5] = "SLTTTMAnimF6"
	animsForFemale[6] = "SLTTTMAnimF7"
	animsForFemale[7] = "SLTTTMAnimF8"
	animsForFemale[8] = "SLTTTMAnimF9"
	animsForFemale[9] = "SLTTTMAnimF10"


	;...........................................................................................
	; ADD, EDIT, OR REMOVE MALE ANIMATIONS HERE.
	;...........................................................................................
	
	string[] animsForMale = new string[3]
	animsForMale[0] = "SLTTTMAnimM1"
	animsForMale[1] = "SLTTTMAnimM2"
	animsForMale[2] = "SLTTTMAnimM3"



	;...........................................................................................
	if (gender == 1)
		if(animsForFemale.length > 0)		
			handleAnimation(act, animsForFemale[index], randNormal, randAhegao)
		endif
	else
		if(animsForMale.length > 0)
			handleAnimation(act, animsForMale[index], randNormal, randAhegao)
		endif
	endif

	Debug.SendAnimationEvent(act, "IdleForceDefaultState")
	SLTTTMAPI.clearExpression(act)

	if (act != game.getPlayer())
		act.AllowPCDialogue(true)
		act.SetDontMove(false)
		act.SetUnconscious(false)
	else
		Game.EnablePlayerControls()
	endif
endFunction


;...........................................................................................
; ADD, EDIT, OR REMOVE NORMAL EXPRESSIONS HERE.
; setExpression(Actor act, string type, string category, int id, int strong)
; You can look it up in this steam guide: https://steamcommunity.com/sharedfiles/filedetails/?l=german&id=187155077
;...........................................................................................

Function setNormalExpression(Actor act, int index) global
	if(index == 0)
		SLTTTMAPI.setExpression(act, "mfg", "e", 2, 30)
		SLTTTMAPI.setExpression(act, "mfg", "m", 0, 90)
		SLTTTMAPI.setExpression(act, "mfg", "m", 1, 90)
		SLTTTMAPI.setExpression(act, "mfg", "p", 2, 90)
		SLTTTMAPI.setExpression(act, "mfg", "p", 4, 30)
		SLTTTMAPI.setExpression(act, "mfg", "p", 5, 30)
		SLTTTMAPI.setExpression(act, "mfg", "p", 12, 60)
	endif
		
	if(index == 1)
		SLTTTMAPI.setExpression(act, "mfg", "e", 2, 30)
		SLTTTMAPI.setExpression(act, "mfg", "m", 0, 35)
		SLTTTMAPI.setExpression(act, "mfg", "m", 1, 35)
		SLTTTMAPI.setExpression(act, "mfg", "p", 2, 90)
		SLTTTMAPI.setExpression(act, "mfg", "p", 4, 30)
		SLTTTMAPI.setExpression(act, "mfg", "p", 5, 30)
		SLTTTMAPI.setExpression(act, "mfg", "p", 12, 60)
	endif
		
	if(index == 2)
		SLTTTMAPI.setExpression(act, "mfg", "e", 2, 90)
		SLTTTMAPI.setExpression(act, "mfg", "m", 0, 35)
		SLTTTMAPI.setExpression(act, "mfg", "m", 1, 35)
		SLTTTMAPI.setExpression(act, "mfg", "p", 6, 30)
		SLTTTMAPI.setExpression(act, "mfg", "p", 5, 60)
	endif
EndFunction


;...........................................................................................
; ADD, EDIT, OR REMOVE AHEGAO EXPRESSIONS HERE.
; setExpression(Actor act, string type, string category, int id, int strong)
; You can look it up in this steam guide: https://steamcommunity.com/sharedfiles/filedetails/?l=german&id=187155077
;...........................................................................................

Function setAhegaoExpression(Actor act, int index) global
	if(index == 0)
		SLTTTMAPI.showTongue(act, true)
		SLTTTMAPI.setExpression(act, "mfg", "e", 2, 90)
		SLTTTMAPI.setExpression(act, "mfg", "p", 1, 60)
		SLTTTMAPI.setExpression(act, "mfg", "p", 11, 60)
		SLTTTMAPI.setExpression(act, "mfg", "m", 11, 90)
	endif
		
	if(index == 1)
		SLTTTMAPI.showTongue(act, true)
		SLTTTMAPI.setExpression(act, "mfg", "m", 11, 90)
		SLTTTMAPI.setExpression(act, "mfg", "m", 0, 30)
		SLTTTMAPI.setExpression(act, "mfg", "m", 1, 30)
		SLTTTMAPI.setExpression(act, "mfg", "e", 2, 90)
		SLTTTMAPI.setExpression(act, "mfg", "p", 12, 90)
		SLTTTMAPI.setExpression(act, "mfg", "p", 11, 90)
	endif
		
	if(index == 2)
		SLTTTMAPI.showTongue(act, true)
		SLTTTMAPI.setExpression(act, "mfg", "e", 2, 90)
		SLTTTMAPI.setExpression(act, "mfg", "m", 11, 90)
		SLTTTMAPI.setExpression(act, "mfg", "p", 7, 90)
		SLTTTMAPI.setExpression(act, "mfg", "p", 4, 90)
		SLTTTMAPI.setExpression(act, "mfg", "p", 1, 60)
		SLTTTMAPI.setExpression(act, "mfg", "p", 11, 60)
	endif
		
	if(index == 3)
		SLTTTMAPI.showTongue(act, true)
		SLTTTMAPI.setExpression(act, "mfg", "e", 2, 90)
		SLTTTMAPI.setExpression(act, "mfg", "m", 11, 90)
		SLTTTMAPI.setExpression(act, "mfg", "p", 11, 90)
		SLTTTMAPI.setExpression(act, "mfg", "p", 14, 90)
	endif
		
	if(index == 4)
		SLTTTMAPI.showTongue(act, true)
		SLTTTMAPI.setExpression(act, "mfg", "e", 2, 90)
		SLTTTMAPI.setExpression(act, "mfg", "m", 11, 90)
		SLTTTMAPI.setExpression(act, "mfg", "p", 12, 90)
		SLTTTMAPI.setExpression(act, "mfg", "p", 11, 90)
	endif
EndFunction


;...........................................................................................
; THIS IS WHERE YOU SELECT WHICH ANIMATION THE MOD WILL USE. YOU'LL CHOOSE WHICH ANIMATION TO PAIR WITH WHICH EXPRESSION.
; setFaceExpression(Actor act, int normalIndex, int ahegaoIndex).
;...........................................................................................

bool Function runPose(Actor act) global
	if(SLTTTMAPI.isFemale(act))			;FEMALE

		GlobalVariable SLTTTMAnimationF1 = Game.GetFormFromFile(0x000820, "SLTooTiredToMove.esp") as GlobalVariable
		GlobalVariable SLTTTMAnimationF2 = Game.GetFormFromFile(0x000821, "SLTooTiredToMove.esp") as GlobalVariable
		GlobalVariable SLTTTMAnimationF3 = Game.GetFormFromFile(0x000822, "SLTooTiredToMove.esp") as GlobalVariable
		GlobalVariable SLTTTMAnimationF4 = Game.GetFormFromFile(0x000823, "SLTooTiredToMove.esp") as GlobalVariable
		GlobalVariable SLTTTMAnimationF5 = Game.GetFormFromFile(0x000824, "SLTooTiredToMove.esp") as GlobalVariable
		GlobalVariable SLTTTMAnimationF6 = Game.GetFormFromFile(0x000825, "SLTooTiredToMove.esp") as GlobalVariable
		GlobalVariable SLTTTMAnimationF7 = Game.GetFormFromFile(0x000826, "SLTooTiredToMove.esp") as GlobalVariable
		GlobalVariable SLTTTMAnimationF8 = Game.GetFormFromFile(0x000827, "SLTooTiredToMove.esp") as GlobalVariable
		GlobalVariable SLTTTMAnimationF9 = Game.GetFormFromFile(0x000828, "SLTooTiredToMove.esp") as GlobalVariable
		GlobalVariable SLTTTMAnimationF10 = Game.GetFormFromFile(0x000829, "SLTooTiredToMove.esp") as GlobalVariable

		int AnimationActiveArrayLength = 0
		int[] AnimationActiveArray = new int[10]
		if(SLTTTMAnimationF1.getValue() == 1)
			AnimationActiveArray[AnimationActiveArrayLength] = 0 
			AnimationActiveArrayLength += 1
		endif
		if(SLTTTMAnimationF2.getValue() == 1)
			AnimationActiveArray[AnimationActiveArrayLength] = 1 
			AnimationActiveArrayLength += 1
		endif
		if(SLTTTMAnimationF3.getValue() == 1)
			AnimationActiveArray[AnimationActiveArrayLength] = 2
			AnimationActiveArrayLength += 1
		endif
		if(SLTTTMAnimationF4.getValue() == 1)
			AnimationActiveArray[AnimationActiveArrayLength] = 3 
			AnimationActiveArrayLength += 1
		endif
		if(SLTTTMAnimationF5.getValue() == 1)
			AnimationActiveArray[AnimationActiveArrayLength] = 4
			AnimationActiveArrayLength += 1
		endif
		if(SLTTTMAnimationF6.getValue() == 1)
			AnimationActiveArray[AnimationActiveArrayLength] = 5
			AnimationActiveArrayLength += 1
		endif
		if(SLTTTMAnimationF7.getValue() == 1)
			AnimationActiveArray[AnimationActiveArrayLength] = 6
			AnimationActiveArrayLength += 1
		endif
		if(SLTTTMAnimationF8.getValue() == 1)
			AnimationActiveArray[AnimationActiveArrayLength] = 7
			AnimationActiveArrayLength += 1
		endif
		if(SLTTTMAnimationF9.getValue() == 1)
			AnimationActiveArray[AnimationActiveArrayLength] = 8
			AnimationActiveArrayLength += 1
		endif
		if(SLTTTMAnimationF10.getValue() == 1)
			AnimationActiveArray[AnimationActiveArrayLength] = 9
			AnimationActiveArrayLength += 1
		endif
	
		if(AnimationActiveArrayLength == 0)
			return false
		endif
	
		int maxRandom = AnimationActiveArrayLength - 1
		int randomInt = Utility.RandomInt(0, maxRandom)
		int random = AnimationActiveArray[randomInt]

		if(random == 0)	
			int randAhegao = Utility.RandomInt(0, 4)	
			SLTTTMAPI.setFaceExpression(act, 2, randAhegao)
			setAnimation(act, 1, random, 2, randAhegao)
			return true
		endif
		if(random == 1)
			int randNormal = Utility.RandomInt(0, 2)
			int randAhegao = Utility.RandomInt(0, 4)
			SLTTTMAPI.setFaceExpression(act, randNormal, randAhegao)
			setAnimation(act, 1, random, randNormal, randAhegao)
			return true
		endif
		if(random == 2)
			int randNormal = Utility.RandomInt(0, 2)
			int randAhegao = Utility.RandomInt(0, 4)
			SLTTTMAPI.setFaceExpression(act, randNormal, randAhegao)
			setAnimation(act, 1, random, randNormal, randAhegao)
			return true
		endif
		if(random == 3)
			int randAhegao = Utility.RandomInt(0, 4)
			SLTTTMAPI.setFaceExpression(act, 2, randAhegao)
			setAnimation(act, 1, random, 2, randAhegao)
			return true
		endif
		if(random == 4)
			int randNormal = Utility.RandomInt(0, 1)
			int randAhegao = Utility.RandomInt(0, 4)
			SLTTTMAPI.setFaceExpression(act, randNormal, randAhegao)
			setAnimation(act, 1, random, randNormal, randAhegao)
			return true
		endif
		if(random == 5)
			int randNormal = Utility.RandomInt(0, 2)
			int randAhegao = Utility.RandomInt(0, 4)
			SLTTTMAPI.setFaceExpression(act, randNormal, randAhegao)
			setAnimation(act, 1, random, randNormal, randAhegao)
			return true
		endif
		if(random == 6)
			int randNormal = Utility.RandomInt(0, 2)
			int randAhegao = Utility.RandomInt(0, 4)
			SLTTTMAPI.setFaceExpression(act, randNormal, randAhegao)
			setAnimation(act, 1, random, randNormal, randAhegao)
			return true
		endif
		if(random == 7)
			int randNormal = Utility.RandomInt(0, 1)
			int randAhegao = Utility.RandomInt(0, 4)
			SLTTTMAPI.setFaceExpression(act, randNormal, randAhegao)
			setAnimation(act, 1, random, randNormal, randAhegao)
			return true
		endif
		if(random == 8)
			int randNormal = Utility.RandomInt(0, 1)
			int randAhegao = Utility.RandomInt(0, 4)
			SLTTTMAPI.setFaceExpression(act, randNormal, randAhegao)
			setAnimation(act, 1, random, randNormal, randAhegao)
			return true
		endif
		if(random == 9)
			int randNormal = Utility.RandomInt(0, 2)
			int randAhegao = Utility.RandomInt(0, 4)
			SLTTTMAPI.setFaceExpression(act, randNormal, randAhegao)
			setAnimation(act, 1, random, randNormal, randAhegao)
			return true
		endif
	endif

	if(!SLTTTMAPI.isFemale(act))			;MALE

		GlobalVariable SLTTTMAnimationM1 = Game.GetFormFromFile(0x00081D, "SLTooTiredToMove.esp") as GlobalVariable
		GlobalVariable SLTTTMAnimationM2 = Game.GetFormFromFile(0x00081E, "SLTooTiredToMove.esp") as GlobalVariable
		GlobalVariable SLTTTMAnimationM3 = Game.GetFormFromFile(0x00081F, "SLTooTiredToMove.esp") as GlobalVariable

		int AnimationActiveArrayLength = 0
		int[] AnimationActiveArray = new int[3]
		if(SLTTTMAnimationM1.getValue() == 1)
			AnimationActiveArray[AnimationActiveArrayLength] = 0 
			AnimationActiveArrayLength += 1
		endif
		if(SLTTTMAnimationM2.getValue() == 1)
			AnimationActiveArray[AnimationActiveArrayLength] = 1 
			AnimationActiveArrayLength += 1
		endif
		if(SLTTTMAnimationM3.getValue() == 1)
			AnimationActiveArray[AnimationActiveArrayLength] = 2
			AnimationActiveArrayLength += 1
		endif

		if(AnimationActiveArrayLength == 0)
			return false
		endif
	
		int maxRandom = AnimationActiveArrayLength - 1
		int randomInt = Utility.RandomInt(0, maxRandom)
		int random = AnimationActiveArray[randomInt]

		if(random == 0)	
			int randAhegao = Utility.RandomInt(0, 4)		
			SLTTTMAPI.setFaceExpression(act, 0, randAhegao)
			setAnimation(act, 0, random, 0, randAhegao)
			return true
		endif
		if(random == 1)
			int randAhegao = Utility.RandomInt(0, 4)
			SLTTTMAPI.setFaceExpression(act, 0, randAhegao)
			setAnimation(act, 0, random, 0, randAhegao)
			return true
		endif
		if(random == 2)
			int randAhegao = Utility.RandomInt(0, 4)
			SLTTTMAPI.setFaceExpression(act, 0, randAhegao)
			setAnimation(act, 0, random, 0, randAhegao)
			return true
		endif
	endif
endFunction

function handleAnimation(Actor act, string animationEvent, int randNormal, int randAhegao) global
	GlobalVariable SLTTTMTiredTime = Game.GetFormFromFile(0x000804, "SLTooTiredToMove.esp") as GlobalVariable	
	float timer = SLTTTMTiredTime.getValue()
	Debug.Trace("SLTTTMCoreData: handleAnimation start, act=" + act + ", animationEvent=" + animationEvent)
	Debug.SendAnimationEvent(act, animationEvent)
	UpdateFhuTullItems(act, animationEvent)
	SLTTTMAPI.setFaceExpression(act, randNormal, randAhegao)
	utility.wait(1)
	if (act != game.getPlayer())
		act.AllowPCDialogue(false)
		act.SetDontMove()
		act.SetUnconscious()
	else
		Game.DisablePlayerControls()
	endif			
	while timer > 0
		utility.wait(0.2)
		timer -= 0.2
		Debug.SendAnimationEvent(act, animationEvent)
		SLTTTMAPI.setFaceExpression(act, randNormal, randAhegao)
	endwhile
	Debug.Trace("SLTTTMCoreData: handleAnimation end, act=" + act + ", animationEvent=" + animationEvent)
	RemoveFhuTullItems(act)
endFunction

Function UpdateFhuTullItems(Actor act, string animationEvent) global
	if !act
		return
	endif
	sr_inflateQuest fhu = Game.GetFormFromFile(0x000D63, "sr_FillHerUp.esp") as sr_inflateQuest
	if !fhu || !fhu.IsTullAnimatedCreampieReady()
		return
	endif
	sr_inflateConfig cfg = fhu.config
	if !cfg
		cfg = Game.GetFormFromFile(0x00001D8C, "sr_FillHerUp.esp") as sr_inflateConfig
	endif
	if !cfg
		return
	endif

	float threshold = cfg.TullAnimatedCreampieThreshold / 100.0

	if fhu.GetVaginalPercentage(act) >= threshold
		EquipTullAnimatedCreampieItem(act,0x00000801)
	elseif fhu.GetOralPercentage(act) >= threshold
		EquipTullAnimatedCreampieItem(act, 0x00000803)
	endif
EndFunction

Function RemoveFhuTullItems(Actor act) global
	if !act
		return
	endif
	RemoveTullAnimatedCreampieItem(act, 0x00000801)
	RemoveTullAnimatedCreampieItem(act, 0x00000809)
	RemoveTullAnimatedCreampieItem(act, 0x00000803)
EndFunction

Function EquipTullAnimatedCreampieItem(Actor act, int formId) global
	if !act
		return
	endif
	Armor a = Game.GetFormFromFile(formId, "TullAnimatedCreampie.esp") as Armor
	if a
		Debug.Trace("SLTTTMCoreData: EquipTullAnimatedCreampieItem, act=" + act + ", armor=" + a + ", formId=" + formId)
		act.AddItem(a, 1, true)
		act.EquipItem(a, abSilent=true)
	endif
EndFunction

Function RemoveTullAnimatedCreampieItem(Actor act, int formId) global
	if !act
		return
	endif
	Armor a = Game.GetFormFromFile(formId, "TullAnimatedCreampie.esp") as Armor
	if a
		if act.IsEquipped(a)
			Debug.Trace("SLTTTMCoreData: RemoveTullAnimatedCreampieItem, act=" + act + ", armor=" + a + ", formId=" + formId)
			act.UnequipItem(a, abSilent=true)
		endif
		act.RemoveItem(a, 99, true)
	endif
EndFunction
