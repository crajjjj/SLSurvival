Scriptname SLV_DelayPreQuest extends Quest  


Event OnInit()
	RegisterForUpdate(10)
	MiscUtil.PrintConsole("Registering for tracking update")
EndEvent

Event OnUpdate()

if (SLV_Main.IsRunning() || SLV_Main.IsCompleted())
	SLV_PreQuest_1.SetStage(1500)
	UnregisterForUpdate()
Endif

int level = SLV_LevelForPreQuest.getValue() as int
If (Game.GetPlayer().GetLevel()) >= level && SLV_PreQuest_1.getStage() == 0
	MiscUtil.PrintConsole("player level >= setting stage")
	SLV_PreQuest_1.SetStage(100)
	UnregisterForUpdate()
Endif

EndEvent

GlobalVariable Property SLV_LevelForPreQuest auto
Quest property SLV_PreQuest_1 auto
Quest Property SLV_Main Auto

