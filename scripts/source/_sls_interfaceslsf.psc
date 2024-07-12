Scriptname _SLS_InterfaceSlsf extends Quest  

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("SexLab - Sexual Fame [SLSF].esm") != 255
		If GetState() != "Installed"
			GoToState("Installed")
		EndIf
	
	Else
		If GetState() != ""
			GoToState("")
		EndIf
	EndIf
EndFunction

Event OnEndState()
	Utility.Wait(5.0) ; Wait before entering active state to help avoid making function calls to scripts that may not have initialized yet.
	FameQuest = Game.GetFormFromFile(0x01E157,"SexLab - Sexual Fame [SLSF].esm") as Quest
EndEvent

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

Function IncreaseSexFame(String FameType, Int Points)
EndFunction

State Installed
	Function IncreaseSexFame(String FameType, Int Points)
	
		;1.3 FameList Chart PC:|
		;----------------------*
		;0  PC.Anal
		;1  PC.Argonian
		;2  PC.Beastiality
		;3  PC.Dominant/Master
		;4  PC.Exhibitionist/Exposed
		;5  PC.GentleLover
		;6  PC.Group
		;7  PC.Khajiit
		;8  PC.LikeMan
		;9  PC.LikeWoman
		;10 PC.Masochist
		;11 PC.Nasty
		;12 PC.Oral
		;13 PC.Orc
		;14 PC.Pregnant
		;15 PC.Sadic
		;16 PC.SkoomaUser
		;17 PC.Slut
		;18 PC.Submissive/Slave
		;19 PC.Whore
		
		Int FameNum
		If FameType == "Whore"
			Debug.Notification("Your fame as a whore in the area has increased")
			FameNum = 19
		ElseIf FameType == "Slut"
			Debug.Notification("Your fame as a slut in the area has increased")
			FameNum = 17
		ElseIf FameType == "Slave"
			Debug.Notification("Your fame as a slave in the area has increased")
			FameNum = 18
		ElseIf FameType == "Beast"
			Debug.Notification("Your fame as a beast fucker in the area has increased")
			FameNum = 2
		ElseIf FameType == "Skooma"
			Debug.Notification("Your fame as a skooma slut in the area has increased")
			FameNum = 16
		EndIf
		
		; Hard sets fames
		;Int[] FameList = New Int[20]
		;FameList[FameIndex] = Points
		;StorageUtil.IntListCopy(None, "_SLS_SlsfFameIncrease", FameList)
		;_SLS_IntSlsf.IncreaseSexFame(FameQuest, "_SLS_SlsfFameIncrease", FameList, 1.0)

		_SLS_IntSlsf.RequestModFameValueByCurrent(FameQuest, FameNum, Many = Points)
	EndFunction
EndState

Quest FameQuest
