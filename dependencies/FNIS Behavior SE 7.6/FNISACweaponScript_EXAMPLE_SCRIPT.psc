ScriptName FNISACweaponScript extends ObjectReference

;	This is an example script/mod which demonstrates how FNIS Alternate Animations can be used for a specific weapon only
;	It was made for a katana to be used with 
;	Oriental Swordsmanship animation of East Asia by cyh0405 - http://www.nexusmods.com/skyrim/mods/70108
;	Whenever the katana is equipped, the Swordsmanship animations are loaded for the player, and unloaded on unequip.
;	The script requires an animation sub folder with the animations, and a file list FNIS_<mod>_List.txt with the following lines:
;	AAprefix fac
;	AAset _2hmmt 1
;	AAset _2hmatk 1
;	AAset _2hmatkpow 1


actor player
int FNISaa_crc
int FNISaa_ModID
int FNISBase_2hmmt
int FNISBase_2hmatk
int FNISBase_2hmatkpow
int FNISValueOld_2hmmt
int FNISValueOld_2hmatk
int FNISValueOld_2hmatkpow

Event OnInit()
	player = Game.GetPlayer()
EndEvent

Event OnEquipped(Actor akActor)
	if ( akActor == player )
		;Menumode and 1st person: wait til menumode is left
		if Utility.IsInMenuMode()
			if ( player.GetAnimationVariableInt("FNISaa_crc") == 0 )
				Utility.wait(0.01)
			endif
		endif
		Game.ForceThirdPerson()
		
		;can't do anything if FNIS crc == 0 (FNIS generator has failed)
		int FNISaa_crcNew = FNIS_aa.GetInstallationCRC()
		if ( FNISaa_crcNew == 0 )
			return
		endif
		
		;crc has changed: mod ID and base values need to be re-read
		if ( FNISaa_crcNew != FNISaa_crc )
			FNISaa_crc = FNISaa_crcNew
			FNISaa_ModID = FNIS_aa.GetAAmodID("fac", "FNISAlternateCombat", true)
			FNISBase_2hmmt = FNIS_aa.GetGroupBaseValue( FNISaa_ModID, FNIS_aa._2hmmt(), "FNISAlternateCombat", true)
			FNISBase_2hmatk = FNIS_aa.GetGroupBaseValue( FNISaa_ModID, FNIS_aa._2hmatk(), "FNISAlternateCombat", true)
			FNISBase_2hmatkpow = FNIS_aa.GetGroupBaseValue( FNISaa_ModID, FNIS_aa._2hmatkpow(), "FNISAlternateCombat", true)
		endif
		
		;store the current AnimVar values
		FNISValueOld_2hmmt = player.GetAnimationVariableInt("FNISaa_2hmmt")
		FNISValueOld_2hmatk = player.GetAnimationVariableInt("FNISaa_2hmatk")
		FNISValueOld_2hmatkpow = player.GetAnimationVariableInt("FNISaa_2hmatkpow")
		
		;set katana specific AnimVar values
		bool result = FNIS_aa.SetAnimGroup(player, "_2hmmt", FNISBase_2hmmt, 0, "FNISAlternateCombat", true)
		result = result && FNIS_aa.SetAnimGroup(player, "_2hmatk", FNISBase_2hmatk, 0, "FNISAlternateCombat", true)
		result = result && FNIS_aa.SetAnimGroup(player, "_2hmatkpow", FNISBase_2hmatkpow, 0, "FNISAlternateCombat", true)

		if !result
			Debug.MessageBox("FNIS AA could not be activated for katana")
		endif
		Debug.Notification("Katana Animvars set")
	endif
EndEvent

Event OnUnEquipped(Actor akActor)
	if ( akActor == player )
		; reset only when setting has been successful
		if ( FNISaa_crc != 0 )
			;Menumode and 1st person: wait til menumode is left
			if Utility.IsInMenuMode()
				if ( player.GetAnimationVariableInt("FNISaa_crc") == 0 )
					Utility.wait(0.01)
				endif
			endif
			Game.ForceThirdPerson()
			
			;if crc has changed (different installation) the old values are invalid. Reset to vanilla
			if ( FNIS_aa.GetInstallationCRC() != FNISaa_crc )
				FNISValueOld_2hmmt = 0
				FNISValueOld_2hmatk = 0
				FNISValueOld_2hmatkpow = 0
			endif
			
			;re-set the AnimVars (value before equip, or vanilla)
			player.SetAnimationVariableInt("FNISaa_2hmmt", FNISValueOld_2hmmt)
			player.SetAnimationVariableInt("FNISaa_2hmatk", FNISValueOld_2hmatk)
			player.SetAnimationVariableInt("FNISaa_2hmatkpow", FNISValueOld_2hmatkpow)
			Debug.Notification("Katana Animvars reset")
		endif
	endif
EndEvent
