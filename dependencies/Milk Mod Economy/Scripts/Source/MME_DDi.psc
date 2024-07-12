Scriptname MME_DDi extends Quest Hidden

Event OnInit()
	StorageUtil.SetIntValue(none,"MME.PluginsCheck.ddi",2)
EndEvent

bool Function IsIntegraged ()
	Return True
EndFunction

bool Function IsWearingDDMilker(Actor akActor)
	form f
	zadLibs Libs = Quest.GetQuest("zadQuest") as zadLibs
	Armor scriptinstance
	int i = akActor.getnumitems()									;count all items in inventory
	While i > 0
		i -= 1
		f = akActor.getnthform(i) as armor							;filter armor in inventory
		If f != none
			If f.HasKeyword(Libs.zad_InventoryDevice)				;check if armor is DD
				scriptinstance = Libs.GetRenderedDevice(f as armor)		;get armor scriptinstance, has dd keywords
				if akActor.isequipped(f) && (StringUtil.Find(f.getname(), "Milk" ) >= 0 || Libs.HasTag(f as armor, "milk"))
					If  scriptinstance.HasKeyword(Libs.zad_DeviousBra)			;"Milk" Bra
						Return true
					ElseIf  scriptinstance.HasKeyword(Libs.zad_DeviousHarness)	;"Milk" Harness
						Return true
					Endif
				Endif
			EndIf
		EndIf
	endwhile
	Return false
EndFunction

bool Function IsWearingGag (Actor akActor)
	zadLibs Libs = Quest.GetQuest("zadQuest") as zadLibs
	Return akActor.WornHasKeyword(Libs.zad_DeviousGag)
EndFunction

bool Function IsWearingGag_Open (Actor akActor)	;oral permitted
	Bool IsMilkingBlocked = false
	zadLibs Libs = Quest.GetQuest("zadQuest") as zadLibs
	if akActor.WornHasKeyword(Libs.zad_DeviousGag) && akActor.WornHasKeyword(Libs.zad_PermitOral)
		IsMilkingBlocked = true
	endif
	Return IsMilkingBlocked
EndFunction

bool Function IsWearingBelt (Actor akActor)
	zadLibs Libs = Quest.GetQuest("zadQuest") as zadLibs
	Return akActor.WornHasKeyword(Libs.zad_DeviousBelt)
EndFunction

bool Function IsWearingBelt_Open (Actor akActor)
	Bool IsMilkingBlocked = false
	zadLibs Libs = Quest.GetQuest("zadQuest") as zadLibs
	if akActor.WornHasKeyword(Libs.zad_DeviousBelt) && akActor.WornHasKeyword(Libs.zad_PermitAnal)
		IsMilkingBlocked = true
	endif
	Return IsMilkingBlocked
EndFunction

bool Function IsMilkingBlocked_Bra (Actor akActor)
	zadLibs Libs = Quest.GetQuest("zadQuest") as zadLibs
	Return akActor.WornHasKeyword(Libs.zad_DeviousBra)
EndFunction

bool Function IsMilkingBlocked_Armbinder (Actor akActor)
	zadLibs Libs = Quest.GetQuest("zadQuest") as zadLibs
	Return akActor.WornHasKeyword(Libs.zad_DeviousArmbinder)
EndFunction

bool Function IsMilkingBlocked_Yoke (Actor akActor)
	zadLibs Libs = Quest.GetQuest("zadQuest") as zadLibs
	Return akActor.WornHasKeyword(Libs.zad_DeviousYoke)
EndFunction

bool Function IsMilkingBlocked_PiercingsNipple (Actor akActor)
	zadLibs Libs = Quest.GetQuest("zadQuest") as zadLibs
	Return akActor.WornHasKeyword(Libs.zad_DeviousPiercingsNipple)
EndFunction

bool Function IsMilkingBlocked_Suit (Actor akActor)
	zadLibs Libs = Quest.GetQuest("zadQuest") as zadLibs
	Return akActor.WornHasKeyword(Libs.zad_DeviousSuit)
EndFunction

bool Function IsWearingHarness (Actor akActor)
	zadLibs Libs = Quest.GetQuest("zadQuest") as zadLibs
	Return akActor.WornHasKeyword(Libs.zad_DeviousHarness)
EndFunction

;----------------------------------------------------------------------------
;DDI hooks
;----------------------------------------------------------------------------

Event OnVibrateStart(string eventName, string argString, float argNum, form sender)			;player only, cuz DD uses strings instead of formid
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	Actor akActor = Game.Getplayer()
	
	If argString == akActor.GetLeveledActorBase().GetName() && IsMilkingBlocked_PiercingsNipple(akActor) && (MilkQ.akActorSex(akActor) == "Female" || MilkQ.akActorSex(akActor) == "Futa" || (MilkQ.akActorSex(akActor) == "Male" && MilkQ.MaleMaids))
		float MilkCnt = MME_Storage.getMilkCurrent(akActor)
		int gush = (MilkCnt*MilkQ.GushPct/100) as int
		String MaidName = akActor.GetLeveledActorBase().getname()
		
		if gush < 1
			gush = 1
		endif
		
		if StorageUtil.GetFloatValue(akActor, "MME.MilkMaid.MilkGen") == 0 
			if Utility.RandomInt(0, 100) < 5
				Debug.Notification(MilkQ.formatString(JsonUtil.GetStringValue("/MME/Strings", "lactationstart"), MaidName))
				if MilkQ.MILKmaid.find(akActor) == -1				; || MilkQ.MILKSlave.find(akActor) != -1
					MilkQ.AssignSlotMaid(akActor)
					Utility.Wait( 1.0 )
				endif
				StorageUtil.AdjustFloatValue(akActor, "MME.MilkMaid.MilkGen", MilkQ.MilkGenValue/3/10 * gush)
			endif
		else																				;if MilkQ.MILKmaid.find(akActor) != -1 || MilkQ.MILKSlave.find(akActor) != -1
			StorageUtil.AdjustFloatValue(akActor, "MME.MilkMaid.MilkGen", MilkQ.MilkGenValue/3/10 * gush)
		endif
		
		If MilkCnt >= 1*gush
			MME_Storage.changeMilkCurrent(akActor, -1*gush, MilkQ.BreastScaleLimit)
			Debug.Notification(MilkQ.formatString(JsonUtil.GetStringValue("/MME/Strings", "vibrationmilkleak"), MaidName))
			MilkQ.PostMilk(akActor)
			MilkQ.AddMilkFx(akActor, 2)
			MilkQ.AddLeak(akActor)
		EndIf
	EndIf
EndEvent
