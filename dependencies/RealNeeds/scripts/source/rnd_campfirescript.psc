Scriptname RND_CampfireScript extends ObjectReference  
{this script handles campfire}

GlobalVariable Property GameHour Auto
MiscObject Property Firewood01 Auto
MiscObject Property CastIronPotMedium01 Auto

Furniture Property RND_CookingPot Auto
Static Property RND_CookingStone Auto
Light Property LightCampFire01 Auto

Message Property RND_CampfireMenu0 Auto
Message Property RND_CampfireMenu1 Auto
Message Property RND_CampfireOff Auto

Float CampfireLastUpdateTimeStamp
Float CampfireHoursLeft
Float HoursAbandoned

Bool CampfireOff = False
Bool CookPotAdded = False

Float PosX
Float PosY
Float PosZ

ObjectReference CampLight
ObjectReference CampFire
ObjectReference CookPot
ObjectReference CookStone

Event OnInit()

	PosX = Self.GetPositionX()
	PosY = Self.GetPositionY()
	PosZ = Self.GetPositionZ() - 16
	Self.SetPosition(PosX, PosY, PosZ + 6)
	Self.SetAngle(0.0, 0.0, 196)
	
	CampLight = Self.PlaceAtMe(LightCampFire01)
	CampFire = Self.PlaceAtMe(Game.GetForm(0x00033DA4))
	CampFire.SetScale(1.5)
	
	CampfireOff = False
	HoursAbandoned = 0.0
	CampfireHoursLeft = 6.0
	CampfireLastUpdateTimeStamp = Utility.GetCurrentGameTime()
	RegisterForSingleUpdateGameTime(1)
	
	If Game.GetPlayer().GetItemCount(CastIronPotMedium01) >= 1
		Game.GetPlayer().RemoveItem(CastIronPotMedium01, 1)	
		CookPotAdded = True
		; place cooking pot
		CookPot = Self.PlaceAtMe(RND_CookingPot)
		CookPot.SetPosition(PosX + 5, PosY + 115, PosZ - 2)
		CookPot.SetAngle(0.0, 0.0, 196)

		CookStone = Self.PlaceAtMe(RND_CookingStone)
		CookStone.SetPosition(PosX - 10, PosY +70, PosZ + 18)
		CookStone.SetAngle(0.0, 0.0, 196)		
	EndIf
	
	GameHour.SetValue(GameHour.GetValue() + 1)
	
EndEvent

Event OnLoad()
	Self.BlockActivation()
EndEvent

Event OnActivate(ObjectReference akActionRef)

	If (Game.GetPlayer() == akActionRef)
		If (Game.GetPlayer().IsSneaking() == 1)	
		
			If CampfireOff == True
				; reignite the fire
				If Game.GetPlayer().GetItemCount(Firewood01) >= 1
					Game.GetPlayer().RemoveItem(Firewood01,1)
					CampFire.Enable()
					CampLight.Enable()
					CampfireOff = False
					HoursAbandoned = 0
					CampfireHoursLeft = 2.0
					CampfireLastUpdateTimeStamp = Utility.GetCurrentGameTime()
					
					If (Game.GetPlayer().GetItemCount(CastIronPotMedium01) >= 1) && (CookPotAdded == False)
						Game.GetPlayer().RemoveItem(CastIronPotMedium01, 1)
						
						CookPotAdded = True
						; place cooking pot
						CookPot = Self.PlaceAtMe(RND_CookingPot)
						CookPot.SetPosition(PosX + 5, PosY + 115, PosZ - 2)
						CookPot.SetAngle(0.0, 0.0, 196)
						
						CookStone = Self.PlaceAtMe(RND_CookingStone)
						CookStone.SetPosition(PosX - 10, PosY +70, PosZ + 18)
						CookStone.SetAngle(0.0, 0.0, 196)
					EndIf
				EndIf	
			Else
				; put out the fire
				CampLight.Disable()
				CampFire.Disable()
				CampfireOff = True
				HoursAbandoned = 0
				CampfireHoursLeft = 0.0
				CampfireLastUpdateTimeStamp = Utility.GetCurrentGameTime()
				; return cooking pot to player
				If CookPotAdded == True
					CookPot.Delete()
					CookStone.Delete()
					Game.GetPlayer().AddItem(CastIronPotMedium01, 1)
					CookPotAdded = False
				EndIf
				
			EndIf
			
		Else
			; check campfire or add more firewood
			If CampfireOff == True
				RND_CampfireOff.Show()
				If CookPotAdded == True
					CookPot.Delete()
					CookStone.Delete()
					Game.GetPlayer().AddItem(CastIronPotMedium01, 1)
					CookPotAdded = False
				EndIf
			Else
				If CookPotAdded == False
					Int iClick = RND_CampfireMenu0.Show(CampfireHoursLeft)
					If iClick == 0
						akActionRef.RemoveItem(Firewood01, 1)
						CampfireHoursLeft += 2
					ElseIf iClick == 1
						Game.GetPlayer().RemoveItem(CastIronPotMedium01, 1)						
						CookPotAdded = True
						; place cooking pot
						CookPot = Self.PlaceAtMe(RND_CookingPot)
						CookPot.SetPosition(PosX + 5, PosY + 115, PosZ - 2)
						CookPot.SetAngle(0.0, 0.0, 196)
		
						CookStone = Self.PlaceAtMe(RND_CookingStone)
						CookStone.SetPosition(PosX - 10, PosY +70, PosZ + 18)
						CookStone.SetAngle(0.0, 0.0, 196)
					EndIf
				Else
					Int iClick = RND_CampfireMenu1.Show(CampfireHoursLeft)
					If iClick == 0
						akActionRef.RemoveItem(Firewood01, 1)
						CampfireHoursLeft += 2
					ElseIf iClick == 1
						CookPot.Delete()
						CookStone.Delete()
						Game.GetPlayer().AddItem(CastIronPotMedium01, 1)
						CookPotAdded = False
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
EndEvent 


Event OnUpdateGameTime()

	If CampfireOff == True
	
		HoursAbandoned += (Utility.GetCurrentGameTime() - CampfireLastUpdateTimeStamp) * 24
		
		If HoursAbandoned >= 24
			CampLight.Delete()
			CampFire.Delete()
			If CookPotAdded == True
				CookPot.Delete()
				CookStone.Delete()
			EndIf
			UnregisterForUpdateGameTime()
			Utility.Wait(1)
			Self.Disable(True)
			Self.Delete()
		Else
			CampfireLastUpdateTimeStamp = Utility.GetCurrentGameTime()
			RegisterForSingleUpdateGameTime(1)
		EndIf
	Else

		CampfireHoursLeft -= (Utility.GetCurrentGameTime() - CampfireLastUpdateTimeStamp) * 24
	
		If CampfireHoursLeft <= 0
			; burn out
			CampLight.Disable()
			CampFire.Disable()
			CampfireOff = True
			HoursAbandoned = 0
			CampfireHoursLeft = 0.0
		EndIf
		CampfireLastUpdateTimeStamp = Utility.GetCurrentGameTime()
		RegisterForSingleUpdateGameTime(1)
		
	EndIf
EndEvent




