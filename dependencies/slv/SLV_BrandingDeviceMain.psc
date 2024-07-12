Scriptname SLV_BrandingDeviceMain extends Quest  

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
 


function brandingMoveToStocks(Actor playerRef, ObjectReference StocksRef)
    	GlobalVariable gstocksactivated= Game.GetFormFromFile(0x007486, "BrandingDeviceOfDoom.esp") As GlobalVariable    
    	gstocksactivated.setvalue(0)

     	playerRef.PathToReference(StocksRef, 1)
	StocksRef.Activate(playerRef)
endfunction


function brandingdoBranding(bool progressivetats)
if progressivetats
	int level = myShaving.GetNextProgressiveSlaveTatLevel()

	String tatsection = myShaving.GetProgressiveSlaveTatsSection(level)
	String tatname = myShaving.GetProgressiveSlaveTatsName(level)

    	brandexternalsetname(tatname ,tatsection )     
    	brandexternal(0,Game.GetPlayer(), 7)

	String facetatsection = myShaving.GetProgressiveFaceSlaveTatsSection(level)
	String facetatname = myShaving.GetProgressiveFaceSlaveTatsName(level)

	if level == 0 && facetatsection != ""
		SlaveTats.simple_remove_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (forehead)", silent = true)
		SlaveTats.simple_remove_tattoo(Game.GetPlayer(), "Slutmarks", "Cunt (right cheek)", silent = true)
		SlaveTats.simple_remove_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (left cheek)", silent = true)
	endif

	SlaveTats.simple_remove_tattoo(Game.GetPlayer(), facetatsection , facetatname , silent = true)
	SlaveTats.simple_add_tattoo(Game.GetPlayer(), facetatsection , facetatname , silent = true)
	Utility.wait(10)
else
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
endif
endfunction


function brandingLeaveStocks(Actor playerRef, ObjectReference StocksRef, ObjectReference floorMarker )
	StocksRef.Activate(playerRef)

     	;playerRef.PathToReference(floorMarker , 1)
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

SLV_HeadShaving Property myShaving auto
