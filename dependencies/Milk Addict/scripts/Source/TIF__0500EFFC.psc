;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname TIF__0500EFFC Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if Init.SgoInstalled
	If Init.GetSgoActorMilkGetCount(akSpeaker) > 0
		Init.IsSgoMilkable = true
		_MA_Cost.SetValueInt((Menu.NpcMilkingCost * (1 + StorageUtil.GetIntValue(akSpeaker,"SGO.Stat.Milks") * Milkq.TimesMilkedMult)) as Int)
		_MA_Milk.SetValueInt(Math.Floor(Init.GetSgoActorMilkGetCount(akSpeaker)))
		;debug.notification("NPC is SGO milkable")
		self.GetOwningQuest().UpdateCurrentInstanceGlobal(_MA_Cost)
		self.GetOwningQuest().UpdateCurrentInstanceGlobal(_MA_Milk)
	Else
		Init.IsSgoMilkable = false
	;debug.notification("NPCs SGO tits are empty")
	EndIf
EndIf

If MilkQ.MILKmaid.find(akSpeaker) > -1
	If MME_Storage.getMilkCurrent(akSpeaker) > 0
		_MA_Cost.SetValueInt((Menu.NpcMilkingCost * (1 + MME_Storage.getMaidLevel(akSpeaker))) as Int)
		_MA_Milk.SetValueInt(Math.Floor(MME_Storage.getMilkCurrent(akSpeaker)))
		self.GetOwningQuest().UpdateCurrentInstanceGlobal(_MA_Cost)
		self.GetOwningQuest().UpdateCurrentInstanceGlobal(_MA_Milk)
		Init.IsMmeMilkable = true
	EndIf
EndIf

If Init.PahExtInstalled
	Init.PahSubmissionFactionRank= akSpeaker.GetFactionRank(Init.PahSubmissionFaction)
	Init.UpdateLocalPahRunAwayValueGlobal()
EndIf

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

GlobalVariable Property _MA_Cost Auto 
GlobalVariable Property _MA_Milk Auto
GlobalVariable Property _MA_PahSubmissionThreshold Auto

_MA_Mcm Property Menu Auto
_MA_Main Property Main Auto
_MA_Init Property Init Auto
MilkQuest Property MilkQ Auto
