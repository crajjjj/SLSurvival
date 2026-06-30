ScriptName sr_HentairimUtils hidden

string Function GetLabel(sslBaseAnimation anim , int stage , String actorpos = "0" ) Global

string ActorPosition = ""
	
	if ActorPos == 0
		ActorPosition = "A"
	elseif ActorPos == 1
		ActorPosition = "B"
	elseif ActorPos == 2
		ActorPosition = "C"
	elseif ActorPos == 3
		ActorPosition = "D"
	elseif ActorPos == 4
		ActorPosition = "E"
	endif


	if anim.HasTag(stage+"LI") || anim.HasTag(stage+ActorPosition+"LDI")
		return "LI"
	elseif anim.HasTag(stage+"FA") || anim.HasTag(stage+ActorPosition+"FAP")
		return "FA"
	elseif anim.HasTag(stage+"SA") || anim.HasTag(stage+ActorPosition+"SAP")
		return "SA"
	elseif anim.HasTag(stage+"BA") 
		return "BA"
	elseif anim.HasTag(stage+"BV")
		return "BV"
	elseif anim.HasTag(stage+"FV") || anim.HasTag(stage+ActorPosition+"FVP")
		return "FV"	
	elseif anim.HasTag(stage+"SV") || anim.HasTag(stage+ActorPosition+"SVP")
		return "SV"	
	elseif anim.HasTag(stage+"DP") || anim.HasTag(stage+ActorPosition+"SDP") || anim.HasTag(stage+ActorPosition+"FDP")
		return "DP"
	elseif anim.HasTag(stage+"FB") || anim.HasTag(stage+ActorPosition+"FBJ")
		return "FB"	
	elseif anim.HasTag(stage+"SB") || anim.HasTag(stage+ActorPosition+"SBJ")
		return "SB"	
	elseif anim.HasTag(stage+"EN") || anim.HasTag(stage+ActorPosition+"ENO") || anim.HasTag(stage+ActorPosition+"ENI")
		return "EN"
	elseif anim.HasTag(stage+"TP") || ((anim.HasTag(stage+ActorPosition+"SDP") || anim.HasTag(stage+ActorPosition+"FDP")) && (anim.HasTag(stage+ActorPosition+"SBJ") || anim.HasTag(stage+ActorPosition+"FBJ")))
		return "TP"
	elseif anim.HasTag(stage+"SR") || (anim.HasTag(stage+ActorPosition+"SVP") && anim.HasTag(stage+ActorPosition+"SBJ")) || (anim.HasTag(stage+ActorPosition+"FVP") && anim.HasTag(stage+ActorPosition+"FBJ")) || (anim.HasTag(stage+ActorPosition+"FAP") && anim.HasTag(stage+ActorPosition+"FBJ"))  || (anim.HasTag(stage+ActorPosition+"SAP") && anim.HasTag(stage+ActorPosition+"SBJ"))   
		return "SR"
	else
		return "LI" ;default lead in if no stimulating actions
	endif

endfunction

string Function StimulationLabel(sslBaseAnimation anim , int stage , Int ActorPos) Global

		string ActorPosition = ""
	
	if ActorPos == 0
		ActorPosition = "A"
	elseif ActorPos == 1
		ActorPosition = "B"
	elseif ActorPos == 2
		ActorPosition = "C"
	elseif ActorPos == 3
		ActorPosition = "D"
	elseif ActorPos == 4
		ActorPosition = "E"
	endif
	
	if anim.HasTag(stage+ActorPosition + "SST")
		return "SST"	
	elseif anim.HasTag(stage+ActorPosition + "FST")
		returN "FST"	
	elseif anim.HasTag(stage+ActorPosition + "BST")
		return "BST"	
	else
		return "LDI" ;default lead in if no stimulating actions
	endif

endfunction

string Function PenetrationLabel(sslBaseAnimation anim , int stage , Int ActorPos) Global

	string ActorPosition = ""
	
	if ActorPos == 0
		ActorPosition = "A"
	elseif ActorPos == 1
		ActorPosition = "B"
	elseif ActorPos == 2
		ActorPosition = "C"
	elseif ActorPos == 3
		ActorPosition = "D"
	elseif ActorPos == 4
		ActorPosition = "E"
	endif
	
	if anim.HasTag(stage+ ActorPosition + "SVP")
		return "SVP"
	elseif anim.HasTag(stage+ActorPosition + "SAP")
		return "SAP"
	elseif anim.HasTag(stage+ActorPosition + "FVP")
		return "FVP"
	elseif anim.HasTag(stage+ActorPosition + "FAP")
		return "FAP"
	elseif anim.HasTag(stage+ActorPosition + "SCG")
		return "SCG"
	elseif anim.HasTag(stage+ActorPosition + "FCG")
		return "FCG"
	elseif anim.HasTag(stage+ActorPosition + "SAC")
		return "SAC"
	elseif anim.HasTag(stage+ActorPosition + "FAC")
		return "FAC"
	elseif anim.HasTag(stage+ActorPosition + "SDP")
		return "SDP"
	elseif anim.HasTag(stage+ActorPosition + "FDP")
		return "SDP"
	else
		return "LDI" ;Default lead in if no stimulating actions
	endif
endfunction

string Function PenisActionLabel(sslBaseAnimation anim , int stage , Int ActorPos) Global
	
	string ActorPosition = ""
	
	if ActorPos == 0
		ActorPosition = "A"
	elseif ActorPos == 1
		ActorPosition = "B"
	elseif ActorPos == 2
		ActorPosition = "C"
	elseif ActorPos == 3
		ActorPosition = "D"
	elseif ActorPos == 4
		ActorPosition = "E"
	endif
	
	if anim.HasTag(stage+ActorPosition + "SDV")
		return "SDV"
	elseif anim.HasTag(stage+ActorPosition + "FDV")
		return "FDV"	
	elseif anim.HasTag(stage+ActorPosition + "SDA")
		retuRN "SDA"
	elseif anim.HasTag(stage+ActorPosition + "FDA")
		return "FDA"
	elseif anim.HasTag(stage+ActorPosition + "SHJ")
		reTURN "SHJ"
	elseif anim.HasTag(stage+ActorPosition + "FHJ")
		return "FHJ"
	elseif anim.HasTag(stage+ActorPosition + "STF")
		reTURN "STF"
	elseif anim.HasTag(stage+ActorPosition + "FTF")
		return "FTF"
	elseif anim.HasTag(stage+ActorPosition + "SMF")
		RETURN "SMF"
	elseif anim.HasTag(stage+ActorPosition + "FMF")
		return "FMF"
	elseif anim.HasTag(stage+ActorPosition + "SFJ")
		reTURN "SFJ"
	elseif anim.HasTag(stage+ActorPosition + "SFJ")
		returN "FFJ"
	else
		reTURN "LDI" ;default lead in if no stimulating actions
	endif
endfunction


String Function OralLabel(sslBaseAnimation anim , int stage , Int ActorPos) Global
	
	string ActorPosition = ""
	
	if ActorPos == 0
		ActorPosition = "A"
	elseif ActorPos == 1
		ActorPosition = "B"
	elseif ActorPos == 2
		ActorPosition = "C"
	elseif ActorPos == 3
		ActorPosition = "D"
	elseif ActorPos == 4
		ActorPosition = "E"
	endif
	
	if anim.HasTag(stage+ ActorPosition + "KIS")
		return "KIS"
	elseif anim.HasTag(stage+ ActorPosition + "CUN")
		return "CUN"
	elseif anim.HasTag(stage+ ActorPosition + "FBJ")
		return "FBJ"
	elseif anim.HasTag(stage+ ActorPosition + "SBJ")
		returN "SBJ"
	else
		reTURN "LDI"
	endif

endfunction

String Function EndingLabel(sslBaseAnimation anim , int stage , Int ActorPos) Global
	;Labels that identify actions on partners
	
	string ActorPosition = ""
	
	if ActorPos == 0
		ActorPosition = "A"
	elseif ActorPos == 1
		ActorPosition = "B"
	elseif ActorPos == 2
		ActorPosition = "C"
	elseif ActorPos == 3
		ActorPosition = "D"
	elseif ActorPos == 4
		ActorPosition = "E"
	endif
	
	if anim.HasTag(stage+ ActorPosition + "ENO")
		return "ENO"
	elseif anim.HasTag(stage+ ActorPosition + "ENI")
		return "ENI"
	else
		Return "LDI"
	endif

endfunction

string Function GetSFX(sslBaseAnimation anim , int stage) Global
if anim.HasTag(stage+"SC")
		return "SC"
	elseif anim.HasTag(stage+"MC")
		return "MC"
	elseif anim.HasTag(stage+"FC")
		return "FC"
	elseif anim.HasTag(stage+"SS")
		return "SS"	
	elseif anim.HasTag(stage+"MS")
		return "MS"
	elseif anim.HasTag(stage+"FS")
		return "FS"	
	elseif anim.HasTag(stage+"RS")
		return "RS"	
	elseif anim.HasTag(stage+"NA")
		return "NA"
	endif

endfunction

Bool Function isAnimationHentairimTagged (sslBaseAnimation animation , int stage , Int pos) Global
    if pos < 0
        return false
    endif
    String EMPTYTAG = "LDI"
    String penetrationLabel = sr_HentairimUtils.PenetrationLabel(animation, stage, pos)
    String oralLabel = sr_HentairimUtils.OralLabel(animation, stage, pos)
    String stimulationLabel = sr_HentairimUtils.StimulationLabel(animation, stage, pos)
    String endingLabel = sr_HentairimUtils.EndingLabel(animation, stage, pos)
    String penisActionLabel = sr_HentairimUtils.PenisActionLabel(animation, stage, pos)
    Bool stageTagsFound = (stimulationLabel != EMPTYTAG || penetrationLabel != EMPTYTAG || oralLabel != EMPTYTAG || endingLabel != EMPTYTAG || penisActionLabel != EMPTYTAG )
    return stageTagsFound
EndFunction

Bool Function isAnimationHentairimTaggedStrings ( String penetrationLabel, String oralLabel, String stimulationLabel, String endingLabel, String penisActionLabel ) Global
    String EMPTYTAG = "LDI"
    Bool stageTagsFound = (stimulationLabel != EMPTYTAG || penetrationLabel != EMPTYTAG || oralLabel != EMPTYTAG || endingLabel!= EMPTYTAG || penisActionLabel!= EMPTYTAG)
    return stageTagsFound
EndFunction

Bool Function IsGettingVaginallyPenetrated(String PenetrationLabel) Global
	return  PenetrationLabel == "FVP" || PenetrationLabel == "FCG" || PenetrationLabel == "SVP" || PenetrationLabel == "SCG"
endfunction
Bool Function IsGettingStimulated(String stimulationLabel) Global
	return  stimulationLabel == "SST" || stimulationLabel == "FST" 
endfunction
Bool Function IsGettingDoublePenetrated(String PenetrationLabel) Global
    return PenetrationLabel == "FDP" || PenetrationLabel == "SDP"
endfunction
Bool Function IsGettingAnallyPenetrated(String PenetrationLabel) Global
	return PenetrationLabel == "SAP" || PenetrationLabel == "SAC" || PenetrationLabel == "FAP"  || PenetrationLabel == "FAC"
endfunction
Bool Function IsGettingInsertedBig(String hentailabel) Global
	return hentailabel == "BST"
endfunction
Bool Function IsSuckingoffOther(String OralLabel) Global
	return OralLabel == "SBJ" ||  OralLabel == "FBJ"
endfunction

Bool Function IsGivingAnalPenetration(String PenisActionLabel) Global
	return PenisActionLabel == "FDA" || PenisActionLabel == "SDA"
endfunction

Bool Function IsGivingVaginalPenetration(String PenisActionLabel) Global
	return PenisActionLabel =="FDV" || PenisActionLabel == "SDV"
endfunction

Bool Function IsGettingSuckedoff(String PenisActionLabel) Global
	return PenisActionLabel == "SMF" ||  PenisActionLabel == "FMF"	
endfunction

;SDV - Giving Soft/Slow Vaginal Penetration
;FDV - Giving Fast/Intense Vaginal Penetration
;SDA - Giving Soft/Slow Anal Penetration
;FDA - Giving Fast/Intense Anal Penetration
;SHJ - Getting Soft/Slow Handjob
;FHJ - Getting Fast/Intense Handjob
;STF - Getting Soft/Slow Titfuck
;FTF - Getting Fast/Intense Titfuck
;SMF - Getting Soft/Slow blowjob
;FMF - Getting Fast/Intense blowjob
;;SFJ - Getting Soft/Slow footjob
;FFJ - Getting Fast/Intense footjob

Bool Function IsCummedInside(String endingLabel) Global
	return endingLabel == "ENI" || endingLabel == "ENO"
endfunction

String Function Substring(String source, Int startIndex, Int len) Global
    If len == 0
        Return ""
    Else
        Return StringUtil.Substring(source, startIndex, len)
    EndIf
EndFunction

String Function GetStageTagsAsString(SslBaseAnimation animation,int stage) Global
    String[] tags = animation.GetTags()
    String result = ""
    Int i = 0
    While i < tags.Length
        If tags[i] && substring(tags[i],0,1) == ("" + stage)
            result = result + tags[i]
            If i < tags.Length - 1
                result = result + ","
            EndIf
        EndIf
        i=i+1
    EndWhile
    Return result
EndFunction

Bool Function isIntense(String hentailabel) Global
    if Substring(hentailabel,0,1) == "F"
      return true
    endif
    return false
endfunction

int Function GetActorPositionFromList(Actor[] actorList, Actor act) Global
    Int i = 0
    While i < actorList.Length
        Actor cur = actorList[i]
        If cur == act
            Return i
        EndIf
        i += 1
    EndWhile
    Return -1
EndFunction