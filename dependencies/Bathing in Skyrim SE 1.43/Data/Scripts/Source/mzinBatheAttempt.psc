ScriptName mzinBatheAttempt Extends ReferenceAlias
{ this script detects bathe attempts when soap is used }

FormList Property SoapList Auto
FormList Property BatheAttemptSpellList Auto

Event OnObjectEquipped(Form BaseObject, ObjectReference Reference)
	
	Debug.Notification("OnObjectEquipped: " + Self.GetActorReference().GetName())
	
	Int MatchingSoapIndex = GetMatchingSoapIndex(BaseObject)
	If MatchingSoapIndex >= 0
		
		; close inventory
		Game.DisablePlayerControls(False, False, False, False, False, True)
		Game.EnablePlayerControls(False, False, False, False, False, True)
		
		; find matching bathe attempt spell
		Spell BatheAttemptSpell = BatheAttemptSpellList.GetAt(MatchingSoapIndex) As Spell
		
		; attempt bathe
		Self.GetActorReference().AddSpell(BatheAttemptSpell, abVerbose = False)
		Utility.Wait(0.1)
		Self.GetActorReference().RemoveSpell(BatheAttemptSpell)

	EndIf

EndEvent

Int Function GetMatchingSoapIndex(Form BaseObject)

	Int MatchingSoapIndex = -1
	Int SoapListIndex = SoapList.GetSize()
	
	While SoapListIndex
		SoapListIndex -= 1		
		If SoapList.GetAt(SoapListIndex) As MiscObject == BaseObject As MiscObject
			MatchingSoapIndex = SoapListIndex
			SoapListIndex = 0 ; break
		EndIf		
	EndWhile
	
	Return MatchingSoapIndex

EndFunction
