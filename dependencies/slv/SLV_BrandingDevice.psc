Scriptname SLV_BrandingDevice extends Quest 

    ;[0]="SlaveF (Lnip)"
    ;[1]="SlaveF (Rnip)"      
    ;[2]="SlaveF (Crotch)"      
    ;[3]="SlaveF (Butthole)"
    ;[4]="SlaveF (Forehead)"
    
    ;[5]="SlaveF (LAss)"
    ;[6]="SlaveF (RAss)"
    ;[7]="SlaveF (Belly)"
    ;[8]="SlaveF (Cunt)"
    ;[9]="SlaveF (LUnderboob)"
    
    ;[10]="SlaveF (RUnderboob)"
    ;[11]="SlaveF (LTopboob)"
    ;[12]="SlaveF (RTopboob)"
    ;[13]="SlaveF (LCheek)"
    ;[14]="SlaveF (RCheek)"
    
    ;[15]="SlaveF (TopBack)"
    ;[16]="SlaveF (LCalf)"
    ;[17]="SlaveF (RCalf)"
    ;[18]="SlaveF (LThigh)"
    ;[19]="SlaveF (RThigh)"
    
    
    
    
    ;[30]="SlaveM (Lnip)"
    ;[31]="SlaveM (Rnip)"      
    ;[32]="SlaveM (Balls)"      ; doesn't work with slavetats
    ;[33]="SlaveM (Butthole)"    
    ;[34]="SlaveM (Cock)"        ;; doesn't work with slavetats
    
    ;[35]="SlaveM (Forehead)"
    ;[36]="SlaveM (LAss)"
    ;[37]="SlaveM (RAss)"
    ;[38]="SlaveM (Crotch)"      
    ;[39]="SlaveM (LCheek)"
    
    ;[40]="SlaveM (RCheek)"
    ;[41]="SlaveM (TopBack)"
 
function brandingMoveToCell(Actor master)
 	Game.ShakeCamera(afStrength = 0.7)
	Game.GetPlayer().MoveTo(Game.GetFormFromFile(0x001857, "BrandingDeviceOfDoom.esp") As Actor) 
	master.MoveTo(Game.GetPlayer()) 
endfunction

function brandingMoveToStocks()
	ObjectReference stocks= Game.GetFormFromFile(0x001853, "BrandingDeviceOfDoom.esp") As ObjectReference
	Utility.wait(3)

    	GlobalVariable gstocksactivated= Game.GetFormFromFile(0x007486, "BrandingDeviceOfDoom.esp") As GlobalVariable    
    	gstocksactivated.setvalue(0)

     	moveActorToStocks(0,Game.GetPlayer())
endfunction

function brandingdoBranding()
	SlaveTats.simple_remove_tattoo(Game.GetPlayer(), "Slutmarks", "Cunt (right cheek)", silent = true)
	SlaveTats.simple_remove_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (left cheek)", silent = true)

    	brandexternalsetname("Cunt (right cheek)","Slutmarks")     
    	brandexternal(0,Game.GetPlayer(), 14)
	Utility.wait(10)

    	brandexternalsetname("Slave (left cheek)","Slave Marks")      
    	brandexternal(0,Game.GetPlayer(), 13)
	Utility.wait(10)

	SlaveTats.simple_remove_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (forehead)", silent = true)
	SlaveTats.simple_remove_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (left hand)", silent = true)
	SlaveTats.simple_remove_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (right hand)", silent = true)

	SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (forehead)", silent = true)
	SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (left hand)", silent = true)
	SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (right hand)", silent = true)
endfunction

function brandingLeaveStocks()
  	moveActorOut(0,Game.GetPlayer()) 
	Utility.wait(20)

	Game.GetPlayer().MoveTo(Game.GetFormFromFile(0x001857, "BrandingDeviceOfDoom.esp") As Actor)
endfunction

function brandingLeaveCell(Actor master)
	Game.GetPlayer().MoveTo(getout) 
	master.MoveTo(Game.GetPlayer()) 
endfunction
ObjectReference Property getout auto

function brandingscene(Actor gobackactor)
    	Actor youractor = Game.GetPlayer()
       ;youractor.unequipall()


	; 0 - brandingdungeon
	; 1 - markarth
	int devnum
	devnum=0
    
 	Game.ShakeCamera(afStrength = 0.7)

	; slave in testcell
    	Actor youractor2 = Game.GetFormFromFile(0x001857, "BrandingDeviceOfDoom.esp") As Actor
    
    	;slave in markarth
    	;Actor youractor2 = Game.GetFormFromFile(0x006F0E, "BrandingDeviceOfDoom.esp") As Actor
	youractor.MoveTo(youractor2) 
    
    	;^^^^^
    	;!!!!USE YOUR OWN ACTOR!!!
	;ObjectReference stocks= Game.GetFormFromFile(0x006EF1, "BrandingDeviceOfDoom.esp") As ObjectReference
	ObjectReference stocks= Game.GetFormFromFile(0x001853, "BrandingDeviceOfDoom.esp") As ObjectReference

	;youractor.MoveTo(stocks) 
       ;youractor.unequipall()
	Utility.wait(3)


	game.disablePlayerControls()
	Game.SetPlayerAIDriven(true)

	; use this when the actor is outside of stocks
	clearactive()

     	moveActorToStocks(devnum,youractor)
  
    	;the iron will brand the left breast
    	; these combine several tats in 1 dds,
    	; so you can set name to something bogus and move the iron to different places several times or something
    	brandexternalsetname("Cock (right cheek)","Slutmarks")     
    	brandexternal(devnum,youractor, 14)
	Utility.wait(10)

    	brandexternalsetname("Sucker (left cheek)","Slutmarks")      
    	brandexternal(devnum,youractor, 13)
	Utility.wait(10)
    
    	;brandexternalsetname("Fuck Me (ass)","Slutmarks")      
    	;brandexternal(devnum,youractor, 5)
	;Utility.wait(10)

    	;brandexternalsetname("Slut (shoulder)","Slutmarks")     
    	;brandexternal(devnum,youractor, 15)
	;Utility.wait(10)

   	moveActorOut(devnum,youractor) 
	Utility.wait(10)

	Game.SetPlayerAIDriven(false)
	game.enablePlayerControls()
	Utility.wait(15.0)

	youractor.MoveTo(youractor2) 
	Utility.wait(15.0)

	youractor.MoveTo(gobackactor) 
endfunction

function moveActorToStocks(int DeviceNum, Actor slaveactor)
    Spell spellputintostocksSELF
        
    if(DeviceNum==0)
        ;test cell
        spellputintostocksSELF = Game.GetFormFromFile(0x00641B, "BrandingDeviceOfDoom.esp") As Spell
    
    elseif(DeviceNum==1)
        ;markarth
        spellputintostocksSELF = Game.GetFormFromFile(0x006EFD, "BrandingDeviceOfDoom.esp") As Spell
        
    endif
       
    spellputintostocksSELF.Cast(slaveactor,slaveactor)
    slaveactor.EvaluatePackage()

    waitwhilenotactive() 
 endfunction
 
function moveActorOut(int DeviceNum, Actor slaveactor)      
    Spell spellremovefromstocksSELF    
    
    if(DeviceNum==0)
        ;test cell
        spellremovefromstocksSELF = Game.GetFormFromFile(0x00641D, "BrandingDeviceOfDoom.esp") As Spell
    elseif(DeviceNum==1)
    
        ;Markarth
        spellremovefromstocksSELF = Game.GetFormFromFile(0x006F03, "BrandingDeviceOfDoom.esp") As Spell
    endif
    spellremovefromstocksSELF.Cast(slaveactor,slaveactor)
    slaveactor.EvaluatePackage()
 endfunction
 
function brandexternal(int DeviceNum, Actor slaveactor, int bodypositionnumber)

    ;Markarth
    ObjectReference stocks= Game.GetFormFromFile(0x006EF1, "BrandingDeviceOfDoom.esp") As ObjectReference
        
    Quest questbdod = Game.GetFormFromFile(0x001854, "BrandingDeviceOfDoom.esp") As Quest
    
    ;; alias that is linked to the STOCKS IN THE CELL (alias # in the quest) linked in xxBrandingVStocks script
    
    ;0 -test cell
    ;6 - markarth
    
    ReferenceAlias slavealias
    GlobalVariable    gstartdevice
    if(Devicenum==0)
        slavealias = questbdod.getalias(0) as ReferenceAlias
        gstartdevice = Game.GetFormFromFile(0x005EB6, "BrandingDeviceOfDoom.esp") As GlobalVariable    
    ;Markarth
    elseif (Devicenum==1)
        slavealias = questbdod.getalias(6) as ReferenceAlias
        gstartdevice = Game.GetFormFromFile(0x006EF8, "BrandingDeviceOfDoom.esp") As GlobalVariable
    endif
     
    ;6EF8 - Markarth
    ;5EB6 - testcell
   
    ;
    
    ;; location on on the body, see the list above
    GlobalVariable gpositionnumber = Game.GetFormFromFile(0x00594D, "BrandingDeviceOfDoom.esp") As GlobalVariable    
    gpositionnumber.setvalue(bodypositionnumber)

       
    ;;branding device OnUpdate will pick it up
    gstartdevice.setvalue(1)
    
    waitwhilebusy()
endfunction


function brandexternalsetname(string strname, string strsection)

    Game.SetGameSettingString("sDefaultMessage", strname)
    Game.SetGameSettingString("sPCControlsTextNone", strsection)
    GlobalVariable goverridenames = Game.GetFormFromFile(0x00594E, "BrandingDeviceOfDoom.esp") As GlobalVariable
    
    goverridenames.setvalue(1)
endfunction


function clearactive()
    GlobalVariable gstocksactivated= Game.GetFormFromFile(0x007486, "BrandingDeviceOfDoom.esp") As GlobalVariable    
    gstocksactivated.setvalue(0)
endfunction

function waitwhilenotactive()
    	Utility.wait(10)
	Debug.notification("It's realy getting hot inside here");

	Utility.wait(10)
	Debug.notification("The machine begins to rumble and glowes");

    	Utility.wait(10)
	Debug.notification("Smoldering parts are visible and the device starts moving.");


    
    GlobalVariable gstocksactivated= Game.GetFormFromFile(0x007486, "BrandingDeviceOfDoom.esp") As GlobalVariable    
    
    int stocksact=gstocksactivated.getvalue() as int
    ;while(stocksact==0)
        stocksact=gstocksactivated.getvalue() as int
        Utility.wait(1.0)
    ;endwhile
    gstocksactivated.setvalue(0)
endfunction


function waitwhilebusy()
    Utility.wait(3)
    
    GlobalVariable gbusy= Game.GetFormFromFile(0x001DC0, "BrandingDeviceOfDoom.esp") As GlobalVariable    
    
    
    int busy=gbusy.getvalue() as int
    while(busy==1)
        busy=gbusy.getvalue() as int
        Utility.wait(1.0)
    endwhile
endfunction
 
