Scriptname _SLS_InterfaceSos extends Quest  

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("Schlongs of Skyrim.esp") != 255
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
	
EndEvent

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

State Installed
	Event OnBeginState()
		; Can't place these in OnEndState() as empty state functions would be called
		
		;SOS_Data.AddRevealingArmor(Game.GetFormFromFile(0x04C8F8, "SL Survival.esp") as Armor) ; Make half naked cover revealing
		SetRevealing(Game.GetFormFromFile(0x04C8F8, "SL Survival.esp") as Armor) ; Make half naked cover revealing
		PubicHairs = new Form[4]
		PubicHairs[0] = FindSchlongByName("Pubic Hair Landing Strip")
		PubicHairs[1] = FindSchlongByName("Pubic Hair Bush")
		PubicHairs[2] = FindSchlongByName("Pubic Hair Wild")
		PubicHairs[3] = FindSchlongByName("Pubic Hair Untamed")
	EndEvent
	
	Function SetRevealing(Armor akArmor)
		_SLS_IntSos.SetRevealing(akArmor)
	EndFunction
	
	Function MakeErect(Actor akActor)
		;Debug.SendAnimationEvent(akActor, "SOSFastErect")
		;(Game.GetFormFromFile(0x0012ED, "Schlongs of Skyrim.esp") as Spell).Cast(akActor) ; Does odd things with npc outfit when effect finishes. Also has a blue visual effect on start. Not ideal.
	EndFunction
	
	Form Function FindSchlongByName(String SchlongName)
		Return _SLS_IntSos.FindSchlongByName(SchlongName)
	EndFunction
	
	Form Function GetSchlong(Actor akActor)
		Return _SLS_IntSos.GetSchlong(akActor)
	EndFunction
	
	Function SetSchlong(Actor akActor, Form Schlong)
		_SLS_IntSos.SetSchlong(akActor, Schlong)
	EndFunction
	
	Function RemoveSchlong(Actor akActor)
		_SLS_IntSos.RemoveSchlong(akActor)
	EndFunction
	
	Bool Function HasPubicHair(Actor akActor)
		If PubicHairs.Find(GetSchlong(akActor)) > -1
			Return true
		EndIf
		Return false
	EndFunction
EndState

Function SetRevealing(Armor akArmor)
EndFunction

Function MakeErect(Actor akActor)
EndFunction
	
Form Function FindSchlongByName(String SchlongName)
	Return None
EndFunction

Form Function GetSchlong(Actor akActor)
EndFunction

Function SetSchlong(Actor akActor, Form Schlong)
EndFunction

Function RemoveSchlong(Actor akActor)
EndFunction

Bool Function HasPubicHair(Actor akActor)
	Return false
EndFunction

Form[] PubicHairs
