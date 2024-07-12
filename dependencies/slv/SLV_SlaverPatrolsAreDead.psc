Scriptname SLV_SlaverPatrolsAreDead extends ReferenceAlias  

event OnDeath(Actor akKiller)
myScripts.SLV_DisplayUser("You killed a slave agent!")

if SLV_CityFreedomQuest.getStage() == stageFrom && allSlaveAgentsAreDead()
	SLV_CityFreedomQuest.SetObjectiveCompleted(stageFrom)
	SLV_CityFreedomQuest.SetStage(stageTo)
EndIf
EndEvent

bool function allSlaveAgentsAreDead()
if aSlaveAgentIsNotDead(SLV_SlaveAgent1)
	myScripts.SLV_DisplayInformation("SlaveAgent1 is still alive") 
	return false
endif
if aSlaveAgentIsNotDead(SLV_SlaveAgent2)
	myScripts.SLV_DisplayInformation("SlaveAgent2 is still alive")
	return false
endif
return true
endfunction

bool function aSlaveAgentIsNotDead(ReferenceAlias SLV_SlaveAgent)
if SLV_SlaveAgent != none
	if SLV_SlaveAgent.getActorRef() != none
		if !SLV_SlaveAgent.getActorRef().isDead()
			return true
		endif
	endif
endif
return false
endfunction

SLV_Utilities Property myScripts auto
Quest Property SLV_CityFreedomQuest Auto
int Property stageFrom Auto
int Property stageTo Auto

ReferenceAlias Property SLV_SlaveAgent1 Auto
ReferenceAlias Property SLV_SlaveAgent2 Auto
