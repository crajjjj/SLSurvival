Scriptname iWant_Widgets_Beginner extends Quest
{Demo code to exercise iWant Widgets interface}

iWant_Widgets Property iWidgets Auto

Float delay = 10.0
Bool running = False

Event OnInit()
	RegisterForModEvent("iWantWidgetsReset", "OniWantWidgetsReset")
EndEvent

Event OniWantWidgetsReset(String eventName, String strArg, Float numArg, Form sender)
	If eventName == "iWantWidgetsReset"
		If !running
			iWidgets = sender As iWant_Widgets
			running = True

			Debug.Notification("Beginner tutorial starting in " + delay As Int + " seconds...")
			Debug.Notification("(Move periodically to avoid idle animation)")
			
			Utility.Wait(delay)
			Debug.Notification("Int myApple = iWidgets.loadLibraryWidget(\"apple\")")
			Int myApple = iWidgets.loadLibraryWidget("apple")
			Utility.Wait(delay)

			Debug.Notification("iWidgets.setPos(myApple, (1280 / 2), (720 / 2))")
			iWidgets.setPos(myApple, (1280 / 2), (720 / 2))
			Utility.Wait(delay)

			Debug.Notification("iWidgets.setVisible(myApple)")
			iWidgets.setVisible(myApple)
			Utility.Wait(delay)

			Debug.Notification("iWidgets.setRGB(myApple, 255, 0, 0)")
			iWidgets.setRGB(myApple, 255, 0, 0)
			Utility.Wait(delay)

			Debug.Notification("iWidgets.setZoom(myApple, 200, 200)")
			iWidgets.setZoom(myApple, 200, 200)
			Utility.Wait(delay)

			Debug.Notification("iWidgets.setSize(myApple, 300, 300)")
			iWidgets.setSize(myApple, 300, 300)
			Utility.Wait(delay)

			Debug.Notification("iWidgets.setRotation(myApple, 45)")
			iWidgets.setRotation(myApple, 45)
			Utility.Wait(delay)

			Debug.Notification("iWidgets.setTransparency(myApple, 0)")
			iWidgets.setTransparency(myApple, 0)
			Utility.Wait(delay)

			Debug.Notification("iWidgets.doTransitionByTime(myApple, 100, 5)")
			iWidgets.doTransitionByTime(myApple, 100, 5)
			Utility.Wait(delay)

			Debug.Notification("iWidgets.destroy(myApple)")
			iWidgets.destroy(myApple)
			
			running = False
		EndIf
	EndIf
EndEvent
