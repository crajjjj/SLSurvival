;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF_Dflow_0703623B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Bool taken = False

; Interesting mis-named variable here... Seems to contain a chance, not a limit.
Int removeChance = _DFlowItemsPerRemoved.GetValue() as INT

Int iFormIndex = PlayerRef.GetNumItems()

While iFormIndex > 0

	iFormIndex -= 1
	Form kForm = PlayerRef.GetNthForm(iFormIndex)
	Int r = Utility.RandomInt(1,100)
	If r <= removeChance && !kForm.HasKeyWord(SSNS)  && !kForm.HasKeyWord(VNS)
		PlayerRef.Removeitem(kForm, 1, True, Shop)
		taken = True
	EndIf

EndWhile

Int pcGold = PlayerRef.GetGoldAmount() As Int

PlayerRef.RemoveItem(Gold001, pcGold)

pcGold = (pcGold * 75) / 100

(GetowningQuest() as QF__Gift_09000D62).DebtPay(pcGold)

Tool.ReduceResist(18)

If taken
	; Quest to regain lost items
	_DflowItems.SetStage(1)
EndIf
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
GlobalVariable Property EnslaveDebt Auto
GlobalVariable Property Will Auto

MiscObject Property Gold001  Auto  

GlobalVariable Property _Dtats  Auto  

GlobalVariable Property SSO  Auto  

Keyword Property SSNS  Auto  
Keyword Property VNS  Auto 

_DFtools Property tool  Auto  

ObjectReference Property Shop  Auto  

GlobalVariable Property _DFlowItemsPerRemoved  Auto  

Quest property _DflowItems auto
