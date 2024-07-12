;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF_Dflow_081A1EA9 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Int iFormIndex = PlayerRef.GetNumItems()
Bool taken = False 
Int chance = (_DFlowItemsPerRemoved.GetValue() As Int) * 2

While iFormIndex > 0
	iFormIndex -= 1
	Form kForm = PlayerRef.GetNthForm(iFormIndex)
	Int r = Utility.RandomInt(1,100)
	If r <= chance && !kForm.HasKeyWord(SSNS)  && !kForm.HasKeyWord(VNS)
		PlayerRef.Removeitem(kForm, 1, True, Shop)
		taken = True
	EndIf
EndWhile

Int pcGold = PlayerRef.GetGoldAmount()
Int removeAmount = (pcGold * 80) / 100

PlayerRef.RemoveItem(Gold001, removeAmount)

Int newDebt = EnslaveDebt.GetValueInt() 
newDebt -= 100
(GetowningQuest() as QF__Gift_09000D62).SetDebt(NewDebt)

tool.ReduceResist(12)

Int maxTattoos = _Dtats.GetValue() As Int

If maxTattoos > 0

       Int t = Utility.RandomInt(1, maxTattoos)
	While t > 0
		t -= 1
              SendModEvent("RapeTattoos_addTattoo")
      	       Utility.wait(3)
       EndWhile

EndIf

If taken
	_DflowItems.SetStage(1)
Endif

(GetowningQuest() as QF__Gift_09000D62).tool.ResumeALL()
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
Keyword Property VNS  Auto 
_DFtools Property tool  Auto  
Keyword Property SSNS  Auto  

ObjectReference Property Shop  Auto  

GlobalVariable Property _DFlowItemsPerRemoved  Auto  
Quest property _DflowItems auto
