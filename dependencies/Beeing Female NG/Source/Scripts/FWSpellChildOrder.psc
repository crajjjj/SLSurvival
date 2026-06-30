Scriptname FWSpellChildOrder extends ActiveMagicEffect


{ Area Type: 0 = same Location; 1 = all}
int property AreaType = 0 auto

{ TeleportTo: 0 = don't teleport; 1 = to caster; 2 = to spoon; 3 = to home; 4 = to meet point }
int property TeleportTo = 0 auto

{ the Order the child should have }
; aliceqwer2718: Currently Order_ID = 31. For any other values, refer to the CustomChildOrderSet below for the child that are just copies of parents' actorbase.
int property Order_ID = 0 auto



Quest Property BF_ChildDialPlayerChildren Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	; Get the Child Setting Quest to read spoon / house / meet point / ...
	Quest q = none
	if TeleportTo>1
		q = BF_ChildDialPlayerChildren
	endif
	
	; Go throw all babys
	int c = StorageUtil.FormListCount(none,"FW.Babys")
	while c > 0
		c-=1
;		FWChildActor ca = StorageUtil.FormListGet(none, "FW.Babys", c) as FWChildActor
		
		Actor myChild = StorageUtil.FormListGet(none, "FW.Babys", c) as Actor
		FWChildActor ca = myChild as FWChildActor
		
;		if ca!=none
		if(ca && !ca.IsDead())
			; Check if the the caster is a parent of the child
			if(StorageUtil.GetFormValue(ca, "FW.Child.Mother") == akCaster || StorageUtil.GetFormValue(ca, "FW.Child.Father") == akCaster)
				if(AreaType == 1 || ca.IsInLocation(akCaster.GetCurrentLocation()))
					if(TeleportTo == 1)
						ca.MoveTo(akCaster)
					elseif(TeleportTo == 2 && q!=none)
						TeleportTo(ca, q, "PlayerHome")
					elseif(TeleportTo == 3 && q!=none)
						TeleportTo(ca, q, "OtherParent")
					elseif(TeleportTo == 4 && q!=none)
						TeleportTo(ca, q, "MeetPoint")
					endif
					ca.Order = Order_ID
					ca.EvaluatePackage()
				endif
			endif
		elseif(myChild && !myChild.IsDead())
			Actor Mother = StorageUtil.GetFormValue(myChild, "FW.Child.Mother") as Actor
			Actor Father = StorageUtil.GetFormValue(myChild, "FW.Child.Father") as Actor
			
			if((Mother == akCaster) || (Father == akCaster))
				if((AreaType == 1) || (myChild.IsInLocation(akCaster.GetCurrentLocation())))
					if(TeleportTo == 1)
						myChild.MoveTo(akCaster)
					elseif((TeleportTo == 2) && (q != none))
						TeleportTo(myChild, q, "PlayerHome")
					elseif((TeleportTo == 3) && (q != none))
						TeleportTo(myChild, q, "OtherParent")
					elseif((TeleportTo == 4) && (q != none))
						TeleportTo(myChild, q, "MeetPoint")
					endif
					
					CustomChildOrderSet(myChild, akCaster, Mother, Father, Order_ID)
					myChild.EvaluatePackage()
				endif
			endif			
		endif
	endwhile
EndEvent

function TeleportTo(Actor c, quest q, string AliasName)
	alias a = q.GetAliasByName(AliasName)
	if(a!=none)
		ReferenceAlias ra = a as ReferenceAlias
		LocationAlias la = a as LocationAlias
		if(ra != none)
			c.MoveTo(ra.GetRef())
		;elseif(la != none)
			;FW_log.WriteLog("Failed to teleport child '" + c.GetDisplayName() + "' - Not possible to teleport to an LocationAlias")
			;c.MoveToInteractionLocation(la.GetLocation())
		else
			FW_log.WriteLog("FWSpellChildOrder - TeleportTo: Failed to teleport child '" + c.GetDisplayName() + "' - No validate alias")
		endif
	else
		FW_log.WriteLog("FWSpellChildOrder - TeleportTo: Failed to teleport child '" + c.GetDisplayName() + "' - Unknown alias")
	endif
endfunction


function CustomChildOrderSet(Actor myChild, Actor myPC, Actor Mother, Actor Father, int value)
	if(value >= 0)
		; Wait Orders
		if(value < 2)
			CustomChildRefreshAI(myChild, value)
		else
			; GoTo Orders
			if(value == 10)
				CustomChildOrder_FollowAndPlayOther(myPC, myChild, Mother, Father)
			else
				; Follow Orders
				if((value >= 30) && (value < 32))
					if(value == 30)
						if((Mother == myPC) || (Father == myPC))
							CustomChildOrder_Follow(myChild)
						endif
					else;if value==31
						if((Mother == myPC) || (Father == myPC))
							CustomChildOrder_FollowAndPlay(myPC, myChild, myPC)
						endif
					endIf			
				else
					if(value == 99)
						CustomChildOrder_LeaveMeAlone(myChild)
					else
						CustomChildRefreshAI(myChild, value)
					endIf
				endIf
			endIf
		endIf	
	else
		CustomChildRefreshAI(myChild, value)
	endif
endFunction

function CustomChildOrder_FollowAndPlay(Actor myPC, Actor myChild, Actor ActorToFollow = none)
	int _order
	
	if(ActorToFollow == none)
		ActorToFollow = myPC
	endIf
	If(ActorToFollow == myPC)
		_order = 31
		myChild.SetPlayerTeammate()
	else
		_order = 10
	endif

	CustomChildRefreshAI(myChild, _order)
endfunction

function CustomChildOrder_FollowAndPlayOther(Actor myPC, Actor myChild, Actor Mother, Actor Father)
	if((Mother == myPC) && (Father != none))
		CustomChildOrder_FollowAndPlay(myPC, myChild, Father)
	elseif(Mother != none)
		CustomChildOrder_FollowAndPlay(myPC, myChild, Mother)
	endif
endFunction

; Follow / Follow other parent
function CustomChildOrder_Follow(Actor myChild)
	int _order = 30
	CustomChildRefreshAI(myChild, _order)
endfunction

function CustomChildOrder_LeaveMeAlone(Actor myChild)
	int _order = 99
	CustomChildRefreshAI(myChild, _order)
	CustomChildDeleteChild(myChild)
endFunction

function CustomChildDeleteChild(Actor myChild)
	if(myChild)
		myChild.RemoveFromAllFactions()
		myChild.AllowPCDialogue(false)

		if(myChild.IsOnMount())
			myChild.Dismount()
		endif
		
		myChild.Disable(true)
		CustomChildDeleteStats(myChild)
		StorageUtil.FormListRemove(none, "FW.Babys", myChild)
		myChild.Delete()
	endif	
endFunction

function CustomChildDeleteStats(Actor myChild)
	StorageUtil.UnsetStringValue(myChild, "FW.Child.Name")
	StorageUtil.UnsetFormValue(myChild, "FW.Child.Mother")
	StorageUtil.UnsetFormValue(myChild, "FW.Child.Father")

	StorageUtil.SetIntValue(myChild, "FW.Child.DispelledCustomChildActor", 0)
	StorageUtil.UnsetIntValue(myChild, "FW.Child.DispelledCustomChildActor")
endFunction

function CustomChildRefreshAI(Actor myChild, int _order)
	if((_order < 30) || (_order >= 50))
		myChild.SetActorValue("WaitingForPlayer", 1)
		myChild.SetPlayerTeammate(false)
	else
		myChild.SetActorValue("WaitingForPlayer", 0)
		myChild.SetPlayerTeammate(true)
	endif
	
	myChild.SetActorValue("JumpingBonus", _order)
	StorageUtil.SetIntValue(myChild, "FW.Child.Order", _order)
	myChild.EnableAI(false)
	myChild.EvaluatePackage()
	myChild.EnableAI(true)
endFunction
