Scriptname zbfGuiloutineBladeScript extends ObjectReference 

ObjectReference Property Guiloutine01 auto
Sound Property BladeSlice1 auto
Sound Property BladeSlice2 auto

auto State closed
Event OnActivate(ObjectReference akActionRef) 
        if akActionRef == Game.GetPlayer()
                    Guiloutine01.PlayGamebryoAnimation("forward", true)
			BladeSlice2.Play(self)
                    GotoState("opened")
            endif
EndEvent
EndState

State opened
Event OnActivate(ObjectReference akActionRef) 
        if akActionRef == Game.GetPlayer()
                    Guiloutine01.PlayGamebryoAnimation("backward", true)
			BladeSlice1.Play(self)
                    GotoState("closed")
            endif
EndEvent
EndState 
