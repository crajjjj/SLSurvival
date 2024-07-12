Scriptname iWant_Widgets_LoadTest3 extends Quest
{Stress test component to exercise widget loading interface}

iWant_Widgets Property iWidgets Auto

Event OnInit()
	RegisterForModEvent("iWantWidgetsReset", "OniWantWidgetsReset")
EndEvent

Event OniWantWidgetsReset(String eventName, String strArg, Float numArg, Form sender)
	Int mySun
	Int count = 0

	If eventName == "iWantWidgetsReset"
		iWidgets = sender As iWant_Widgets
		While True

			mySun = iWidgets.loadLibraryWidget("sun")
			iWidgets.setPos(mySun, 300, 100)
			iWidgets.setVisible(mySun)
			count = count + 1

			If (count % 1000) == 0
				Debug.Notification("Sun " + count)
			EndIf
		EndWhile
	EndIf
EndEvent
