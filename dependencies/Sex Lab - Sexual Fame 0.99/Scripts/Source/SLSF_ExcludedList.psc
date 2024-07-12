Scriptname SLSF_ExcludedList extends Quest  

SLSF_Configuration Property Config Auto

Form[] ListOfActualWearSuitable
Actor Property PlayerRef Auto

Function OpenAddHubList()
	UIListMenu ListOfAddHub = UIExtensions.GetMenu("UIListMenu", True) as UIListMenu
	ListOfAddHub.AddEntryItem("$SLSF_CLOTHING")
	ListOfAddHub.AddEntryItem("$SLSF_EXCLUSIONTATS")
	ListOfAddHub.AddEntryItem("$SLSF_NONE")
	
	ListOfAddHub.OpenMenu()
	Int Selected = ListOfAddHub.GetResultInt()
	
	If Selected == 0
		OpenAddList()
	ElseIf Selected == 1
		If Config.SlaveTatsLoaded
			OpenExcludeSlaveTatsList(Config.ExcludedSlaveTats)
		Else
			Debug.Notification("$SLSF_SAVETATSNOTFOUND")
		EndIf
	EndIf
EndFunction

Function OpenAddList()
	RegenList()
	Int Num = 0
	Int Max = ListOfActualWearSuitable.Length
	String Name
	Form Item
	
	UIListMenu ListOfPossibleExclusion = UIExtensions.GetMenu("UIListMenu", True) as UIListMenu
	
	While Num < Max
		Item = ListOfActualWearSuitable[Num]
		If Item != None
			Name = Item.GetName()
			If Name == ""
				If Config.DeviousDevicesIntegrationLoaded
					If Item.HasKeyword(Config.DDSuit)
						Name = "DD Body Suit"
					EndIf
				EndIf
				
				If Name == ""
					Name = "Unnamed Reference "+Item
				EndIf
			EndIf
			ListOfPossibleExclusion.AddEntryItem(Name)
		EndIf
		Num += 1
	EndWhile
	ListOfPossibleExclusion.AddEntryItem("$SLSF_NONE")
	Int Last = ListOfPossibleExclusion.GetPropertyInt("currentIndex") - 1
	
	ListOfPossibleExclusion.OpenMenu()
	Int Selected = ListOfPossibleExclusion.GetResultInt()
	
	If Selected >= 0 && Selected < Last
		If ListOfActualWearSuitable[Selected] != None
			TryToAdd(ListOfActualWearSuitable[Selected] as Form)
		EndIf
	EndIf
EndFunction

Function OpenRemoveListHub()
	UIListMenu ListOfExclusionHub = UIExtensions.GetMenu("UIListMenu", True) as UIListMenu
	ListOfExclusionHub.AddEntryItem("$SLSF_EXCLUSIONFEET")
	ListOfExclusionHub.AddEntryItem("$SLSF_EXCLUSIONHAND")
	ListOfExclusionHub.AddEntryItem("$SLSF_EXCLUSIONHEAD")
	ListOfExclusionHub.AddEntryItem("$SLSF_EXCLUSIONBODY")
	If Config.SlaveTatsLoaded
		ListOfExclusionHub.AddEntryItem("$SLSF_EXCLUSIONTATS")
	EndIf
	
	ListOfExclusionHub.OpenMenu()
	Int Selected = ListOfExclusionHub.GetResultInt()
	
	If Selected == 0
		OpenRemoveList(Config.ExcludedFeet)
	ElseIf Selected == 1
		OpenRemoveList(Config.ExcludedHand)
	ElseIf Selected == 2
		OpenRemoveList(Config.ExcludedHead)
	ElseIf Selected == 3
		OpenRemoveList(Config.ExcludedBody)
	ElseIf Selected == 4
		RemoveSlaveTatsExclusion(Config.ExcludedSlaveTats)
	EndIf
EndFunction

Function OpenRemoveList(Form[] which)
	Int Num = which.Length
	String Name
	Form Item
	
	UIListMenu ListOfExclusion = UIExtensions.GetMenu("UIListMenu", True) as UIListMenu
	
	While Num > 0
		Num -= 1
		Item = which[Num]
		If Item != None
			Name = Item.GetName()
			If Name == ""
				If Config.DeviousDevicesIntegrationLoaded
					If Item.HasKeyword(Config.DDSuit)
						Name = "DD Body Suit"
					EndIf
				EndIf
				
				If Name == ""
					Name = "Unnamed Reference "+Item
				EndIf
			EndIf
			ListOfExclusion.AddEntryItem(Name)
		EndIf
		
	EndWhile
	ListOfExclusion.AddEntryItem("$SLSF_EMPTY")
	Int Last = ListOfExclusion.GetPropertyInt("currentIndex") - 1
	
	ListOfExclusion.OpenMenu()
	Int Selected = ListOfExclusion.GetResultInt()
	
	If Selected >= 0 && Selected < Last 
		which[selected] = None
		Debug.Notification("$SLSF_ITEMREMOVEDFROMEXCLUDED")
	EndIf
EndFunction

Function OpenExcludeSlaveTatsList(String[] which)
	UIListMenu ListOfExclusion = UIExtensions.GetMenu("UIListMenu", True) as UIListMenu
	Int Num
	
	While Num < which.Length
		If which[Num] != ""
			ListOfExclusion.AddEntryItem(which[Num])
		Else
			ListOfExclusion.AddEntryItem("$SLSF_NONE")
		EndIf
		Num += 1
	EndWhile
	
	ListOfExclusion.OpenMenu()
	Int Selected = ListOfExclusion.GetResultInt()
	
	If Selected >= 0 && Selected < 10
		String Result
		UITextEntryMenu TextEntry = UIExtensions.GetMenu("UITextEntryMenu", True) as UITextEntryMenu
		TextEntry.SetPropertyString("text", Config.ExcludedSlaveTats[Selected])
		TextEntry.OpenMenu()
		Result = TextEntry.GetResultString()
		
		Debug.Notification("Imput Value got: "+Result)
		Config.ExcludedSlaveTats[Selected] = Result
	EndIf
EndFunction

Function RemoveSlaveTatsExclusion(String[] which)
	UIListMenu ListOfExclusion = UIExtensions.GetMenu("UIListMenu", True) as UIListMenu
	Int Num
	
	While Num < which.Length
		If which[Num] != ""
			ListOfExclusion.AddEntryItem(which[Num])
		Else
			ListOfExclusion.AddEntryItem("$SLSF_NONE")
		EndIf
		Num += 1
	EndWhile
	
	ListOfExclusion.OpenMenu()
	Int Selected = ListOfExclusion.GetResultInt()
	
	If Selected >= 0 && Selected < 10
		Config.ExcludedSlaveTats[Selected] = None
	EndIf
EndFunction

Function RegenList()
	ListOfActualWearSuitable = New Form[10]
	Int Index
	Int SlotsChecked
	Bool Adding
	
	Int ThisSlot = 0x01
	While (ThisSlot < 0x80000000)
		If (Math.LogicalAnd(SlotsChecked, ThisSlot) != ThisSlot) ;only check slots we haven't found anything equipped on already
			If PlayerRef.GetWornForm(ThisSlot)
				Form Equipped = PlayerRef.GetWornForm(ThisSlot)
				
				If  ListOfActualWearSuitable.Find(Equipped) == -1
					;Feet
					If Equipped.HasKeyword(Config.ClothingKeyword[0]) || Equipped.HasKeyword(Config.ClothingKeyword[1])
						If Config.ExcludedFeet.Find(Equipped) == -1
							Adding = True
						EndIf
					ElseIf Equipped.HasKeyword(Config.ClothingKeyword[2]) || Equipped.HasKeyword(Config.ClothingKeyword[3])
						If Config.ExcludedHand.Find(Equipped) == -1
							Adding = True
						EndIf
					ElseIf Equipped.HasKeyword(Config.ClothingKeyword[4]) || Equipped.HasKeyword(Config.ClothingKeyword[5])
						If Config.ExcludedHead.Find(Equipped) == -1
							Adding = True
						EndIf
					Else
							;Body
						If Config.DeviousDevicesIntegrationLoaded
							If Equipped.HasKeyword(Config.DDSuit)
								If Config.ExcludedBody.Find(Equipped) == -1
									Adding = True
								EndIf
							EndIf
						EndIf
						
						If (Equipped.HasKeyword(Config.ClothingKeyword[6]) || Equipped.HasKeyword(Config.ClothingKeyword[7])) && !Adding
							If Config.ExcludedBody.Find(Equipped) == -1
								Adding = True
							EndIf
						EndIf
					EndIf
					
					If Adding
						If Index < 10
							ListOfActualWearSuitable[Index] = Equipped
							Index += 1
						EndIf
						Adding = False
					EndIf
				EndIf
			EndIf
		EndIf
		ThisSlot *= 2 ;double the number to move on to the next slot
	EndWhile
EndFunction

Function TryToAdd(Form Item)
	Int Where = -1
	Bool NotAdd
	Bool BodyAdd
	
	If Item.HasKeyword(Config.ClothingKeyword[0]) || Item.HasKeyword(Config.ClothingKeyword[1])
		Where = Config.ExcludedFeet.Find(None)
		If Where != -1
			Config.ExcludedFeet[Where] = Item
		Else
			NotAdd = True
		EndIf
	ElseIf Item.HasKeyword(Config.ClothingKeyword[2]) || Item.HasKeyword(Config.ClothingKeyword[3])
		Where = Config.ExcludedHand.Find(None)
		If Where != -1
			Config.ExcludedHand[Where] = Item
		Else
			NotAdd = True
		EndIf
	ElseIf Item.HasKeyword(Config.ClothingKeyword[4]) || Item.HasKeyword(Config.ClothingKeyword[5])
		Where = Config.ExcludedHead.Find(None)
		If Where != -1
			Config.ExcludedHead[Where] = Item
		Else
			NotAdd = True
		EndIf
	Else
			;Body
		If Config.DeviousDevicesIntegrationLoaded
			If Item.HasKeyword(Config.DDSuit)
				BodyAdd = True
			EndIf
		EndIf
		
		If (Item.HasKeyword(Config.ClothingKeyword[6]) || Item.HasKeyword(Config.ClothingKeyword[7]))
			BodyAdd = True
		EndIf
		
		If BodyAdd
			Where = Config.ExcludedBody.Find(None)
			If Where != -1
				Config.ExcludedBody[Where] = Item
			Else
				NotAdd = True
			EndIf
		Else
			NotAdd = True
		EndIf
	EndIf
	
	If NotAdd
		Debug.Notification("$SLSF_WARN_ITEMEXCLUDEDENIED")
	Else
		Debug.Notification("$SLSF_WARN_ITEMEXCLUDEACCEPTED")
	EndIf
EndFunction