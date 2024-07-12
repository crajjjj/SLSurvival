Scriptname SLV_EnableColosseum extends Quest  


function SLV_enableAll()
SLV_enablePassage()
SLV_enableArena()
endfunction


function SLV_enablePassage()
Int newPassageItems = newPassageEnabling.Length
While newPassageItems 
	newPassageItems -= 1
	newPassageEnabling[newPassageItems].Enable()
EndWhile
endfunction

ObjectReference[] Property newPassageEnabling Auto


function SLV_enableArena()
Int newArenaItems = newArenaEnabling.Length
While newArenaItems 
	newArenaItems -= 1
	newArenaEnabling[newArenaItems].Enable()
EndWhile

if MCMMenu.ArenaGore
	newArenaItems = newArenaGoreEnabling.Length
	While newArenaItems 
		newArenaItems -= 1
		newArenaGoreEnabling[newArenaItems].Enable()
	EndWhile
endif
endfunction



function SLV_CheatAllRecipes()
SLV_CheatUpperMine()
SLV_CheatLowerMine()
SLV_CheatPassage()
SLV_CheatArena()
SLV_CheatTrainingArea()
SLV_CheatBeastArea()
SLV_CheatGladiatorArea()
SLV_CheatSlaveArea()
endfunction

function SLV_CheatUpperMine()
PlayerRef.additem(SLV_HousePart001CampLayout,1)
PlayerRef.additem(SLV_HousePart007UpperMineLayout,1)
PlayerRef.additem(SLV_HousePart012UpperMineWorkbench,1)
endfunction

function SLV_CheatGladiatorArea()
PlayerRef.additem(SLV_HousePart039FreeGladiatorLayout,1)
PlayerRef.additem(SLV_HousePart046FreeGladiatorWorkbench,1)
endfunction

function SLV_CheatSlaveArea()
PlayerRef.additem(SLV_HousePart048SlaveGladiatorLayout,1)
PlayerRef.additem(SLV_HousePart055SlaveGladiatorWorkbench,1)
endfunction

function SLV_CheatLowerMine()
PlayerRef.additem(SLV_HousePart014LowerMineLayout,1)
PlayerRef.additem(SLV_HousePart019LowerMineWorkbench,1)
endfunction

function SLV_CheatPassage()
PlayerRef.additem(SLV_HousePart021PassageLayout,1)
PlayerRef.additem(SLV_HousePart037PassageWorkbench,1)
endfunction

function SLV_CheatArena()
PlayerRef.additem(SLV_HousePart057ArenaLayout,1)
PlayerRef.additem(SLV_HousePart071ArenaWorkbench,1)
endfunction

function SLV_CheatTrainingArea()
PlayerRef.additem(SLV_HousePart073TrainingLayout,1)
PlayerRef.additem(SLV_HousePart078TrainingWorkbench,1)
endfunction

function SLV_CheatBeastArea()
PlayerRef.additem(SLV_HousePart080AnimalAreaLayout,1)
PlayerRef.additem(SLV_HousePart090AnimalAreaWorkbench,1)
endfunction


ObjectReference[] Property newArenaEnabling Auto
ObjectReference[] Property newArenaGoreEnabling Auto
SLV_MCMMenu Property MCMMenu Auto
Actor Property PlayerRef Auto

MiscObject Property SLV_HousePart001CampLayout Auto
MiscObject Property SLV_HousePart007UpperMineLayout Auto
MiscObject Property SLV_HousePart012UpperMineWorkbench Auto
MiscObject Property SLV_HousePart014LowerMineLayout Auto
MiscObject Property SLV_HousePart019LowerMineWorkbench Auto
MiscObject Property SLV_HousePart021PassageLayout Auto
MiscObject Property SLV_HousePart037PassageWorkbench Auto
MiscObject Property SLV_HousePart039FreeGladiatorLayout Auto
MiscObject Property SLV_HousePart046FreeGladiatorWorkbench Auto
MiscObject Property SLV_HousePart048SlaveGladiatorLayout Auto
MiscObject Property SLV_HousePart055SlaveGladiatorWorkbench Auto
MiscObject Property SLV_HousePart057ArenaLayout Auto
MiscObject Property SLV_HousePart071ArenaWorkbench Auto
MiscObject Property SLV_HousePart073TrainingLayout Auto
MiscObject Property SLV_HousePart078TrainingWorkbench Auto
MiscObject Property SLV_HousePart080AnimalAreaLayout Auto
MiscObject Property SLV_HousePart090AnimalAreaWorkbench Auto