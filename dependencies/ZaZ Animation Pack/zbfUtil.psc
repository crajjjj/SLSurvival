Scriptname zbfUtil Hidden

; @section: zbfUtil
; 
; Mixed utility functions used by ZaZ Animation Pack. Free to use by other mods as well, just pay attention that some
; functions are ::Deprecated, and may disappear at a later time.
;
; There are plenty of alternatives to use, and functions document the suggested alternatives as needed.
; 
; @header: Sections
; - ::Getters: Functions to retrieve the various global objects in ZaZ Animation Pack.
; - ::Ai: Ai controls to turn on/off ai for the player.
; - ::Lists: List functions to manipulate lists of Strings and Forms.
; - ::Actor: Functions to manipulate actors, force them to wear items, check names, determine if the
;            actor can be used with SexLab (::IsValidActor), and so on.
; - ::Mask: Functions to manipulate masks of bits.
; - ::Misc: Mixed functions with no other obvious home.
; 

; @section: Getters

; @section: Version

; Returns the current version of ZaZ Animation Pack.
;
; Higher number means later versions.
Int Function GetVersion() Global
	Return 610
EndFunction

; Returns the current version of Zaz Animation Pack as a human readable string.
; 
String Function GetVersionStr() Global
	Return "8.0"
EndFunction

; @section: Ai

; Convenience function to lock ai
Function RetainAi() Global
	zbfBondageShell.GetApi().RetainAi()
EndFunction

; Convenience function to release ai
Function ReleaseAi() Global
	zbfBondageShell.GetApi().ReleaseAi()
EndFunction

; @section: Actor
; 
; Various support routines to help deal with actors. Fetching name (::GetActorName), putting on items (::WearItem, ::WearItemCond)
; and similar functions.
; 

; Puts on an armor item on the actor. The item itself is duplicated onto the character, so it's not removed from it's original container.
; 
; akActor - Actor to wear the item
; akArmor - Armor to place on the actor. Duplicates the item, original is not removed from it's container.
; abForced - Prevents removal by the character.
;
; Example:  
; zbfUtil.WearItem(PlayerRef, WristBindings, abForced = True)  
; Forces the player to wear WristBindings, and they can't be removed through the normal inventory screen.
Function WearItem(Actor akActor, Form akItem, Bool abForced = False) Global
	akActor.AddItem(akItem, aiCount = 1, abSilent = True)
	akActor.EquipItem(akItem, abPreventRemoval = abForced, abSilent = True)
EndFunction

; Unequips an item on the actor. Opposite of WearItem. The item, or a similar item, is destroyed in the process.
;
; akActor - Actor to unequip the armor.
; akArmor - Armor type to unequip. The item is not placed in the characters actors inventory.
; abForced - Prevents reequipping by the character (?)
; 
; Example:  
; zbfUtil.UnwearItem(PlayerRef, WristBindings)  
; Frees the player from wrist bindings. The bindings are not retained in the inventory.
Function UnWearItem(Actor akActor, Form akItem, Bool abForced = False) Global
	akActor.UnequipItem(akItem, abPreventEquip = abForced, abSilent = True)
	akActor.RemoveItem(akItem, aiCount = 1, abSilent = True)
EndFunction

; Conditionally wears an item
;
; Wears the item if:
; * Item is not already worn  
; * abCond evaluates to True  
Function WearItemCond(Actor akActor, Form akItem, Bool abForced = False, Bool abCond = True) Global
	If (akActor.IsEquipped(akItem) == False) && (abCond == True)
		akActor.AddItem(akItem, aiCount = 1, abSilent = True)
		akActor.EquipItem(akItem, abPreventRemoval = abForced, abSilent = True)
	EndIf
EndFunction

; Conditionally unwears an item
;
; Unwears the item if:
; * Item is worn
; * abCond evaluates to True
Function UnWearItemCond(Actor akActor, Form akItem, Bool abForced = False, Bool abCond = True) Global
	If (akActor.IsEquipped(akItem) == True) && (abCond == True)
		akActor.UnequipItem(akItem, abPreventEquip = abForced, abSilent = True)
		akActor.RemoveItem(akItem, aiCount = 1, abSilent = True)
	EndIf
EndFunction

; Actor scale is composed of two parts, B (base from CK) and S (console scale from console or papyrus)
; D (display scale) = B * S
; 
; Sets an actor display scale to a specified value.
; 
; Returns the previous scale factor (S) to make restoration easy. (Use SetScale from console or papyrus.)
Float Function SetActorDisplayScale(Actor akActor, Float afScale) Global
	; Identities:
	; 
	; D = S * B
	; D' = S' * B'
	; B = B'
	; S' = 1.0
	; 
	Float D = akActor.GetScale()
	akActor.SetScale(1.0)
	Float Dprim = akActor.GetScale()
	; B = B' = D' / S' = D'
	
	akActor.SetScale(afScale / Dprim)
	Return D / Dprim ; S = D / B = D / D'
EndFunction

; Returns a human friendly name for the specified actor.
; 
; A none actor is returned as an empty string.
; 
String Function GetActorName(Actor akActor) Global
	If akActor != None
		Return akActor.GetLeveledActorBase().GetName()
	EndIf
	Return ""
EndFunction

; Returns a human friendly name for the specified object reference.
; 
; A None variable returns as an empty string.
; 
String Function GetObjectName(ObjectReference akObject) Global
	If akObject != None
		Actor act = akObject As Actor
		If act != None
			Return act.GetLeveledActorBase().GetName()
		EndIf

		Return akObject.GetBaseObject().GetName() + "(" + akObject + ")"
	EndIf
	Return ""
EndFunction

; Returns true if the actor is valid for animating or running through the ZAP module.
; 
; There may be other considerations as well. For instance, the actor could be busy animating, or be under ai control from some other mod.
; These factors are obviously not checked. However, basics like if the actor is dead, has 3d loaded, or can animate or is visible at all,
; are properly checked.
; 
Bool Function IsValidActor(Actor akActor) Global
	If (akActor != None)
		ActorBase base = akActor.GetLeveledActorBase()
		Return \
			akActor.Is3DLoaded() && \
			!akActor.IsDisabled() && !akActor.IsDeleted() && \
			!akActor.IsDead() && (akActor.GetActorValue("Health") >= 1.0) && \
			!akActor.IsOnMount() && \
			!akActor.IsFlying() && \
			(base.GetSex() >= 0)
	EndIf
	Return False
EndFunction

; @section: Misc

; Places akObjA behind akObjB, according to akObjB's facing
;
; Works well to use with the pillory animations.
; This function is identical to MoveToFront with a negative distance and different default distance.
; 
Function MoveToBehind(ObjectReference akObjB, ObjectReference akObjA, Float afDistance = 45.0) Global
	akObjA.MoveTo(akObjB, -afDistance * Math.Sin(akObjB.GetAngleZ()), -afDistance * Math.Cos(akObjB.GetAngleZ()), 0.0)
EndFunction

; Places object A in front of object B at the specified distance.
;
; This function is identical to MoveToBehind with a negative distance and different default distance.
; 
Function MoveToFront(ObjectReference akObjB, ObjectReference akObjA, Float afDistance = 120.0) Global
	akObjA.MoveTo(akObjB, afDistance * Math.Sin(akObjB.GetAngleZ()), afDistance * Math.Cos(akObjB.GetAngleZ()), 0.0)
EndFunction

; Places akObject relative to akReference
; 
; akObject is placed in front of akReference, optionally offset by an angle, and at a specified distance.
; 
; Does not change facing of any of the objects.
; 
Function PlaceRelative(ObjectReference akObject, ObjectReference akReference, Float afDistance, Float afAngle = 0.0) Global
	Float angle = akReference.GetAngleZ() + afAngle
	akObject.MoveTo(akReference, afDistance * Math.Sin(angle), afDistance * Math.Cos(angle), 0, abMatchRotation = False)
EndFunction

; Rotates object akObject to face object akReference
; 
; An additional afOffset is added to the final heading, which is 0.0 if facing the object, and 180.0 if facing completely
; away from an object.
; 
Function FaceObject(ObjectReference akObject, ObjectReference akReference, Float afOffset = 0.0) Global
	Float angle = akObject.GetHeadingAngle(akReference)
	akObject.SetAngle(akObject.GetAngleX(), akObject.GetAngleY(), akObject.GetAngleZ() + angle + afOffset)
EndFunction

; Helper to get a Form from the animation pack.
; 
; Allows a fallback during development, and should not be triggered when using the mod. Generally one should use
; Game::GetFormFromFile instead.
; 
Form Function GetGenericForm(Int aiFormId) Global
	; Helper functions, not to be used directly.
	Form generic = Game.GetFormFromFile(aiFormId, "ZaZAnimationPack.esm")
	If generic == None
		generic = Game.GetFormFromFile(aiFormId, "ZaZAnimationPack.esp")
	EndIf
	Return generic
EndFunction

; @section: Lists

; Helper function to create an array of strings
; 
; Consider using ::ArgString instead, which is more flexible and does not limit the number of arguments to 6.
; 
String[] Function StrList(String asS1 = "", String asS2 = "", String asS3 = "", String asS4 = "", String asS5 = "", String asS6 = "") Global
	String[] list
	If asS1 == ""
		Return list ; Just an empty list then ....
	ElseIf asS2 == ""
		list = New String[1]
		list[0] = asS1
	ElseIf asS3 == ""
		list = New String[2]
		list[0] = asS1
		list[1] = asS2
	ElseIf asS4 == ""
		list = New String[3]
		list[0] = asS1
		list[1] = asS2
		list[2] = asS3
	ElseIf asS5 == ""
		list = New String[4]
		list[0] = asS1
		list[1] = asS2
		list[2] = asS3
		list[3] = asS4
	ElseIf asS6 == ""
		list = New String[5]
		list[0] = asS1
		list[1] = asS2
		list[2] = asS3
		list[3] = asS4
		list[4] = asS5
	Else
		list = New String[6]
		list[0] = asS1
		list[1] = asS2
		list[2] = asS3
		list[3] = asS4
		list[4] = asS5
		list[5] = asS6
	EndIf
	Return list
EndFunction

; Helper function to create a list of actors.
; 
; The list of actors is always compact, that is, zbfUtil.ActorList(None, None, PlayerRef, None) will return an array lookling
; like [PlayerRef, None, None, None]. The list is always in the same order as the parameters, however.
; 
Actor[] Function ActorList(Actor akActor1, Actor akActor2 = None, Actor akActor3 = None, Actor akActor4 = None) Global
	Actor[] list = New Actor[4]
	Int i = 0
	If akActor1 != None
		list[i] = akActor1
		i += 1
	EndIf
	If akActor2 != None
		list[i] = akActor2
		i += 1
	EndIf
	If akActor3 != None
		list[i] = akActor3
		i += 1
	EndIf
	If akActor4 != None
		list[i] = akActor4
		i += 1
	EndIf
	Return list
EndFunction

; Returns the number of non-None entries in the list of actors.
; 
Int Function CountActorList(Actor[] akList) Global
	Int iActors = 0
	Int i = akList.Length
	While i > 0
		i -= 1
		If akList[i] != None
			iActors += 1
		EndIf
	EndWhile
	Return iActors
EndFunction

; @section: Mask
; 
; Support routines for binary masks.
; 

; Adds the binary mask to aiMask, and returns the new value
; 
Int Function AddFlag(Int aiMask, Int aiFlags) Global
	Return Math.LogicalOr(aiMask, aiFlags)
EndFunction

; Removes the binary mask from aiMask, and returns the new value
; 
Int Function RemoveFlag(Int aiMask, Int aiFlags) Global
	Return Math.LogicalAnd(aiMask, Math.LogicalNot(aiFlags))
EndFunction

; Checks if aiMask has all of aiFlags
; 
Bool Function HasFlag(Int aiMask, Int aiFlags) Global
	Return Math.LogicalAnd(aiMask, aiFlags) == aiFlags
EndFunction

; Sets a set of flag to a specific boolean state.
; 
Int Function SetFlag(Int aiMask, Int aiFlags, Bool abState) Global
	If abState == False
		Return Math.LogicalAnd(aiMask, Math.LogicalNot(aiFlags))
	EndIf

	Return Math.LogicalOr(aiMask, aiFlags)
EndFunction

; Flips the specified flags (bits) to the other state
; 
Int Function FlipFlag(Int aiMask, Int aiFlags) Global
	Return Math.LogicalXor(aiMask, aiFlags)
EndFunction

; @section: Misc

; Checks if the game is currently in a menu, the console or similar.
; 
; This function can/should be used to disable keyboard intercepts.
; 
Bool Function IsInMenu() Global
	Return Utility.IsInMenuMode() || UI.IsMenuOpen("Console") || UI.IsMenuOpen("Loading Menu")
EndFunction

; Helper function to return a list of filtered actors from a source list.
; 
; Actors are valid only if they pass zbfUtil::IsValidActor.
; Optionally they must also be in the same cell as akReference, within the specified max distance.
; abRemovePlayer controls if the player is allowed to be slotted.
; 
; This function selects only up to four actors, and the array is always preallocated to four elements. The elements are always copied in
; the order of the source list.
; 
; This function can be used to filter actors for all functions in zbfSexLab:: in terms of valid and suitable actors. It will not check for
; worn items or similar.
; 
Actor[] Function GetFilteredActorList(Actor[] akSources, ObjectReference akReference = None, Float afMaxDistance = 4000.0, Bool abRemovePlayer = False) Global
	Actor PlayerRef = Game.GetPlayer()
	Actor[] temp = New Actor[4]
	Int i = 0
	Int matched = 0
	While (matched < 4) && (i < akSources.Length)
		Actor a = akSources[i]
		If zbfUtil.IsValidActor(a) && !(abRemovePlayer && (a == PlayerRef))
			If (akReference == None) || (a.GetDistance(akReference) < afMaxDistance && (a.GetParentCell() == akReference.GetParentCell()))
				temp[matched] = a
				matched += 1
			EndIf
		EndIf
		i += 1
	EndWhile
	Return temp
EndFunction

; Retrieves all actors selected through the MCM system
;
; Selecting actors is done by targetting an actor in game or in the console, then in-game pressing the select actor key (default N,
; same as SexLab).
; 
; This list will always contain the player in the first slot. See also zbfUtil::GetSelectedSexLabActors for the companion function.
; 
Actor[] Function GetSelectedActors() Global
	zbfExternalInterface zbfExt = zbfExternalInterface.GetApi()
	Return GetFilteredActorList(zbfExt.GetSelectedActors(), Game.GetPlayer())
EndFunction

; Retrieves the actor that was most recently selected through the MCM system
; 
Actor Function GetSelectedActor() Global
	zbfExternalInterface zbfExt = zbfExternalInterface.GetApi()
	Actor[] actors = GetFilteredActorList(zbfExt.GetSelectedActors(), Game.GetPlayer())
	Return actors[1]
EndFunction

; Retrieves all actors selected through the MCM "Animation Test System" menu
; 
; This list can be fully set by the user, and does not always contain the player.
; 
Actor[] Function GetSelectedSexLabActors() Global
	zbfExternalInterface zbfExt = zbfExternalInterface.GetApi()
	Return GetFilteredActorList(zbfExt.GetSelectedSexLabActors(), Game.GetPlayer())
EndFunction

; @section: Lists

; Splits a string into an array of strings based on a delimiter
; 
; asDelimiter - Controls the substring that marks a limit between strings.
; bAllowEmpty - If set, then the resulting list of strings is compacted.
; 
String[] Function ArgString(String asArgs, String asDelimiter = ",", Bool bAllowEmpty = False) Global
	String[] split = New String[15]
	Int iFoundStrings = 0
	Int iMaxLen = StringUtil.GetLength(asArgs)
	Int iDelimLength = StringUtil.GetLength(asDelimiter)

	Int iBegin = 0
	While iBegin < iMaxLen
		Int iEnd = StringUtil.Find(asArgs, asDelimiter, iBegin)
		If iEnd < 0
			iEnd = iMaxLen
		EndIf
		
		; trim the string
		Int iLeft = iBegin
		Int iRight = iEnd - 1
		While (iLeft <= iRight) && (StringUtil.GetNthChar(asArgs, iLeft) == " ")
			iLeft += 1
		EndWhile
		While (iLeft <= iRight) && (StringUtil.GetNthChar(asArgs, iRight) == " ")
			iRight -= 1
		EndWhile

		; If final (trimmed) length is longer than zero, assign the string to the slot
		If iLeft <= iRight
			split[iFoundStrings] = StringUtil.Substring(asArgs, iLeft, iRight - iLeft + 1)
		EndIf
		If bAllowEmpty || (split[iFoundStrings] != "")
			iFoundStrings += 1
		EndIf
		
		iBegin = iEnd + iDelimLength
	EndWhile

	String[] compact = StringArray(iFoundStrings)
	Int i = iFoundStrings
	While i > 0
		i -= 1
		compact[i] = split[i]
	EndWhile
	Return compact
EndFunction

; Removes beginning and trailing spaces in a string.
; 
; No other whitespace is touched.
; 
String Function Trim(String asInput) Global
	Int iLeft = 0
	Int iRight = StringUtil.GetLength(asInput) - 1
	
	While (iLeft <= iRight) && (StringUtil.GetNthChar(asInput, iLeft) == " ")
		iLeft += 1
	EndWhile
	While (iLeft <= iRight) && (StringUtil.GetNthChar(asInput, iRight) == " ")
		iRight -= 1
	EndWhile
	If iLeft <= iRight
		Return StringUtil.Substring(asInput, iLeft, iRight - iLeft + 1)
	EndIf
	Return ""
EndFunction

; @section: Lists

; Creates a String array with the specified length.
String[] Function StringArray(Int aiLength) Global
	String[] empty
	If aiLength < 8
		If aiLength <= 0
			Return empty
		ElseIf aiLength == 1
			Return New String[1]
		ElseIf aiLength == 2
			Return New String[2]
		ElseIf aiLength == 3
			Return New String[3]
		ElseIf aiLength == 4
			Return New String[4]
		ElseIf aiLength == 5
			Return New String[5]
		ElseIf aiLength == 6
			Return New String[6]
		Else
			Return New String[7]
		EndIf
	ElseIf aiLength < 16
		If aiLength == 8
			Return New String[8]
		ElseIf aiLength == 9
			Return New String[9]
		ElseIf aiLength == 10
			Return New String[10]
		ElseIf aiLength == 11
			Return New String[11]
		ElseIf aiLength == 12
			Return New String[12]
		ElseIf aiLength == 13
			Return New String[13]
		ElseIf aiLength == 14
			Return New String[14]
		Else
			Return New String[15]
		EndIf
	ElseIf aiLength < 24
		If aiLength == 16
			Return New String[16]
		ElseIf aiLength == 17
			Return New String[17]
		ElseIf aiLength == 18
			Return New String[18]
		ElseIf aiLength == 19
			Return New String[19]
		ElseIf aiLength == 20
			Return New String[20]
		ElseIf aiLength == 21
			Return New String[21]
		ElseIf aiLength == 22
			Return New String[22]
		Else
			Return New String[23]
		EndIf
	EndIf
	Debug.Trace("zbfUtil::StringArray function has failed for length " + aiLength + ".")
	Return empty
EndFunction

; Creates a Form array with the specified length.
Form[] Function FormArray(Int aiLength) Global
	Form[] empty
	If aiLength < 8
		If aiLength <= 0
			Return empty
		ElseIf aiLength == 1
			Return New Form[1]
		ElseIf aiLength == 2
			Return New Form[2]
		ElseIf aiLength == 3
			Return New Form[3]
		ElseIf aiLength == 4
			Return New Form[4]
		ElseIf aiLength == 5
			Return New Form[5]
		ElseIf aiLength == 6
			Return New Form[6]
		Else
			Return New Form[7]
		EndIf
	ElseIf aiLength < 16
		If aiLength == 8
			Return New Form[8]
		ElseIf aiLength == 9
			Return New Form[9]
		ElseIf aiLength == 10
			Return New Form[10]
		ElseIf aiLength == 11
			Return New Form[11]
		ElseIf aiLength == 12
			Return New Form[12]
		ElseIf aiLength == 13
			Return New Form[13]
		ElseIf aiLength == 14
			Return New Form[14]
		Else
			Return New Form[15]
		EndIf
	ElseIf aiLength < 24
		If aiLength == 16
			Return New Form[16]
		ElseIf aiLength == 17
			Return New Form[17]
		ElseIf aiLength == 18
			Return New Form[18]
		ElseIf aiLength == 19
			Return New Form[19]
		ElseIf aiLength == 20
			Return New Form[20]
		ElseIf aiLength == 21
			Return New Form[21]
		ElseIf aiLength == 22
			Return New Form[22]
		Else
			Return New Form[23]
		EndIf
	EndIf
	Debug.Trace("zbfUtil::FormArray function has failed for length " + aiLength + ".")
	Return empty
EndFunction

; Removes string ("", empty, by default) entries from a String array, compacting the array afterwards.
String[] Function TrimStringArray(String[] akArray, String akEmpty = "") Global
	Int iNonEmpty = 0
	Int i = akArray.Length
	While i > 0
		i -= 1
		If akArray[i] != akEmpty
			iNonEmpty += 1
		EndIf
	EndWhile
	String[] kNew = StringArray(iNonEmpty)
	i = akArray.Length
	Int j = kNew.Length
	While j > 0
		i -= 1
		If akArray[i] != akEmpty
			j -= 1
			kNew[j] = akArray[i]
		EndIf
	EndWhile
	Return kNew
EndFunction

; Removes Form (None by default) entries from a Form array, compacting the array afterwards.
Form[] Function TrimFormArray(Form[] akArray, Form akEmpty = None) Global
	Int iNonEmpty = 0
	Int i = akArray.Length
	While i > 0
		i -= 1
		If akArray[i] != akEmpty
			iNonEmpty += 1
		EndIf
	EndWhile
	Form[] kNew = FormArray(iNonEmpty)
	i = akArray.Length
	Int j = kNew.Length
	While j > 0
		i -= 1
		If akArray[i] != akEmpty
			j -= 1
			kNew[j] = akArray[i]
		EndIf
	EndWhile
	Return kNew
EndFunction

; @section: Deprecated
; 
; Deprecated functions. Replace calling these with the newer versions.
; 

; Returns the zbfSexLab module which handles SexLab integration.
;
; Function is deprecated. Use zbfSexLab::GetApi instead.
; 
zbfSexLab Function GetSexLab() Global
	Debug.Trace("zbfUtil::GetSexLab DEPRECATED!")
	Return zbfUtil.GetGenericForm(0x0200CD14) As zbfSexLab
EndFunction

; Returns the zbfSexLab module which handles SexLab integration.
;
; Identical to calling zbfSexLab::GetApi, which is the preferred way of getting the zbfSexLab api.
; 
zbfSexLab Function GetSL() Global
	Debug.Trace("zbfUtil::GetSL DEPRECATED!")
	Return zbfUtil.GetGenericForm(0x0200CD14) As zbfSexLab
EndFunction

; Returns the main ZaZ Animation Pack API
; 
; Identical to calling zbfBondageShell::GetApi, which is the preferred way of retrieving the instance.
; 
zbfBondageShell Function GetMain() Global
	Debug.Trace("zbfUtil::GetMain DEPRECATED!")
	Return zbfUtil.GetGenericForm(0x020137E6) As zbfBondageShell
EndFunction
