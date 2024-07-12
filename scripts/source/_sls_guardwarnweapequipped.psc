Scriptname _SLS_GuardWarnWeapEquipped extends ReferenceAlias  

Event OnInit()
	If Self.GetOwningQuest().IsRunning()
		InProc = false
		RegisterForSingleUpdate(8.0) ; Wait some time after entering a city
	EndIf
EndEvent

Event OnUpdate()
	If DoDetection
		;Debug.Messagebox("OnUpdate() - DoDetection")
		DoGuardDetection()
		
	Else
		;Debug.Messagebox("OnUpdate() - !DoDetection")
		If IsWearingWeapon()
			BeginGuardDetection()
		Else
			UnRegisterForUpdate()
		EndIf
	EndIf
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	;Debug.Messagebox("OnObjectEquipped(): InProc: " + InProc)
	If !InProc && akBaseObject as Weapon
		If IsWeaponViolation(akBaseObject)
			If UI.IsMenuOpen("InventoryMenu")
				InProc = true
				While UI.IsMenuOpen("InventoryMenu") ; Don't use Utility.Wait() on it's own because of the Unpause mod
					Utility.Wait(2.0)
				EndWhile
				If IsWearingWeapon()
					;Debug.Messagebox("Hello HIHI!!!")
					BeginGuardDetection()
					InProc = false
				EndIf
			Else
				BeginGuardDetection()
			EndIf
		EndIf
	EndIf
EndEvent

Event OnObjectUnEquipped(Form akBaseObject, ObjectReference akReference)	
	;Debug.Messagebox("OnObjectUnEquipped(): InProc: " + InProc)
	If akBaseObject as Weapon
		If UI.IsMenuOpen("InventoryMenu")
			While UI.IsMenuOpen("InventoryMenu") ; Don't use Utility.Wait() on it's own because of the Unpause mod
				Utility.Wait(0.5)
			EndWhile
			If !IsWearingWeapon()
				EndGuardDetection()
			EndIf
		ElseIf !IsWearingWeapon()
			EndGuardDetection()
		EndIf
	EndIf
EndEvent

Bool Function IsWearingWeapon()
	Form akForm
	akForm = PlayerRef.GetEquippedWeapon(false)
	If akForm as Weapon
		If IsWeaponViolation(akForm)
			;Debug.Messagebox("IsWearingWeapon(): Yes 1")
			Return true
		EndIf
	EndIf
	akForm = PlayerRef.GetEquippedWeapon(true)
	If akForm as Weapon
		If IsWeaponViolation(akForm)
			;Debug.Messagebox("IsWearingWeapon(): Yes 2")
			Return true
		EndIf
	EndIf
	;Debug.Messagebox("IsWearingWeapon(): No")
	Return false
EndFunction

Bool Function IsWeaponViolation(Form akForm)
	If !akForm.HasKeyword(SexlabNoStrip) && akForm.IsPlayable() && !_SLS_LicExceptionsWeapon.HasForm(akForm) ; Is NoStrip and Playable Necessary?
		;Debug.Messagebox("IsWeaponViolation: " + akForm + "  Yes")
		Return true
	EndIf
	;Debug.Messagebox("IsWeaponViolation: " + akForm + "  No")
	Return false
EndFunction

Function BeginGuardDetection()
	;Debug.Messagebox("BeginGuardDetection()")
	DoDetection = true
	RegisterForSingleUpdate(3.0)
EndFunction

Function EndGuardDetection()
	;Debug.Messagebox("EndGuardDetection()")
	DoDetection = false
	UnRegisterForUpdate()
EndFunction

Function DoGuardDetection()
	If !CheckIsDetected()
		RegForUpdate()
	Else
		While _SLS_GuardWarnWeapEquippedDetectQuest.IsRunning() || UI.IsMenuOpen("Dialogue Menu")
			Utility.Wait(8.0)
		EndWhile
		If IsWearingWeapon()
			DoDetection = true
		Else
			DoDetection = false
		EndIf
		RegForUpdate()
	EndIf
EndFunction

Function RegForUpdate()
	If PlayerRef.IsInCombat()
		RegisterForSingleUpdate(30.0)
	Else
		RegisterForSingleUpdate(3.0)
	EndIf
EndFunction

Bool Function CheckIsDetected()
	If _SLS_GuardWarnTypeAndCooldown.GetValueInt() == 0
		_SLS_PlayerIsAIDriven.SetValueInt((PlayerRef.GetCurrentPackage() != None) as Int)
		_SLS_GuardWarnWeapEquippedDetectQuest.Stop()
		_SLS_GuardWarnWeapEquippedDetectQuest.Start()
		Actor Guard = (_SLS_GuardWarnWeapEquippedDetectQuest.GetNthAlias(0) as ReferenceAlias).GetReference() as Actor
		If Guard ; Detected
			;Debug.Messagebox("DETECTED")
			_SLS_GuardWarnTypeAndCooldown.SetValueInt(7)
			If Guard.IsInFaction(_SLS_GuardBehaviourWarningFact)
				_SLS_GuardWarnWeapEquippedDetectQuest.Stop()
				Util.SendBeginGuardWarnPunishEvent(_SLS_GuardWarnWeapEquippedDetectQuest, Guard)
			EndIf
			_SLS_GuardWarnDoApproach.SetValueInt(1)
			Guard.EvaluatePackage()
			;Debug.Messagebox("Guard: " + Guard + "\nPack: " + Guard.GetCurrentPackage())
			;Debug.Messagebox("CheckIsDetected(): Yes")
			Return true
		Else ; Not detected
			_SLS_GuardWarnWeapEquippedDetectQuest.Stop()
			;Debug.Messagebox("CheckIsDetected(): No 1")
			Return false
		EndIf
	
	Else
		;Debug.Messagebox("CheckIsDetected(): No 2")
		Return false
	EndIf
EndFunction

Faction Property _SLS_GuardBehaviourWarningFact Auto

Formlist Property _SLS_LicExceptionsWeapon Auto

GlobalVariable Property _SLS_GuardWarnDoApproach Auto
GlobalVariable Property _SLS_GuardWarnTypeAndCooldown  Auto
GlobalVariable Property _SLS_PlayerIsAIDriven  Auto

Quest Property _SLS_GuardWarnWeapEquippedDetectQuest Auto

Actor Property PlayerRef Auto

Keyword Property SexlabNoStrip Auto
Keyword Property ArmorLight Auto
Keyword Property ArmorHeavy Auto

SLS_Utility Property Util Auto

Bool InProc = false
Bool DoDetection = false
