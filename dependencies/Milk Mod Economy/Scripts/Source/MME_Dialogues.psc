Scriptname MME_Dialogues Extends TopicInfo Hidden

;script wont work in CK, cuz CK is sheet, generate random empty script and use tes5edit to set correct script name and fragments

;---Contents---
;
;Function Init_Milking(Actor akActor1, Actor akActor2)	;Initiate Breastfeeding through sexlab
;
;dialogue script fragments
;Function Fragment_00(Actor akSpeakerRef)				;[MME] Hey there! opening dialogue (fill up/refresh dialogue conditions for further usage)
;Function Fragment_01(Actor akSpeakerRef)				;Breastfeeding(Player sucking milk)
;Function Fragment_02(Actor akSpeakerRef)				;Breastfeeding(Player's milk being sucked)
;Function Fragment_03(Actor akSpeakerRef)				;NPC Give milkmaid lactacid
;Function Fragment_04(Actor akSpeakerRef)				;NPC Make milkmaid
;Function Fragment_05(Actor akSpeakerRef)				;NPC Make futanari
;Function Fragment_06(Actor akSpeakerRef)				;NPC Convert milkmaid <-> milkslave
;Function Fragment_07(Actor akSpeakerRef)				;NPC Increase breast size
;Function Fragment_08(Actor akSpeakerRef)				;NPC Decrease breast size
;Function Fragment_09(Actor akSpeakerRef)				;TradeBreastEnl_Alchemy
;Function Fragment_10(Actor akSpeakerRef)				;TradeBreastRedu_Alchemy
;Function Fragment_11(Actor akSpeakerRef)				;TradeCum_Alchemy
;Function Fragment_12(Actor akSpeakerRef)				;TradeLactacid_Alchemy
;Function Fragment_13(Actor akSpeakerRef)				;TradeLactacid_Farmer
;Function Fragment_14(Actor akSpeakerRef)				;TradeLactacid_Khajiit
;Function Fragment_15(Actor akSpeakerRef)				;TradeMilk_Alchemy
;Function Fragment_16(Actor akSpeakerRef)				;TradeMilk_Farmer
;Function Fragment_17(Actor akSpeakerRef)				;TradeMilk_Fence
;Function Fragment_18(Actor akSpeakerRef)				;TradeMilk_Inn
;Function Fragment_19(Actor akSpeakerRef)				;TradeMilk_Khajiit
;Function Fragment_20(Actor akSpeakerRef)				;TradeMilk_Orc
;Function Fragment_21(Actor akSpeakerRef)				;TradeLactacid_Alchemy x10
;Function Fragment_22(Actor akSpeakerRef)				;TradeLactacid_Farmer x10
;
;duplicate fragments used in different dialogues
;can be changed later to have different outcome
;
;Fragment_03,Fragment_04
;Fragment_12,Fragment_13
;Fragment_17,Fragment_19
;Fragment_21,Fragment_22
;
;------

Function Init_Milking(Actor akActor1, Actor akActor2)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	
	actor[] sexActors = new actor[2]
	sslBaseAnimation[] anims
	anims = new sslBaseAnimation[1]

	;sexActors[]: 0 - actor being sucked, 1 - actor sucking
	;sexActors[0] / akActor1 should probably never be male, but w/e
	;if akActor1.GetActorBase().GetSex() == 0 && akActor2.GetActorBase().GetSex() == 0
	;	Debug.Notification(JsonUtil.GetStringValue("/MME/Strings", "MilkingGayWarning"))
	;	return
	;else
		sexActors[0] = akActor1
		sexActors[1] = akActor2
	;endif

	if sexActors[1].GetLeveledActorBase().GetSex() == 0 || ((MilkQ.akActorSex(sexActors[1]) == "Futa") && Utility.RandomInt(1, 2) == 1)
		anims[0] = MilkQ.SexLab.AnimSlots.GetbyRegistrar("zjBreastFeedingVar")		;Straight
	else
		anims[0] = MilkQ.SexLab.AnimSlots.GetbyRegistrar("zjBreastFeeding")			;Lesbian
	endif

	MilkQ.SexLab.StartSex(sexActors, anims)
EndFunction

;----------------------------------------------------------------------------------------------------
;
;Script Fragments
;
;----------------------------------------------------------------------------------------------------

Function Fragment_00(ObjectReference akSpeakerRef)
MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
;GetSex(): 0 - male, 1 - female
;Debug.Notification("[MME] Hey there! dialogue script(fill up dialogues conditions)")
	Actor akSpeaker = akSpeakerRef as Actor
	
;MilkQ.MilkQC Dialogue Variables reset
	MilkQ.MilkQC.MME_TargetMilk = 0
	MilkQ.MilkQC.MME_SubjectMilk = 0
	MilkQ.MilkQC.MME_CanbeconvertedfromSlaveToMaid = 0
	MilkQ.MilkQC.MME_CanBeConvertedFromMaidToSlave = 0
	MilkQ.MilkQC.MME_FreeMaidSlots = 0
	MilkQ.MilkQC.MME_SubjectMaid = false
	MilkQ.MilkQC.MME_SubjectSlave = false

;checks pc milk
	if Game.Getplayer().GetLeveledActorBase().GetSex() == 1 || (Game.Getplayer().GetLeveledActorBase().GetSex() == 0 && MilkQ.MaleMaids)
		MilkQ.MilkQC.MME_TargetMilk = MME_Storage.getMilkCurrent(Game.Getplayer())
	endif

	if akSpeaker.GetLeveledActorBase().GetSex() == 1 || (akSpeaker.GetLeveledActorBase().GetSex() == 0 && MilkQ.MaleMaids)
;checks if npc has string "Milkslave" or "Milkmaid", "Milk slave" or "Milk maid", "Cow" in its name and make it milkslave if it is
		if MilkQ.IsNamedMaid(akSpeaker) != 0 && MilkQ.MILKSlave.Find(none) != -1 && MilkQ.MILKSlave.Find(akSpeaker) == -1 && MilkQ.MilkMaid.Find(akSpeaker) == -1 && MilkQ.DialogueForceMilkSlave
			MilkQ.AssignSlotSlave(akSpeaker, 0, Utility.RandomInt(4))
		endif
	
;checks if player have free maidslots
		if MilkQ.MILKmaid.Find(none,1) <= MilkQ.Milklvl0fix() && MilkQ.MILKmaid.Find(none,1) > 0
			MilkQ.MilkQC.MME_FreeMaidSlots = 1
		else
			MilkQ.MilkQC.MME_FreeMaidSlots = 0
		endif


;checks if npc can be transferred from slave to maid
		if MilkQ.MILKSlave.Find(akSpeaker) != -1
			MilkQ.MilkQC.MME_SubjectSlave = true
			if MilkQ.MilkQC.Debug_enabled == 1
				int i = 1
				int count = 0
				While i < MilkQ.MilkMaid.Length && MilkQ.Milklvl0fix() > count
					If MilkQ.MilkMaid[i] == None
						count = count + 1
					EndIf
					i = i + 1
				EndWhile
				If MilkQ.MILKmaid.Find(none,1) != -1 || count == 0
					MilkQ.MilkQC.MME_CanbeconvertedfromSlaveToMaid = 1
				Endif
			endif
		endif

;checks if npc can be transferred from maid to slave
		if MilkQ.MilkMaid.Find(akSpeaker) != -1
			MilkQ.MilkQC.MME_SubjectMaid = true
			if MilkQ.MilkQC.Debug_enabled == 1
				If MilkQ.MILKSlave.Find(none,1) != -1
					MilkQ.MilkQC.MME_CanBeConvertedFromMaidToSlave = 1
				Endif
			endif
		endif

;checks npc milk
		MilkQ.MilkQC.MME_SubjectMilk = MME_Storage.getMilkCurrent(akSpeaker)
		
		if MilkQ.IsNamedMaid(akSpeaker) != 0 && MilkQ.MilkQC.MME_SubjectMilk == 0
			MilkQ.MilkQC.MME_SubjectMilk = Utility.RandomInt(4)
		endif
	endif
EndFunction

Function Fragment_01(ObjectReference akSpeakerRef)
	Actor akSpeaker = akSpeakerRef as Actor
	Init_Milking(akSpeakerRef as actor, Game.Getplayer())
EndFunction

Function Fragment_02(ObjectReference akSpeakerRef)
	Actor akSpeaker = akSpeakerRef as Actor
	Init_Milking(Game.Getplayer(), akSpeakerRef as actor)
EndFunction

Function Fragment_03(ObjectReference akSpeakerRef)
	Actor akSpeaker = akSpeakerRef as Actor
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	akSpeaker.EquipItem(MilkQ.MME_Util_Potions.GetAt(0))
	Game.Getplayer().RemoveItem(MilkQ.MME_Util_Potions.GetAt(0), 1)
EndFunction

Function Fragment_04(ObjectReference akSpeakerRef)
	Actor akSpeaker = akSpeakerRef as Actor
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	akSpeaker.EquipItem(MilkQ.MME_Util_Potions.GetAt(0))
	Game.Getplayer().RemoveItem(MilkQ.MME_Util_Potions.GetAt(0), 1)
EndFunction

Function Fragment_05(ObjectReference akSpeakerRef)
	Actor akSpeaker = akSpeakerRef as Actor
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	akSpeaker.EquipItem(MilkQ.MME_Cums.GetAt(3))
	Game.Getplayer().RemoveItem(MilkQ.MME_Cums.GetAt(3), 1)
EndFunction

Function Fragment_06(ObjectReference akSpeakerRef)
	Actor akSpeaker = akSpeakerRef as Actor
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	if MilkQ.MilkQC.MME_CanBeConvertedFromMaidToSlave == 1					;MilkModEconomy transfer from milkmaid to milkslave dialogue script
		MilkQ.AssignSlotMaidToSlave(akSpeaker)
	elseif MilkQ.MilkQC.MME_CanbeconvertedfromSlaveToMaid == 1				;MilkModEconomy transfer from milkslave to milkmaid dialogue script
		MilkQ.AssignSlotSlaveToMaid(akSpeaker)
	endif
EndFunction

Function Fragment_07(ObjectReference akSpeakerRef)
	Actor akSpeaker = akSpeakerRef as Actor
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	akSpeaker.EquipItem(MilkQ.MME_Util_Potions.GetAt(1))
	Game.Getplayer().RemoveItem(MilkQ.MME_Util_Potions.GetAt(1), 1)
EndFunction

Function Fragment_08(ObjectReference akSpeakerRef)
	Actor akSpeaker = akSpeakerRef as Actor
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	akSpeaker.EquipItem(MilkQ.MME_Util_Potions.GetAt(2))
	Game.Getplayer().RemoveItem(MilkQ.MME_Util_Potions.GetAt(2), 1)
EndFunction

Function Fragment_09(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	Game.Getplayer().additem(MilkQ.MME_Util_Potions.GetAt(1), 1)
	Game.Getplayer().removeitem(JsonUtil.GetFormValue("/MME/Forms", "gold") as MiscObject, 1000, true)
EndFunction

Function Fragment_10(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	Game.Getplayer().additem(MilkQ.MME_Util_Potions.GetAt(2), 1)
	Game.Getplayer().removeitem(JsonUtil.GetFormValue("/MME/Forms", "gold") as MiscObject, 1000, true)
EndFunction

Function Fragment_11(ObjectReference akSpeakerRef)
	int i = 0
	int gold = 0
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	if Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)) > 0
		gold = gold + (MilkQ.MME_Cums.GetAt(i) as Potion).GetGoldValue() * Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i))
		Game.Getplayer().removeitem(MilkQ.MME_Cums.GetAt(i), Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)))
	endif
	i = i + 1
	if Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)) > 0
		gold = gold + (MilkQ.MME_Cums.GetAt(i) as Potion).GetGoldValue() * Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i))
		Game.Getplayer().removeitem(MilkQ.MME_Cums.GetAt(i), Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)))
	endif
	i = i + 1
	if Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)) > 0
		gold = gold + (MilkQ.MME_Cums.GetAt(i) as Potion).GetGoldValue() * Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)) * 2
		Game.Getplayer().removeitem(MilkQ.MME_Cums.GetAt(i), Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)))
	endif
	i = i + 1
	if Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)) > 0
		gold = gold + (MilkQ.MME_Cums.GetAt(i) as Potion).GetGoldValue() * Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)) * 2
		Game.Getplayer().removeitem(MilkQ.MME_Cums.GetAt(i), Game.Getplayer().GetItemCount(MilkQ.MME_Cums.GetAt(i)))
	endif

	Game.Getplayer().additem(JsonUtil.GetFormValue("/MME/Forms", "gold") as MiscObject, gold, true)
EndFunction

Function Fragment_12(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	Game.Getplayer().additem(MilkQ.MME_Util_Potions.GetAt(0), 1)
	Game.Getplayer().removeitem(JsonUtil.GetFormValue("/MME/Forms", "gold") as MiscObject, 100, true)
EndFunction

Function Fragment_13(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	Game.Getplayer().additem(MilkQ.MME_Util_Potions.GetAt(0), 1)
	Game.Getplayer().removeitem(JsonUtil.GetFormValue("/MME/Forms", "gold") as MiscObject, 100, true)
EndFunction

Function Fragment_14(ObjectReference akSpeakerRef)
	int i = 0
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	while i < MilkQ.MME_Milks.GetSize()
		if Game.Getplayer().GetItemCount(MilkQ.MME_Milks.GetAt(i)) > 0
			Game.Getplayer().removeitem(MilkQ.MME_Milks.GetAt(i))
			Game.Getplayer().additem(MilkQ.MME_Util_Potions.GetAt(0), 1)
			return
		endif
		i = i + 1
	endwhile
EndFunction

Function Fragment_15(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	MilkQ.MilkE.InitiateDialogueTrade(Game.Getplayer(), 4)
EndFunction

Function Fragment_16(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	MilkQ.MilkE.InitiateDialogueTrade(Game.Getplayer(), 1)
EndFunction

Function Fragment_17(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	MilkQ.MilkE.InitiateDialogueTrade(Game.Getplayer(), 5)
EndFunction

Function Fragment_18(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	MilkQ.MilkE.InitiateDialogueTrade(Game.Getplayer(), 2)
EndFunction

Function Fragment_19(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	MilkQ.MilkE.InitiateDialogueTrade(Game.Getplayer(), 3)
EndFunction

Function Fragment_20(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	MilkQ.MilkE.InitiateDialogueTrade(Game.Getplayer(), 3)
EndFunction

Function Fragment_21(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	Game.Getplayer().additem(MilkQ.MME_Util_Potions.GetAt(0), 10)
	Game.Getplayer().removeitem(JsonUtil.GetFormValue("/MME/Forms", "gold") as MiscObject, 1000, true)
EndFunction

Function Fragment_22(ObjectReference akSpeakerRef)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	Game.Getplayer().additem(MilkQ.MME_Util_Potions.GetAt(0), 10)
	Game.Getplayer().removeitem(JsonUtil.GetFormValue("/MME/Forms", "gold") as MiscObject, 1000, true)
EndFunction

