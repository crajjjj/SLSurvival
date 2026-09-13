Scriptname _SLS_CoverMyself extends ReferenceAlias  

Event OnInit()
	Quest CoverQuest = Self.GetOwningQuest()
	If CoverQuest.IsRunning()
		If Menu.CoverMyselfMechanics
			RegisterForModEvent("_SLS_IntCoverShutdown", "On_SLS_IntCoverShutdown")
			RegisterForMenu("InventoryMenu")
			;RegisterForKey(Menu.CoverMyselfKey)
			RegisterforCameraState()
			_SLS_CoveringNakedStatus.SetValueInt(5) ; player is naked and not covering
			; AND / Dynamic Feminine Modesty swap the nude locomotion set via OAR whenever
			; the player counts as modest - which overrides the cover/uncover choice this
			; quest exists to give. While this quest owns covering, gate those movesets off;
			; the key-driven offset anim is the only cover visual.
			_SLS_IntModestyAnims.SuppressCoverAnims(PlayerRef)
		Else
			CoverQuest.Stop()
		EndIf
	EndIf
EndEvent

Event OnPlayerLoadGame()
	; Suppression is applied at quest start; a save made while the quest was already
	; running never re-fires OnInit, so re-assert it on every load. Defined in the empty
	; state only - the default impl still runs while in "Covered", which is also correct.
	If Self.GetOwningQuest().IsRunning() && Menu.CoverMyselfMechanics
		_SLS_IntModestyAnims.SuppressCoverAnims(PlayerRef)
	EndIf
EndEvent

Function EndCover()
	If !Devious.IsPlayerGagged() && !sslBaseExpression.IsMouthOpen(PlayerRef)
		PlayerRef.ClearExpressionOverride()
	EndIf
	;Debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
	Debug.SendAnimationEvent(PlayerRef, "OffsetStop")
	GoToState("")
EndFunction

Event OnPlayerCameraState(int oldState, int newState)
	If newState >= 10 && newState <= 12 && !Devious.IsPlayerGagged() && !sslBaseExpression.IsMouthOpen(PlayerRef); Horse, bleedout or dragon
		PlayerRef.ClearExpressionOverride()
	EndIf
EndEvent

Event OnMenuOpen(String MenuName)
	IsInInv = true
EndEvent

Event OnMenuClose(String MenuName)
	IsInInv = false
EndEvent
;/
Function ChangeCoverKey(Int keyCode)
	UnRegisterForAllKeys()
	RegisterForKey(Menu.CoverMyselfKey)
EndFunction
/;
Event OnKeyDown(Int KeyCode)
	If !Utility.IsInMenuMode() && CanCover()
		If !Devious.IsPlayerGagged() && !sslBaseExpression.IsMouthOpen(PlayerRef)
			PlayerRef.SetExpressionOverride(11, 50)
		EndIf
		;Debug.SendAnimationEvent(PlayerRef, "ZaZAPCSHFOFF") ; Zaz - lots of footsteps
		Debug.SendAnimationEvent(PlayerRef, "SLS_CoverSelf") ; DCL - less footsteps
		GoToState("Covered")
	EndIf
EndEvent

Bool Function CanCover()
	If !PlayerRef.IsOnMount() && Devious.AreHandsAvailable(PlayerRef) && !Dflow.HasActorCrawlKeyword(PlayerRef) && Amp.AvailLeftLeg == 3 && Amp.AvailRightLeg == 3 && StorageUtil.GetStringValue(PlayerRef, "_SD_sDefaultStance") != "Crawling" && HasEnoughWillpower()
		Return true
	EndIf
	Return false
EndFunction

Bool Function HasEnoughWillpower()
	If Dflow.GetWillpower() == 0.0
		Debug.Notification("What's the point. Everyone's already seen me naked")
		Return false
	EndIf
	Return true
EndFunction

Event On_SLS_IntWeaponReadied(string eventName, string strArg, float numArg, Form sender)
EndEvent

Event OnAnimationStart(int tid, bool HasPlayer)
EndEvent

Event On_SLS_IntCoverShutdown(string eventName, string strArg, float numArg, Form sender)
	If numArg >= 1.0
		_SLS_CoveringNakedStatus.SetValueInt(1) ; Not naked
		If GetState() == "Covered"
			EndCover()
		EndIf
		_SLS_IntModestyAnims.RestoreCoverAnims(PlayerRef) ; hand cover anims back to AND/OAR
		Self.GetOwningQuest().Stop()
	EndIf
EndEvent

State Covered
	Event OnBeginState()
		;Debug.Messagebox("Begin State")
		RegisterForAnimationEvent(PlayerRef, "tailSprint")
		RegisterForAnimationEvent(PlayerRef, "JumpUp")
		RegisterForAnimationEvent(PlayerRef, "JumpDown") ; fall
		RegisterForAnimationEvent(PlayerRef, "BeginCastVoice")
		RegisterForAnimationEvent(PlayerRef,"staggerStop")
		RegisterForAnimationEvent(PlayerRef,"SoundPlay.FSTSwimSwim")
		RegisterForAnimationEvent(PlayerRef,"getupstart") ; rag doll
		RegisterForAnimationEvent(PlayerRef,"tailHorseMount")
		;RegisterForAnimationEvent(PlayerRef,"IdleSurrender") ; Doesn't register
		RegisterForModEvent("_SLS_IntWeaponReadied", "On_SLS_IntWeaponReadied")
		RegisterForModEvent("HookAnimationStart", "OnAnimationStart")
		
		_SLS_CoveringNakedStatus.SetValueInt(2)
	EndEvent
	
	Event OnEndState()
		UnRegisterForAnimationEvent(PlayerRef, "tailSprint")
		UnRegisterForAnimationEvent(PlayerRef, "JumpUp")
		UnRegisterForAnimationEvent(PlayerRef, "JumpDown")
		UnRegisterForAnimationEvent(PlayerRef, "BeginCastVoice")
		UnRegisterForAnimationEvent(PlayerRef,"staggerStop")
		UnRegisterForAnimationEvent(PlayerRef,"SoundPlay.FSTSwimSwim")
		UnRegisterForAnimationEvent(PlayerRef,"getupstart")
		UnRegisterForAnimationEvent(PlayerRef,"tailHorseMount")
		;UnRegisterForAnimationEvent(PlayerRef,"IdleSurrender") ; Doesn't register
		UnRegisterForModEvent("_SLS_IntWeaponReadied")
		UnRegisterForModEvent("HookAnimationStart")
		_SLS_CoveringNakedStatus.SetValueInt(5)
		;Debug.Messagebox("END State")
	EndEvent
	
	Event OnPlayerCameraState(int oldState, int newState)
		If newState >= 10 && newState <= 12 && !sslBaseExpression.IsMouthOpen(PlayerRef) ; Horse, bleedout or dragon
			PlayerRef.ClearExpressionOverride()
			GoToState("")
		EndIf
	EndEvent
	
	Event OnMenuClose(String MenuName)
		IsInInv = false
		If PlayerRef.WornHasKeyword(ArmorCuirass) || PlayerRef.WornHasKeyword(ClothingBody) || !CanCover()
			EndCover()
		EndIf
	EndEvent
	
	Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
		If !IsInInv && akBaseObject as Armor
			If Math.LogicalAnd((akBaseObject as Armor).GetSlotMask(), 4) == 4 || Devious.IsHandAnimChangeDevice(akBaseObject) || Dflow.HasArmorCrawlKeyword(akBaseObject as Armor)
				EndCover()
			EndIf
		EndIf
	EndEvent
		
	Event OnKeyDown(Int KeyCode)
		If !Utility.IsInMenuMode()
			If CanCover()
				EndCover()
			Else
				GoToState("")
				If !sslBaseExpression.IsMouthOpen(PlayerRef)
					PlayerRef.ClearExpressionOverride()
				EndIf
			EndIf
		EndIf
	EndEvent
	
	Event OnAnimationEvent(ObjectReference akSource, string asEventName)
		;Debug.MessageBox(asEventName)
		GoToState("")
	EndEvent
	
	Event OnAnimationStart(int tid, bool HasPlayer)
		GoToState("")
	EndEvent
	
	Event On_SLS_IntWeaponReadied(string eventName, string strArg, float numArg, Form sender)
		GoToState("")
	EndEvent
	
	Event OnSit(ObjectReference akFurniture)
		GoToState("")
	EndEvent
EndState

Bool IsInInv = false

SLS_Mcm Property Menu Auto
_SLS_InterfaceDevious Property Devious Auto
_SLS_InterfaceDeviousFollowers Property Dflow Auto
_SLS_Amputation Property Amp Auto

Keyword Property ArmorCuirass Auto
Keyword Property ClothingBody Auto
Keyword Property _DFCrawlRequired Auto Hidden

Actor Property PlayerRef Auto

Idle Property IdleStop Auto

GlobalVariable Property _SLS_CoveringNakedStatus Auto ; 1 - Not naked (1x ResistLoss), 2 - Naked but covering (2x ResistLost), 5 - Naked not covering (5x ResistLoss)
