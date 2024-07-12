Scriptname _DF_SkoomaWhore

Form Function GetLeafSkooma() Global
    Return Game.GetFormFromFile(0x0001A05F, "SexLabSkoomaWhore.esp")
EndFunction

Form[] Function GetAddictiveSkoomas() Global

    String modName ="SexLabSkoomaWhore.esp"
    
    Form windhelmDoubleDistilledSkooma = Game.GetForm(0x0003F4BD)
    Form skooma                        = Game.GetForm(0x00057A7A)
    Form roseOfAzura       = Game.GetFormFromFile(0x00014980, modName)
    Form boethiasDeception = Game.GetFormFromFile(0x000169EA, modName)
    Form thiefsDelight     = Game.GetFormFromFile(0x000174BD, modName)
    Form theSecondBrain    = Game.GetFormFromFile(0x00017A2F, modName)
    Form elendrsFlask      = Game.GetFormFromFile(0x00017A3E, modName)
    Form theContortionist  = Game.GetFormFromFile(0x00017FB0, modName)
    Form morgulsTouch      = Game.GetFormFromFile(0x00018521, modName)
    Form toughFlesh        = Game.GetFormFromFile(0x00018A94, modName)
    Form occatosPallatine  = Game.GetFormFromFile(0x00019003, modName)
    Form magesFriend       = Game.GetFormFromFile(0x00019011, modName)
    Form theArchMage       = Game.GetFormFromFile(0x00019022, modName)
    Form verminasPrice     = Game.GetFormFromFile(0x00019AEA, modName)
    Form leafSkooma        = Game.GetFormFromFile(0x0001A05F, modName)

    ; Form herbTea           = Game.GetFormFromFile(0x0001A064, modName)
    ; Form purifyingSolution = Game.GetFormFromFile(0x0001A065, modName)
    
    Form[] skoomaList = new Form[15]
    
    skoomaList[ 0] = windhelmDoubleDistilledSkooma
    skoomaList[ 1] = skooma
    skoomaList[ 2] = roseOfAzura
    skoomaList[ 3] = boethiasDeception
    skoomaList[ 4] = thiefsDelight
    skoomaList[ 5] = theSecondBrain
    skoomaList[ 6] = elendrsFlask
    skoomaList[ 7] = theContortionist
    skoomaList[ 8] = morgulsTouch
    skoomaList[ 9] = toughFlesh
    skoomaList[10] = occatosPallatine
    skoomaList[11] = magesFriend
    skoomaList[12] = theArchMage
    skoomaList[13] = verminasPrice
    skoomaList[14] = leafSkooma
    
    return skoomaList
    
EndFunction

