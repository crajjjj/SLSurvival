Scriptname _STA_SpankUtil extends Quest Conditional

Int[] AssSpankCounter
Int[] TitsSpankCounter
Int[] DeviousSlots

;Float[] IntensityHistoryAss
;Float[] IntensityHistoryTits
Float[] MasochistHistory

Int[] Property AssSpankTracking
    Int[] Function Get()
        Return AssSpankCounter
    EndFunction
EndProperty

Int[] Property TitSpankTracking
    Int[] Function Get()
        Return TitsSpankCounter
    EndFunction
EndProperty

Int[] Property DeviousSlotTracking
    Int[] Function Get()
        Return DeviousSlots
    EndFunction
EndProperty

Float[] Property MasochismTracking
    Float[] Function Get()
        Return MasochistHistory
    EndFunction
EndProperty

Bool Property BumpSpankToggle = true Auto Hidden Conditional
Bool Property SexSpankToggle = true Auto Hidden
Bool Property SexSlapNotify = false Auto Hidden
Bool Property BumpSpankNotifications = true Auto Hidden

Float Property MasochismStepSize = 0.5 Auto Hidden; Needs MCM Setting

Float LastUpdate
Float MasochismLastUpdate
Float Property IntensityAss = 0.0 Auto Hidden Conditional
Float Property IntensityTits = 0.0 Auto Hidden Conditional
Float Property PlayerMasochism = 0.0 Auto Hidden ; 0 - Hates, 1 - Dislikes, 2 - Likes, 3 - Loves
Float Property SpankStaminaPercent = 0.15 Auto Hidden ; Percentage Stamina damaged/restored per spank
Float Property BaseSpankArousalMod = 2.0 Auto Hidden 

Float Property SlapHeavyVolume = 0.6 Auto Hidden ; Needs MCM Setting
Float Property SlapLightVolume = 0.6 Auto Hidden ; Needs MCM Setting
Float Property SlapMoanVolume = 0.6 Auto Hidden ; Needs MCM Setting

Float Property MaxAssIntensity = 1.0 Auto Hidden ; Needs MCM Setting
Float Property MaxTitsIntensity = 1.0 Auto Hidden ; Needs MCM Setting
Float Property AgeFadeFactor = 1.0 Auto Hidden 
Float Property SpanksToHeal = 0.0 Auto Hidden
Float Property RunUpAndSpankTimeout = 3.0 Auto Hidden
Float Property BumpSpankVibeChance = 33.3 Auto Hidden
Float Property BumpSpankStaggerChance = 65.0 Auto Hidden

Int Property RapeCount Auto Hidden
Int Property SpanksToMaxIntensity = 30 Auto Hidden; Needs MCM Setting
Int SpankCounterLimit = 48 ; Number of hours to consider. Also equals array size
Int MasochistHistoryLimit = 28 ; Number of 'periods' to consider for masochism progress. Periods = update frequency. Limit * Periods = total masochism history
Int MasochistHistoryPeriod = 6 ; Update player masochism every x hours
Int Property SpankerGender Auto Hidden Conditional ; 0 - male, 1 - female, -1 - None
Int Property SpankType Auto Hidden Conditional ; 0 - Ass, 1 - tits
Int Property DdThreshold = 3 Auto Hidden

Int Property DflowSpankThreshold = 1 Auto Hidden
Int DflowSpankCounter = 0
Int SpankedNpcIndex = 0

Sound Property _STA_SlapMoan Auto
Sound Property _STA_SlapMoanGagged Auto
Sound Property _STA_SlapHeavy Auto

Formlist Property _STA_EquippedDdsList Auto

Actor Property PlayerRef Auto

Faction Property zbfFactionSlave Auto Hidden; Zaz slaves
Faction Property _pchsSlavesFaction Auto Hidden; SBC slaves
Faction Property _STA_DummyNeverUsedFaction Auto
Faction Property _STA_NeverSpankFaction Auto
;Faction Property EventSpecificSpankFaction Auto Hidden

Keyword Property zad_DeviousHeavyBondage Auto Hidden
Keyword Property zad_DeviousPlug Auto Hidden
Keyword Property zad_DeviousPiercingsNipple Auto Hidden
Keyword Property _STA_DummyNeverUsedKeyword Auto

Potion Property _STA_SkinBalm01 Auto

Spell Property _STA_SpankPlayerDetectSpell Auto
Spell Property _STA_SkinBalmVisibleSpell Auto
Spell Property _STA_BumpSpankCooloffSpell Auto
Spell Property _STA_DoPlayerSpankNpcSpell Auto
Spell Property _STA_SpankedNpcSpell Auto

;GlobalVariable Property _DWill Auto
;GlobalVariable Property _STA_DflowWill Auto

;Topic Property EventSpecificSpankBeginTopic Auto Hidden
;Topic Property EventSpecificSpankEndTopic Auto Hidden

Topic Property _STA_SpankingSlapReplyHatesTopic Auto
Topic Property _STA_SpankingSlapReplyDislikesTopic Auto
Topic Property _STA_SpankingSlapReplyLikesTopic Auto
Topic Property _STA_SpankingSlapReplyLovesTopic Auto

Topic Property _STA_SpankingSexSpankHatesTopic Auto
Topic Property _STA_SpankingSexSpankLovesTopic Auto

Topic Property _STA_PlayerGaggedSpankReplyTopic Auto
Topic Property _STA_SpankedNpcResponse00 Auto

Topic Property _STA_SpankEventStockComments00 Auto

Quest Property _STA_RandomNpcRunUpAndSpankQuest Auto
Quest Property _STA_RandomNpcRunUpAndSpankFurnQuest Auto
Quest Property _STA_SpecificNpcRunUpAndSpankQuest Auto
Quest Property _STA_SpankedNpcAliasesQuest Auto

_STA_InterfaceDeviousFollowers Property Dflow Auto
_STA_InterfaceDeviousDevices Property Devious Auto
_STA_SexDialogUtil Property SexDialog Auto
_STA_Mcm Property Menu Auto
SexlabFramework Property Sexlab Auto

Event OnInit()
	CheckDependencies()
	LastUpdate = Utility.GetCurrentGameTime()
	MasochismLastUpdate = Utility.GetCurrentGameTime()
	AssSpankCounter = new Int[128]
	TitsSpankCounter = new Int[128]
	MasochistHistory = new Float[128]
	DeviousSlots = new Int[17]
	SetupDeviousSlots()
	PlayerRef.AddSpell(_STA_SpankPlayerDetectSpell, false)
	PlayerRef.AddSpell(_STA_DoPlayerSpankNpcSpell, false)
	RegEvents()
EndEvent

; Timeout - How long before releasing the Npc from the spank alias. For Milk Addict this is as long as your character is on the ground during a trip event
; AllowNpcInFurniture - Allows Npcs in furniture (eg: Crafting) to be selected to spank you. For MA this would take too long for it's trip events
Event OnSTA_DoRandomNpcSpank(Float Timeout, Bool AllowNpcInFurniture, Float ResistLoss = -1.0)
	Debug.Trace("_STA_: Received OnSTA_DoRandomNpcSpank")
	RunUpAndSpankTimeout = Timeout
	_STA_RandomNpcRunUpAndSpankQuest.Stop()
	_STA_RandomNpcRunUpAndSpankFurnQuest.Stop()
	Dflow.ModEventResistLoss = ResistLoss
	If AllowNpcInFurniture
		_STA_RandomNpcRunUpAndSpankFurnQuest.Start()
	Else
		_STA_RandomNpcRunUpAndSpankQuest.Start()
	EndIf
EndEvent

Event OnSTA_DoNpcSpankSpecificCustom(Float Timeout, Form ActorForm, Form SpankBeginTopic, Form SpankEndTopic, Float ResistLoss = -1.0)
	; Event used to send a specific Npc to spank the player with custom comments. 'Always use dummy' must be disabled for custom comments to work
	
	; STA contains the keyword _STA_NpcDialogOutEffect. It is injected into Update.esm. Copy this keyword to your mod and use it as a condition on your dialogue to stop Npcs saying it outside of spanks
	; Use the condition 'HasMagicEffectKeyword' _STA_NpcDialogOutEffect == 1.0
	; STA will handle adding the magic effect with this keyword to enable the dialogue and will remove it afterwards. 
	
	; SpankBeginTopic: NOT YET IMPLEMENTED! A topic from your mod you want an npc to say when begin their approach
	; SpankEndTopic: A topic from your mod you want an npc to say a short time after they sucessfully spank the player
	
	Debug.Trace("_STA_: Received OnSTA_DoNpcSpankSpecificCustom: ActorForm: " + ActorForm + ". SpankBeginTopic: " + SpankBeginTopic + ". SpankEndTopic: " + SpankEndTopic + ". Timeout: " + Timeout)
	Actor akActor = ActorForm as Actor
	If akActor && !_STA_SpecificNpcRunUpAndSpankQuest.IsRunning()
		If akActor.Is3dLoaded()
			If SpankEndTopic as Topic
				SexDialog.DummyNpcWhatToSay = SpankEndTopic as Topic
			EndIf
			(Self.GetNthAlias(1) as ReferenceAlias).ForceRefTo(akActor)
			Dflow.ModEventResistLoss = ResistLoss
			_STA_SpecificNpcRunUpAndSpankQuest.Start()
		EndIf
	Else
		Debug.Trace("_STA_: _STA_SpecificNpcRunUpAndSpankQuest is currently busy")
	EndIf
EndEvent

Event OnSTA_DoNpcSpankSpecific(Float Timeout, Form ActorForm, Bool DoComment, Float ResistLoss = -1.0)
	; Event used to send a specific Npc to spank the player. Npc says a stock STA comment on successful spanks if DoComment is true
	
	Debug.Trace("_STA_: Received OnSTA_DoNpcSpankSpecific: ActorForm: " + ActorForm + ". Timeout: " + Timeout)
	
	Actor akActor = ActorForm as Actor
	If akActor && !_STA_SpecificNpcRunUpAndSpankQuest.IsRunning()
		If akActor.Is3dLoaded()
			If DoComment
				SexDialog.DummyNpcWhatToSay = _STA_SpankEventStockComments00
			EndIf
			Dflow.ModEventResistLoss = ResistLoss
			(Self.GetNthAlias(1) as ReferenceAlias).ForceRefTo(akActor)
			_STA_SpecificNpcRunUpAndSpankQuest.Start()
		EndIf
	Else
		Debug.Trace("_STA_: _STA_SpecificNpcRunUpAndSpankQuest is currently busy")
	EndIf
EndEvent

Event OnSTA_DoPlayerComment(Form WhatToSay, Bool PriorityComment, Bool ForcedGagComment = false)
	If WhatToSay as Topic
		SexDialog.QueueComment(WhatToSay as Topic, PriorityComment, ForcedGagComment)
	EndIf
EndEvent

Function DoGameTimeUpdate()
	Float CurrentTime = Utility.GetCurrentGameTime()
	Int NumOfHours = Math.Floor((CurrentTime - LastUpdate) / 0.041667)
	Debug.Trace("_STA_: Spanky: Waited " + NumOfHours + " hours ===============================================================================================")

	;/
    Int DoBalmUpdate = ModEvent.Create("SLS_DoBalmUpdate")
    If (DoBalmUpdate)
        ModEvent.Send(DoBalmUpdate)
    EndIf	
	
	Utility.WaitMenuMode(5.0)
/;

	HealSpanks(NumOfHours, false)
	
	ShiftIntArrayLeft(AssSpankCounter, SpankCounterLimit, NumOfHours)
	ShiftIntArrayLeft(TitsSpankCounter, SpankCounterLimit, NumOfHours)
		
	IntensityAss = GetOverlayIntensity(AssSpankCounter)
	IntensityTits = GetOverlayIntensity(TitsSpankCounter)
	
	; Update Alphas
	UpdateAlpha(PlayerRef, IntensityAss, "\\SL Survival\\spanky\\spank_ass_light.dds", "Body")
	UpdateAlpha(PlayerRef, IntensityTits, "\\SL Survival\\spanky\\spank_breasts_light.dds", "Body")
	
	
	
	AdjustMasochismAttitude(CurrentTime)
	SexDialog.ApplyPainEffect()
	LastUpdate = CurrentTime
	
	;/
	Debug.Trace("_STA_: IntensityHistoryAss: DEBUG BEGIN **********************************************************************************************")
	Int i = SpankCounterLimit - 1
	While i > 0
		Debug.Trace("_STA_: Array: IntensityHistoryAss[" + i + "] = " + IntensityHistoryAss[i])
		i -= 1
	EndWhile
	Debug.Trace("_STA_: IntensityHistoryAss: DEBUG END **********************************************************************************************")
	
	Debug.Trace("_STA_: MasochistHistory: DEBUG BEGIN **********************************************************************************************")
	int i = SpankCounterLimit - 1
	While i > 0
		Debug.Trace("_STA_: Array: MasochistHistory[" + i + "] = " + MasochistHistory[i])
		i -= 1
	EndWhile
	Debug.Trace("_STA_: MasochistHistory: DEBUG END **********************************************************************************************")
	/;
EndFunction

Function PlayerLoadsGame()
	CheckDependencies()
	IntensityAss = GetOverlayIntensity(AssSpankCounter)
	IntensityTits = GetOverlayIntensity(TitsSpankCounter)
	UpdateAlpha(PlayerRef, IntensityAss, "\\SL Survival\\spanky\\spank_ass_light.dds", "Body")
	UpdateAlpha(PlayerRef, IntensityTits, "\\SL Survival\\spanky\\spank_breasts_light.dds", "Body")
	SexDialog.ApplyPainEffect()
	RegEvents()
EndFunction

Function CheckDependencies()
	If Game.GetModByName("ZaZAnimationPack.esm") != 255
		zbfFactionSlave = Game.GetFormFromFile(0x0096AE, "ZaZAnimationPack.esm") as Faction
	Else
		zbfFactionSlave = _STA_DummyNeverUsedFaction
	EndIf
	If Game.GetModByName("SexyBanditCaptives.esp") != 255
		_pchsSlavesFaction = Game.GetFormFromFile(0x00E6B7, "SexyBanditCaptives.esp") as Faction
	Else
		zbfFactionSlave = _STA_DummyNeverUsedFaction
	EndIf
	If Game.GetModByName("Devious Devices - Integration.esm") != 255
		zad_DeviousHeavyBondage = Game.GetFormFromFile(0x05226C, "Devious Devices - Integration.esm") as Keyword ; zad_DeviousHeavyBondage
		zad_DeviousPlug = Game.GetFormFromFile(0x003331, "Devious Devices - Assets.esm") as Keyword ; zad_DeviousPlug
		zad_DeviousPiercingsNipple = Game.GetFormFromFile(0x00CA39, "Devious Devices - Assets.esm") as Keyword ; zad_DeviousPiercingsNipple
	Else
		zad_DeviousHeavyBondage = _STA_DummyNeverUsedKeyword
		zad_DeviousPlug = _STA_DummyNeverUsedKeyword
		zad_DeviousPiercingsNipple = _STA_DummyNeverUsedKeyword
	EndIf
EndFunction

Function RegEvents()
	RegisterForModEvent("STA_DoRandomNpcSpank", "OnSTA_DoRandomNpcSpank")
	RegisterForModEvent("STA_DoNpcSpankSpecific", "OnSTA_DoNpcSpankSpecific")
	RegisterForModEvent("STA_DoNpcSpankSpecificCustom", "OnSTA_DoNpcSpankSpecificCustom")
	RegisterForModEvent("STA_DoPlayerComment", "OnSTA_DoPlayerComment")
EndFunction

Function ModPlayerArousal()
	Float Amount = BaseSpankArousalMod * GetMasochismAttitude(PlayerMasochism)
    ModArousal(PlayerRef, Amount)
EndFunction

Function ModArousal(Actor akActor, Float Amount)
	Amount = BaseSpankArousalMod * GetMasochismAttitude(PlayerMasochism)
    Int ModArousalEvent = ModEvent.Create("slaUpdateExposure")
    ModEvent.PushForm(ModArousalEvent, akActor)
    ModEvent.PushFloat(ModArousalEvent, Amount)
    ModEvent.Send(ModArousalEvent)
EndFunction

Function DoBumpSpank(Actor akSpeaker, Bool DoStagger)
	If CanDoBumpSpank(akSpeaker)
		_STA_BumpSpankCooloffSpell.Cast(akSpeaker, akSpeaker)
		If Utility.RandomFloat(0.0, 100.0) > 50.0
			DoAssBumpSpank(akSpeaker, DoStagger)
		Else
			If Utility.RandomFloat(0.0, 100.0) > 75.0
				DoTitsBumpGrope(akSpeaker)
			Else
				DoTitsBumpSpank(akSpeaker, DoStagger)
			EndIf
		EndIf
	EndIf
EndFunction

Bool Function CanDoBumpSpank(Actor akTarget)
	If akTarget.IsInFaction(zbfFactionSlave) || akTarget.IsInFaction(_pchsSlavesFaction)
		akTarget.AddToFaction(_STA_NeverSpankFaction)
		Return false
	Else
		If akTarget.WornHasKeyword(zad_DeviousHeavyBondage)
			Return false
		EndIf
	EndIf
	Return true
EndFunction

Function DoAssBumpSpank(Actor akSpeaker, Bool DoStagger)
	SpankerGender = akSpeaker.GetLeveledActorBase().GetSex()
	BumpNotification(akSpeaker.GetBaseObject().GetName() + " slaps your ass hard as you walk by")
	Debug.SendAnimationEvent(akSpeaker, "IdleTake")
	IncSpankCounter(AssSpankCounter)
	Utility.Wait(0.05)
	If DoStagger && !PlayerRef.IsOnMount() && StorageUtil.GetIntValue(None, "_STA_ForbidSpankStaggers", Missing = 0) == 0 && BumpSpankStaggerChance > Utility.RandomFloat(0.0, 100.0)
		;Debug.SendAnimationEvent(PlayerRef, "staggerStart")
		Debug.SendAnimationEvent(PlayerRef, "Sta_slap_forward")
	EndIf
	Utility.Wait(0.05)
	SlapSound(PlayerRef)
	SexDialog.QueueComment(GetBumpSpankComment(), PriorityComment = false)
	SpankModStamina(false)
	IntensityAss = GetOverlayIntensity(AssSpankCounter)
	UpdateAlpha(PlayerRef, IntensityAss, "\\SL Survival\\spanky\\spank_ass_light.dds", "Body")
	DecDflowWill("bum is")
	SexDialog.ApplyPainEffect()
	AssSpankVibe()
	ModPlayerArousal()
EndFunction

Function DoTitsBumpSpank(Actor akSpeaker, Bool DoStagger)
	SpankerGender = akSpeaker.GetLeveledActorBase().GetSex()
	BumpNotification(akSpeaker.GetBaseObject().GetName() + " slaps your tits hard as you walk by")
	Debug.SendAnimationEvent(akSpeaker, "IdleTake")
	Utility.Wait(0.05)
	If DoStagger && !PlayerRef.IsOnMount() && StorageUtil.GetIntValue(None, "_STA_ForbidSpankStaggers", Missing = 0) == 0 && BumpSpankStaggerChance > Utility.RandomFloat(0.0, 100.0)
		;Debug.SendAnimationEvent(PlayerRef, "staggerStart")
		Debug.SendAnimationEvent(PlayerRef, "Sta_slap_backward")
	EndIf
	Utility.Wait(0.05)
	SlapSound(PlayerRef)
	SexDialog.QueueComment(GetBumpSpankComment(), PriorityComment = false)
	IncSpankCounter(TitsSpankCounter)
	SpankModStamina(false)
	IntensityTits = GetOverlayIntensity(TitsSpankCounter)
	UpdateAlpha(PlayerRef, IntensityTits, "\\SL Survival\\spanky\\spank_breasts_light.dds", "Body")
	DecDflowWill("breasts are")
	SexDialog.ApplyPainEffect()
	ModPlayerArousal()
	TitsSpankVibe()
	SexDialog.BeginBoobLeak()
EndFunction

Function DoTitsBumpGrope(Actor akSpeaker)
	SpankerGender = akSpeaker.GetLeveledActorBase().GetSex()
	Debug.SendAnimationEvent(akSpeaker, "IdleTake")
	BumpNotification(akSpeaker.GetBaseObject().GetName() + " roughly gropes your tits as you pass by")
	Utility.Wait(0.5)
	SexDialog.QueueComment(GetBumpSpankComment(), PriorityComment = false)
	IncSpankCounter(TitsSpankCounter)
	SpankModStamina(false)
	IntensityTits = GetOverlayIntensity(TitsSpankCounter)
	UpdateAlpha(PlayerRef, IntensityTits, "\\SL Survival\\spanky\\spank_breasts_light.dds", "Body")
	DecDflowWill("tits are")
	SexDialog.ApplyPainEffect()
	ModPlayerArousal()
	SexDialog.BeginBoobLeak()
EndFunction

Function BumpNotification(String Note)
	If BumpSpankNotifications
		Debug.Notification(Note)
	EndIf
EndFunction

Function DoSexSpank(Actor SexParnter)
	If Utility.RandomFloat(0.0, 100.0) > 50.0
		DoSexSpankAss(SexParnter)
	Else
		DoSexSpankTits(SexParnter)
	EndIf
EndFunction

Function DoSexSpankAss(Actor SexParnter)
	SpankerGender = SexParnter.GetLeveledActorBase().GetSex()
	If SexSlapNotify
		Debug.Notification(SexParnter.GetBaseObject().GetName() + " slaps your ass hard as they fuck you")
	EndIf
	IncSpankCounter(AssSpankCounter)
	SlapSound(PlayerRef)
	SexDialog.QueueComment(GetSexSpankComment(), PriorityComment = false)
	SpankModStamina(true)
	SexDialog.BeginSpankModEnjoyment()
	IntensityAss = GetOverlayIntensity(AssSpankCounter)
	UpdateAlpha(PlayerRef, IntensityAss, "\\SL Survival\\spanky\\spank_ass_light.dds", "Body")
	DecDflowWill("bum is")
	SexDialog.ApplyPainEffect()
	ModPlayerArousal()
EndFunction

Function DoSexSpankTits(Actor SexParnter)
	SpankerGender = SexParnter.GetLeveledActorBase().GetSex()
	If SexSlapNotify
		Debug.Notification(SexParnter.GetBaseObject().GetName() + " slaps your tits hard as they fuck you")
	EndIf
	IncSpankCounter(TitsSpankCounter)
	SlapSound(PlayerRef)
	SexDialog.QueueComment(GetSexSpankComment(), PriorityComment = false)
	SpankModStamina(true)
	SexDialog.BeginSpankModEnjoyment()
	IntensityTits = GetOverlayIntensity(TitsSpankCounter)
	UpdateAlpha(PlayerRef, IntensityTits, "\\SL Survival\\spanky\\spank_breasts_light.dds", "Body")
	DecDflowWill("tits are")
	SexDialog.ApplyPainEffect()
	ModPlayerArousal()
	SexDialog.BeginBoobLeak()
EndFunction

Function AssSpankVibe()
	If PlayerRef.WornHasKeyword(zad_DeviousPlug) && BumpSpankVibeChance > Utility.RandomFloat(0.0, 100.0) && Devious.HasVibePlugs(PlayerRef)
		Devious.VibrateEffect(PlayerRef, vibStrength = Utility.RandomInt(1, 5), duration = Utility.RandomInt(3, 8), teaseOnly = false, silent = false)
	EndIf
EndFunction

Function TitsSpankVibe()
	If PlayerRef.WornHasKeyword(zad_DeviousPiercingsNipple) && BumpSpankVibeChance > Utility.RandomFloat(0.0, 100.0) && Devious.HasVibeNipplePiercings(PlayerRef)
		Devious.VibrateEffect(PlayerRef, vibStrength = Utility.RandomInt(1, 5), duration = Utility.RandomInt(3, 8), teaseOnly = false, silent = false)
	EndIf
EndFunction

Function SlapSound(Actor akTarget)
	Int SlapHeavy = _STA_SlapHeavy.Play(akTarget)
	Sound.SetInstanceVolume(SlapHeavy, SlapHeavyVolume) 
	Utility.Wait(0.1)
	Int SlapMoan
	If SexDialog.IsMouthAvailable
		SlapMoan = _STA_SlapMoan.Play(akTarget)
	Else
		SlapMoan = _STA_SlapMoanGagged.Play(akTarget)
	EndIf
	Sound.SetInstanceVolume(SlapMoan, SlapMoanVolume) 
	Utility.Wait(0.5)
EndFunction

Function DecDflowWill(String SlapString)
	If DflowSpankThreshold > 0
		DflowSpankCounter += 1
		If DflowSpankCounter >= DflowSpankThreshold
			Dflow.DecDflowWill(SlapString)
			DflowSpankCounter = 0
		EndIf
	EndIf
EndFunction

Function SpankModStamina(Bool IsSexing)
	Float ModAmount = PlayerRef.GetBaseActorValue("Stamina") * SpankStaminaPercent * GetMasochismAttitude(PlayerMasochism)
	If ModAmount > 0.0
		PlayerRef.RestoreActorValue("Stamina", ModAmount)
	Else
		PlayerRef.DamageActorValue("Stamina", ModAmount)
	EndIf
EndFunction

Topic Function GetBumpSpankComment()
	If PlayerMasochism < MasochismStepSize ; Hates
		Return _STA_SpankingSlapReplyHatesTopic
	ElseIf PlayerMasochism < MasochismStepSize * 2.0 ; Dislikes
		Return _STA_SpankingSlapReplyDislikesTopic
	ElseIf PlayerMasochism < MasochismStepSize * 3.0 ; Likes
		Return _STA_SpankingSlapReplyLikesTopic
	Else
		Return _STA_SpankingSlapReplyLovesTopic ; Loves
	EndIf
EndFunction

Topic Function GetSexSpankComment()
	If SexDialog.IsMouthAvailable == 0 ; Gagged
		Return _STA_PlayerGaggedSpankReplyTopic
	Else
		If PlayerMasochism < MasochismStepSize * 2.0 ; Dislikes
			Return _STA_SpankingSexSpankHatesTopic
		Else
			Return _STA_SpankingSexSpankLovesTopic
		EndIf
	EndIf
EndFunction

Function AdjustMasochismAttitude(Float CurrentTime)
	If !Menu.PauseMasochism
		Int NumOfUpdates = Math.Floor((Math.Floor(CurrentTime * 24.0) - Math.Floor(MasochismLastUpdate * 24)) / MasochistHistoryPeriod)  ; Update every MasochistHistoryPeriod hours
		If NumOfUpdates > 0
			; Apply healing

			Float DeviousFactor = (GetDeviousMasochismFactor() as Float) - DdThreshold ; Allow x DDs before affecting trait
			If DeviousFactor < 0.0
				DeviousFactor = 0.0
			EndIf
			Debug.Trace("_STA_: Devious Factor: " + DeviousFactor + ". RapeCount: " + RapeCount)
			Float NextElement = ((AddIntArray(AssSpankCounter, SpankCounterLimit, CountTo = 0;/(SpankCounterLimit - MasochistHistoryPeriod)/;)    +     AddIntArray(TitsSpankCounter, SpankCounterLimit, CountTo = 0;/(SpankCounterLimit - MasochistHistoryPeriod)/;)   +   (DeviousFactor * 1.0)   +   (RapeCount * 3.0))   /    MasochistHistoryPeriod)
			;Debug.Messagebox("NextElement: " + NextElement)
			ShiftFloatArrayLeft(MasochistHistory, MasochistHistoryLimit, NumOfUpdates, NextElement, "MasochistHistory")
			
			Float OldAttitude = PlayerMasochism
			PlayerMasochism = AddFloatArray(MasochistHistory, MasochistHistoryLimit) / MasochistHistoryLimit
			
			; Cap it
			Float MasCap = (4.0 * MasochismStepSize)
			If PlayerMasochism > MasCap
				PlayerMasochism = MasCap
			EndIf

			Debug.Trace("_STA_: Player masochism: " + PlayerMasochism)
			MasochismLastUpdate = CurrentTime
			RapeCount = 0

			If GetMasochismAttitude(OldAttitude) != GetMasochismAttitude(PlayerMasochism) ; Attitude changed
				If PlayerMasochism < MasochismStepSize
					Debug.Notification("I hate being spanked")
				ElseIf PlayerMasochism < MasochismStepSize * 2.0
					Debug.Notification("A little light spanking isn't so bad I guess")
				ElseIf PlayerMasochism < MasochismStepSize * 3.0
					Debug.Notification("I kind of like being spanked")
				Else
					Debug.Notification("I love being spanked. I need more pain")
				EndIf
			EndIf
		EndIf
	EndIf
EndFunction

Int Function GetMasochismAttitude(Float ValueToCheck)
	If ValueToCheck < MasochismStepSize ; Hates
		Return -2
	ElseIf ValueToCheck < MasochismStepSize * 2.0 ; Dislikes
		Return -1
	ElseIf ValueToCheck < MasochismStepSize * 3.0 ; Likes
		Return 1
	Else
		Return 2 ; Loves
	EndIf
EndFunction

Bool Function GetIsPlayerMasochist()
	Int Masochism = GetMasochismAttitude(PlayerMasochism)
	If Masochism < 0
		Return false
	Else
		Return true
	EndIf
EndFunction

Function BeginOverlay(Actor akTarget, Float Alpha, String TextureToApply, String Area)
	Bool Gender = akTarget.GetLeveledActorBase().GetSex() as Bool
	Debug.Trace("_STA_: Spanky: Applying " + TextureToApply + " to " + akTarget.GetBaseObject().GetName())
	ReadyOverlay(akTarget, Gender, Area, TextureToApply, Alpha)
EndFunction

Function ReadyOverlay(Actor akTarget, Bool Gender, String Area, String TextureToApply, Float Alpha)
	Int SlotToUse = GetEmptySlot(akTarget, Gender, Area)
	If SlotToUse != -1
		ApplyOverlay(akTarget, Gender, Area, SlotToUse, TextureToApply, Alpha)
	Else
		Debug.Trace("_STA_: Spanky: Error applying overlay to area: " + Area)
	EndIf
EndFunction

Function ApplyOverlay(Actor akTarget, Bool Gender, String Area, String OverlaySlot, String TextureToApply, Float Alpha)
	String Node = Area + " [ovl" + OverlaySlot + "]"
	If !NiOverride.HasOverlays(akTarget)
		NiOverride.AddOverlays(akTarget)
	EndIf
	NiOverride.AddNodeOverrideString(akTarget, Gender, Node, 9, 0, TextureToApply, TRUE)
	NiOverride.AddNodeOverrideInt(akTarget, Gender, Node, 0, 0, 0, TRUE)
	NiOverride.AddNodeOverrideInt(akTarget, Gender, Node, 7, 0, 0, TRUE)
	
	NiOverride.AddNodeOverrideInt(akTarget, Gender, Node, 7, -1, 0, TRUE)
    NiOverride.AddNodeOverrideInt(akTarget, Gender, Node, 0, -1, 0, TRUE)
    NiOverride.AddNodeOverrideFloat(akTarget, Gender, Node, 8, -1, Alpha, TRUE)
	NiOverride.AddNodeOverrideFloat(akTarget, Gender, Node, 2, -1, 0.0, TRUE)
	NiOverride.AddNodeOverrideFloat(akTarget, Gender, Node, 3, -1, 0.0, TRUE)
	NiOverride.ApplyNodeOverrides(akTarget)
EndFunction

Int Function GetEmptySlot(Actor akTarget, Bool Gender, String Area)
	Int i = GetNumSlots(Area)
	String TexPath
	While i > 0
		i -= 1
		TexPath = NiOverride.GetNodeOverrideString(akTarget, Gender, Area + " [ovl" + i + "]", 9, 0)
		If TexPath == "" || TexPath == "actors\\character\\overlays\\default.dds"
			Debug.Trace("_STA_: GetEmptySlot: Slot " + i + " chosen for area: " + area + " on " + akTarget.GetBaseObject().GetName())
			Return i
		EndIf
	EndWhile
	Debug.Trace("_STA_: GetEmptySlot: Error: Could not find a free slot in area: " + Area + " on "  + akTarget.GetBaseObject().GetName())
	Return -1
EndFunction

Function UpdateAlpha(Actor akTarget, Float Alpha, String TextureToUpdate, String Area)
	Int SpankSlot = GetSpankOverlaySlot(akTarget, TextureToUpdate, Area)
	If SpankSlot == -1
		BeginOverlay(akTarget, Alpha, TextureToUpdate, Area)
		SpankSlot = GetSpankOverlaySlot(akTarget, TextureToUpdate, Area)
		If SpankSlot == -1
			Debug.Trace("_STA_: Spanky: Critical error getting spank overlay slot")
			Return
		EndIf
	EndIf

	Debug.Trace("_STA_: Spanky: Update alpha on " + akTarget.GetBaseObject().GetName() + " to " + Alpha)
	String Node = Area + " [ovl" + SpankSlot + "]"
	Bool Gender = akTarget.GetLeveledActorBase().GetSex() as Bool
	NiOverride.AddNodeOverrideFloat(akTarget, Gender, Node, 8, -1, Alpha, TRUE)
EndFunction

Int Function GetSpankOverlaySlot(Actor akTarget, String TextureToUpdate, String Area)
	String Node
	Bool Result = false	
	Bool Gender = akTarget.GetLeveledActorBase().GetSex() as Bool
	String MatchString = TextureToUpdate
	Int j = GetNumSlots(Area)
	While j > 0 && !Result
		j -= 1
		Node = Area + " [ovl" + j + "]"
		If NiOverride.GetNodeOverrideString(akTarget, Gender, Node, 9, 0) == MatchString
			Return j
		EndIf
	EndWhile
	Return -1
EndFunction

Function RemoveOverlay(Actor akTarget, String TextureToRemove, String Area)
	Debug.Trace("_STA_: RemoveOverlay : " + TextureToRemove + " called on " + akTarget.GetLeveledActorBase().GetName() + " from area: " + Area)
	Bool Gender = akTarget.GetLeveledActorBase().GetSex() as Bool
	String TexPath
	Int j = 0
	While j < GetNumSlots(Area)
		String Node = Area + " [ovl" + j + "]"
		TexPath = NiOverride.GetNodeOverrideString(akTarget, Gender, Node, 9, 0)
		If TexPath == TextureToRemove
			NiOverride.AddNodeOverrideString(akTarget, Gender, Node, 9, 0, "actors\\character\\overlays\\default.dds", true)
			NiOverride.RemoveNodeOverride(akTarget, Gender, Node, 9, 0)
			NiOverride.RemoveNodeOverride(akTarget, Gender, Node, 7, -1)
			NiOverride.RemoveNodeOverride(akTarget, Gender, Node, 0, -1)
			NiOverride.RemoveNodeOverride(akTarget, Gender, Node, 8, -1)
			NiOverride.RemoveNodeOverride(akTarget, Gender, Node, 2, -1)
			NiOverride.RemoveNodeOverride(akTarget, Gender, Node, 3, -1)

			Debug.Trace("_STA_: Removing overlay from slot " + j + " of area: " + Area + " on " + akTarget.GetLeveledActorBase().GetName())
		EndIf
		j += 1
	EndWhile
EndFunction

Int Function GetNumSlots(String Area)
	If Area == "Body"
		Return NiOverride.GetNumBodyOverlays()
	ElseIf Area == "Face"
		Return NiOverride.GetNumFaceOverlays()
	ElseIf Area == "Hands"
		Return NiOverride.GetNumHandOverlays()
	Else
		Return NiOverride.GetNumFeetOverlays()
	EndIf
EndFunction

Float Function GetOverlayIntensity(Int[] ArraySelect)
	Float IntensityTemp = 0.0
	Float AgeFactor
	Int i = SpankCounterLimit
	Float SpankCounterLimitAsFloat = SpankCounterLimit as Float
	While i >= 0
		AgeFactor = (i / SpankCounterLimitAsFloat)
		;Debug.Messagebox("i: " + i + ". AgeFactor: " + AgeFactor)
		IntensityTemp += (AgeFactor * AgeFactor * AgeFadeFactor) * ArraySelect[i]
		;Debug.Trace("_STA_: Spanky: i: " + i + ". SpankCounterLimitAsFloat: " + SpankCounterLimitAsFloat + ". AgeFactor: " + AgeFactor + ". Spanks: " + ArraySelect[i])
		i -= 1
	EndWhile
	IntensityTemp = (IntensityTemp / SpanksToMaxIntensity)
	If IntensityTemp > 1.0
		IntensityTemp = 1.0
	EndIf
	
	; Cap intensity
	If ArraySelect == AssSpankCounter
		IntensityTemp *= MaxAssIntensity
	ElseIf ArraySelect == TitsSpankCounter
		IntensityTemp *= MaxTitsIntensity
	EndIf
	Debug.Trace("_STA_: Spanky: IntensityTemp: " + IntensityTemp)
	Return IntensityTemp
EndFunction

Function IncSpankCounter(Int[] ArraySelect)
	ArraySelect[SpankCounterLimit - 1] = ArraySelect[SpankCounterLimit - 1] + 1
	Debug.Trace("_STA_: Spanky: CounteR: " + ArraySelect[SpankCounterLimit - 1])
EndFunction

Function BeginBalm()
	If PlayerRef.GetWornForm(0x00000004) == None
		SpanksToHeal = Menu.SpanksHealed
		HealSpanks(1, true)
		UpdateBalmEffect()
		Utility.Wait(0.5)
		SendGetWetEvent(PlayerRef, 100.0)
		sslBaseVoice voice = SexLab.PickVoice(PlayerRef)
		voice.Moan(PlayerRef, 10, False)
	Else
		Debug.Notification("I need to remove my clothes before I can apply balm")
		PlayerRef.AddItem(_STA_SkinBalm01, 1, abSilent = true)
	EndIf
EndFunction

Function SendGetWetEvent(Actor akTarget, Float Amount)
    Int GetWet = ModEvent.Create("WFR_MakeWetExternal")
    If (GetWet)
        ModEvent.PushForm(GetWet, PlayerRef)
        ModEvent.PushFloat(GetWet, Amount)
        ModEvent.Send(GetWet)
    EndIf
EndFunction

Function UpdateBalmEffect()
	_STA_SkinBalmVisibleSpell.SetNthEffectMagnitude(0, SpanksToHeal)
	_STA_SkinBalmVisibleSpell.Cast(PlayerRef, PlayerRef)
EndFunction

Function HealSpanks(Int NumOfHours, Bool ForceUpdate = false)
	If SpanksToHeal > 0
		Int NumOfHoursHealing
		If !ForceUpdate ; First application of balm is a freebie
			NumOfHoursHealing = Math.Ceiling(SpanksToHeal / Menu.SpanksHealedDecay)
			If NumOfHours < NumOfHoursHealing
				NumOfHoursHealing = NumOfHours
				SpanksToHeal -= (NumOfHours * Menu.SpanksHealedDecay)
			Else
				SpanksToHeal = 0.0
			EndIf
		Else
			NumOfHoursHealing = 1
		EndIf
		
		Int SpankTemp
		SpankTemp = AssSpankCounter[SpankCounterLimit - 1] - Utility.RandomInt(Math.Floor(SpanksToHeal), Math.Ceiling(SpanksToHeal))
		If SpankTemp < 0
			SpankTemp = 0
		EndIf
		AssSpankCounter[SpankCounterLimit - 1] = SpankTemp
		
		SpankTemp = TitsSpankCounter[SpankCounterLimit - 1] - Utility.RandomInt(Math.Floor(SpanksToHeal), Math.Ceiling(SpanksToHeal))
		If SpankTemp < 0
			SpankTemp = 0
		EndIf
		TitsSpankCounter[SpankCounterLimit - 1] = SpankTemp
		
		If !ForceUpdate ; First application of balm does not affect old spanks
			DecArrayAll(AssSpankCounter, NumOfHoursHealing)
			DecArrayAll(TitsSpankCounter, NumOfHoursHealing)
			UpdateBalmEffect()
		EndIf

		If ForceUpdate ; Normally, DoGameTimeUpdate() will handle updating the overlays. Only used when balm first applied
			IntensityAss = GetOverlayIntensity(AssSpankCounter)
			UpdateAlpha(PlayerRef, IntensityAss, "\\SL Survival\\spanky\\spank_ass_light.dds", "Body")
			IntensityTits = GetOverlayIntensity(TitsSpankCounter)
			UpdateAlpha(PlayerRef, IntensityTits, "\\SL Survival\\spanky\\spank_breasts_light.dds", "Body")
			SexDialog.ApplyPainEffect()
		EndIf
	EndIf
EndFunction

Function DecArrayAll(Int[] ArraySelect, Int NumOfHours);, Int DecAmountLower, Int DecAmountUpper)
	Int i = SpankCounterLimit - 1 ; Current hour already modified in HealSpanks (start at index -2)
	While i > 0
		i -= 1
		Int j = NumOfHours
		While j > 0 && ArraySelect[i] > 0 ; This is a lot of looping for something so simples
			j -= 1
			If Menu.OldSpankHealChance > Utility.RandomFloat(0.0, 100.0)
				ArraySelect[i] = ArraySelect[i] - 1
				;Debug.Trace("_STA_: Healing old spank")
			EndIf
		EndWhile
	EndWhile
EndFunction

Function ShiftIntArrayLeft(Int[] ArraySelect, Int ArrayLength, Int NumOfHours)

	Int CurrentSpanks = ArraySelect[ArrayLength - 1]
	
	; Shift array left by NumOfHours
	Int i = 0
	While i < (ArrayLength - 1) - NumOfHours
		ArraySelect[i] = ArraySelect[i+NumOfHours]
		i += 1
	EndWhile
	
	; Save Current spanks
	If i < ArrayLength
		ArraySelect[i] = CurrentSpanks
		i += 1
	EndIf
	
	; Zero the rest of the array
	While i <= (ArrayLength - 1)
		ArraySelect[i] = 0
		i += 1
	EndWhile
EndFunction

Function ShiftFloatArrayLeft(Float[] ArraySelect, Int ArrayLength, Int NumOfHours, Float Intensity, String WhichArray)

	; Shift array left by NumOfHours
	Int i = 0
	While i <= (ArrayLength - 1) - NumOfHours
		ArraySelect[i] = ArraySelect[i+NumOfHours]
		i += 1
	EndWhile
	
	; Save last intensity value
	If  i <= (ArrayLength - 1)
		Debug.Trace("_STA_: SETTING " + WhichArray + " [" + i + "] to " + Intensity)
		ArraySelect[i] = Intensity 
		i += 1
	EndIf
	
	; Zero the rest of the array
	While i <= (ArrayLength - 1)
		ArraySelect[i] = 0
		i += 1
	EndWhile
EndFunction

Float Function AddFloatArray(Float[] ArraySelect, Int ArrayLength)
	;Debug.Trace("_STA_: Add Float Array BEGIN =========================================")
	Int i = 0
	Float Sum = 0.0
	While i <= ArrayLength
		;Debug.Trace("_STA_: ArraySelect[" + i + "]: " + ArraySelect[i] + ". Sum: " + Sum)
		Sum += ArraySelect[i]
		i += 1
	EndWhile
	;Debug.Trace("_STA_: Add Float Array END =========================================")
	Return Sum
EndFunction

Float Function AddIntArray(Int[] ArraySelect, Int ArrayLength, Int CountTo = 0)
	;Debug.Trace("_STA_: Add Int Array BEGIN =========================================")
	Int Sum = 0
	Int i = ArrayLength
	While i > CountTo
		i -= 1
		;Debug.Trace("_STA_: ArraySelect[" + i + "]: " + ArraySelect[i] + ". Sum: " + Sum)
		Sum += ArraySelect[i]
	EndWhile
	;Debug.Trace("_STA_: Add Int Array END =========================================")
	;Debug.Messagebox("Sum: " + Sum + "ArrayLength: " + ArrayLength + "\nCountTo: " + CountTo + "\n\nArraySelect: " + ArraySelect)
	Return Sum
EndFunction

Function ResetMasochism()
	PlayerMasochism = 0.0
	ZeroFloatArray(MasochistHistory)
	AdjustMasochismAttitude(Utility.GetCurrentGameTime())
EndFunction

Function ResetTitsAndAssOverlays()
	IntensityAss = 0.0
	IntensityTits = 0.0
	;ZeroFloatArray(IntensityHistoryAss)
	;ZeroFloatArray(IntensityHistoryTits)
	ZeroIntArray(AssSpankCounter)
	ZeroIntArray(TitsSpankCounter)
	PlayerLoadsGame()
EndFunction

Function ZeroFloatArray(Float[] ArraySelect)
	Int i = ArraySelect.Length
	While i > 0
		i -= 1
		ArraySelect[i] = 0.0
	EndWhile
EndFunction

Function ZeroIntArray(Int[] ArraySelect)
	Int i = ArraySelect.Length
	While i > 0
		i -= 1
		ArraySelect[i] = 0
	EndWhile
EndFunction

Function SetupDeviousSlots()
	DeviousSlots[0] = 30 ; Head (Hood)
	DeviousSlots[1] = 32 ; Body
	DeviousSlots[2] = 33 ; Gloves
	DeviousSlots[3] = 37 ; Boots
	DeviousSlots[4] = 44 ; Gag
	DeviousSlots[5] = 45 ; Collar
	DeviousSlots[6] = 46 ; Armbinder
	DeviousSlots[7] = 48 ; Anal Plug
	DeviousSlots[8] = 49 ; Chastity Belt
	DeviousSlots[9] = 50 ; Vaginal Piercing
	DeviousSlots[10] = 51 ; Nipple Piercings
	DeviousSlots[11] = 53 ; Leg Cuffs
	DeviousSlots[12] = 55 ; Blindfold
	DeviousSlots[13] = 56 ; Chastity Bra
	DeviousSlots[14] = 57 ; Vaginal Plug
	DeviousSlots[15] = 58 ; Harness/Corset
	DeviousSlots[16] = 59 ; Arm Cuffs
EndFunction

Int Function GetDeviousMasochismFactor()
	If Game.GetModByName("Devious Devices - Assets.esm") != 255 ; Needs integration
		_STA_EquippedDdsList.Revert()
		Keyword zad_Lockable = Game.GetFormFromFile(0x003894, "Devious Devices - Assets.esm") as Keyword
		Form ArmorTemp
		Int i = DeviousSlots.Length
		While i > 0
			i -= 1
			ArmorTemp = PlayerRef.GetWornForm(Armor.GetMaskForSlot(DeviousSlots[i]))
			;Debug.Trace("_STA_: DeviousSlots[" + i + "] = " + DeviousSlots[i] + " = " + ArmorTemp)
			If ArmorTemp != None
				If ArmorTemp.HasKeyword(zad_Lockable)
					_STA_EquippedDdsList.AddForm(ArmorTemp) ; Duplicate forms won't be added - Dds that occupy more than one slot
				EndIf
			EndIf
		EndWhile
		Return _STA_EquippedDdsList.GetSize()
	EndIf
EndFunction

Function IncRapeCount(Int Amount)
	RapeCount += Amount
EndFunction

Function PlayerSpanksNpc(Actor akTarget)
	;Debug.Messagebox("Spank: " + akTarget)
	Debug.SendAnimationEvent(PlayerRef, "IdleTake")
	Utility.Wait(0.05)
	Debug.SendAnimationEvent(akTarget, "staggerStart")
	Utility.Wait(0.05)
	If akTarget.GetLeveledActorBase().GetSex() == 1
		SlapSound(akTarget)
	Else
		Int SlapHeavy = _STA_SlapHeavy.Play(akTarget)
		Sound.SetInstanceVolume(SlapHeavy, SlapHeavyVolume) 
	EndIf
	;SexDialog.DoNpcDialogOut(_STA_SpankedNpcResponse00, akTarget)
	akTarget.Say(_STA_SpankedNpcResponse00)
	If StorageUtil.GetIntValue(akTarget, "_STA_SpankedNpcIndex", missing = -1) == -1
		(_STA_SpankedNpcAliasesQuest.GetNthAlias(SpankedNpcIndex) as ReferenceAlias).ForceRefTo(akTarget)
		akTarget.EvaluatePackage()
		StorageUtil.SetIntValue(akTarget, "_STA_SpankedNpcIndex", SpankedNpcIndex)
		SpankedNpcIndex += 1
		If SpankedNpcIndex > _STA_SpankedNpcAliasesQuest.GetNumAliases()
			SpankedNpcIndex = 0
		EndIf
	EndIf
	_STA_SpankedNpcSpell.Cast(akTarget, akTarget)
EndFunction

Function PlayerSpankedNpcEnd(Actor akTarget)
	StorageUtil.UnsetIntValue(akTarget, "_STA_SpankedNpcIndex")
	;Debug.Messagebox("End: " + akTarget)
	ReferenceAlias AliasSelect
	Int i = _STA_SpankedNpcAliasesQuest.GetNumAliases()
	While i > 0
		i -= 1
		AliasSelect = _STA_SpankedNpcAliasesQuest.GetNthAlias(i) as ReferenceAlias
		If AliasSelect.GetReference() as Actor == akTarget
			AliasSelect.Clear()
			akTarget.EvaluatePackage()
		EndIf
	EndWhile
EndFunction

Function SendRandomRunUpAndSpankCompleteEvent()
	SendModEvent("_STA_RandomRunUpAndSpankComplete")
EndFunction

Function SpankAssBasic()
    SlapSound(PlayerRef)
    IncSpankCounter(AssSpankCounter)
    SpankModStamina(True)
    IntensityAss = GetOverlayIntensity(AssSpankCounter)
    UpdateAlpha(PlayerRef, IntensityAss, "\\SL Survival\\spanky\\spank_ass_light.dds", "Body")
    ;SexDialog.ApplyPainEffect()
    ModPlayerArousal()
EndFunction

Function SpankTitsBasic()
    SlapSound(PlayerRef)
    IncSpankCounter(TitsSpankCounter)
    SpankModStamina(True)
    IntensityTits = GetOverlayIntensity(TitsSpankCounter)
    UpdateAlpha(PlayerRef, IntensityTits, "\\SL Survival\\spanky\\spank_breasts_light.dds", "Body")
    ;SexDialog.ApplyPainEffect()
    ModPlayerArousal()
    SexDialog.BeginBoobLeak()
EndFunction

Function SpankSoundPlayer()
    SlapSound(PlayerRef)
EndFunction

Function FixupSpanks(Int assSpanks, Int titSpanks)
    While assSpanks > 0
        assSpanks -= 1
        IncSpankCounter(AssSpankCounter)
    EndWhile
    While titSpanks > 0
        titSpanks -= 1
        IncSpankCounter(TitsSpankCounter)
    EndWhile
    SpankModStamina(False) ; Treat like out-of-sex
    IntensityAss = GetOverlayIntensity(AssSpankCounter)
    IntensityTits = GetOverlayIntensity(TitsSpankCounter)
    UpdateAlpha(PlayerRef, IntensityAss, "\\SL Survival\\spanky\\spank_ass_light.dds", "Body")
    UpdateAlpha(PlayerRef, IntensityTits, "\\SL Survival\\spanky\\spank_breasts_light.dds", "Body")
    SexDialog.ApplyPainEffect()
    ModPlayerArousal()
EndFunction

Int Function GetMasochismStage()
    ; PlayerMasochism increases as masochism grows, each MasochismStepSize it goes up a step
    ; Hates    -2
    ; Dislikes -1
    ; Unused    0
    ; Likes     1
    ; Loves     2
    Return GetMasochismAttitude(PlayerMasochism)
EndFunction

Float Function GetStaVersion()
    Return SexDialog.StaVersion
EndFunction

Bool Function CheckDfPatch()
    Return True
EndFunction
