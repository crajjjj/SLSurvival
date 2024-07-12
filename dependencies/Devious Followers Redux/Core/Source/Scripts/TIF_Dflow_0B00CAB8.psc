;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF_Dflow_0B00CAB8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Q.Debt(FreedomCost.getValue()/4)

GetOwningQuest().reset()
GetOwningQuest().setstage(100)
int tG = PlayerRef.GetItemCount(Gold001)
PlayerRef.RemoveItem(Gold001, tG)
msg.show()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

QF__Gift_09000D62 Property q  Auto  

zadlibs Property libs  Auto  
Actor Property PlayerRef  Auto  
Armor Property Collar  Auto  
Armor Property Mitts  Auto  
Armor Property boots  Auto

Message Property msg  Auto  
GlobalVariable Property FreedomCost Auto


MiscObject Property Gold001  Auto  
