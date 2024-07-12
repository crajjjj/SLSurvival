Scriptname MME_DebugSpellsScr extends activemagiceffect Hidden

Event OnEffectStart(Actor akTarget, Actor akCaster)
	MilkQUEST MilkQ = Quest.GetQuest("MME_MilkQUEST") as MilkQUEST
	Actor PlayerRef = Game.Getplayer()
	
	if !PlayerRef.HasSpell( MilkQ.MilkModToggle )
		PlayerRef.AddSpell( MilkQ.MilkModToggle, false )
	endif
	if !PlayerRef.HasSpell( MilkQ.MilkModInfo )
		PlayerRef.AddSpell( MilkQ.MilkModInfo, false )
	endif
	if !PlayerRef.HasSpell( MilkQ.MilkSelf )
		PlayerRef.AddSpell( MilkQ.MilkSelf, false )
	endif
	if !PlayerRef.HasSpell( MilkQ.MilkTarget )
		PlayerRef.AddSpell( MilkQ.MilkTarget, false )
	endif
	if !PlayerRef.HasSpell( MilkQ.MME_ResetMaids )
		PlayerRef.AddSpell( MilkQ.MME_ResetMaids, false )
	endif
	if !PlayerRef.HasSpell( MilkQ.MME_ResetMod )
		PlayerRef.AddSpell( MilkQ.MME_ResetMod, false )
	endif
	if !PlayerRef.HasSpell( MilkQ.MME_Uninstall )
		PlayerRef.AddSpell( MilkQ.MME_Uninstall, false )
	endif
EndEvent