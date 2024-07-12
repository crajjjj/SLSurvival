ScriptName mzinBathe Extends ActiveMagicEffect
{ this script bathes a dirty actor }

FormList Property DirtinessTierList AutoReadOnly
FormList Property BathingAnimationCyclesList AutoReadOnly

GlobalVariable Property DirtyLevel Auto
GlobalVariable Property LastDirtyUpdateTime Auto
GlobalVariable Property BathingAnimationStyle AutoReadOnly

Idle Property BathingAnimationStop AutoReadOnly
Idle Property BathingAnimationDefaultPart1 AutoReadOnly
Idle Property BathingAnimationDefaultPart2 AutoReadOnly
Idle Property BathingAnimationDefaultPart3 AutoReadOnly
Idle Property BathingAnimationDefaultPart4 AutoReadOnly
Idle Property BathingAnimationCustom1 AutoReadOnly

Message Property BathingSuccessMessage AutoReadOnly

Event OnEffectStart(Actor BathingActor, Actor akCaster)

	BathingSuccessMessage.Show()

	BathingActor.UnequipAll()
	
	Int DirtinessTierIndex = GetDirtinessTier(BathingActor)
	PlayBathingAnimation(BathingActor, DirtinessTierIndex)
	BathingActor.RemoveSpell(DirtinessTierList.GetAt(DirtinessTierIndex) As Spell)
	BathingActor.AddSpell(DirtinessTierList.GetAt(0) As Spell, abVerbose = False)

	DirtyLevel.SetValue(0.0)		
	LastDirtyUpdateTime.SetValue(Utility.GetCurrentGameTime())

EndEvent

; dirty
Int Function GetDirtinessTier(Actor BathingActor)

	Int DirtinessTier = 0
	
	Int DirtinessTierIndex = DirtinessTierList.GetSize()
	While DirtinessTierIndex
		DirtinessTierIndex -= 1
		If BathingActor.HasSpell(DirtinessTierList.GetAt(DirtinessTierIndex) As Spell)
			DirtinessTier = DirtinessTierIndex
		EndIf
	EndWhile
	
	Return DirtinessTier

EndFunction

; animations
Function PlayBathingAnimation(Actor BathingActor, Int DirtinessTier)

	Int AnimationStyle = BathingAnimationStyle.GetValue() As Int
	Int AnimationCycles = (BathingAnimationCyclesList.GetAt(DirtinessTier) As GlobalVariable).GetValue() As Int

	If AnimationStyle > 0 && BathingActor.IsSwimming() == False
	
		Game.ForceThirdPerson()
		Game.DisablePlayerControls(True, True, False, False, True, False, True)
		Utility.Wait(0.1)
	
		If AnimationStyle == 1
			PlayBathingAnimationDefault(BathingActor, AnimationCycles)
		ElseIf AnimationStyle == 2
			PlayBathingAnimationCustom1(BathingActor, AnimationCycles)
		EndIf
		
		Game.EnablePlayerControls()
		
	EndIf

EndFunction
Function PlayBathingAnimationDefault(Actor BathingActor, Int AnimationCycles)

	BathingActor.PlayIdle(BathingAnimationDefaultPart1)
	Utility.Wait(2)
	BathingActor.PlayIdle(BathingAnimationStop)
	Utility.Wait(1)
	
	While AnimationCycles > 0	
		AnimationCycles -= 1	
		BathingActor.PlayIdle(BathingAnimationDefaultPart2)
		Utility.Wait(2)
		BathingActor.PlayIdle(BathingAnimationStop)
		Utility.Wait(1)
	EndWhile
	
	BathingActor.PlayIdle(BathingAnimationDefaultPart3)
	Utility.Wait(2)
	BathingActor.PlayIdle(BathingAnimationStop)
	Utility.Wait(1)
	BathingActor.PlayIdle(BathingAnimationDefaultPart4)
	Utility.Wait(3)
	BathingActor.PlayIdle(BathingAnimationStop)

EndFunction
Function PlayBathingAnimationCustom1(Actor BathingActor, Int AnimationCycles)

	While AnimationCycles > 0
		AnimationCycles -= 1	
		BathingActor.PlayIdle(BathingAnimationCustom1)
		Utility.Wait(16)
	EndWhile

EndFunction
