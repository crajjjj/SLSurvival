Scriptname iWant_Widgets_LoadTest4 extends Quest
{Stress test component to exercise widget loading interface}

iWant_Widgets Property iWidgets Auto

Event OnInit()
	RegisterForModEvent("iWantWidgetsReset", "OniWantWidgetsReset")
EndEvent

Event OniWantWidgetsReset(String eventName, String strArg, Float numArg, Form sender)
	Int myUmbrella
	Int count = 0

	If eventName == "iWantWidgetsReset"
		iWidgets = sender As iWant_Widgets
		While True

			myUmbrella = iWidgets.loadLibraryWidget("umbrella")
			iWidgets.setPos(myUmbrella, 400, 100)
			iWidgets.setVisible(myUmbrella)
			count = count + 1

			If (count % 1000) == 0
				Debug.Notification("Umbrella " + count)
			EndIf
		EndWhile
	EndIf
EndEvent
