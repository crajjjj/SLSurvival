Scriptname _AMP_ToggleSpell extends activemagiceffect  

AmputatorMainScript Property AMS Auto

Event OnEffectStart (Actor akTarget, Actor akCaster)
	ShowMessage( akTarget)
EndEvent

Function ShowMessage(Actor akTarget)
	int ibutton = AMPMSGToggleSpell.show()                  
	int dbutton = AMPMSGToggleleftrightSpell.show()
	AMS.ApplyAmputator(akTarget, ibutton, dbutton)
EndFunction

Message Property AMPMSGToggleSpell  Auto  
Message Property AMPMSGToggleleftrightSpell  Auto  
