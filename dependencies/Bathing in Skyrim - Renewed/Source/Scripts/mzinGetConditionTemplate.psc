Scriptname mzinGetConditionTemplate extends activemagiceffect  

import ModEvent

Actor targetActor
String Property hostState Auto
GlobalVariable Property targetPercentage Auto

Event OnEffectStart(Actor Target, Actor Caster)
    targetActor = Target
    GoToState(hostState)
EndEvent

State mzinCondition_Swimming
    Event OnBeginState()
        RegisterForSingleUpdate(3.0)
    EndEvent
    Event OnUpdate()
        int targetEvent = Create("BiS_DecreaseActorDirt_" + targetActor.GetFormID())
        PushFloat(targetEvent, targetPercentage.GetValue())
        PushFloat(targetEvent, 4.2)
        PushFloat(targetEvent, 0.0)
        PushBool(targetEvent, true)
        Send(targetEvent)
    EndEvent
EndState