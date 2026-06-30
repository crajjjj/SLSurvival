Scriptname FWOvulationItem extends FWSpell 

;FWSystem property System auto

actor ActorRef
bool bInit=false

function execute()

	if bInit==false || ActorRef==none
		return
	endif

	FW_log.WriteLog("FWOvulationItem - Changing state of " + ActorRef + " to Luteal_State where the impregnation change is maximum.")
	ActorRef.SendModEvent("BeeingFemale", "ChangeState", 2)
endfunction

Event OnWoman(Actor akTarget, Actor akCaster)
	ActorRef = akCaster
	execute()
endEvent

Event OnInit()
	bInit=true
	parent.OnInit()
	execute()
endEvent