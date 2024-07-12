Scriptname SLV_ThalmorChoppingBlockAliasScript extends ReferenceAlias  
{
- This script hooks up the two people in the head chop block furniture and makes them play the chop animation together.
BM Note: adapted from vanilla script to allow player to be executed as well.
}

import utility
import Debug

ObjectReference executionerActor = None
ObjectReference executioneeActor = None
ObjectReference executionGuardActor = None

Spell Property TiedUpPrisonerTracker Auto

Idle property IdleHeadChop auto
{This is the idle that the executionee will play when everything is ready.}

Keyword property executionerKeyword auto
{The keyword that designates the executioner from the soon to be dead.}

Keyword property executionGuardKeyword auto
{The keyword that designates the executioner from the soon to be dead.}

SLV_Utilities Property myScripts auto


;*****************************************

auto STATE readyToChop

Event OnActivate( ObjectReference akActionRef )
	if(akActionRef.HasKeyword(executionerKeyword))
		executionerActor = akActionRef
		myScripts.SLV_DisplayInformation("executionerActor has been set")
	elseif(akActionRef.HasKeyword(executionGuardKeyword))
		executionGuardActor = akActionRef	
		myScripts.SLV_DisplayInformation("executionGuardActor has been set")
	else
		if(akActionRef == Game.GetPlayer())
			Game.ForceFirstPerson()
		endif
		(akActionRef as Actor).SetRestrained(true)
		(akActionRef as Actor).GetActorBase().SetEssential(false)
		(akActionRef as Actor).RemoveSpell(TiedUpPrisonerTracker)	
		executioneeActor = akActionRef
		myScripts.SLV_DisplayInformation("executioneeActor has been set")
	endif
	
	;if it's ready, then do the chop!
	if (executioneeActor != none && executionerActor != none && executionGuardActor != none)
		gotoState("chopping")
		myScripts.SLV_DisplayInformation("starting chopping anim now")
		RegisterForSingleUpdate(0.5)
	endif
endEvent

endState

STATE chopping
	; do nothing for now
endState

Event OnUpdate() 
	;if it's ready, then do the chop!
	if ( executioneeActor != none && executionerActor != none)		
		myScripts.SLV_DisplayInformation("CHOPPING START" )
		wait(0.5)

		;set up the relationship
		if ( !executioneeActor.AddDependentAnimatedObjectReference( executionerActor ) || !executioneeActor.AddDependentAnimatedObjectReference( executionGuardActor ) )
			myScripts.SLV_DisplayInformation("dependence broken." )
		endif
		
		;play the idle and wait..
		Actor myExecutionee = executioneeActor as Actor
		Actor myExecutioner = executionerActor as Actor

		if(!myExecutionee.PlayIdle(IdleHeadChop))
 			myScripts.SLV_DisplayInformation(self+ " play idle failed")
			if(myExecutionee == Game.GetPlayer())
				Debug.SetGodMode(false)
			endif
			myExecutionee.KillEssential(Game.GetPlayer())
			myExecutionee.EndDeferredKill()	
		else
			myScripts.SLV_DisplayInformation(self+ " play idle suceess")
			Wait(2.0)
			executioneeActor.RemoveDependentAnimatedObjectReference( executionerActor )
			executioneeActor.RemoveDependentAnimatedObjectReference( executionGuardActor )
			executioneeActor = None
			
			if(myExecutionee == Game.GetPlayer())
				Wait(10.0)
			else
				Wait(16.0) ; need some extra time for the anim to finish pushing the previous victim away.
			endif
			if(!myExecutionee.IsDead()) ; incredibly, decapitation doesn't actually kill the victim
				if(myExecutionee == Game.GetPlayer())
					Game.TriggerScreenBlood(10)
					Debug.SetGodMode(false)
				endif
				myExecutionee.KillEssential(Game.GetPlayer())
				myExecutionee.EndDeferredKill()
			endif
		endif
		;Now clean up.  Set the executionee to NULL, since he's no longer needed...
		gotoState("readyToChop")
 		myScripts.SLV_DisplayInformation("CHOPPING END" )
	endif
endEvent
