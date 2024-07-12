;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname QF__DFlowDealS_090E53C8 Extends Quest Hidden

;BEGIN ALIAS PROPERTY _DMaster
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias__DMaster Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Client
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Client Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY You
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_You Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE _DDeal
Quest __temp = self as Quest
_DDeal kmyQuest = __temp as _DDeal
;END AUTOCAST
;BEGIN CODE
Float temp = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealSPTimer.SetValue(temp)
kmyQuest.LDC.EquipDeviceByKeyWord(kmyQuest.LDC.libs.zad_deviouspluganal)
Alias__DMaster.Forcerefto(_DFlow_DMaster.GetReference() )
Alias_You.Forcerefto(Tool.PC )
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN AUTOCAST TYPE _DDeal
Quest __temp = self as Quest
_DDeal kmyQuest = __temp as _DDeal
;END AUTOCAST
;BEGIN CODE
Float Temp = 0.0
if (_DflowDealSPTimer.getValue() <=  GameDaysPassed.GetValue())
temp = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealSPTimer.SetValue(temp)
Else
temp =_DflowDealSPTimer.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealSPTimer.SetValue(temp)
endif
Tool.GiveWhoreArmor(False)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
kmyQuest.Stage0()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN AUTOCAST TYPE _DF_WhoreDeal
Quest __temp = self as Quest
_DF_WhoreDeal kmyQuest = __temp as _DF_WhoreDeal
;END AUTOCAST
;BEGIN CODE
KmyQuest.DelayHrs(1.0)
Float Temp = 0.0
if (_DflowDealSPTimer.getValue() <=  GameDaysPassed.GetValue())
temp = GameDaysPassed.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealSPTimer.SetValue(temp)
Else
temp =_DflowDealSPTimer.GetValue() + _DflowDealBaseDays.GetValue()
_DflowDealSPTimer.SetValue(temp)
endif

if KmyQuest.Stat != 1 
libs.ForceequipDevice(libs.PlayerRef, kmyQuest.Item3 ,kmyQuest.Item3R, libs.zad_DeviousPlugAnal, skipevents = false, skipmutex = true)
endif

KmyQuest.Triggered = False
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property _DflowDealSPTimer auto 
GlobalVariable Property GameDaysPassed auto
GlobalVariable Property _DflowDealBaseDays auto
ReferenceAlias Property _DFlow_DMaster auto
zadlibs Property libs  Auto 
zadxlibs Property xlibs Auto  
_DFtools Property tool  Auto 
Scene Property WhoreOut Auto 
Scene Property Normal Auto 
Scene Property Thief Auto 
Scene Property Again Auto 
Scene Property GangRape Auto 
Scene Property Notpayed Auto 
Scene Property Overpay Auto 

MiscObject Property Gold001 Auto
Message Property _DFlowDealSWhoreOutMsg Auto 
Message Property _DFlowDealSWhoreOutMsgResist Auto
Int Used = 0
Bool Running = False

Function WhoreOut()
Tool.PauseAll()
If !Running
	Running = true
int Outcome = Utility.RandomInt(1,6)
;1 = Normal
;2 = Thief
;3 = Again
;4 = GangRape
;5 = Notpayed
;6 = Overpay.
		tool.PauseAll()
		game.setplayeraidriven(true)
		Debug.Notification("$DF_DEALSPULLED")
		WhoreOut.Start()
		Tool.SceneErrorCatch(WhoreOut, 60)

		game.setplayeraidriven(false)
		int choice = 0
		If Used <= 2
			Choice = _DFlowDealSWhoreOutMsg.show()
			
		endif
		
		if Choice == 0
		Used += 1
		tool.DS.Triggered = True
		Tool.Sex(Alias_Client.GetReference() as Actor)
		Utility.wait(10)
		if (Game.GetPlayer().GetItemCount(Gold001) > 150) && Outcome == 2
			Tool.PC.Enable()
			Alias_You.Forcerefto(Tool.PC )
			Tool.PC.Moveto(Game.Getplayer(),1000,1000)
			Game.GetPlayer().RemoveItem(Gold001, Utility.RandomInt(75,200))
			Debug.Notification("$DF_DEALSTHIEF")
		Elseif Outcome == 2 
			Outcome = 5
		endif
		
		
		While libs.IsAnimating(libs.playerref)
			Utility.wait(4)
		endwhile
		
		if Outcome == 1
			Normal.Start()
			Tool.SceneErrorCatch(Normal,20)
		Elseif Outcome == 2
			Thief.Start()
			
			Tool.SceneErrorCatch(Thief,20)
			Tool.PC.Disable()
		Elseif Outcome == 3
			Again.Start()
			Tool.SceneErrorCatch(Again,20)
			Tool.Sex(Alias_Client.GetReference() as Actor)
		Elseif Outcome == 4
			GangRape.Start()
			Tool.SceneErrorCatch(GangRape,20)
			Tool.Rapetime()
		Elseif Outcome == 5
			Notpayed.Start()
			
			Tool.SceneErrorCatch(Notpayed,20)
			Tool.MCM.AddDebtNoti(50)
			Tool.MCM.q.Debt(50.0)
		Elseif Outcome == 6
			Overpay.Start()
			Tool.SceneErrorCatch(Overpay,20)
			Game.Getplayer().Additem(Gold001, Utility.RandomInt(5,20))
		endif
		else
			_DFlowDealSWhoreOutMsgResist.Show()
			libs.equipDevice(libs.PlayerRef, xlibs.zadx_HR_IronCuffsFrontInventory, xlibs.zadx_HR_IronCuffsFrontRendered, libs.zad_DeviousArmCuffs, skipevents = false, skipmutex = true)
		endif
		Tool.ResumeALL()
		Running = False
endif
EndFunction
