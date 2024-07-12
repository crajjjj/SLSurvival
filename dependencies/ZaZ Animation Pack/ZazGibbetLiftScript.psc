Scriptname ZazGibbetLiftScript extends ObjectReference  


ObjectReference Property GibbetLift auto
Sound Property sound1 auto
Sound Property sound2 auto

auto State closed
Event OnActivate(ObjectReference akActionRef) 
        if akActionRef == Game.GetPlayer()
                    GibbetLift.PlayGamebryoAnimation("forward", true)
			sound2.Play(self)
                    GotoState("opened")
            endif
EndEvent
EndState

State opened
Event OnActivate(ObjectReference akActionRef) 
        if akActionRef == Game.GetPlayer()
                    GibbetLift.PlayGamebryoAnimation("backward", true)
			sound1.Play(self)
                    GotoState("closed")
            endif
EndEvent
EndState