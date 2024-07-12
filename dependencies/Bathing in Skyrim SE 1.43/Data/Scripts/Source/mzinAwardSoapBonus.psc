ScriptName mzinAwardSoapBonus Extends ActiveMagicEffect
{ this script applies soap bonuses to a bathing actor }

MiscObject Property Soap Auto
FormList Property SoapList Auto
FormList Property SoapBonusList Auto
FormList Property SoapBonusMessageList Auto

Event OnEffectStart(Actor BathingActor, Actor akCaster)

	Int SoapIndex = GetMatchingSoapIndex(Soap)
	
	; remove soap from inventory
	BathingActor.RemoveItem(SoapList.GetAt(SoapIndex) As MiscObject, 1, abSilent = True)

	; clear any existing soap bonus
	Int SoapBonusIndex = SoapBonusList.GetSize()
	While SoapBonusIndex
		SoapBonusIndex -= 1
		If BathingActor.HasSpell(SoapBonusList.GetAt(SoapBonusIndex) As Spell)
			BathingActor.RemoveSpell(SoapBonusList.GetAt(SoapBonusIndex) As Spell)
		EndIf
	EndWhile

	; add soap bonus
	Spell SoapBonus = SoapBonusList.GetAt(SoapIndex) As Spell
	BathingActor.AddSpell(SoapBonus, abVerbose = False)
	
	; report soap bonus
	Message SoapBonusMessage = SoapBonusMessageList.GetAt(SoapIndex) As Message
	SoapBonusMessage.Show()

EndEvent

Int Function GetMatchingSoapIndex(MiscObject SoapObject)

	Int MatchingSoapIndex = -1
	Int SoapListIndex = SoapList.GetSize()
	
	While SoapListIndex
		SoapListIndex -= 1		
		If SoapObject == SoapList.GetAt(SoapListIndex) As MiscObject 
			MatchingSoapIndex = SoapListIndex
			SoapListIndex = 0 ; break
		EndIf		
	EndWhile
	
	Return MatchingSoapIndex

EndFunction
