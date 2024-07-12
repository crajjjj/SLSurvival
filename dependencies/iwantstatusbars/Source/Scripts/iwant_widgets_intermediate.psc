Scriptname iWant_Widgets_Intermediate extends Quest
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
			
			Utility.Wait(delay)
			
			Debug.Notification("Intermediate tutorial starting in " + delay As Int + " seconds...")
			Debug.Notification("(Move periodically to avoid idle animation)")

			Utility.Wait(delay)
			Debug.Notification("iWidgets.loadWidget...")
			Int i = 0
			Int x
			Int y
			Int s
			Int[] mySheep
			mySheep = new Int[10]

			While (i < mySheep.Length)
				mySheep[i] = iWidgets.loadWidget("widgets/iwant/widgets/library/sheep.dds")
				iWidgets.setVisible(mySheep[i])
				i += 1
			EndWhile
			Utility.Wait(delay)

			Debug.Notification("iWidgets.drawShapeLine(mySheep, 100, 100, 75, 50)")
			iWidgets.drawShapeLine(mySheep, 100, 100, 75, 50)
			Utility.Wait(delay)

			Debug.Notification("iWidgets.drawShapeCircle(mySheep, 1280/2, 720/2, 250, 0, 360/10)")
			iWidgets.drawShapeCircle(mySheep, 1280/2, 720/2, 250, 0, 360/10)
			Utility.Wait(delay)

			Debug.Notification("iWidgets.drawOrbit(mySheep, 1280/2, 720/2, 250, 0, 360/9)")
			iWidgets.drawShapeOrbit(mySheep, 1280/2, 720/2, 250, 0, 360/9)
			Utility.Wait(delay)

			Debug.Notification("iWidgets.setZoom(mySheep[0], 200, 200)")
			iWidgets.setZoom(mySheep[0], 200, 200)
			Utility.Wait(delay)

			Debug.Notification("iWidgets.doTransition...")
			i = 1
			While (i < mySheep.Length)
				x = Utility.RandomInt(50, 1230)
				y = Utility.RandomInt(50, 670)
				s = Utility.RandomInt(1, 10)
				iWidgets.doTransitionByTime(mySheep[i], x, s, "x")
				iWidgets.doTransitionByTime(mySheep[i], y, s, "y")
				i += 1
			EndWhile
			Utility.Wait(delay)

			Debug.Notification("iWidgets.doTransition...scale")
			i = 1
			While (i < mySheep.Length)
				x = Utility.RandomInt(-100, 100)
				s = Utility.RandomInt(1, 10)
				iWidgets.doTransitionByTime(mySheep[i], x, s, "xscale")
				iWidgets.doTransitionByTime(mySheep[i], x, s, "yscale")
				i += 1
			EndWhile
			Utility.Wait(delay)

			Debug.Notification("iWidgets.doTransition(mySheep[0], 180, 300, 'rotation')")
			iWidgets.doTransitionByTime(mySheep[0], 180, 10, "rotation")
			Utility.Wait(delay)

			Debug.Notification("iWidgets.doTransition(mySheep[0], 0, 150, 'rotation')")
			iWidgets.doTransitionByTime(mySheep[0], 0, 5, "rotation")
			Utility.Wait(delay)

			Debug.Notification("iWidgets.loadText...")
			Int t

			t = iWidgets.loadText("NO MORE DEBUG MESSAGES FOR USERS")
			iWidgets.setPos(t, 1280/2, 100)
			iWidgets.setRGB(t, 0, 0, 255)
			iWidgets.setVisible(t)
			
			Utility.Wait(delay)

			Debug.Notification("Praise Sheogorath!")
			Int Sheogorath
			Sheogorath = iWidgets.loadText("Praise Sheogorath!", "Sofia", 48)
			iWidgets.setPos(Sheogorath, 1280/2, 250)
			iWidgets.setRGB(Sheogorath, Utility.RandomInt(0, 255), Utility.RandomInt(0, 255), Utility.RandomInt(0, 255))
			iWidgets.setTransparency(Sheogorath, Utility.RandomInt(50, 100))
			iWidgets.setRotation(Sheogorath, Utility.RandomInt(0, 359))
			iWidgets.setVisible(Sheogorath)
			Utility.Wait(delay)
			
			running = False
		EndIf
	EndIf
EndEvent
