Scriptname rapeTattoos_utils hidden

; Returns retained JMap mapping texture paths to a sub-jmap with extra data
int function getDataMap() global
    return getConfigFile("settings.json", "rTatsSettingsTemplate.json")
endfunction

; Returns retained JMap with weighted tattoo color configuration settings
int function getColorConfig() global
    return getConfigFile("colorConfig.json", "rTatsColorConfigTemplate.json")
endfunction

int function getConfigFile(string userFilename, string templateFilename) global
    int config = 0
	string userConfigPath = JContainers.userDirectory() + "rTats/" + userFilename
	log("Attempting to read user config file at \"rTats/" + userFilename + "\"")
	if (JContainers.fileExistsAtPath(userConfigPath))
		config = JValue.readFromFile(userConfigPath)
	endif
	if config == 0
		log("Could not read user config file - falling back to template at \"Data/" + templateFilename + "\"")
		; File does not exist, fall back to template
		config = JValue.readFromFile("Data/" + templateFilename)
	endif
	log("Config file loaded - " + JMap.count(config) + " tattoo mappings found")
	return JValue.retain(config)
endfunction

; Checks if Zaz Animation Pack is installed
bool function isZazInstalled() global
	return Game.GetModByName("ZaZAnimationPack.esm") != 255
endfunction

; Retrieves the Zaz slave faction from Zaz Animation Pack, if present
Faction function getZazSlaveFaction() global
	if isZazInstalled()
		return Game.GetFormFromFile(0x000096AE, "ZaZAnimationPack.esm") as Faction
	endif
	return None
endfunction

function log(string msg) global
	msg = "[ Rape Tattoos ] " + msg
	Debug.Trace(msg)
endfunction