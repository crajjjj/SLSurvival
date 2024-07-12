Scriptname iWant_Widgets_Demo extends Quest
{Demo code to exercise iWant Widgets interface}

iWant_Widgets Property iWidgets Auto

Bool running = False

Event OnInit()
	RegisterForModEvent("iWantWidgetsReset", "OniWantWidgetsReset")
EndEvent

Event OniWantWidgetsReset(String eventName, String strArg, Float numArg, Form sender)
	If eventName == "iWantWidgetsReset"
		If !running
			iWidgets = sender As iWant_Widgets
			
			Int i
			Int r
			Int g
			Int b
			Int z

			running = True
			
			Debug.Notification("Demo starting in 15 seconds...")
			Debug.Notification("(Move periodically to avoid idle animation)")
			Utility.Wait(15)

			Debug.Notification("In November of 2011 Bethesda released Skyrim")
			Utility.Wait(2)
			Debug.Notification("...and it was good.")
			Utility.Wait(8)
			
			Debug.Notification("In December of 2011 SkyUI Team released SkyUI")
			Utility.Wait(2)
			Debug.Notification("...and it was good.")
			Utility.Wait(8)

			Debug.Notification("In May of 2020, DaemonPrime presents...")
			Int logo = iWidgets.loadLibraryWidget("demo/logo")
			iWidgets.setTransparency(logo, 0)
			iWidgets.setVisible(logo)
			iWidgets.setPos(logo, 1280/2, 720/2)
			iWidgets.setZoom(logo, 50, 50)
			Utility.Wait(4)
			iWidgets.doTransition(logo, 100, 150)
			Utility.Wait(7)
			iWidgets.doTransition(logo, 0, 90)
			Utility.Wait(4)

			Debug.Notification("iWant Widgets")
			Int apple = iWidgets.loadLibraryWidget("apple")
			Int mug = iWidgets.loadLibraryWidget("mug")
			Int moon = iWidgets.loadLibraryWidget("moonandstars")
			iWidgets.setRGB(apple, 255, 0, 0)
			iWidgets.setRGB(mug, 0, 255, 255)
			iWidgets.setRGB(moon, 255, 255, 0)
			iWidgets.setTransparency(apple, 0)
			iWidgets.setTransparency(mug, 0)
			iWidgets.setTransparency(moon, 0)
			iWidgets.setVisible(apple)
			iWidgets.setVisible(mug)
			iWidgets.setVisible(moon)
			iWidgets.setPos(apple, (1280/2) - 150 , 720/2)
			iWidgets.setPos(mug, 1280/2, 720/2)
			iWidgets.setPos(moon, (1280/2) + 150, 720/2)
			Utility.Wait(1)
			iWidgets.doTransition(apple, 100, 150)
			Utility.Wait(3)
			iWidgets.doTransition(mug, 100, 150)
			Utility.Wait(3)
			iWidgets.doTransition(moon, 100, 150)
			Utility.Wait(6)

			Debug.Notification("...lots of widgets")
			Int[] snow
			snow = new Int[128]
			i = 0
			while (i < 128)
				snow[i] = iWidgets.loadLibraryWidget("snowflake")
				r = Utility.RandomInt(0,127)
				g = 2 * r
				b = 255
				z = Utility.RandomInt(25,175)
				iWidgets.setRGB(snow[i], r, g, b)
				iWidgets.setTransparency(snow[i], 0)
				iWidgets.setZoom(snow[i], z, z)
				iWidgets.setRotation(snow[i], Utility.RandomInt(0, 359))
				iWidgets.setPos(snow[i], Utility.RandomInt(0, 1279), 0)
				iWidgets.setVisible(snow[i])
				iWidgets.doTransition(snow[i], Utility.RandomInt(50, 100), 15)
				iWidgets.doTransition(snow[i], Utility.RandomInt(-180, 180), Utility.RandomInt(300, 600), "rotation")
				iWidgets.doTransition(snow[i], 700, Utility.RandomInt(210, 900), "y", "bounce", "out")
				i += 1
			EndWhile
			Utility.Wait(8)
			i = 0
			while (i < 128)
				iWidgets.doTransition(snow[i], 0, 60)
				i += 1
			EndWhile
			iWidgets.doTransition(apple, 0, 60)
			iWidgets.doTransition(mug, 0, 60)
			iWidgets.doTransition(moon, 0, 60)		
			Utility.Wait(3)
			
			Debug.Notification("iWant text")
			Int hello
			
			hello = iWidgets.loadText("Hello World!")
			iWidgets.setPos(hello, 1280/2, 720/2)
			iWidgets.setVisible(hello)
			Utility.Wait(5)
			Int[] lots
			String text = "...lot's of text."
			i = 0
			
			lots = new Int[12]
			lots[0] = iWidgets.loadText(text, "Nova Cut", Utility.RandomInt(16, 72))
			lots[1] = iWidgets.loadText(text, "Medieval Sharp", Utility.RandomInt(16, 72))
			lots[2] = iWidgets.loadText(text, "Minipax", Utility.RandomInt(16, 72))
			lots[3] = iWidgets.loadText(text, "Sofia", Utility.RandomInt(16, 72))
			lots[4] = iWidgets.loadText(text, "Nova Cut", Utility.RandomInt(16, 72))
			lots[5] = iWidgets.loadText(text, "Medieval Sharp", Utility.RandomInt(16, 72))
			lots[6] = iWidgets.loadText(text, "Minipax", Utility.RandomInt(16, 72))
			lots[7] = iWidgets.loadText(text, "Sofia", Utility.RandomInt(16, 72))
			lots[8] = iWidgets.loadText(text, "Nova Cut", Utility.RandomInt(16, 72))
			lots[9] = iWidgets.loadText(text, "Medieval Sharp", Utility.RandomInt(16, 72))
			lots[10] = iWidgets.loadText(text, "Minipax", Utility.RandomInt(16, 72))
			lots[11] = iWidgets.loadText(text, "Sofia", Utility.RandomInt(16, 72))

			iWidgets.doTransition(hello, 0, 60)
			Utility.Wait(2)
			while (i < 12)
				r = Utility.RandomInt(127,255)
				g = Utility.RandomInt(127,255)
				b = Utility.RandomInt(127,255)
				iWidgets.setRGB(lots[i], r, g, b)
				iWidgets.setPos(lots[i], Utility.RandomInt(200, 1080), Utility.RandomInt(200, 520))
				iWidgets.setRotation(lots[i], Utility.RandomInt(0, 359))
				iWidgets.setVisible(lots[i])
				i += 1
			EndWhile
			
			Utility.Wait(3)
			i = 0
			while (i < 12)
				iWidgets.doTransition(lots[i], 0, 90)
				i += 1
			EndWhile
			
			Int shapetext
			shapetext = iWidgets.loadText("iWant shapes", "Minipax", 72)
			iWidgets.setPos(shapetext, 1280/2, 100)
			Int[] shape1
			Int[] shape2
			Int[] shape3
			Int[] shape4
			
			shape1 = new Int[10]
			shape2 = new Int[10]
			shape3 = new Int[10]
			shape4 = new Int[10]
			
			i = 0
			while (i < 10)
				shape1[i] = iWidgets.loadLibraryWidget("sheep")
				iWidgets.setZoom(shape1[i], 35, 35)
				iWidgets.setVisible(shape1[i])
				i += 1
			EndWhile
			i = 0
			while (i < 10)
				shape2[i] = iWidgets.loadLibraryWidget("apple")
				iWidgets.setZoom(shape2[i], 35, 35)
				iWidgets.setRGB(shape2[i], 255, 0, 0)
				iWidgets.setVisible(shape2[i])
				i += 1
			EndWhile
			i = 0
			while (i < 10)
				shape3[i] = iWidgets.loadLibraryWidget("snowflake")
				iWidgets.setZoom(shape3[i], 35, 35)
				iWidgets.setRGB(shape3[i], 0, 0, 255)
				iWidgets.setVisible(shape3[i])
				i += 1
			EndWhile
			i = 0
			while (i < 10)
				shape4[i] = iWidgets.loadLibraryWidget("sun")
				iWidgets.setZoom(shape4[i], 35, 35)
				iWidgets.setRGB(shape4[i], 255, 255, 0)
				iWidgets.setVisible(shape4[i])
				i += 1
			EndWhile
			iWidgets.setZoom(shape4[0], 100, 100)
			
			Utility.Wait(1)
			iWidgets.setVisible(shapetext)
			Utility.Wait(1)

			iWidgets.drawShapeLine(shape1, 50, 150, 0, 50)
			Utility.Wait(5)
			
			Int moreshapetext
			moreshapetext = iWidgets.loadText("...lots of shapes.", "Minipax", 48)
			iWidgets.setPos(moreshapetext, 1280/2, 200)
			iWidgets.setVisible(moreshapetext)

			Utility.Wait(2)
			Int moreshapetext2
			moreshapetext2 = iWidgets.loadText("(or at least a few)", "Minipax", 24)
			iWidgets.setPos(moreshapetext2, 1280/2, 275)
			iWidgets.setTransparency(moreshapetext2, 0)
			iWidgets.setVisible(moreshapetext2)
			iWidgets.doTransition(moreshapetext2, 100, 150)

			iWidgets.drawShapeLine(shape2, 1150, 650, -50, 0)
			iWidgets.drawShapeCircle(shape3, 1280/3, 400, 100, 0, 36)
			iWidgets.drawShapeOrbit(shape4, (1280/3)*2, 400, 100, 0, 360/9)
			i = 0
			While (i < 10)
				iWidgets.doTransition(shape4[i], 359, 300, "rotation")
				i += 1
			EndWhile
			Utility.Wait(7)
			
			i = 0
			While (i < 10)
				iWidgets.doTransition(shape1[i], 0, 90)
				iWidgets.doTransition(shape2[i], 0, 90)
				iWidgets.doTransition(shape3[i], 0, 90)
				iWidgets.doTransition(shape4[i], 0, 90)
				i += 1
			EndWhile
			iWidgets.doTransition(shapetext, 0, 90)
			iWidgets.doTransition(moreshapetext, 0, 90)
			iWidgets.doTransition(moreshapetext2, 0, 90)
			Utility.Wait(3)
			
			Int basetext
			basetext = iWidgets.loadText("iWant control of native widgets.", "Minipax", 36)
			iWidgets.setPos(basetext, 1280/2, 100)
			iWidgets.setVisible(basetext)

			iWidgets.setSkyrimTemperature(4)
			iWidgets.setSkyrimHealthMeterPercent(Utility.RandomInt(0,100))
			iWidgets.setSkyrimStaminaMeterPercent(Utility.RandomInt(0,100))
			iWidgets.setSkyrimMagickaMeterPercent(Utility.RandomInt(0,100))
			Utility.Wait(5)
			iWidgets.setSkyrimTemperature(1)
			iWidgets.setSkyrimHealthMeterPercent(Utility.RandomInt(0,100))
			iWidgets.setSkyrimStaminaMeterPercent(Utility.RandomInt(0,100))
			iWidgets.setSkyrimMagickaMeterPercent(Utility.RandomInt(0,100))

			Utility.Wait(5)
			iWidgets.setSkyrimTemperature(0)
			iWidgets.setSkyrimHealthMeterPercent(100)
			iWidgets.setSkyrimStaminaMeterPercent(100)
			iWidgets.setSkyrimMagickaMeterPercent(100)
			Utility.Wait(3)
			iWidgets.doTransition(basetext, 0, 90)
			Utility.Wait(3)
		
			Int[] s
			
			s = new Int[16]
			s[0]  = iWidgets.loadText("Dedicated to My Busy B.", "Sofia", 18)
			s[1]  = iWidgets.loadText("Without her love and tolerance", "Sofia", 18)
			s[2]  = iWidgets.loadText("this project would never have happened.", "Sofia", 18)
			s[3]  = iWidgets.loadText("Thank you My Love", "Sofia", 18)
			s[4]  = iWidgets.loadText(" ", "Sofia", 18)
			s[5]  = iWidgets.loadText("Special thanks to", "Sofia", 18)
			s[6]  = iWidgets.loadText("my parents", "Sofia", 18)
			s[7]  = iWidgets.loadText("and grandparents", "Sofia", 18)
			s[8]  = iWidgets.loadText("who, in 1983", "Sofia", 18)
			s[9]  = iWidgets.loadText("thought it would be a good idea", "Sofia", 18)
			s[10] = iWidgets.loadText("to buy a kid a", "Sofia", 18)
			s[11] = iWidgets.loadText("TI-99/4A.", "Sofia", 18)
			s[12] = iWidgets.loadText(" ", "Sofia", 18)
			s[13] = iWidgets.loadText("It seemed like a good idea at the time...", "Sofia", 18)
			s[14] = iWidgets.loadText(" ", "Sofia", 18)
			s[15] = iWidgets.loadText("turns out it was.", "Sofia", 18)

			Int[] ti
			ti = new Int[5]
			ti[0] = iWidgets.loadLibraryWidget("demo/ti01")
			ti[1] = iWidgets.loadLibraryWidget("demo/ti02")
			ti[2] = iWidgets.loadLibraryWidget("demo/ti03")
			ti[3] = iWidgets.loadLibraryWidget("demo/ti04")
			ti[4] = iWidgets.loadLibraryWidget("demo/ti05")
			
			Int busyb
			busyb = iWidgets.loadLibraryWidget("demo/busyb")
			iWidgets.setTransparency(busyb, 0)
			iWidgets.setPos(busyb, 900, 100)
			iWidgets.setVisible(busyb)
			iWidgets.doTransition(busyb, 100, 900)
			
			i = 0
			while (i < 3)
				iWidgets.setZoom(ti[i], 50, 50)
				iWidgets.setTransparency(ti[i], 0)
				iWidgets.setPos(ti[i], 150, 200 + (200 * i))
				iWidgets.setVisible(ti[i])
				iWidgets.doTransition(ti[i], 100, 900)
				i += 1
			EndWhile

			while (i < ti.Length)
				iWidgets.setZoom(ti[i], 50, 50)
				iWidgets.setTransparency(ti[i], 0)
				iWidgets.setPos(ti[i], 1130, (400 + (200 * (i - 3))))
				iWidgets.setVisible(ti[i])
				iWidgets.doTransition(ti[i], 100, 900)
				i += 1
			EndWhile

			i = 0
			while (i < s.Length)
				iWidgets.setTransparency(s[i], 0)
				iWidgets.setPos(s[i], 1280/2, 100 + (i * 36))
				iWidgets.setVisible(s[i])
				iWidgets.doTransition(s[i], 100, 240)
				Utility.Wait(2)
				i += 1
			EndWhile

			Utility.Wait(10)
			iWidgets.doTransition(busyb, 0, 90)
			i = 0
			while (i < ti.Length)
				iWidgets.doTransition(ti[i], 0, 90)
				i += 1
			EndWhile

			i = 0
			while (i < s.Length)
				iWidgets.doTransition(s[i], 0, 90)
				i += 1
			EndWhile
			Utility.Wait(3)
			
			Int closetext = iWidgets.loadText("In May of 2020 DaemonPrime released")
			iWidgets.setTransparency(closetext, 0)
			iWidgets.setPos(closetext, 1280/2, 150)
			iWidgets.setVisible(closetext)
			iWidgets.doTransition(closetext, 100, 90)

			iWidgets.doTransition(logo, 100, 150)
			Utility.Wait(7)
			
			Int question = iWidgets.loadText("Is it good?")
			iWidgets.setTransparency(question, 0)
			iWidgets.setPos(question, 1280/2, 650)
			iWidgets.setVisible(question)
			iWidgets.doTransition(question, 100, 90)
			
			Utility.Wait(10)
			iWidgets.doTransition(closetext, 0, 90)
			iWidgets.doTransition(logo, 0, 90)
			iWidgets.doTransition(question, 0, 150)

			running = False
		EndIf
	EndIf
EndEvent
