Scriptname MilkPlayerLoadGame extends ReferenceAlias  

;import MyPluginScript

;----------------------------------------------------------------------------
;Events
;----------------------------------------------------------------------------

Event OnInit()
	Debug.Trace("MilkModEconomy 1st run, initializing")
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST

	MilkQ.VarSetup()
	MilkQ.MaidReset()
	MilkQ.SlaveReset()
	if !MilkQ.MilkFlag
		MilkQ.MilkFlag = true
		MilkQ.EconFlag = true
		MilkQ.RegisterForSingleUpdateGameTime (MilkQ.MilkPoll)
		MilkQ.MilkE.RegisterForSingleUpdateGameTime (MilkQ.MilkPoll)
		Debug.Notification("Milk Mod Enabled. Event intervals set to: Milk production - " + MilkQ.MilkPoll + " hour, Economy update every morning at 9 o'clock")
	endif
	Maintenance()
EndEvent

Event OnPlayerLoadGame()
	Maintenance()
EndEvent

;----------------------------------------------------------------------------
;Self hooks
;----------------------------------------------------------------------------

Event onMME_AddMilkSlave(Form Sender, Int Level, Float Milk)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	actor akActor = Sender as Actor
	
	if akActor != none
		if MilkQ.MILKmaid.find(akActor, 0) == -1 && MilkQ.MILKslave.find(akActor, 0) == -1
			if !Level
				Level = 0
			endif
			if !Milk
				Milk = 0
			endif
			MilkQ.AssignSlotSlave(akActor, Level, Milk)
		elseif MilkQ.MILKmaid.find(akActor) != -1
			String MaidName = akActor.GetLeveledActorBase().getname()
			Debug.Notification(MilkQ.formatString(JsonUtil.GetStringValue("/MME/Strings", "ismaid"), MaidName))
		else 
			String MaidName = akActor.GetLeveledActorBase().getname()
			Debug.Notification(MilkQ.formatString(JsonUtil.GetStringValue("/MME/Strings", "isslave"), MaidName))
		endif
	else
		Debug.Notification(JsonUtil.GetStringValue("/MME/Strings", "eventactornone"))
	endif
EndEvent

Event onMME_AddMilkMaid(Form Sender)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	actor akActor = Sender as Actor
	
	if akActor != none
		if MilkQ.MILKmaid.find(akActor, 0) == -1 && MilkQ.MILKslave.find(akActor, 0) == -1
			MilkQ.AssignSlotMaid(akActor)
		elseif MilkQ.MILKmaid.find(akActor) != -1
			String MaidName = akActor.GetLeveledActorBase().getname()
			Debug.Notification(MilkQ.formatString(JsonUtil.GetStringValue("/MME/Strings", "ismaid"), MaidName))
		else 
			String MaidName = akActor.GetLeveledActorBase().getname()
			Debug.Notification(MilkQ.formatString(JsonUtil.GetStringValue("/MME/Strings", "isslave"), MaidName))
		endif
	else
		Debug.Notification(JsonUtil.GetStringValue("/MME/Strings", "eventactornone"))
	endif
EndEvent

Event onMME_Milking(Form Sender, Int Mode, Int PumpType)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	actor akActor = Sender as Actor
	
	if akActor != none
		if MilkQ.MILKmaid.find(akActor) != -1
			MilkQ.Milking(akActor, 0, Mode, PumpType)
		else 
			String MaidName = akActor.GetLeveledActorBase().getname()
			Debug.Notification(MilkQ.formatString(JsonUtil.GetStringValue("/MME/Strings", "isnotmaid"), MaidName))
		endif
	else
		Debug.Notification(JsonUtil.GetStringValue("/MME/Strings", "eventactornone"))
	endif
EndEvent

Event OnSlaveToggle(Form Sender)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	actor akActor = Sender as Actor
	
	if akActor != none
		if MilkQ.MILKmaid.find(akActor) == -1 && MilkQ.MILKmaid.find(akActor) == -1
			String MaidName = akActor.GetLeveledActorBase().getname()
			Debug.Notification(MilkQ.formatString(JsonUtil.GetStringValue("/MME/Strings", "isnotmaidslave"), MaidName))
		elseif StorageUtil.GetIntValue(akActor,"MME.MilkMaid.IsSlave") == 0
			StorageUtil.SetIntValue(akActor,"MME.MilkMaid.IsSlave", 1)
			akActor.AddToFaction(MilkQ.MilkSlaveFaction)
		elseif StorageUtil.GetIntValue(akActor,"MME.MilkMaid.IsSlave") == 1
			StorageUtil.SetIntValue(akActor,"MME.MilkMaid.IsSlave", 0)
			akActor.RemoveFromFaction(MilkQ.MilkSlaveFaction)
		endif
	else
		Debug.Notification(JsonUtil.GetStringValue("/MME/Strings", "eventactornone"))
	endif
EndEvent

Event OnSleepStop(bool abInterrupted)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	Int i = 0
	
	while i < MilkQ.MILKmaid.length
		if MilkQ.MILKmaid[i] != none
			int BreastRowsAdjust = StorageUtil.GetFloatValue(MilkQ.MILKmaid[i],"MME.MilkMaid.AdjustBreastRow") as int
			if BreastRowsAdjust != 0
				int BreastRows = MME_Storage.getBreastRows(MilkQ.MILKmaid[i])
				MME_Storage.setBreastRows(MilkQ.MILKmaid[i], BreastRows + BreastRowsAdjust)
				MilkQ.MultibreastChange(MilkQ.MILKmaid[i])
				StorageUtil.SetFloatValue(MilkQ.MILKmaid[i],"MME.MilkMaid.AdjustBreastRow", 0) 						;reset
			endif
		endif
		i += 1
	endWhile
	self.RegisterForSleep()
endEvent

;----------------------------------------------------------------------------
;SexLab hooks
;----------------------------------------------------------------------------

Event OnSexLabStart(String _eventName, String _args, Float _argc, Form _sender)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	Actor[] actors = MilkQ.SexLab.HookActors(_args)											;0 - actor being sucked, 1 - actor sucking
	sslBaseAnimation animation = MilkQ.SexLab.HookAnimation(_args)
	String  animName = getAnimName(_args)

	if (animName == "3J Straight Breastfeeding"\
	|| animName == "3J Lesbian Breastfeeding"\
	|| animName == "3Jiou Breastfeeding Lesbian"\
	|| animName == "3Jiou Breastfeeding Straight")\
	|| animation.HasTag("Breastfeeding")

		if MilkQ.MILKmaid.Find(actors[0]) != -1\
		&& !actors[0].HasSpell( MilkQ.BeingMilkedPassive )\
		&& (actors[0].GetLeveledActorBase().GetSex() == 1 || (actors[0].GetLeveledActorBase().GetSex() == 0 && MilkQ.MaleMaids))
			if MME_Storage.getMilkCurrent(actors[0]) >= 1

				actors[1].equipitem(MilkQ.MME_Milk_Basic.GetAt(0), true, true)
				
				;khajiit gives lactacid
				if actors[1].GetLeveledActorBase().GetRace() == Game.GetFormFromFile(0x13745, "Skyrim.esm") as Race
					actors[0].additem(MilkQ.MME_Util_Potions.GetAt(0), 1)
				endif
			endif
			MilkQ.Milking(actors[0], 0, 4, 0)
		endif
	endif
EndEvent

Event OnSexLabEnd(String _eventName, String _args, Float _argc, Form _sender)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	Actor[] actors = MilkQ.SexLab.HookActors(_args)
	int idx

	While idx < actors.Length
		if actors[idx].HasSpell( MilkQ.BeingMilkedPassive )
			actors[idx].RemoveSpell( MilkQ.BeingMilkedPassive )
		endif
		idx += 1
	EndWhile
EndEvent

Event OnSexLabOrgasm(String _eventName, String _args, Float _argc, Form _sender)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	Actor[] actors = MilkQ.SexLab.HookActors(_args)
	int idx

	While idx < actors.Length
		Orgasm(actors[idx], _args)
		idx += 1
	EndWhile
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int Thread)
	actor akActor = ActorRef as actor
	string _args =  Thread as string
	
	Orgasm(akActor, _args)
EndEvent

String Function getAnimName(String _argString)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	sslBaseAnimation animation = MilkQ.SexLab.HookAnimation(_argString)

	If animation
		Return animation.Name
	EndIf
	return ""
EndFunction

Function Orgasm(Actor akActor, String _args)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	sslBaseAnimation animation = MilkQ.SexLab.HookAnimation(_args)

	if MilkQ.MILKmaid.Find(akActor) != -1
		if MME_Storage.getMilkCurrent(akActor) >= 1
			;can orgasm from genitals
			;can orgasm from tits
			if ((animation.HasTag("Anal")\
				|| animation.HasTag("Vaginal")\
				|| animation.HasTag("Masturbation")\
				|| animation.HasTag("Fisting"))\
				&& !MilkQ.DDI.IsWearingBelt(akActor))\
			|| (animation.HasTag("Breast")\ 
				&& ((!MilkQ.DDi.IsMilkingBlocked_Bra(akActor) && !MilkQ.SLSD.IsMilkingBlocked_Bra_SLSD(akActor))\
				|| (MilkQ.DDi.IsMilkingBlocked_Bra(akActor) && MilkQ.SLSD.IsMilkingBlocked_Bra_SLSD(akActor))))
				
				If ((!MilkQ.DDi.IsMilkingBlocked_Bra(akActor) && !MilkQ.SLSD.IsMilkingBlocked_Bra_SLSD(akActor))\
				|| (MilkQ.DDi.IsMilkingBlocked_Bra(akActor) && MilkQ.SLSD.IsMilkingBlocked_Bra_SLSD(akActor)))
				
					Form maidArmor = akActor.GetWornForm(Armor.GetMaskForSlot(32))
					if maidArmor != none && MilkQ.MilkingEquipment.Find(maidArmor.getname()) != -1\
					|| maidArmor == MilkQ.MilkCuirass\
					|| maidArmor == MilkQ.MilkCuirassFuta\
					|| StringUtil.Find(maidArmor.getname(), "Milk" ) >= 0\
					|| StringUtil.Find(maidArmor.getname(), "Cow" ) >=0\
					|| MilkQ.SLSD.IsMilkingBlocked_Bra_SLSD(akActor)
						if StorageUtil.GetIntValue(akActor, "MME.MilkMaid.IsSlave") == 1
							StorageUtil.AdjustFloatValue(akActor, "MME.MilkMaid.MilkingContainerMilksSUM", 1)
						else
							MilkQ.MilkE.InitiateTrade(1, 1, akActor, true)
						endif
						MME_Storage.changeMilkCurrent(akActor, -1, MilkQ.BreastScaleLimit)
					elseif maidArmor != none && MilkQ.BasicLivingArmor.find(maidArmor.getname()) >= 0\
					|| MilkQ.ParasiteLivingArmor.find(maidArmor.getname()) >= 0\
					|| StringUtil.Find(maidArmor.getname(), "Spriggan" ) >= 0\
					|| StringUtil.Find(maidArmor.getname(), "Living Arm" ) >= 0\
					|| StringUtil.Find(maidArmor.getname(), "Hermaeus Mora" ) >= 0\
					|| StringUtil.Find(maidArmor.getname(), "HM Priestess" ) >= 0\
					|| StringUtil.Find(maidArmor.getname(), "Tentacle Armor" ) >= 0\
					|| StringUtil.Find(maidArmor.getname(), "Tentacle Parasite" ) >= 0
						MME_Storage.changeMilkCurrent(akActor, -1, MilkQ.BreastScaleLimit)
					else
						MME_Storage.changeMilkCurrent(akActor, -1, MilkQ.BreastScaleLimit)
					endif
					;MME_Storage.changeMilkCurrent(akActor, -1, MilkQ.BreastScaleLimit)
					StorageUtil.AdjustFloatValue(akActor,"MME.MilkMaid.TimesMilked", 1)
					MilkQ.PostMilk(akActor)
					MilkQ.AddMilkFx(akActor, 2)
					MilkQ.AddLeak(akActor)
					If MilkQ.MilkMsgs == true
						String MaidName = akActor.GetLeveledActorBase().GetName()
						Debug.Notification(MilkQ.formatString(JsonUtil.GetStringValue("/MME/Strings", "orgasmmilkleak"), MaidName))
					EndIf
				EndIf
				
				if (animation.HasTag("Breast")\
				&& ((!MilkQ.DDi.IsMilkingBlocked_Bra(akActor) && !MilkQ.SLSD.IsMilkingBlocked_Bra_SLSD(akActor))\
				|| (MilkQ.DDi.IsMilkingBlocked_Bra(akActor) && MilkQ.SLSD.IsMilkingBlocked_Bra_SLSD(akActor))))
					float MilkCnt = MME_Storage.getMilkCurrent(akActor)
					int gush = (MilkCnt*MilkQ.GushPct/100) as int
					String MaidName = akActor.GetLeveledActorBase().getname()
					
					if gush < 1
						gush = 1
					endif
					
					if StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.MilkGen") == 0 
						Debug.Notification(MilkQ.formatString(JsonUtil.GetStringValue("/MME/Strings", "lactationstart"), MaidName))
					endif
					StorageUtil.AdjustFloatValue(akActor, "MME.MilkMaid.MilkGen", MilkQ.MilkGenValue/3/10 * gush)
				endif
			endif
		endif
	endif
	
	Actor PlayerRef = Game.Getplayer()
	if  MilkQ.CumProduction && (akActor == PlayerREF || MilkQ.MILKmaid.Find(akActor) != -1) && !(MilkQ.isSuccubus(akActor) || MilkQ.isVampire(akActor))
		if animation.HasTag("Masturbation")\
		&& !(MilkQ.DDi.IsWearingBelt(akActor)\
		|| MilkQ.DDi.IsMilkingBlocked_Armbinder(akActor)\
		|| MilkQ.DDi.IsMilkingBlocked_Yoke(akActor))

			if MilkQ.akActorSex(akActor) == "Male" 
				akActor.AddItem(MilkQ.MME_Cums.GetAt(1), 1)
			elseif MilkQ.akActorSex(akActor) == "Female" 
				akActor.AddItem(MilkQ.MME_Cums.GetAt(0), 1)
			elseif MilkQ.akActorSex(akActor) == "Futa"
				int futamilk = Utility.RandomInt(0, 1)
				akActor.AddItem(MilkQ.MME_Cums.GetAt(3), futamilk)
				akActor.AddItem(MilkQ.MME_Cums.GetAt(2), 1-futamilk)
			endif
			if akActor == PlayerREF
				PlayerREF.RemoveItem(JsonUtil.GetFormValue("/MME/Forms", "gold") as MiscObject, 2, true)
			endif
		endif
	endif
EndFunction

;----------------------------------------------------------------------------
;change breast size on game load/location change
;----------------------------------------------------------------------------

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	UpdateSize()
EndEvent

Function UpdateSize()
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST

	if MilkQ.MILKmaid as Bool && MilkQ.MilkFlag && MilkQ.BreastScale == 2
		Debug.Trace("MilkModEconomy, BreastScale = NiE, LocationChange/GameLoad updating breast size")
		Int i = 0
		while i < MilkQ.MILKmaid.length
			if MilkQ.MILKmaid[i] != none && MilkQ.MILKmaid[i].IsInLocation(MilkQ.PlayerREF.getCurrentLocation())
				MilkQ.CurrentSize(MilkQ.MILKmaid[i])
			endIf
			i += 1
		endWhile
	endIf
EndFunction

Function Maintenance()
;Debug.Notification("My SKSE float function returned " + MyTest())
;Debug.Notification("My SKSE string function returned " + GetStringValue())
	Debug.Trace("MilkModEconomy OnPlayerLoadGame")
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST

	if PapyrusUtil.GetVersion() < 28
		Debug.MessageBox( "PapyrusUtil is too old" + PapyrusUtil.GetVersion())
	endif
	
	if SexLabUtil.GetVersion() < 15903
		Debug.MessageBox( "SexLab is too old" + SexLabUtil.GetVersion())
	endif
	
	String File

	File = "/MME/MME_SOS.json"
	if JsonUtil.GetErrors(File) != ""
		Debug.Notification("MME_SOS.Json has errors")
	endif
	
	File = "/MME/RND.json"
	if JsonUtil.GetErrors(File) != ""
		Debug.Notification("MME_RND.Json has errors")
	endif
	
	File = "/MME/Strings.json"
	if JsonUtil.GetErrors(File) != ""
		Debug.Notification("MME_Strings.Json has errors")
	endif
	
	RegisterEvents()

	MilkQ.MME_Milks.revert()
	MilkQ.MME_Foods.revert()

	MilkQ.DLCcheck()
	MilkQ.Strings_setup()	;rem
	;MilkQ.DebuffArraySet()	;rem
	;MilkQ.BuffArraySet()	;rem
	
	;debug
	;MME_RebuildJson.MME_JsonRebuild()
	;Game.GetPlayer().additem(MilkQ.MME_Util_Potions.GetAt(0), 10)
	self.UpdateSize()
	self.RegisterForSleep()

	if MilkQ.SexLab.AnimSlots.GetbyRegistrar("zjBreastFeedingVar") && MilkQ.SexLab.AnimSlots.GetbyRegistrar("zjBreastFeeding")
		MilkQ.MilkQC.MME_BreasfeedingAnimationsCheck = True
		Debug.Trace("MilkModEconomy 3J Breastfeeding animations found")
	else
		MilkQ.MilkQC.MME_BreasfeedingAnimationsCheck = False
		Debug.Trace("MilkModEconomy 3J Breastfeeding animations NOT found")
	endif
	
	;selfdiagnostic
	;general check to see if this script working at all and mod have launched, will not launch if milkq and plguins return errors
	;if not, more detailed info on broken scripts will be shown by MME_Status.MilkPluginsInfo()
	StorageUtil.SetIntValue(MilkQ.PlayerRef, "MME_ScriptsStarted", 1)
	Debug.Trace("MilkModEconomy status set to " + StorageUtil.GetIntValue(MilkQ.PlayerRef, "MME_ScriptsStarted") + ", should be 1")
	Debug.Trace("MilkModEconomy maintenance done")
EndFunction

Function RegisterEvents()
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	MilkQ.DDi.RegisterForModEvent("DeviceVibrateEffectStart", "OnVibrateStart")
	
	self.RegisterForModEvent("MME_AddMilkMaid", "onMME_AddMilkMaid")
	self.RegisterForModEvent("MME_AddMilkSlave", "onMME_AddMilkSlave")
	self.RegisterForModEvent("MME_Milking", "onMME_Milking")
	self.RegisterForModEvent("OrgasmStart", "OnSexLabOrgasm")
	self.RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
	self.RegisterForModEvent("StageStart", "OnSexLabStart")
	self.RegisterForModEvent("AnimationStart", "OnSexLabStart")
	self.RegisterForModEvent("AnimationEnd", "OnSexLabEnd")
	self.RegisterForModEvent("SlaveToggle", "OnSlaveToggle")
	Debug.Trace("MilkModEconomy Registered events")
EndFunction

