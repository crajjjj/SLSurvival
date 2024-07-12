Scriptname zbfPlayerControl extends ReferenceAlias

; @section: zbfPlayerControl
; 
; To use this script, simply attach it to a ReferenceAlias in some quest that's started automatically.
; As soon as the script starts up, it will register with Zaz Animation Pack. If "Main" has been set in
; the CK, then this value will be used. Otherwise, it will automatically fetch the "Main" quest from
; the ZazAnimationPack.esm file.
; 
; Mods are encouraged to set a name. This way, a list of registered mods can be displayed on the
; Zaz Animation Pack MCM screen.
;

zbfBondageShell Property Main Auto
String Property ModName = "(Unnamed)" Auto

; @section: Ai
; 

; Turns on the player ai controls.
; 
; If called multiple times on this object, the corresponding release function must be called an equal number of times.
; For ai to be released from the player.
; 
; Ai retain/release mechanism is convenient to use in situations where several factors could indepenantly request ai control
; of the player. Examples would be a scene player at the same time that some event occurs. If the event retains ai, then releases it
; when done, it will not interfere with anyone else claiming ai control on the player.
; 
; Another example would be wearing an item that does not refresh its effect. Retain when the item is worn, and release when item is
; no longer worn. That way, it will not interefere with any other events or circumstances requesting player ai control.
; 
; Note that as long as at least one mod wants the player to be ai controlled, it will remain enabled.
Function RetainAi()
	iAiRefs += 1
	Main.RetainAi()
EndFunction

; Releases the player from ai control
; 
; Note that as long as at least one mod wants the player to be ai controlled, it will remain enabled.
Function ReleaseAi()
	If iAiRefs > 0
		Main.ReleaseAi()
		iAiRefs -= 1
	EndIf
EndFunction

; Releases all this mod's ai controls
; 
Function ReleaseAllAi()
	While iAiRefs > 0
		ReleaseAi()
	EndWhile
EndFunction

; Forces ai control from this mod
; 
; If abEnable is set to false, ai control from this mod is not forced. Zap will then consider only the ai count.
; If set to true, ai control will be enabled even if the ai counter is currently at zero (internally, this function
; increases the global counter).
; 
; Note that as long as at least one mod wants the player to be ai controlled, it will remain enabled.
Function SetAi(Bool abEnable)
	If abEnable != bAiForce
		If abEnable
			Main.RetainAi()
		Else
			Main.ReleaseAi()
		EndIf
	EndIf

	bAiForce = abEnable
EndFunction

; Returns true if ai is enabled from this mod.
; 
Bool Function GetAi()
	Return iAiRefs > 0
EndFunction

; @section: Player controls
; 

; Disable player controls
; 
; Every registered mod can disable player controls regardless of other registered mods. This makes sure that the least 
; amount of permissions are active on the player at any given time. There is no reference counting of player controls
; currently.
; 
Function SetDisabledControls(Bool abMovement = False, Bool abFighting = False, Bool abSneaking = False, Bool abMenu = False, Bool abActivate = False)
	iControlMask =  0x01 * abMovement As Int
	iControlMask += 0x02 * abFighting As Int
	iControlMask += 0x04 * abSneaking As Int
	iControlMask += 0x08 * abMenu As Int
	iControlMask += 0x10 * abActivate As Int

	InternalReapplyPlayerControls()
EndFunction

; Disables game controls
; 
Function SetDisabledGameControls(Bool abSaving = False, Bool abWaiting = False, Bool abShowMessage = False)
	iControlMask += 0x20 * abSaving As Int
	iControlMask += 0x40 * abWaiting As Int
	iControlMask += 0x80 * abShowMessage As Int

	InternalReapplyPlayerControls()
EndFunction

; Disables fast travel
; 
Function SetDisableFastTravel(Bool abFastTravel = False)
	iControlMask += 0x100 * abFastTravel As Int

	InternalReapplyPlayerControls()
EndFunction

; Sets the control mask manually.
; 
; This function is meant to be used by functions that already have access to a control mask. There
; is little point for an end user to call this function directly.
; 
Function SetRawControlMask(Int aiMask)
	iControlMask = Math.LogicalAnd(aiMask, 0xFF)
	InternalReapplyPlayerControls()
EndFunction

; Forces this mod to release all control impairments.
; 
Function ReleaseAll()
	iControlMask = 0
	iAiRefs = 0

	InternalReapplyPlayerControls()
EndFunction


; @section: Private
;

Int iAiRefs = 0 ; Number of ai references from this mod
Bool bAiForce = False ; Forced ai from this mod

; Control mask definition
; 
; NOTE: Order of these correspond to the same order that WornEffectMaskEx exposes. Do not change this order
; without changing in both places at the same time. Relative offset is less sensitive.
; 
; 0x1 - Movement
; 0x2 - Fighting
; 0x4 - Sneaking
; 0x8 - Menu
; 0x10 - Activation
; 
Int Property iControlMask Auto Hidden

Function InternalReapplyPlayerControls()
	Main.ReapplyPlayerControls()
EndFunction

Function InternalRegister()
	If Main == None
		Main = zbfUtil.GetMain()
	EndIf
	Main.Register(Self)
EndFunction

Event OnInit()
	GoToState("Registering")
	InternalRegister()
	GoToState("Normal")
EndEvent

Event OnPlayerLoadGame()
	GoToState("Registering")
	InternalRegister()
	GoToState("Normal")
EndEvent

Auto State Normal
EndState

State Registering
	Event OnInit()
	EndEvent

	Event OnPlayerLoadGame()
	EndEvent
EndState
