Scriptname _DFsold extends Quest  Conditional

QF__Gift_09000D62 Property q  Auto  
_DflowFollowerController Property q2  Auto  
Scene Property SaleScene Auto

Bool Property Active auto Conditional
Bool Property Enable auto Conditional
Float Property Timer  Auto Conditional
Float Property TimerMax  Auto
Float Property TimerMin  Auto

ObjectReference Property SellerMarker  Auto

ReferenceAlias Property Alias_Seller Auto
ReferenceAlias Property Alias_Buyer Auto
ReferenceAlias Property Alias_You Auto

ReferenceAlias Property _DM1 Auto
ReferenceAlias Property _DM2 Auto
ReferenceAlias Property _DM3 Auto
ReferenceAlias Property _DM4 Auto

; Seems to be flag for whether sold or not. I don't think it's used for anything.
Bool Property x = False Auto


Function StartSaleTimer()

    Q.PickEndlessSlaveryDestination()
    Enable = True
    RandomTimer()

EndFunction


Function Sale(Actor Buyer)

    q.Tool.PauseAll()
    Game.SetPlayerAIDriven(True)
    ; The dummy is used to drive the scene dialog.
    q.Tool.PC.Enable() ; invis race do nothing actor
    q.Tool.PC.MoveTo(Game.GetPlayer(), 1000, 1000, 1000)
    
    Alias_Buyer.ForceRefTo(Buyer)
    Alias_You.ForceRefTo(q.Tool.PC)
    Alias_Seller.ForceRefTo(q.Alias__DMaster.GetActorReference())
    
    SaleScene.Start()
    q.Tool.SceneErrorCatch(SaleScene,60)
    
    ; Swap followers
    q2.InternalRemoveFollower(q.Alias__DMaster.GetActorReference()) ; This sets the DFlow quest to stage 5
    
    q2.AddFollower(Buyer)
    
    q.Alias__DMaster.ForceRefto(buyer)
    Timer = Utility.RandomFloat(TimerMin,TimerMax) + Utility.GetCurrentGameTime()
    q.Tool.PC.disable()
    
    If x
        Alias_Seller.GetActorReference().Moveto(SellerMarker)
    endif
    
    FixAliases(Buyer)
    Q.SetStage(100) ; Basic slavery.
    
    SellerMarker.Moveto(Buyer)
    x = True ; Flag sold is active?
    q.Tool.ResumeAll()
    Game.SetPlayerAIDriven(False)
    
EndFunction

Function ReturnBuyer()
    ; Safe to call this if sold never ran
    Actor buyer = Alias_Buyer.GetActorReference()
    If buyer
        ; Put the buyer back in their place... Seems a bit dodgy ... oh well...
        buyer.MoveTo(SellerMarker)
        x = False
    EndIf
EndFunction

Function FixAliases(Actor a)
    ; Update the aliases for DealO, P, S and Games
	_DM1.ForceRefto(a)
	_DM2.ForceRefto(a)
	_DM3.ForceRefto(a)
	_DM4.ForceRefto(a)
Endfunction

function RandomTimer()
    Timer = Utility.GetCurrentGameTime() + Utility.RandomFloat(TimerMin, TimerMax)
Endfunction
