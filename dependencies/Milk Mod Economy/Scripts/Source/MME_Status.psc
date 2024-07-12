Scriptname MME_Status extends Quest Hidden
{MME check script}
;Doesn't connect to main mod in anyway, only purpose is to check if MME scripts are initiated
;To do this we check MME_ScriptsStarted, which should be set be MME to 1 by maintenance() in MilkPlayerLoadGame script
;by it self this script is run once when mod is installed, should be registered by alias script to run on playerloadgame

Event OnInit()
	RegisterForSingleUpdate(60)
EndEvent

Event OnUpdate()
	if StorageUtil.GetIntValue(Game.GetPlayer(), "MME_ScriptsStarted") != 1
		;Debug.Messagebox(JsonUtil.GetStringValue("/MME/Strings", "MME_Status"))
		MilkPluginsInfo()
		int ButtonPressed = (Game.GetFormFromFile(0x6B54A, "MilkModNew.esp") as message).Show()
		if ButtonPressed == 0
			RegisterForSingleUpdate(60)
			Debug.Trace("MilkModEconomy MME_Status: Scripts are not running, retrying in 60 sec")
		else
			Debug.Trace("MilkModEconomy MME_Status: Scripts are not running, screw your scripts, it'll work without them!")
		endif
	else
		StorageUtil.UnsetIntValue(Game.GetPlayer(), "MME_ScriptsStarted")
		Debug.Trace("MilkModEconomy MME_Status: Scripts are running, Unsetting StorageUtil MME_ScriptsStarted, shutting down")
	endif
EndEvent

Function MilkPluginsInfo()
	String msg = ""
	String Status = ""
	int i = 0
	String [] name = new string[10]
	Int[] value = new int[10]
	bool ErrorsFound = False

	;individual check to see if scripts working at all
	;stop quest
	;reset quest (so that scripts run OnInit() during quest start)
	;start quest (OnInit() sends StorageUtil values if script has launched)
	Quest.GetQuest("MME_SLA").stop()
	Quest.GetQuest("MME_SLA").reset()
	Quest.GetQuest("MME_SLA").start()
	Quest.GetQuest("MME_DDi").stop()
	Quest.GetQuest("MME_DDi").reset()
	Quest.GetQuest("MME_DDi").start()
	Quest.GetQuest("MME_zbf").stop()
	Quest.GetQuest("MME_zbf").reset()
	Quest.GetQuest("MME_zbf").start()
	Quest.GetQuest("MME_SLHP").stop()
	Quest.GetQuest("MME_SLHP").reset()
	Quest.GetQuest("MME_SLHP").start()
	Quest.GetQuest("MME_FM").stop()
	Quest.GetQuest("MME_FM").reset()
	Quest.GetQuest("MME_FM").start()
	Quest.GetQuest("MME_SLP").stop()
	Quest.GetQuest("MME_SLP").reset()
	Quest.GetQuest("MME_SLP").start()
	Quest.GetQuest("MME_PSQ").stop()
	Quest.GetQuest("MME_PSQ").reset()
	Quest.GetQuest("MME_PSQ").start()
	Quest.GetQuest("MME_SGO").stop()
	Quest.GetQuest("MME_SGO").reset()
	Quest.GetQuest("MME_SGO").start()
	; these scripts connect to MilkQ and will return error if MilkQ script is broken
	Quest.GetQuest("MME_ineed").stop()
	Quest.GetQuest("MME_ineed").reset()
	Quest.GetQuest("MME_ineed").start()
	Quest.GetQuest("MME_SOS").stop()
	Quest.GetQuest("MME_SOS").reset()
	Quest.GetQuest("MME_SOS").start()
	utility.wait(1) ; wait for quests startup and do their OnInit()

	value[0] = StorageUtil.GetIntValue(none,"MME.PluginsCheck.ddi")
	value[1] = StorageUtil.GetIntValue(none,"MME.PluginsCheck.ineed")
	value[2] = StorageUtil.GetIntValue(none,"MME.PluginsCheck.psq")
	value[3] = StorageUtil.GetIntValue(none,"MME.PluginsCheck.sgo")
	value[4] = StorageUtil.GetIntValue(none,"MME.PluginsCheck.sla")
	value[5] = StorageUtil.GetIntValue(none,"MME.PluginsCheck.slhp")
	value[6] = StorageUtil.GetIntValue(none,"MME.PluginsCheck.slp")
	value[7] = StorageUtil.GetIntValue(none,"MME.PluginsCheck.sos")
	value[8] = StorageUtil.GetIntValue(none,"MME.PluginsCheck.zbf")
	value[9] = StorageUtil.GetIntValue(none,"MME.PluginsCheck.fm")

	name[0] = "MME.PluginsCheck.ddi"
	name[1] = "MME.PluginsCheck.ineed"
	name[2] = "MME.PluginsCheck.psq"
	name[3] = "MME.PluginsCheck.sgo"
	name[4] = "MME.PluginsCheck.sla"
	name[5] = "MME.PluginsCheck.slhp"
	name[6] = "MME.PluginsCheck.slp"
	name[7] = "MME.PluginsCheck.sos"
	name[8] = "MME.PluginsCheck.zbf"
	name[9] = "MME.PluginsCheck.fm"

	msg = "Milk Mod Economy plugins check:\n"
	While i < name.Length
		if value[i] == 1
			Status = "off"
		elseif value[i] == 2
			Status = "on"
		else
			Status = "error"
			ErrorsFound = True
		endif

		msg = msg + ("Plugin: " + name[i] + " Status: " + Status + "\n")
		i += 1
	endwhile
	
	if ErrorsFound == True
		Debug.MessageBox(msg)
	endif
	
	;reset StorageUtil for next run
	StorageUtil.UnSetIntValue(none,"MME.PluginsCheck.ddi")
	StorageUtil.UnSetIntValue(none,"MME.PluginsCheck.ineed")
	StorageUtil.UnSetIntValue(none,"MME.PluginsCheck.psq")
	StorageUtil.UnSetIntValue(none,"MME.PluginsCheck.sgo")
	StorageUtil.UnSetIntValue(none,"MME.PluginsCheck.sla")
	StorageUtil.UnSetIntValue(none,"MME.PluginsCheck.slhp")
	StorageUtil.UnSetIntValue(none,"MME.PluginsCheck.slp")
	StorageUtil.UnSetIntValue(none,"MME.PluginsCheck.sos")
	StorageUtil.UnSetIntValue(none,"MME.PluginsCheck.zbf")
	StorageUtil.UnSetIntValue(none,"MME.PluginsCheck.fm")
EndFunction
