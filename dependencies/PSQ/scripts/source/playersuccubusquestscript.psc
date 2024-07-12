Scriptname PlayerSuccubusQuestScript Extends Quest

Import StorageUtil
Import ColorComponent

;基礎なプロパティ
SexLabFramework Property SexLab Auto
slaUtilScr Property slaUtil Auto
Actor Property PlayerRef Auto
GlobalVariable Property GameDaysPassed Auto

;サキュバス値を計算する時の基礎
GlobalVariable Property PlayerIsSuccubus Auto
GlobalVariable Property SuccubusEnergy Auto
GlobalVariable Property SuccubusEXP Auto
GlobalVariable Property SuccubusRank Auto

;吸精に関わるなんか
Keyword Property ActorTypeUndead Auto
GlobalVariable Property AllowSneakFeed Auto
GlobalVariable Property AllowForceFeed Auto
GlobalVariable Property AllowSleepFeed Auto
GlobalVariable Property AllowTeamMateFeed Auto
Bool Property EnableDrain = True Auto Hidden
Bool Property AllowDrainFromFemale = True Auto Hidden
Bool Property AllowDrainFromBeast = True Auto Hidden
Bool Property AllowDrainFromUndead Auto Hidden
Bool Property AllowKill = True Auto Hidden
Bool Property EnableCaptive = True Auto Hidden
Bool Property EnableSoulTrap Auto Hidden
Bool Property ExtractSemenPotion Auto Hidden
Bool Property AutoExtractSemenPotion Auto Hidden
Bool Property FastMode Auto Hidden
Int Property ConditionToKill = 3 Auto Hidden
Int Property ConditionToSoulTrap Auto Hidden
Float Property SexTimer Auto Hidden
Float Property AutoExtractSemenPotionThreshold = 90.0 Auto Hidden
Float Property LoversDrainMult = 2.0 Auto Hidden
Float Property DrainValueMultipliers = 1.0 Auto Hidden
Float Property FastModeTime = 60.0 Auto Hidden
Spell Property SuccubusRapeVictimDebuffSpell Auto
Spell Property SuccubusSoulTrap Auto

;経験値
Float Property EXPGainedMultipliers = 1.0 Auto Hidden

;NPCの持つエナジー計算用のなんか
Bool Property AdjustMinEnergyOfHuman = True Auto Hidden
Float Property LoversRestoreMult = 1.5 Auto Hidden
Float Property CalcMaxEnergyHealth = 3.0 Auto Hidden
Float Property MinEnergyOfHuman = 500.0 Auto Hidden

;飢餓伝説
SuccubusEnergyBarUpdate Property SEBU Auto
Bool Property EnergyModeAlt Auto Hidden
Bool Property StopEnergyConsuming Auto Hidden
Bool Property EnableStarvation = True Auto Hidden
Bool Property EnableSatiationNotification = True Auto Hidden
Bool Property EnableSatiationEffect = True Auto Hidden
Float Property MaxEnergy Auto Hidden
Float Property MaxEnergyAtAltMode = 1000.0 Auto Hidden
Float Property EnergyConsumption Auto Hidden
Float Property EnergyConsumptionPerMax = 14.0 Auto Hidden
Float Property ConsumeTimer Auto Hidden
Float Property LastConsumeTime Auto Hidden
Float Property HealthBuffInc = 0.55 Auto Hidden
Float Property HealthBuffDec = 0.30 Auto Hidden
Float Property MagickaBuffInc = 0.65 Auto Hidden
Float Property MagickaBuffDec = 0.25 Auto Hidden
Float Property StaminaBuffInc = 0.55 Auto Hidden
Float Property StaminaBuffDec = 0.30 Auto Hidden
Float Property HealthRateBuffInc = 150.0 Auto Hidden
Float Property HealthRateBuffDec = 80.0 Auto Hidden
Float Property MagickaRateBuffInc = 170.0 Auto Hidden
Float Property MagickaRateBuffDec = 70.0 Auto Hidden
Float Property StaminaRateBuffInc = 150.0 Auto Hidden
Float Property StaminaRateBuffDec = 80.0 Auto Hidden
Float Property SpeedBuffInc = 70.0 Auto Hidden
Float Property SpeedBuffDec = 30.0 Auto Hidden
Spell Property SuccubusSatiatySpellA Auto
Spell Property SuccubusSatiatySpellB Auto
Spell Property SuccubusSatiatySpellC Auto
Spell Property SuccubusStarvation Auto
Spell SatiatySpell1
Spell SatiatySpell2
Armor Property SuccubusNanka Auto

;母乳関連
Bool IsMilking
Bool Property StopAddMilk Auto Hidden
Potion Property SuccubusMilk Auto
Sound Property SoundMilking Auto

;魂石妊娠用
Bool Property EnableSoulGemPregnancy Auto Hidden
Bool Property AllowAnalPregnancy Auto Hidden
Int Property FertilisationProbability = 5 Auto Hidden
Spell Property PSQSoulGemImpregnateSpell Auto
Spell Property PSQSoulGemBirthingSpell Auto

;精液と愛液
Potion Property SemenPotion Auto
Potion Property SuccubusFluid1 Auto
Potion Property SuccubusFluid2 Auto
Potion Property SuccubusFluid3 Auto
Potion Property SuccubusFluid4 Auto
Potion Property SuccubusFluid5 Auto
Potion Property SuccubusFluid6 Auto
Potion Property SuccubusFluid7 Auto
Potion Property SuccubusFluid8 Auto
EffectShader Property SexLabCumOralShaderPSQ Auto

;サキュバス魔法
Bool Property EnableSuccubusDrainFF = True Auto Hidden
Bool Property EnableSuccubusDrainHealthSpell = True Auto Hidden
Bool Property EnableSuccubusDrainStaminaSpell = True Auto Hidden
Int Property CharmSpellAmmo Auto Hidden
Float Property RestoreMagickaMAX = 100.0 Auto Hidden
Float Property LastReloadTime Auto Hidden
Keyword Property SuccubusSpell Auto
Keyword Property SuccubusSpellNoConsume Auto
Spell Property SuccubusDrainFF01 Auto
Spell Property SuccubusDrainFF02 Auto
Spell Property SuccubusDrainFF03 Auto
Spell Property SuccubusDrainFF04 Auto
Spell Property SuccubusDrainFF05 Auto
Spell Property SuccubusDrainFF06 Auto
Spell Property SuccubusDrainFF07 Auto
Spell Property SuccubusDrainFF08 Auto
Spell Property SuccubusDrainHealthSpell01 Auto
Spell Property SuccubusDrainHealthSpell02 Auto
Spell Property SuccubusDrainHealthSpell03 Auto
Spell Property SuccubusDrainHealthSpell04 Auto
Spell Property SuccubusDrainHealthSpell05 Auto
Spell Property SuccubusDrainHealthSpell06 Auto
Spell Property SuccubusDrainHealthSpell07 Auto
Spell Property SuccubusDrainHealthSpell08 Auto
Spell Property SuccubusDrainStaminaSpell01 Auto
Spell Property SuccubusDrainStaminaSpell02 Auto
Spell Property SuccubusDrainStaminaSpell03 Auto
Spell Property SuccubusDrainStaminaSpell04 Auto
Spell Property SuccubusDrainStaminaSpell05 Auto
Spell Property SuccubusDrainStaminaSpell06 Auto
Spell Property SuccubusDrainStaminaSpell07 Auto
Spell Property SuccubusDrainStaminaSpell08 Auto
Spell Property StatsMSGBoxSpell Auto
Spell Property FortifyMSGBoxSpell Auto
Spell Property RestoreMagickaSpell Auto
Spell Property MasturbationSpell Auto
Spell Property CreatePenisSpellSelf Auto
Spell Property CreatePenisSpellOther Auto
Spell Property SuccubusCharmSpell Auto
Spell Property HenshinSpell Auto
Spell Property StarkRealitySpell Auto
Spell Property SuccubusCurseSpell Auto
Spell Property SuccubusRaiseArousalSpell Auto
Spell Property SuccubusArousalCloakSpell Auto
Spell Property SuccubusSpellLearningMSGBoxSpell Auto
Spell Property SuccuKanashibari Auto
Spell Property SuccubusSummonMerchantSpell Auto
Bool Property EnableSpellCastingNotification Auto Hidden
Bool Property EnableSuccubusSpellBooster = True Auto Hidden
Bool Property EnableEnergyConsumingBySuccubusSpell = True Auto Hidden
GlobalVariable Property TransformBooster Auto
Perk Property SuccubusSpellBoostPerk Auto

;バニラ魔法
Spell Property SuccuFirebolt Auto
Spell Property SuccuIceSpike Auto
Spell Property SuccuLightningBolt Auto
Spell Property SuccuFireball Auto
Spell Property SuccuIceStorm Auto
Spell Property SuccuChainLightning Auto
Spell Property SuccuIncinerate Auto
Spell Property SuccuIcySpear Auto
Spell Property SuccuThunderbolt Auto
Spell Property SuccuFireStorm Auto
Spell Property SuccuBlizzard Auto
Spell Property SuccuCourage Auto
Spell Property SuccuCalm Auto
Spell Property SuccuFear Auto
Spell Property SuccuFury Auto
Spell Property SuccuRally Auto
Spell Property SuccuPacify Auto
Spell Property SuccuRout Auto
Spell Property SuccuFrenzy Auto
Spell Property SuccuCallToArms Auto
Spell Property SuccuHarmony Auto
Spell Property SuccuHysteria Auto
Spell Property SuccuMayhem Auto
Spell Property SuccuOakflesh Auto
Spell Property SuccuIronflesh Auto
Spell Property SuccuStoneflesh Auto
Spell Property SuccuEbonyflesh Auto
Spell Property SuccuDragonhide Auto
Spell Property SuccuHealOther Auto
Spell Property SuccuFastHealing Auto
Spell Property SuccuGrandHealing Auto
Spell Property SuccuCloseWounds Auto
Spell Property SuccuParalyze Auto

;サキュバス特殊能力
Bool Property EnableFortifyBartar = True Auto Hidden
Bool Property EnableFortifyDestruction = True Auto Hidden
Bool Property EnableFortifyIllusion = True Auto Hidden
Bool Property EnableMagicResistance = True Auto Hidden
Bool Property PhysicalWeakness Auto Hidden
Float Property FortifyDestructionMult = 1.0 Auto Hidden
Float Property FortifyIllusionMult = 1.0 Auto Hidden
Float Property MagicResistanceMult = 1.0 Auto Hidden
Spell Property ImmunityToSTD Auto
Spell Property FortifyMagickaSpell Auto
Spell Property FortifySneakSpell Auto
Spell Property FortifyBartarSpell1 Auto
Spell Property FortifyBartarSpell2 Auto
Spell Property FortifyBartarSpell3 Auto
Spell Property FortifyBartarSpell4 Auto
Spell Property FortifyBartarSpell5 Auto
Spell Property FortifyBartarSpell6 Auto
Spell Property FortifyBartarSpell7 Auto
Spell Property FortifyBartarSpell8 Auto
Spell Property FortifyDestructionSpell Auto
Spell Property FortifyIllusionSpell Auto
Spell Property MagicResistanceSpell Auto
Perk Property SuccubusFeed Auto
Perk Property FortifySneakPerk Auto
Perk Property FortifyBartarPerk Auto
Perk Property FortifyIllusionPerk Auto

;サキュバス模様
Bool Property HenshinTattoo Auto Hidden
Bool Property EnableBodyPaintTintChangeSatiation Auto Hidden
Bool Property EnableBodyPaintAlphaChangeSatiation Auto Hidden
Bool Property EnableBodyPaintGlowTintChangeSatiation Auto Hidden
Bool Property EnableBodyPaintGlowAlphaChangeSatiation Auto Hidden
Int Property BPTintColorStart = 0xFFFF0000 Auto Hidden
Int Property BPTintColorEnd =  0xFF000000 Auto Hidden
Int Property BPGTintColorStart = 0xFF0000 Auto Hidden
Int Property BPGTintColorEnd =  0x000000 Auto Hidden
Float Property BPGAlphaStart = 2.0 Auto Hidden
Float Property BPGAlphaEnd =  0.0 Auto Hidden
Int BPTintCurrentColor
Float BPTintDefRed = 255.0
Float BPTintDefGreen = 0.0
Float BPTintDefBlue = 0.0
Float BPTintColorMaxRed = 255.0
Float BPTintColorMaxGreen = 0.0
Float BPTintColorMaxBlue = 0.0
Float BPTintColorTempRed
Float BPTintColorTempGreen
Float BPTintColorTempBlue
Int BPGTintCurrentColor
Float BPGTintDefRed = 255.0
Float BPGTintDefGreen = 0.0
Float BPGTintDefBlue = 0.0
Float BPGTintColorMaxRed = 255.0
Float BPGTintColorMaxGreen = 0.0
Float BPGTintColorMaxBlue = 0.0
Float BPGTintColorTempRed
Float BPGTintColorTempGreen
Float BPGTintColorTempBlue
Float BPGCurrentAlpha
Float BPGAlphaDef = 2.0

;自分以外サキュバス模様
Bool Property EnableCursePaintGradient Auto Hidden
Bool Property EnableCursePaintTint Auto Hidden
Bool Property EnableCursePaintAlpha Auto Hidden
Bool Property EnableCursePaintGlowTint Auto Hidden
Bool Property EnableCursePaintGlowAlpha Auto Hidden
Spell Property SuccubusCurseCloakSpell Auto Hidden
Faction Property SuccubusCursedFaction Auto Hidden

;サキュバス飛ぶ
Bool Property EnableAutoAddFlying = True Auto Hidden
Int Property CanFlyingLevel = 4 Auto Hidden
Float Property WingMaxJumpHeight = 280.0 Auto Hidden
Float Property DefaultJumpHeight = 76.0 Auto Hidden
GlobalVariable Property HasWing Auto
Spell Property SuccubusFlyingSpell Auto
Perk Property SuccubusWingPerk Auto

;サキュバスアイ
Bool NightEyeProceeding
Bool Property SuccubusNightEyeEnabled Auto Hidden
Float Property SuccubusNightEyeStrength = 0.5 Auto Hidden
Spell Property DetectArousalCloakSpell Auto
Spell Property TerminateDetectArousalSpell Auto
ImageSpaceModifier Property SuccubusNightEyeImod Auto
ImageSpaceModifier Property SuccubusNightEyeIntroFXImod Auto
ImageSpaceModifier Property SuccubusNightEyeOutroFXImod Auto

;サキュバス釣り
Actor[] Fish
Actor[] Slots
Int FishCount
Package Property PSQFishPackage Auto
Message Property PSQLureMSGBox Auto
Spell Property PSQLureCastSpell Auto
Spell Property PSQLureTriggerSpell Auto
Spell Property PSQLureSelfCalmSpell Auto
Spell Property PSQLureRegisterSpell Auto
Spell Property PSQTerminateLureSpell Auto

;使い魔関係
Bool Property ChargeFull Auto Hidden
Bool Property EFFActive Auto Hidden
Float Property ChargeValueAuto = 1000.0 Auto Hidden
Faction Property FamiliarLoyaltyFaction Auto
Faction Property FamiliarDebuffFaction Auto
KeyWord Property PSQFamiliarActor Auto
KeyWord Property PSQContractableActor Auto
Quest Property FollowerExtension Auto Hidden
EFFCore Property XFLMain Auto Hidden

;ちんちん
Bool Property AutoGenderSwitch = True Auto Hidden
Bool Property EnableFutanariPower = True Auto Hidden
Armor Property FemaleSchlongA Auto
Armor Property FemaleSchlongB Auto
Armor Property FemaleSchlongC Auto
Armor Property FemaleSchlongD Auto
Armor Property FemaleSchlongE Auto
Armor Property PlayerHumanSchlong Auto
Armor Property PlayerSuccubusSchlong Auto
Spell Property PowerOfFutanari Auto
Message Property SelectSchlongMSGBox Auto

;Cum Inflation
Bool Property EnableCumInflation = True Auto Hidden
Bool Property CumInflationAnal = True Auto Hidden
Bool Property CumInflationOral = True Auto Hidden
Bool Property ManualDigestionMode Auto Hidden
Float Property CumInflationValue Auto Hidden
Float Property CumInflationIncrement = 10.0 Auto Hidden
Spell Property CumInflationSpell Auto

;体型変化
Bool Property EnableHeightChangeSuccubus Auto Hidden
Bool Property EnableBreastChangeSuccubus Auto Hidden
Bool Property EnableButtChangeSuccubus Auto Hidden
Bool Property EnableGenitalsChangeSuccubus Auto Hidden
Bool Property EnableScrotumChangeSuccubus Auto Hidden
Bool Property EnableBreastGrowthByMilk Auto Hidden
Bool Property EnableBreastGrowthByPregnancy Auto Hidden
Bool Property EnableBellyGrowthByPregnancy Auto Hidden
Bool Property EnableBodyslideMorph Auto Hidden
Float Property SuccubusHeight = 1.0 Auto Hidden
Float Property SuccubusBreast = 1.0 Auto Hidden
Float Property SuccubusButt = 1.0 Auto Hidden
Float Property SuccubusGenitals = 1.0 Auto Hidden
Float Property SuccubusScrotum = 1.0 Auto Hidden
Float Property BreastScaleMax = 5.0 Auto Hidden
Float Property BellyScaleMax = 7.0 Auto Hidden

;変身
Bool Property IsHenshined Auto Hidden
Bool Property IsHenshinchu Auto Hidden
Bool Property HenshinCuirass Auto Hidden
Bool Property HenshinBoots Auto Hidden
Bool Property HenshinGloves Auto Hidden
Bool Property HenshinWings Auto Hidden
Bool Property HenshinHorn Auto Hidden
Bool Property HenshinTail Auto Hidden
Bool Property HenshinSkin Auto Hidden
Bool Property HenshinBody Auto Hidden
Bool Property HenshinPenis Auto Hidden
Bool Property HenshinHair Auto Hidden
Bool Property HenshinHairColor Auto Hidden
Bool Property HenshinEyes Auto Hidden
Bool Property HenshinIsCrime Auto Hidden
Bool Property HenshinFear Auto Hidden
Bool Property HenshinBuff Auto Hidden
Bool Property HenshinArmorRate Auto Hidden
Bool Property CanWalkOnTheWater Auto Hidden
Int Property PSQSkinColor = -16775751 Auto Hidden
Int Property PSQSkinColorAlpha = 255 Auto Hidden
Int Property PSQSuccubusHairColorInt Auto Hidden
Int Property OrgSkinColor Auto Hidden
Float Property HenshinBuffRateHealth = 30.0 Auto Hidden
Float Property HenshinBuffRateMagicka = 30.0 Auto Hidden
Float Property HenshinBuffRateStamina = 30.0 Auto Hidden
Float Property HenshinBuffRateCarry = 30.0 Auto Hidden
Float Property SuccubusArmorMagnitude = 50.0 Auto Hidden
Armor Property PSQSuccubusBoots Auto
Armor Property PSQSuccubusCuirass Auto
Armor Property PSQSuccubusGauntlets Auto
Armor Property PSQSuccubusHorns Auto
Armor Property PSQSuccubusWings Auto
Armor Property PSQSuccubusTail Auto
Armor Property PSQSuccubusSkin Auto
Armor Property OrgBoots Auto Hidden
Armor Property OrgGloves Auto Hidden
Armor Property OrgArmor Auto Hidden
Armor Property OrgSkin Auto Hidden
Armor Property PSQHumanSkin Auto
Armor Property SuccubusStaticWings Auto
Armor Property SuccubusDragonWingsCommon Auto
Armor Property SuccubusDragonWingsBoss Auto
Armor Property SuccubusDragonWingsForest Auto
Armor Property SuccubusDragonWingOdaviing Auto
Armor Property SuccubusDragonWingsParthurnax Auto
Armor Property SuccubusDragonWingsSnow Auto
Armor Property SuccubusDragonWingsTundra Auto
Armor Property SuccubusDragonWingsUnderskin Auto
Armor Property SuccubusDragonWingsAlduin Auto
Armor Property SuccubusDragonWingsBloody Auto
Armor Property SuccubusDragonWingsRealFlying Auto
Armor Property SuccubusFairyWings Auto
HeadPart Property PSQSuccubusHead Auto
HeadPart Property PSQSuccubusHair Auto
HeadPart Property PSQSuccubusEyes Auto
HeadPart Property PSQHumanHead Auto
HeadPart Property OrgHead Auto Hidden
HeadPart Property OrgHair Auto Hidden
HeadPart Property OrgEyes Auto Hidden
ColorForm Property PSQSuccubusHairColor Auto
ColorForm Property OrgHairColor Auto Hidden
Sound Property SoundHenshinMoan Auto
Formlist Property SuccubusFoeList Auto
EffectShader Property SuccubusTransFXS Auto
EffectShader Property FireFXShader Auto
EffectShader Property ShockPlayerCloakFXShader Auto
Spell Property SuccubusWaterWalking Auto
Spell Property SuccubusArmorSpell Auto
Spell Property SuccubusFormFearSpell Auto
Spell Property SuccubusHenshinBonusSpell Auto
Faction Property SuccubusFoeFaction Auto
Faction Property SuccubusNPCFaction Auto
TextureSet Property PSQSuccubusEyesTexture Auto
Spell Property TransformNPCSuccubusSpell Auto

;PSQRape関連
Bool Property EnablePSQRape Auto Hidden
Int Property RapeArousalThreshold = 80 Auto Hidden
Float Property RapeHealthThreshold = 30.0 Auto Hidden
Float Property RapeChance = 30.0 Auto Hidden
Faction Property PSQRapeNoAttackFaction Auto
Formlist Property SuccubusFriendList Auto
KeyWord Property MagicInfluence Auto

;Aroused関連
Bool Property UseArousalAtDrain = True Auto Hidden
Bool Property FluidNeedArousal = True Auto Hidden
Bool Property ArousedForceTransform Auto Hidden
Bool Property ArousedForceDeTransform Auto Hidden
Float Property RequiredToFluid = 30.0 Auto Hidden
Float Property TransformThreshold = 90.0 Auto Hidden
Float Property DeTransformThreshold = 30.0 Auto Hidden
Spell Property SuccubusForceTransform Auto

;RND用
Spell Property PSQEatSemenSpell Auto
GlobalVariable Property FoodPointsSemen Auto
GlobalVariable Property WaterPointsSemen Auto

;ホットキーの値
Int Property HotkeyEnableDrain = 211 Auto Hidden
Int Property HotkeyAllowKill = 211 Auto Hidden
Int Property HotkeySuccubusCharmSpell = 211 Auto Hidden
Int Property HotkeyMasturbation = 211 Auto Hidden
Int Property HotkeyRestoreMagicka = 211 Auto Hidden
Int Property HotkeyExtractSemenPotion = 211 Auto Hidden
Int Property HotkeyEnableSoulTrap = 211 Auto Hidden
Int Property HotkeyCreatePenisSelf = 211 Auto Hidden
Int Property HotkeyHenshin = 211 Auto Hidden
Int Property HotkeyEnergyBar = 211 Auto Hidden
Int Property HotkeyNightEye = 211 Auto Hidden
Int Property HotkeyDetectArousal = 211 Auto Hidden
Int Property HotkeySuccubusStats = 211 Auto Hidden
Int Property HotkeyToggleFlying = 211 Auto Hidden
Int Property HotkeyFlyingSpellRight = 211 Auto Hidden
Int Property HotkeyIncreaseNode = 211 Auto Hidden
Int Property HotkeyDecreaseNode = 211 Auto Hidden
Int Property HotkeyHeight = 211 Auto Hidden
Int Property HotkeyWeight = 211 Auto Hidden
Int Property HotkeyBreastNode = 211 Auto Hidden
Int Property HotkeyButtNode = 211 Auto Hidden
Int Property HotkeyGenitalsNode = 211 Auto Hidden
Int Property HotkeyScrotumNode = 211 Auto Hidden
Int Property HotkeyDigestion = 211 Auto Hidden

;Strings
String Property StringGot Auto
String Property StringSemenPotionsFrom Auto
String Property StringDrained Auto
String Property StringSemenFrom Auto
String Property StringSuccubusEXP Auto
String Property StringCurrent Auto
String Property StringUsed Auto
String Property StringSatiation Auto
String Property StringConsumptionPerDay Auto

;サキュバス化時専用のプロパティ
Bool Property AllowHybrid Auto Hidden
GlobalVariable Property PlayerIsVampire Auto
GlobalVariable Property PlayerIsWerewolf Auto
Spell Property SuccubusCureDisease Auto
Spell Property WerewolfChange Auto
Spell Property WerewolfImmunity Auto
Quest Property C00 Auto
Quest Property PlayerVampireQuest Auto

;開発の指針
;経験値周りや母乳などの数値をなんかするやつは適当だが後に回そう。
;プロパティとメニューをなんとかして動くように仕立てるのが先。

Event OnInit()
	RegisterForSingleUpdate(15)
EndEvent

;一定時間毎に色々やる処理
Event OnUpdate()
	If PlayerIsSuccubus.GetValue() == 1
		;エナジー消費処理
		If !StopEnergyConsuming
			ConsumeTimer = GameDaysPassed.GetValue() - LastConsumeTime
			Satiety(-1 * EnergyConsumption * ConsumeTimer)
			LastConsumeTime = GameDaysPassed.GetValue()
		EndIf
		
		;母乳追加処理
		If !StopAddMilk
			AddMilk()
		EndIf
		
		;Succubus Charmを補給
		ReloadSuccubusCharm()
		
		;もしもサキュバスになった後に吸血鬼か犬になっていた場合サキュバスでなくする機能
		If PlayerIsVampire.GetValue() == 1 || PlayerIsWerewolf.GetValue() == 1
			If !AllowHybrid
				QuitSuccubus()
			EndIf
		EndIf
	Else
		If GetIntValue(Game.GetPlayer(), "PSQ_SpellON") == 1
			SetIntValue(Game.GetPlayer(), "PSQ_SpellON", 0)
			BecomeSuccubus()
		EndIf
	EndIf
	RegisterForSingleUpdate(15)
EndEvent

;セックス開始時に発生する色々
Event PSQStartSex(Form FormRef, Int TID)
	If PlayerIsSuccubus.GetValue() == 1	
	
		sslThreadController Thread = SexLab.GetController(tid)
		actor[] actors = Thread.Positions
		Int NumberOfActors = actors.Length
		
		;プレイヤーが入っていたらとはしたものの多分無くてもいい。
		If actors.Find(PlayerRef) >= 0
			
			;強姦か否かを判別
			Bool IsRape
			If Thread.VictimRef != None
				IsRape = True
			EndIf
			
			;オナニーだったらLureするか聞く
			If NumberOfActors == 1
				If PSQLureMSGBox.Show() == 0
					PlayerRef.AddSpell(PSQLureCastSpell, False)
				EndIf
			EndIf
			
			Int i = NumberOfActors - 1
			Int Aractor
			While i >= 0
				Aractor = i
				;セックス開始時のArousalを記録
				SetIntValue(actors[Aractor], "PSQ_ArousalAtBeginning", SlaUtil.GetActorArousal(actors[Aractor]))
				
				;レイプ時の体力回復を止めるSpellを追加(トロールとか回復速すぎて体力減らせない)
				;レイプ被害者だけが回復しないようにするか今考えています
				If IsRape
					actors[Aractor].AddSpell(SuccubusRapeVictimDebuffSpell, False)
				EndIf
				
				;NPCにエナジーを設定
				If actors[Aractor] != PlayerRef
					SetEnergy(actors[Aractor])
				EndIf
				i -= 1
			EndWhile
			
		EndIf
	EndIf
EndEvent

;セックス正常終了時に発生する色々。どんどん複雑になっていく気がする。
Event PSQOrgasm(Form FormRef, Int TID)
	If PlayerIsSuccubus.GetValue() == 1	
		sslThreadController Thread = SexLab.GetController(tid)
		sslBaseAnimation animation = Thread.Animation
		actor[] actors = Thread.Positions
		Int NumberOfActors = actors.Length
		Int CumID
		
		;プレイヤーが入っていたらとはしたものの多分無くてもいい。
		If actors.Find(PlayerRef) >= 0
			If NumberOfActors == 1
				AddSuccubusFluid()
			Else
				;PlayerがFemalePositionであるか
				Bool PlayerIsFemalePosition
				If Thread.ActorAlias(PlayerRef).MalePosition == False
					PlayerIsFemalePosition = True
				EndIf
				
				Bool VaginalCum
				Bool AnalCum
				Bool OralCum
				Bool CanCumInflation
				Bool CanExtractSemenPotion
				Bool CanImpregnant
				
				If PlayerIsFemalePosition
					;whileループでプレイヤーのposition numberを得る
					;もっといい方法があるかもしれないが知らないのでこれ
					Int PlayerPosition
					Int PP = NumberOfActors - 1
					While PP >= 0
						If actors[PP] == PlayerRef
							PlayerPosition = PP
							PP -= 100
						EndIf
						PP -= 1
					EndWhile
					
					;射精位置は得られるようになったらしいけど、3人以上で誰がどこにっていうのは把握不可っぽい
					CumID = Animation.GetCumID(PlayerPosition, Thread.Stage)
					If CumID == 1 || CumID == 4 || CumID == 5 || CumID == 7
						VaginalCum = True
					EndIf
					If CumID == 3 || CumID == 5 || CumID == 6 || CumID == 7
						AnalCum = True
					EndIf
					If CumID == 2 || CumID == 4 || CumID == 6 || CumID == 7
						OralCum = True
					EndIf
					
					If CumID > 0
						CanExtractSemenPotion = True
					EndIf
					
					If EnableSoulGemPregnancy && (VaginalCum || (AnalCum && AllowAnalPregnancy))
						CanImpregnant = True
					EndIf
					
					;CumInfrationに備える。膣は必ず、尻と口は選択制。
					If EnableCumInflation
						If VaginalCum || (CumInflationAnal && AnalCum) || (CumInflationOral && OralCum)
							CanCumInflation = True
						EndIf
					EndIf
				EndIf
				
				;強姦か否かを判別
				Bool PlayerIsVictim = False
				Bool PlayerIsAggressor = False
				If Thread.IsVictim(PlayerRef)
					PlayerIsVictim = True
				EndIf
				If Thread.IsAggressor(PlayerRef)
					PlayerIsAggressor = True
				EndIf
				
				;増加する経験値とか初期化
				CumInflationValue = 0
				SetFloatValue(PlayerRef, "PSQ_IncreaseEXP", 0)
				
				;セックス時間を出す。
				Float SexTime = Thread.TotalTime
				If FastMode
					SexTime = FastModeTime
				EndIf
				
				;吸い取る量を計算
				Float DrainValue = SexTime * DrainValueMultipliers * SuccubusRank.GetValue()
				
				If UseArousalAtDrain
					Float ArousedRank = GetIntValue(PlayerRef, "PSQ_ArousalAtBeginning") as Float
					If ArousedRank < 50
						ArousedRank = 50
					EndIf
					DrainValue = DrainValue * (ArousedRank / 50)
				EndIf
				
				If PlayerIsAggressor
					DrainValue = DrainValue * 2
				EndIf
				
				;ドレーン
				Int i = NumberOfActors - 1
				Int Victim
				While i >= 0
					Victim = i
					If actors[Victim] != PlayerRef
						Bool AllowDrain = IsNotUndead(actors[Victim])
						Bool IsMalePosition
						Bool RealPenis
						
						If !Thread.ActorAlias(actors[Victim]).IsUsingStrapon()
							RealPenis = True
						EndIf
						
						If Thread.ActorAlias(actors[Victim]).MalePosition || !actors[Victim].HasKeywordString("ActorTypeNPC")
							IsMalePosition = True
						EndIf
						
						If AllowDrain
							SuccubusDrain(actors[Victim], DrainValue, PlayerIsVictim, PlayerIsAggressor, CanExtractSemenPotion, CanImpregnant, OralCum, CanCumInflation, IsMalePosition, RealPenis)
						EndIf
						
						If IsFamiliar(actors[Victim])
							ChargeFamiliar(actors[Victim])
						EndIf
						
						If EnableCaptive
							Captive(actors[Victim], DrainValue)
						EndIf
					EndIf
					i -= 1
				EndWhile
				If CanCumInflation
					CumInflationSpell.Cast(PlayerRef)
				EndIf
				Satiety()
				SatietyNotification()
				;経験値追加
				SuccubusLevelUp(GetFloatValue(PlayerRef, "PSQ_IncreaseEXP"))
			EndIf
		EndIf
	EndIf
EndEvent

;セックス終了時の処理。なんか変えた結果ダメージと死亡判定はここに移すことになった。
Event PSQEndSex(Form FormRef, Int TID)
	If PlayerIsSuccubus.GetValue() == 1	
		sslThreadController Thread = SexLab.GetController(tid)
		sslBaseAnimation animation = Thread.Animation
		actor[] actors = Thread.Positions
		Int NumberOfActors = actors.Length
		
		Int i = actors.Length - 1
		While i >= 0
			actors[i].RemoveSpell(SuccubusRapeVictimDebuffSpell)
			actors[i].RemoveFromFaction(PSQRapeNoAttackFaction)
			
			If actors[i] != PlayerRef
				If GetIntValue(Actors[i], "PSQ_SoulTrapMark") == 1
					SetIntValue(Actors[i], "PSQ_SoulTrapMark", 0)
					SuccubusSoulTrap.Cast(PlayerRef, Actors[i])
					Utility.Wait(0.1)
				EndIf
				
				Actors[i].DamageActorValue("Health", GetFloatValue(Actors[i], "PSQ_DrainDamageHealth"))
				Actors[i].DamageActorValue("Stamina", GetFloatValue(Actors[i], "PSQ_DrainDamageStamina"))
				If GetIntValue(Actors[i], "PSQ_DeathMark") == 1
					SetIntValue(Actors[i], "PSQ_DeathMark", 0)
					Actors[i].Kill()
				EndIf
			EndIf
			i -= 1
		EndWhile
		
		;ルアー解決処理
		PlayerRef.RemoveSpell(PSQLureCastSpell)
		If FishCount > 1
			Fishery()
		EndIf
	EndIf
EndEvent

;相手がアンデッドかどうか判別するだけのなんか
Bool Function IsNotUndead(Actor Hector)
	If Hector.HasKeyword(PSQFamiliarActor) == 1 || Hector.HasKeyword(PSQContractableActor) == 1
		Return False
	EndIf
	
	If Hector.HasKeyword(ActorTypeUndead) == 1 || Hector.IsCommandedActor() == 1
		If AllowDrainFromUndead
			Return True
		EndIf
		Return False
	EndIf
	Return True
EndFunction

;相手がマイファミリアーかどうか判別するやつ
Bool Function IsFamiliar(Actor Hector)
	If Hector.HasKeyword(PSQFamiliarActor) == 1
		Return True
	EndIf
	Return False
EndFunction

;相手から吸えるエナジーを計算
Function SetEnergy(Actor Victim)
	;相手の所持エナジーの最大値を計算。デフォルトでは基礎体力の3倍。
	Float NPCMaxEnergy = Victim.GetBaseActorValue("Health") * CalcMaxEnergyHealth
	
	;対象が人間である場合最大値の最小値を設定可能。一般市民からの吸精が無意味になることがあるため。
	Bool UseMinEnergy = False
	If AdjustMinEnergyOfHuman
		If Victim.HasKeywordString("ActorTypeNPC")
			If NPCMaxEnergy < MinEnergyOfHuman
				NPCMaxEnergy = MinEnergyOfHuman
				UseMinEnergy = True
			EndIf
		EndIf
	EndIf
	
	;前回の吸精からの日数を取得。
	Float Timer = GameDaysPassed.GetValue() - GetFloatValue(Victim, "PSQ_LastEnergyCalcTime")
	If GetFloatValue(Victim, "PSQ_LastEnergyCalcTime") == 0.0
		Timer = 1000
	EndIf
	
	;対象が人間ではない場合、大雑把に分類されたRaceごとの経験によって所持エナジーと回復量に倍率をかける。最大2倍。
	If !Victim.HasKeywordString("ActorTypeNPC")
		String KeyString = "MyUniAnimalExp_" + GetVictimRace(Victim)
		
		Float RaceLikeMult = GetFloatValue(PlayerRef, KeyString) / 100 + 1
		If RaceLikeMult > 2.0
			RaceLikeMult = 2.0
		EndIf		
		
		NPCMaxEnergy = NPCMaxEnergy * RaceLikeMult
		Timer = Timer * RaceLikeMult
	EndIf		
	
	;恋人のエナジー回復量は1.5倍になる。
	If Victim.GetRelationshipRank(PlayerRef) == 4
		Timer = Timer * LoversRestoreMult
	EndIf
	
	;サキュバスの呪いがかけられていたらエナジー回復量と最大値が増える。積極的に呪っていこう。
	If GetIntValue(Victim, "PSQ_Accursed") == 1
		Timer = Timer * 1.5
		NPCMaxEnergy = NPCMaxEnergy * 2.0
	EndIf
	
	;基礎体力×日数だけエナジーを追加。最低保障値を使用していた場合は最低保障値/3*日数。
	Float Energy
	If UseMinEnergy
		Energy = GetFloatValue(Victim, "PSQ_EnergyOfActor") + (MinEnergyOfHuman / 3) * Timer
	Else
		Energy = GetFloatValue(Victim, "PSQ_EnergyOfActor") + Victim.GetBaseActorValue("Health") * Timer
	EndIf
	
	If Energy > NPCMaxEnergy
		Energy = NPCMaxEnergy
	EndIf
	
	SetFloatValue(Victim, "PSQ_EnergyOfActor", Energy)
	SetFloatValue(Victim, "PSQ_LastEnergyCalcTime", GameDaysPassed.GetValue())
EndFunction

;吸精
Function SuccubusDrain(Actor Target, Float DrainValue, Bool PlayerIsVictim, Bool PlayerIsAggressor, Bool CanExtractSemenPotion, Bool CanImpregnant, Bool IsOral, Bool CumInflation, Bool IsMalePosition, Bool RealPenis)
	If EnableDrain
		If UseArousalAtDrain
			DrainValue = ProcessingArousal(Target, DrainValue)
		EndIf
		
		If Target.GetRelationshipRank(PlayerRef) == 4
			DrainValue = DrainValue * LoversDrainMult
		EndIf
		
		Float DrainEnergy = DrainValue
		Float DamageHealth = DrainValue
		
		If DamageHealth >= Target.GetActorValue("Health")
			If KillAtDrain(PlayerIsVictim, PlayerIsAggressor)
				SetIntValue(Target, "PSQ_DeathMark", 1)
				If SoulTrapWhenKillAtDrain(PlayerIsVictim, PlayerIsAggressor)
					SetIntValue(Target, "PSQ_SoulTrapMark", 1)
				EndIf
			Else
				DamageHealth = Target.GetActorValue("Health") - 1
			EndIf
		EndIf
		
		If DrainEnergy > GetFloatValue(Target, "PSQ_EnergyOfActor")
			DrainEnergy = GetFloatValue(Target, "PSQ_EnergyOfActor")
		EndIf
		
		;対象に与えるダメージとCumInflation値を記録する
		SetFloatValue(Target, "PSQ_DrainDamageHealth", DamageHealth)
		SetFloatValue(Target, "PSQ_DrainDamageStamina", DrainValue)
		If CumInflation && IsMalePosition && RealPenis
			CumInflationValue = CumInflationValue + DrainEnergy
		EndIf
		
		;ドレイン処理だ。エナジー化を手動にするモードを追加した。
		If !ManualDigestionMode || !CumInflation || !IsMalePosition || !RealPenis
			SetFloatValue(Target, "PSQ_EnergyOfActor", GetFloatValue(Target, "PSQ_EnergyOfActor") - DrainEnergy)
		EndIf
		Float IncreaseEXP = GetFloatValue(PlayerRef, "PSQ_IncreaseEXP") + DrainEnergy / (SuccubusRank.GetValue() * 100)
		SetFloatValue(PlayerRef, "PSQ_IncreaseEXP", IncreaseEXP)
		
		;対象が人間ではないなら種族経験値を追加する。
		If !Target.HasKeywordString("ActorTypeNPC")
			String KeyString = "MyUniAnimalExp" + GetVictimRace(Target)
			SetFloatValue(PlayerRef, KeyString, GetFloatValue(PlayerRef, KeyString) + 1.0)
		EndIf
		
		;フラグによって薬にするかどうか決めるが最低一個分の吸収量がなかったら普通にやる
		If SemenPotionChecker() && DrainEnergy >= 50 && CanExtractSemenPotion
			Int Quantity
			While DrainEnergy >= 50
				Quantity += 1
				DrainEnergy -= 50
			EndWhile
			PlayerRef.AddItem(SemenPotion , Quantity, True)
			Debug.Notification(StringGot + Quantity + StringSemenPotionsFrom + Target.GetLeveledActorBase().GetName())
		Else
			SuccubusEnergy.SetValue(SuccubusEnergy.GetValue() + DrainEnergy)
			PlayerRef.RestoreActorValue("Magicka", DrainEnergy)
			Float Manpukudo = SuccubusEnergy.GetValue() / MaxEnergy
			SEBU.UpdateEnergyBar(Manpukudo)
			Debug.Notification(StringDrained + DrainEnergy as Int + StringSemenFrom + Target.GetLeveledActorBase().GetName())
			If CanImpregnant
				If FertilisationProbability >= Utility.RandomInt(1, 100)
					PSQSoulGemImpregnateSpell.Cast(PlayerRef)
				EndIf
			EndIf
			If IsOral
				FoodPointsSemen.SetValue(DrainEnergy / 10)
				WaterPointsSemen.SetValue(DrainEnergy / 15)
				PSQEatSemenSpell.Cast(PlayerRef)
			EndIf
		EndIf
	EndIf
EndFunction

;精液の薬にするかどうか判別するためのなんか
Bool Function SemenPotionChecker()
	If ExtractSemenPotion || AutoExtractSemenPotion && AutoExtractSemenPotionThreshold < SuccubusEnergy.GetValue() / MaxEnergy * 100
		Return True
	EndIf
	Return False
EndFunction

;吸精時に殺すかどうかを決めるだけのなんか 0 == 常に 1 == Aggressorの時のみ 2 == Victimの時のみ 3 == 1+2
Bool Function KillAtDrain(Bool PisV, Bool PisA)
	If AllowKill
		If ConditionToKill == 0 || ConditionToKill == 1 && PisA || ConditionToKill == 2 && PisV == 1 || ConditionToKill == 3 && PisA || ConditionToKill == 3 && PisV
			Return True
		EndIf
	EndIf
	Return False
EndFunction

;吸精時に殺す場合魂縛するかどうかを決めるだけのなんか 0 == 常に 1 == Aggressorの時のみ 2 == Victimの時のみ 3 == 1+2
Bool Function SoulTrapWhenKillAtDrain(Bool PisV, Bool PisA)
	If EnableSoulTrap
		If ConditionToSoulTrap == 0 || ConditionToSoulTrap == 1 && PisA || ConditionToSoulTrap == 2 && PisV || ConditionToSoulTrap == 3 && PisA || ConditionToSoulTrap == 3 && PisV
			Return True
		EndIf
	EndIf
	Return False
EndFunction

;吸精できる値を欲情度によって変動させるなんか
Float Function ProcessingArousal(Actor Target, Float DrainValue)
	Float ArousedRank = GetIntValue(Target, "PSQ_ArousalAtBeginning") as Float
	Float DrainValueMod = ArousedRank * ArousedRank / 10000
	
	If DrainValueMod < 0.1
		Return DrainValue * 0.1
	Else 
		Return DrainValue * DrainValueMod
	EndIf
EndFunction

;使い魔にエナジーをチャージするやつ
Float Function ChargeFamiliar(Actor FamiliarActor)
	Float ChargeValue
	Float FamiliarMaxEnergy = GetFloatValue(FamiliarActor, "PSQ_FamiliarMaxEnergy")
	
	If GetFloatValue(FamiliarActor, "PSQ_ChargeValue") == 0
		If ChargeFull
			ChargeValue = FamiliarMaxEnergy - GetFloatValue(FamiliarActor, "PSQ_FamiliarEnergy")
		ElseIf ChargeValueAuto != 0
			ChargeValue = ChargeValueAuto
		EndIf
	Else
		ChargeValue = GetFloatValue(FamiliarActor, "PSQ_ChargeValue")
		SetFloatValue(FamiliarActor, "PSQ_ChargeValue", 0)
	Endif
	
	If ChargeValue > SuccubusEnergy.GetValue()
		ChargeValue = SuccubusEnergy.GetValue()
	EndIf
	
	SuccubusEnergy.SetValue(SuccubusEnergy.GetValue() - ChargeValue)
	SetFloatValue(FamiliarActor, "PSQ_FamiliarEnergy", GetFloatValue(FamiliarActor, "PSQ_FamiliarEnergy") + ChargeValue)
	If GetFloatValue(FamiliarActor, "PSQ_FamiliarEnergy") > FamiliarMaxEnergy
		SetFloatValue(FamiliarActor, "PSQ_OverEnergy", GetFloatValue(FamiliarActor, "PSQ_FamiliarEnergy") - FamiliarMaxEnergy)
		SetFloatValue(FamiliarActor, "PSQ_FamiliarEnergy", FamiliarMaxEnergy)
	EndIf
	
	If GetFloatValue(FamiliarActor, "PSQ_FamiliarEnergy") >= 0
		FamiliarActor.RemoveFromFaction(FamiliarDebuffFaction)
	EndIf
	
	Float FamiliarLoyalty = GetFloatValue(FamiliarActor, "PSQ_FamiliarLoyalty")
	FamiliarLoyalty += 1
	If FamiliarLoyalty > 100
		FamiliarLoyalty = 100
	Endif
	SetFloatValue(FamiliarActor, "PSQ_FamiliarLoyalty", FamiliarLoyalty)
	FamiliarActor.SetFactionRank(FamiliarLoyaltyFaction, FamiliarLoyalty as Int)
	
	FamiliarActor.Activate(FamiliarActor)
EndFunction

;セックス時相手を魅了して友好度を上げる処理
Function Captive(Actor Target, Float DrainValue)
	If UseArousalAtDrain
		DrainValue = ProcessingArousal(Target, DrainValue)
	EndIf
	Int TargetDisposition
	Int IncreasingDisposition = 0
	Int CurrentDisposition = Target.GetRelationshipRank(PlayerRef)
	
	Float Threshold = DrainValue / 5 + SuccubusRank.GetValue() * 20
	Float Random = Utility.RandomFloat(0.0, 100.0)
	
	While Threshold >= Random
		IncreasingDisposition += 1
		Threshold -= 100
	EndWhile
	
	If CurrentDisposition >= -4
		If CurrentDisposition < 4
			If CurrentDisposition + IncreasingDisposition > 4
				TargetDisposition = 4
			Else
				TargetDisposition = CurrentDisposition + IncreasingDisposition
			EndIf
			Target.SetRelationshipRank(PlayerRef,TargetDisposition)
		EndIf
	EndIf
EndFunction

;体液を追加する処理
Function AddSuccubusFluid()
	If !FluidNeedArousal || GetIntValue(PlayerRef, "PSQ_ArousalAtBeginning") >= RequiredToFluid as Int
		If SuccubusRank.GetValue() == 1
			PlayerRef.AddItem(SuccubusFluid1, 1)
		ElseIf SuccubusRank.GetValue() == 2
			PlayerRef.AddItem(SuccubusFluid2, 1)
		ElseIf SuccubusRank.GetValue() == 3
			PlayerRef.AddItem(SuccubusFluid3, 1)
		ElseIf SuccubusRank.GetValue() == 4
			PlayerRef.AddItem(SuccubusFluid4, 1)
		ElseIf SuccubusRank.GetValue() == 5
			PlayerRef.AddItem(SuccubusFluid5, 1)
		ElseIf SuccubusRank.GetValue() == 6
			PlayerRef.AddItem(SuccubusFluid6, 1)
		ElseIf SuccubusRank.GetValue() == 7
			PlayerRef.AddItem(SuccubusFluid7, 1)
		ElseIf SuccubusRank.GetValue() == 8
			PlayerRef.AddItem(SuccubusFluid8, 1)
		EndIf
	EndIf
EndFunction

;レベルアップ処理
Function SuccubusLevelUp(Float Value)
	Float EXP = Value * EXPGainedMultipliers
	If EXP != 0
		SuccubusEXP.SetValue(SuccubusEXP.GetValue() + EXP)
		Debug.Notification(StringSuccubusEXP + SuccubusEXP.GetValue() * 100)
	EndIf
	
	If !EnergyModeAlt
		If SuccubusEXP.GetValue() >= 10
			MaxEnergy = 250 * Math.Sqrt(SuccubusEXP.GetValue())
		Else
			MaxEnergy = 60 * SuccubusEXP.GetValue() + 200
		EndIf
	EndIf
	
	Float Rank = SuccubusRank.GetValue()
	Float RootEXP = Math.Sqrt(SuccubusEXP.GetValue() / 6)
	PlayerRef.RemoveSpell(FortifyDestructionSpell)
	PlayerRef.RemoveSpell(FortifyIllusionSpell)
	PlayerRef.RemoveSpell(MagicResistanceSpell)
	FortifyDestructionSpell.SetNthEffectMagnitude(0, (3 * Rank + RootEXP) * FortifyDestructionMult)
	FortifyIllusionSpell.SetNthEffectMagnitude(0, (3 * Rank + RootEXP) * FortifyIllusionMult)
	MagicResistanceSpell.SetNthEffectMagnitude(0, ((2 * Rank + 0.5 * RootEXP) + 7) * MagicResistanceMult)
	FortifyIllusionPerk.SetNthEntryValue(0, 1, 1 + ((3 * Rank + RootEXP) / 100) * FortifyIllusionMult)
	If EnableFortifyDestruction
		PlayerRef.AddSpell(FortifyDestructionSpell, False)
	EndIf
	If EnableFortifyIllusion
		PlayerRef.AddSpell(FortifyIllusionSpell, False)
	EndIf
	If EnableMagicResistance
		PlayerRef.AddSpell(MagicResistanceSpell, False)
	EndIf
	
	EnergyConsumption = MaxEnergy * EnergyConsumptionPerMax / 100
	
	If SuccubusRank.GetValue() == 1 && SuccubusEXP.GetValue() >= 10
		SuccubusRank.SetValue(2)
		Debug.Notification("$PSQ_RankUpTo2")
		Debug.Notification("$PSQ_GotTitle2")
		If EnableSuccubusDrainFF
			PlayerRef.AddSpell(SuccubusDrainFF02, False)
		EndIf
		If EnableSuccubusDrainHealthSpell
			PlayerRef.AddSpell(SuccubusDrainHealthSpell02, False)
		EndIf
		If EnableSuccubusDrainStaminaSpell
			PlayerRef.AddSpell(SuccubusDrainStaminaSpell02, False)
		EndIf
		If EnableFortifyBartar
			PlayerRef.AddSpell(FortifyBartarSpell2, False)
		EndIf
		PlayerRef.AddSpell(SuccuKanashibari, False)
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell01)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell01)
		PlayerRef.RemoveSpell(SuccubusDrainFF01)
		PlayerRef.RemoveSpell(FortifyBartarSpell1)
	ElseIf SuccubusRank.GetValue() == 2 && SuccubusEXP.GetValue() >= 50
		SuccubusRank.SetValue(3)
		Debug.Notification("$PSQ_RankUpTo3")
		Debug.Notification("$PSQ_GotTitle3")
		If EnableSuccubusDrainStaminaSpell
			PlayerRef.AddSpell(SuccubusDrainStaminaSpell03, False)
		EndIf
		If EnableSuccubusDrainHealthSpell
			PlayerRef.AddSpell(SuccubusDrainHealthSpell03, False)
		EndIf
		If EnableSuccubusDrainFF
			PlayerRef.AddSpell(SuccubusDrainFF03, False)
		EndIf
		If EnableFortifyBartar
			PlayerRef.AddSpell(FortifyBartarSpell3, False)
		EndIf
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell02)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell02)
		PlayerRef.RemoveSpell(SuccubusDrainFF02)
		PlayerRef.RemoveSpell(FortifyBartarSpell2)
	ElseIf SuccubusRank.GetValue() == 3 && SuccubusEXP.GetValue() >= 100
		SuccubusRank.SetValue(4)
		Debug.Notification("$PSQ_RankUpTo4")
		Debug.Notification("$PSQ_GotTitle4")
		If EnableSuccubusDrainStaminaSpell
			PlayerRef.AddSpell(SuccubusDrainStaminaSpell04, False)
		EndIf
		If EnableSuccubusDrainHealthSpell
			PlayerRef.AddSpell(SuccubusDrainHealthSpell04, False)
		EndIf
		If EnableSuccubusDrainFF
			PlayerRef.AddSpell(SuccubusDrainFF04, False)
		EndIf
		PlayerRef.AddSpell(FortifyMSGBoxSpell, False)
		If EnableFortifyBartar
			PlayerRef.AddSpell(FortifyBartarSpell4, False)
		EndIf
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell03)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell03)
		PlayerRef.RemoveSpell(SuccubusDrainFF03)
		PlayerRef.RemoveSpell(FortifyBartarSpell3)
	ElseIf SuccubusRank.GetValue() == 4 && SuccubusEXP.GetValue() >= 250
		SuccubusRank.SetValue(5)
		Debug.Notification("$PSQ_RankUpTo5")
		Debug.Notification("$PSQ_GotTitle5")
		If EnableSuccubusDrainStaminaSpell
			PlayerRef.AddSpell(SuccubusDrainStaminaSpell05, False)
		EndIf
		If EnableSuccubusDrainHealthSpell
			PlayerRef.AddSpell(SuccubusDrainHealthSpell05, False)
		EndIf
		If EnableSuccubusDrainFF
			PlayerRef.AddSpell(SuccubusDrainFF05, False)
		EndIf
		If EnableFortifyBartar
			PlayerRef.AddSpell(FortifyBartarSpell5, False)
		EndIf
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell04)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell04)
		PlayerRef.RemoveSpell(SuccubusDrainFF04)
		PlayerRef.RemoveSpell(FortifyBartarSpell4)
	ElseIf SuccubusRank.GetValue() == 5 && SuccubusEXP.GetValue() >= 500
		SuccubusRank.SetValue(6)
		Debug.Notification("$PSQ_RankUpTo6")
		Debug.Notification("$PSQ_GotTitle6")
		If EnableSuccubusDrainStaminaSpell
			PlayerRef.AddSpell(SuccubusDrainStaminaSpell06, False)
		EndIf
		If EnableSuccubusDrainHealthSpell
			PlayerRef.AddSpell(SuccubusDrainHealthSpell06, False)
		EndIf
		If EnableSuccubusDrainFF
			PlayerRef.AddSpell(SuccubusDrainFF06, False)
		EndIf
		If EnableFortifyBartar
			PlayerRef.AddSpell(FortifyBartarSpell6, False)
		EndIf
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell05)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell05)
		PlayerRef.RemoveSpell(SuccubusDrainFF05)
		PlayerRef.RemoveSpell(FortifyBartarSpell5)
	ElseIf SuccubusRank.GetValue() == 6 && SuccubusEXP.GetValue() >= 1000
		SuccubusRank.SetValue(7)
		Debug.Notification("$PSQ_RankUpTo7")
		Debug.Notification("$PSQ_GotTitle7")
		If EnableSuccubusDrainStaminaSpell
			PlayerRef.AddSpell(SuccubusDrainStaminaSpell07, False)
		EndIf
		If EnableSuccubusDrainHealthSpell
			PlayerRef.AddSpell(SuccubusDrainHealthSpell07, False)
		EndIf
		If EnableSuccubusDrainFF
			PlayerRef.AddSpell(SuccubusDrainFF07, False)
		EndIf
		If EnableFortifyBartar
			PlayerRef.AddSpell(FortifyBartarSpell7, False)
		EndIf
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell06)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell06)
		PlayerRef.RemoveSpell(SuccubusDrainFF06)
		PlayerRef.RemoveSpell(FortifyBartarSpell6)
	ElseIf SuccubusRank.GetValue() == 7 && SuccubusEXP.GetValue() >= 2000
		SuccubusRank.SetValue(8)
		Debug.Notification("$PSQ_RankUpTo8")
		Debug.Notification("$PSQ_GotTitle8")
		If EnableSuccubusDrainStaminaSpell
			PlayerRef.AddSpell(SuccubusDrainStaminaSpell08, False)
		EndIf
		If EnableSuccubusDrainHealthSpell
			PlayerRef.AddSpell(SuccubusDrainHealthSpell08, False)
		EndIf
		If EnableSuccubusDrainFF
			PlayerRef.AddSpell(SuccubusDrainFF08, False)
		EndIf
		If EnableFortifyBartar
			PlayerRef.AddSpell(FortifyBartarSpell8, False)
		EndIf
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell07)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell07)
		PlayerRef.RemoveSpell(SuccubusDrainFF07)
		PlayerRef.RemoveSpell(FortifyBartarSpell7)
	EndIf
EndFunction

;釣り
Function Fishery()
	If FishCount > 0
		Slots = sslUtility.PushActor(PlayerRef, Slots)
		
		Int j = 0
		While j < 4
			;Fish一覧を表示
			UIListMenu ListMenu = UIExtensions.GetMenu("UIListMenu") as UIListMenu
			ListMenu.ResetMenu()
			ListMenu.AddEntryItem("End")
			Int i = 0
			While i < FishCount
				ListMenu.AddEntryItem(Fish[i].GetLeveledActorBase().GetName())
				i += 1
			EndWhile
			
			ListMenu.OpenMenu()
			
			;FishをPush
			Int Ret = ListMenu.GetResultInt()
			If Ret == -1 || Ret == 0
				j = 666
			Else
				Slots = sslUtility.PushActor(Fish[Ret - 1], Slots)
				Fish[Ret - 1] = None
			EndIf
			
			;Fishの整理
			If FishCount != 1
				i = 0
				Int k = 0
				While i < FishCount
					If Fish[k] != None
						Fish[k] = Fish[i]
						k += 1
					EndIf
					i += 1
				EndWhile
			Else
				j = 666
			EndIf
			
			j += 1
		EndWhile
		
		If Slots.Length > 1
			TriggerSex()
		Else
			ResetSlots()
			DischargeFish()
		EndIf
	Else
		DischargeFish()
	EndIf
EndFunction

Function TriggerSex()
	sslThreadModel Thread = SexLab.NewThread()
	Slots = SexLab.SortActors(Slots)
	Int i
	While i < Slots.Length
		If Thread.AddActor(Slots[i]) == -1
			Thread.Initialize()
			ResetSlots()
			Return
		EndIf
		i += 1
	EndWhile
	
	Thread.StartThread()
	ResetSlots()
EndFunction

Function RegisterFish(Actor FishActor, Int AI)
	If SexLab.ValidateActor(FishActor) == 1 && !FishActor.HasKeywordString("SexLabActive")
		
		If GetIntValue(PlayerRef, "PSQ_LureEffectOnFemale") == 1
			If FishActor.GetLeveledActorBase().GetSex() == 1
				Return
			EndIf
		EndIf
		If GetIntValue(PlayerRef, "PSQ_LureEffectOnMale") == 1
			If FishActor.GetLeveledActorBase().GetSex() == 0
				Return
			EndIf
		EndIf
		If GetIntValue(PlayerRef, "PSQ_LureEffectOnBeast") == 1
			If !FishActor.HasKeywordString("ActorTypeNPC")
				Return
			EndIf
		EndIf
		If GetIntValue(PlayerRef, "PSQ_LureEffectOnUndead") == 0
			If FishActor.HasKeyword(ActorTypeUndead) == 1 || FishActor.IsCommandedActor() == 1
				Return
			EndIf
		EndIf
		
		SlaUtil.UpdateActorExposure(FishActor, AI)
		If SlaUtil.GetActorArousal(FishActor) > 70
			If !IsSlotted(FishActor) && PlayerRef.HasSpell(PSQLureCastSpell)
				Fish[FishCount] = FishActor
				PSQLureSelfCalmSpell.Cast(FishActor, FishActor)
				ActorUtil.AddPackageOverride(FishActor, PSQFishPackage, 98)
				FishActor.EvaluatePackage()
				FishCount += 1
			EndIf
		EndIf
	EndIf
EndFunction

Function ResetSlots()
	Actor[] Emptyslots
	Slots = Emptyslots
EndFunction

Function DischargeFish()
	While FishCount > 0
		Fish[FishCount - 1] = None
		FishCount -= 1
	EndWhile
	PSQTerminateLureSpell.Cast(PlayerRef, PlayerRef)
EndFunction

Bool Function IsSlotted(Actor FishActor)
	Return Fish.Find(FishActor) != -1
EndFunction

;ミルクを追加する処理だよ
Function AddMilk()
	Float MilkTotal = GetFloatValue(PlayerRef, "PRG_MilkTotal")
	Float MilkBonus = GetFloatValue(PlayerRef, "PRG_MilkBonus")
	Float MilkBase = SuccubusRank.GetValue() + (GetFloatValue(PlayerRef, "PRG_SeedsTotal") / 1500 + MilkBonus / 500)
	If MilkBase > SuccubusRank.GetValue() * 6
		MilkBase = SuccubusRank.GetValue() * 6
	EndIf
	MilkBase = (GameDaysPassed.GetValue() - GetFloatValue(PlayerRef, "PRG_LastUpdateTimeMilk")) * MilkBase
	MilkTotal = MilkTotal + MilkBase
	If MilkTotal > SuccubusRank.GetValue() * 20
		MilkTotal = SuccubusRank.GetValue() * 20
	EndIf
	SetFloatValue(PlayerRef, "PRG_MilkTotal", MilkTotal)
	If !IsHenshined
		SetBreastScaleHuman()
	Else
		SetBreastScaleSuccubus()
	EndIf
	
	If GameDaysPassed.GetValue() - GetFloatValue(PlayerRef, "PRG_LastOvipositionTime") < 7
		MilkBonus = MilkBonus - (MilkBonus * (GameDaysPassed.GetValue() - GetFloatValue(PlayerRef, "PRG_LastUpdateTimeMilk"))) / 7
		SetFloatValue(PlayerRef, "PRG_MilkBonus", MilkBonus)
	Else
		SetFloatValue(PlayerRef, "PRG_MilkBonus", 0.0)
		If GetIntValue(PlayerRef, "PRG_SeedsNum") == 0
			SetIntValue(PlayerRef, "PRG_IsPregnant", 0)
		EndIf
	EndIf
	SetFloatValue(PlayerRef, "PRG_LastUpdateTimeMilk", GameDaysPassed.GetValue())
EndFunction

;搾乳するよ
Function Milking()
	If StorageUtil.GetFloatValue(PlayerRef, "PRG_MilkTotal") >= 1 && !IsMilking
		IsMilking = True
		sslBaseVoice Voice = SexLab.PickVoice(PlayerRef)
		sslBaseExpression Expression = SexLab.PickExpression(PlayerRef)
		Debug.Notification("$PSQ_MilkingNow")
		Int InstanceID = SoundMilking.Play(PlayerRef)
		Int i = 0
		While i < 5
			Expression.Apply(PlayerRef, Utility.RandomInt(40, 100), 1)
			MoanNoWait(Voice, Utility.RandomInt(0, 30))
			Utility.Wait(Utility.RandomFloat(1.5, 2.5))
			i += 1
		EndWhile
		Sound.StopInstance(InstanceID)
		StorageUtil.SetFloatValue(PlayerRef, "PRG_MilkTotal", StorageUtil.GetFloatValue(PlayerRef, "PRG_MilkTotal") - 1)
		PlayerRef.AddItem(SuccubusMilk, 1)
	ElseIf StorageUtil.GetFloatValue(PlayerRef, "PRG_MilkTotal") < 1
		Debug.Notification("$PSQ_NoMilk")
	Else
		Debug.Notification("$PSQ_MilkingNow")
	EndIf
	IsMilking = False
EndFunction

;満腹度を追加する関数
Function Satiety(Float Value = 0.0)
	If PlayerIsSuccubus.GetValue() == 1
		SuccubusEnergy.SetValue(SuccubusEnergy.GetValue() + Value)
		
		If SuccubusEnergy.GetValue() <= 0
			SuccubusEnergy.SetValue(0)
			If EnableStarvation
				PlayerRef.AddSpell(SuccubusStarvation, False)
			Else
				PlayerRef.RemoveSpell(SuccubusStarvation)
			EndIf
		Else
			PlayerRef.RemoveSpell(SuccubusStarvation)
			If SuccubusEnergy.GetValue() > MaxEnergy
				SuccubusEnergy.SetValue(MaxEnergy)
			EndIf
		EndIf
		
		If PlayerRef.HasSpell(SuccubusSatiatySpellA)
			SatiatySpell1 = SuccubusSatiatySpellB
			SatiatySpell2 = SuccubusSatiatySpellA
		Else
			SatiatySpell1 = SuccubusSatiatySpellA
			SatiatySpell2 = SuccubusSatiatySpellB
		EndIf
		
		Float Manpukudo = SuccubusEnergy.GetValue() / MaxEnergy
		SEBU.UpdateEnergyBar(Manpukudo)
		ChangeBodyPaint(Manpukudo)
		Float RootEXP = Math.Sqrt(SuccubusEXP.GetValue())
		If EnableSatiationEffect
			SatiatySpell1.SetNthEffectMagnitude(0, PlayerRef.GetBaseAV("Health") * (Manpukudo * HealthBuffInc - HealthBuffDec))
			SatiatySpell1.SetNthEffectMagnitude(1, PlayerRef.GetBaseAV("Magicka") * (Manpukudo * MagickaBuffInc - MagickaBuffDec))
			SatiatySpell1.SetNthEffectMagnitude(2, PlayerRef.GetBaseAV("Stamina") * (Manpukudo * StaminaBuffInc - StaminaBuffDec))
			SatiatySpell1.SetNthEffectMagnitude(3, Manpukudo * HealthRateBuffInc - HealthRateBuffDec)
			SatiatySpell1.SetNthEffectMagnitude(4, Manpukudo * MagickaRateBuffInc - MagickaRateBuffDec)
			SatiatySpell1.SetNthEffectMagnitude(5, Manpukudo * StaminaRateBuffInc - StaminaRateBuffDec)
			SatiatySpell1.SetNthEffectMagnitude(6, Manpukudo * SpeedBuffInc - SpeedBuffDec)
		Else
			SatiatySpell1.SetNthEffectMagnitude(0, 0)
			SatiatySpell1.SetNthEffectMagnitude(1, 0)
			SatiatySpell1.SetNthEffectMagnitude(2, 0)
			SatiatySpell1.SetNthEffectMagnitude(3, 0)
			SatiatySpell1.SetNthEffectMagnitude(4, 0)
			SatiatySpell1.SetNthEffectMagnitude(5, 0)
			SatiatySpell1.SetNthEffectMagnitude(6, 0)
		EndIf
		SatiatySpell1.SetNthEffectMagnitude(7, Manpukudo * 100)
		PlayerRef.AddSpell(SuccubusSatiatySpellC, False)
		PlayerRef.AddSpell(SatiatySpell1, False)
		PlayerRef.RemoveSpell(SatiatySpell2)
		PlayerRef.RemoveSpell(SuccubusSatiatySpellC)
		If Game.GetGameSettingFloat("fJumpHeightMin") < 300 && HasWing.GetValueInt() == 1
			Game.SetGameSettingFloat("fJumpHeightMin", WingMaxJumpHeight)
		EndIf
		PlayerRef.AddItem(SuccubusNanka, 1, True)
		PlayerRef.EquipItem(SuccubusNanka, abSilent = True)
		PlayerRef.RemoveItem(SuccubusNanka, PlayerRef.GetItemCount(SuccubusNanka), True)
	EndIf
EndFunction

;満腹度メッセージを表示する関数
Function SatietyNotification(Float Value = 0.0, Bool NoticeConsumed = False)
	Float Manpukudo = SuccubusEnergy.GetValue() / MaxEnergy * 100
	If EnableSatiationNotification
		If NoticeConsumed
			Debug.Notification(StringUsed + -(Value as Int) + " / " + StringCurrent + SuccubusEnergy.GetValueInt() + " / " + StringSatiation + (Manpukudo as Int) + "%")
		Else
			Debug.Notification(StringCurrent + SuccubusEnergy.GetValueInt() + " / " + StringSatiation + (Manpukudo as Int) + "%")
		EndIf
	EndIf
EndFunction

;満腹度に応じてBodyPaintを変える関数
Function ChangeBodyPaint(Float Manpukudo)
	If HenshinTattoo && !IsHenshined
		Return
	EndIf
	
	If EnableBodyPaintTintChangeSatiation
		BPTintColorTempRed = BPTintColorMaxRed - BPTintDefRed * Math.Abs(1 - Manpukudo)
		BPTintColorTempGreen = BPTintColorMaxGreen - BPTintDefGreen * Math.Abs(1 - Manpukudo)
		BPTintColorTempBlue = BPTintColorMaxBlue - BPTintDefBlue * Math.Abs(1 - Manpukudo)
		BPTintCurrentColor = SetRed(BPTintCurrentColor, BPTintColorTempRed as Int)
		BPTintCurrentColor = SetGreen(BPTintCurrentColor, BPTintColorTempGreen as Int)
		BPTintCurrentColor = SetBlue(BPTintCurrentColor, BPTintColorTempBlue as Int)
		NiOverride.AddNodeOverrideInt(PlayerRef, true, "Body [Ovl5]", 7, -1, BPTintCurrentColor, true)
		NiOverride.AddNodeOverrideInt(PlayerRef, true, "Hands [Ovl2]", 7, -1, BPTintCurrentColor, true)
		NiOverride.AddNodeOverrideInt(PlayerRef, true, "Feet [Ovl2]", 7, -1, BPTintCurrentColor, true)
		NiOverride.AddNodeOverrideInt(PlayerRef, true, "Face [Ovl2]", 7, -1, BPTintCurrentColor, true)
	EndIf
	
	If EnableBodyPaintAlphaChangeSatiation
		NiOverride.AddNodeOverrideFloat(PlayerRef, true, "Face [Ovl2]", 8, -1, Manpukudo, true)
		NiOverride.AddNodeOverrideFloat(PlayerRef, true, "Feet [Ovl2]", 8, -1, Manpukudo, true)
		NiOverride.AddNodeOverrideFloat(PlayerRef, true, "Hands [Ovl2]", 8, -1, Manpukudo, true)
		NiOverride.AddNodeOverrideFloat(PlayerRef, true, "Body [Ovl5]", 8, -1, Manpukudo, true)
	EndIf
	
	If HenshinTattoo && !EnableBodyPaintAlphaChangeSatiation
		NiOverride.AddNodeOverrideFloat(PlayerRef, true, "Face [Ovl2]", 8, -1, 1.0, true)
		NiOverride.AddNodeOverrideFloat(PlayerRef, true, "Feet [Ovl2]", 8, -1, 1.0, true)
		NiOverride.AddNodeOverrideFloat(PlayerRef, true, "Hands [Ovl2]", 8, -1, 1.0, true)
		NiOverride.AddNodeOverrideFloat(PlayerRef, true, "Body [Ovl5]", 8, -1, 1.0, true)
	EndIf
	
	If EnableBodyPaintGlowTintChangeSatiation
		BPGTintColorTempRed = BPGTintColorMaxRed - BPGTintDefRed * Math.Abs(1 - Manpukudo)
		BPGTintColorTempGreen = BPGTintColorMaxGreen - BPGTintDefGreen * Math.Abs(1 - Manpukudo)
		BPGTintColorTempBlue = BPGTintColorMaxBlue - BPGTintDefBlue * Math.Abs(1 - Manpukudo)
		BPGTintCurrentColor = SetRed(BPGTintCurrentColor, BPGTintColorTempRed as Int)
		BPGTintCurrentColor = SetGreen(BPGTintCurrentColor, BPGTintColorTempGreen as Int)
		BPGTintCurrentColor = SetBlue(BPGTintCurrentColor, BPGTintColorTempBlue as Int)
		NiOverride.AddNodeOverrideInt(PlayerRef, true, "Body [Ovl5]", 0, -1, BPGTintCurrentColor, true)
		NiOverride.AddNodeOverrideInt(PlayerRef, true, "Hands [Ovl2]", 0, -1, BPGTintCurrentColor, true)
		NiOverride.AddNodeOverrideInt(PlayerRef, true, "Feet [Ovl2]", 0, -1, BPGTintCurrentColor, true)
		NiOverride.AddNodeOverrideInt(PlayerRef, true, "Face [Ovl2]", 0, -1, BPGTintCurrentColor, true)
	EndIf

	If EnableBodyPaintGlowAlphaChangeSatiation
		BPGCurrentAlpha = BPGAlphaStart - BPGAlphaDef * Math.Abs(1 - Manpukudo)
		
		NiOverride.AddNodeOverrideFloat(PlayerRef, true, "Face [Ovl2]", 1, -1, BPGCurrentAlpha, true)
		NiOverride.AddNodeOverrideFloat(PlayerRef, true, "Feet [Ovl2]", 1, -1, BPGCurrentAlpha, true)
		NiOverride.AddNodeOverrideFloat(PlayerRef, true, "Hands [Ovl2]", 1, -1, BPGCurrentAlpha, true)
		NiOverride.AddNodeOverrideFloat(PlayerRef, true, "Body [Ovl5]", 1, -1, BPGCurrentAlpha, true)
	EndIf
EndFunction

;呪われた人の欲情度に応じてBodyPaintを変えるやつ
Function ChangeAccursedBodyPaint(Actor Accursed)
	Float Arousal = SlaUtil.GetActorArousal(Accursed) as Float / 100
	
	If EnableCursePaintTint
		Int CurrentColor
		CurrentColor = SetRed(CurrentColor, (GetFloatValue(Accursed, "PSQ_CurseTattooMaxRed") - GetFloatValue(Accursed, "PSQ_CurseTattooDefRed") * Math.Abs(1 - Arousal)) as Int)
		CurrentColor = SetBlue(CurrentColor, (GetFloatValue(Accursed, "PSQ_CurseTattooMaxBlue") - GetFloatValue(Accursed, "PSQ_CurseTattooDefBlue") * Math.Abs(1 - Arousal)) as Int)
		CurrentColor = SetGreen(CurrentColor, (GetFloatValue(Accursed, "PSQ_CurseTattooMaxGreen") - GetFloatValue(Accursed, "PSQ_CurseTattooDefGreen") * Math.Abs(1 - Arousal)) as Int)
		NiOverride.AddNodeOverrideInt(Accursed, True, "Body [Ovl5]", 7, -1, CurrentColor, True)
		NiOverride.AddNodeOverrideInt(Accursed, True, "Hands [Ovl2]", 7, -1, CurrentColor, True)
		NiOverride.AddNodeOverrideInt(Accursed, True, "Feet [Ovl2]", 7, -1, CurrentColor, True)
		NiOverride.AddNodeOverrideInt(Accursed, True, "Face [Ovl2]", 7, -1, CurrentColor, True)
	EndIf
	
	If EnableCursePaintAlpha
		NiOverride.AddNodeOverrideFloat(Accursed, true, "Face [Ovl2]", 8, -1, Arousal, true)
		NiOverride.AddNodeOverrideFloat(Accursed, true, "Feet [Ovl2]", 8, -1, Arousal, true)
		NiOverride.AddNodeOverrideFloat(Accursed, true, "Hands [Ovl2]", 8, -1, Arousal, true)
		NiOverride.AddNodeOverrideFloat(Accursed, true, "Body [Ovl5]", 8, -1, Arousal, true)
	EndIf
	
	If EnableCursePaintGlowTint
		Int CurrentGlow
		CurrentGlow = SetRed(CurrentGlow, (GetFloatValue(Accursed, "PSQ_CurseTattooMaxRedG") - GetFloatValue(Accursed, "PSQ_CurseTattooDefRedG") * Math.Abs(1 - Arousal)) as Int)
		CurrentGlow = SetBlue(CurrentGlow, (GetFloatValue(Accursed, "PSQ_CurseTattooMaxBlueG") - GetFloatValue(Accursed, "PSQ_CurseTattooDefBlueG") * Math.Abs(1 - Arousal)) as Int)
		CurrentGlow = SetGreen(CurrentGlow, (GetFloatValue(Accursed, "PSQ_CurseTattooMaxGreenG") - GetFloatValue(Accursed, "PSQ_CurseTattooDefGreenG") * Math.Abs(1 - Arousal)) as Int)
		NiOverride.AddNodeOverrideInt(Accursed, true, "Body [Ovl5]", 0, -1, CurrentGlow, true)
		NiOverride.AddNodeOverrideInt(Accursed, true, "Hands [Ovl2]", 0, -1, CurrentGlow, true)
		NiOverride.AddNodeOverrideInt(Accursed, true, "Feet [Ovl2]", 0, -1, CurrentGlow, true)
		NiOverride.AddNodeOverrideInt(Accursed, true, "Face [Ovl2]", 0, -1, CurrentGlow, true)
	EndIf
	
	If EnableCursePaintGlowAlpha
		Float CurrentGlowAlpha = GetFloatValue(Accursed, "PSQ_CurseTattooMaxAlphaG") - GetFloatValue(Accursed, "PSQ_CurseTattooDefAlphaG") * Math.Abs(1 - Arousal)
		
		NiOverride.AddNodeOverrideFloat(Accursed, true, "Face [Ovl2]", 1, -1, CurrentGlowAlpha, true)
		NiOverride.AddNodeOverrideFloat(Accursed, true, "Feet [Ovl2]", 1, -1, CurrentGlowAlpha, true)
		NiOverride.AddNodeOverrideFloat(Accursed, true, "Hands [Ovl2]", 1, -1, CurrentGlowAlpha, true)
		NiOverride.AddNodeOverrideFloat(Accursed, true, "Body [Ovl5]", 1, -1, CurrentGlowAlpha, true)
	EndIf
EndFunction

;Succubus Charmの残弾を補充する関数
Function ReloadSuccubusCharm()
	Float ReloadTimer = GameDaysPassed.GetValue() - LastReloadTime
	Int AddAmmo = Math.Floor(ReloadTimer * SuccubusRank.GetValue())
	LastReloadTime = GameDaysPassed.GetValue() - (ReloadTimer - (AddAmmo as Float / SuccubusRank.GetValue()))
	
	CharmSpellAmmo = CharmSpellAmmo + AddAmmo
	If CharmSpellAmmo > SuccubusRank.GetValueInt()
		CharmSpellAmmo = SuccubusRank.GetValueInt()
	EndIf
EndFunction

;胸サイズ変えるやつ(人間)
Function SetBreastScaleHuman()
	Float BreastScale = 1.0
	If EnableBreastGrowthByPregnancy
		BreastScale = BreastScale + GetFloatValue(PlayerRef, "PRG_SeedsTotal") / 9000
	EndIf
	If EnableBreastGrowthByMilk
		BreastScale = BreastScale + GetFloatValue(PlayerRef, "PRG_MilkTotal") / 10
	EndIf
	If BreastScale > BreastScaleMax
		BreastScale = BreastScaleMax
	EndIf
	If BreastScale == 1.0
		NiOverride.RemoveNodeTransformScale(PlayerRef, True, True, "NPC L Breast", "PSQ")
		NiOverride.RemoveNodeTransformScale(PlayerRef, False, True, "NPC L Breast", "PSQ")
		NiOverride.RemoveNodeTransformScale(PlayerRef, True, True, "NPC R Breast", "PSQ")
		NiOverride.RemoveNodeTransformScale(PlayerRef, False, True, "NPC R Breast", "PSQ")
	Else
		NiOverride.AddNodeTransformScale(PlayerRef, True, True, "NPC L Breast", "PSQ", BreastScale)
		NiOverride.AddNodeTransformScale(PlayerRef, False, True, "NPC L Breast", "PSQ", BreastScale)
		NiOverride.AddNodeTransformScale(PlayerRef, True, True, "NPC R Breast", "PSQ", BreastScale)
		NiOverride.AddNodeTransformScale(PlayerRef, False, True, "NPC R Breast", "PSQ", BreastScale)
	EndIf
	NiOverride.UpdateNodeTransform(PlayerRef, True, True, "NPC L Breast")
	NiOverride.UpdateNodeTransform(PlayerRef, False, True, "NPC L Breast")
	NiOverride.UpdateNodeTransform(PlayerRef, True, True, "NPC R Breast")
	NiOverride.UpdateNodeTransform(PlayerRef, False, True, "NPC R Breast")
EndFunction

;体型を変えるやつ(サキュバス)
Function SetScaleSuccubus()
	If EnableHeightChangeSuccubus
		NiOverride.AddNodeTransformScale(PlayerRef, True, True, "NPC", "PSQ", SuccubusHeight)
		NiOverride.AddNodeTransformScale(PlayerRef, False, True, "NPC", "PSQ", SuccubusHeight)
		NiOverride.UpdateNodeTransform(PlayerRef, True, True, "NPC")
		NiOverride.UpdateNodeTransform(PlayerRef, False, True, "NPC")
	EndIf
	If EnableButtChangeSuccubus
		NiOverride.AddNodeTransformScale(PlayerRef, True, True, "NPC L Butt", "PSQ", SuccubusButt)
		NiOverride.AddNodeTransformScale(PlayerRef, False, True, "NPC L Butt", "PSQ", SuccubusButt)
		NiOverride.AddNodeTransformScale(PlayerRef, True, True, "NPC R Butt", "PSQ", SuccubusButt)
		NiOverride.AddNodeTransformScale(PlayerRef, False, True, "NPC R Butt", "PSQ", SuccubusButt)
		NiOverride.UpdateNodeTransform(PlayerRef, True, True, "NPC L Butt")
		NiOverride.UpdateNodeTransform(PlayerRef, False, True, "NPC L Butt")
		NiOverride.UpdateNodeTransform(PlayerRef, True, True, "NPC R Butt")
		NiOverride.UpdateNodeTransform(PlayerRef, False, True, "NPC R Butt")
	EndIf
	If EnableGenitalsChangeSuccubus
		NiOverride.AddNodeTransformScale(PlayerRef, True, True, "NPC Genitals01 [Gen01]", "PSQ", SuccubusGenitals)
		NiOverride.AddNodeTransformScale(PlayerRef, False, True, "NPC Genitals01 [Gen01]", "PSQ", SuccubusGenitals)
		NiOverride.UpdateNodeTransform(PlayerRef, True, True, "NPC Genitals01 [Gen01]")
		NiOverride.UpdateNodeTransform(PlayerRef, False, True, "NPC Genitals01 [Gen01]")
	EndIf
	If EnableScrotumChangeSuccubus
		NiOverride.AddNodeTransformScale(PlayerRef, True, True, "NPC GenitalsScrotum [GenScrot]", "PSQ", SuccubusScrotum)
		NiOverride.AddNodeTransformScale(PlayerRef, False, True, "NPC GenitalsScrotum [GenScrot]", "PSQ", SuccubusScrotum)
		NiOverride.UpdateNodeTransform(PlayerRef, True, True, "NPC GenitalsScrotum [GenScrot]")
		NiOverride.UpdateNodeTransform(PlayerRef, False, True, "NPC GenitalsScrotum [GenScrot]")
	EndIf
EndFunction

;体型を戻すやつ
Function SetScaleHuman()
	NiOverride.RemoveNodeTransformScale(PlayerRef, True, True, "NPC", "PSQ")
	NiOverride.RemoveNodeTransformScale(PlayerRef, False, True, "NPC", "PSQ")
	NiOverride.UpdateNodeTransform(PlayerRef, True, True, "NPC")
	NiOverride.UpdateNodeTransform(PlayerRef, False, True, "NPC")
	
	NiOverride.RemoveNodeTransformScale(PlayerRef, True, True, "NPC L Butt", "PSQ")
	NiOverride.RemoveNodeTransformScale(PlayerRef, False, True, "NPC L Butt", "PSQ")
	NiOverride.RemoveNodeTransformScale(PlayerRef, True, True, "NPC R Butt", "PSQ")
	NiOverride.RemoveNodeTransformScale(PlayerRef, False, True, "NPC R Butt", "PSQ")
	NiOverride.UpdateNodeTransform(PlayerRef, True, True, "NPC L Butt")
	NiOverride.UpdateNodeTransform(PlayerRef, False, True, "NPC L Butt")
	NiOverride.UpdateNodeTransform(PlayerRef, True, True, "NPC R Butt")
	NiOverride.UpdateNodeTransform(PlayerRef, False, True, "NPC R Butt")
	
	NiOverride.RemoveNodeTransformScale(PlayerRef, True, True, "NPC Genitals01 [Gen01]", "PSQ")
	NiOverride.RemoveNodeTransformScale(PlayerRef, False, True, "NPC Genitals01 [Gen01]", "PSQ")
	NiOverride.UpdateNodeTransform(PlayerRef, True, True, "NPC Genitals01 [Gen01]")
	NiOverride.UpdateNodeTransform(PlayerRef, False, True, "NPC Genitals01 [Gen01]")
	
	NiOverride.RemoveNodeTransformScale(PlayerRef, True, True, "NPC GenitalsScrotum [GenScrot]", "PSQ")
	NiOverride.RemoveNodeTransformScale(PlayerRef, False, True, "NPC GenitalsScrotum [GenScrot]", "PSQ")
	NiOverride.UpdateNodeTransform(PlayerRef, True, True, "NPC GenitalsScrotum [GenScrot]")
	NiOverride.UpdateNodeTransform(PlayerRef, False, True, "NPC GenitalsScrotum [GenScrot]")
EndFunction

;胸サイズ変えるやつ(サキュバス)
Function SetBreastScaleSuccubus()
	Float BreastScale = 1.0
	If EnableBreastGrowthByPregnancy
		BreastScale = BreastScale + GetFloatValue(PlayerRef, "PRG_SeedsTotal") / 9000
	EndIf
	If EnableBreastGrowthByMilk
		BreastScale = BreastScale + GetFloatValue(PlayerRef, "PRG_MilkTotal") / 10
	EndIf
	If EnableBreastChangeSuccubus
		BreastScale = BreastScale + SuccubusBreast
	EndIf
	If BreastScale > BreastScaleMax
		BreastScale = BreastScaleMax
	EndIf
	If BreastScale == 1.0
		NiOverride.RemoveNodeTransformScale(PlayerRef, True, True, "NPC L Breast", "PSQ")
		NiOverride.RemoveNodeTransformScale(PlayerRef, False, True, "NPC L Breast", "PSQ")
		NiOverride.RemoveNodeTransformScale(PlayerRef, True, True, "NPC R Breast", "PSQ")
		NiOverride.RemoveNodeTransformScale(PlayerRef, False, True, "NPC R Breast", "PSQ")
	Else
		NiOverride.AddNodeTransformScale(PlayerRef, True, True, "NPC L Breast", "PSQ", BreastScale)
		NiOverride.AddNodeTransformScale(PlayerRef, False, True, "NPC L Breast", "PSQ", BreastScale)
		NiOverride.AddNodeTransformScale(PlayerRef, True, True, "NPC R Breast", "PSQ", BreastScale)
		NiOverride.AddNodeTransformScale(PlayerRef, False, True, "NPC R Breast", "PSQ", BreastScale)
	EndIf
	NiOverride.UpdateNodeTransform(PlayerRef, True, True, "NPC L Breast")
	NiOverride.UpdateNodeTransform(PlayerRef, False, True, "NPC L Breast")
	NiOverride.UpdateNodeTransform(PlayerRef, True, True, "NPC R Breast")
	NiOverride.UpdateNodeTransform(PlayerRef, False, True, "NPC R Breast")
EndFunction

;お腹周りサイズを変えるやつ
Function SetBellyScale()
	If EnableBodyslideMorph
		Float BellyScale = 0.0
		
		BellyScale = BellyScale + (GetFloatValue(PlayerRef, "PSQ_InternalSemen") / 10000)
		If EnableBellyGrowthByPregnancy
			BellyScale = BellyScale + GetFloatValue(PlayerRef, "PRG_SeedsTotal") / 30000
		EndIf
		
		If BellyScale < 0.0
			BellyScale = 0.0
		EndIf
		
		If BellyScale > BellyScaleMax
			BellyScale = BellyScaleMax
		EndIf
		
		NiOverride.SetBodyMorph(PlayerRef, "PregnancyBelly", "PSQ", BellyScale)
		NiOverride.UpdateModelWeight(PlayerRef)
	Else
		Float BellyScale = 1.0
		
		BellyScale = BellyScale + (GetFloatValue(PlayerRef, "PSQ_InternalSemen") / 20000)
		If EnableBellyGrowthByPregnancy
			BellyScale = BellyScale + GetFloatValue(PlayerRef, "PRG_SeedsTotal") / 3000
		EndIf
		
		If BellyScale < 1.0
			BellyScale = 1.0
		EndIf
		
		If BellyScale == 1.0
			NiOverride.RemoveNodeTransformScale(PlayerRef, True, True, "NPC Belly", "PSQ")
			NiOverride.RemoveNodeTransformScale(PlayerRef, False, True, "NPC Belly", "PSQ")
		Else
			NiOverride.AddNodeTransformScale(PlayerRef, True, True, "NPC Belly", "PSQ", BellyScale)
			NiOverride.AddNodeTransformScale(PlayerRef, False, True, "NPC Belly", "PSQ", BellyScale)
		EndIf
		NiOverride.UpdateNodeTransform(PlayerRef, True, True, "NPC Belly")
		NiOverride.UpdateNodeTransform(PlayerRef, False, True, "NPC Belly")
	EndIf
EndFunction

;リロード時に再処理したいもの
Function PSQReload()
	If PlayerIsSuccubus.GetValueInt() == 1
		SexLab.UntrackActor(PlayerRef, "PSQHook")
		UnregisterForModEvent("PSQHook_Orgasm")
		UnregisterForModEvent("PSQHook_Start")
		UnregisterForModEvent("PSQHook_End")
		
		SexLab.TrackActor(PlayerRef, "PSQHook")
		RegisterForModEvent("PSQHook_Orgasm", "PSQOrgasm")
		RegisterForModEvent("PSQHook_Start", "PSQStartSex")
		RegisterForModEvent("PSQHook_End", "PSQEndSex")
		
		FortifyIllusionPerk.SetNthEntryValue(0, 1, ((3 * SuccubusRank.GetValue() + Math.Sqrt(SuccubusEXP.GetValue())) / 100) + 1)
		Satiety()
		If HasWing.GetValueInt() == 1
			Game.SetGameSettingFloat("fJumpHeightMin", DefaultJumpHeight)
		EndIf
		If SuccubusNightEyeEnabled
			SuccubusNightEyeIntroFXImod.Apply(SuccubusNightEyeStrength)
			Utility.Wait(0.5)
			SuccubusNightEyeIntroFXImod.PopTo(SuccubusNightEyeImod, SuccubusNightEyeStrength)
		EndIf
		Fish = New Actor[100]
		ResetSlots()
		If IsHenshined
			If HenshinBody
				PlayerRef.GetLeveledActorBase().SetSkin(PSQSuccubusSkin)
				PlayerRef.ChangeHeadPart(PSQSuccubusHead)
				If !HenshinHairColor && !HenshinSkin
					PlayerRef.QueueNiNodeUpdate()
				EndIf
			EndIf
			If HenshinSkin
				Game.SetTintMaskColor(PSQSkinColor, 6, 0)
				If !HenshinHairColor
					PlayerRef.QueueNiNodeUpdate()
				EndIf
			EndIf
			If HenshinHairColor
				PSQSuccubusHairColor.SetColor(PSQSuccubusHairColorInt)
				PlayerRef.GetLeveledActorBase().SetHairColor(PSQSuccubusHairColor)
				PlayerRef.QueueNiNodeUpdate()
			EndIf
			Float BoosterRate = Math.Sqrt(Math.Sqrt(SuccubusEXP.GetValue())) / 2
			If BoosterRate < 1
				BoosterRate = 1
			EndIf
			Int i = 0
			While i <= 6
				SuccubusSpellBoostPerk.SetNthEntryValue(i, 1, BoosterRate)
				i += 1
			EndWhile
		EndIf
	EndIf
	ReloadHotkeys()
	RegisterForSingleUpdate(15)
Endfunction

;レベルアップメッセージを伴わないレベル設定処理
Function SetSuccubusLevel()
	If !EnergyModeAlt
		If SuccubusEXP.GetValue() >= 10
			MaxEnergy = 250 * Math.Sqrt(SuccubusEXP.GetValue())
		Else
			MaxEnergy = 60 * SuccubusEXP.GetValue() + 200
		EndIf
	Else
		MaxEnergy = MaxEnergyAtAltMode
	EndIf
	EnergyConsumption = MaxEnergy * EnergyConsumptionPerMax / 100
	
	SuccubusRank.SetValue(1)
	If EnableSuccubusDrainFF
		PlayerRef.AddSpell(SuccubusDrainFF01, False)
	EndIf
	If EnableSuccubusDrainHealthSpell
		PlayerRef.AddSpell(SuccubusDrainHealthSpell01, False)
	EndIf
	If EnableSuccubusDrainStaminaSpell
		PlayerRef.AddSpell(SuccubusDrainStaminaSpell01, False)
	EndIf
	If EnableFortifyBartar
		PlayerRef.AddSpell(FortifyBartarSpell1, False)
	EndIf
	If SuccubusEXP.GetValue() >= 10
		SuccubusRank.SetValue(2)
		If EnableSuccubusDrainFF
			PlayerRef.AddSpell(SuccubusDrainFF02, False)
		EndIf
		If EnableSuccubusDrainHealthSpell
			PlayerRef.AddSpell(SuccubusDrainHealthSpell02, False)
		EndIf
		If EnableSuccubusDrainStaminaSpell
			PlayerRef.AddSpell(SuccubusDrainStaminaSpell02, False)
		EndIf
		If EnableFortifyBartar
			PlayerRef.AddSpell(FortifyBartarSpell2, False)
		EndIf
		PlayerRef.AddSpell(SuccuKanashibari, False)
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell01)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell01)
		PlayerRef.RemoveSpell(SuccubusDrainFF01)
		PlayerRef.RemoveSpell(FortifyBartarSpell1)
	EndIf
	If SuccubusEXP.GetValue() >= 50
		SuccubusRank.SetValue(3)
		If EnableSuccubusDrainStaminaSpell
			PlayerRef.AddSpell(SuccubusDrainStaminaSpell03, False)
		EndIf
		If EnableSuccubusDrainHealthSpell
			PlayerRef.AddSpell(SuccubusDrainHealthSpell03, False)
		EndIf
		If EnableSuccubusDrainFF
			PlayerRef.AddSpell(SuccubusDrainFF03, False)
		EndIf
		PlayerRef.AddSpell(FortifyMSGBoxSpell, False)
		If EnableFortifyBartar
			PlayerRef.AddSpell(FortifyBartarSpell3, False)
		EndIf
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell02)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell02)
		PlayerRef.RemoveSpell(SuccubusDrainFF02)
		PlayerRef.RemoveSpell(FortifyBartarSpell2)
	EndIf
	If SuccubusEXP.GetValue() >= 100
		SuccubusRank.SetValue(4)
		If EnableSuccubusDrainStaminaSpell
			PlayerRef.AddSpell(SuccubusDrainStaminaSpell04, False)
		EndIf
		If EnableSuccubusDrainHealthSpell
			PlayerRef.AddSpell(SuccubusDrainHealthSpell04, False)
		EndIf
		If EnableSuccubusDrainFF
			PlayerRef.AddSpell(SuccubusDrainFF04, False)
		EndIf
		If EnableFortifyBartar
			PlayerRef.AddSpell(FortifyBartarSpell4, False)
		EndIf
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell03)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell03)
		PlayerRef.RemoveSpell(SuccubusDrainFF03)
		PlayerRef.RemoveSpell(FortifyBartarSpell3)
	EndIf
	If SuccubusEXP.GetValue() >= 250
		SuccubusRank.SetValue(5)
		If EnableSuccubusDrainStaminaSpell
			PlayerRef.AddSpell(SuccubusDrainStaminaSpell05, False)
		EndIf
		If EnableSuccubusDrainHealthSpell
			PlayerRef.AddSpell(SuccubusDrainHealthSpell05, False)
		EndIf
		If EnableSuccubusDrainFF
			PlayerRef.AddSpell(SuccubusDrainFF05, False)
		EndIf
		If EnableFortifyBartar
			PlayerRef.AddSpell(FortifyBartarSpell5, False)
		EndIf
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell04)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell04)
		PlayerRef.RemoveSpell(SuccubusDrainFF04)
		PlayerRef.RemoveSpell(FortifyBartarSpell4)
	EndIf
	If SuccubusEXP.GetValue() >= 500
		SuccubusRank.SetValue(6)
		If EnableSuccubusDrainStaminaSpell
			PlayerRef.AddSpell(SuccubusDrainStaminaSpell06, False)
		EndIf
		If EnableSuccubusDrainHealthSpell
			PlayerRef.AddSpell(SuccubusDrainHealthSpell06, False)
		EndIf
		If EnableSuccubusDrainFF
			PlayerRef.AddSpell(SuccubusDrainFF06, False)
		EndIf
		If EnableFortifyBartar
			PlayerRef.AddSpell(FortifyBartarSpell6, False)
		EndIf
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell05)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell05)
		PlayerRef.RemoveSpell(SuccubusDrainFF05)
		PlayerRef.RemoveSpell(FortifyBartarSpell5)
	EndIf
	If SuccubusEXP.GetValue() >= 1000
		SuccubusRank.SetValue(7)
		If EnableSuccubusDrainStaminaSpell
			PlayerRef.AddSpell(SuccubusDrainStaminaSpell07, False)
		EndIf
		If EnableSuccubusDrainHealthSpell
			PlayerRef.AddSpell(SuccubusDrainHealthSpell07, False)
		EndIf
		If EnableSuccubusDrainFF
			PlayerRef.AddSpell(SuccubusDrainFF07, False)
		EndIf
		If EnableFortifyBartar
			PlayerRef.AddSpell(FortifyBartarSpell7, False)
		EndIf
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell06)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell06)
		PlayerRef.RemoveSpell(SuccubusDrainFF06)
		PlayerRef.RemoveSpell(FortifyBartarSpell6)
	EndIf
	If SuccubusEXP.GetValue() >= 2000
		SuccubusRank.SetValue(8)
		If EnableSuccubusDrainStaminaSpell
			PlayerRef.AddSpell(SuccubusDrainStaminaSpell08, False)
		EndIf
		If EnableSuccubusDrainHealthSpell
			PlayerRef.AddSpell(SuccubusDrainHealthSpell08, False)
		EndIf
		If EnableSuccubusDrainFF
			PlayerRef.AddSpell(SuccubusDrainFF08, False)
		EndIf
		If EnableFortifyBartar
			PlayerRef.AddSpell(FortifyBartarSpell8, False)
		EndIf
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell07)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell07)
		PlayerRef.RemoveSpell(SuccubusDrainFF07)
		PlayerRef.RemoveSpell(FortifyBartarSpell7)
	EndIf
EndFunction

;ホットキーやつ
Event OnKeyDown(Int KeyCode)
	If !Utility.IsInMenuMode()
		If PlayerIsSuccubus.GetValue() == 1
			If KeyCode == HotkeySuccubusStats
				StatsMSGBoxSpell.Cast(PlayerRef)
			EndIf
			
			If KeyCode == HotkeyDigestion
				SetIntValue(PlayerRef, "PSQ_Digestioning", 1)
				While Input.IsKeyPressed(HotkeyDigestion) && GetFloatValue(PlayerRef, "PSQ_InternalSemen") > 0
					Float Decrement = CumInflationIncrement
					If Decrement > GetFloatValue(PlayerRef, "PSQ_InternalSemen")
						Decrement = GetFloatValue(PlayerRef, "PSQ_InternalSemen")
						Satiety(Decrement)
						SetBellyScale()
					EndIf
					
					SetFloatValue(PlayerRef, "PSQ_InternalSemen", GetFloatValue(PlayerRef, "PSQ_InternalSemen") - decrement)
					Satiety(Decrement)
					SetBellyScale()
				EndWhile
			EndIf
			
			If KeyCode == HotkeyEnableDrain
				EnableDrain = !EnableDrain
				If EnableDrain
					Debug.Notification("$PSQ_EnableDrainHotkeyNotice1")
				Else
					Debug.Notification("$PSQ_EnableDrainHotkeyNotice2")
				EndIf
			EndIf
			
			If KeyCode == HotkeyAllowKill
				AllowKill = !AllowKill
				If AllowKill
					Debug.Notification("$PSQ_AllowKillHotkeyNotice1")
				Else
					Debug.Notification("$PSQ_AllowKillHotkeyNotice2")
				EndIf
			EndIf
			
			If KeyCode == HotkeyEnableSoulTrap
				EnableSoulTrap = !EnableSoulTrap
				If EnableSoulTrap
					Debug.Notification("$PSQ_EnableDrainSoulTrapHotkeyNotice1")
				Else
					Debug.Notification("$PSQ_EnableDrainSoulTrapHotkeyNotice2")
				EndIf
			EndIf
			
			If KeyCode == HotkeyExtractSemenPotion
				ExtractSemenPotion = !ExtractSemenPotion
				If ExtractSemenPotion
					Debug.Notification("$PSQ_EnableSemenPotionHotkeyNotice1")
				Else
					Debug.Notification("$PSQ_EnableSemenPotionHotkeyNotice2")
				EndIf
			EndIf
			
			If KeyCode == HotkeyEnergyBar
				SEBU.EnegyBarVisible = !SEBU.EnegyBarVisible
				SEBU.UpdateEnergyBarPosition()
			EndIf
			
			If KeyCode == HotkeyNightEye && !Input.IsKeyPressed(HotkeyIncreaseNode) && !Input.IsKeyPressed(HotkeyDecreaseNode)
				If !NightEyeProceeding
					NightEyeProceeding = True
					If SuccubusNightEyeEnabled
						SuccubusNightEyeEnabled = False
						SuccubusNightEyeImod.PopTo(SuccubusNightEyeOutroFXImod, SuccubusNightEyeStrength)
						SuccubusNightEyeIntroFXImod.Remove()
					Else
						SuccubusNightEyeEnabled = True
						SuccubusNightEyeIntroFXImod.Apply(SuccubusNightEyeStrength)
						Utility.Wait(0.5)
						SuccubusNightEyeIntroFXImod.PopTo(SuccubusNightEyeImod, SuccubusNightEyeStrength)
					EndIf
					NightEyeProceeding = False
				EndIf
			EndIf
			
			If KeyCode == HotkeySuccubusCharmSpell
				If CharmSpellAmmo > 0
					If SuccubusRank.GetValue() < 8
						CharmSpellAmmo -= 1
					EndIf
					SuccubusCharmSpell.Cast(PlayerRef)
				Else
					Debug.Notification("$PSQ_OutOfAmmo")
				EndIf
			EndIf
			
			If KeyCode == HotkeyDetectArousal
				If PlayerRef.HasSpell(DetectArousalCloakSpell)
					PlayerRef.RemoveSpell(DetectArousalCloakSpell)
					TerminateDetectArousalSpell.Cast(PlayerRef)
				Else
					PlayerRef.AddSpell(DetectArousalCloakSpell, False)
				EndIf
			EndIf
			
			If KeyCode == HotkeyToggleFlying
				If PlayerRef.HasSpell(SuccubusFlyingSpell)
					PlayerRef.RemoveSpell(SuccubusFlyingSpell)
					Debug.Notification("$PSQ_FlyingDisabled")
				Else
					If HasWing.GetValueInt() == 1
						If SuccubusRank.GetValueInt() >= CanFlyingLevel
							PlayerRef.AddSpell(SuccubusFlyingSpell, False)
							Debug.Notification("$PSQ_FlyingEnabled")
						Else
							Debug.Notification("$PSQ_NotEnoughLevelToFlying")
						EndIf
					Else
						Debug.Notification("$PSQ_HasNoWings")
					EndIf
				EndIf
			EndIf
			
			If KeyCode == HotkeyCreatePenisSelf
				CreatePenisSpellSelf.Cast(PlayerRef)
			EndIf
			
			If KeyCode == HotkeyHenshin
				HenshinSpell.Cast(PlayerRef)
				TransformNPCSuccubusSpell.Cast(PlayerRef)
			EndIf
			
			If KeyCode == HotkeyMasturbation
				MasturbationSpell.Cast(PlayerRef)
			EndIf
			
			If KeyCode == HotkeyRestoreMagicka
				RestoreMagickaSpell.Cast(PlayerRef)
			EndIf
			
			If Input.IsKeyPressed(HotkeyIncreaseNode)
				If KeyCode == HotkeyNightEye
					If !NightEyeProceeding
						NightEyeProceeding = True
						SuccubusNightEyeStrength = SuccubusNightEyeStrength + 0.10
						If SuccubusNightEyeStrength > 1.0
							SuccubusNightEyeStrength = 1.0
						EndIf
						If SuccubusNightEyeEnabled && SuccubusNightEyeStrength < 1.0
							SuccubusNightEyeIntroFXImod.Apply(0.10)
							Utility.Wait(1.0)
							SuccubusNightEyeIntroFXImod.PopTo(SuccubusNightEyeImod, 0.10)
						EndIf
						NightEyeProceeding = False
					EndIf
				EndIf
			
				If KeyCode == HotkeyHeight
					If IsHenshined
						If EnableHeightChangeSuccubus
							SuccubusHeight = SuccubusHeight + 0.01
							SetScaleSuccubus()
						EndIf
					EndIf
				EndIf
				
				If KeyCode == HotkeyBreastNode
					If IsHenshined
						If EnableBreastChangeSuccubus
							SuccubusBreast = SuccubusBreast + 0.01
							SetBreastScaleSuccubus()
						EndIf
					EndIf
				EndIf
				
				If KeyCode == HotkeyButtNode
					If IsHenshined
						If EnableButtChangeSuccubus
							SuccubusButt = SuccubusButt + 0.01
							SetScaleSuccubus()
						EndIf
					EndIf
				EndIf
				
				If KeyCode == HotkeyGenitalsNode
					If IsHenshined
						If EnableGenitalsChangeSuccubus
							SuccubusGenitals = SuccubusGenitals + 0.01
							SetScaleSuccubus()
						EndIf
					EndIf
				EndIf
				
				If KeyCode == HotkeyScrotumNode
					If IsHenshined
						If EnableScrotumChangeSuccubus
							SuccubusScrotum = SuccubusScrotum + 0.01
							SetScaleSuccubus()
						EndIf
					EndIf
				EndIf
			EndIf
			
			If Input.IsKeyPressed(HotkeyDecreaseNode)
				If KeyCode == HotkeyNightEye
					If !NightEyeProceeding
						NightEyeProceeding = True
						SuccubusNightEyeStrength = SuccubusNightEyeStrength - 0.10
						If SuccubusNightEyeStrength < 0.0
							SuccubusNightEyeStrength = 0.0
						EndIf
						If SuccubusNightEyeEnabled && SuccubusNightEyeStrength > 0.0
							SuccubusNightEyeIntroFXImod.Remove()
							SuccubusNightEyeImod.PopTo(SuccubusNightEyeOutroFXImod, SuccubusNightEyeStrength)
							Utility.Wait(1.0)
							SuccubusNightEyeImod.Apply(SuccubusNightEyeStrength)
						EndIf
						NightEyeProceeding = False
					EndIf
				EndIf
				
				If KeyCode == HotkeyHeight
					If IsHenshined
						If EnableHeightChangeSuccubus && !PlayerRef.IsOnMount()
							SuccubusHeight = SuccubusHeight - 0.01
							SetScaleSuccubus()
						EndIf
					EndIf
				EndIf
				
				If KeyCode == HotkeyBreastNode
					If IsHenshined
						If EnableBreastChangeSuccubus
							SuccubusBreast = SuccubusBreast - 0.01
							SetBreastScaleSuccubus()
						EndIf
					EndIf
				EndIf
				
				If KeyCode == HotkeyButtNode
					If IsHenshined
						If EnableButtChangeSuccubus
							SuccubusButt = SuccubusButt - 0.01
							SetScaleSuccubus()
						EndIf
					EndIf
				EndIf
				
				If KeyCode == HotkeyGenitalsNode
					If IsHenshined
						If EnableGenitalsChangeSuccubus
							SuccubusGenitals = SuccubusGenitals - 0.01
							SetScaleSuccubus()
						EndIf
					EndIf
				EndIf
				
				If KeyCode == HotkeyScrotumNode
					If IsHenshined
						If EnableScrotumChangeSuccubus
							SuccubusScrotum = SuccubusScrotum - 0.01
							SetScaleSuccubus()
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
EndEvent

;Event OnKeyUp(Int KeyCode)
;EndEvent

;リロードホットキーやつ
Function ReloadHotkeys()
	UnregisterForAllKeys()
	RegisterForKey(HotkeyEnableDrain)
	RegisterForKey(HotkeyAllowKill)
	RegisterForKey(HotkeySuccubusCharmSpell)
	RegisterForKey(HotkeyMasturbation)
	RegisterForKey(HotkeyRestoreMagicka)
	RegisterForKey(HotkeyExtractSemenPotion)
	RegisterForKey(HotkeyEnableSoulTrap)
	RegisterForKey(HotkeyCreatePenisSelf)
	RegisterForKey(HotkeyHenshin)
	RegisterForKey(HotkeyEnergyBar)
	RegisterForKey(HotkeyNightEye)
	RegisterForKey(HotkeyDetectArousal)
	RegisterForKey(HotkeyToggleFlying)
	RegisterForKey(HotkeySuccubusStats)
	RegisterForKey(HotkeyHeight)
	RegisterForKey(HotkeyWeight)
	RegisterForKey(HotkeyBreastNode)
	RegisterForKey(HotkeyButtNode)
	RegisterForKey(HotkeyGenitalsNode)
	RegisterForKey(HotkeyScrotumNode)
	RegisterForKey(HotkeyDigestion)
	UnRegisterForKey(211)
EndFunction

;サキュバスになる処理
Function BecomeSuccubus()
	;すでにサキュバスなら何もしません
	If PlayerIsSuccubus.GetValue() != 1
		;病気を治療します
		SuccubusCureDisease.Cast(PlayerRef)
		If PlayerIsVampire.GetValue() == 1
			(PlayerVampireQuest as PlayerVampireQuestScript).VampireCure(PlayerRef)
		EndIf
		If PlayerIsWerewolf.GetValue() == 1
			(C00 as CompanionsHousekeepingScript).CurePlayer()
			PlayerIsWerewolf.SetValue(0)
		EndIf
		
		;サキュバスになります
		PlayerIsSuccubus.SetValue(1)
		SetIntValue(PlayerRef, "PSQ_PlayerIsSuccubus", 1)
		
		;サキュバスレベルを設定します
		SetSuccubusLevel()
		
		;自分の体力を当座のエナジーに変換します
		Satiety(PlayerRef.GetActorValue("Health"))
		
		If PhysicalWeakness
			PlayerRef.SetActorValue("Health", PlayerRef.GetBaseActorValue("Health") - 30)
			PlayerRef.SetActorValue("Stamina", PlayerRef.GetBaseActorValue("Stamina") - 30)
		EndIf
		
		;どのレベルでも共通の魔法を追加します
		PlayerRef.AddSpell(FortifyMagickaSpell, False)
		PlayerRef.AddSpell(ImmunityToSTD, False)
		PlayerRef.AddSpell(RestoreMagickaSpell, False)
		PlayerRef.AddSpell(FortifySneakSpell, False)
		PlayerRef.AddSpell(MasturbationSpell, False)
		PlayerRef.AddSpell(SuccubusCharmSpell, False)
		PlayerRef.AddSpell(CreatePenisSpellSelf, False)
		PlayerRef.AddSpell(CreatePenisSpellOther, False)
		PlayerRef.AddSpell(StarkRealitySpell, False)
		PlayerRef.AddSpell(HenshinSpell, False)
		PlayerRef.AddSpell(StatsMSGBoxSpell, False)
		PlayerRef.AddSpell(SuccubusCurseSpell, False)
		PlayerRef.AddSpell(SuccubusSummonMerchantSpell, False)
		PlayerRef.AddSpell(SuccubusRaiseArousalSpell, False)
		PlayerRef.AddSpell(SuccubusArousalCloakSpell, False)
		PlayerRef.AddSpell(SuccubusSpellLearningMSGBoxSpell, False)
		PlayerRef.AddPerk(SuccubusFeed)
		
		If EnableSoulGemPregnancy
			PlayerRef.AddSpell(PSQSoulGemBirthingSpell, False)
		EndIf
		If EnableFortifyIllusion
			PlayerRef.AddPerk(FortifyIllusionPerk)
		EndIf
		PlayerRef.AddPerk(FortifySneakPerk)
		If EnableFortifyBartar
			PlayerRef.AddPerk(FortifyBartarPerk)
		EndIf
		PlayerRef.AddPerk(SuccubusWingPerk)
		PlayerRef.AddPerk(SuccubusSpellBoostPerk)
		
		;セックス監視イベントをレジストします
		SexLab.TrackActor(PlayerRef, "PSQHook")
		RegisterForModEvent("PSQHook_Orgasm", "PSQOrgasm")
		RegisterForModEvent("PSQHook_Start", "PSQStartSex")
		RegisterForModEvent("PSQHook_End", "PSQEndSex")
	
		
		Fish = New Actor[100]
		ResetSlots()
		
		;最後のエナジー消費時間を初期化します
		LastConsumeTime = GameDaysPassed.Value
		
		FactionInit()
		EnableEnterSoulCairn()
	EndIf
EndFunction

;サキュバスをやめる処理
Function QuitSuccubus()
	;もしサキュバスでないなら何もしません
	If PlayerIsSuccubus.GetValue() == 1
		
		;サキュバスでなくなります
		PlayerIsSuccubus.SetValue(0)
		SuccubusEnergy.SetValue(0)
		SuccubusRank.SetValue(0)
		SetIntValue(PlayerRef, "PSQ_PlayerIsSuccubus", 0)
		
		;ジャンプ力を元に戻す
		HasWing.SetValue(0)
		Game.SetGameSettingFloat("fJumpHeightMin", 76.0)
		
		If PhysicalWeakness
			PlayerRef.SetActorValue("Health", PlayerRef.GetBaseActorValue("Health") + 30)
			PlayerRef.SetActorValue("Stamina", PlayerRef.GetBaseActorValue("Stamina") + 30)
		EndIf
		
		DisableEnterSoulCairn()
		
		;サキュバス魔法を忘れ去ります
		If IsHenshined
			SuccubusTransFXS.Play(PlayerRef, 0.5)
			Utility.Wait(0.5)
			PlayerRef.RemoveSpell(SuccubusHenshinBonusSpell)
			PlayerRef.RemoveSpell(SuccubusWaterWalking)
			PlayerRef.RemoveSpell(SuccubusArmorSpell)
			If OrgEyes != None
				PlayerRef.ChangeHeadPart(OrgEyes)
			EndIf
			If HenshinBody
				PlayerRef.GetLeveledActorBase().SetSkin(PSQHumanSkin)
				PlayerRef.ChangeHeadPart(PSQHumanHead)
				If OrgHairColor == None && OrgSkinColor == 0
					PlayerRef.QueueNiNodeUpdate()
				EndIf
			EndIf
			If OrgSkinColor != 0
				Game.SetTintMaskColor(OrgSkinColor, 6, 0)
				If OrgHairColor == None
					PlayerRef.QueueNiNodeUpdate()
				EndIf
			EndIf
			If OrgHair != None
				PlayerRef.ChangeHeadPart(OrgHair)
			EndIf
			If OrgHairColor != None
				PlayerRef.GetLeveledActorBase().SetHairColor(OrgHairColor)
				PlayerRef.QueueNiNodeUpdate()
			EndIf
			PlayerRef.RemoveItem(PSQSuccubusBoots, PlayerRef.GetItemCount(PSQSuccubusBoots), True)
			PlayerRef.RemoveItem(PSQSuccubusCuirass, PlayerRef.GetItemCount(PSQSuccubusCuirass), True)
			PlayerRef.RemoveItem(PSQSuccubusGauntlets, PlayerRef.GetItemCount(PSQSuccubusGauntlets), True)
			If PlayerRef.GetItemCount(OrgArmor) > 0
				PlayerRef.EquipItem(OrgArmor, abSilent = True)
			EndIf
			If PlayerRef.GetItemCount(OrgGloves) > 0
				PlayerRef.EquipItem(OrgGloves, abSilent = True)
			EndIf
			If PlayerRef.GetItemCount(OrgBoots) > 0
				PlayerRef.EquipItem(OrgBoots, abSilent = True)
			EndIf
			PlayerRef.RemoveItem(PSQSuccubusHorns, PlayerRef.GetItemCount(PSQSuccubusHorns), True)
			PlayerRef.RemoveItem(PSQSuccubusWings, PlayerRef.GetItemCount(PSQSuccubusWings), True)
			PlayerRef.RemoveItem(PSQSuccubusTail, PlayerRef.GetItemCount(PSQSuccubusTail), True)
			PlayerRef.RemoveFromFaction(SuccubusFoeFaction)
			TransformBooster.SetValue(0)
			IsHenshined = False
			OrgArmor = None
			OrgGloves = None
			OrgBoots = None
			OrgEyes = None
			OrgSkinColor = 0
		EndIf
		PlayerRef.RemoveItem(FemaleSchlongA, PlayerRef.GetItemCount(FemaleSchlongA), True)
		PlayerRef.RemoveItem(FemaleSchlongB, PlayerRef.GetItemCount(FemaleSchlongB), True)
		PlayerRef.RemoveItem(FemaleSchlongC, PlayerRef.GetItemCount(FemaleSchlongC), True)
		PlayerRef.RemoveItem(FemaleSchlongD, PlayerRef.GetItemCount(FemaleSchlongD), True)
		PlayerRef.RemoveItem(FemaleSchlongE, PlayerRef.GetItemCount(FemaleSchlongE), True)
		PlayerRef.RemoveSpell(HenshinSpell)
		PlayerRef.RemoveSpell(FortifyMagickaSpell)
		PlayerRef.RemoveSpell(ImmunityToSTD)
		PlayerRef.RemoveSpell(SuccubusSatiatySpellA)
		PlayerRef.RemoveSpell(SuccubusSatiatySpellB)
		PlayerRef.RemoveSpell(SuccubusStarvation)
		PlayerRef.RemoveSpell(StarkRealitySpell)
		PlayerRef.RemoveSpell(SuccubusSpellLearningMSGBoxSpell)
		PlayerRef.RemoveSpell(SuccuKanashibari)
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell01)
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell02)
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell03)
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell04)
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell05)
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell06)
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell07)
		PlayerRef.RemoveSpell(SuccubusDrainStaminaSpell08)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell01)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell02)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell03)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell04)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell05)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell06)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell07)
		PlayerRef.RemoveSpell(SuccubusDrainHealthSpell08)
		PlayerRef.RemoveSpell(SuccubusDrainFF01)
		PlayerRef.RemoveSpell(SuccubusDrainFF02)
		PlayerRef.RemoveSpell(SuccubusDrainFF03)
		PlayerRef.RemoveSpell(SuccubusDrainFF04)
		PlayerRef.RemoveSpell(SuccubusDrainFF05)
		PlayerRef.RemoveSpell(SuccubusDrainFF06)
		PlayerRef.RemoveSpell(SuccubusDrainFF07)
		PlayerRef.RemoveSpell(SuccubusDrainFF08)
		PlayerRef.RemoveSpell(FortifyMSGBoxSpell)
		PlayerRef.RemoveSpell(StatsMSGBoxSpell)
		PlayerRef.RemoveSpell(RestoreMagickaSpell)
		PlayerRef.RemoveSpell(CreatePenisSpellSelf)
		PlayerRef.RemoveSpell(CreatePenisSpellOther)
		PlayerRef.RemoveSpell(PSQSoulGemImpregnateSpell)
		PlayerRef.RemoveSpell(FortifySneakSpell)
		PlayerRef.RemoveSpell(SuccubusCurseSpell)
		PlayerRef.RemoveSpell(SuccubusSummonMerchantSpell)
		PlayerRef.RemoveSpell(SuccubusRaiseArousalSpell)
		PlayerRef.RemoveSpell(SuccubusArousalCloakSpell)
		PlayerRef.RemoveSpell(DetectArousalCloakSpell)
		PlayerRef.RemoveSpell(FortifyBartarSpell1)
		PlayerRef.RemoveSpell(FortifyBartarSpell2)
		PlayerRef.RemoveSpell(FortifyBartarSpell3)
		PlayerRef.RemoveSpell(FortifyBartarSpell4)
		PlayerRef.RemoveSpell(FortifyBartarSpell5)
		PlayerRef.RemoveSpell(FortifyBartarSpell6)
		PlayerRef.RemoveSpell(FortifyBartarSpell7)
		PlayerRef.RemoveSpell(FortifyBartarSpell8)
		PlayerRef.RemoveSpell(MasturbationSpell)
		PlayerRef.RemoveSpell(FortifyDestructionSpell)
		PlayerRef.RemoveSpell(FortifyIllusionSpell)
		PlayerRef.RemovePerk(SuccubusFeed)
		PlayerRef.RemovePerk(FortifyIllusionPerk)
		PlayerRef.RemovePerk(FortifySneakPerk)
		PlayerRef.RemovePerk(FortifyBartarPerk)
		PlayerRef.RemovePerk(SuccubusWingPerk)
		PlayerRef.RemovePerk(SuccubusSpellBoostPerk)
		;バニラ魔法空間
		PlayerRef.RemoveSpell(SuccuFirebolt)
		PlayerRef.RemoveSpell(SuccuIceSpike)
		PlayerRef.RemoveSpell(SuccuLightningBolt)
		PlayerRef.RemoveSpell(SuccuFireball)
		PlayerRef.RemoveSpell(SuccuIceStorm)
		PlayerRef.RemoveSpell(SuccuChainLightning)
		PlayerRef.RemoveSpell(SuccuIncinerate)
		PlayerRef.RemoveSpell(SuccuIcySpear)
		PlayerRef.RemoveSpell(SuccuThunderbolt)
		PlayerRef.RemoveSpell(SuccuFireStorm)
		PlayerRef.RemoveSpell(SuccuBlizzard)
		PlayerRef.RemoveSpell(SuccuCourage)
		PlayerRef.RemoveSpell(SuccuCalm)
		PlayerRef.RemoveSpell(SuccuFear)
		PlayerRef.RemoveSpell(SuccuFury)
		PlayerRef.RemoveSpell(SuccuRally)
		PlayerRef.RemoveSpell(SuccuPacify)
		PlayerRef.RemoveSpell(SuccuRout)
		PlayerRef.RemoveSpell(SuccuFrenzy)
		PlayerRef.RemoveSpell(SuccuCallToArms)
		PlayerRef.RemoveSpell(SuccuHarmony)
		PlayerRef.RemoveSpell(SuccuHysteria)
		PlayerRef.RemoveSpell(SuccuMayhem)
		PlayerRef.RemoveSpell(SuccuOakflesh)
		PlayerRef.RemoveSpell(SuccuIronflesh)
		PlayerRef.RemoveSpell(SuccuStoneflesh)
		PlayerRef.RemoveSpell(SuccuEbonyflesh)
		PlayerRef.RemoveSpell(SuccuDragonhide)
		PlayerRef.RemoveSpell(SuccuHealOther)
		PlayerRef.RemoveSpell(SuccuFastHealing)
		PlayerRef.RemoveSpell(SuccuGrandHealing)
		PlayerRef.RemoveSpell(SuccuCloseWounds)
		PlayerRef.RemoveSpell(SuccuParalyze)
		
		;セックス監視イベントを終了します
		SexLab.UntrackActor(PlayerRef, "PSQHook")
		UnregisterForModEvent("PSQHook_Orgasm")
		UnregisterForModEvent("PSQHook_Start")
		UnregisterForModEvent("PSQHook_End")
	EndIf
EndFunction

;変身時などのファクションを初期化する仕事
Function FactionInit()
	Faction AiteFaction
	Int NumFactions = SuccubusFoeList.GetSize()
	Int FactionIndex = 0
	While FactionIndex < NumFactions
		AiteFaction = SuccubusFoeList.GetAt(FactionIndex) as Faction
		If AiteFaction
			SuccubusFoeFaction.SetEnemy(AiteFaction)
		Endif
		FactionIndex += 1
	EndWhile
	
	FactionIndex = 0
	NumFactions = SuccubusFriendList.GetSize()
	While FactionIndex < NumFactions
		AiteFaction = SuccubusFriendList.GetAt(FactionIndex) as Faction
		If AiteFaction
			PSQRapeNoAttackFaction.SetAlly(AiteFaction)
		Endif
		FactionIndex += 1
	EndWhile
EndFunction

;ウェイト無しで喘ぐ関数だよ。SSLのMoanはWaitとセットになってるから作ったよ。
Function MoanNoWait(sslBaseVoice Voice, Int Strength)
	If SexLab.Config.UseLipSync && Game.GetCameraState() != 3
		PlayerRef.Say(SexLab.Config.LipSync)
	EndIf
	Sound GetMoan = Voice.GetSound(Strength)
	GetMoan.Play(PlayerRef)
EndFunction

;デイドラ存在なのでソウルケアンに入れるようにするやつ
Function EnableEnterSoulCairn()
	Int Mods = Game.GetModCount()
	String Name
	While Mods
		Mods -= 1
		Name = Game.GetModName(Mods)
		If Name == "Dawnguard.esm"
			(Game.GetFormFromFile(0xD40D, "Dawnguard.esm") as GlobalVariable).SetValue(1)
			(Game.GetFormFromFile(0xD412, "Dawnguard.esm") as ObjectReference).Disable()
			(Game.GetFormFromFile(0xD410, "Dawnguard.esm") as ObjectReference).Disable()
		EndIf
	EndWhile
EndFunction

;デイドラ存在ではなくなったのでソウルケアンに入れなくするやつ
Function DisableEnterSoulCairn()
	Int Mods = Game.GetModCount()
	String Name
	While Mods
		Mods -= 1
		Name = Game.GetModName(Mods)
		If Name == "Dawnguard.esm"
			(Game.GetFormFromFile(0xD40D, "Dawnguard.esm") as GlobalVariable).SetValue(0)
			(Game.GetFormFromFile(0xD412, "Dawnguard.esm") as ObjectReference).Enable()
			(Game.GetFormFromFile(0xD410, "Dawnguard.esm") as ObjectReference).Enable()
		EndIf
	EndWhile
EndFunction

Function RegisteriNeed()
	Int Mods = Game.GetModCount()
	String Name
	While Mods
		Mods -= 1
		Name = Game.GetModName(Mods)
		If Name == "iNeed.esp"
			(Game.GetFormFromFile(0xD6B, "iNeed.esp") as FormList).AddForm(SemenPotion)
			(Game.GetFormFromFile(0xD6B, "iNeed.esp") as FormList).AddForm(Game.GetFormFromFile(0xE2D, "PSQ PlayerSuccubusQuest.esm") as Potion)
			(Game.GetFormFromFile(0xD6B, "iNeed.esp") as FormList).AddForm(Game.GetFormFromFile(0xE2E, "PSQ PlayerSuccubusQuest.esm") as Potion)
			(Game.GetFormFromFile(0xD6C, "iNeed.esp") as FormList).AddForm(Game.GetFormFromFile(0xE1C, "PSQ PlayerSuccubusQuest.esm") as Potion)
			(Game.GetFormFromFile(0xD69, "iNeed.esp") as FormList).AddForm(Game.GetFormFromFile(0xE1D, "PSQ PlayerSuccubusQuest.esm") as Potion)
			(Game.GetFormFromFile(0xBA28, "iNeed.esp") as FormList).AddForm(Game.GetFormFromFile(0xE2C, "PSQ PlayerSuccubusQuest.esm") as Potion)
		EndIf
	EndWhile
EndFunction

Function GetBodyPaintData(Bool IsStartValue)
	If NetImmerse.HasNode(PlayerRef, "Body [Ovl5]", False)
		If IsStartValue
			BPTintColorStart = NiOverride.GetNodePropertyInt(PlayerRef, False, "Body [Ovl5]", 7, -1)
			BPGTintColorStart = NiOverride.GetNodePropertyInt(PlayerRef, False, "Body [Ovl5]", 0, -1)
			BPGAlphaStart = NiOverride.GetNodePropertyFloat(PlayerRef, False, "Body [Ovl5]", 1, -1)
		Else
			BPTintColorEnd = NiOverride.GetNodePropertyInt(PlayerRef, False, "Body [Ovl5]", 7, -1)
			BPGTintColorEnd = NiOverride.GetNodePropertyInt(PlayerRef, False, "Body [Ovl5]", 0, -1)
			BPGAlphaEnd = NiOverride.GetNodePropertyFloat(PlayerRef, False, "Body [Ovl5]", 1, -1)
		EndIf
	Else
		Bool IsFemale = PlayerRef.GetActorBase().GetSex() as Bool
		If IsStartValue
			BPTintColorStart = NiOverride.GetNodeOverrideInt(PlayerRef, IsFemale, "Body [Ovl5]", 7, -1)
			BPGTintColorStart = NiOverride.GetNodeOverrideInt(PlayerRef, IsFemale, "Body [Ovl5]", 0, -1)
			BPGAlphaStart = NiOverride.GetNodeOverrideFloat(PlayerRef, isFemale, "Body [Ovl5]", 1, -1)
		Else
			BPTintColorEnd = NiOverride.GetNodeOverrideInt(PlayerRef, IsFemale, "Body [Ovl5]", 7, -1)
			BPGTintColorEnd = NiOverride.GetNodeOverrideInt(PlayerRef, IsFemale, "Body [Ovl5]", 0, -1)
			BPGAlphaEnd = NiOverride.GetNodeOverrideFloat(PlayerRef, isFemale, "Body [Ovl5]", 1, -1)
		EndIf
	Endif
	
	BPTintColorMaxRed = GetRed(BPTintColorStart) as Float
	BPTintColorMaxGreen = GetGreen(BPTintColorStart) as Float
	BPTintColorMaxBlue = GetBlue(BPTintColorStart) as Float
	BPTintDefRed = BPTintColorMaxRed - GetRed(BPTintColorEnd) as Float
	BPTintDefGreen = BPTintColorMaxGreen - GetGreen(BPTintColorEnd) as Float
	BPTintDefBlue = BPTintColorMaxBlue - GetBlue(BPTintColorEnd) as Float
	
	BPGTintColorMaxRed = GetRed(BPGTintColorStart) as Float
	BPGTintColorMaxGreen = GetGreen(BPGTintColorStart) as Float
	BPGTintColorMaxBlue = GetBlue(BPGTintColorStart) as Float
	BPGTintDefRed = BPGTintColorMaxRed - GetRed(BPGTintColorEnd) as Float
	BPGTintDefGreen = BPGTintColorMaxGreen - GetGreen(BPGTintColorEnd) as Float
	BPGTintDefBlue = BPGTintColorMaxBlue - GetBlue(BPGTintColorEnd) as Float
	BPGAlphaDef = BPGAlphaStart - BPGAlphaEnd
EndFunction

Function RegisterEFF()
	Int Mods = Game.GetModCount()
	String Name
	While Mods
		Mods -= 1
		Name = Game.GetModName(Mods)
		If Name == "EFFCore.esm"
			FollowerExtension = (Game.GetFormFromFile(0xEFF, "EFFCore.esm") as Quest)
			XFLMain = (FollowerExtension as EFFCore)
			
			EFFActive = True
		EndIf
	EndWhile
EndFunction

Function OpenRaceMenu(Actor Target)
	Bool UICheck
	Bool RaceMenuCheck
	
	If Game.GetFormFromFile(0xE00, "UIExtensions.esp") != None
		UICheck = True
	Endif
	
	If Game.GetFormFromFile(0x800, "RaceMenu.esp") != None
		RaceMenuCheck = True
	Endif
	
	If UICheck && RaceMenuCheck
		If SKSE.GetPluginVersion("NiOverride") >= 1
			If !NiOverride.HasOverlays(Target)
				NiOverride.AddOverlays(Target)
			Endif
		Endif
		
		UIMenuBase MenuBase = UIExtensions.GetMenu("UICosmeticMenu")
		MenuBase.SetPropertyInt("Categories", 0x7E)
		MenuBase.OpenMenu(Target)
		
		If SKSE.GetPluginVersion("NiOverride") >= 1
			If GetAllVisibleOverlays(Target) == 0
				NiOverride.RemoveOverlays(Target)
			Endif
		Endif
	EndIf
EndFunction

Int Function GetAllVisibleOverlays(Actor Target)
	Int TotalVisible = 0
	If SKSE.GetPluginVersion("NiOverride") >= 1
		TotalVisible += GetVisibleOverlays(Target, 256, "Body [Ovl", NiOverride.GetNumBodyOverlays())
		TotalVisible += GetVisibleOverlays(Target, 257, "Hands [Ovl", NiOverride.GetNumHandOverlays())
		TotalVisible += GetVisibleOverlays(Target, 258, "Feet [Ovl", NiOverride.GetNumFeetOverlays())
		TotalVisible += GetVisibleOverlays(Target, 259, "Face [Ovl", NiOverride.GetNumFaceOverlays())
	EndIf
	Return TotalVisible
EndFunction

Int Function GetVisibleOverlays(Actor Target, Int TintType, String TintTemplate, Int TintCount)
	Int i = 0
	Int Visible = 0
	ActorBase TargetBase = Target.GetActorBase()
	While i < TintCount
	String NodeName = TintTemplate + i + "]"
	Float Alpha = 0
	String Texture = ""
	If NetImmerse.HasNode(Target, NodeName, False)
		Alpha = NiOverride.GetNodePropertyFloat(Target, False, NodeName, 8, -1)
		Texture = NiOverride.GetNodePropertyString(Target, False, NodeName, 9, 0)
	Else
		Bool IsFemale = TargetBase.GetSex() as Bool
		Alpha = NiOverride.GetNodeOverrideFloat(Target, IsFemale, NodeName, 8, -1)
		Texture = NiOverride.GetNodeOverrideString(Target, IsFemale, NodeName, 9, 0)
	EndIf
	If Texture == ""
		Texture = "Actors\\Character\\Overlays\\Default.dds"
	EndIf
	If Texture != "Actors\\Character\\Overlays\\Default.dds" && Alpha > 0.0
		Visible += 1
	EndIf
	i += 1
	EndWhile
	Return Visible
EndFunction

Function GetAccursedBodyPaintData(Actor Accursed, Bool IsStartValue)
	Int TintColor
	Int GlowColor
	Float GlowAlpha
	
	If NetImmerse.HasNode(Accursed, "Body [Ovl5]", False)
		TintColor = NiOverride.GetNodePropertyInt(Accursed, False, "Body [Ovl5]", 7, -1)
		GlowColor = NiOverride.GetNodePropertyInt(Accursed, False, "Body [Ovl5]", 0, -1)
		GlowAlpha = NiOverride.GetNodePropertyFloat(Accursed, False, "Body [Ovl5]", 1, -1)
	Else
		Bool IsFemale = Accursed.GetActorBase().GetSex() as Bool
		TintColor = NiOverride.GetNodeOverrideInt(Accursed, IsFemale, "Body [Ovl5]", 7, -1)
		GlowColor = NiOverride.GetNodeOverrideInt(Accursed, IsFemale, "Body [Ovl5]", 0, -1)
		GlowAlpha = NiOverride.GetNodeOverrideFloat(Accursed, IsFemale, "Body [Ovl5]", 1, -1)
	EndIf
	
	If IsStartValue
		SetFloatValue(Accursed, "PSQ_CurseTattooMaxRed", GetRed(TintColor) as Float)
		SetFloatValue(Accursed, "PSQ_CurseTattooMaxGreen", GetGreen(TintColor) as Float)
		SetFloatValue(Accursed, "PSQ_CurseTattooMaxBlue", GetBlue(TintColor) as Float)
		
		SetFloatValue(Accursed, "PSQ_CurseTattooMaxRedG", GetRed(GlowColor) as Float)
		SetFloatValue(Accursed, "PSQ_CurseTattooMaxGreenG", GetGreen(GlowColor) as Float)
		SetFloatValue(Accursed, "PSQ_CurseTattooMaxBlueG", GetBlue(GlowColor) as Float)
		
		SetFloatValue(Accursed, "PSQ_CurseTattooMaxAlphaG", GlowAlpha as Float)
	Else
		SetFloatValue(Accursed, "PSQ_CurseTattooDefRed", GetFloatValue(Accursed, "PSQ_CurseTattooMaxRed") - GetRed(TintColor) as Float)
		SetFloatValue(Accursed, "PSQ_CurseTattooDefGreen", GetFloatValue(Accursed, "PSQ_CurseTattooMaxGreen") - GetGreen(TintColor) as Float)
		SetFloatValue(Accursed, "PSQ_CurseTattooDefBlue", GetFloatValue(Accursed, "PSQ_CurseTattooMaxBlue") - GetBlue(TintColor) as Float)
		
		SetFloatValue(Accursed, "PSQ_CurseTattooDefRedG", GetFloatValue(Accursed, "PSQ_CurseTattooMaxRedG") - GetRed(TintColor) as Float)
		SetFloatValue(Accursed, "PSQ_CurseTattooDefGreenG", GetFloatValue(Accursed, "PSQ_CurseTattooMaxGreenG") - GetGreen(TintColor) as Float)
		SetFloatValue(Accursed, "PSQ_CurseTattooDefBlueG", GetFloatValue(Accursed, "PSQ_CurseTattooMaxBlueG") - GetBlue(TintColor) as Float)
		
		SetFloatValue(Accursed, "PSQ_CurseTattooDefAlphaG", GetFloatValue(Accursed, "PSQ_CurseTattooMaxAlphaG") - GlowAlpha as Float)
	EndIf
EndFunction

String Function GetVictimRace(Actor Victim)
	String RaceString = sslCreatureAnimationSlots.GetRaceKey(Victim.GetLeveledActorBase().GetRace())
	If RaceString == "Canines" || RaceString == "Wolves" || RaceString == "Dogs" || RaceString == "Foxes"
		Return "Canines"
	ElseIf RaceString == "Bears"
		Return "Bears"
	ElseIf RaceString == "Horses"
		Return "Horses"
	ElseIf RaceString == "Trolls"
		Return "Trolls"
	ElseIf RaceString == "SabreCats"
		Return "SabreCats"
	ElseIf RaceString == "Chaurus" || RaceString == "ChaurusReapers" || RaceString == "ChaurusHunters"
		Return "Chaurus"
	ElseIf RaceString == "Spiders" || RaceString == "LargeSpiders" || RaceString == "GiantSpiders"
		Return "Spiders"
	ElseIf RaceString == "DwarvenBallistas" || RaceString == "DwarvenCenturions" || RaceString == "DwarvenSpheres" || RaceString == "DwarvenSpiders"
		Return "DwarvenBallistas"
	ElseIf RaceString == "Draugrs"
		Return "Draugrs"
	ElseIf RaceString == "Falmers"
		Return "Falmers"
	ElseIf RaceString == "FlameAtronach"
		Return "FlameAtronach"
	ElseIf RaceString == "FrostAtronach"
		Return "FrostAtronach"
	ElseIf RaceString == "Gargoyles"
		Return "Gargoyles"
	ElseIf RaceString == "Lurkers"
		Return "Lurkers"
	ElseIf RaceString == "Giants"
		Return "Giants"
	ElseIf RaceString == "Goats"
		Return "Goats"
	ElseIf RaceString == "Boars" || RaceString == "BoarsAny" || RaceString == "BoarsMounted"
		Return "Boars"
	ElseIf RaceString == "Werewolves"
		Return "Werewolves"
	ElseIf RaceString == "Skeevers"
		Return "Skeevers"
	ElseIf RaceString == "Spriggans"
		Return "Spriggans"
	ElseIf RaceString == "WispMothers"
		Return "WispMothers"
	ElseIf RaceString == "Wisps"
		Return "Wisps"
	ElseIf RaceString == "Dragons"
		Return "Dragons"
	ElseIf RaceString == "DragonPriests"
		Return "DragonPriests"
	ElseIf RaceString == "VampireLords"
		Return "VampireLords"
	ElseIf RaceString == "Cows"
		Return "Cows"
	ElseIf RaceString == "IceWraiths"
		Return "IceWraiths"
	ElseIf RaceString == "Rieklings"
		Return "Rieklings"
	ElseIf RaceString == "Deers"
		Return "Deers"
	ElseIf RaceString == "Ashhoppers"
		Return "Ashhoppers"
	ElseIf RaceString == "Slaughterfishes"
		Return "Slaughterfishes"
	ElseIf RaceString == "Chickens"
		Return "Chickens"
	ElseIf RaceString == "Hagravens"
		Return "Hagravens"
	ElseIf RaceString == "Mammoths"
		Return "Mammoths"
	ElseIf RaceString == "Horkers"
		Return "Horkers"
	ElseIf RaceString == "Mudcrabs"
		Return "Mudcrabs"
	ElseIf RaceString == "Netches"
		Return "Netches"
	ElseIf RaceString == "Rabbits"
		Return "Rabbits"
	ElseIf RaceString == "Seekers"
		Return "Seekers"
	ElseIf RaceString == "StormAtronach"
		Return "StormAtronach"
	Else
		Return "None"
	EndIf
EndFunction
