scriptname sslAnimationDefaults extends sslAnimationFactory


;/ 

For JSON loading animation instructions, see /data/SKSE/Plugins/SexLab/Animations/_README_.txt

/;

function LoadAnimations()
	; Prepare factory resources (as non creature)
	PrepareFactory()

	if Game.GetCameraState() == 0
		if Utility.IsInMenuMode()
			MiscUtil.PrintConsole("WARNING! To continue with the SexLab animations setup close the console and all the menu")
		endIf
		Utility.Wait(0.1)
		Game.ForceThirdPerson()
	endIf
	bool SexLabDefault = Game.GetPlayer().GetAnimationVariableInt("SexLabDefault") >= 16300
	
	; Foreplay
	if SexLabDefault
		RegisterAnimation("zjBreastFeeding")
		RegisterAnimation("zjBreastFeedingVar")
	endIf
	RegisterCategory("Foreplay")

	; Register any remaining custom categories from json loaders
	RegisterOtherCategories()
endFunction

function zjBreastFeeding(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "3jiou Breastfeeding Lesbian"
	Base.SoundFX = Sucking

	int a1 = Base.AddPosition(Female)
	Base.AddPositionStage(a1, "3j_BreastFeeding_A1_S1", 0)
	Base.AddPositionStage(a1, "3j_BreastFeeding_A1_S2", 0)
	Base.AddPositionStage(a1, "3j_BreastFeeding_A1_S3", 0, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "3j_BreastFeeding_A1_S4", 0)
	
	int a2 = Base.AddPosition(Female)
	Base.AddPositionStage(a2, "3j_BreastFeeding_A2_S1", -2, up = 1, silent = true, openMouth = true)
	Base.AddPositionStage(a2, "3j_BreastFeeding_A2_S2", -0.5, up = 2, silent = true, openMouth = true)
	Base.AddPositionStage(a2, "3j_BreastFeeding_A2_S3", 2, up = 2)
	Base.AddPositionStage(a2, "3j_BreastFeeding_A2_S4", 0)

	Base.SetTags("3jiou,Boobs,Breast,Hands,Pussy,Mouth,Breastfeeding,Boobjob,Loving,Foreplay,Leadin,Kissing,Lesbian")

	Base.Save(id)
endFunction


function zjBreastFeedingVar(int id)
	sslBaseAnimation Base = Create(id)

	Base.Name = "3jiou Breastfeeding Straight"
	Base.SoundFX = Sucking

	int a1 = Base.AddPosition(Female)
	Base.AddPositionStage(a1, "3j_BreastFeedingvar_A1_S1", 0)
	Base.AddPositionStage(a1, "3j_BreastFeedingvar_A1_S2", 0)
	Base.AddPositionStage(a1, "3j_BreastFeedingvar_A1_S3", 0, silent = true, openMouth = true)
	Base.AddPositionStage(a1, "3j_BreastFeedingvar_A1_S3", 0)
	
	int a2 = Base.AddPosition(Male, addCum=Vaginal)
	Base.AddPositionStage(a2, "3j_BreastFeedingvar_A2_S1", -2, up = 1, silent = true, openMouth = true)
	Base.AddPositionStage(a2, "3j_BreastFeedingvar_A2_S2", -0.5, up = 2, silent = true, openMouth = true)
	Base.AddPositionStage(a2, "3j_BreastFeedingvar_A2_S3", 2, up = 2, sos = -1)		
	Base.AddPositionStage(a2, "3j_BreastFeedingvar_A2_S3", 0, sos = -1)	

	Base.SetTags("3jiou,Sex,Straight,Boobs,Breast,Hands,Pussy,Mouth,Breastfeeding,Handjob,Loving,HandsCum")

	Base.Save(id)
endFunction
