Scriptname iWant_Widgets_LoadTest1 extends Quest
{Stress test component to exercise widget loading interface}

iWant_Widgets Property iWidgets Auto

Event OnInit()
	RegisterForModEvent("iWantWidgetsReset", "OniWantWidgetsReset")
EndEvent

Event OniWantWidgetsReset(String eventName, String strArg, Float numArg, Form sender)
	Int myApple
	Int count = 0

	If eventName == "iWantWidgetsReset"
		iWidgets = sender As iWant_Widgets
		While True

			myApple = iWidgets.loadLibraryWidget("apple")
			iWidgets.setPos(myApple, 100, 100)
			iWidgets.setVisible(myApple)
			count = count + 1

			If (count % 1000) == 0
				Debug.Notification("Apple " + count)
			EndIf
		EndWhile
	EndIf
EndEvent
