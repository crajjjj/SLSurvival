Scriptname sr_SHBFailQuest extends Quest  

sr_inflateQuest Property inflater auto
Message Property sr_SHBFailMsg auto
Quest Property SHB auto
bool property done = false auto hidden

Event OnStoryChangeLocation(ObjectReference akActor, Location akOldLocation, Location akNewLocation)
	If inflater.IsPlugged(inflater.player) < 1 || inflater.IsPlugged(inflater.player) == 2
		done = true
		ForceDeflate()
	EndIf
EndEvent

Function ForceDeflate()
	done = true
	sr_SHBFailMsg.Show()
	float time = utility.RandomFloat(15.0, 20.0)
	inflater.QueueActor(inflater.player, false, inflater.VAGINAL, inflater.GetVaginalCum(inflater.player), time, animate = 2)
	inflater.InflateQueued()
;	inflater.Deflate(inflater.player, false, inflater.GetVaginalCum(inflater.player), 2)
	Utility.Wait(time + 0.2)
	SHB.SetStage(20)
	Stop()
EndFunction