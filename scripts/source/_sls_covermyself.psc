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
		Else
			CoverQuest.Stop()
		EndIf
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
