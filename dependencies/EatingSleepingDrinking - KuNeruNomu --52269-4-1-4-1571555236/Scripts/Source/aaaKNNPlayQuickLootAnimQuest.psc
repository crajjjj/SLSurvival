Scriptname aaaKNNPlayQuickLootAnimQuest extends Quest

Spell Property aaaKNNPlayPerkChestCrouchingBaseSpellQL auto
Spell Property aaaKNNPlayPerkChestCrouchingBaseSpellQLIns auto
Spell Property aaaKNNPlayPerkChestCrouchingACTIChestSpellQL auto
Spell Property aaaKNNPlayPerkChestCrouchingACTIChestSpellQLIns auto
Spell Property aaaKNNPlayPerkChestCrouchSneakBaseSpellQL auto
Spell Property aaaKNNPlayPerkChestCrouchSneakBaseSpellQLIns auto
Spell Property aaaKNNPlayPerkChestCrouchSneakACTIChestSpellQL auto
Spell Property aaaKNNPlayPerkChestCrouchSneakACTIChestSpellQLIns auto
Spell Property aaaKNNPlayPerkChestHunchingSpellQL auto
Spell Property aaaKNNPlayPerkChestHunchingSpellQLIns auto
Spell Property aaaKNNPlayPerkChestHunchSneakSpellQL auto
Spell Property aaaKNNPlayPerkChestHunchSneakSpellQLIns auto
Spell Property aaaKNNPlayPerkChestStandingSpellQL auto
Spell Property aaaKNNPlayPerkChestStandingSpellQLIns auto
Spell Property aaaKNNPlayPerkChestStandSneakSpellQL auto
Spell Property aaaKNNPlayPerkChestStandSneakSpellQLIns auto
Spell Property aaaKNNPlayPerkChestOnTipToeSpellQL auto
Spell Property aaaKNNPlayPerkChestOnTipToeSpellQLIns auto
Spell Property aaaKNNPlayPerkChestSneakOnTipToeSpellQL auto
Spell Property aaaKNNPlayPerkChestSneakOnTipToeSpellQLIns auto
Event ActivateChestForQL(Actor akActor, float offsetPosZ, bool IsChest, bool IsInstant, bool IsActorSneaking)
	;Debug.Notification("offsetPosZ : " + offsetPosZ)
	float offset = 0.0
	if IsChest
		offset = 25.0
	endIf
	if offsetPosZ < 20.0
		if IsChest
			if !IsInstant
				if !IsActorSneaking
					aaaKNNPlayPerkChestCrouchingACTIChestSpellQL.Cast(akActor)
				else
					aaaKNNPlayPerkChestCrouchSneakACTIChestSpellQL.Cast(akActor)
				endIf
			else
				if !IsActorSneaking
					;Debug.Notification("aaaKNNPlayPerkChestCrouchingACTIChestSpellQLIns")
					aaaKNNPlayPerkChestCrouchingACTIChestSpellQLIns.Cast(akActor)
				else
					aaaKNNPlayPerkChestCrouchSneakACTIChestSpellQLIns.Cast(akActor)
				endIf
			endIf
		else
			if !IsActorSneaking
				if !IsInstant
					aaaKNNPlayPerkChestCrouchingBaseSpellQL.Cast(akActor)
				else
					aaaKNNPlayPerkChestCrouchingBaseSpellQLIns.Cast(akActor)
				endIf
			else
				if !IsInstant
					aaaKNNPlayPerkChestCrouchSneakBaseSpellQL.Cast(akActor)
				else
					aaaKNNPlayPerkChestCrouchSneakBaseSpellQLIns.Cast(akActor)
				endIf
			endIf
		endIf
	elseIf offsetPosZ < 35.0
		if !IsActorSneaking
			if !IsInstant
				aaaKNNPlayPerkChestHunchingSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestHunchingSpellQLIns.Cast(akActor)
			endIf
		else
			if !IsInstant
				aaaKNNPlayPerkChestHunchSneakSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestHunchSneakSpellQLIns.Cast(akActor)
			endIf	
		endIf
	elseIf offsetPosZ <= 65 + offset
		if !IsActorSneaking
			if !IsInstant
				aaaKNNPlayPerkChestStandingSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestStandingSpellQLIns.Cast(akActor)
			endIf
		else
			if !IsInstant
				aaaKNNPlayPerkChestStandSneakSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestStandSneakSpellQLIns.Cast(akActor)
			endIf
		endIf
	else
		if !IsActorSneaking
			if !IsInstant
				aaaKNNPlayPerkChestOnTipToeSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestOnTipToeSpellQLIns.Cast(akActor)
			endIf
		else
			if !IsInstant
				aaaKNNPlayPerkChestSneakOnTipToeSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestSneakOnTipToeSpellQLIns.Cast(akActor)
			endIf
		endIf
	endIf
EndEvent

Event ActivateSackMiscForQL(Actor akActor, float offsetPosZ, bool IsInstant, bool IsActorSneaking)
	if offsetPosZ > 120.0
		if !IsActorSneaking
			if !IsInstant
				aaaKNNPlayPerkChestOnTipToeSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestOnTipToeSpellQLIns.Cast(akActor)
			endIf
		else
			if !IsInstant
				aaaKNNPlayPerkChestSneakOnTipToeSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestSneakOnTipToeSpellQLIns.Cast(akActor)
			endIf
		endIf
	elseIf offsetPosZ > 70.0
		if !IsActorSneaking
			if !IsInstant
				aaaKNNPlayPerkChestStandingSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestStandingSpellQLIns.Cast(akActor)
			endIf
		else
			if !IsInstant
				aaaKNNPlayPerkChestStandSneakSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestStandSneakSpellQLIns.Cast(akActor)
			endIf
		endIf
	elseIf offsetPosZ > 30.0
		if !IsActorSneaking
			if !IsInstant
				aaaKNNPlayPerkChestHunchingSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestHunchingSpellQLIns.Cast(akActor)
			endIf
		else
			if !IsInstant
				aaaKNNPlayPerkChestHunchSneakSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestHunchSneakSpellQLIns.Cast(akActor)
			endIf
		endIf
	else
		if !IsActorSneaking
			if !IsInstant
				aaaKNNPlayPerkChestCrouchingBaseSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestCrouchingBaseSpellQLIns.Cast(akActor)
			endIf
		else
			if !IsInstant
				aaaKNNPlayPerkChestCrouchSneakBaseSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestCrouchSneakBaseSpellQLIns.Cast(akActor)
			endIf
		endIf
	endIf
EndEvent

Event ActivateBarrelForQL(Actor akActor, float offsetPosZ, bool IsBarrelLean, bool IsInstant, bool IsActorSneaking)
	;Debug.Notification("ActivateChestQL")
	if !IsBarrelLean
		if offsetPosZ < -80.0
			if !IsActorSneaking
				if !IsInstant
					aaaKNNPlayPerkChestCrouchingBaseSpellQL.Cast(akActor)
				else
					aaaKNNPlayPerkChestCrouchingBaseSpellQLIns.Cast(akActor)
				endIf
			else
				if !IsInstant
					aaaKNNPlayPerkChestCrouchSneakBaseSpellQL.Cast(akActor)
				else
					aaaKNNPlayPerkChestCrouchSneakBaseSpellQLIns.Cast(akActor)
				endIf
			endIf
		elseIf offsetPosZ <= 80.0
			if !IsActorSneaking
				if !IsInstant
					aaaKNNPlayPerkChestStandingSpellQL.Cast(akActor)
				else
					aaaKNNPlayPerkChestStandingSpellQLIns.Cast(akActor)
				endIf
			else
				if !IsInstant
					aaaKNNPlayPerkChestStandSneakSpellQL.Cast(akActor)
				else
					aaaKNNPlayPerkChestStandSneakSpellQLIns.Cast(akActor)
				endIf
			endIf
		else
			if !IsActorSneaking
				if !IsInstant
					aaaKNNPlayPerkChestOnTipToeSpellQL.Cast(akActor)
				else
					aaaKNNPlayPerkChestOnTipToeSpellQLIns.Cast(akActor)
				endIf
			else
				if !IsInstant
					aaaKNNPlayPerkChestSneakOnTipToeSpellQL.Cast(akActor)
				else
					aaaKNNPlayPerkChestSneakOnTipToeSpellQLIns.Cast(akActor)
				endIf
			endIf
		endIf
	else
		if offsetPosZ < 0.0
			if !IsActorSneaking
				if !IsInstant
					aaaKNNPlayPerkChestCrouchingBaseSpellQL.Cast(akActor)
				else
					aaaKNNPlayPerkChestCrouchingBaseSpellQLIns.Cast(akActor)
				endIf
			else
				if !IsInstant
					aaaKNNPlayPerkChestCrouchSneakBaseSpellQL.Cast(akActor)
				else
					aaaKNNPlayPerkChestCrouchSneakBaseSpellQLIns.Cast(akActor)
				endIf
			endIf
		elseIf offsetPosZ < 40.0
			if !IsActorSneaking
				if !IsInstant
					aaaKNNPlayPerkChestHunchingSpellQL.Cast(akActor)
				else
					aaaKNNPlayPerkChestHunchingSpellQLIns.Cast(akActor)
				endIf
			else
				if !IsInstant
					aaaKNNPlayPerkChestHunchSneakSpellQL.Cast(akActor)
				else
					aaaKNNPlayPerkChestHunchSneakSpellQLIns.Cast(akActor)
				endIf
			endIf
		elseIf offsetPosZ <= 80.0
			if !IsActorSneaking
				if !IsInstant
					aaaKNNPlayPerkChestStandingSpellQL.Cast(akActor)
				else
					aaaKNNPlayPerkChestStandingSpellQLIns.Cast(akActor)
				endIf
			else
				if !IsInstant
					aaaKNNPlayPerkChestStandSneakSpellQL.Cast(akActor)
				else
					aaaKNNPlayPerkChestStandSneakSpellQLIns.Cast(akActor)
				endIf
			endIf
		else
			if !IsActorSneaking
				if !IsInstant
					aaaKNNPlayPerkChestOnTipToeSpellQL.Cast(akActor)
				else
					aaaKNNPlayPerkChestOnTipToeSpellQLIns.Cast(akActor)
				endIf
			else
				if !IsInstant
					aaaKNNPlayPerkChestSneakOnTipToeSpellQL.Cast(akActor)
				else
					aaaKNNPlayPerkChestSneakOnTipToeSpellQLIns.Cast(akActor)
				endIf
			endIf
		endIf
	endIf
EndEvent

Spell property aaaKNNPlayPerkCupBoardSpellQL auto
Spell Property aaaKNNPlayPerkCupBoardSpellQLInstant auto
Spell property aaaKNNPlayPerkCupBoardSneakSpellQL auto
Spell Property aaaKNNPlayPerkCupBoardSneakSpellQLIns auto
Event ActivateCupboardForQL(Actor akActor, bool IsInstant, bool IsActorSneaking)
	if !IsInstant
		if !IsActorSneaking
			aaaKNNPlayPerkCupBoardSpellQL.Cast(akActor)
		else
			aaaKNNPlayPerkCupBoardSneakSpellQL.Cast(akActor)
		endIf
	else
		if !IsActorSneaking
			aaaKNNPlayPerkCupBoardSpellQLInstant.Cast(akActor)
		else
			aaaKNNPlayPerkCupBoardSneakSpellQLIns.Cast(akActor)
		endIf
	endIf
EndEvent

Spell Property aaaKNNPlayPerkEndTableSpellQL auto
Spell Property aaaKNNPlayPerkEndTableSpellQLInstant auto
Spell Property aaaKNNPlayPerkEndTableSneakSpellQL auto
Spell Property aaaKNNPlayPerkEndTableSneakSpellQLIns auto
Event ActivateEndtableForQL(Actor akActor, bool IsInstant, bool IsActorSneaking)
	if !IsInstant
		if !IsActorSneaking
			aaaKNNPlayPerkEndTableSpellQL.Cast(akActor)
		else
			aaaKNNPlayPerkEndTableSneakSpellQL.Cast(akActor)
		endIf
	else
		if !IsActorSneaking
			aaaKNNPlayPerkEndTableSpellQLInstant.Cast(akActor)
		else
			aaaKNNPlayPerkEndTableSneakSpellQLIns.Cast(akActor)
		endIf
	endIf
EndEvent

Spell Property aaaKNNPlayPerkWardrobeSpellQL auto
Spell Property aaaKNNPlayPerkWardrobeSpellQLInstant auto
Spell Property aaaKNNPlayPerkWardrobeSneakSpellQL auto
Spell Property aaaKNNPlayPerkWardrobeSneakSpellQLIns auto
Event ActivateWardrobeForQL(Actor akActor, bool IsInstant, bool IsActorSneaking)
	if !IsInstant
		if !IsActorSneaking
			aaaKNNPlayPerkWardrobeSpellQL.Cast(akActor)
		else
			aaaKNNPlayPerkWardrobeSneakSpellQL.Cast(akActor)
		endIf
	else
		if !IsActorSneaking
			aaaKNNPlayPerkWardrobeSpellQLInstant.Cast(akActor)
		else
			aaaKNNPlayPerkWardrobeSneakSpellQLIns.Cast(akActor)
		endIf
	endIf
EndEvent

Spell Property aaaKNNPlayPerkChestCrouchingLootHumanSpellQL auto
Spell Property aaaKNNPlayPerkChestCrouchingLootHumanSpellQLIns auto
Spell Property aaaKNNPlayPerkChestCrouchSneakLootNPCSpellQL auto
Spell Property aaaKNNPlayPerkChestCrouchSneakLootNPCSpellQLIns auto
Spell Property aaaKNNPlayPerkChestHunchingLootSpellQL auto
Spell Property aaaKNNPlayPerkChestHunchingLootSpellQLInstant auto
Spell Property aaaKNNPlayPerkChestHunchSneakLootSpellQL auto
Spell Property aaaKNNPlayPerkChestHunchSneakLootSpellQLIns auto
Event ActivateLootForQL(Actor akActor, float offsetPosZ, bool IsInstant, bool IsActorSneaking)
	;Debug.Notification("ActivateLootForQL : " + offsetPosZ)
	if offsetPosZ < 20.0
		if !IsInstant
			if !IsActorSneaking
				aaaKNNPlayPerkChestCrouchingLootHumanSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestCrouchSneakLootNPCSpellQL.Cast(akActor)
			endIf
		else
			if !IsActorSneaking
				aaaKNNPlayPerkChestCrouchingLootHumanSpellQLIns.Cast(akActor)
			else
				aaaKNNPlayPerkChestCrouchSneakLootNPCSpellQLIns.Cast(akActor)
			endIf
		endIf
	elseIf offsetPosZ < 65.0
		if !IsInstant
			if !IsActorSneaking
				aaaKNNPlayPerkChestHunchingLootSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestHunchSneakLootSpellQL.Cast(akActor)
			endIf
		else
			if !IsActorSneaking
				aaaKNNPlayPerkChestHunchingLootSpellQLInstant.Cast(akActor)
			else
				aaaKNNPlayPerkChestHunchSneakLootSpellQLIns.Cast(akActor)
			endIf
		endIf
	elseIf offsetPosZ <= 150.0
		if !IsActorSneaking
			if !IsInstant
				aaaKNNPlayPerkChestStandingSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestStandingSpellQLIns.Cast(akActor)
			endIf
		else
			if !IsInstant
				aaaKNNPlayPerkChestStandSneakSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestStandSneakSpellQLIns.Cast(akActor)
			endIf
		endIf
	else
		if !IsActorSneaking
			if !IsInstant
				aaaKNNPlayPerkChestOnTipToeSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestOnTipToeSpellQLIns.Cast(akActor)
			endIf
		else
			if !IsInstant
				aaaKNNPlayPerkChestSneakOnTipToeSpellQL.Cast(akActor)
			else
				aaaKNNPlayPerkChestSneakOnTipToeSpellQLIns.Cast(akActor)
			endIf
		endIf
	endIf
EndEvent