Scriptname sr_OrcPickup extends sr_FTUQuestBase Hidden conditional

int property pref auto hidden ; 0 = either, 1 = vaginal, 2 = anal

ReferenceAlias Property chief auto
GlobalVariable Property sr_OPUPercentage Auto
Scene Property forceGreetScene Auto
Quest Property tribesmanFinder Auto
Scene Property shareScene Auto 

ObjectReference Property pump auto

bool interruptSceneDone = false
bool stripped = false

SexLabFramework sexlab
Form[] chiefClothes
Form[] playerClothes

Armor Property orcPlugs auto
Armor Property orcPlugsRendered Auto

Faction Property OrcFriendFaction auto
bool factionIsTmp = false

bool property forcedForceGreet = false auto conditional hidden

bool property keepArmbinder = false auto hidden

sslBaseAnimation currentAnim = none 

; ------------------
;  Consensual scene
; ------------------

Function StartSceneProfessional()
	sexlab = SexLabUtil.GetAPI()
	
	Actor[] actors = new Actor[2]
	actors[0] = inflater.player
	actors[1] = chief.GetActorReference()
	
	String tags = "anal,vaginal"
	If pref > 0
		int chance = Utility.RandomInt(0,99)
		int div
		If pref == 1
			div = 20
		ElseIf pref == 2
			div = 80
		EndIf
		
		if chance < div
			tags = "anal"
		Else
			tags = "vaginal"
		EndIf		
	EndIf
		
	bool victim = false
	If Utility.RandomInt(0,99) < 13
		victim = true
	EndIf
	
	sslBaseAnimation[] anims = sexlab.GetAnimationsByTags(2, tags, "oral,subsub,pillory,cuddle,gay", RequireAll = false)
	
	if !stripped
		playerClothes = SexLab.StripActor(actors[0])
		chiefClothes = SexLab.StripActor(actors[1])
		stripped = true
	EndIf
	
	RegisterForModEvent("HookAnimationEnd_OrcChief", "AnimationEnd")
	sslThreadModel thread = SexLab.NewThread()
	thread.AddActor(actors[0], victim)
	thread.AddActor(actors[1])
	thread.DisableUndressAnimation(actors[0], true)
	thread.DisableUndressAnimation(actors[1], true)
	thread.SetHook("OrcChief")
	thread.SetAnimations(anims)
	thread.DisableLeadIn()
	
	sslThreadController controller = thread.StartThread()
	if controller == none	
		inflater.error("Failed to start orc chieftain scene.")
		Debug.Notification("SexLab failed to start orc chieftain scene.")
	endIf
EndFunction

Function AnimationEnd(int threadID, bool hasPlayer)
	UnregisterForModEvent("HookAnimationEnd_OrcChief")
	while(inflater.player.IsInFaction(inflater.inflaterAnimatingFaction) || inflater.player.IsInFaction(inflater.slAnimatingFaction) )
		Utility.Wait(1.0)
	endWhile
	sr_OPUPercentage.value = inflater.GetInflationPercentage(inflater.player)
	UpdateCurrentInstanceGlobal(sr_OPUPercentage)
	SetObjectiveDisplayed(20, false)
	SetObjectiveDisplayed(20)
	
	inflater.log("Percentage: " + sr_OPUPercentage.value)
	If sr_OPUPercentage.value < 100
		If sr_OPUPercentage.value >= 60 && !interruptSceneDone
			interruptSceneDone = true
			SetStage(22)
			forceGreetScene.Start()
		Else
			StartSceneProfessional()
		EndIf
	Else
		SexLab.UnstripActor(chief.GetActorReference(), chiefClothes)
		SexLab.UnstripActor(inflater.player, playerClothes)
		SetStage(25)
		forceGreetScene.Start()
	EndIf
EndFunction

; --------------
;  Forced scene
; --------------

Function FactionCheck()
	if(!inflater.player.IsInFaction(OrcFriendFaction))
		inflater.player.AddToFaction(OrcFriendFaction)
		inflater.player.SetFactionRank(OrcFriendFaction, 1)
		factionIsTmp = true
	EndIf
EndFunction

Function RemoveFaction()
	If factionIsTmp
		inflater.player.RemoveFromFaction(OrcFriendFaction)
	EndIf
EndFunction

Function StartSceneForced()
	forcedForceGreet = false
	sexlab = SexLabUtil.GetAPI()
	zbfSexLab zbfsl = zbfUtil.GetSexLab()
	
	Actor[] actors = new Actor[2]
	actors[0] = inflater.player
	actors[1] = chief.GetActorReference()
	
	sslBaseAnimation[] anims = new sslBaseAnimation[1]
	anims[0] = zbfsl.NewAnimation("FTU")
	
;	String tags = "armbinder"
	If Utility.RandomInt(0,99) < 75 ; 75% of actually filling
		If ( Utility.RandomInt(0,1) == 0 && inflater.GetAnalCum(inflater.player) < (inflater.config.maxInflation - 1) ) || inflater.GetVaginalCum(inflater.player) >= (inflater.config.maxInflation - 1) 
;			tags += ",anal"
			zbfsl.DefineDoggy01(anims[0], "FTUArmbinderDoggy", "ZapArmbDoggy01", "AggrDoggyStyle")
		Else
			zbfsl.DefineMissionary01(anims[0], "FTUArmbinderMissionary", "ZapArmbMissionary01", "AggrMissionary")
;			tags += ",vaginal"
		EndIf
	Else ; 25% chance of chief just having fun
		If Utility.RandomInt(0,2) == 0 ; 33% for boobjob
			zbfsl.DefineBoobJob01(anims[0], "FTUArmbinderBoobjob", "ZapArmbBoobJob01", "Arrok_Boobjob")
;			tags += ",boobjob"
		Else ; 67% chance for oral
			zbfsl.DefineSkullFuck01(anims[0], "FTUArmbinderSkullfuck", "ZapArmbSkullFuck01", "AP_SkullFuck")
;			tags += ",oral"
		EndIf
	EndIf
	anims[0].AddTag("DomSub")
	anims[0].AddTag("Armbinder")
	anims[0].AddTag("NoSwap")
	anims[0].save(-1)
	
	currentAnim = anims[0]
	
	
;	sslBaseAnimation[] anims = sexlab.GetAnimationsByTags(2, tags, "subsub,pillory,cuddle,gay,lesbian", RequireAll = true)
;	if anims == none || anims.length < 1 || anims[0] == none
;		anims = sexlab.GetAnimationsByTags(2, "oral,vaginal,anal", "subsub,pillory,cuddle,gay,lesbian", RequireAll = false)
;	endIf
	
	if !stripped
		playerClothes = SexLab.StripActor(actors[0], DoAnimate = false)
		stripped = true
	EndIf
	
	RegisterForModEvent("HookAnimationEnd_OrcChief", "AnimationEndForced")
	sslThreadModel thread = SexLab.NewThread()
	thread.AddActor(actors[0], true)
	thread.AddActor(actors[1])
	thread.DisableUndressAnimation(actors[0], true)
	thread.DisableUndressAnimation(actors[1], true)
	chiefClothes = SexLab.StripActor(actors[1], DoAnimate = false)
	thread.SetHook("OrcChief")
	thread.SetAnimations(anims)
	thread.DisableBedUse(true)
	thread.DisableLeadIn()
	
	sslThreadController controller = thread.StartThread()
	if controller == none	
		inflater.error("Failed to start orc chieftain scene.")
		Debug.Notification("SexLab failed to start orc chieftain scene.")
	endIf
EndFunction

Function AnimationEndForced(int threadID, bool hasPlayer)
	UnregisterForModEvent("HookAnimationEnd_OrcChief")
	while(inflater.player.IsInFaction(inflater.inflaterAnimatingFaction) || inflater.player.IsInFaction(inflater.slAnimatingFaction) )
		Utility.Wait(1.0)
	endWhile
	
	zbfUtil.GetSexLab().ReleaseAnimation(currentAnim)
	currentAnim = none
	
	SexLab.UnstripActor(chief.GetActorReference(), chiefClothes)
	sr_OPUPercentage.value = inflater.GetInflationPercentage(inflater.player)
	UpdateCurrentInstanceGlobal(sr_OPUPercentage)
	SetObjectiveDisplayed(20, false)
	SetObjectiveDisplayed(20)
	
	inflater.log("Percentage: " + sr_OPUPercentage.value)
	If sr_OPUPercentage.value < 119
		ManipulateBeltAndLeash(true)
		SetStage(51)
		RegisterForSingleUpdateGameTime(Utility.RandomFloat(0.25, 0.75))
	Else
		If !keepArmbinder
			SexLab.UnstripActor(inflater.player, playerClothes)
		EndIf
		SetStage(60)
		forceGreetScene.Start()
		ftu.EquipUniform(belt = true, collar = false, open = false)
	EndIf
EndFunction

Function StartShare(Actor tribesman)
	shareScene.Stop()
	sexlab = SexLabUtil.GetAPI()
	zbfSexLab zbfsl = zbfUtil.GetSexLab()
	
	Actor[] actors = new Actor[2]

	sslBaseAnimation[] anims = new sslBaseAnimation[1]
	anims[0] = zbfsl.NewAnimation("FTU")
	
	If sexlab.GetGender(tribesman) == 1
		zbfsl.DefineLesbian01(anims[0], "FTUArmbinderLesbian", "Arrok_Lesbian", "ZapArmbLesbian01")
		actors[0] = tribesman
		actors[1] = inflater.player
	Else
		If Utility.RandomInt(0,99) < 33
			zbfsl.DefineBoobJob01(anims[0], "FTUArmbinderBoobjob", "ZapArmbBoobJob01", "Arrok_Boobjob")
		Else
			zbfsl.DefineSkullFuck01(anims[0], "FTUArmbinderSkullfuck", "ZapArmbSkullFuck01", "AP_SkullFuck")
		EndIf
		actors[0] = inflater.player
		actors[1] = tribesman
	EndIf

	anims[0].AddTag("DomSub")
	anims[0].AddTag("Armbinder")
	anims[0].AddTag("NoSwap")
	anims[0].save(-1)
	
	currentAnim = anims[0]

	RegisterForModEvent("HookAnimationEnd_OrcTribesman", "AnimationEndShare")
	sslThreadModel thread = SexLab.NewThread()
	If sexlab.GetGender(tribesman) == 1
		thread.AddActor(actors[0])
		thread.AddActor(actors[1], true)
	Else
		thread.AddActor(actors[0], true)
		thread.AddActor(actors[1])
	EndIf 
	thread.DisableUndressAnimation(actors[0], true)
	thread.DisableUndressAnimation(actors[1], true)
	thread.SetHook("OrcTribesman")
	thread.SetAnimations(anims)
	thread.DisableBedUse(true)
	thread.DisableLeadIn()
	
	sslThreadController controller = thread.StartThread()
	if controller == none	
		inflater.error("Failed to start tribesman scene.")
		Debug.Notification("SexLab failed to start tribesman scene.")
	endIf
EndFunction

Event AnimationEndShare(int threadID, bool hasPlayer)
	UnregisterForModEvent("HookAnimationEnd_OrcTribesman")
	while(inflater.player.IsInFaction(inflater.inflaterAnimatingFaction) || inflater.player.IsInFaction(inflater.slAnimatingFaction) )
		Utility.Wait(1.0)
	endWhile
	
	zbfUtil.GetSexLab().ReleaseAnimation(currentAnim)
	currentAnim = none
	
	tribesmanFinder.Stop()

	RegisterForSingleUpdateGameTime(Utility.RandomFloat(0.25, 0.75))
EndEvent

Event OnUpdateGameTime()
	; Time for some more, slave!
	; Belt is removed in the dialogue started here
	if Utility.RandomInt(0,99) < 75
		forcedForceGreet = true
		forceGreetScene.Start()
	Else
		tribesmanFinder.start()
		if(tribesmanFinder.isRunning())
			shareScene.start()
		Else
			forcedForceGreet = true
			inflater.warn("Failed to start tribe scene")
			forceGreetScene.Start()
		EndIf
	EndIf
EndEvent

Armor binder = none
Function ManipulateArmbinder(bool equip)
	if binder == none
		binder = ftu.zad.GetDeviceByTags(ftu.zad.zad_DeviousArmbinder, "black")
	endIf
	ftu.zad.ManipulateGenericDevice(inflater.player, binder, equip, false, true)
EndFunction

Function RemoveGenericArmbinder()
	ftu.zad.ManipulateGenericDeviceByKeyword(inflater.player, ftu.zad.zad_DeviousArmbinder, false, false, true)
EndFunction

Function MakeArmbinderInescapable(bool status)
	inflater.log("MakeArmbinderInescapable: " + status)
	If !status ; too many dots!
		ftu.zad.abq.EnableStruggling()
		ftu.zad.abq.EnableDialogue()
	Else
		ftu.zad.abq.DisableStruggling()
		ftu.zad.abq.DisableDialogue()
	EndIf
EndFunction

Function ManipulateBeltAndLeash(bool equip)
	If !equip ; unequipping, remove belt first
		ftu.ManipulateDevice(inflater.player, ftu.QSTFullBelt, equip, false, true)
	EndIf
	ftu.ManipulateDevice(inflater.player, ftu.zad.plugSoulgemAn, equip, false, true)
	ManipulateDevice(inflater.player, orcPlugs, equip, false, true)
	If equip ; Equipping, equip belt last
		ftu.ManipulateDevice(inflater.player, ftu.QSTFullBelt, equip, false, true)
	EndIf
EndFunction

Function RemoveItems()
	inflater.player.RemoveItem(binder, 1, abSilent = true)
	inflater.player.RemoveItem(ftu.zad.plugSoulgemAn, 1, abSilent = true)
	inflater.player.RemoveItem(orcPlugs, 1, abSilent = true)
EndFunction


; -----------------------
;  Ending transfer scene
; -----------------------

Function DisablePump(bool d = true)
	pump.BlockActivation(d)
EndFunction

; BAAAD Spot to keep these
float plAn
float anTime
Actor courier

Function StartTransfer(Actor c)
	inflater.log("Starting OPU transfer")
	Actor pl = inflater.player
	courier = c
	
	If ftu.playerInPump == 1
		Debug.SendAnimationEvent(pl, "ZaZMOMFreeFurn_06")
	Else
		Debug.SendAnimationEvent(pl, "ZaZMOMBoundFurn_06")
	EndIf
	Debug.SendAnimationEvent(courier, "ZaZMOMFreeFurn_06")
	
	float plVag = inflater.GetVaginalCum(pl)
	plAn = inflater.GetAnalCum(pl)
	float plTot = plVag + plAn
	
	float partVag = plVag / plTot
	float totalTime = 30.0
	float vagTime = totalTime * partVag
	anTime = totalTime * ( 1 - partVag )
	
	ftu.StartMoanLoop(pl)
	ftu.StartMoanLoop(courier)	
	
	String cb = "OPU-VagDone"
	String cbf = "TransferPartTwo"
	int pool = inflater.VAGINAL
	If plVag <= 0.0 || plAn <= 0.0
		cb = "OPU-AnDone"
		cbf = "TransferDone"
		if plVag <= 0.0
			pool = inflater.ANAL
			inflater.log("OPU transfer: only anal")
		Else
			inflater.log("OPU transfer: only vag")
		EndIf
	EndIf
;	inflater.StripActor(courier)
	
	RegisterForModEvent(cb, cbf)
	inflater.QueueActor(pl, false, pool, plVag, vagTime, callback = cb, animate = -1)
	inflater.QueueActor(courier, true, inflater.VAGINAL, (inflater.config.maxInflation - inflater.GetOriginalScale(courier)), (totalTime + 1))
	
	inflater.InflateQueued()
EndFunction

Event TransferPartTwo(Form akActor, float startVag, float startAn)
	UnregisterForModEvent("OPU-VagDone")
	inflater.log("First transfer done")
	RegisterForModEvent("OPU-AnDone", "TransferDone")
	inflater.QueueActor(inflater.player, false, inflater.ANAL, plAn, anTime, callback = "OPU-AnDone", animate = -1)
	inflater.InflateQueued()
EndEvent

Event TransferDone(Form akActor, float startVag, float startAn)
	UnregisterForModEvent("OPU-AnDone")
	inflater.log("Second transfer done")
	
	If ftu.playerInPump == 1
		Debug.SendAnimationEvent(inflater.player, "ZaZMOMFreeFurn_02")
	Else
	   Debug.SendAnimationEvent(inflater.player, "ZaZMOMBoundFurn_02")
	EndIf
	Debug.SendAnimationEvent(courier, "ZaZMOMFreeFurn_02")
	
	ftu.StopMoanLoop(inflater.player)
	ftu.StopMoanLoop(courier)
;	inflater.UnstripActor(courier)
	ftu.EquipUniform(belt = true, collar = false, open = false, courier = courier)
	
	SetStage(110)
EndEvent

Function ManipulateDevice(actor akActor, armor device, bool equipOrUnequip, bool skipEvents = false, bool skipMutex = false)
	If device == None
		return
	EndIf
	Armor deviceRendered
	Keyword deviceKeyword
	if device == orcPlugs
		deviceRendered = orcPlugsRendered
		deviceKeyword = ftu.zad.zad_DeviousPlugVaginal
	Else
		ftu.ManipulateDevice(akActor, device, equipOrUnequip, skipEvents)
		return
	EndIf
	if equipOrUnequip
		ftu.zad.EquipDevice(akActor, device, deviceRendered, deviceKeyword, skipEvents = skipEvents, skipMutex = skipMutex)
	else
		ftu.zad.RemoveDevice(akActor, device, deviceRendered, deviceKeyword, skipEvents = skipEvents, skipMutex = skipMutex)
	EndIf
EndFunction

