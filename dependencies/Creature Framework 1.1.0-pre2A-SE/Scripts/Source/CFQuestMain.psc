Scriptname CFQuestMain extends Quest
{The main quest script | Creature Framework}

; General properties
CreatureFramework property API auto hidden
Actor property Player auto
Spell property CloakSpell auto
Spell property CreatureSpell auto
Spell property CreatureApplySpell auto
Spell property TargetPuppetSpell auto

; Whether or not the cloak has been applied at all since load
bool cloakApplied

; Whether or not the creature spell has been added to the player yet
bool playerGotCreatureSpell

; Perform necessary actions every startup
function Maintenance()
	API = CreatureFrameworkUtil.GetAPI()
	CloakSpell.SetNthEffectMagnitude(0, CreatureFrameworkUtil.GetConfig().PrfCloakRange)
	CreatureFrameworkUtil.GetCreatureApplySpell().SetNthEffectDuration(0, CreatureFrameworkUtil.GetConfig().PrfCloakCooldown)
	cloakApplied = false

	; Register for mod events
	UnregisterForAllModEvents()
	RegisterForModEvent("CFInternal_CloakSettingChanged", "OnCloakSettingChange")
	RegisterForModEvent("CFInternal_PuppetTargetKeyChanged", "OnPuppetTargetKeyChange")
	RegisterForModEvent("CFUninstall", "OnUninstall")

	; Register for the puppet target key
	UnregisterForAllKeys()
	RegisterForKey(API.Config.PupTargetKey)

	; Register for an update to handle the cloak spell
	UnregisterForUpdate()
	RegisterForSingleUpdate(0.25)
endFunction

; The cloak rate setting was changed
event OnCloakSettingChange()
	UnregisterForUpdate()
	Player.RemoveSpell(CloakSpell)
	if API.Config.PrfCloakRate > 0
		RegisterForSingleUpdate(API.Config.PrfCloakRate)
	endIf
endEvent

; The puppet target key was changed
event OnPuppetTargetKeyChange()
	UnregisterForAllKeys()
	RegisterForKey(API.Config.PupTargetKey)
	CFDebug.Log("[Main Quest] The puppet target key was changed; registered for new key")
endEvent

; The mod is being uninstalled
event OnUninstall()
	UnregisterForUpdate()
	Player.RemoveSpell(CloakSpell)
endEvent

; A key has been released
event OnKeyUp(int keyCode, float holdTime)
	if keyCode == API.Config.PupTargetKey
		CFDebug.Log("[Main Quest] Player casting target puppet spell")
		TargetPuppetSpell.Cast(Player)
	endIf
endEvent

; An update has been received
event OnUpdate()
	if !API.AreActiveActorsRestarting()
		if !cloakApplied
			cloakApplied = true
			CFDebug.Log("[Main Quest] The cloak is being applied for the first time since game load")
		endIf

		; Handle the player character manually
		if API.IsCreatureOrBeast(Player)
			if !playerGotCreatureSpell
				CreatureApplySpell.Cast(Player, Player)
				playerGotCreatureSpell = true
				CFDebug.Log("[Main Quest] Cast creature apply spell on player")
			endIf
		else
			if playerGotCreatureSpell
				Player.RemoveSpell(CreatureSpell)
				playerGotCreatureSpell = false
				CFDebug.Log("[Main Quest] Removed creature spell from player")
			endIf
		endIf

		; Cloak time
		Player.AddSpell(CloakSpell, false)
		Utility.Wait(API.Config.PrfCloakDuration)
		Player.RemoveSpell(CloakSpell)
	else
		CFDebug.Log("[Main Quest] Skipping cloak application; API is restarting active actors")
	endIf

	if API.Config.PrfCloakRate > 0
		RegisterForSingleUpdate(API.Config.PrfCloakRate)
	endIf
endEvent
