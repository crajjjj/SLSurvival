Scriptname SAT_UpkeepScript extends Quest  

float property Trauma = 0.0 auto
float property Stress = 0.0 auto

float property lastSexTime = 0.0 auto hidden
float property lastRapeTime = 0.0 auto hidden

float property lastCombatTime auto hidden
float property CombatStartTime auto hidden
bool property InCombat = false auto hidden

float property lastHealth = 1.0 auto hidden
bool property firstInstall = false auto hidden
float property lastUpdateTime auto hidden

ImageSpaceModifier Property SAT_Stress01 Auto
ImageSpaceModifier Property SAT_Stress02 Auto
ImageSpaceModifier Property SAT_Stress03 Auto
ImageSpaceModifier Property SAT_StressDoubleVision Auto
ImageSpaceModifier Property SAT_Trauma01 Auto
ImageSpaceModifier Property SAT_Trauma02 Auto
ImageSpaceModifier Property SAT_Trauma03 Auto
ImageSpaceModifier Property SAT_RedFlash Auto
ImageSpaceModifier Property SAT_Arousal01 Auto
ImageSpaceModifier Property SAT_Arousal02 Auto

slaFrameworkScr Property slaFramework auto
SAT_mcmConfig Property mcm auto
SexLabFramework Property SexLab auto

actor property PlayerRef auto

quest property SAT_RedFlashesController auto
quest property SAT_FollowerController auto

referenceAlias Property Follower01 auto
referenceAlias Property Follower02 auto
referenceAlias Property Follower03 auto
referenceAlias Property Follower04 auto


Event OnInit()
	RegisterForModEvent("AnimationStart", "HavingSex")
	RegisterForModEvent("AnimationEnd", "SexEnded")
	RegisterForUpdate(3.0)
	RegisterForUpdateGameTime(0.25)
	If !firstInstall
		lastCombatTime = utility.GetCurrentGameTime()
		firstInstall = true
	endif
endEvent


Event OnUpdate()
																									;TRAUMA
float gameTime = utility.GetCurrentGameTime()

float lastTime
If mcm.TraumaNoSex
	lastTime = lastSexTime
else
	lastTime = lastRapeTime
endif

If gameTime - lastTime >= mcm.TraumaDays
	Trauma -= (gameTime - lastUpdateTime) * mcm.TraumaTimeValue			;daily reduction per day after the trauma days
	If Trauma < 0
		Trauma = 0
	endif
endif
			
																									;COMBAT
If PlayerRef.isInCombat() == true && InCombat == false 	;we just entered combat
	InCombat = true
	CombatStartTime = GameTime
elseif PlayerRef.isInCombat() == false && InCombat == true		;we just left combat
	InCombat = false
	LastCombatTime = GameTime
	Stress += ((LastCombatTime - CombatStartTime) * 24 * 60 / 10 * mcm.StressTimeMulti) 			; 1 point of stress for 10 game minutes of combat, adjustable by multiplier (default = 1)
		If Stress > 100
			Stress = 100
		endif
endif

If InCombat == false
	Stress -= (gameTime - lastUpdateTime) * mcm.StressTimeValue			   ;reduce stress by daily rate
	If Stress < 0
		Stress = 0
	endif
endif

lastUpdateTime = gameTime												;log game-time of each update, used for trauma and stress reduction over time


float health = PlayerRef.GetAVPercentage("health")
If lastHealth > health   							 						;we took damage
	Stress += (lastHealth - health) * 10 * mcm.StressDamMulti           		;1 point of Stress for 10% of damage, health comes in 0.X values (1.0 = 100%), therefore * 10 ( *100 /10 )
		If Stress > 100
			Stress = 100
		endif
	lastHealth = health
elseif lastHealth < health
	lastHealth = health
endif

																																		;AROUSAL
If mcm.RisingArousal
	if slaFramework.GetActorArousal(PlayerRef) < Stress as Int
		slaFramework.SetActorExposure(PlayerRef, Stress as Int)
	endif
endif


If (Stress >= 66) && !sexlab.isActorActive(PlayerRef)																					;VISUAL EFFECTS
	SAT_Stress03.apply()
	If (utility.randomInt(0,2) == 1)
		SAT_StressDoubleVision.apply()
	endIf
elseIf (Stress >= 33) && !sexlab.isActorActive(PlayerRef)
	SAT_Stress02.apply()
elseIf (Stress >= mcm.StressFreeValue) && !sexlab.isActorActive(PlayerRef)
	SAT_Stress01.apply()
endIf

If (Trauma >= 66) && !sexlab.isActorActive(PlayerRef) && utility.randomInt(1,100) <= 33
	SAT_Trauma03.apply()
elseIf (Trauma >= 33) && !sexlab.isActorActive(PlayerRef) && utility.randomInt(1,100) <= 25
	SAT_Trauma02.apply()
elseIf (Trauma >= mcm.TraumaFreeValue) && !sexlab.isActorActive(PlayerRef) && utility.randomInt(1,100) <= 20
	SAT_Trauma01.apply() 
	If mcm.TraumaArousalLock
		slaFramework.SetActorArousalBlocked(PlayerRef, true)
		slaFramework.SetActorExposure(PlayerRef, 0)
	endif
else
	slaFramework.SetActorArousalBlocked(PlayerRef, false)
endIf

If mcm.ArousalVisuals 
	int Arousal = slaFramework.GetActorArousal(PlayerRef)
	If Trauma == 0 && Arousal >= 70 && utility.randomInt(1,100) <= 18 && !sexlab.isActorActive(PlayerRef) && InCombat == false
		SAT_Arousal02.apply()
	elseIf Trauma == 0 && Arousal >= 50 && utility.randomInt(1,100) <= 12 && !sexlab.isActorActive(PlayerRef) && InCombat == false
		SAT_Arousal01.apply()
	endIf
endif
EndEvent

Event OnUpdateGameTime()																									; FOLLOWER
	if mcm.followerArousal
		if SAT_FollowerController.Start()
			Utility.Wait(1.0)

			Actor Follower = Follower01.getActorRef()
				If Follower != none
					if slaFramework.GetActorArousal(Follower) < Stress as Int
						slaFramework.SetActorExposure(Follower, Stress as Int)
					endif
				endif

			Follower = Follower02.getActorRef()
				If Follower != none
					if slaFramework.GetActorArousal(Follower) < Stress as Int
						slaFramework.SetActorExposure(Follower, Stress as Int)
					endif
				endif

			Follower = Follower03.getActorRef()
				If Follower != none
					if slaFramework.GetActorArousal(Follower) < Stress as Int
						slaFramework.SetActorExposure(Follower, Stress as Int)
					endif
				endif

			Follower = Follower04.getActorRef()
				If Follower != none
					if slaFramework.GetActorArousal(Follower) < Stress as Int
						slaFramework.SetActorExposure(Follower, Stress as Int)
					endif
				endif

			SAT_FollowerController.Stop()
		else
			Debug.trace("SAT Followerquest falied to start!")
			SAT_FollowerController.Stop()
		endif
	endif
endEvent

Function alcohol()
	Stress -= mcm.alcoholStressValue
	Trauma -= mcm.alcoholTraumaValue

	If Trauma < 0
		Trauma = 0
	endif
	If Stress < 0
		Stress = 0
	endif
endFunction


Function drug()
	Stress -= mcm.drugStressValue
	Trauma -= mcm.drugTraumaValue

	If Trauma < 0
		Trauma = 0
	endif
	If Stress < 0
		Stress = 0
	endif
endFunction


Event HavingSex(string eventName, string argString, float argNum, form sender)

	sslThreadController controller = SexLab.HookController(argString)
	If controller.HasPlayer()										
			
		lastSexTime = utility.GetCurrentGameTime()
		actor victim = SexLab.HookVictim(argString)

		If victim == Game.GetPlayer()

			lastRapeTime = utility.GetCurrentGameTime()
			If mcm.RapeFlash == true
				SAT_RedFlashesController.RegisterForUpdate(0.5)														
			endif

			sslBaseAnimation animation = SexLab.HookAnimation(argString)
			If animation.HasTag("beastiality")
				Trauma += mcm.TraumaBeastRapeValue
			elseif animation.HasTag("anal")
				Trauma += mcm.TraumaAnalRapeValue
			elseif animation.HasTag("vaginal")
				Trauma += mcm.TraumaVaginalRapeValue
			elseif animation.HasTag("oral")
				Trauma += mcm.TraumaOralRapeValue
			endif
			If Trauma > 100
				Trauma = 100
			endif
		else
			Stress -= mcm.StressSexValue
			If Stress < 0
				Stress = 0
			endif

			sslBaseAnimation animation = SexLab.HookAnimation(argString)
			If animation.HasTag("beastiality")
				Trauma += mcm.TraumaBeastConsensValue
			elseif animation.HasTag("anal")
				Trauma += mcm.TraumaAnalConsensValue
			elseif animation.HasTag("vaginal")
				Trauma += mcm.TraumaVaginalConsensValue
			elseif animation.HasTag("oral")
				Trauma += mcm.TraumaOralConsensValue
			endif
			If Trauma > 100
				Trauma = 100
			endif
		endif
	endif
endEvent


Event SexEnded(string eventName, string argString, float argNum, form sender)		; unregister to stop red flashes
	sslThreadController controller = SexLab.HookController(argString)
	If controller.HasPlayer()	
		SAT_RedFlashesController.UnregisterForUpdate()
	endif
EndEvent