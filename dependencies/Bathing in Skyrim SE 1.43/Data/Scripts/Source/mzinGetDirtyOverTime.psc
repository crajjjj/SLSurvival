ScriptName mzinGetDirtyOverTime Extends ActiveMagicEffect
{ this script increases the player's dirtiness over time }

mzinBatheQuest Property BatheQuest Auto

FormList Property DirtyActors Auto

FormList Property DungeonLocationList Auto
FormList Property SettlementLocationList Auto

FormList Property GetDirtyOverTimeSpellList Auto
FormList Property SoapBonusSpellList Auto
FormList Property DirtinessSpellList Auto
FormList Property DirtinessThresholdList Auto

FormList Property EnterTierMessageList Auto
FormList Property ExitTierMessageList Auto

GlobalVariable Property DirtinessUpdateInterval Auto
GlobalVariable Property DirtinessPercentage Auto
GlobalVariable Property DirtinessPerHourDungeon Auto
GlobalVariable Property DirtinessPerHourSettlement Auto
GlobalVariable Property DirtinessPerHourWilderness Auto

Keyword Property WashPropKeyword Auto

; local variables
Actor DirtyActor
Bool  DirtyActorIsPlayer
Float DirtAppliedLastUpdate
Float LocalDirtinessPercentage
Float LocalLastUpdateTime

Event OnEffectStart(Actor Target, Actor Caster)
	DirtyActor = Target
	DirtyActorIsPlayer = (Target == Game.GetPlayer())

	Int InitialDirtinessTier = (Self.GetMagnitude() As Int) - 1

	If InitialDirtinessTier >= 0 && InitialDirtinessTier < DirtinessThresholdList.GetSize()
		LocalDirtinessPercentage = (DirtinessThresholdList.GetAt(InitialDirtinessTier) As GlobalVariable).GetValue()
		DirtyActor.AddSpell(DirtinessSpellList.GetAt(InitialDirtinessTier + 1) As Spell, False)
	Else
		LocalDirtinessPercentage = 0.0
		DirtyActor.AddSpell(DirtinessSpellList.GetAt(0) As Spell, False)
	EndIf

	If DirtyActorIsPlayer
		DirtinessPercentage.SetValue(LocalDirtinessPercentage)
	ElseIf DirtyActors.Find(DirtyActor) == -1
		DirtyActors.AddForm(DirtyActor)
	EndIf

	LocalLastUpdateTime = Utility.GetCurrentGameTime()
	RegisterForSingleUpdateGameTime(DirtinessUpdateInterval.GetValue())
EndEvent
Event OnEffectFinish(Actor Target, Actor Caster)
	If DirtyActorIsPlayer == False && DirtyActors.Find(DirtyActor) != -1		
		RemoveSpells(SoapBonusSpellList)
		RemoveSpells(GetDirtyOverTimeSpellList)
	EndIf
EndEvent
Event OnUpdateGameTime()
	ApplyDirt()
	LocalLastUpdateTime = Utility.GetCurrentGameTime()
	RegisterForSingleUpdateGameTime(DirtinessUpdateInterval.GetValue())
EndEvent
Event OnObjectEquipped(Form WashProp, ObjectReference WashPropReference)
	If WashProp.HasKeyWord(WashPropKeyword)
		CloseInventory()
		If BatheQuest.IsUnderWaterfall(DirtyActor)
			If BatheQuest.TryShowerActor(DirtyActor, WashProp As MiscObject) == False
				BatheQuest.TryBatheActor(DirtyActor, WashProp as MiscObject)	
			EndIf
		Else
			BatheQuest.TryBatheActor(DirtyActor, WashProp as MiscObject)
		EndIf
	EndIf
EndEvent

Function CloseInventory()
	If DirtyActorIsPlayer
		Game.DisablePlayerControls(False, False, False, False, False, True)
		Game.EnablePlayerControls(False, False, False, False, False, True)
	EndIf
EndFunction
Function ApplyDirt()
	Float HoursPassed = (Utility.GetCurrentGameTime() - LocalLastUpdateTime) * 24
	Float DirtPerHour = 0.0
	
	Location CurrentLocation = DirtyActor.GetCurrentLocation()

	If LocationHasKeyWordInList(CurrentLocation, SettlementLocationList)
		DirtPerHour = DirtinessPerHourSettlement.GetValue()
	ElseIf LocationHasKeyWordInList(CurrentLocation, DungeonLocationList)
		DirtPerHour = DirtinessPerHourDungeon.GetValue()
	ElseIf DirtyActor.IsInInterior()
		DirtPerHour = DirtinessPerHourSettlement.GetValue()
	Else
		DirtPerHour = DirtinessPerHourWilderness.GetValue()
	EndIf

	Float DirtAdded = (DirtPerHour * HoursPassed)

	If DirtAppliedLastUpdate <= 0.0
		DirtAppliedLastUpdate = DirtAdded
	EndIf

	Float DirtAppliedThisUpdate = (DirtAdded + DirtAppliedLastUpdate) / 2.0
	DirtAppliedLastUpdate = DirtAppliedThisUpdate
			
	LocalDirtinessPercentage += DirtAppliedThisUpdate
	If LocalDirtinessPercentage > 1.0
		LocalDirtinessPercentage = 1.0
	EndIf

	If DirtyActorIsPlayer
		DirtinessPercentage.SetValue(LocalDirtinessPercentage)
	EndIf

	Message EnterMessage = None
	Message ExitMessage = None

	Int Index = 0
	While Index < DirtinessSpellList.GetSize() - 1	

		Spell DirtinessSpell = DirtinessSpellList.GetAt(Index) As Spell
		Spell NextDirtinessSpell = DirtinessSpellList.GetAt(Index + 1) As Spell
		
		Float DirtinessThreshold = (DirtinessThresholdList.GetAt(Index) As GlobalVariable).GetValue()

		If DirtyActor.HasSpell(DirtinessSpell) && LocalDirtinessPercentage >= DirtinessThreshold

			RemoveSpells(SoapBonusSpellList)

			DirtyActor.RemoveSpell(DirtinessSpell)
			DirtyActor.AddSpell(NextDirtinessSpell, False)

			ExitMessage = ExitTierMessageList.GetAt(Index) As Message
			If EnterMessage == None
				EnterMessage= EnterTierMessageList.GetAt(Index + 1) As Message
			EndIf

		EndIf
		
		Index += 1
	
	EndWhile
	
	If DirtyActorIsPlayer
		If ExitMessage
			ExitMessage.Show()
		EndIf
		If EnterMessage
			EnterMessage.Show()
		EndIf
	EndIf
EndFunction

Bool Function LocationHasKeyWordInList(Location CurrentLocation, FormList KeyWordList)
	If CurrentLocation != None
		Int KeyWordListIndex = KeyWordList.GetSize()	
		While KeyWordListIndex
			KeyWordListIndex -= 1
			If CurrentLocation.HasKeyWord(KeyWordList.GetAt(KeyWordListIndex) As KeyWord)
				Return True
			EndIf		
		EndWhile
	EndIf
	
	Return False
EndFunction

Function RemoveSpells(FormList SpellFormList)
	Int SpellListIndex = SpellFormList.GetSize()
	While SpellListIndex
		SpellListIndex -= 1
		DirtyActor.RemoveSpell(SpellFormList.GetAt(SpellListIndex) As Spell)	
	EndWhile
EndFunction
