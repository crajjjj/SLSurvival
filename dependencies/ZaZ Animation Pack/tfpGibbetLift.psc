Scriptname tfpGibbetLift extends ObjectReference


ObjectReference Property tfpGibbetLifting auto
Sound Property stonesound1 auto
Sound Property stonesound2 auto

auto State closed
Event OnActivate(ObjectReference akActionRef) 
        if akActionRef == Game.GetPlayer()
                    tfpGibbetLifting.PlayGamebryoAnimation("forward", true)
			stonesound2.Play(self)
                    GotoState("opened")
            endif
EndEvent
EndState

State opened
Event OnActivate(ObjectReference akActionRef) 
        if akActionRef == Game.GetPlayer()
                    tfpGibbetLifting.PlayGamebryoAnimation("backward", true)
			stonesound1.Play(self)
                    GotoState("closed")
            endif
EndEvent
EndState
