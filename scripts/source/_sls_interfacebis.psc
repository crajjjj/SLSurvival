Scriptname _SLS_InterfaceBis extends Quest  

Quest BisQuest

GlobalVariable PlayerDirt

Formlist Property _SLS_BisSoapList Auto

Event OnInit()
	RegisterForModEvent("_SLS_Int_PlayerLoadsGame", "On_SLS_Int_PlayerLoadsGame")
EndEvent

Event On_SLS_Int_PlayerLoadsGame(string eventName, string strArg, float numArg, Form sender)
	PlayerLoadsGame()
EndEvent

Function PlayerLoadsGame()
	If Game.GetModByName("Bathing in Skyrim - Main.esp") != 255
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
	BisQuest = Game.GetFormFromFile(0x0279ED,"Bathing in Skyrim - Main.esp") as Quest
	_SLS_BisSoapList.Revert()
	_SLS_BisSoapList.AddForm(Game.GetFormFromFile(0x000D6B,"Bathing in Skyrim - Main.esp")) ; mzinSoapPlain
	_SLS_BisSoapList.AddForm(Game.GetFormFromFile(0x000D71,"Bathing in Skyrim - Main.esp")) ; mzinSoapFlowerBlue
	_SLS_BisSoapList.AddForm(Game.GetFormFromFile(0x000D6D,"Bathing in Skyrim - Main.esp")) ; mzinSoapFlowerRed
	_SLS_BisSoapList.AddForm(Game.GetFormFromFile(0x000D6F,"Bathing in Skyrim - Main.esp")) ; mzinSoapFlowerPurple
	_SLS_BisSoapList.AddForm(Game.GetFormFromFile(0x000D6E,"Bathing in Skyrim - Main.esp")) ; mzinSoapFlowerRBP
	_SLS_BisSoapList.AddForm(Game.GetFormFromFile(0x000D70,"Bathing in Skyrim - Main.esp")) ; mzinSoapFlowerLavender
	_SLS_BisSoapList.AddForm(Game.GetFormFromFile(0x000D72,"Bathing in Skyrim - Main.esp")) ; mzinSoapDragonsTongue
	_SLS_BisSoapList.AddForm(Game.GetFormFromFile(0x000D6C,"Bathing in Skyrim - Main.esp")) ; mzinSoapDwemer
	_SLS_BisSoapList.AddForm(Game.GetFormFromFile(0x02AA92,"Bathing in Skyrim - Main.esp")) ; mzinSoapSpriggan
	_SLS_BisSoapList.AddForm(Game.GetFormFromFile(0x0228F5,"Bathing in Skyrim - Main.esp")) ; mzinWashRag
	
	PlayerDirt = Game.GetFormFromFile(0x000DA8, "Bathing in Skyrim - Main.esp") as GlobalVariable
EndEvent

Bool Function GetIsInterfaceActive()
	If GetState() == "Installed"
		Return true
	EndIf
	Return false
EndFunction

State Installed
	Function TryBatheActor(Actor DirtyActor, MiscObject WashProp)
		_SLS_IntBis.TryBatheActor(BisQuest, DirtyActor, WashProp)
	EndFunction
	
	Float Function GetPlayerDirt()
		Return PlayerDirt.GetValue()
	EndFunction
EndState

Function TryBatheActor(Actor DirtyActor, MiscObject WashProp)
EndFunction

Float Function GetPlayerDirt()
	Return 0.0
EndFunction
