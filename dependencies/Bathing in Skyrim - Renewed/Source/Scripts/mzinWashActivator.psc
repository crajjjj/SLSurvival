Scriptname mzinWashActivator extends ObjectReference

Event OnActivate(ObjectReference akActionRef)
    Actor DirtyActor = akActionRef as Actor

    If !DirtyActor || BatheQuest.IsRestricted(DirtyActor)
        Return
    EndIf

    BatheQuest.WashActor(DirtyActor, BatheQuest.TryFindWashProp(DirtyActor), true, false)
EndEvent

mzinBatheQuest Property BatheQuest Auto