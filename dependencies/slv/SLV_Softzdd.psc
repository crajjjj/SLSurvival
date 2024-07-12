Scriptname SLV_Softzdd extends Quest  

function enable_all()
if Game.GetModByName("zdd.esp") == 255
	return;
endif  
enable_whiterun()
enable_markarth()
enable_solitude()
enable_windhelm()
endfunction

function disable_all()
if Game.GetModByName("zdd.esp") == 255
	return;
endif  
disable_whiterun()
disable_markarth()
disable_solitude()
disable_windhelm()
endfunction


function enable_whiterun()
switch_whiterun(true)
endfunction
function disable_whiterun()
switch_whiterun(false)
endfunction

function switch_whiterun(bool on)
if Game.GetModByName("zdd.esp") == 255
	return;
endif

switch_zdd_form(0x005f90, on)
switch_zdd_form(0x0095ff, on)
switch_zdd_form(0x0038be, on)
switch_zdd_form(0x0085d4, on)
switch_zdd_form(0x005e9d, on)

switch_zdd_form(0x005f96, on)
switch_zdd_form(0x005fa3, on)
switch_zdd_form(0x005fa4, on)
endfunction


function enable_markarth()
switch_markarth(true)
endfunction
function disable_markarth()
switch_markarth(false)
endfunction


function switch_markarth(bool on)
if Game.GetModByName("zdd.esp") == 255
	return;
endif

switch_zdd_form(0x007b00, on)
switch_zdd_form(0x0085d3, on)
switch_zdd_form(0x00909c, on)

switch_zdd_form(0x007b01, on)
switch_zdd_form(0x0085d2, on)

endfunction



function enable_solitude()
switch_solitude(true)
endfunction
function disable_solitude()
switch_solitude(false)
endfunction


function switch_solitude(bool on)
if Game.GetModByName("zdd.esp") == 255
	return;
endif
switch_zdd_form(0x00702c, on)
switch_zdd_form(0x006a9f, on)
switch_zdd_form(0x006aa2, on)
switch_zdd_form(0x00702b, on)

switch_zdd_form(0x007af7, on)
switch_zdd_form(0x007afc, on)
switch_zdd_form(0x006a94, on)
switch_zdd_form(0x00806a, on)
endfunction


function enable_windhelm()
switch_windhelm(true)
endfunction
function disable_windhelm()
switch_windhelm(false)
endfunction


function switch_windhelm(bool on)
if Game.GetModByName("zdd.esp") == 255
	return;
endif

switch_zdd_form(0x00a0ce, on)
switch_zdd_form(0x00a0cf, on)
endfunction



function switch_zdd_form(int objectid, bool on)
ObjectReference zdd = Game.GetFormFromFile(objectid, "zdd.esp") as ObjectReference
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