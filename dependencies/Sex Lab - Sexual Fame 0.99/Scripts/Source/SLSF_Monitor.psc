Scriptname SLSF_Monitor extends ReferenceAlias

SLSF_Configuration Property Config Auto
SLSF_Utility Property SLSFUtility Auto
SLSF_FameMaintenance Property FameMain Auto
SLSF_FunctionAccess Property Access Auto
SexLabFramework property SexLab auto

;0 Empty, 1 Tats/slavetats, 2 Dirt, 3 Cum, 4 Empty, 5 Device, 6 Empty, 7 Clothes, 8 Empty, 9 OtherDevices, 10 Empty
Faction[] Property EquipSurfaceFeet Auto
Faction[] Property EquipSurfaceHand Auto
Faction[] Property EquipSurfaceHead Auto
Faction[] Property EquipSurfaceBody Auto
Faction Property EquipSurfaceOther Auto
Faction Property SlAnimation Auto

Spell Property EquipStatus Auto
Actor Property PlayerRef Auto
Keyword Property CumOral Auto  
Keyword Property CumAnal Auto
Keyword Property CumVaginal Auto
Keyword Property CumOralStacked Auto  
Keyword Property CumAnalStacked Auto
Keyword Property CumVaginalStacked Auto

;SL Aroused
FormList Property SlaExcluded Auto
Faction Property SlANaked Auto

Event OnInit()
	Utility.Wait(2.0)
	If !PlayerRef.IsChild()
		Debug.Notification("$SLSFSTARTINGMESSAGE")
		PlayerRef.SetFactionRank(SLSFUtility.Roletype, 21)
		InitializeSurfaces()
		Maintenance()
	EndIf
EndEvent

Event OnPlayerLoadGame()
	If !PlayerRef.IsChild()
		SLSFUtility.CheckPapyrusLocationsConsistence()
		Maintenance()
	EndIf
EndEvent

Event OnLocationChange(Location akOldLoc, Location Actual) ;OnLocationChange doesn't fire if flying on a dragon, Until it land.
	SLSFUtility.CallSyncFameLocation()
EndEvent

Function Maintenance()
	Config.SystemInPause = True
	Int CheckPresence = Game.GetModByName("SexLab - Sexual Fame [SLSF].esm")
	If CheckPresence != 255
		SecureDisabler()
		SLSFUtility.CheckExtensionPresence()
		MaintenanceOfRegisteredKey()
		SLSFUtility.UpdateToLastest()
		SLSFUtility.CallSyncFameLocation()
		RegisterForEvents()
		FameMain.LoadLocationOnPapyrus()
	;Else
		;Hi! I'm an empty Uninstall Procedure, Do you want to be my friend?
	EndIf
EndFunction

Function SecureDisabler()
	Config.SystemInPause = False
	Config.ShameAnimSuspended = False
	Config.SceneInUse.SetValue(0.0)
	Config.AllowCommentProbability = Config.CommentProbabilityRepository
	
	Int FameNum = Config.FameListPc.Length
	Config.PeriodicIncValue = Utility.CreateIntArray(FameNum)
	Config.PeriodicIncSender = Utility.CreateStringArray(FameNum)
EndFunction

Event OnKeyUp(Int KeyCode, Float HoldTime)
	If KeyCode == Config.KeyForConfigMenu && !Config.KeyCallInPause && !Utility.IsInMenuMode() && !PlayerRef.IsChild()
		SLSFUtility.CallConfigMenu()
	EndIf
EndEvent

Function MaintenanceOfRegisteredKey()
	UnregisterForAllKeys()
	RegisterForKey(Config.KeyForConfigMenu)
EndFunction

Function RegisterForEvents()
	Access.MaintenanceForEvents()
	Self.UnregisterForAllModEvents()
	Utility.Wait(1.0)
	RegisterForModEvent("AnimationEnd", "IncFameBySlAction")
EndFunction

Event IncFameBySlAction(String eventName, String argString, Float argNum, Form sender)
	FameMain.FameSlIncrease(eventName, argString, argNum, sender)
	
	Utility.Wait(4.0)
	CheckSurFaces3()
	ApplyMgef()
EndEvent

Function ApplyMgef()
	If !PlayerRef.IsChild()
		Config.PlayerEquipReady = False
		PlayerRef.RemoveSpell(EquipStatus)
		Utility.Wait(0.1)
		PlayerRef.AddSpell(EquipStatus, False)
		Config.PlayerEquipReady = True
	EndIf
EndFunction

Function Surface1_2And3()
	CheckSurFaces1()
	CheckSurfaces2()
	CheckSurFaces3()
	ApplyMgef()
EndFunction

Function CheckSurfaces1()
	;------------Surface 1 (slavetats)
	If Config.SlaveTatsLoaded
			;Feet
		PlayerRef.SetFactionRank(EquipSurfaceFeet[1], SLSFUtility.CountSlaveTatsOnArea(PlayerRef, "Feet") as Int)
	
			;Hand
		PlayerRef.SetFactionRank(EquipSurfaceHand[1], SLSFUtility.CountSlaveTatsOnArea(PlayerRef, "Hands") as Int)

			;Head
		PlayerRef.SetFactionRank(EquipSurfaceHead[1], SLSFUtility.CountSlaveTatsOnArea(PlayerRef, "Face") as Int)
	
			;Body
		PlayerRef.SetFactionRank(EquipSurfaceBody[1], SLSFUtility.CountSlaveTatsOnArea(PlayerRef, "Body") as Int)
	Else
		PlayerRef.SetFactionRank(EquipSurfaceFeet[1], 0)
		PlayerRef.SetFactionRank(EquipSurfaceHand[1], 0)
		PlayerRef.SetFactionRank(EquipSurfaceHead[1], 0)
		PlayerRef.SetFactionRank(EquipSurfaceBody[1], 0)
	EndIf
EndFunction

Function CheckSurfaces2()
	;------------Surface 2 (Dirt)
		;Dirt Only use the Body Location
		
	Bool FoundLightDirt		;Hiddable
	Bool FoundDirt			;Not Hiddable

		;Bathing In Skyrim
	If Config.BathingInSkyrimLoaded
		;If !FoundLightDirt
			FoundLightDirt = PlayerRef.HasMagicEffect(Config.BathingInSkyrimDirt[0])	;'Light Dirt'
		;EndIf
		
		;If !FoundDirt
			FoundDirt = PlayerRef.HasMagicEffect(Config.BathingInSkyrimDirt[1])			;'Dirt'
		;EndIf
	Else
			;SlaveTats
		If Config.SlaveTatsLoaded
			Int a = SLSFUtility.GetSlaveTatsDirt(PlayerRef)
			If a == 1
				FoundLightDirt = True
			ElseIf a == 2
				FoundDirt = True
			EndIf
		EndIf
	EndIf
	
	
	If FoundDirt
		PlayerRef.SetFactionRank(EquipSurfaceBody[2], 2)
	ElseIf FoundLightDirt
		PlayerRef.SetFactionRank(EquipSurfaceBody[2], 1)
	Else
		PlayerRef.SetFactionRank(EquipSurfaceBody[2], 0)
	EndIf
EndFunction

Function CheckSurfaces3()
	;------------Surface 3 (Cum)
	Utility.Wait(2.5)
	Int Value
		;Feet, Hand: None
		;Head
	Value = (PlayerRef.HasMagicEffectWithKeyword(CumOral) as Int + PlayerRef.HasMagicEffectWithKeyword(CumOralStacked) as Int)
	If Config.CumAlwaysHiddable && Value > 1
		Value = 1
	Endif
	
	PlayerRef.SetFactionRank(EquipSurfaceHead[3], Value)
	
		;Body
	Value = (PlayerRef.HasMagicEffectWithKeyword(CumAnal) || PlayerRef.HasMagicEffectWithKeyword(CumVaginal)) as Int
	
	If !Config.CumAlwaysHiddable && (PlayerRef.HasMagicEffectWithKeyword(CumAnalStacked) || PlayerRef.HasMagicEffectWithKeyword(CumVaginalStacked))
		Value = 2
	EndIf
	
	PlayerRef.SetFactionRank(EquipSurfaceBody[3], Value)
EndFunction

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	If akBaseObject != None
		If akBaseObject.GetType() == 26
			RegisterForSingleUpdate(Config.BaseUpdateInterval)
		ElseIf akBaseObject.GetType() == 46
			If !Config.SkoomaWhoreLoaded
				If akBaseObject as Potion
					If Config.Skooma.Find(akBaseObject as Potion) >= 0
						Int[] Increases = Utility.CreateIntArray(Config.FameListPc.Length)
						Increases[16] = 100
						FameMain.FameIncreaseInternal(Increases)
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
EndEvent

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	If akBaseObject != None
		If akBaseObject.GetType() == 26
			RegisterForSingleUpdate(Config.BaseUpdateInterval)
		EndIf
	EndIf
EndEvent

Event OnUpdate()
	If !PlayerRef.IsInFaction(SlAnimation)
		CheckSurFaces5_7And9()
	EndIf
EndEvent

Function CheckSurFaces5_7And9_From_Event()
	If !PlayerRef.IsInFaction(SlAnimation)
		CheckSurFaces5_7And9()
	EndIf
EndFunction

Function CheckSurFaces5_7And9()
	Bool Found
	;------------Surface 5 (Device)
		;Feet
	;Zaz Resources Doesn't contain any Foot device
	;If PlayerRef.WornHasKeyword(Config.ZazFoot[0])
	;	Found = True
	;Endif
	
	; DD Devices Disabled, All DD Boots are considered on Surfaces 9 (Other Devices)
	;If Config.DeviousDevicesIntegrationLoaded && !Found
	;	If PlayerRef.WornHasKeyword(Config.DDFootDevice[0])
	;		Found = True
	;	Endif
	;EndIf
	
	PlayerRef.SetFactionRank(EquipSurfaceFeet[5], Found as Int)
	Found = False
		
		;Hand
	;Zaz Resources Doesn't contain any Hand device
	;If PlayerRef.WornHasKeyword(Config.ZazHand[0])
	;	Found = True
	;Endif
	
	; DD Devices Disabled, All DD Gloves are considered on Surfaces 9 (Other Devices)
	;If Config.DeviousDevicesIntegrationLoaded && !Found
	;	If PlayerRef.WornHasKeyword(Config.DDHandDevice[0])
	;		Found = True
	;	Endif
	;EndIf
	
	PlayerRef.SetFactionRank(EquipSurfaceHand[5], Found as Int)
	Found = False
	
		;Head
	If PlayerRef.WornHasKeyword(Config.ZazHead[0]) || PlayerRef.WornHasKeyword(Config.ZazHead[1])
		Found = True
	Endif
	
	;Note: DDHeadDevice[2] Uses the ZazHead every times, Pointless to repeat 
	If Config.DeviousDevicesIntegrationLoaded && !Found
		If PlayerRef.WornHasKeyword(Config.DDHeadDevice[0])	|| PlayerRef.WornHasKeyword(Config.DDHeadDevice[1])
			Found = True
		Endif
	EndIf
	
	PlayerRef.SetFactionRank(EquipSurfaceHead[5], Found as Int)
	Found = False
	
		;Body
	If PlayerRef.WornHasKeyword(Config.ZazBody[0]) || PlayerRef.WornHasKeyword(Config.ZazBody[1]) || PlayerRef.WornHasKeyword(Config.ZazBody[2]) || PlayerRef.WornHasKeyword(Config.ZazBody[3]) || PlayerRef.WornHasKeyword(Config.ZazBody[4])
		Found = True
	Endif
	
	;Note: DDBodyDevice[6,7,8] Uses the ZazBody every times, Pointless to repeat 
	If Config.DeviousDevicesIntegrationLoaded && !Found
		If PlayerRef.WornHasKeyword(Config.DDBodyDevice[0]) || PlayerRef.WornHasKeyword(Config.DDBodyDevice[1]) || PlayerRef.WornHasKeyword(Config.DDBodyDevice[2]) || PlayerRef.WornHasKeyword(Config.DDBodyDevice[3]) || PlayerRef.WornHasKeyword(Config.DDBodyDevice[4]) || PlayerRef.WornHasKeyword(Config.DDBodyDevice[5]) ; || PlayerRef.WornHasKeyword(Config.DDBodyDevice[6]) || PlayerRef.WornHasKeyword(Config.DDBodyDevice[7]) || PlayerRef.WornHasKeyword(Config.DDBodyDevice[8])
			Found = True
		Endif
	EndIf
	
	PlayerRef.SetFactionRank(EquipSurfaceBody[5], Found as Int)
	Found = False
	
	;------------Surface 7 (Clothing)
	Int SlotsChecked
	;SlotsChecked += 0x00100000
	;SlotsChecked += 0x00200000 ;ignore reserved slots
	;SlotsChecked += 0x80000000
	
	PlayerRef.SetFactionRank(EquipSurfaceFeet[7], 0)
	PlayerRef.SetFactionRank(EquipSurfaceHand[7], 0)
	PlayerRef.SetFactionRank(EquipSurfaceHead[7], 0)
	PlayerRef.SetFactionRank(EquipSurfaceBody[7], 0)
	
	Int ThisSlot = 0x01
	While (ThisSlot < 0x80000000)
		If (Math.LogicalAnd(SlotsChecked, ThisSlot) != ThisSlot) ;only check slots we haven't found anything equipped on already
			If PlayerRef.GetWornForm(ThisSlot)
				Form Equipped = PlayerRef.GetWornForm(ThisSlot)
				If Equipped != None
					
					;------------Surface 7 (Clothing)
						;Feet
					If Equipped.HasKeyword(Config.ClothingKeyword[0]) || Equipped.HasKeyword(Config.ClothingKeyword[1])
						Found = !SLSFUtility.CheckIfExcluded(Config.ExcludedFeet, Equipped)
						PlayerRef.SetFactionRank(EquipSurfaceFeet[7], Found as Int)
					EndIf
					;Found = False
					
						;Hand
					If Equipped.HasKeyword(Config.ClothingKeyword[2]) || Equipped.HasKeyword(Config.ClothingKeyword[3])
						Found = !SLSFUtility.CheckIfExcluded(Config.ExcludedHand, Equipped)
						PlayerRef.SetFactionRank(EquipSurfaceHand[7], Found as Int)
					EndIf
					;Found = False
					
						;Head
					If Equipped.HasKeyword(Config.ClothingKeyword[4]) || Equipped.HasKeyword(Config.ClothingKeyword[5])
						Found = !SLSFUtility.CheckIfExcluded(Config.ExcludedHead, Equipped)
						PlayerRef.SetFactionRank(EquipSurfaceHead[7], Found as Int)
					EndIf
					;Found = False
					
						;Body
					If Config.DeviousDevicesIntegrationLoaded
						If Equipped.HasKeyword(Config.DDSuit)
							Found = !SLSFUtility.CheckIfExcluded(Config.ExcludedBody, Equipped)
							PlayerRef.SetFactionRank(EquipSurfaceBody[7], Found as Int)
						Else
							Found = False
						EndIf
					EndIf
					
					If (Equipped.HasKeyword(Config.ClothingKeyword[6]) || Equipped.HasKeyword(Config.ClothingKeyword[7])) && !Found
						Found = !SLSFUtility.CheckIfExcluded(Config.ExcludedBody, Equipped)
						PlayerRef.SetFactionRank(EquipSurfaceBody[7], Found as Int)
					EndIf
					;Found = False
				EndIf
			EndIf
		EndIf
		ThisSlot *= 2
	EndWhile
	
	Found = False
	
	;------------Surface 9 (Other Devices)
	If PlayerRef.WornHasKeyword(Config.ZazOther[0]) || PlayerRef.WornHasKeyword(Config.ZazOther[1])
		Found = True
	Endif
	
	If Config.DeviousDevicesIntegrationLoaded && !Found
		If PlayerRef.WornHasKeyword(Config.DDOtherDevice[0]) || PlayerRef.WornHasKeyword(Config.DDOtherDevice[1])
			Found = True
		Endif
	EndIf

	PlayerRef.SetFactionRank(EquipSurfaceOther, Found as Int)
	Found = False
	ApplyMgef()
	;SLSFUtility.ApplyStartingShame()	 ;Moved in The naked Effect
EndFunction

Function InitializeSurfaces()
	Int a = EquipSurfaceFeet.Length
	While a > 0
		a -= 1
		PlayerRef.SetFactionRank(EquipSurfaceFeet[a], 0)
		PlayerRef.SetFactionRank(EquipSurfaceHand[a], 0)
		PlayerRef.SetFactionRank(EquipSurfaceHead[a], 0)
		PlayerRef.SetFactionRank(EquipSurfaceBody[a], 0)
	EndWhile
EndFunction
