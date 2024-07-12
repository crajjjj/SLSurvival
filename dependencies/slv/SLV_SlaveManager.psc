Scriptname SLV_SlaveManager extends Quest  

Faction Property SLV_SlaveBasicTraining auto
Faction Property SLV_SlaveAdvancedTraining auto
Faction Property SLV_SlaveBeastTraining auto
Faction Property SLV_SlavePainslutTraining auto

Faction Property zbf_FactionSlaver auto
Faction Property zbf_FactionSlave auto
Faction Property zbf_FactionMaster auto
Faction Property SLV_Slave auto

SLV_SlaveManagementQuest Property slaveManagement Auto

function SLV_AddNewSlave(Actor NPCActor)
if SLV_AddNewSingleSlave(slaveManagement.Alias_SLV_PlayerSlave1, NPCActor)
	return
endif
if SLV_AddNewSingleSlave(slaveManagement.Alias_SLV_PlayerSlave2, NPCActor)
	return
endif
if SLV_AddNewSingleSlave(slaveManagement.Alias_SLV_PlayerSlave3, NPCActor)
	return
endif
if SLV_AddNewSingleSlave(slaveManagement.Alias_SLV_PlayerSlave4, NPCActor)
	return
endif
if SLV_AddNewSingleSlave(slaveManagement.Alias_SLV_PlayerSlave5, NPCActor)
	return
endif
if SLV_AddNewSingleSlave(slaveManagement.Alias_SLV_PlayerSlave6, NPCActor)
	return
endif
if SLV_AddNewSingleSlave(slaveManagement.Alias_SLV_PlayerSlave7, NPCActor)
	return
endif
if SLV_AddNewSingleSlave(slaveManagement.Alias_SLV_PlayerSlave8, NPCActor)
	return
endif
if SLV_AddNewSingleSlave(slaveManagement.Alias_SLV_PlayerSlave9, NPCActor)
	return
endif
endfunction

bool function SLV_AddNewSingleSlave(ReferenceAlias slaveRef, Actor NPCActor)
if !slaveRef
	slaveRef.forceRefTo(NPCActor)
	SLV_AddSingleSlave(NPCActor)
	return true
elseif !slaveRef.getActorRef()
	slaveRef.forceRefTo(NPCActor)
	SLV_AddSingleSlave(NPCActor)
	return true
endif

return false
endfunction

function SLV_FreeSlave(Actor NPCActor)
if !slaveManagement.Alias_SLV_PlayerSlave1
	if slaveManagement.Alias_SLV_PlayerSlave1.getActorRef() == NPCActor
		SLV_FreeSingleSlave(slaveManagement.Alias_SLV_PlayerSlave1)
		return
	endif
endif
if !slaveManagement.Alias_SLV_PlayerSlave2
	if slaveManagement.Alias_SLV_PlayerSlave2.getActorRef() == NPCActor
		SLV_FreeSingleSlave(slaveManagement.Alias_SLV_PlayerSlave2)
		return
	endif
endif
if !slaveManagement.Alias_SLV_PlayerSlave3
	if slaveManagement.Alias_SLV_PlayerSlave3.getActorRef() == NPCActor
		SLV_FreeSingleSlave(slaveManagement.Alias_SLV_PlayerSlave3)
		return
	endif
endif
if !slaveManagement.Alias_SLV_PlayerSlave4
	if slaveManagement.Alias_SLV_PlayerSlave4.getActorRef() == NPCActor
		SLV_FreeSingleSlave(slaveManagement.Alias_SLV_PlayerSlave4)
		return
	endif
endif
if !slaveManagement.Alias_SLV_PlayerSlave5
	if slaveManagement.Alias_SLV_PlayerSlave5.getActorRef() == NPCActor
		SLV_FreeSingleSlave(slaveManagement.Alias_SLV_PlayerSlave5)
		return
	endif
endif
if !slaveManagement.Alias_SLV_PlayerSlave6
	if slaveManagement.Alias_SLV_PlayerSlave6.getActorRef() == NPCActor
		SLV_FreeSingleSlave(slaveManagement.Alias_SLV_PlayerSlave6)
		return
	endif
endif
if !slaveManagement.Alias_SLV_PlayerSlave7
	if slaveManagement.Alias_SLV_PlayerSlave7.getActorRef() == NPCActor
		SLV_FreeSingleSlave(slaveManagement.Alias_SLV_PlayerSlave7)
		return
	endif
endif
if !slaveManagement.Alias_SLV_PlayerSlave8
	if slaveManagement.Alias_SLV_PlayerSlave8.getActorRef() == NPCActor
		SLV_FreeSingleSlave(slaveManagement.Alias_SLV_PlayerSlave8)
		return
	endif
endif
if !slaveManagement.Alias_SLV_PlayerSlave9
	if slaveManagement.Alias_SLV_PlayerSlave9.getActorRef() == NPCActor
		SLV_FreeSingleSlave(slaveManagement.Alias_SLV_PlayerSlave9)
		return
	endif
endif
endfunction

function SLV_AddSingleSlave(Actor NPCActor)
NPCActor.removeFromFaction(SLV_SlaveBasicTraining)
NPCActor.removeFromFaction(SLV_SlaveAdvancedTraining)
NPCActor.removeFromFaction(SLV_SlaveBeastTraining)
NPCActor.removeFromFaction(SLV_SlavePainslutTraining)
NPCActor.removeFromFaction(zbf_FactionSlaver)
NPCActor.addToFaction(SLV_Slave)
NPCActor.addToFaction(zbf_FactionSlave)
endfunction

function SLV_FreeSingleSlave(ReferenceAlias slave)
Actor NPCActor = slave.getActorRef()
NPCActor.removeFromFaction(SLV_SlaveBasicTraining)
NPCActor.removeFromFaction(SLV_SlaveAdvancedTraining)
NPCActor.removeFromFaction(SLV_SlaveBeastTraining)
NPCActor.removeFromFaction(SLV_SlavePainslutTraining)
NPCActor.removeFromFaction(SLV_Slave)
NPCActor.removeFromFaction(zbf_FactionSlave)

ActorUtil.ClearPackageOverride(NPCActor)
NPCActor.evaluatePackage()

slave.clear()
endfunction