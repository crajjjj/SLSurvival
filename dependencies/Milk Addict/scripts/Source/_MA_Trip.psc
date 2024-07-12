Scriptname _MA_Trip extends activemagiceffect  

Event OnInit()
	RegisterForSingleUpdate(MilkMain.TripFrequency)
EndEvent

Event OnUpdate()
	If MilkMain.TripDropChance > 0.0 && Menu.TotalSlots > 0
		Actor CreatureSelect
		
		Location CurrentLocation = PlayerRef.GetCurrentLocation()
		Float LocationMod = Menu.TripStripChanceLocationMod
		If CurrentLocation != None
			If CurrentLocation.HasKeyword(LocTypeDwelling) || CurrentLocation.HasKeyword(LocTypeHabitation)
				LocationMod = 1.0
			EndIf
		EndIf

		; Trip
		if (MilkMain.TripChance * LocationMod) > utility.RandomFloat(0.0, 100.0) && !PlayerRef.HasMagicEffect(_MA_fortifyspeed)
			Int i = 0
			while !PlayerRef.IsRunning()
				Utility.wait(1)
			endwhile
			If Game.IsMovementControlsEnabled() && PlayerRef.GetCurrentScene() == None
				If !Menu.UseAltTripMethod
					_MA_TripSpell.Cast(PlayerRef, PlayerRef)
				Else
					PlayerRef.PushActorAway(PlayerRef, 1.5)
				EndIf
				Debug.Notification("Your lack of focus & coordination results in a stumble")
				sslBaseVoice voice = SexLab.PickVoice(PlayerRef)
				voice.Moan(PlayerRef, 10, False)
			
				; Drop as well ?
				If MilkMain.TripDropChance > Utility.RandomFloat(0.0, 100.0)
					Int RanInt = Utility.RandomInt(0, Menu.TotalSlots - 1)
					Int SlotSelect = Menu.DropSlots[RanInt]
					Armor ArmorSelect = PlayerRef.GetWornForm(SlotSelect) as Armor
					
					While (ArmorSelect == None && i < Menu.DropSlots.Length)
						ArmorSelect = PlayerRef.GetWornForm(Menu.DropSlots[i]) as Armor
						i+=1
					EndWhile
					If ArmorSelect != None
						If Math.LogicalAnd(ArmorSelect.GetSlotMask(), 4) == 4 && MilkMain.CurrentSlutiness == 7; Don't drop immune body armor
							Debug.Trace("_MA_: Not dropping immune clothes")
						
						ElseIf ((ArmorSelect.HasKeyword(ArmorClothing) || ArmorSelect.HasKeyword(ArmorLight) || ArmorSelect.HasKeyword(ArmorHeavy)) && !ArmorSelect.HasKeyword(SexLabNoStrip))
							ObjectReference DroppedItem
							PlayerRef.UnequipItem(ArmorSelect, false, true)
							DroppedItem = PlayerRef.DropObject(ArmorSelect, 1)
							DroppedItem.SetActorOwner(PlayerRef.GetActorBase())
							Menu.DroppedClothesAliases[RanInt].ForceRefTo(DroppedItem)
							Init.InitLostClothes(DroppedItem)
							_MA_StripArmor.Play(PlayerRef)
						EndIf
					EndIf
				EndIf

				; Mount ?
				If Menu.CreatureEventsT && !PlayerRef.IsInCombat() && PlayerRef.GetWornForm(4) == None && !Init.MountEventCooldown
					_MA_TripSearch.Stop()
					_MA_TripSearch.Start()
					i = 0
					ReferenceAlias nthAlias
					Actor  ActorRef
					While i < _MA_TripSearch.GetNumAliases() && CreatureSelect == None
						nthAlias = _MA_TripSearch.GetNthAlias(i) as ReferenceAlias
						ActorRef = nthAlias.GetReference() as Actor
						If ActorRef != None
							If PlayerRef.GetDistance(ActorRef) <= Menu.TripDistanceReq && SLA.GetActorArousal(ActorRef) >= Menu.TripArousalReq
								CreatureSelect = ActorRef
							EndIf
						EndIf
						i += 1
					EndWhile
					If Menu.DebugTripT
						Debug.Messagebox("Creature: " + CreatureSelect + ". Combat: " + PlayerRef.IsInCombat() + ". GetWornForm(4): " + PlayerRef.GetWornForm(4) + ". GetDistance: " + PlayerRef.GetDistance(CreatureSelect) + ". GetActorArousal: " + SLA.GetActorArousal(CreatureSelect))
						Debug.Trace("_MA_: Creature: " + CreatureSelect + ". Combat: " + PlayerRef.IsInCombat() + ". GetWornForm(4): " + PlayerRef.GetWornForm(4) + ". GetDistance: " + PlayerRef.GetDistance(CreatureSelect) + ". GetActorArousal: " + SLA.GetActorArousal(CreatureSelect))
					EndIf
					If CreatureSelect != None
						Init.TripMountEvent = true
						Init.MountEventCooldown = true
						Debug.Notification("A nearby creature mounts you suddenly in your vulnerable state")
						actor[] sexActors = new actor[2]
						SexActors[0] = PlayerRef
						SexActors[1] = CreatureSelect
						String animationTags
						String supressTags
						String raceID = MiscUtil.GetActorRaceEditorID(CreatureSelect)
						String RaceKeyz = sslCreatureAnimationSlots.GetRaceKeyByID(raceID) 
						sslBaseAnimation[] animations = Sexlab.GetCreatureAnimationsByRaceKeyTags(ActorCount = 2, RaceKey = RaceKeyz, Tags = "Doggystyle", TagSuppress = "", RequireAll = true)
						;Utility.Wait(0.2)
						If Menu.MountTeleport
							CreatureSelect.MoveTo(PlayerRef)
						EndIf
						Sexlab.StartSex(sexActors, animations, Victim = PlayerRef)
						_MA_TripMountSpectatorsQuest.Start()
					EndIf
				EndIf
				If CreatureSelect == None
					Init.SendTripSpankEvent()
				EndIf
			EndIf
			
			Utility.Wait(4.0) ; Takes about 4 seconds to get up?
			RegisterForSingleUpdate(MilkMain.TripFrequency)
		Else
			;If !Game.IsMovementControlsEnabled()
			;	Debug.Messagebox("Tried to trip but player controls disabled")
			;EndIf
			RegisterForSingleUpdate(MilkMain.TripFrequency)
		EndIf
		
	Else
		RegisterForSingleUpdate(30.0)
	EndIf
EndEvent

SPELL Property _MA_TripSpell  Auto

MagicEffect Property _MA_fortifyspeed Auto

Actor Property PlayerRef  Auto  

Keyword Property SexLabNoStrip  Auto  
Keyword Property ArmorClothing  Auto  
Keyword Property ArmorLight  Auto 
Keyword Property ArmorHeavy  Auto 
Keyword Property LocTypeDwelling Auto
Keyword Property LocTypeHabitation Auto

ReferenceAlias Property TripSearch01  Auto  

Quest Property _MA_TripSearch  Auto
Quest Property _MA_TripMountSpectatorsQuest Auto

Sound Property _MA_StripArmor Auto

_MA_Main Property MilkMain Auto
_MA_Init Property Init Auto
_MA_Mcm Property Menu Auto
SexLabFramework Property SexLab Auto
slaFrameWorkScr Property SLA Auto