scriptname FrostUtil hidden

; Frostfall SDK Required External -- DO NOT RECOMPILE
string script_name = "FrostUtil"
Event OnInit()
    while true
        debug.messagebox("Mod Developer: You have recompiled " + script_name + " in the Frostfall Dev Kit. Please exit and delete " + script_name + ".pex from your scripts directory; reinstalling Dev Kit might be necessary. This message will repeat.")
        utility.wait(1)
    endWhile
endEvent

FrostfallAPI function GetAPI() global
    return None
endFunction

; System Access ===================================================================================

; These are not intended for public use and are therefore undocumented.

_Frost_ExposureSystem function GetExposureSystem() global
    return None
endFunction

_Frost_ClothingSystem function GetClothingSystem() global
    return None
endFunction

_Frost_InterfaceHandler function GetInterfaceHandler() global
    return None
endFunction

_Frost_ExposureMeterInterfaceHandler function GetExposureMeterHandler() global
    return None
endFunction

_Frost_WetnessMeterInterfaceHandler function GetWetnessMeterHandler() global
    return None
endFunction

_Frost_WeatherMeterInterfaceHandler function GetWeathersenseMeterHandler() global
    return None
endFunction

_Frost_ArmorProtectionDatastoreHandler function GetClothingDatastoreHandler() global
    return None
endFunction

_Frost_LegacyArmorDatastore function GetLegacyArmorDatastore() global
    return None
endFunction

_Frost_Compatibility function GetCompatibilitySystem() global
    return None
endFunction

_Frost_HeatSourceSystem function GetHeatSourceSystem() global
    return None
endFunction

_Frost_WetnessSystem function GetWetnessSystem() global
    return None
endFunction

_Frost_ClimateSystem function GetClimateSystem() global
    return None
endFunction

_Frost_WarmthSystem function GetWarmthSystem() global
    return None
endFunction

_Frost_CoverageSystem function GetCoverageSystem() global
    return None
endFunction

_Frost_RescueSystem function GetRescueSystem() global
    return None
endFunction

_Frost_ShelterSystem function GetShelterSystem() global
    return None
endFunction

_Frost_PlayerStateSystem function GetPlayerStateSystem() global
    return None
endFunction

_Frost_FrostResistSystem function GetFrostResistSystem() global
    return None
endFunction

FallbackEventEmitter function GetEventEmitter_UpdateWarmth() global
    return None
endFunction

FallbackEventEmitter function GetEventEmitter_UpdateCoverage() global
    return None
endFunction

FallbackEventEmitter function GetEventEmitter_OnTamrielRegionChange() global
    return None
endFunction

FallbackEventEmitter function GetEventEmitter_OnConjuredObjectIDUpdated() global
    return None
endFunction

FallbackEventEmitter function GetEventEmitter_OnRescuePlayer() global
    return None
endFunction

FallbackEventEmitter function GetEventEmitter_DispelBoundCloaks() global
    return None
endFunction

FallbackEventEmitter function GetEventEmitter_OnInnerFireMeditate() global
    return None
endFunction

FallbackEventEmitter function GetEventEmitter_OnPlayerStartSwimming() global
    return None
endFunction

FallbackEventEmitter function GetEventEmitter_OnPlayerStopSwimming() global
    return None
endFunction

FallbackEventEmitter function GetEventEmitter_SoupEffectStart() global
    return None
endFunction

FallbackEventEmitter function GetEventEmitter_SoupEffectStop() global
    return None
endFunction

FallbackEventEmitter function GetEventEmitter_FrostfallLoaded() global
    return None
endFunction

FallbackEventEmitter function GetEventEmitter_StartFrostfall() global
    return None
endFunction

FallbackEventEmitter function GetEventEmitter_StopFrostfall() global
    return None
endFunction

bool function IsArmorShield(Armor akArmor) global
    return false
endFunction

bool function IsArmorCloak(Armor akArmor) global
    return false
endFunction

bool function IsWarmEnoughToRemoveGearInTent() global
    return false
endFunction

; Public Functions ================================================================================

;/********f* FrostUtil/GetAPIVersion
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Get the FrostUtil API version number.
*
* SYNTAX
*/;
float function GetAPIVersion() global
    return -1.0
endFunction

;/********f* FrostUtil/GetFrostfallVersion
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Get the Frostfall mod version number.
*
* SYNTAX
*/;
float function GetFrostfallVersion() global
    return -1.0
endFunction

;/********f* FrostUtil/IsPlayerNearFire
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Whether or not the player is currently near a fire.
*
* SYNTAX
*/;
bool function IsPlayerNearFire() global
    return false
endFunction

;/********f* FrostUtil/GetPlayerHeatSourceLevel
* API VERSION ADDED
* 1
*
* DESCRIPTION
* The level (size) of the player's current nearby heat source.
*
* SYNTAX
*/;
int function GetPlayerHeatSourceLevel() global
    return -1
endFunction

;/********f* FrostUtil/GetPlayerHeatSourceDistance
* API VERSION ADDED
* 1
*
* DESCRIPTION
* The distance from the player to the player's current nearby heat source.
*
* SYNTAX
*/;
float function GetPlayerHeatSourceDistance() global
    return -1.0
endFunction

;/********f* FrostUtil/IsPlayerTakingShelter
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Whether or not the player is taking shelter underneath an outcropping / building. If the
* player is "sheltered", the player will dry off if wet, regardless of current weather conditions.
*
* SYNTAX
*/;
bool function IsPlayerTakingShelter() global
    return false
endFunction

;/********f* FrostUtil/IsNearFastTravelException
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Whether or not the player near a "fast travel exception". If a player is nearby one of these objects, the
* Exposure System will re-enable the player's Fast Travel controls. This is used in cases where there is an
* expectation for Fast Travel be enabled when near these objects (like Apocrypha's Black Books.)
*
* SYNTAX
*/;
bool function IsNearFastTravelException() global
    return false
endFunction

;/********f* FrostUtil/GetCurrentTemperature
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Returns the current area temperature, based on location, weather, weather severity, and time of day.
*
* SYNTAX
*/;
int function GetCurrentTemperature() global
    return -1
endFunction

;/********f* FrostUtil/GetCurrentWeatherActual
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Returns the current weather somewhat more accurately than the default GetCurrentWeather() function.
* This function returns the outgoing weather if the weather is currently transitioning out (and thus is
* still currently visible). Otherwise, returns the current weather.
*
* SYNTAX
*/;
Weather function GetCurrentWeatherActual() global
    return None
endFunction

;/********f* FrostUtil/GetWeatherClassificationActual
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Returns the classification of the weather returned by GetCurrentWeatherActual().
*
* SYNTAX
*/;
int function GetWeatherClassificationActual(Weather akWeather) global
    return -1
endFunction

;/********f* FrostUtil/IsWeatherSevere
* API VERSION ADDED
* 1
*
* DESCRIPTION
* True if this weather is in the severe weather list that Frostfall maintains, false if not.
*
* SYNTAX
*/;
bool function IsWeatherSevere(Weather akWeather) global
    return false
endFunction

;/********f* FrostUtil/AddSevereWeather
* API VERSION ADDED
* 2
*
* DESCRIPTION
* Adds a weather to the severe weather list that Frostfall maintains.
*
* SYNTAX
*/;
function AddSevereWeather(Weather akWeather) global
    return 
endFunction

;/********f* FrostUtil/RemoveSevereWeather
* API VERSION ADDED
* 2
*
* DESCRIPTION
* Removes a weather from the severe weather list that Frostfall maintains. Only weather forms added
* to the list via AddSevereWeather can be removed.
*
* SYNTAX
*/;
function RemoveSevereWeather(Weather akWeather) global
    return 
endFunction

;/********f* FrostUtil/IsWeatherOvercast
* API VERSION ADDED
* 1
*
* DESCRIPTION
* True if this weather is in the overcast weather list that Frostfall maintains, false if not.
*
* SYNTAX
*/;
bool function IsWeatherOvercast(Weather akWeather) global
    return false
endFunction

;/********f* FrostUtil/AddOvercastWeather
* API VERSION ADDED
* 2
*
* DESCRIPTION
* Adds a weather to the overcast weather list that Frostfall maintains.
*
* SYNTAX
*/;
function AddOvercastWeather(Weather akWeather) global
    return 
endFunction

;/********f* FrostUtil/RemoveOvercastWeather
* API VERSION ADDED
* 2
*
* DESCRIPTION
* Removes a weather from the overcast weather list that Frostfall maintains. Only weather forms added
* to the list via AddOvercastWeather can be removed.
*
* SYNTAX
*/;
function RemoveOvercastWeather(Weather akWeather) global
    return 
endFunction

;/********f* FrostUtil/IsRefInOblivion
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Whether or not the reference is in a base game or DLC Oblivion worldspace.
*
* SYNTAX
*/;
bool function IsRefInOblivion(ObjectReference akReference) global
    return false
endFunction

;/********f* FrostUtil/IsOblivionWorldspace
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Whether or not the worldspace is a base game or DLC Oblivion worldspace.
*
* SYNTAX
*/;
bool function IsOblivionWorldspace(Worldspace akWorldspace) global
    return false
endFunction

;/********f* FrostUtil/AddOblivionWorldspace
* API VERSION ADDED
* 2
*
* DESCRIPTION
* Adds a worldspace to the Oblivion worldspace list that Frostfall maintains. The player does not gain exposure when in planes of Oblivion.
*
* SYNTAX
*/;
function AddOblivionWorldspace(Worldspace akWorldspace) global
    return 
endFunction

;/********f* FrostUtil/RemoveOblivionWorldspace
* API VERSION ADDED
* 2
*
* DESCRIPTION
* Removes a worldspace from the Oblivion worldspace list that Frostfall maintains. The player does not gain exposure when in planes of Oblivion.
* Only Worldspace forms added to the list via AddOblivionWorldspace can be removed.
*
* SYNTAX
*/;
function RemoveOblivionWorldspace(Worldspace akWorldspace) global
    return 
endFunction

;/********f* FrostUtil/IsExposureException
* API VERSION ADDED
* 2
*
* DESCRIPTION
* True if this form is in the exposure exception list that Frostfall maintains, false if not. When the player goes near this object (600 units or less),
* the player will not gain or lose exposure.
*
* SYNTAX
*/;
bool function IsExposureException(Form akBaseObject) global
    return false
endFunction

;/********f* FrostUtil/AddExposureException
* API VERSION ADDED
* 2
*
* DESCRIPTION
* Adds a form to the list of exposure exception objects that Frostfall maintains. When the player goes near this object (600 units or less),
* the player will not gain or lose exposure.
*
* SYNTAX
*/;
function AddExposureException(Form akBaseObject) global
    return 
endFunction

;/********f* FrostUtil/RemoveExposureException
* API VERSION ADDED
* 2
*
* DESCRIPTION
* Removes a form from the list of exposure exception objects that Frostfall maintains.
* Only forms added to the list via AddExposureException can be removed.
*
* SYNTAX
*/;
function RemoveExposureException(Form akBaseObject) global
    return 
endFunction

;/********f* FrostUtil/IsFastTravelException
* API VERSION ADDED
* 2
*
* DESCRIPTION
* True if this form is in the fast travel exception list that Frostfall maintains, false if not. When the player goes near this object (600 units or less),
* fast travel controls will be re-enabled regardless of their fast travel settings.
*
* SYNTAX
*/;
bool function IsFastTravelException(Form akBaseObject) global
    return false
endFunction

;/********f* FrostUtil/AddFastTravelException
* API VERSION ADDED
* 2
*
* DESCRIPTION
* Adds a form to the list of fast travel exception objects that Frostfall maintains. When the player goes near this object (600 units or less),
* fast travel controls will be re-enabled regardless of their fast travel settings.
*
* SYNTAX
*/;
function AddFastTravelException(Form akBaseObject) global
    return 
endFunction

;/********f* FrostUtil/RemoveFastTravelException
* API VERSION ADDED
* 2
*
* DESCRIPTION
* Removes a form from the list of fast travel exception objects that Frostfall maintains.
* Only forms added to the list via AddFastTravelException can be removed.
*
* SYNTAX
*/;
function RemoveFastTravelException(Form akBaseObject) global
    return 
endFunction

;/********f* FrostUtil/IsSleepException
* API VERSION ADDED
* 2
*
* DESCRIPTION
* True if this form is in the sleep exception list that Frostfall maintains, false if not.
*
* SYNTAX
*/;
bool function IsSleepException(Form akBaseObject) global
    return false
endFunction

;/********f* FrostUtil/AddSleepException
* API VERSION ADDED
* 2
*
* DESCRIPTION
* Adds a form to the list of sleep exception objects that Frostfall maintains. When the player goes near this object (600 units or less),
* the player will be able to sleep. This is important if the player has "Disable Waiting Outdoors" enabled, which prevents
* sleeping unless near an object in this list.
*
* SYNTAX
*/;
function AddSleepException(Form akBaseObject) global
    return 
endFunction

;/********f* FrostUtil/RemoveSleepException
* API VERSION ADDED
* 2
*
* DESCRIPTION
* Removes a form from the list of sleep exception objects that Frostfall maintains.
* Only forms added to the list via AddSleepException can be removed.
*
* SYNTAX
*/;
function RemoveSleepException(Form akBaseObject) global
    return 
endFunction

;/********f* FrostUtil/AddFastTravelWorldspaceException
* API VERSION ADDED
* 2
*
* DESCRIPTION
* Adds a worldspace to the list of worldspaces that Frostfall maintains where fast travel controls should always be enabled.
*
* SYNTAX
*/;
function AddFastTravelWorldspaceException(Worldspace akWorldspace) global
    return 
endFunction

;/********f* FrostUtil/RemoveFastTravelWorldspaceException
* API VERSION ADDED
* 2
*
* DESCRIPTION
* Adds a worldspace to the list of worldspaces that Frostfall maintains where fast travel controls should always be enabled.
* Only Worldspace forms added to the list via AddFastTravelWorldspaceException can be removed.
*
* SYNTAX
*/;
function RemoveFastTravelWorldspaceException(Worldspace akWorldspace) global
    return 
endFunction

;/********f* FrostUtil/GetPlayerWetness
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Return the player's current wetness value.
*
* SYNTAX
*/;
float function GetPlayerWetness() global
    return -1.0
endFunction

;/********f* FrostUtil/GetPlayerWetnessLevel
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Return the player's current wetness level. May be easier to use than GetPlayerWetness() if you don't
* need to know the actual wetness value.
*
* SYNTAX
*/;
int function GetPlayerWetnessLevel() global
    return -1
endFunction

;/********f* FrostUtil/ModPlayerWetness
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Modify the player's current wetness by the given amount. Using this
* function will correctly process the wetness change and notify the UI layer
* (meters, etc) of the change and display them as appropriate. Using this function
* is the only safe method of directly modifying the player's wetness value.
*
* SYNTAX
*/;
function ModPlayerWetness(float amount, float limit = -1.0) global
    return 
endFunction

;/********f* FrostUtil/GetPlayerExposure
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Return the player's current exposure value.
*
* SYNTAX
*/;
float function GetPlayerExposure() global
    return -1.0
endFunction

;/********f* FrostUtil/GetPlayerExposureLevel
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Return the player's current exposure level. May be easier to use than GetPlayerExposure() if you don't
* need to know the actual exposure value.
*
* SYNTAX
*/;
int function GetPlayerExposureLevel() global
    return -1
endFunction

;/********f* FrostUtil/GetPlayerExposureLimit
* API VERSION ADDED
* 3
*
* DESCRIPTION
* Return the player's current exposure limit value, the value that exposure will be attracted to over time.
*
* SYNTAX
*/;
float function GetPlayerExposureLimit() global
    return -1.0
endFunction

;/********f* FrostUtil/ModPlayerExposure
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Modify the player's current exposure by the given amount. Using this
* function will correctly process the exposure change and notify the UI layer
* (meters, etc) of the change and display them as appropriate. Using this function
* is the only safe method of directly modifying the player's exposure value.
*
* SYNTAX
*/;
function ModPlayerExposure(float amount, float limit = -1.0) global
    return 
endFunction

;/********f* FrostUtil/GetPlayerWarmth
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Returns the player's total Warmth value.
*
* SYNTAX
*/;
int function GetPlayerWarmth() global
    return -1
endFunction

;/********f* FrostUtil/GetPlayerCoverage
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Returns the player's total Coverage value.
*
* SYNTAX
*/;
int function GetPlayerCoverage() global
    return -1
endFunction

;/********f* FrostUtil/GetPlayerArmorWarmth
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Returns the sum of the Warmth values of all gear worn by the player.
*
* SYNTAX
*/;
int function GetPlayerArmorWarmth() global
    return -1
endFunction

;/********f* FrostUtil/GetPlayerArmorCoverage
* API VERSION ADDED
* 1
*
* DESCRIPTION
* Returns the sum of the Coverage values of all gear worn by the player.
*
* SYNTAX
*/;
int function GetPlayerArmorCoverage() global
    return -1
endFunction

;/********f* FrostUtil/ArmorProtectionDataExists
* API VERSION ADDED
* 3
*
* DESCRIPTION
* Whether or not the player's current profile (or the default values profile) contains data about this armor.
*
* SYNTAX
*/;
bool function ArmorProtectionDataExists(Armor akArmor) global
    return false
endFunction

;/********f* FrostUtil/ArmorProtectionDataExistsByKey
* API VERSION ADDED
* 3
*
* DESCRIPTION
* Whether or not the player's current profile (or the default values profile) contains data about this armor, by datastore key.
*
* SYNTAX
*/;
bool function ArmorProtectionDataExistsByKey(string asKey) global
    return false
endFunction

; Events ==========================================================================================

;/********e* FrostUtil/Frostfall_OnPlayerStartSwimming
* API VERSION ADDED
* 1
*
* DESCRIPTION
* An SKSE Mod Event that is raised when the player begins swimming.
*
* SYNTAX
Event Frostfall_OnPlayerStartSwimming()
    return 
EndEvent

Event Frostfall_OnPlayerStartSwimming()
    return 
EndEvent
;*********/;
function SendEvent_OnPlayerStartSwimming() global
    return 
endFunction

;/********e* FrostUtil/Frostfall_OnPlayerStopSwimming
* API VERSION ADDED
* 1
*
* DESCRIPTION
* An SKSE Mod Event that is raised when the player stops swimming.
*
* SYNTAX
Event Frostfall_OnPlayerStopSwimming()
    return 
EndEvent

Event Frostfall_OnPlayerStopSwimming()
    return 
EndEvent
;*********/;
function SendEvent_OnPlayerStopSwimming() global
    return 
endFunction

function RaiseFrostAPIError() global
    return 
endFunction


; Mod Event Documentation =========================================================================

;/********e* FrostUtil/Frostfall_Loaded
* API VERSION ADDED
* 1
*
* DESCRIPTION
* An SKSE Mod Event that is raised when Frostfall is finished starting up, or after loading a save game with Frostfall enabled.
*
* SYNTAX
Event Frostfall_Loaded()
    return 
EndEvent

Event Frostfall_Loaded()
    return 
EndEvent
* NOTES
* This event will only be raised if Frostfall is enabled. Therefore, don't rely
* on this event at game start-up for a critical function as you will not receive it
* until the player starts up Frostfall or loads a game with Frostfall already enabled.
;*********/;

;/********e* FrostUtil/Frost_OnRescuePlayer
* API VERSION ADDED
* 1
*
* DESCRIPTION
* An SKSE Mod Event that is raised when the player is rescued when using the Max Exposure Rescue mechanic.
*
* SYNTAX
Event Frost_OnRescuePlayer(bool in_water)
    return 
EndEvent

Event Frost_OnRescuePlayer(bool in_water)
    return 
EndEvent
;*********/;

;/********e* FrostUtil/Frost_OnTamrielRegionChange
* API VERSION ADDED
* 1
*
* DESCRIPTION
* An SKSE Mod Event that is raised when the player moves from one tracked region to another.
*
* SYNTAX
Event OnTamrielRegionChange(int region, bool in_region)
    return 
EndEvent

Event Frost_OnTamrielRegionChange(int region, bool in_region)
    return 
EndEvent
* NOTES
* The following are possible region IDs:
* * REGION_UNKNOWN = -1
* * REGION_PINEFOREST = 1
* * REGION_VOLCANICTUNDRA = 2
* * REGION_FALLFOREST = 3
* * REGION_REACH = 4
* * REGION_TUNDRA = 5
* * REGION_TUNDRAMARSH = 6
* * REGION_COAST = 7
* * REGION_SNOW = 8
* * REGION_OBLIVION = 9
* * REGION_FALMERVALLEY = 10
* * REGION_SOLSTHEIM = 11
* * REGION_WYRMSTOOTH = 20
* * REGION_DARKEND = 21
;*********/;

;/********e* FrostUtil/Frost_OnInnerFireMeditate
* API VERSION ADDED
* 1
*
* DESCRIPTION
* An SKSE Mod Event that is raised when the player begins or ends using the Inner Fire ability.
*
* SYNTAX
Event Frost_OnInnerFireMeditate(bool abMeditating)
    return 
EndEvent

Event Frost_OnInnerFireMeditate(bool abMeditating)
    return 
EndEvent
;*********/;

; Deprecated / Unused Functions ===================================================================

bool function IsWarmEnoughToHarvestWood() global
    return false
endFunction

function Event_LegacyWoodHarvest() global
    return 
endFunction
