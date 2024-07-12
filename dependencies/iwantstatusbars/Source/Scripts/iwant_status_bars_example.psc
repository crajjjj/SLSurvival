Scriptname iWant_Status_Bars_Example extends Quest
{Demo code to exercise iWant Status Bars interface}

iWant_Status_Bars Property iBars Auto

Float _updateTimer = 1.0
Bool loaded = False

Event OnInit()
	RegisterForModEvent("iWantStatusBarsReady", "OniWantStatusBarsReady")
	RegisterForSingleUpdate(_updateTimer)
EndEvent

Int ICONCOUNT = 100

Event OniWantStatusBarsReady(String eventName, String strArg, Float numArg, Form sender)
	If eventName == "iWantStatusBarsReady"
		Debug.Notification("Generating icons")
		If !loaded
			iBars = sender As iWant_Status_Bars

			String[] s
			s = new String[3]
			s[0] = "widgets/iwant/widgets/library/sheep.dds"
			s[1] = "widgets/iwant/widgets/library/mug.dds"
			s[2] = "widgets/iwant/widgets/library/apple.dds"
			
			Int[] r
			Int[] g
			Int[] b
			Int[] a
			r = new Int[3]
			g = new Int[3]
			b = new Int[3]
			a = new Int[3]
			
			Int i = 0
			Int j = 0

			i = 0
			While i < ICONCOUNT
				j = 0
				While j < 3
					r[j] = Utility.RandomInt(0, 255)
					g[j] = Utility.RandomInt(0, 255)
					b[j] = Utility.RandomInt(0, 255)
					a[j] = Utility.RandomInt(25, 100)
					j += 1
				EndWhile
				iBars.loadIcon("iwant_status_bars_example", "SBExample" + (i As String), s, s, r, g, b, a)
				i += 1
			EndWhile

			Debug.Notification("Status Bars Loaded")
			loaded = True
		EndIf
	EndIf
	RegisterForSingleUpdate(_updateTimer)
EndEvent

Event OnUpdate()
	Debug.Notification("Timer tick")
	UpdateStatus()
	RegisterForSingleUpdate(_updateTimer)
EndEvent

Int ic = 0
Int style = 1

Function UpdateStatus()
	If loaded
		iBars.setIconStatus("iwant_status_bars_example", "SBExample" + (ic As String), style)
		ic += 1
		If ic > ICONCOUNT
			ic = 0
			style += 1
		EndIf
		If style > 2
			style = 0
		EndIf
	EndIf
EndFunction
