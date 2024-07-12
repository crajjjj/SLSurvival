Scriptname SLV_SlaverOutfit extends Quest  

function setSlaverOutfit(int level)
Outfit guardoutfit = getOutfit(level)

lvlUpSlaverNPC(Zaid.getActorRef(),guardoutfit)
lvlUpSlaverNPC(Eric.getActorRef(),guardoutfit)
lvlUpSlaverNPC(Brutus.getActorRef(),guardoutfit)
lvlUpSlaverNPC(Swen.getActorRef(),guardoutfit)
lvlUpSlaverNPC(Mundus.getActorRef(),guardoutfit)
lvlUpSlaverNPC(Torwin.getActorRef(),guardoutfit)
lvlUpSlaverNPC(Fang.getActorRef(),guardoutfit)

if game.getplayer().IsInFaction(SlaverunSlaverFaction)
	givePCSlaverReward(getPlayerReward(level))
endif
endfunction

function lvlUpSlaverNPC(Actor NPCActor, Outfit newoutfit)
NPCActor.setOutfit(newoutfit)
if myScripts.SLV_getSchlongSize(NPCActor) < 10
	myScripts.SLV_SlaverSchlong(NPCActor)
endif
myScripts.SLV_IncleaseSchlong(NPCActor)
endfunction

function initSlaverSchlongs()
myScripts.SLV_SlaverSchlong(Zaid.getActorRef())
myScripts.SLV_SlaverSchlong(Eric.getActorRef())
myScripts.SLV_SlaverSchlong(Brutus.getActorRef())
myScripts.SLV_SlaverSchlong(Swen.getActorRef())
myScripts.SLV_SlaverSchlong(Mundus.getActorRef())
myScripts.SLV_SlaverSchlong(Torwin.getActorRef())
myScripts.SLV_SlaverSchlong(Fang.getActorRef())
myScripts.SLV_SlaverSchlong(SLV_Finn.getActorRef())

endfunction
SLV_Utilities Property myScripts auto
  
Outfit function getOutfit(int level)
if (level== 0) 
	return SLV_GuardOutfit0
elseif (level== 1)
	return SLV_GuardOutfit1
elseif (level== 2)
	return SLV_GuardOutfit2
elseif (level== 3)
	return SLV_GuardOutfit3
elseif (level== 4)
	return SLV_GuardOutfit4
elseif (level== 5)
	return SLV_GuardOutfit5
elseif (level== 6)
	return SLV_GuardOutfit6
elseif (level== 7)
	return SLV_GuardOutfit7
elseif (level== 8)
	return SLV_GuardOutfit8
elseif (level== 9)
	return SLV_GuardOutfit9
else
	return SLV_GuardOutfit0
endif
endfunction

Armor[] function getPlayerReward(int level)
if (level== 0) 
	return PCSlaverReward0
elseif (level== 1)
	return PCSlaverReward1 
elseif (level== 2)
	return PCSlaverReward2
elseif (level== 3)
	return PCSlaverReward3 
elseif (level== 4)
	return PCSlaverReward4
elseif (level== 5)
	return PCSlaverReward5 
elseif (level== 6)
	return PCSlaverReward6 
elseif (level== 7)
	return PCSlaverReward7 
elseif (level== 8)
	return PCSlaverReward8 
elseif (level== 9)
	return PCSlaverReward9 
else
	return PCSlaverReward0
endif
endfunction

function givePCSlaverReward(Armor[] PCSlaverReward)
Int armorRewards= PCSlaverReward.Length
While armorRewards
	armorRewards-= 1
	PlayerRef.addItem(PCSlaverReward[armorRewards])
	if !MCMMenu.enforcerForSlavers
		PlayerRef.equipItem(PCSlaverReward[armorRewards])
	endif
EndWhile
endfunction
Actor Property PlayerRef auto
SLV_MCMMenu Property MCMMenu Auto

ReferenceAlias Property Zaid auto
ReferenceAlias Property Eric auto
ReferenceAlias Property Brutus auto
ReferenceAlias Property Swen auto
ReferenceAlias Property Mundus auto
ReferenceAlias Property Torwin auto
ReferenceAlias Property Fang auto
ReferenceAlias Property SLV_Finn auto

Faction Property SlaverunSlaverFaction auto

Outfit Property SLV_GuardOutfit0 auto
Outfit Property SLV_GuardOutfit1 auto
Outfit Property SLV_GuardOutfit2 auto
Outfit Property SLV_GuardOutfit3 auto
Outfit Property SLV_GuardOutfit4 auto
Outfit Property SLV_GuardOutfit5 auto
Outfit Property SLV_GuardOutfit6 auto
Outfit Property SLV_GuardOutfit7 auto
Outfit Property SLV_GuardOutfit8 auto
Outfit Property SLV_GuardOutfit9 auto

Armor[] Property PCSlaverReward0 Auto
Armor[] Property PCSlaverReward1 Auto
Armor[] Property PCSlaverReward2 Auto
Armor[] Property PCSlaverReward3 Auto
Armor[] Property PCSlaverReward4 Auto
Armor[] Property PCSlaverReward5 Auto
Armor[] Property PCSlaverReward6 Auto
Armor[] Property PCSlaverReward7 Auto
Armor[] Property PCSlaverReward8 Auto
Armor[] Property PCSlaverReward9 Auto
