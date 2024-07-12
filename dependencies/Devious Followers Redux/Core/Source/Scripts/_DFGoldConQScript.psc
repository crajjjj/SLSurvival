Scriptname _DFGoldConQScript extends Quest  Conditional

QF__Gift_09000D62 Property Q auto
; Access to MCM via Q.Tool.MCM
; Access to Tool via Q.Tool
_DFLicensing Property _DFLicenses Auto

Message Property _DFlowDebtCreditMsg0 Auto
Message Property _DFlowDebtCreditMsg1 Auto
Message Property _DFlowDebtCreditMsg2 Auto
MiscObject Property Gold001 Auto
MiscObject Property _DFCred001 Auto

GlobalVariable Property _DWill Auto
GlobalVariable Property _DflowDebt Auto

Float Property Decay Auto Conditional
Float Property RedGoldMod Auto Conditional ; Modifier for ReduceGold

Int Property Credit Auto Conditional
Int Property CredToLeave Auto Conditional
Int Property AgreedGold Auto Conditional
Int Property AgreedGoldSlaveDefault Auto
Int Property AgreedGoldDefault Auto
Int Property AgreedGoldMin Auto
Int Property AgreedGoldMax Auto
Int Property AskForMore Auto Conditional
; AskForMore states 
; 0 = Locked out
; 1 = Unlocked can't leave
; 2 = Unlocked can leave @ 1000 + without credit
; 3 = Unlocked can leave @ 1000 Credit

Float ReduceGold = 0.0
Float ReduceGold2 = 0.0
Float DecayS = 0.0

Bool Property Stay0 Auto Conditional ; If player loses all gold it won't be replaced.
Bool Property KnockDown Auto Conditional 
Bool Property Other Auto Conditional 
Bool Property CredToLeaveBool Auto Conditional

; Yes, these two have back-to-front names ... sigh.
Bool Property Active Auto Conditional  ; If gold control is enabled in MCM (means enabled)
Bool Property Enabled Auto Conditional ; If gold control is currently running (means active)

Bool Property IsEnabledForcedLicenseControl Auto
Bool Property WasActive Auto
Bool Property WasEnabled Auto

Int Property HadGold Auto



; Ends control if it was running, resets state - called by SetStage(0)
Function ResetIt()
    Credit = 0 
    Enabled= False
    AgreedGold = Utility.Randomint(AgreedGoldMin, AgreedGoldMax)
EndFunction


Function StartIt()

    Q.AdjustDebt(0.0)

    AgreedGold = Utility.Randomint(AgreedGoldMin,AgreedGoldMax)
    Int pcGold = Game.GetPlayer().GetItemCount(Gold001)

    Credit = Q.NormalizeDebt() ; Make any -ve debt player had into GC credit.
    Credit += Q.DebtPayGoldQ(pcGold)

    AskforMore = 1
    If pcGold > AgreedGold
        Game.GetPlayer().Removeitem(Gold001, pcGold - AgreedGold, True)
    Else
        Game.GetPlayer().AddItem(Gold001, AgreedGold - pcGold, True)
    EndIf

    _DFlowDebtCreditMsg1.Show(AgreedGold, Q.Tool.MCM.Debt.GetValueInt(),Credit)

    Enabled = True
    
    If IsEnabledForcedLicenseControl
        _DFLicenses.SetStage(9)
    EndIf
    
EndFunction


Function Endit()

    If Enabled
        Int pcGold = Game.GetPlayer().GetItemCount(Gold001)
        If pcGold > Credit
            Game.GetPlayer().Removeitem(Gold001, pcGold - Credit, True)
        Else
            Game.GetPlayer().AddItem(Gold001, Credit - pcGold, True)
        EndIf
    EndIf
    
    ResetIt()
    Reset()
    
EndFunction


Function EnditNoCredit()

    If Enabled
        Int pcGold = Game.GetPlayer().GetItemCount(Gold001)
        Game.GetPlayer().Removeitem(Gold001, pcGold, True)
    EndIf
    
    ResetIt()
    Reset()
    
EndFunction


Function CoinFlip()

    Int Coin = Utility.Randomint(0,1)
    If Coin == 1
        Debug.Notification("$DFHEADS")
        EndIt()
        Reset()
    ElseIf Coin == 0
        Debug.Notification("$DFTAILS")
        Q.PunDebt()
    EndIf
        
EndFunction


Function AddCredit(Int surplusCash)

    Credit += surplusCash
    RebalanceDebtAndCredit()
    
    Recalc()
    
EndFunction


Function Recalc() ; Occurs on location change, or if you talk to the follower about debt.

    If Enabled && Q.GetStage() >= 10

        Int pcGold = Game.GetPlayer().GetItemCount(Gold001)
        Int missingGold = 0
        
        If pcGold < AgreedGold
            missingGold = AgreedGold - pcGold
            
            If pcGold == 0 && Stay0
                AgreedGold = 0
                AskForMore = 0
                Debug.Notification("$DF_LOSTALLGOLD")
            Else
                ; Add missing gold
                Game.GetPlayer().AddItem(Gold001, missingGold)
            EndIf
            
            If Credit >= 1
                Int remainingCredit = Credit - missingGold
                
                If remainingCredit >= 1
                    RemoveCreditNoti(missingGold)
                    missingGold = 0
                    Credit = remainingCredit 
                ElseIf remainingCredit < 1
                    missingGold -= Credit
                    Debug.Notification("$DFNOCRED")
                    Credit = 0
                EndIf
            EndIf	
                
            If missingGold != 0
            
                Q.Debt(missingGold)
                ; Don't warn slaves or game-players about impending enslavement
                If Q.GetStage() < 98 && Q.Debt.GetValue() > Q.EnslavementDebt.GetValue()
                    Debug.Notification("$DFDANGER")
                EndIf
                Q.Tool.MCM.AddDebtNoti(missingGold)
                
            EndIf
        
        
        ElseIf pcGold > AgreedGold ; Player gained some gold - adjust debt/credit
        
            Int gainedGold =  pcGold - AgreedGold 
            Game.GetPlayer().RemoveItem(Gold001, gainedGold)
            
            Int remainingCredit = Q.DebtPayGoldQ(gainedGold) ; This will half the amount paid in if you have an abusive follower
            If remainingCredit > 0
                AddCreditNoti(remainingCredit)
                Credit += remainingCredit
            EndIf
        
        Endif
        
        ; Balance adjustment does not eat credit like debt payments do.
        RebalanceDebtAndCredit()
        
        ; Decay and DecayS are Floats, AgreedGold is an Int ... this is messy.
        If Decay > 0 
            If DecayS == 0
                DecayS = (AgreedGold As Float) * Decay
            EndIf
            AgreedGold -= (DecayS As Int)
            
            Game.GetPlayer().RemoveItem(Gold001, DecayS As Int, True)
        Endif
        
        CredToLeaveBool = Credit >= CredToLeave
        
        If AgreedGold < 0 
            AgreedGold = 0
        EndIf
        
    EndIf
    
Endfunction


Function RebalanceDebtAndCredit()

    Int currentDebt = _DflowDebt.GetValue() As Int
    
    If Credit > 0 && currentDebt > 0
        If Credit >= currentDebt
            Credit -= currentDebt
            currentDebt = 0
        Else
            currentDebt -= Credit
            Credit = 0
        EndIf
    Endif
    
    _DflowDebt.SetValue(currentDebt As Float)

EndFunction


Function IncAgreedGold(int a)

    If Enabled
        AgreedGold += a 
        Game.GetPlayer().AddItem(Gold001, a)
        ReduceGold2 = AgreedGold * RedGoldMod * 2 
        ReduceGold = AgreedGold * RedGoldMod * 2
        If Decay > 0
            DecayS = AgreedGold * Decay*3
        EndIf
    EndIf
    
EndFunction

Function ResetCurrentGold()

    If Enabled
        ; Adjust current gold state and decay rate
        If AgreedGold > AgreedGoldDefault
            Int delta = AgreedGold - AgreedGoldDefault
            AgreedGold = AgreedGoldDefault
            Game.GetPlayer().RemoveItem(Gold001, delta, True)
        ElseIf AgreedGold <= AgreedGoldDefault
            Int delta = AgreedGoldDefault - AgreedGold
            AgreedGold = AgreedGoldDefault
            Game.GetPlayer().AddItem(Gold001, delta, True)
        EndIf
        
        If Decay > 0.0
            DecayS = AgreedGold * Decay
        EndIf
    EndIf

EndFunction

Function ResetAgreedGold() ; Use this only when sleeping

    If !Enabled
        Return
    EndIf
    
    Recalc()
    ReduceGold2 = 0
    ReduceGold = 0
    
    ; Special case for slaves...
    If Q.GetStage() >= 98 && Q.GetStage() < 200 
        AgreedGoldDefault = 0
        AskForMore = 0
        
        Int getMoreChance = currentWill * 8 ; Less chance than if you are free
        If Utility.RandomInt(0, 99) < getMoreChance
            AskForMore = 1
        EndIf
        
        ResetCurrentGold()
        
        ; There's no message for slaves
        Return
    EndIf

    
    ; Make the gold you get follow a center-loaded distribution curve, rather than all values equally likely.
    ; You are more likely to get a value somewhere in the middle than at the extremes.
    Int goldRange = AgreedGoldMax - AgreedGoldMin
    
    Int rolls = 3
    Int rollMax = goldRange / rolls
    Int rolled = 0
    While rolls
        rolled += Utility.RandomInt(0, goldRange)
        rolls -= 1
    EndWhile
    
    AgreedGoldDefault = AgreedGoldMin + rolled

    
    Int currentWill = _DWill.GetValue() As Int
    If currentWill < Utility.RandomInt(0, 5)
        AgreedGoldDefault = AgreedGoldMin
    EndIf

    ResetCurrentGold()

    ; AskForMore states 
    ; 0 = Locked out
    ; 1 = Unlocked can't leave
    ; 2 = Unlocked can leave @ threshold + without credit
    ; 3 = Unlocked can leave @ threshold with credit
    
    ; Ask for more was spaghetti - simplified it - chance to leave now directly based on willpower
    ; Things are much better at high will, but also worse at zero will.
    Int leaveChance = currentWill * 10
    If Utility.RandomInt(0, 99) < leaveChance
        ; Can leave
        AskForMore = 2
        ; Chance to keep credit is also directly off willpower
        Int keepCreditChance = currentWill * 7
        If Utility.RandomInt(0, 99) < keepCreditChance
            AskForMore = 3
        EndIf
    Else
        ; Cannot leave
        AskForMore = 0
        Int getMoreChance = currentWill * 11
        If Utility.RandomInt(0, 99) < getMoreChance
            AskForMore = 1
        EndIf
    EndIf
    
    


    ; Show gold control status message
    Int debtGold = _DFlowDebt.GetValue() As Int
    
    If AskForMore == 1
        _DFlowDebtCreditMsg1.Show(AgreedGold, debtGold, Credit)
    ElseIf AskForMore == 0
        _DFlowDebtCreditMsg0.Show(AgreedGold, debtGold, Credit)
    ElseIf AskForMore == 2
        _DFlowDebtCreditMsg2.Show(AgreedGold, CredToLeave, debtGold, Credit)
    ElseIf AskForMore == 3
        _DFlowDebtCreditMsg2.Show(AgreedGold, CredToLeave, debtGold, Credit)
    EndIf
    
EndFunction


Function AddCreditNoti(int n)
    Game.GetPlayer().AddItem(_DFCred001, n) 
    Game.GetPlayer().RemoveItem(_DFCred001, n, True) 
EndFunction


Function RemoveCreditNoti(int n)
    Game.GetPlayer().AddItem(_DFCred001, n, True) 
    Game.GetPlayer().RemoveItem(_DFCred001, n) 
EndFunction



Function FollowerKnockeddown()

	If Enabled && KnockDown && Q.GetStage() >= 10 && (Q.GetStage() < 100 || Q.GetStage() >= 200)
    
        If ReduceGold == 0
            ReduceGold = AgreedGold*RedGoldMod
            If Utility.RandomInt(0, 99) < 33
                AskForMore = 0
            EndIf
        EndIf
        
        AgreedGold -= (ReduceGold As Int)
        
        If AgreedGold < 0
                ReduceGold = ReduceGold - AgreedGold
                AgreedGold = 0
                AskForMore = 0
        EndIf
        
        Game.GetPlayer().RemoveItem(Gold001, ReduceGold as Int, True)

    EndIf
    
EndFunction


Function LivesLost()

    If Enabled && (Q.GetStage() < 100 || Q.GetStage() > 10)
        If OTher
            Float lives = Q.Tool.MCM.Lives.GetValue()
            Float livesM = Q.Tool.MCM.Lives.GetValue()
            Float Third = LivesM/3
            
            If ReduceGold2 == 0
                ReduceGold2 = AgreedGold * RedGoldMod
            EndIf
            
            If Utility.RandomFloat(0, Lives) < Third
                AgreedGold -= ReduceGold2 As Int
                If AgreedGold < 0
                    ReduceGold2 -= AgreedGold
                    AgreedGold = 0
                    AskForMore = 0
                EndIf
                Game.GetPlayer().RemoveItem(Gold001, ReduceGold2 as Int, True)
            EndIf
            
            If Utility.RandomInt(0, 99) < 10
                AskForMore = 0
            EndIf
        EndIf
    EndIf

EndFunction


Function Pause()

    WasActive = Active
    WasEnabled = Enabled
    HadGold = 0
    
    ; If we pause, gold control ends, and credit is returned.
    ; If there's debt we remember it.
    If Enabled
    
        If Credit < 0
            _DflowDebt.Mod(-Credit)
            Credit = 0
        EndIf
    
        HadGold = pcGold

        Int pcGold = Game.GetPlayer().GetItemCount(Gold001)
        If pcGold > Credit
            ; In this case PC has more gold than they have credit, take away the gold they don't own.
            Game.GetPlayer().Removeitem(Gold001, pcGold - Credit, True)
        Else
            ; PC has more credit than they had gold, so we return the gold.
            Game.GetPlayer().AddItem(Gold001, Credit - pcGold, True)
        EndIf
        
        ; As player had their gold returned, or debt increased, we can treat Credit as 0 at this point
        Credit = 0
        
        Enabled = False
    EndIf

EndFunction


Function Unpause()

    Active = WasActive
    Enabled = WasEnabled
    
    If Enabled
    
        ; When we arrive here, PC had Credit set to zero - we only want to restore the amount of gold they had.
        ; We aren't trying to rebalance all their credit ... the only thing that makes sense here is to rebalance credit relative to what they have.
        ; If the player had huge credit when they left, and that gold was returned, and they lost it, we don't want to give them huge debt; they lost their own money not the follower's.
        ; Just balance the player's HELD gold against Credit(0) and Debt.
    
        Int pcGold = Game.GetPlayer().GetItemCount(Gold001)
        If pcGold > HadGold
            ; Have more than we used to
            Int extraGold = pcGold - HadGold
            Game.GetPlayer().RemoveItem(Gold001, extraGold, True)
            Credit = extraGold
        Else
            ; Have less than we used to
            Int lessGold = HadGold - pcGold
            Game.GetPlayer().AddItem(Gold001, lessGold, True)
            _DFlowDebt.Mod(lessGold)
        EndIf
    
    EndIf

EndFunction
