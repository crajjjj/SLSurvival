Scriptname SLV_SoftHydraSlavegirls extends Quest  

function disable_all()
if Game.GetModByName("hydra_slavegirls.esp") == 255 || ThisMenu.Hydragon == false
	return;
endif

disable_whiterun()
disable_dawnstar()
disable_falkreath()
disable_markarth()
disable_morthal()
disable_riften()
disable_riverwood()
disable_solitude()
disable_windhelm()
disable_winterhold()
endfunction


function enable_all()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return;
endif

if ThisMenu.Hydragon == false
	enable_solitude()
	enable_windhelm()
	enable_winterhold()
	enable_morthal()
	enable_riften()
	enable_markarth()
	enable_dawnstar()
	enable_falkreath()
	enable_riverwood()
	enable_whiterun()
	return
endif

if SlaverunQuest.getStage() >= 10000
	enable_solitude()
endif
if SlaverunQuest.getStage() >= 9000
	enable_windhelm()
endif
if SlaverunQuest.getStage() >= 8000
	enable_winterhold()
endif
if SlaverunQuest.getStage() >= 7000
	enable_morthal()
endif
if SlaverunQuest.getStage() >= 6000
	enable_riften()
endif
if SlaverunQuest.getStage() >= 5000
	enable_markarth()
endif
if SlaverunQuest.getStage() >= 4000
	enable_dawnstar()
endif
if SlaverunQuest.getStage() >= 3000
	enable_falkreath()
endif
if SlaverunQuest.getStage() >= 2000
	enable_riverwood()
endif
if SlaverunQuest.getStage() >= 1000
	enable_whiterun()
endif
endfunction


function enable_whiterun()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return;
endif
switch_whiterun(true)
endfunction


function disable_whiterun()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return;
endif
switch_whiterun(false)
endfunction

function switch_whiterun(bool on)
;plaindistrict4
switch_zdd_form(0x006a00,on)
switch_zdd_form(0x0069fa,on)
switch_zdd_form(0x0069fc,on)

;belethors
switch_zdd_form(0x0018a6,on)

;dragonsreach
switch_zdd_form(0x014355,on)
switch_zdd_form(0x014356,on)
switch_zdd_form(0x051cd9,on)
switch_zdd_form(0x0718ab,on)
switch_zdd_form(0x001e1b,on)
switch_zdd_form(0x031ea0,on)
switch_zdd_form(0x031ea2,on)
switch_zdd_form(0x032ede,on)
switch_zdd_form(0x051cda,on)
switch_zdd_form(0x0718ac,on)

switch_zdd_form(0x001e1b,on)
switch_zdd_form(0x0718ab,on)
switch_zdd_form(0x0d3248,on)

;dragonsreach dungeon
;switch_zdd_form(0x0a3dd7,on)
;switch_zdd_form(0x0a3dd9,on)

;dragonsreach jarlquarter
switch_zdd_form(0x0718b0,on)
switch_zdd_form(0x0718b1,on)

;dragonreach house battle born
switch_zdd_form(0x040213,on)

;Chillfurrow Farm
switch_zdd_form(0x0a5ecf,on)

;Whiterun Exterior14
switch_zdd_form(0x0a5ecb,on)

;Whiterun Exterior17
switch_zdd_form(0x0a5ecd,on)

;BattleBornFarmExterior
switch_zdd_form(0x057397,on)
switch_zdd_form(0x0a5ed2,on)

;LoreiusFarmExterior
switch_zdd_form(0x0a5ed4,on)
switch_zdd_form(0x0a74ce,on)
switch_zdd_form(0x0a74d1,on)

;Whitewatch Tower
switch_zdd_form(0x0578fe,on)

;WhiterunWorld
switch_zdd_form(0x006a00,on)

;WhiterunWindDistrict
switch_zdd_form(0x0069fa,on)
switch_zdd_form(0x0069fc,on)



switch_zdd_form(0x0d8126,on)

endfunction


function enable_dawnstar()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return;
endif
switch_dawnstar(true)
endfunction


function disable_dawnstar()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return;
endif
switch_dawnstar(false)
endfunction

function switch_dawnstar(bool on)
;Windpeak Inn
switch_zdd_form(0x03805e,on)
switch_zdd_form(0x038060,on)

;The White hall
switch_zdd_form(0x04f166,on)
switch_zdd_form(0x06421e,on)
switch_zdd_form(0x04f169,on)
switch_zdd_form(0x05e076,on)
switch_zdd_form(0x06421d,on)

;Dawnstar Jail
switch_zdd_form(0x023333,on)
switch_zdd_form(0x09a99b,on)

endfunction


function enable_falkreath()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return;
endif
switch_falkreath(true)
endfunction


function disable_falkreath()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return;
endif
switch_falkreath(false)
endfunction

function switch_falkreath(bool on)
;Jarls Longhouse
switch_zdd_form(0x034fb9,on)
switch_zdd_form(0x034fba,on)
switch_zdd_form(0x0012f7,on)
switch_zdd_form(0x0a74c0,on)

;Falkreath Jail
switch_zdd_form(0x023335,on)

;Exterior04
switch_zdd_form(0x073516,on)
switch_zdd_form(0x073519,on)

;Exterior02
switch_zdd_form(0x05e07c,on)

;Exterior01
switch_zdd_form(0x072489,on)
switch_zdd_form(0x07248a,on)
switch_zdd_form(0x07351a,on)
switch_zdd_form(0x07351b,on)
switch_zdd_form(0x07351d,on)

switch_zdd_form(0x062175,on)
endfunction

function enable_markarth()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return;
endif
switch_markarth(true)
endfunction


function disable_markarth()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return;
endif
switch_markarth(false)
endfunction

function switch_markarth(bool on)
;Understone Keep
switch_zdd_form(0x0626dc,on)
switch_zdd_form(0x0626dd,on)
switch_zdd_form(0x064793,on)
switch_zdd_form(0x08fd47,on)
switch_zdd_form(0x0a53ab,on)
switch_zdd_form(0x0a74c6,on)
switch_zdd_form(0x0a7a46,on)
switch_zdd_form(0x05e078,on)
switch_zdd_form(0x064794,on)
switch_zdd_form(0x08fd48,on)
switch_zdd_form(0x0a53ac,on)
switch_zdd_form(0x0a74c7,on)
switch_zdd_form(0x0a7a37,on)
switch_zdd_form(0x0c893c,on)

;Silver-Blood Inn
switch_zdd_form(0x001309,on)

;SalviusFarm Exterior02
switch_zdd_form(0x0a5eee,on)

;SalviusFarm Exterior01
switch_zdd_form(0x05cade,on)

;LeftHandMine
switch_zdd_form(0x05cadd,on)
switch_zdd_form(0x0a5eec,on)

;Markath MainGate
switch_zdd_form(0x02283b,on)

endfunction

function enable_morthal()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return;
endif
switch_morthal(true)
endfunction


function disable_morthal()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return;
endif
switch_morthal(false)
endfunction

function switch_morthal(bool on)

;Morthal Jail
switch_zdd_form(0x020657,on)
switch_zdd_form(0x030e27,on)

;Highmoon Hall
switch_zdd_form(0x063ca5,on)
switch_zdd_form(0x0a74c4,on)
switch_zdd_form(0x000d68,on)
switch_zdd_form(0x028bfe,on)
switch_zdd_form(0x0662a7,on)
switch_zdd_form(0x0a74c5,on)

;Moorside Inn
switch_zdd_form(0x014348,on)
switch_zdd_form(0x01434b,on)

endfunction

function enable_riften()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return;
endif
switch_riften(true)
endfunction


function disable_riften()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return;
endif
switch_riften(false)
endfunction

function switch_riften(bool on)

;Haelga Bunkhouse
switch_zdd_form(0x000d6c,on)

;Romlyn Dreths House
switch_zdd_form(0x0a4e2f,on)
switch_zdd_form(0x0a4e30,on)

;Mistveil Keep Barracks
switch_zdd_form(0x072a09,on)
switch_zdd_form(0x072a0a,on)

;The Ragged Flagon
;switch_zdd_form(0x0a5ec9,on)

;Mistveil Keep Jarls chambers
switch_zdd_form(0x034fc4,on)
switch_zdd_form(0x0012ff,on)

;Riften Jail
switch_zdd_form(0x09a980,on)
switch_zdd_form(0x09e63e,on)
switch_zdd_form(0x09f6c4,on)

;Riften Plankside
switch_zdd_form(0x053d49,on)

;SnowShodFarm
switch_zdd_form(0x0a5ed8,on)

;MerryfairFarmexterior
switch_zdd_form(0x07352d,on)
switch_zdd_form(0x0a5ed6,on)

;Riften NorthGate
switch_zdd_form(0x060bc6,on)

;BlackBriarLodgeexterior
switch_zdd_form(0x0a7fb0,on)

;RiftenWorld
switch_zdd_form(0x006a12,on)

;RiftenCitySouth
switch_zdd_form(0x006a14,on)
switch_zdd_form(0x0074ee,on)
switch_zdd_form(0x0250b5,on)

switch_zdd_form(0x01d035,on)

endfunction


function enable_riverwood()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return
endif

switch_riverwood(true)
endfunction


function disable_riverwood()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return
endif

switch_riverwood(false)
endfunction

function switch_riverwood(bool on)

;Riverwood Exterior02
switch_zdd_form(0x028137,on)

;Riverwood Exterior04
switch_zdd_form(0x0662af,on)
switch_zdd_form(0x0a5ee4,on)

switch_zdd_form(0x0da83f,on)

endfunction


function enable_solitude()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return
endif

switch_solitude(true)
endfunction


function disable_solitude()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return
endif

switch_solitude(false)
endfunction

function switch_solitude(bool on)
;Thalmor Headquarters
switch_zdd_form(0x028c01,on)
switch_zdd_form(0x028c04,on)

;Bards College
switch_zdd_form(0x0771bd,on)
switch_zdd_form(0x0771be,on)

;Blue Palace
switch_zdd_form(0x03c674,on)
switch_zdd_form(0x08fd45,on)
switch_zdd_form(0x033f1e,on)
switch_zdd_form(0x033f21,on)
switch_zdd_form(0x033f24,on)
switch_zdd_form(0x03448e,on)
switch_zdd_form(0x03c676,on)
switch_zdd_form(0x08fd46,on)

;Castle Dour Dungeon
switch_zdd_form(0x09a98d,on)
switch_zdd_form(0x09e640,on)
switch_zdd_form(0x09f6bf,on)

;Winking Skeever
switch_zdd_form(0x001333,on)

;Castle Dour
switch_zdd_form(0x0018a0,on)

;Dragon Bridge Four Shields Tavern
switch_zdd_form(0x0018ac,on)

;Dragon Bridge Exterior
switch_zdd_form(0x0a5ef6,on)

;Dragon Bridge Exterior01
switch_zdd_form(0x04e111,on)
switch_zdd_form(0x04e119,on)
switch_zdd_form(0x09a9a2,on)

;Dragon Bridge Exterior02
switch_zdd_form(0x04e115,on)

;EastEmpireTrading Docks
switch_zdd_form(0x050c99,on)
switch_zdd_form(0x05326c,on)

;Solitude Exterior
switch_zdd_form(0x053271,on)

;Katlas Farm
switch_zdd_form(0x0a5efd,on)

;Solitude Sawmill
switch_zdd_form(0x0a5efb,on)


;SolitudeWorld
switch_zdd_form(0x001e3c,on)

;SolitudeCasteDourcDistrict1
switch_zdd_form(0x005473,on)
switch_zdd_form(0x005474,on)
switch_zdd_form(0x005479,on)

;SolitudeCasteDourcDistrict2
switch_zdd_form(0x0239ee,on)

switch_zdd_form(0x005471,on)
endfunction


function enable_windhelm()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return;
endif

switch_windhelm(true)
endfunction


function disable_windhelm()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return;
endif

switch_windhelm(false)
endfunction

function switch_windhelm(bool on)
; windhelm palace Upstairs
switch_zdd_form(0x031e89,on)

; windhelm palace
switch_zdd_form(0x072498,on)
switch_zdd_form(0x072499,on)
switch_zdd_form(0x001310,on)
switch_zdd_form(0x001312,on)
switch_zdd_form(0x034a00,on)
switch_zdd_form(0x034a12,on)

; Gnisis Cornerclub
switch_zdd_form(0x064225,on)
switch_zdd_form(0x064226,on)
switch_zdd_form(0x07b9c9,on)

; Candlehearth Hall
switch_zdd_form(0x001e15,on)

; Argonian Assemblage
switch_zdd_form(0x00132a,on)

; Nightgate Inn
switch_zdd_form(0x01592d,on)
switch_zdd_form(0x01592e,on)

; Hall of the Dead
switch_zdd_form(0x06420e,on)
switch_zdd_form(0x06420f,on)

; House of Clan Cruel-Sea
switch_zdd_form(0x03fc7e,on)
switch_zdd_form(0x03fc7f,on)

; WindhelmDocksExterior
switch_zdd_form(0x09bfbf,on)

; WindhelmWorld
switch_zdd_form(0x002924,on)

; WindhelmOrigin
switch_zdd_form(0x00546e,on)
switch_zdd_form(0x00546f,on)
switch_zdd_form(0x005470,on)

switch_zdd_form(0x0a74c3,on)
switch_zdd_form(0x038060,on)

endfunction




function enable_winterhold()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return;
endif

switch_winterhold(true)
endfunction


function disable_winterhold()
if Game.GetModByName("hydra_slavegirls.esp") == 255
	return;
endif

switch_winterhold(false)
endfunction


function switch_winterhold(bool on)
; The Frozen hearth
switch_zdd_form(0x03c672,on)

; Hall of Attainment
switch_zdd_form(0x09bfa2,on)

; Jarls Longhouse
switch_zdd_form(0x000d6a,on)

; The Arcanaeum
switch_zdd_form(0x000d6e,on)

; Winterhold exterior
switch_zdd_form(0x00bbd6,on)

endfunction


function disable_zdd_form(int objectid)
ObjectReference zdd = Game.GetFormFromFile(objectid, "hydra_slavegirls.esp") as ObjectReference
if zdd
	zdd.disable()
endif
endfunction

function enable_zdd_form(int objectid)
ObjectReference zdd = Game.GetFormFromFile(objectid, "hydra_slavegirls.esp") as ObjectReference
if zdd
	zdd.enable()
endif
endfunction

function switch_zdd_form(int objectid, bool on)
ObjectReference zdd = Game.GetFormFromFile(objectid, "hydra_slavegirls.esp") as ObjectReference
if on
	if zdd
		zdd.enable()
	endif
else
	if zdd
		zdd.disable()
	endif
endif
endfunction

SLV_MCMMenu Property ThisMenu auto
Quest Property SlaverunQuest Auto