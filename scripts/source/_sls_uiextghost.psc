Scriptname _SLS_UiExtGhost extends Actor

Event OnLoad()
	(Game.GetFormFromFile(0x12CD4E, "SL Survival.esp") as Sound).Play(Self)
	;RegisterForModEvent("_STA_RandomRunUpAndSpankComplete", "On_STA_RandomRunUpAndSpankComplete") ; Specific doesn't send event :(
	RegisterForSingleUpdate(3.0)
EndEvent

Event OnUpdate()
	If Game.GetModByName("UIExtensions.esp") == 255
		Util.SendDoSpecificNpcSpankEvent(Timeout = 2.0, AllowNpcInFurniture = true, akActor = Self, DialogWait = false)
		RegisterForSingleUpdate(Utility.RandomFloat(2.0, 5.0))
	Else
		Disable(true)
		Delete()
	EndIf
EndEvent

Event On_STA_RandomRunUpAndSpankComplete(string eventName, string strArg, float numArg, Form sender)
	Debug.Messagebox("HELLO")
EndEvent

SLS_Utility Property Util Auto
