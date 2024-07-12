Scriptname SLV_SpecialDevices extends Quest  


function SLV_equipDDChainsNoPlugs(Actor NPCActor)
if MCMMenu.SkipDevices
	return
endif

Libs.ManipulateGenericDevice(NPCActor, xlibs.zadx_HR_ChainHarnessArmsInventory, TRUE, FALSE, TRUE)
;Libs.ManipulateGenericDevice(NPCActor, xlibs.zadx_HR_NippleChainCollarInventory, TRUE, FALSE, TRUE)
Libs.ManipulateGenericDevice(NPCActor, xlibs.zadx_HR_NippleClampsInventory, TRUE, FALSE, TRUE)
Libs.ManipulateGenericDevice(NPCActor, xlibs.zadx_HR_ChainHarnessBraInventory, TRUE, FALSE, TRUE)
Libs.ManipulateGenericDevice(NPCActor, xlibs.zadx_HR_ChainHarnessBootsInventory, TRUE, FALSE, TRUE)
Libs.ManipulateGenericDevice(NPCActor, xlibs.zadx_HR_ChainHarnessGlovesInventory, TRUE, FALSE, TRUE)
Libs.ManipulateGenericDevice(NPCActor, xlibs.zadx_HR_ChainHarnessLegsInventory, TRUE, FALSE, TRUE)
Libs.ManipulateGenericDevice(NPCActor, xlibs.zadx_HR_ChainHarnessNippleInventory, TRUE, FALSE, TRUE)
Libs.ManipulateGenericDevice(NPCActor, xlibs.zadx_HR_ChainHarnessBodyInventory, TRUE, FALSE, TRUE)
Libs.ManipulateGenericDevice(NPCActor, xlibs.zadx_HR_PearGagInventory, TRUE, FALSE, TRUE)

endfunction


function SLV_equipDDChainsPlugs(Actor NPCActor)
if MCMMenu.SkipDevices
	return
endif
Libs.ManipulateGenericDevice(NPCActor, xlibs.zadx_HR_IronPearAnalSignBlackInventory, TRUE, FALSE, TRUE)
Libs.ManipulateGenericDevice(NPCActor, xlibs.zadx_HR_IronPearVaginalBellBlackInventory, TRUE, FALSE, TRUE)
endfunction

function SLV_equipPrisonerChains01(Actor NPCActor)
if MCMMenu.SkipDevices
	return
endif
Libs.ManipulateGenericDevice(NPCActor, zadx_HR_PrisonerChains01Inventory, TRUE, FALSE, TRUE)
endfunction

function SLV_equipBallChain02(Actor NPCActor)
if MCMMenu.SkipDevices
	return
endif
Libs.ManipulateGenericDevice(NPCActor, zadx_HR_BallChain02Inventory, TRUE, FALSE, TRUE)
endfunction

function SLV_equipIronCollarChain01x4(Actor NPCActor)
if MCMMenu.SkipDevices
	return
endif
Libs.ManipulateGenericDevice(NPCActor, zadx_HR_IronCollarChain01x4Inventory, TRUE, FALSE, TRUE)
endfunction

function SLV_equipPonyOutfit(Actor NPCActor)
if MCMMenu.SkipDevices
	return
endif
Libs.ManipulateGenericDevice(NPCActor, zadx_HR_PlugPonyTail03Inventory, TRUE, FALSE, TRUE)
Libs.ManipulateGenericDevice(NPCActor, zadx_XinPonyBootsInventory, TRUE, FALSE, TRUE)
Libs.ManipulateGenericDevice(NPCActor, zadx_dud_Pony_Harness_Ears_Leather_BlackInventory, TRUE, FALSE, TRUE)
endfunction

function SLV_equipAnkleIron(Actor NPCActor)
if MCMMenu.SkipDevices
	return
endif
Libs.ManipulateGenericDevice(NPCActor, zbfAnkleIronHDT, TRUE, FALSE, TRUE)
endfunction

function SLV_equipStraitJacket(Actor NPCActor, String color)
if MCMMenu.SkipDevices
	return
endif
if color == "black" || color == "Black" 
	Libs.ManipulateGenericDevice(NPCActor, zadx_StraitJacketLeatherBlackInventory, TRUE, FALSE, TRUE)
elseif color == "red" || color == "Red" 
Libs.ManipulateGenericDevice(NPCActor, zadx_StraitJacketLeatherRedInventory, TRUE, FALSE, TRUE)
elseif color == "white" || color == "White" 
	Libs.ManipulateGenericDevice(NPCActor, zadx_StraitJacketLeatherWhiteInventory, TRUE, FALSE, TRUE)
else
	Libs.ManipulateGenericDevice(NPCActor, zadx_StraitJacketLeatherBlackInventory, TRUE, FALSE, TRUE)
endif
endfunction

function SLV_equipShackles(Actor NPCActor)
if MCMMenu.SkipDevices
	return
endif
if NPCActor == none
	NPCActor = Game.getPlayer()
	MiscUtil.PrintConsole("NPCActor is null")
endif
if xlibs == none
	MiscUtil.PrintConsole("xlibs is null")
endif

if xlibs.zadx_AnkleShackles_Black_Inventory == none
	MiscUtil.PrintConsole("xlibs.zadx_AnkleShackles_Black_Inventory is null")
endif
if zadx_AnkleShackles_Black_Inventory == none
	MiscUtil.PrintConsole("zadx_AnkleShackles_Black_Inventory is null")
endif
;Libs.ManipulateGenericDevice(NPCActor, zadx_AnkleShackles_Black_Inventory, TRUE, FALSE, TRUE)
Libs.ManipulateGenericDevice(NPCActor, xlibs.zadx_AnkleShackles_Black_Inventory, TRUE, FALSE, TRUE)
endfunction

;DEVIOUS DEVICES PROPERTIES
zadxLibs Property xlibs Auto
zadLibs Property libs Auto
SLV_MCMMenu Property MCMMenu Auto

Armor Property zadx_HR_PrisonerChains01Inventory Auto
Armor Property zadx_HR_BallChain02Inventory Auto
Armor Property zadx_HR_IronCollarChain01x4Inventory Auto

Armor Property zadx_HR_PlugPonyTail03Inventory Auto
Armor Property zadx_XinPonyBootsInventory Auto
Armor Property zadx_dud_Pony_Harness_Ears_Leather_BlackInventory Auto
Armor Property zbfAnkleIronHDT Auto

Armor Property zadx_StraitJacketLeatherBlackInventory Auto
Armor Property zadx_StraitJacketLeatherRedInventory Auto
Armor Property zadx_StraitJacketLeatherWhiteInventory Auto
Armor Property zadx_AnkleShackles_Black_Inventory Auto