scriptname FNISSM_NPCAlias extends ReferenceAlias

; This NPC alias script is started by the quest FNISSMQuest2:
; - when the quest is started ( with GetRef() = none: undesired effect, but apparantly not avoidable)
; - for the 5 closest NPCs with the following conditions
;   -female, -no child, -3d loaded, -not in combat, -playable race, -AnimVar FNISaa_mt = 0
; For those females the new move type (in FNISaa_mt) will be determined via presets or random calculation

FNISSMQuestScript Property FNISSMQuest Auto
MiscObject property FNISSMCoin Auto 
Actorbase Property PlayerHouseMannequin Auto
SoulGem Property WhiterunSoulGem Auto

event OnInit()
	if ( GetRef() != none )
		if FNISSMQuest.DebugLevel > 1
			Debug.Trace("FNISSM NPC alias: " + GetName() + " Actor: " + GetRef().GetBaseObject().GetName())
			;Debug.Notification("FNISSM NPC alias: " + GetName() + " Actor: " + GetRef().GetBaseObject().GetName())
		endIf

		FNISSMQuest.AliasCount += 1
		
		int MOVE												; the move type the character (preset or calculated)
		int iPreset = GetRef().GetItemCount(WhiterunSoulGem)	; preset by modder (number of Whiterun soul gems)
		if iPreset >= 10
			iPreset = 0
		endIf
		int iCoin = GetRef().GetItemCount(FNISSMCoin)			; the number of coins the NPC will get or loose to remember the current move type
		;Debug.Trace("FNISSM " + iCoin + " Coins " + (GetRef().GetBaseObject() as ActorBase).Getname())
		If ( iPreset != iCoin )
			If ( iPreset > 0 )
				MOVE = iPreset
			Else
				MOVE = iCoin
			endIf
			iCoin = MOVE - iCoin
		Else
			iCoin = 0
			If ( iPreset > 0 )
				MOVE = iPreset
			Else
				MOVE = FNISSMQuest.getRandomAnimation(GetRef() as Actor)	; calculat a random move type based on armor and age
				iCoin = MOVE
			endIf
		endIf

		if FNISSMQuest.DebugLevel > 0
			Debug.Trace("FNISSM MOVE " + MOVE + " " + (GetRef().GetBaseObject() as ActorBase).Getname())
			if FNISSMQuest.DebugLevel > 1
				Debug.Notification("FNISSM MOVE " + MOVE + " " + (GetRef().GetBaseObject() as ActorBase).Getname())
			endIf
		endIf
																		
		; assign the move type (see FNIS Documentation for Modders' for details)
		bool bOk
		if ( MOVE > 9 ) || ( MOVE == 0 )						; should not happen
			bOk = FNIS_aa.SetAnimGroup(GetActorRef(), "_mt", 0, 0, "FNIS Sexy Move", true)
		else
			bOk = FNIS_aa.SetAnimGroup(GetActorRef(), "_mt", FNISSMQuest.FNISsmMtBase, MOVE - 1, "FNIS Sexy Move", true)
		endIf
			if !bOk
				Debug.Trace("FNISSM - ERROR cannot set _mt animvar for " + (GetRef().GetBaseObject() as ActorBase).Getname())
			endif

		if FNISSMQuest.SMnoCoin
			iCoin = 0 - GetRef().GetItemCount(FNISSMCoin)		; no coins if user doesn't want to remember assignments
		endif
		If ( iCoin > 0 )										; assign the new number of Sexy Coins
			GetRef().AddItem(FNISSMCoin, iCoin)
		ElseIf ( iCoin < 0 )
			GetRef().RemoveItem(FNISSMCoin, -iCoin)
		endif
	endif
endEvent
