Scriptname sr_SHBPlugMonitor extends ReferenceAlias  

sr_inflateQuest property inflater auto

Event OnObjectUnequipped(Form akBaseObject, ObjectReference akReference)
	If akBaseObject as Armor
		int plugged = inflater.isPlugged(inflater.player)
		if plugged != 1 && plugged != 3 && !(GetOwningQuest() as sr_SHBFailQuest).done
			(GetOwningQuest() as sr_SHBFailQuest).ForceDeflate()
		endIf
	EndIf
EndEvent
