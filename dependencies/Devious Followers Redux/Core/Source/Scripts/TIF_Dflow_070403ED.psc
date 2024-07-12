;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF_Dflow_070403ED Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
If _Dtats.getValue() > 0
        Int t = Utility.RandomInt(1, _Dtats.getvalue() as int)
        int n = 0
       while n < t
              SendModEvent("RapeTattoos_addTattoo")
              Utility.wait(2)
              n += 1
       endwhile

endif

Int iFormIndex = PlayerRef.GetNumItems()
Bool Taken = False 
	While iFormIndex > 0
		iFormIndex -= 1
		Form kForm = PlayerRef.GetNthForm(iFormIndex)
		Int r = Utility.RandomInt(1,100)
		Int t = (_DFlowItemsPerRemoved.GetValue()*2) as int
		if r <= t && !kForm.HasKeyWord(SSNS)  && !kForm.HasKeyWord(VNS)
		PlayerRef.Removeitem(kForm,1,true,Shop)
		Taken = True
		endif
	EndWhile
		int g = playerref.getgoldamount()
		PlayerRef.RemoveItem(Gold001, (g*0.8) as int)
		Int NewDebt = EnslaveDebt.GetValueInt() 
		NewDebt -= 100
		(GetowningQuest() as QF__Gift_09000D62).SetDebt(NewDebt)
		tool.reduceResist(12)
		If Taken
		_DflowItems.setstage(1)
		endif
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