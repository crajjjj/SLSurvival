Scriptname iWant_Widgets_LoadTest2 extends Quest
{Stress test component to exercise widget loading interface}

iWant_Widgets Property iWidgets Auto

Event OnInit()
	RegisterForModEvent("iWantWidgetsReset", "OniWantWidgetsReset")
EndEvent

Event OniWantWidgetsReset(String eventName, String strArg, Float numArg, Form sender)
	Int mySheep
	Int count = 0

	If eventName == "iWantWidgetsReset"
		iWidgets = sender As iWant_Widgets
		While True

			mySheep = iWidgets.loadLibraryWidget("sheep")
			iWidgets.setPos(mySheep, 200, 100)
			iWidgets.setVisible(mySheep)
			count = count + 1

			If (count % 1000) == 0
				Debug.Notification("Sheep " + count)
			EndIf
		EndWhile
	EndIf
EndEvent
