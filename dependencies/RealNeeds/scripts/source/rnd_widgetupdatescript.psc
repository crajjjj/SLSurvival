Scriptname RND_WidgetUpdateScript extends Quest  

RND_HungerCountScript Property HungerScript Auto
RND_ThirstCountScript Property ThirstScript Auto
RND_SleepCountScript Property SleepScript Auto
RND_InebriationCountScript Property InebriationScript Auto
RND_WeightCountScript Property WeightScript Auto

Float Property UpdateTimer Auto

Event OnInit()
    RegisterForSingleUpdate(UpdateTimer)
EndEvent

Event OnUpdate()
    	HungerScript.UpdateStatus()
    	ThirstScript.UpdateStatus()
    	SleepScript.UpdateStatus()
    	InebriationScript.UpdateStatus()
    	WeightScript.UpdateStatus()
    	RegisterForSingleUpdate(UpdateTimer)
EndEvent