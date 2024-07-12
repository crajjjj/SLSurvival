Scriptname SLS_PlaceRandomZazSlave extends ObjectReference  

Actor MySlave

Event OnLoad()
	If Init.ZazInstalled && !Populated
		If TownMustBeEnslaved
			If !IsFree()
				Populated = true
				MySlave = Self.PlaceActorAtMe(Init.RandomZazSlave)
				MySlave.AddToFaction(_SLS_KennelSlave)
				MySlave.MoveTo(Self)
			EndIf
		Else
			Populated = true
			MySlave = Self.PlaceActorAtMe(Init.RandomZazSlave)
			MySlave.AddToFaction(_SLS_KennelSlave)
			MySlave.MoveTo(Self)
		EndIf
		If MySlave
			Utility.Wait(1.5)
			;Debug.Messagebox("Doing it")
			Sexlab.AddCum(MySlave, Vaginal = Utility.RandomInt(0,1) as Bool, Oral = Utility.RandomInt(0,1) as Bool, Anal = Utility.RandomInt(0,1) as Bool)
			
			
			
			
			;/
			Int i = Utility.RandomInt(1,1) ; Leave this at 1 for now as tats don't display on zbfSlaveFemale for some reason
			While i > 0
				i -= 1
				RapeTats.AddRapeTat(MySlave)
			EndWhile
			/;
			;Utility.Wait(1.0)

			Sexlab.AddCum(MySlave, Vaginal = Utility.RandomInt(0,1) as Bool, Oral = Utility.RandomInt(0,1) as Bool, Anal = Utility.RandomInt(0,1) as Bool)
			Devious.EquipRandomDds(MySlave, Utility.RandomInt(StorageUtil.GetIntValue(Menu, "KennelSlaveDeviceCountMin", Missing = 2), StorageUtil.GetIntValue(Menu, "KennelSlaveDeviceCountMax", Missing = 6)))

			If Utility.RandomInt(0, 100) > 0
				Fhu.InflateTo(MySlave, Hole = Utility.RandomInt(1, 2), time = 0.01, targetLevel = Utility.RandomFloat(1.0, 6.0))
			EndIf
			;MySlave.SetExpressionOverride(aiMood = 13, aiStrength = 100)
		EndIf
	EndIf
EndEvent

Event OnUnload()
	If MySlave
		MySlave.Disable()
		MySlave.DeleteWhenAble()
		Populated = false
	EndIf
EndEvent

Bool Function IsFree()
	If Init.SlvrunRelInstalled
		If MyLocation == "Whiterun"
			Return Slaverun.IsFreeTownWhiterun()
		ElseIf MyLocation == "Solitude"
			Return Slaverun.IsFreeTownSolitude()
		ElseIf MyLocation == "Markarth"
			Return Slaverun.IsFreeTownMarkarth()
		ElseIf MyLocation == "Windhelm"
			Return Slaverun.IsFreeTownWindhelm()
		ElseIf MyLocation == "Riften"
			Return Slaverun.IsFreeTownRiften()
		EndIf
	Else
		Return true
	EndIf
EndFunction

_SLS_InterfaceRapeTats Property RapeTats Auto

SexlabFramework Property Sexlab Auto

Faction Property _SLS_KennelSlave Auto

_SLS_InterfaceFhu Property Fhu Auto
_SLS_InterfaceDevious Property Devious Auto
_SLS_InterfaceSlaverun Property Slaverun Auto
SLS_Init Property Init Auto
SLS_Mcm Property Menu Auto

String Property MyLocation Auto
Bool Property TownMustBeEnslaved Auto
Bool Populated = false
