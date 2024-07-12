Scriptname _AMP_Mcm extends SKI_ConfigBase  

event OnConfigInit()
	;Debug.Notification("Amputator MCM Initialized")
	RegisterForKey(EditorKey)
	SetupArrays()
endEvent

Event OnConfigClose()
	If AmpStartToggled
		ToggleAmputator()
	EndIf
EndEvent

Function SetupArrays()
	Pages = new string[3]
	Pages[0] = "General "
	Pages[1] = "Settings "
	Pages[2] = "Editor "
EndFunction

Function ToggleAmputator()
	If AmpEnabled
		_AMP_MainQuest.Start()
	
	Else
		Actor akTarget
		Int i = _AMP_AmputeeAliases.GetNumAliases()
		While i > 0
			i -= 1
			akTarget = (_AMP_AmputeeAliases.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
			If akTarget
				Main.RemoveFromAllAmpFactions(akTarget)
				OldMain.RemoveAllAmpSpells(akTarget)
				Main.ApplyAmputator(akTarget, 0, 0, true, Self)
			EndIf
		EndWhile
		_AMP_MainQuest.Stop()
	EndIf
	AmpStartToggled = false
EndFunction

Event OnPageReset(String page)
	SetCursorFillMode(TOP_TO_BOTTOM)
	If page == "General "
		AddHeaderOption("General ")
		optStart = AddToggleOption("Enable/Disable Amputator", AmpEnabled)
		optDebug = AddToggleOption("Debug Mode", valDebug)

	ElseIf page == "Settings "
		AddHeaderOption("All Actors")
		optAdjustSpeed= AddToggleOption("Adjust Movement Speed", _AMP_SlowEnable.GetValueInt())
		optUseAnimations = AddToggleOption("Use Alternate Animations ", valUseAnimations)
		GlitchedAnimSetOID = AddToggleOption("Use Glitched Animation Set ", Main.UseGlitchedAnimSet)
		AddemptyOption()
		
		AddHeaderOption("Player Only")
		optPlayerControls = AddToggleOption("Disable Player Controls", valPlayerControls)
		optAdjustJump = AddToggleOption("Adjust Jump height", Main.valAdjustJump)
		NormalJumpHeightOID_S = AddSliderOption("Normal Jump Height ", Main.StoredJumpHeight, "{1}")
		ResetJumpHeightOID = AddTextOption("Reset Jump Height ", "")
		AddemptyOption()

	ElseIf page == "Editor "
		UpdateNameList()
		AddHeaderOption("Editor ")
		EditorKeyOID_K = AddKeyMapOption("Editor Hotkey", EditorKey)
		AddemptyOption()
		AddTextOption("Actor Slot Usage: ", "(" + StorageUtil.FormListCount(_AMP_MainQuest, "_AMP_Amputees") + "/" + _AMP_AmputeeAliases.GetNumAliases() + ")")
		AmpListOID_M = AddMenuOption("Selected Actor ", AmpNameList[amplistIndex])
		optRemoveActor = AddTextOption("Remove Actor: ", AmpNameList[amplistIndex])
	EndIf
EndEvent

Event OnOptionHighlight(Int option)
	If option == optPlayerControls 
		SetInfoText("Toggle this to disable fighting and sneaking for the player, when affected by Amputator")
	elseIf option == optAdjustJump 
		SetInfoText("Toggle this to lower jumping height, when affected by Amputator")
	elseIf option == optAdjustSpeed
		SetInfoText("Toggle this to slow actors down, when affected by Amputator")
	elseIf option == optUseAnimations
		SetInfoText("Toggle this let actors use alternate animations, when affected by Amputator")
	elseIf option == optRemoveActor
		SetInfoText("Remove the currently selected actor from the amputator framework")
	elseIf option == GlitchedAnimSetOID
		SetInfoText("The newer crawling animation set that has the actor head lower and ass higher is glitched somehow (I'm not an animator so I haven't a clue). I recommend leaving this off. Other than the really annoying screen flashing to grey and your characters body disappearing it can also fire way too many animation events potentially overloading your script engine. If you think you can help fix this please get in touch")
	elseIf option == NormalJumpHeightOID_S
		SetInfoText("What your normal jump height should be when your legs are not amputated\nYour jump height is detected automatically on new games.")
	elseIf option == ResetJumpHeightOID
		SetInfoText("Sets your current jump height to 'Normal Jump Height' above. Useful if it gets messed up somehow\nCan also be used for fun as I left the slider range... wide. Or if you're just sick of climbing to High Hrothgar. Just remember what the value was so you can change it back afterwards")
	Endif
EndEvent

Event OnOptionDefault(Int option)
	If option == optDebug
		valDebug = false
		SetToggleOptionValue(optDebug, valDebug)
	elseIf (option == optAdjustJump)
		Main.valAdjustJump = true
		SetToggleOptionValue(optAdjustJump, Main.valAdjustJump)
	elseIf option == GlitchedAnimSetOID
		Main.UseGlitchedAnimSet = false
		SetToggleOptionValue(GlitchedAnimSetOID, Main.UseGlitchedAnimSet)
	ElseIf option == optAdjustSpeed
		_AMP_SlowEnable.SetValueInt(1)
		SetToggleOptionValue(optAdjustSpeed, _AMP_SlowEnable.GetValueInt())
		RefreshSpeeds()
	endif
EndEvent

Event OnOptionSelect(Int option)
	If (option == optStart)
		If AmpEnabled
			If ShowMessage("Disabling the amputator will remove amputations from all stored actors. Proceed?")
				AmpEnabled = !AmpEnabled
				AmpStartToggled = true
			EndIf
		Else
			AmpEnabled = !AmpEnabled
			AmpStartToggled = true
		EndIf
		SetToggleOptionValue(optStart, AmpEnabled)
	ElseIf (option == optDebug)
		valDebug = !valDebug
		SetToggleOptionValue(optDebug, valDebug)
	ElseIf (option == optAdjustSpeed)
		If _AMP_SlowEnable.GetValueInt() == 0
			_AMP_SlowEnable.SetValueInt(1)
		Else
			_AMP_SlowEnable.SetValueInt(0)
		EndIf
		SetToggleOptionValue(optAdjustSpeed, _AMP_SlowEnable.GetValueInt())	
		RefreshSpeeds()
	ElseIf (option == optAdjustJump)
		Main.valAdjustJump= !Main.valAdjustJump
		SetToggleOptionValue(optAdjustJump, Main.valAdjustJump)
	ElseIf (option == optPlayerControls )
		valPlayerControls= !valPlayerControls
		SetToggleOptionValue(optPlayerControls, valPlayerControls)
	ElseIf (option == optUseAnimations)
		valUseAnimations = !valUseAnimations 
		SetToggleOptionValue(optUseAnimations, valUseAnimations)
	ElseIf (option == GlitchedAnimSetOID)
		Main.UseGlitchedAnimSet = !Main.UseGlitchedAnimSet 
		SetToggleOptionValue(GlitchedAnimSetOID, Main.UseGlitchedAnimSet)
	ElseIf (option == optRemoveActor)
		SetTextOptionValue(optRemoveActor, "Removing... ")
		Main.ApplyAmputator(AmpActorList[amplistIndex] as Actor, 0, 0, true, Self)
		UpdateNameList()
		SetTextOptionValue(optAmpListCount ,ampListLength ,false)
		SetMenuOptionValue(AmpListOID_M, AmpNameList[amplistIndex])
		SetTextOptionValue(optRemoveActor, "Done! ")
	ElseIf option == ResetJumpHeightOID
		Game.SetGameSettingFloat("fJumpHeightMin", Main.StoredJumpHeight)
		SetTextOptionValue(ResetJumpHeightOID, "Done! ")
	EndIf
EndEvent

event OnOptionKeyMapChange(int option, int keyCode, string conflictControl, string conflictName)
    if (option == EditorKeyOID_K)
        EditorKey = keyCode
        SetKeyMapOptionValue(EditorKeyOID_K,EditorKey)
		UnregisterForAllKeys()
        RegisterForKey(EditorKey)
    endIf
endEvent

event OnOptionMenuOpen(int option)
    if (option == AmpListOID_M)
	UpdateNameList()
        SetMenuDialogOptions(AmpNameList)
        SetMenuDialogStartIndex(amplistIndex)
        SetMenuDialogDefaultIndex(0)
    endIf
endEvent

event OnOptionMenuAccept(int option, int index)
    if (option ==  AmpListOID_M)
        amplistIndex= index
        SetMenuOptionValue(AmpListOID_M, AmpNameList[amplistIndex])
		SetTextOptionValue(optRemoveActor, AmpNameList[amplistIndex])
    endIf
endEvent

Event OnOptionSliderOpen(int option)
	If (option == NormalJumpHeightOID_S)
		SetSliderDialogStartValue(Main.StoredJumpHeight)
		SetSliderDialogDefaultValue(76.0)
		SetSliderDialogRange(0.0, 100000.0)
		SetSliderDialogInterval(1.0)
	EndIf
EndEvent

Event OnOptionSliderAccept(int option, float value)
	If (option == NormalJumpHeightOID_S)
		Main.StoredJumpHeight = value
		SetSliderOptionValue(NormalJumpHeightOID_S, Main.StoredJumpHeight)
	EndIf
EndEvent

Event OnKeyDown(Int KeyCode)
	Debug.Trace("A registered key has been pressed")
	Main.ShowMessage()
EndEvent

Function UpdateNameList()
	StorageUtil.FormListClear(Self, "_AMP_ActorFormList")
	StorageUtil.StringListClear(Self, "_AMP_ActorStringList")
	Int i = _AMP_AmputeeAliases.GetNumAliases()
	Int Count = 0
	Actor akActor
	While i > 0
		i -= 1
		akActor = (_AMP_AmputeeAliases.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If akActor
			StorageUtil.StringListAdd(Self, "_AMP_ActorStringList", Count + ": " + akActor.GetActorBase().GetName())
			StorageUtil.FormListAdd(Self, "_AMP_ActorFormList", akActor)
		Else
			StorageUtil.StringListAdd(Self, "_AMP_ActorStringList", Count + ": None")
			StorageUtil.FormListAdd(Self, "_AMP_ActorFormList", None)
		EndIf
		Count += 1
	EndWhile
	AmpNameList = StorageUtil.StringListToArray(Self, "_AMP_ActorStringList")
	AmpActorList = StorageUtil.FormListToArray(Self, "_AMP_ActorFormList")
EndFunction

Function RefreshSpeeds()
	Int i = _AMP_AmputeeAliases.GetNumAliases()
	Actor akActor
	While i > 0
		i -= 1
		akActor = (_AMP_AmputeeAliases.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If akActor
			Game.GetPlayer().modAV("CarryWeight", -0.01)
			Game.GetPlayer().modAV("CarryWeight", 0.01)
		EndIf
	EndWhile
EndFunction

; SKYUI
Int optStart
Int optDebug
Int optPlayerControls
Int optUseAnimations
Int optAdjustSpeed
Int optAdjustJump
Int AmpListOID_M
Int GlitchedAnimSetOID
Int NormalJumpHeightOID_S
Int ResetJumpHeightOID

string[] AmpNameList
Form[] AmpActorList

Int ampListLength
Int optAmpListCount
int amplistIndex = 0
Int optRemoveActor
Bool AmpEnabled = true
Bool AmpStartToggled = false

Bool property valDebug = false Auto Hidden
Bool property valPlayerControls = true Auto Hidden
Bool property valUseAnimations = true Auto Hidden

;KEYMAP
int EditorKeyOID_K ; 
int EditorKey  = 59 ; F1

Quest Property _AMP_MainQuest Auto
Quest Property _AMP_AmputeeAliases Auto

GlobalVariable Property _AMP_SlowEnable Auto

_AMP_Main Property Main Auto
AmputatorMainScript Property OldMain Auto
