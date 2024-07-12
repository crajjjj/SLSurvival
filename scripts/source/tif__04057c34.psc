;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__04057C34 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Form SwDrug
Int i = 0
While i < Menu.PpFailDrugCount
	If Init.SkoomaWhoreInstalled
		SwDrug = Init._SLS_DrugsListWoLactacid.GetAt(Utility.RandomInt(0,((Init._SLS_DrugsListWoLactacid.GetSize()) - 1)))
	EndIf

	If Init.SkoomaWhoreInstalled && Init.MmeInstalled
		If Utility.RandomFloat(0.0, 100.0) > 50.0
			PlayerRef.EquipItem(SwDrug)
		Else
			PlayerRef.EquipItem(Init.MME_Lactacid)
		EndIf
	ElseIf Init.SkoomaWhoreInstalled
		PlayerRef.EquipItem(SwDrug)
	ElseIf Init.MmeInstalled
		PlayerRef.EquipItem(Init.MME_Lactacid)
	EndIf
	Utility.Wait(1.0)
	i += 1
EndWhile
PpFail.EndPickpocketFailFg(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

_SLS_PickPocketFailDetect Property PpFail Auto
SLS_Init Property Init Auto
SLS_Mcm Property Menu Auto
Actor Property PlayerRef Auto
