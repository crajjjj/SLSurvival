Scriptname _SLS_KennelSlaves extends Quest  

Event OnInit()
	If Self.IsRunning()
		Utility.Wait(8.0)
		If Init.SlsCreatureEvents
			FuckRandomSlave()
			RegForUpdate()
		EndIf
	EndIf
EndEvent

Event OnUpdate()
	FuckRandomSlave()
	RegForUpdate()
EndEvent

Function FuckRandomSlave()
	If Menu.KennelSlaveRapeTimeMin >= 0
		_SLS_KennelFreeSlaveSearchQuest.Stop()
		_SLS_KennelFreeSlaveSearchQuest.Start()
		
		Actor Slave = (_SLS_KennelFreeSlaveSearchQuest.GetNthAlias(0) as ReferenceAlias).GetReference() as Actor
		Actor Creature = (_SLS_KennelFreeSlaveSearchQuest.GetNthAlias(1) as ReferenceAlias).GetReference() as Actor
		
		If Slave && Creature
			actor[] sexActors =  new actor[2]
			sexActors[0] = Slave
			sexActors[1] = Creature
			
			sslBaseAnimation[] animations = SexLab.GetCreatureAnimationsByRace(2, Creature.GetRace())
			
			;Debug.Messagebox("Fucking random slave\n\nSlave: " + Slave + ". Creature: " + Creature + "\n\nAnimations: " + animations)
			If animations.Length > 0
				Sexlab.StartSex(sexActors, animations, Slave)
			
			Else
				Debug.Trace("_SLS_: Kennel: No animations found. Creature race: " + Creature.GetRace())
			EndIf
		EndIf
	EndIf
EndFunction

Function RegForUpdate()
	RegisterForSingleUpdate(Utility.RandomInt(Menu.KennelSlaveRapeTimeMin, Menu.KennelSlaveRapeTimeMax))
EndFunction

Quest Property _SLS_KennelFreeSlaveSearchQuest Auto

SLS_Mcm Property Menu Auto
SLS_Init Property Init Auto
SexlabFramework Property Sexlab Auto
