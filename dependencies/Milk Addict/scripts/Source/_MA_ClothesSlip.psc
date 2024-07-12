Scriptname _MA_ClothesSlip extends activemagiceffect  

Event OnInit()
	RegisterForSingleUpdate(MilkMain.SlipFrequency)
EndEvent

Event OnUpdate()	
	If MilkMain.SlipFrequency > 0.0 && Menu.TotalSlots > 0 && !PlayerRef.HasMagicEffect(_MA_FortifySpeed)
	
		Location CurrentLocation = PlayerRef.GetCurrentLocation()
		Float LocationMod = Menu.TripStripChanceLocationMod
		If CurrentLocation != None
			If CurrentLocation.HasKeyword(LocTypeDwelling) || CurrentLocation.HasKeyword(LocTypeHabitation)
				LocationMod = 1.0
			EndIf
		EndIf
		
		if (MilkMain.SlipChance * LocationMod) > utility.RandomFloat(0.0, 100.0) ; Slip success check
			Int RanInt = Utility.RandomInt(0, Menu.TotalSlots - 1)
			Int SlotSelect = Menu.DropSlots[RanInt]
			
			while !PlayerRef.IsRunning()
				Utility.wait(1)
			endwhile
			
			Armor ArmorSelect = PlayerRef.GetWornForm(SlotSelect) as Armor
			Int i = 0
			While (ArmorSelect == None && i < Menu.DropSlots.Length)
				ArmorSelect = PlayerRef.GetWornForm(Menu.DropSlots[i]) as Armor
				i+=1
			EndWhile
			If ArmorSelect != None
				If Math.LogicalAnd(ArmorSelect.GetSlotMask(), 4) == 4 && MilkMain.CurrentSlutiness == 7; Don't drop immune body armor
					Debug.Trace("_MA_: Not dropping immune clothes")
				ElseIf ((ArmorSelect.HasKeyword(ArmorClothing) || ArmorSelect.HasKeyword(ArmorLight) || ArmorSelect.HasKeyword(ArmorHeavy)) && (!ArmorSelect.HasKeyword(SexLabNoStrip) && ArmorSelect.IsPlayable()))
					ObjectReference DroppedItem
					If Menu.DropType == 0
						PlayerRef.UnequipItem(ArmorSelect, false, false)
					ElseIf Menu.DropType == 1
						DroppedItem = PlayerRef.DropObject(ArmorSelect, 1)
						DroppedItem.SetActorOwner(PlayerRef.GetActorBase())
						Init.InitLostClothes(DroppedItem)
						sslBaseVoice voice = SexLab.PickVoice(PlayerRef)
						voice.Moan(PlayerRef, 10, False)
						_MA_StripArmor.Play(DroppedItem)
					EndIf
					Menu.DroppedClothesAliases[RanInt].ForceRefTo(DroppedItem)
				EndIf				
			EndIf
		EndIf
		RegisterForSingleUpdate(MilkMain.SlipFrequency)
	Else
		RegisterForSingleUpdate(60)
	EndIf
EndEvent

Actor Property PlayerRef  Auto  

MagicEffect Property _MA_FortifySpeed Auto

_MA_Main Property MilkMain Auto
_MA_Mcm Property Menu Auto
_MA_Init Property Init Auto

Keyword Property SexLabNoStrip  Auto  
Keyword Property ArmorClothing  Auto  
Keyword Property ArmorLight  Auto 
Keyword Property ArmorHeavy  Auto 
Keyword Property LocTypeDwelling Auto
Keyword Property LocTypeHabitation Auto

ReferenceAlias Property DroppedClothesBody Auto
ReferenceAlias Property DroppedClothesHands Auto
ReferenceAlias Property DroppedClothesFeet Auto
ReferenceAlias Property DroppedClothesHair Auto

Sound Property _MA_StripArmor Auto

SexLabFramework Property SexLab Auto
