Scriptname _SNObjectSetup extends ObjectReference  

;====================================================================================

Sound Property SoundFX Auto

Activator Property PlaceableObject Auto

MiscObject Property ObjectKit Auto

Message Property _SNWaterKegMsg Auto

ObjectReference UseableObject

Bool Property IsBarrel Auto
Bool Loaded

Actor Property PlayerRef Auto

;====================================================================================

Event OnLoad()
	Loaded = True
	If IsBarrel
		GoToState("Barrel")
	Else
		GoToState("KegBucket")
	EndIf
EndEvent

Event OnEquipped(Actor akActor)
	If !Loaded
		If IsBarrel
			GoToState("Barrel")
		Else
			GoToState("KegBucket")
		EndIf
	EndIf
EndEvent

;====================================================================================

Function PosMenu(ObjectReference Object, Int iButton = -1,  Bool abMenu = True)
	Utility.Wait(1.0)
	Float PosX = Object.GetPositionX()
	Float PosY = Object.GetPositionY()
	While abMenu
		iButton = _SNWaterKegMsg.Show()
		If iButton == 0						;Move Up
			Object.SetPosition(PosX, PosY, Object.GetPositionZ() + 5.0)
			Utility.Wait(1.0)
		ElseIf iButton == 1					;Move Down
			Object.SetPosition(PosX, PosY, Object.GetPositionZ() - 5.0)
			Utility.Wait(1.0)
		ElseIf iButton == 2					;Turn Left
			Object.SetAngle(0.0, 0.0, Object.GetAngleZ() + 5.0)
			Utility.Wait(1.0)
		ElseIf iButton == 3					;Turn Right
			Object.SetAngle(0.0, 0.0, Object.GetAngleZ() - 5.0)
			Utility.Wait(1.0)
		ElseIf iButton == 4					;Start Over
			Object.Disable()
			Object.Delete()
			PlayerRef.AddItem(ObjectKit)
			abMenu = False
			GoToState("Dead")
		ElseIf iButton == 5					;Exit
			abMenu = False
			GoToState("Dead")
		EndIf
	EndWhile
EndFunction

;====================================================================================

State Barrel

	Event OnBeginState()
		UseableObject = PlayerRef.PlaceAtMe(PlaceableObject)
		UseableObject.MoveTo(PlayerRef, 100.0 * Math.Sin(PlayerRef.GetAngleZ()), 100.0 * Math.Cos(PlayerRef.GetAngleZ()), 0.0)
		Float zOffset = UseableObject.GetHeadingAngle(PlayerRef)
		UseableObject.SetAngle(0.0, 0.0, UseableObject.GetAngleZ() + zOffset)
		If Loaded
			Self.Disable()
			Self.Delete()
		Else
			PlayerRef.RemoveItem(ObjectKit, 1, true)
		EndIf
		SoundFX.PlayAndWait(UseableObject)
		SoundFX.PlayAndWait(UseableObject)
		SoundFX.Play(UseableObject)
		PosMenu(UseableObject)
	EndEvent

EndState

;====================================================================================

State KegBucket

	Event OnBeginState()
		UseableObject = PlayerRef.PlaceAtMe(PlaceableObject)
		UseableObject.MoveTo(PlayerRef, 100.0 * Math.Sin(PlayerRef.GetAngleZ()), 100.0 * Math.Cos(PlayerRef.GetAngleZ()), 60.0)
		UseableObject.SetAngle(0.0, 0.0, UseableObject.GetAngleZ())
		If Loaded
			Self.Disable()
			Self.Delete()
		Else
			PlayerRef.RemoveItem(ObjectKit, 1, true)
		EndIf
		SoundFX.Play(UseableObject)
		PosMenu(UseableObject)
	EndEvent

EndState

;====================================================================================

State Dead
EndState