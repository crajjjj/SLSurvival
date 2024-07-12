Scriptname zadcAnims extends sslAnimationFactory

SexlabFramework Property Sexlab Auto
zadLibs Property libs Auto
zadclibs Property clib Auto

function LoadAnimations()
	libs.log("Devious Devices Contraptions is now creating sex animations.")
	SexLab = SexLabUtil.GetAPI()
	If SexLab == None
		libs.Error("Animation registration failed: Sexlab is none.")
	EndIf
	if clib == None
		libs.Error("Animation registration failed: Quest is none.")
	EndIf
	SexLab.GetSetAnimationObject("DDZapPillorySex01", "CreateDDZapPillorySex01", clib)
	SexLab.GetSetAnimationObject("DDZapPillorySex02", "CreateDDZapPillorySex02", clib)
	SexLab.GetSetAnimationObject("DDZapPillorySex03", "CreateDDZapPillorySex03", clib)
	SexLab.GetSetAnimationObject("DDZapPilloryLick01", "CreateDDZapPilloryLick01", clib)
EndFunction

Function CreateDDZapPillorySex01(int id)
	String asAnim1 = "DDZapPillorySex01"
	String asAnim2 = "DDZapPillorySex01"
	
	sslBaseAnimation Anim = SexLab.GetAnimationObject("DDZapPillorySex01")
	if Anim != none && Anim.Name != "DDZapPillorySex01"
		Anim.Name = "DDZapPillorySex01"
		Anim.SetContent(Sexual)
		Anim.SoundFX = Squishing

		Int B = Anim.AddPosition(Female, AddCum = Vaginal)
		Anim.AddPositionStage(B, asAnim1 + "_A1_S1")
		Anim.AddPositionStage(B, asAnim1 + "_A1_S2")
		Anim.AddPositionStage(B, asAnim1 + "_A1_S3")
		Anim.AddPositionStage(B, asAnim1 + "_A1_S4")
		Anim.AddPositionStage(B, asAnim1 + "_A1_S5")
		Anim.AddPositionStage(B, asAnim1 + "_A1_S6")

		Int A = Anim.AddPosition(Male)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S1", -45.0, sos = 3, strapOn = True)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S2", -45.0, sos = 3, strapOn = True)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S3", -45.0, sos = 3, strapOn = True)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S4", -45.0, sos = 3, strapOn = True)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S5", -45.0, sos = 3, strapOn = True)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S6", -45.0, sos = 3, strapOn = True)

		Anim.AddTag("Pillory")
		Anim.AddTag("Vaginal")		
		
		Anim.Save(-1)
	EndIf
EndFunction

Function CreateDDZapPillorySex02(int id)
	String asAnim1 = "DDZapPillorySex01"
	String asAnim2 = "DDZapPillorySex01"
	
	sslBaseAnimation Anim = SexLab.GetAnimationObject("DDZapPillorySex02")
	if Anim != none && Anim.Name != "DDZapPillorySex02"
		Anim.Name = "DDZapPillorySex02"
		Anim.SetContent(Sexual)
		Anim.SoundFX = Squishing

		Int B = Anim.AddPosition(Female, AddCum = Vaginal)
		Anim.AddPositionStage(B, asAnim1 + "_A1_S1")		
		;Anim.AddPositionStage(B, asAnim1 + "_A1_S3")
		Anim.AddPositionStage(B, asAnim1 + "_A1_S4")
		Anim.AddPositionStage(B, asAnim1 + "_A1_S2")
		Anim.AddPositionStage(B, asAnim1 + "_A1_S5")
		Anim.AddPositionStage(B, asAnim1 + "_A1_S6")

		Int A = Anim.AddPosition(Male)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S1", -45.0, sos = 3, strapOn = True)		
		;Anim.AddPositionStage(A, asAnim2 + "_A2_S3", -45.0, sos = 3, strapOn = True)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S4", -45.0, sos = 3, strapOn = True)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S2", -45.0, sos = 3, strapOn = True)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S5", -45.0, sos = 3, strapOn = True)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S6", -45.0, sos = 3, strapOn = True)

		Anim.AddTag("Pillory")
		Anim.AddTag("Vaginal")		
		
		Anim.Save(-1)
	EndIf
EndFunction

Function CreateDDZapPillorySex03(int id)
	String asAnim1 = "DDZapPillorySex01"
	String asAnim2 = "DDZapPillorySex01"
	
	sslBaseAnimation Anim = SexLab.GetAnimationObject("DDZapPillorySex03")
	if Anim != none && Anim.Name != "DDZapPillorySex03"
		Anim.Name = "DDZapPillorySex03"
		Anim.SetContent(Sexual)
		Anim.SoundFX = Squishing

		Int B = Anim.AddPosition(Female, AddCum = Vaginal)
		Anim.AddPositionStage(B, asAnim1 + "_A1_S1")
		Anim.AddPositionStage(B, asAnim1 + "_A1_S5")
		Anim.AddPositionStage(B, asAnim1 + "_A1_S2")
		Anim.AddPositionStage(B, asAnim1 + "_A1_S3")
		Anim.AddPositionStage(B, asAnim1 + "_A1_S4")
		Anim.AddPositionStage(B, asAnim1 + "_A1_S2")		
		Anim.AddPositionStage(B, asAnim1 + "_A1_S3")
		Anim.AddPositionStage(B, asAnim1 + "_A1_S5")
		Anim.AddPositionStage(B, asAnim1 + "_A1_S6")

		Int A = Anim.AddPosition(Male)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S1", -45.0, sos = 3, strapOn = True)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S5", -45.0, sos = 3, strapOn = True)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S2", -45.0, sos = 3, strapOn = True)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S3", -45.0, sos = 3, strapOn = True)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S4", -45.0, sos = 3, strapOn = True)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S2", -45.0, sos = 3, strapOn = True)		
		Anim.AddPositionStage(A, asAnim2 + "_A2_S3", -45.0, sos = 3, strapOn = True)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S5", -45.0, sos = 3, strapOn = True)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S6", -45.0, sos = 3, strapOn = True)

		Anim.AddTag("Pillory")
		Anim.AddTag("Vaginal")		
		
		Anim.Save(-1)
	EndIf
EndFunction

Function CreateDDZapPillorySex04(int id)
	String asAnim1 = "DDZapPillorySex01"
	String asAnim2 = "DDZapPillorySex01"
	
	sslBaseAnimation Anim = SexLab.GetAnimationObject("DDZapPillorySex04")
	if Anim != none && Anim.Name != "DDZapPillorySex04"
		Anim.Name = "DDZapPillorySex04"
		Anim.SetContent(Sexual)
		Anim.SoundFX = Squishing

		Int B = Anim.AddPosition(Female, AddCum = Vaginal)
		Anim.AddPositionStage(B, asAnim1 + "_A1_S1")
		Anim.AddPositionStage(B, asAnim1 + "_A1_S2")				
		Anim.AddPositionStage(B, asAnim1 + "_A1_S5")
		Anim.AddPositionStage(B, asAnim1 + "_A1_S6")

		Int A = Anim.AddPosition(Male)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S1", -45.0, sos = 3, strapOn = True)						
		Anim.AddPositionStage(A, asAnim2 + "_A2_S2", -45.0, sos = 3, strapOn = True)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S5", -45.0, sos = 3, strapOn = True)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S6", -45.0, sos = 3, strapOn = True)

		Anim.AddTag("Pillory")
		Anim.AddTag("Vaginal")		
		
		Anim.Save(-1)
	EndIf
EndFunction

Function DDZapPilloryLick01(int id)
	String asAnim1 = "DDZapPilloryLick01"
	String asAnim2 = "DDZapPilloryLick01"
	
	sslBaseAnimation Anim = SexLab.GetAnimationObject("DDZapPilloryLick01")
	if Anim != none && Anim.Name != "DDZapPilloryLick01"
		Anim.Name = "DDZapPilloryLick01"
		Anim.SetContent(Sexual)
		Anim.SoundFX = Squishing

		Int B = Anim.AddPosition(Female, AddCum = Vaginal)
		Anim.AddPositionStage(B, asAnim1 + "_A1_S1")		

		Int A = Anim.AddPosition(Male)
		Anim.AddPositionStage(A, asAnim2 + "_A2_S1", -45.0, sos = 3, strapOn = False)		

		Anim.AddTag("Pillory")
		Anim.AddTag("Oral")		
		
		Anim.Save(-1)
	EndIf
EndFunction
