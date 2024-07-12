Scriptname PSC_AliasScript extends ReferenceAlias

PaySexCrimeMCM Property PSC_MCM Auto
PSC_ApproachStart Property ApproachStart Auto
PSC_QuestScript Property QuestScript Auto

Quest Property GuardApproachQuest  Auto

Location Property WindhelmLocation  Auto 
Location Property FalkreathLocation  Auto  
Location Property SolitudeLocation  Auto  
Location Property MorthalLocation  Auto   
Location Property DawnstarLocation  Auto    
Location Property MarkarthLocation  Auto  
Location Property RiftenLocation  Auto  
Location Property WhiterunLocation  Auto    
Location Property WinterholdLocation  Auto  
;Location Property WinterholdCollegeLocation  Auto



Event OnPlayerLoadGame()
	QuestScript.PluginCheck()
EndEvent



Event OnCellLoad()
	;clears actors could help against long term persitance.
	PSC_MCM.Teammates[0] = None
	PSC_MCM.Guards[0] = None
endEvent


Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	If ( (PSC_MCM.PSC_AllowApproach) && (PSC_MCM.PSC_UseApproachLocations) )
		If (akNewLoc)
			If (QuestScript.IsApprovedLocation(akNewLoc))
				If (akOldLoc)
					If !akNewLoc.IsChild(akOldLoc)
						;Debug.Notification("Entered Approachable Location")
						ApproachStart.StageOne()
					EndIf
				Else
					;Debug.Notification("Entered Approachable Location")
					ApproachStart.StageOne()
				EndIf
			EndIf
		EndIf
	EndIf
EndEvent