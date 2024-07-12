Scriptname iWant_Status_Bars_Simple_Example extends Quest
{A simple sample using the iWant Status Bars interface}

iWant_Status_Bars Property iBars Auto

Float _updateTimer = 1.0
Bool loaded = False
Int myApple
String MYMOD = "iWant Status Bars Simple Example"
String MYAPPLERIPENESS = "Apple Ripeness"

Event OnInit()
	RegisterForModEvent("iWantStatusBarsReady", "OniWantStatusBarsReady")
	RegisterForSingleUpdate(_updateTimer)
EndEvent

Event OniWantStatusBarsReady(String eventName, String strArg, Float numArg, Form sender)
	If eventName == "iWantStatusBarsReady"
		iBars = sender As iWant_Status_Bars
		If !loaded
			; One time setup code

			String[] s
			Int[] r
			Int[] g
			Int[] b
			Int[] a
			s = new String[2]
			r = new Int[2]
			g = new Int[2]
			b = new Int[2]
			a = new Int[2]
			
			s[0] = "widgets/iwant/widgets/library/apple.dds"
			r[0] = 255
			g[0] = 0
			b[0] = 0
			a[0] = 100
			s[1] = "widgets/iwant/widgets/library/apple.dds"
			r[1] = 0
			g[1] = 255
			b[1] = 0
			a[1] = 100

			myApple = iBars.loadIcon(MYMOD, MYAPPLERIPENESS, s, s, r, g, b, a)

			loaded = True
		EndIf
	EndIf
	RegisterForSingleUpdate(_updateTimer)
EndEvent

Event OnUpdate()
	UpdateStatus()
	RegisterForSingleUpdate(_updateTimer)
EndEvent

Function UpdateStatus()
	If loaded
		; Randomly change the state of the apple (red or green)
		iBars.setIconStatus(MYMOD, MYAPPLERIPENESS, Utility.RandomInt(0,1))
	EndIf
EndFunction
