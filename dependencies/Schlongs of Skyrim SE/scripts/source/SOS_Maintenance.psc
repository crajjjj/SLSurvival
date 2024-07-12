Scriptname SOS_Maintenance extends Quest

SOS_SetupQuest_Script Property SOS Auto
SOS_PlayerAliasScript Property PlayerAliasScript Auto
Bool firstTime

Event OnInit()
	Init()
EndEvent

Function Init()
	If !CheckRequirements()
		Return
	EndIf
	
	int installedVersion = CheckUpdate()
	
	If firstTime
		SOS.Start()
	Else
		PlayerAliasScript.CheckAddons()
	EndIf
	
	SOS.SOS_VersionInt = installedVersion
	
	SOS.Initialize(firstTime)
EndFunction

Int Function CheckUpdate()
	
	Int loadedVersion = SOS.SOS_VersionInt
	Int installedVersion = 300004 ; Current version
	Debug.Trace("SOS Maintenance: loaded version is " + loadedVersion)
	firstTime = False
	
	If loadedVersion < installedVersion
	
		If loadedVersion
		
			Debug.Trace("SOS: updating to version 3.00.004") ; Current version

			If loadedVersion < 300000
				SOS_Data.ClearConcealingArmors()
				SOS_Data.ClearRevealingArmors()
			EndIf
			If loadedVersion < 300002
				SOS.config.PerformVersionUpdate(300002)
			EndIf

			; add switch for each subsequent release here
			SOS.Notify("$SOS update complete")

		ElseIf SOS.SOS_Version
			; in 2.04.012 (and 2.05.026) the version number was changed to int to avoid floating point issues
			; fix version
			SOS.SOS_VersionInt = (SOS.SOS_Version * 100000) as Int
			; re-run the update
			Return CheckUpdate()
		Else
			; no version saved
			firstTime = True
			
		Endif

	else
		Debug.Trace("SOS Maintenance: " + SOS.SOS_VersionInt + " is update")
	endIf
	
	Return installedVersion

EndFunction

Bool Function CheckRequirements()
	int minSkseVersion = 55 ; version 2.0.6
	String minSkseVersionStr = "2.0.6"
	int minSOSVersion = 300004
	
	bool ok = SKSE.GetVersionRelease() >= minSkseVersion
	If !ok
		Debug.TraceAndBox("SOS Warning!\n\nSKSE not found, or the installed version is too old.\n\nFound " + SKSE.GetVersion() + "." + SKSE.GetVersionMinor()+ "." + SKSE.GetVersionBeta() + ", expected " + minSkseVersionStr + " or higher.\n\nPlease exit the game without saving and install the last SKSE version")
		Return false
	EndIf
	
	ok = SKSE.GetPluginVersion("SchlongsOfSkyrim") >= minSOSVersion
	If !ok
		Debug.TraceAndBox("SOS Warning!\n\nSchlongsOfSkyrim.dll not found, or the installed version is too old.\n\nFound " + SKSE.GetPluginVersion("SchlongsOfSkyrim") + ", expected " + minSOSVersion + ".\n\nPlease exit the game and reinstall SOS")
		Return false
	EndIf

	Return true
EndFunction
