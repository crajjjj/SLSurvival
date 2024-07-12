Scriptname RND_MaintenanceScript extends activemagiceffect  

GlobalVariable Property RND_ModVersion Auto

GlobalVariable Property RND_HasSKSE Auto
GlobalVariable Property RND_HasSkyUI Auto

Quest Property RNDConfigQuest Auto
Quest Property RNDTrackingQuest Auto
Quest Property RNDReminderQuest Auto
Quest Property RNDSpoilageQuest Auto

RND_PlayerScript Property RND_Player Auto

event OnEffectStart(Actor akTarget, Actor akCaster)
	
	if (SKSE.GetVersion() + SKSE.GetVersionMinor() * 0.01 + SKSE.GetVersionBeta() * 0.0001) >= 1.0605
		RND_HasSKSE.SetValue(1)
	else
		RND_HasSKSE.SetValue(0)
		Debug.Trace("RND: SKSE 1.06.06+ not found...")
	endif
	
	if Game.GetFormFromFile(0x00000802, "SkyUI_SE.esp")
		RND_HasSkyUI.SetValue(1)
	else
		RND_HasSkyUI.SetValue(0)
		Debug.Trace("RND: SkyUI SE not found...")
	endif
	
	if RND_ModVersion.GetValue() < 1.99 ; Current version
	
		if RND_ModVersion.GetValue() > 0
			RNDConfigQuest.Stop()
			Utility.Wait(1)
			RNDConfigQuest.Start()
		endif

		if RND_State.GetValue() == 1
			RND_State.SetValue(0)
			RNDTrackingQuest.Stop()
			RNDReminderQuest.Stop()
			RNDSpoilageQuest.Stop()
			RND_RemoveNeedsSpell.Cast(Game.GetPlayer(), Game.GetPlayer())
			RND_CureDiseaseSpell.Cast(Game.GetPlayer(), Game.GetPlayer())
			
			Utility.Wait(1)
			RND_State.SetValue(1)
			RNDTrackingQuest.Start()
			RNDReminderQuest.Start()
			RNDSpoilageQuest.Start()
			RND_InitNeedsSpell.Cast(Game.GetPlayer(), Game.GetPlayer())
		endif
		
		RND_InitMessage.Show()
		Utility.Wait(3)

		if RND_HasSKSE.GetValue() == 0 || RND_HasSkyUI.GetValue() == 0
			Game.GetPlayer().AddItem(RND_SugarBall, 1)			
		endif
		
		RND_ModVersion.SetValue(1.99)

	endif
	
	if RNDTrackingQuest.isRunning()
		RND_Player.mapKey()
		RND_Player.chkDLC()
	endif
	
endEvent

Spell Property RND_InitNeedsSpell Auto
Spell Property RND_CureDiseaseSpell Auto
Spell Property RND_RemoveNeedsSpell Auto

Potion Property RND_SugarBall Auto
GlobalVariable Property RND_State Auto
Message Property RND_InitMessage Auto

