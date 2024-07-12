Scriptname _AMP_Main extends Quest

Event OnInit()
	Utility.Wait(3.0)
	ModCRC = FNIS_aa.GetInstallationCRC()
	if (ModCRC == 0)
		; Error
	else
		InitAnims ()
	EndIf
	
	StoredJumpHeight = Game.GetGameSettingFloat("fJumpHeightMin")
EndEvent

Function ScriptInit()
	int current_crc = FNIS_aa.GetInstallationCRC()
	if(current_crc == 0)
		;Error
	ElseIf (current_crc != ModCRC)
		InitAnims ()
		ModCRC = current_crc
	EndIf
EndFunction

Function InitAnims()
	ModID = FNIS_aa.GetAAModID("amp",Modname ,true)
	mtidle_base = FNIS_aa.GetGroupBaseValue(ModID, FNIS_aa._mtidle(), Modname , true)
	mt_base = FNIS_aa.GetGroupBaseValue(ModID, FNIS_aa._mt(), Modname , true)
	mtx_base = FNIS_aa.GetGroupBaseValue(ModID, FNIS_aa._mtx(), Modname , true)
	sprint_base = FNIS_aa.GetGroupBaseValue(ModID, FNIS_aa._sprint(), Modname , true)
	mtturn_base = FNIS_aa.GetGroupBaseValue(ModID, FNIS_aa._mtturn(), Modname , true)
EndFunction

Function AddActor(Actor akActor)
	Actor akTarget
	Int EmptySlot = -1
	Int i = _AMP_AmputeeAliases.GetNumAliases()
	While i > 0
		i -= 1
		akTarget = (_AMP_AmputeeAliases.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If akTarget
			If akTarget == akActor
				Debug.Trace("_AMP_: Actor is already added")
				Return
			EndIf
			
		Else
			If EmptySlot == -1
				EmptySlot = i
			EndIf
		EndIf
	EndWhile
	
	If EmptySlot > -1
		(_AMP_AmputeeAliases.GetNthAlias(EmptySlot) as ReferenceAlias).ForceRefTo(akActor)
		StorageUtil.FormListAdd(Self, "_AMP_Amputees", akActor, allowDuplicate = false)
		Debug.Trace("_AMP_: Added " + akActor.GetBaseObject().GetName() + " to amputator")
	Else
		Debug.Notification("_AMP_: No empty slots remaining")
		Debug.Trace("_AMP_: No empty slots remaining")
	EndIf
EndFunction

Function RemoveActor(Actor akActor)
	If akActor
		Actor akTarget
		Int i = _AMP_AmputeeAliases.GetNumAliases()
		While i > 0
			i -= 1
			akTarget = (_AMP_AmputeeAliases.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
			If akTarget == akActor
				(_AMP_AmputeeAliases.GetNthAlias(i) as ReferenceAlias).Clear()
				StorageUtil.FormListRemove(Self, "_AMP_Amputees", akActor, allInstances = true)
				If akActor.Is3Dloaded()
					AmputateActor(akActor, 0, 0, true, Self)
				EndIf
				Debug.Trace("_AMP_: Removed " + akActor.GetBaseObject().GetName() + " from amputator")
			EndIf
		EndWhile
	EndIf
EndFunction

Function GameLoadReapply()
	Utility.Wait(2.0)
	Bool SlifInstalled = Game.GetModByName("SexLab Inflation Framework.esp") != 255
	Actor akTarget
	Int i = _AMP_AmputeeAliases.GetNumAliases()
	While i > 0
		i -= 1
		akTarget = (_AMP_AmputeeAliases.GetNthAlias(i) as ReferenceAlias).GetReference() as Actor
		If akTarget
			If akTarget.Is3Dloaded()
				If SlifInstalled ; SLIF is not refreshing the nodes on load for some reason. Heal and reamp.
					AmputateActor(akTarget, 0 , 0, false, Self)
				Endif
				ReapplyAmputations(akTarget)
			EndIf
		EndIf
	EndWhile
EndFunction

Function ReapplyAmputations(Actor akActor)
	If akActor
		If Game.GetModByName("SexLab Inflation Framework.esp") != 255
			AmputateActor(akActor, 0 , 0, false, Self)
		EndIf

		; Arms
		Int RankL = akActor.GetFactionRank(_AMP_AmputeeArmLeftFact)
		Int RankR = akActor.GetFactionRank(_AMP_AmputeeArmRightFact)
		If RankL > -1
			AmputateActor(akActor , RankL + 1, 1, false, Self)
		Endif
		If RankR > -1
			AmputateActor(akActor , RankR + 1, 2, false, Self)
		EndIf
		
		; Legs
		RankL = akActor.GetFactionRank(_AMP_AmputeeLegLeftFact)
		RankR = akActor.GetFactionRank(_AMP_AmputeeLegRightFact)
		If RankL > -1
			AmputateActor(akActor , RankL + 4, 1, false, Self)
		Endif
		If RankR > -1
			AmputateActor(akActor , RankR + 4, 2, false, Self)
		EndIf
	
	Else
		Debug.Trace("_AMP_: ReapplyAmputations: Received a none actor")
	Endif
EndFunction

Function ApplyAmputator(Actor akActor, int morphType ,int bothleftright, Bool SendEvent = true, Form akSource = None)
	;/
	morphType determines which bodypart to remove, the codes are:
	0 = Heal all Amputations
	1 = Feet
	2 = Lower Legs
	3 = Upper Legs
	4 = Hands
	5 = Forearms
	6 = UpperArms

	bothLeftRight determines which side to remove
	0 = Both sides
	1 = Left
	2 = Right
	
	Factions. Actors added to factions depending on amputations
	_AMP_AmputeeArmLeftFact
	_AMP_AmputeeArmRightFact
	_AMP_AmputeeLegLeftFact
	_AMP_AmputeeLegRightFact
	
	Faction Rank < 0 = Unaffected
	Faction Rank = 1 = Hand/Foot
	Faction Rank = 2 = Forearm/Lower leg
	Faction Rank = 3 = Upper arm/Upper leg
	
	SendEvent: If enabled sends a mod event to inform other mods that a limb change has occurred on the actor. Default = true. False is mainly used internally to refresh current amputation states on game load etc. 
	ApplyAmputator calls through the old AmputatorMainScript script make sendevent = true. This maintains compatibility with mods using the older version of the amputator (same number of arguements)
	
	akSource: The source form that requested the limb change. If the akSource == None then it means the call was made through the old main script (AmputatorMainScript) by a mod that has not been updated to use Amputator Tweaked and it's source can not be determined. 
	You can use 'If akSource != YourQuest' (or whatever form send the request) to ignore changes made by your own mod.
	/;
	
	;Debug.Messagebox("akActor: " + akActor + "\nmorphType: " + morphType + "\nbothleftright: " + bothleftright)
	If akActor
		If morphType == 0
			OldMain.RemoveAllAmpSpells(akActor)
			RemoveFromAllAmpFactions(akActor)
			
			RemoveActor(akActor)
			AmputateActor(akActor, 0, 0, SendEvent, akSource)

		Else 
			If bothleftright == 0 ; Both
				akActor.AddSpell(OldMain.AmputeeAbilitiesRight[morphType - 1], false)
				akActor.AddSpell(OldMain.AmputeeAbilitiesLeft[morphType - 1], false)
				If morphType  < 4 ; Legs
					akActor.SetFactionRank(_AMP_AmputeeLegLeftFact, morphType - 1)
					akActor.SetFactionRank(_AMP_AmputeeLegRightFact, morphType - 1)
					
				Else ; Arms
					akActor.SetFactionRank(_AMP_AmputeeArmLeftFact, morphType - 4)
					akActor.SetFactionRank(_AMP_AmputeeArmRightFact, morphType - 4)
				EndIf
			
			ElseIf bothleftright == 1 ; Left
				akActor.AddSpell(OldMain.AmputeeAbilitiesLeft[morphType - 1], false)
				If morphType  < 4 ; Legs
					akActor.SetFactionRank(_AMP_AmputeeLegLeftFact, morphType - 1)
					
				Else ; Arms
					akActor.SetFactionRank(_AMP_AmputeeArmLeftFact, morphType - 4)
				EndIf
				
			ElseIf bothleftright == 2 ; Right
				akActor.AddSpell(OldMain.AmputeeAbilitiesRight[morphType - 1], false)
				If morphType  < 4 ; Legs
					akActor.SetFactionRank(_AMP_AmputeeLegRightFact, morphType - 1)
					
				Else ; Arms
					akActor.SetFactionRank(_AMP_AmputeeArmRightFact, morphType - 4)
				EndIf
			EndIf   

			AddActor(akActor)
			akActor.AddSpell(OldMain.AMP_AmputeeStatusEffectSpell, false)
			AmputateActor(akActor, morphType, bothleftright, SendEvent, akSource)
		EndIf
		akActor.modAV("CarryWeight", -0.01)
		akActor.modAV("CarryWeight", 0.01) 
	
	Else
		Debug.Trace("_AMP_: ApplyAmputator: Received a None actor")
	EndIf
EndFunction

Function AmputateActor(Actor akActor, int morphType ,int bothleftright, Bool SendEvent = true, Form akSource)
	;Debug.Messagebox("akActor: " + akActor + "\nmorphType: " + morphType + "\nbothleftright: " + bothleftright)
	OldMain.RemoveObseleteSpell(akActor)

	Int LeftArmRank = akActor.GetFactionRank(_AMP_AmputeeArmLeftFact)
	Int RightArmRank = akActor.GetFactionRank(_AMP_AmputeeArmRightFact)
	Int LeftLegRank = akActor.GetFactionRank(_AMP_AmputeeLegLeftFact)
	Int RightLegRank = akActor.GetFactionRank(_AMP_AmputeeLegRightFact)

	If(morphType == 0)
		ChangeWalkAnimations(akActor, -1)
		Morph.MorphActor(akActor ,0 ,0)
	
	Else
		ChooseWalkAnimation(akActor, LeftArmRank, RightArmRank, LeftLegRank, RightLegRank)
		;/
		If LeftLegRank == 0 || RightLegRank == 0 ;FEET
			ChangeWalkAnimations(akActor,0)

		ElseIf LeftLegRank == 1 || RightLegRank == 1 ;LOWER LEGS
			;If(akActor.WornHasKeyword(ProstheticKwdL[1]) || akActor.WornHasKeyword(ProstheticKwdR[1]))
			;	ChangeWalkAnimations( akActor, -1)
			;	DebugMessage("Prosthetic Legs Active")
			
			;Else
				If LeftArmRank == 1 || RightArmRank == 1
					ChangeWalkAnimations(akActor, 1)
				ElseIf LeftArmRank == 2 || RightArmRank == 2
					ChangeWalkAnimations(akActor, 2)
				Else
					ChangeWalkAnimations(akActor, 0)
				EndIf
			;Endif

		ElseIf LeftLegRank == 2 || RightLegRank == 2 ;UPPER LEGS
			ChangeWalkAnimations(akActor, 2)
		EndIf
		/;
	EndIf
	
	If(morphType > 0)
		DoMorphs(akActor, 3, LeftArmRank + 4, 1)
		DoMorphs(akActor, 3, RightArmRank + 4, 2)
		DoMorphs(akActor, 0, LeftLegRank + 1, 1)
		DoMorphs(akActor, 0, RightLegRank + 1, 2)
	EndIf
	
	If SendEvent
		SendAmpModEvent(akActor, akSource)
	Endif
EndFunction

Function ChooseWalkAnimation(Actor akActor, Int LeftArmRank, Int RightArmRank, Int LeftLegRank, Int RightLegRank)
	;Debug.Messagebox("_AMP_: ChooseWalkAnimation(): akActor: " + akActor + "\nLeftArmRank: " + LeftArmRank + "\nRightArmRank: " + RightArmRank + "\nLeftLegRank: " + LeftLegRank + "\nRightLegRank: " + RightLegRank)
	;Debug.Trace("_AMP_: ChooseWalkAnimation(): akActor: " + akActor + "\nLeftArmRank: " + LeftArmRank + "\nRightArmRank: " + RightArmRank + "\nLeftLegRank: " + LeftLegRank + "\nRightLegRank: " + RightLegRank)
;/	
	If LeftLegRank == 2 || RightLegRank == 2 ;UPPER LEGS
		ChangeWalkAnimations(akActor, 2)
	ElseIf LeftLegRank == 1 || RightLegRank == 1 ;LOWER LEGS
		;If(akActor.WornHasKeyword(ProstheticKwdL[1]) || akActor.WornHasKeyword(ProstheticKwdR[1]))
		;	ChangeWalkAnimations( akActor, -1)
		;	DebugMessage("Prosthetic Legs Active")
		
		;Else
			If LeftArmRank == 1 || RightArmRank == 1 ; Feet
				ChangeWalkAnimations(akActor, 1)
			ElseIf LeftArmRank == 2 || RightArmRank == 2
				ChangeWalkAnimations(akActor, 2)
			Else
				ChangeWalkAnimations(akActor, 0)
			EndIf
		;Endif
	Else
		ChangeWalkAnimations(akActor, -1)
	EndIf
/;

;/
	If LeftLegRank == 0 || RightLegRank == 0 ;FEET
		ChangeWalkAnimations(akActor,0)

	ElseIf LeftLegRank == 1 || RightLegRank == 1 ;LOWER LEGS
		;If(akActor.WornHasKeyword(ProstheticKwdL[1]) || akActor.WornHasKeyword(ProstheticKwdR[1]))
		;	ChangeWalkAnimations( akActor, -1)
		;	DebugMessage("Prosthetic Legs Active")
		
		;Else
			If LeftArmRank == 1 || RightArmRank == 1
				ChangeWalkAnimations(akActor, 1)
			ElseIf LeftArmRank == 2 || RightArmRank == 2
				ChangeWalkAnimations(akActor, 2)
			Else
				ChangeWalkAnimations(akActor, 0)
			EndIf
		;Endif

	ElseIf LeftLegRank == 2 || RightLegRank == 2 ;UPPER LEGS
		ChangeWalkAnimations(akActor, 2)
	EndIf
/;
	If LeftLegRank < 0 && RightLegRank < 0
		ChangeWalkAnimations(akActor, -1)
	Else
		If LeftArmRank >= 1 && RightArmRank >= 1
			ChangeWalkAnimations(akActor, 1)
		Else
			ChangeWalkAnimations(akActor, 0)
		EndIf
	EndIf
EndFunction

Function DoMorphs(Actor akActor, Int Limit, Int AmpFactionRank, Int Side)
	While AmpFactionRank > Limit
		Morph.MorphActor(akActor , AmpFactionRank, Side)
		AmpFactionRank -= 1
	EndWhile
EndFunction

Function ChangeWalkAnimations(Actor akActor,int animset)
	Debug.Trace("_AMP_: ChangeWalkAnimations()" + akActor + ". animset: " + animset)
	If(Menu.valuseAnimations)
		bool bOk
		
		If animset > 0 && !UseGlitchedAnimSet
			animset = 0
		EndIf
		
		If animset == -1
			bOk = FNIS_aa.SetAnimGroup(akActor,"_mtidle", 0, 0, Modname, true)
			bOk = FNIS_aa.SetAnimGroup(akActor,"_mt", 0, 0, Modname, true)
			bOk = FNIS_aa.SetAnimGroup(akActor,"_mtx", 0, 0, Modname, true)
			bOk = FNIS_aa.SetAnimGroup(akActor,"_sprint", 0, 0, Modname, true)
			bOk = FNIS_aa.SetAnimGroup(akActor,"_mtturn", 0, 0, Modname, true)
			
			bOk = FNIS_aa.SetAnimGroup(akActor,"_sneakidle", 0, 0, Modname, true)
			bOk = FNIS_aa.SetAnimGroup(akActor,"_sneakmt", 0, 0, Modname, true)

			If(akActor ==  PlayerRef)
				DebugMessage("Vanilla Animationset")
				zbfPC.SetDisabledControls(false, false, false, false, false)
				Game.SetGameSettingFloat("fJumpHeightMin", StoredJumpHeight)
			EndIf
		
		ElseIf animset == 0
			bOk = FNIS_aa.SetAnimGroup(akActor,"_mtidle", mtidle_base, 0, Modname, true)
			bOk = FNIS_aa.SetAnimGroup(akActor,"_mt", mt_base, 0, Modname, true)
			bOk = FNIS_aa.SetAnimGroup(akActor,"_mtx", mtx_base, 0, Modname, true)
			bOk = FNIS_aa.SetAnimGroup(akActor,"_sprint", sprint_base, 0, Modname, true)
			bOk = FNIS_aa.SetAnimGroup(akActor,"_mtturn", mtturn_base, 0, Modname, true)

			bOk = FNIS_aa.SetAnimGroup(akActor,"_sneakidle", mtidle_base, 0, Modname, true)
			bOk = FNIS_aa.SetAnimGroup(akActor,"_sneakmt", mt_base, 0, Modname, true)

			If(akActor == PlayerRef)
				DebugMessage("Old on all fours Animationset")
				If Menu.valPlayerControls
					zbfPC.SetDisabledControls(false, true, true, false, false)
				EndIf
				If valAdjustJump
					Game.SetGameSettingFloat("fJumpHeightMin", 10.0)
				Endif
			EndIf
			
		ElseIf animset == 1; && UseGlitchedAnimSet
			bOk = FNIS_aa.SetAnimGroup(akActor,"_mtidle", mtidle_base, 1, Modname, true)
			bOk = FNIS_aa.SetAnimGroup(akActor,"_mt", mt_base, 1, Modname, true)
			bOk = FNIS_aa.SetAnimGroup(akActor,"_mtx", mtx_base, 1, Modname, true)
			bOk = FNIS_aa.SetAnimGroup(akActor,"_sprint", sprint_base, 1, Modname, true)
			bOk = FNIS_aa.SetAnimGroup(akActor,"_mtturn", mtturn_base, 1, Modname, true)
			
			if(akActor == PlayerRef)
				DebugMessage("New on all fours Animationset")
				If Menu.valPlayerControls
					zbfPC.SetDisabledControls(false, true, true, false, false)
				EndIf
				If valAdjustJump
					Game.SetGameSettingFloat("fJumpHeightMin", 5.0)
				Endif
			EndIf
		
		ElseIf animset == 2; || (animset == 1 && UseGlitchedAnimSet)
			bOk = FNIS_aa.SetAnimGroup(akActor,"_mtidle", mtidle_base, 2, Modname, true)
			bOk = FNIS_aa.SetAnimGroup(akActor,"_mt", mt_base,2, Modname, true)
			bOk = FNIS_aa.SetAnimGroup(akActor,"_mtx", mtx_base, 2, Modname, true)
			bOk = FNIS_aa.SetAnimGroup(akActor,"_sprint", sprint_base, 2, Modname, true)
			bOk = FNIS_aa.SetAnimGroup(akActor,"_mtturn", mtturn_base, 2, Modname, true)
			If(akActor == PlayerRef)
				DebugMessage("Crawling Animationset")
				If Menu.valPlayerControls
					zbfPC.SetDisabledControls(false, true, true, false, false)
				EndIf
				If valAdjustJump
					Game.SetGameSettingFloat("fJumpHeightMin", 5.0)
				Endif
			EndIf
		EndIf
		
		If !bOk
			DebugMessage("Amputator Fnis AlternateAnimations Error")
		EndIf
	EndIf
EndFunction

Function DebugMessage(string msg)
	If(Menu.valDebug)
		Debug.Notification(msg)
	EndIf
EndFunction

Function ShowMessage()
		Actor akActor = Game.GetCurrentCrosshairRef() as Actor
		;Int dbutton = 0
		Int ibutton = 0
		If !akActor
			akActor = PlayerRef
		EndIf
		Debug.notification("Amputator selected Actor: " + akActor.GetDisplayName())
		ibutton = _AMP_ToggleSpellMsg.show()
		If Ibutton == 0
			ApplyAmputator(akActor, ibutton, 0, true, Self) ; Heal
		ElseIf Ibutton == 7
			ChooseWalkAnimation(akActor, akActor.GetFactionRank(_AMP_AmputeeArmLeftFact), akActor.GetFactionRank(_AMP_AmputeeArmRightFact), akActor.GetFactionRank(_AMP_AmputeeLegLeftFact), akActor.GetFactionRank(_AMP_AmputeeLegRightFact))
		Else           
			;dbutton = _AMP_ToggleLeftRightSpellMsg.show()
			ApplyAmputator(akActor, ibutton, _AMP_ToggleLeftRightSpellMsg.show(), true, Self)
		EndIf
			
		;/
		else
			int cbutton = _AMP_NoValidActorMsg.show()
			if(cbutton == 0)
				ibutton = _AMP_ToggleSpellMsg.show()                  
				if(Ibutton != 0)             
					dbutton = _AMP_ToggleLeftRightSpellMsg.show()
				EndIf
				If dbutton == 7
					Else
					ApplyAmputator(PlayerRef, ibutton, dbutton, true, Self)
				EndIf
			else
			
			EndIf
		EndIf
		/;
EndFunction

Function RemoveFromAllAmpFactions(Actor akActor)
	akActor.RemoveFromFaction(_AMP_AmputeeArmLeftFact)
	akActor.RemoveFromFaction(_AMP_AmputeeArmRightFact)
	akActor.RemoveFromFaction(_AMP_AmputeeLegLeftFact)
	akActor.RemoveFromFaction(_AMP_AmputeeLegRightFact)
EndFunction

Function SendAmpModEvent(Actor akActor, Form akSource = None)
	; akActor: the actor the limb change applied to
	; akSource: the source form that requested the change
	Int AmpEvent = ModEvent.Create("_AMP_LimbChangeEvent")
	If (AmpEvent)
		ModEvent.PushForm(AmpEvent, akActor)
		ModEvent.PushForm(AmpEvent, akSource)
		ModEvent.Send(AmpEvent)
	EndIf
EndFunction

Function AmputeeGetsUp(Actor akActor, ObjectReference akFurniture)
	;Debug.Messagebox("akFurniture: " + akFurniture + "\nBase: " + akFurniture.GetBaseObject())
	If _AMP_MineMarkerList.HasForm(akFurniture.GetBaseObject())
		ReapplyAmputations(akActor)
	EndIf
EndFunction

Int ModCRC
Int ModID
Int mtidle_base
Int mt_base
Int mtx_base
Int sprint_base
int mtturn_base

string property Modname Auto

Float Property StoredJumpHeight Auto Hidden

Bool Property UseGlitchedAnimSet = false Auto Hidden
Bool Property valAdjustJump = true Auto Hidden

Message Property _AMP_ToggleSpellMsg  Auto  
Message Property _AMP_ToggleLeftRightSpellMsg  Auto  
Message Property _AMP_NoValidActorMsg Auto  

Actor Property PlayerRef Auto

Quest Property _AMP_AmputeeAliases Auto

Faction Property _AMP_AmputeeLegRightFact Auto ; < 0 not affected, 0 - Foot, 1 - Lower leg, 2 - Upper leg
Faction Property _AMP_AmputeeLegLeftFact Auto
Faction Property _AMP_AmputeeArmRightFact Auto
Faction Property _AMP_AmputeeArmLeftFact Auto

Formlist Property _AMP_MineMarkerList Auto

AmputatorMainScript Property OldMain Auto
_AMP_Morph Property Morph Auto
_AMP_Mcm Property Menu Auto 
zbfPlayerControl Property zbfPC Auto
