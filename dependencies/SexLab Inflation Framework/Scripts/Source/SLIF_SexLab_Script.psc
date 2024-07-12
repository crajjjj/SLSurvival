Scriptname SLIF_SexLab_Script Hidden

Int Function GetGender(Actor kActor, int gender) Global
	
	if (gender == -1)
		
		SexLabFramework SexLab = Game.GetFormFromFile(0xD62,"SexLab.esm") as SexLabFramework
		if (SexLab)
			int sexlab_gender = SexLab.GetGender(kActor)
			if (sexlab_gender != -1)
				if (sexlab_gender == 0)
					return 0
				elseIf (sexlab_gender == 1)
					return 1
				elseIf (sexlab_gender == 2)
					return 5
				elseIf (sexlab_gender == 3)
					return 6
				endIf
			endIf
		endIf
		
	endIf
	
	return gender
EndFunction

Function ForceSexLabGenderForActorList() Global
	ForceSexLabGenderByList("slif_actor_list")
	ForceSexLabGenderByList("slif_morph_actor_list")
EndFunction

Function ForceSexLabGenderByList(String list) Global
	int count = StorageUtil.FormListCount(none, list)
	int i = 0
	while(i < count)
		Actor kActor = StorageUtil.FormListGet(none, list, i) as Actor
		ForceSexLabGender(kActor)
		i += 1
	endWhile
EndFunction

Function ForceSexLabGender(Actor kActor) Global
	if (SLIF_Util.isModInstalled("SexLab.esm"))
		SexLabFramework SexLab = Game.GetFormFromFile(0xD62,"SexLab.esm") as SexLabFramework
		
		bool treat_male_as_female = SLIF_Config.GetInt("treat_male_as_female") as bool
		bool treat_trans_as_male  = SLIF_Config.GetInt("treat_trans_as_male") as bool
		
		int gender           = StorageUtil.GetIntValue(kActor, "slif_gender")
		bool male            = gender == 0
		bool female          = gender == 1
		bool shemale         = gender == 2
		bool futanari        = gender == 3
		bool genderless      = gender == 4
		bool male_creature   = gender == 5
		bool female_creature = gender == 6
		
		bool isFemale = kActor.GetLeveledActorBase().GetSex() == 1
		bool isMale   = isFemale == false
			
		if (treat_male_as_female && isMale && (female || shemale || futanari))
			SexLab.TreatAsFemale(kActor)
		elseIf (treat_trans_as_male && isFemale && (male || shemale || futanari))
			SexLab.TreatAsMale(kActor)
		else
			SexLab.ClearForcedGender(kActor)
		endIf
	endIf
EndFunction
