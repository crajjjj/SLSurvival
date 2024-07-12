Scriptname _DFSpankShim

Function SpankAss() Global

    _STA_SpankUtil spanky = Game.GetFormFromFile(0x00000D62, "Spank That Ass.esp") As _STA_SpankUtil
    If spanky
        spanky.SpankAssBasic()
    EndIf

EndFunction

Function SpankTits() Global

    _STA_SpankUtil spanky = Game.GetFormFromFile(0x00000D62, "Spank That Ass.esp") As _STA_SpankUtil
    If spanky
        spanky.SpankTitsBasic()
    EndIf

EndFunction

Function SpankSound() Global

    _STA_SpankUtil spanky = Game.GetFormFromFile(0x00000D62, "Spank That Ass.esp") As _STA_SpankUtil
    If spanky
        spanky.SpankSoundPlayer()
    EndIf

EndFunction


Int Function GetMasochismStage() Global

    ; PlayerMasochism increases as masochism grows, each MasochismStepSize it goes up a step
    ; Hates    -2
    ; Dislikes -1
    ; Unused    0
    ; Likes     1
    ; Loves     2
    
    _STA_SpankUtil spanky = Game.GetFormFromFile(0x00000D62, "Spank That Ass.esp") As _STA_SpankUtil
    If spanky
        Return spanky.GetMasochismStage()
    EndIf
    
    Return 0 ; STA not installed, or Masochism data in a funny state.
    
EndFunction


; Add bulk spanks and update the pain buff/debuff
Function FixupSpanks(Int assSpanks, Int titSpanks) Global

    _STA_SpankUtil spanky = Game.GetFormFromFile(0x00000D62, "Spank That Ass.esp") As _STA_SpankUtil
    If spanky
        Return spanky.FixupSpanks(assSpanks, titSpanks)
    EndIf

EndFunction


Bool Function SetSpankEnable(Bool enable) Global

    _STA_SpankUtil spanky = Game.GetFormFromFile(0x00000D62, "Spank That Ass.esp") As _STA_SpankUtil
    If spanky
        Bool old = spanky.SexSpankToggle
        spanky.SexSpankToggle = enable
        Return old
    EndIf
    Return False
    
EndFunction


Bool Function CheckPatch() Global

    _STA_SpankUtil spanky = Game.GetFormFromFile(0x00000D62, "Spank That Ass.esp") As _STA_SpankUtil
    If !spanky
        Return False
    EndIf
    
    ; This won't CTD I hope...
    Bool ok =  spanky.CheckDfPatch()
    
    If ok
        ok = spanky.GetStaVersion() >= 3.5 ; Should be 3.7, but version value was never updated for 3.7
    EndIf
    
    Return ok
    
EndFunction

Float Function GetStaVersion() Global
    
    _STA_SpankUtil spanky = Game.GetFormFromFile(0x00000D62, "Spank That Ass.esp") As _STA_SpankUtil
    If !spanky
        Return -1.0
    EndIf
    
    Return spanky.GetStaVersion()

EndFunction    
