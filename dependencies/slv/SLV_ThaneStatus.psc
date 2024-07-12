Scriptname SLV_ThaneStatus extends Quest  

Quest Property Favor250  Auto  
Quest Property FreeformRiftenThane  Auto  
Quest Property Favor252  Auto  
Quest Property Favor253  Auto  
Quest Property Favor254  Auto  
Quest Property Favor255  Auto  
Quest Property Favor256  Auto  
Quest Property Favor257  Auto  
Quest Property Favor258  Auto  

Quest Property FavorJarlsMakeFriends  Auto  

ReferenceAlias Property SLV_JarlDawnstar  Auto  
ReferenceAlias Property SLV_JarlFalkreath  Auto  
ReferenceAlias Property SLV_JarlMarkarth  Auto  
ReferenceAlias Property SLV_JarlMorthal  Auto  
ReferenceAlias Property SLV_JarlRiften  Auto  
ReferenceAlias Property SLV_JarlSolitude  Auto  
ReferenceAlias Property SLV_JarlWhiterun  Auto  
ReferenceAlias Property SLV_JarlWindhelm  Auto  
ReferenceAlias Property SLV_JarlWinterhold  Auto  



Function SLV_MakeThaneOfJarl(Actor Jarl)
	If Jarl == SLV_JarlDawnstar.GetActorRef()
		If favor256.GetStage() < 10
			favor256.SetStage(10)
		EndIf
		Utility.Wait(0.5)
		If ( FavorJarlsMakeFriends.GetStageDone(75) == False )
			FavorJarlsMakeFriends.SetStage(75)
		EndIf
	ElseIf Jarl == SLV_JarlFalkreath.GetActorRef()
		If favor258.GetStage() < 10
			favor258.SetStage(10)
		EndIf
		Utility.Wait(0.5)
		If ( FavorJarlsMakeFriends.GetStageDone(95) == False )
			FavorJarlsMakeFriends.SetStage(95)
		EndIf
	ElseIf Jarl == SLV_JarlMarkarth.GetActorRef()
		If favor250.GetStage() < 10
			favor250.SetStage(10)
		EndIf
		Utility.Wait(0.5)
		If ( FavorJarlsMakeFriends.GetStageDone(15) == False )
			FavorJarlsMakeFriends.SetStage(15)
		EndIf
	ElseIf Jarl == SLV_JarlMorthal.GetActorRef()
		If favor255.GetStage() < 10
			favor255.SetStage(10)
		EndIf
		Utility.Wait(0.5)
		If ( FavorJarlsMakeFriends.GetStageDone(65) == False )
			FavorJarlsMakeFriends.SetStage(65)
		EndIf
	ElseIf Jarl == SLV_JarlRiften.GetActorRef()
		;/ ########################### THIS NEEDS FIXING IF ENABLED. FreeformRiftenThane does not use the same quest logic as the others.
		If FreeformRiftenThane.GetStage() < 10
			FreeformRiftenThane.SetStage(10)
		EndIf
		Utility.Wait(0.5)
		If ( FavorJarlsMakeFriends.GetStageDone(25) == False )
			FavorJarlsMakeFriends.SetStage(25)
		EndIf
		/;
	ElseIf Jarl == SLV_JarlSolitude.GetActorRef()
		If favor252.GetStage() < 10
			favor252.SetStage(10)
		EndIf
		Utility.Wait(0.5)
		If ( FavorJarlsMakeFriends.GetStageDone(35) == False )
			FavorJarlsMakeFriends.SetStage(35)
		EndIf
	ElseIf Jarl == SLV_JarlWhiterun.GetActorRef()
		If favor253.GetStage() < 10
			favor253.SetStage(10)
		EndIf
		Utility.Wait(0.5)
		If ( FavorJarlsMakeFriends.GetStageDone(45) == False )
			FavorJarlsMakeFriends.SetStage(45)
		EndIf
	ElseIf Jarl == SLV_JarlWindhelm.GetActorRef()
		If favor254.GetStage() < 10
			favor254.SetStage(10)
		EndIf
		Utility.Wait(0.5)
		If ( FavorJarlsMakeFriends.GetStageDone(55) == False )
			FavorJarlsMakeFriends.SetStage(55)
		EndIf
	ElseIf Jarl == SLV_JarlWinterhold.GetActorRef()
		If favor257.GetStage() < 10
			favor257.SetStage(10)
		EndIf
		Utility.Wait(0.5)
		If ( FavorJarlsMakeFriends.GetStageDone(85) == False )
			FavorJarlsMakeFriends.SetStage(85)
		EndIf
	EndIf
EndFunction

Function SLV_MakeThaneOfDawnstar()
;If Jarl == SLV_JarlDawnstar.GetActorRef()
	If favor256.GetStage() < 10
		favor256.SetStage(10)
	EndIf
	Utility.Wait(0.5)
	If ( FavorJarlsMakeFriends.GetStageDone(75) == False )
		FavorJarlsMakeFriends.SetStage(75)
	EndIf
EndFunction

Function SLV_MakeThaneOfFalkreath()
;If Jarl == SLV_JarlFalkreath.GetActorRef()
	If favor258.GetStage() < 10
		favor258.SetStage(10)
	EndIf
	Utility.Wait(0.5)
	If ( FavorJarlsMakeFriends.GetStageDone(95) == False )
		FavorJarlsMakeFriends.SetStage(95)
	EndIf
EndFunction

Function SLV_MakeThaneOfMarkarth()
;If Jarl == SLV_JarlMarkarth.GetActorRef()
	If favor250.GetStage() < 10
		favor250.SetStage(10)
	EndIf
	Utility.Wait(0.5)
	If ( FavorJarlsMakeFriends.GetStageDone(15) == False )
		FavorJarlsMakeFriends.SetStage(15)
	EndIf
EndFunction

Function SLV_MakeThaneOfMorthal()
;If Jarl == SLV_JarlMorthal.GetActorRef()
	If favor255.GetStage() < 10
		favor255.SetStage(10)
	EndIf
	Utility.Wait(0.5)
	If ( FavorJarlsMakeFriends.GetStageDone(65) == False )
		FavorJarlsMakeFriends.SetStage(65)
	EndIf
EndFunction

Function SLV_MakeThaneOfRiften()
;If Jarl == SLV_JarlRiften.GetActorRef()
	;/ ########################### THIS NEEDS FIXING IF ENABLED. FreeformRiftenThane does not use the same quest logic as the others.
	If FreeformRiftenThane.GetStage() < 10
		FreeformRiftenThane.SetStage(10)
	EndIf
	Utility.Wait(0.5)
	If ( FavorJarlsMakeFriends.GetStageDone(25) == False )
		FavorJarlsMakeFriends.SetStage(25)
	EndIf
	/;
EndFunction

Function SLV_MakeThaneOfSolitude()
;If Jarl == SLV_JarlSolitude.GetActorRef()
	If favor252.GetStage() < 10
		favor252.SetStage(10)
	EndIf
	Utility.Wait(0.5)
	If ( FavorJarlsMakeFriends.GetStageDone(35) == False )
		FavorJarlsMakeFriends.SetStage(35)
	EndIf
EndFunction

Function SLV_MakeThaneOfWhiterun()
;If Jarl == SLV_JarlWhiterun.GetActorRef()
	If favor253.GetStage() < 10
		favor253.SetStage(10)
	EndIf
	Utility.Wait(0.5)
	If ( FavorJarlsMakeFriends.GetStageDone(45) == False )
		FavorJarlsMakeFriends.SetStage(45)
	EndIf
EndFunction

Function SLV_MakeThaneOfWindhelm()
;If Jarl == SLV_JarlWindhelm.GetActorRef()
	If favor254.GetStage() < 10
		favor254.SetStage(10)
	EndIf
	Utility.Wait(0.5)
	If ( FavorJarlsMakeFriends.GetStageDone(55) == False )
		FavorJarlsMakeFriends.SetStage(55)
	EndIf
EndFunction

Function SLV_MakeThaneOfWinterhold()
;If Jarl == SLV_JarlWinterhold.GetActorRef()
	If favor257.GetStage() < 10
		favor257.SetStage(10)
	EndIf
	Utility.Wait(0.5)
	If ( FavorJarlsMakeFriends.GetStageDone(85) == False )
		FavorJarlsMakeFriends.SetStage(85)
	EndIf
;EndIf

EndFunction


