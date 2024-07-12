;/ Decompiled by Champollion V1.0.1
Source   : CommonArrayHelper.psc
Modified : 2016-11-16 21:47:51
Compiled : 2016-11-16 21:48:32
User     : David Pierce
Computer : CHESKO-PC
/;
scriptName CommonArrayHelper hidden
{Global array helper functions.}

;-- Properties --------------------------------------

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

Bool function ArrayAddArmor(Armor[] akArray, Armor akValue) global

	Int i = 0
	while i < akArray.length
		if CommonArrayHelper.IsNone(akArray[i] as Form)
			akArray[i] = akValue
			return true
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

Bool function LinkedArrayRemoveArmor(Armor akArmor, Armor[] akArray1, Armor[] akArray2, Armor[] akArray3, Armor[] akArray4, Bool abSort = false) global

	Int idx = -1
	idx = akArray1.find(akArmor, 0)
	if idx != -1
		akArray1[idx] = none
		if abSort
			CommonArrayHelper.LinkedArraySortArmors(akArray1, akArray2, akArray3, akArray4, 0)
		endIf
		return true
	endIf
	idx = -1
	idx = akArray2.find(akArmor, 0)
	if idx != -1
		akArray2[idx] = none
		if abSort
			CommonArrayHelper.LinkedArraySortArmors(akArray1, akArray2, akArray3, akArray4, 0)
		endIf
		return true
	endIf
	idx = -1
	idx = akArray3.find(akArmor, 0)
	if idx != -1
		akArray3[idx] = none
		if abSort
			CommonArrayHelper.LinkedArraySortArmors(akArray1, akArray2, akArray3, akArray4, 0)
		endIf
		return true
	endIf
	idx = -1
	idx = akArray4.find(akArmor, 0)
	if idx != -1
		akArray4[idx] = none
		if abSort
			CommonArrayHelper.LinkedArraySortArmors(akArray1, akArray2, akArray3, akArray4, 0)
		endIf
		return true
	endIf
	return false
endFunction

Bool function ArrayAddRef(ObjectReference[] akArray, ObjectReference akValue) global

	Int index = akArray.find(none, 0)
	if index >= 0
		akArray[index] = akValue
		return true
	else
		return false
	endIf
endFunction

Bool function IsNone(Form akForm) global

	Int i = 0
	if akForm
		i = akForm.GetFormID()
		if i == 0
			return true
		else
			return false
		endIf
	else
		return true
	endIf
endFunction

Bool function ArrayAddFloat(Float[] afArray, Float afValue, Float afInsertAtValue) global

	Int i = 0
	while i < afArray.length
		if afArray[i] == afInsertAtValue
			afArray[i] = afValue
			return true
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

Bool function ArrayAddAlias(Alias[] akArray, Alias akValue) global

	Int i = 0
	while i < akArray.length
		if akArray[i] == none
			akArray[i] = akValue
			return true
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

Int function ArrayCountActivator(Activator[] akArray) global

	Int i = 0
	Int myCount = 0
	while i < akArray.length
		if !CommonArrayHelper.IsNone(akArray[i] as Form)
			myCount += 1
			i += 1
		else
			i += 1
		endIf
	endWhile
	return myCount
endFunction

Bool function ArrayRemoveArmor(Armor[] akArray, Armor akValue, Bool abSort = false) global

	Int i = 0
	while i < akArray.length
		if akArray[i] == akValue
			akArray[i] = none
			if abSort == true
				CommonArrayHelper.ArraySortArmor(akArray, 0)
			endIf
			return true
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

Bool function LinkedArrayAddArmor(Armor akArmor, Armor[] akArray1, Armor[] akArray2, Armor[] akArray3, Armor[] akArray4, Bool abTryInvalidRemoval = false) global

	Int idx = -1
	idx = akArray1.find(none, 0)
	if idx != -1
		akArray1[idx] = akArmor
		return true
	endIf
	idx = -1
	idx = akArray2.find(none, 0)
	if idx != -1
		akArray2[idx] = akArmor
		return true
	endIf
	idx = -1
	idx = akArray3.find(none, 0)
	if idx != -1
		akArray3[idx] = akArmor
		return true
	endIf
	idx = -1
	idx = akArray4.find(none, 0)
	if idx != -1
		akArray4[idx] = akArmor
		return true
	endIf
	if abTryInvalidRemoval
		Bool foundInvalidArmors = CommonArrayHelper.LinkedArrayRemoveInvalidArmors(akArray1, akArray2, akArray3, akArray4)
		if foundInvalidArmors
			return CommonArrayHelper.LinkedArrayAddArmor(akArmor, akArray1, akArray2, akArray3, akArray4, true)
		else
			return false
		endIf
	else
		return false
	endIf
endFunction

Int function GetVersion() global

	return 2
endFunction

Bool function ArrayAddForm(Form[] akArray, Form akValue) global

	Int i = 0
	while i < akArray.length
		if CommonArrayHelper.IsNone(akArray[i])
			akArray[i] = akValue
			return true
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

Int function ArrayCountRef(ObjectReference[] akArray) global

	Int i = 0
	Int myCount = 0
	while i < akArray.length
		if akArray[i] != none
			myCount += 1
			i += 1
		else
			i += 1
		endIf
	endWhile
	return myCount
endFunction

Bool function ArraySortMessage(Message[] akArray, Int i = 0) global

	Bool bFirstNoneFound = false
	Int iFirstNonePos = i
	while i < akArray.length
		if CommonArrayHelper.IsNone(akArray[i] as Form)
			akArray[i] = none
			if bFirstNoneFound == false
				bFirstNoneFound = true
				iFirstNonePos = i
				i += 1
			else
				i += 1
			endIf
		elseIf bFirstNoneFound == true
			if !CommonArrayHelper.IsNone(akArray[i] as Form)
				akArray[iFirstNonePos] = akArray[i]
				akArray[i] = none
				CommonArrayHelper.ArraySortMessage(akArray, iFirstNonePos + 1)
				return true
			else
				i += 1
			endIf
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

function LinkedArrayClearArmors128(Armor[] akArray1, Armor[] akArray2, Armor[] akArray3, Armor[] akArray4) global

	akArray1 = new Armor[128]
	akArray2 = new Armor[128]
	akArray3 = new Armor[128]
	akArray4 = new Armor[128]
endFunction

Int function ArrayCountArmor(Armor[] akArray) global

	Int i = 0
	Int myCount = 0
	while i < akArray.length
		if !CommonArrayHelper.IsNone(akArray[i] as Form)
			myCount += 1
			i += 1
		else
			i += 1
		endIf
	endWhile
	return myCount
endFunction

Bool function ArrayAddBool(Bool[] abArray, Bool abValue, Int aiIndex) global

	if aiIndex < abArray.length
		abArray[aiIndex] = abValue
		return true
	else
		return false
	endIf
endFunction

Bool function ArraySortForm(Form[] akArray, Int i = 0) global

	Bool bFirstNoneFound = false
	Int iFirstNonePos = i
	while i < akArray.length
		if CommonArrayHelper.IsNone(akArray[i])
			akArray[i] = none
			if bFirstNoneFound == false
				bFirstNoneFound = true
				iFirstNonePos = i
				i += 1
			else
				i += 1
			endIf
		elseIf bFirstNoneFound == true
			if !CommonArrayHelper.IsNone(akArray[i])
				akArray[iFirstNonePos] = akArray[i]
				akArray[i] = none
				CommonArrayHelper.ArraySortForm(akArray, iFirstNonePos + 1)
				return true
			else
				i += 1
			endIf
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

Bool function ArraySortArmor(Armor[] akArray, Int i = 0) global

	Bool bFirstNoneFound = false
	Int iFirstNonePos = i
	while i < akArray.length
		if CommonArrayHelper.IsNone(akArray[i] as Form)
			akArray[i] = none
			if bFirstNoneFound == false
				bFirstNoneFound = true
				iFirstNonePos = i
				i += 1
			else
				i += 1
			endIf
		elseIf bFirstNoneFound == true
			if !CommonArrayHelper.IsNone(akArray[i] as Form)
				akArray[iFirstNonePos] = akArray[i]
				akArray[i] = none
				CommonArrayHelper.ArraySortArmor(akArray, iFirstNonePos + 1)
				return true
			else
				i += 1
			endIf
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

Bool function LinkedArraySortArmors(Armor[] akArray1, Armor[] akArray2, Armor[] akArray3, Armor[] akArray4, Int i) global

	Bool firstNoneFound = false
	Int firstNoneFoundArrayId = 0
	Int firstNoneIndex = 0
	while i < 512
		Int myCurrArray
		Int j = 0
		if i < 128
			myCurrArray = 1
			j = i
		elseIf i < 256 && i >= 128
			j = i - 128
			myCurrArray = 2
		elseIf i < 384 && i >= 256
			j = i - 256
			myCurrArray = 3
		elseIf i < 512 && i >= 384
			j = i - 384
			myCurrArray = 4
		endIf
		if myCurrArray == 1
			if akArray1[j] == none
				if firstNoneFound == false
					firstNoneFound = true
					firstNoneFoundArrayId = myCurrArray
					firstNoneIndex = j
					i += 1
				else
					i += 1
				endIf
			elseIf firstNoneFound == true
				if akArray1[j] != none
					if firstNoneFoundArrayId == 1
						akArray1[firstNoneIndex] = akArray1[j]
						akArray1[j] = none
					elseIf firstNoneFoundArrayId == 2
						akArray2[firstNoneIndex] = akArray1[j]
						akArray1[j] = none
					elseIf firstNoneFoundArrayId == 3
						akArray3[firstNoneIndex] = akArray1[j]
						akArray1[j] = none
					elseIf firstNoneFoundArrayId == 4
						akArray4[firstNoneIndex] = akArray1[j]
						akArray1[j] = none
					endIf
					CommonArrayHelper.LinkedArraySortArmors(akArray1, akArray2, akArray3, akArray4, firstNoneIndex + 1)
					return true
				else
					i += 1
				endIf
			else
				i += 1
			endIf
		elseIf myCurrArray == 2
			if akArray2[j] == none
				if firstNoneFound == false
					firstNoneFound = true
					firstNoneFoundArrayId = myCurrArray
					firstNoneIndex = j
					i += 1
				else
					i += 1
				endIf
			elseIf firstNoneFound == true
				if akArray2[j] != none
					if firstNoneFoundArrayId == 1
						akArray1[firstNoneIndex] = akArray2[j]
						akArray2[j] = none
					elseIf firstNoneFoundArrayId == 2
						akArray2[firstNoneIndex] = akArray2[j]
						akArray2[j] = none
					elseIf firstNoneFoundArrayId == 3
						akArray3[firstNoneIndex] = akArray2[j]
						akArray2[j] = none
					elseIf firstNoneFoundArrayId == 4
						akArray4[firstNoneIndex] = akArray2[j]
						akArray2[j] = none
					endIf
					CommonArrayHelper.LinkedArraySortArmors(akArray1, akArray2, akArray3, akArray4, firstNoneIndex + 1)
					return true
				else
					i += 1
				endIf
			else
				i += 1
			endIf
		elseIf myCurrArray == 3
			if akArray3[j] == none
				if firstNoneFound == false
					firstNoneFound = true
					firstNoneFoundArrayId = myCurrArray
					firstNoneIndex = j
					i += 1
				else
					i += 1
				endIf
			elseIf firstNoneFound == true
				if akArray3[j] != none
					if firstNoneFoundArrayId == 1
						akArray1[firstNoneIndex] = akArray3[j]
						akArray3[j] = none
					elseIf firstNoneFoundArrayId == 2
						akArray2[firstNoneIndex] = akArray3[j]
						akArray3[j] = none
					elseIf firstNoneFoundArrayId == 3
						akArray3[firstNoneIndex] = akArray3[j]
						akArray3[j] = none
					elseIf firstNoneFoundArrayId == 4
						akArray4[firstNoneIndex] = akArray3[j]
						akArray3[j] = none
					endIf
					CommonArrayHelper.LinkedArraySortArmors(akArray1, akArray2, akArray3, akArray4, firstNoneIndex + 1)
					return true
				else
					i += 1
				endIf
			else
				i += 1
			endIf
		elseIf myCurrArray == 4
			if akArray4[j] == none
				if firstNoneFound == false
					firstNoneFound = true
					firstNoneFoundArrayId = myCurrArray
					firstNoneIndex = j
					i += 1
				else
					i += 1
				endIf
			elseIf firstNoneFound == true
				if akArray4[j] != none
					if firstNoneFoundArrayId == 1
						akArray1[firstNoneIndex] = akArray4[j]
						akArray4[j] = none
					elseIf firstNoneFoundArrayId == 2
						akArray2[firstNoneIndex] = akArray4[j]
						akArray4[j] = none
					elseIf firstNoneFoundArrayId == 3
						akArray3[firstNoneIndex] = akArray4[j]
						akArray4[j] = none
					elseIf firstNoneFoundArrayId == 4
						akArray4[firstNoneIndex] = akArray4[j]
						akArray4[j] = none
					endIf
					CommonArrayHelper.LinkedArraySortArmors(akArray1, akArray2, akArray3, akArray4, firstNoneIndex + 1)
					return true
				else
					i += 1
				endIf
			else
				i += 1
			endIf
		endIf
	endWhile
	return false
endFunction

Int function ArrayCountForm(Form[] akArray) global

	Int i = 0
	Int myCount = 0
	while i < akArray.length
		if !CommonArrayHelper.IsNone(akArray[i])
			myCount += 1
			i += 1
		else
			i += 1
		endIf
	endWhile
	return myCount
endFunction

Bool function ArrayRemoveAlias(Alias[] akArray, Alias akValue, Bool abSort = false) global

	Int i = 0
	while i < akArray.length
		if akArray[i] == akValue
			akArray[i] = none
			if abSort == true
				CommonArrayHelper.ArraySortAlias(akArray, 0)
			endIf
			return true
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

Bool function ArrayRemoveFormList(FormList[] akArray, FormList akValue, Bool abSort = false) global

	Int i = 0
	while i < akArray.length
		if akArray[i] == akValue
			akArray[i] = none
			if abSort == true
				CommonArrayHelper.ArraySortFormList(akArray, 0)
			endIf
			return true
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

Bool function ArrayRemoveForm(Form[] akArray, Form akValue, Bool abSort = false) global

	Int i = 0
	while i < akArray.length
		if akArray[i] == akValue
			akArray[i] = none
			if abSort == true
				CommonArrayHelper.ArraySortForm(akArray, 0)
			endIf
			return true
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

Bool function LinkedArrayRemoveInvalidArmors(Armor[] akArray1, Armor[] akArray2, Armor[] akArray3, Armor[] akArray4) global

	Bool foundInvalidArmor = false
	Int i = 0
	while i < akArray1.length
		if akArray1[i] as String == "[Armor <None>]"
			akArray1[i] = none
			foundInvalidArmor = true
		endIf
		i += 1
	endWhile
	i = 0
	while i < akArray2.length
		if akArray2[i] as String == "[Armor <None>]"
			akArray2[i] = none
			foundInvalidArmor = true
		endIf
		i += 1
	endWhile
	i = 0
	while i < akArray3.length
		if akArray3[i] as String == "[Armor <None>]"
			akArray3[i] = none
			foundInvalidArmor = true
		endIf
		i += 1
	endWhile
	i = 0
	while i < akArray4.length
		if akArray4[i] as String == "[Armor <None>]"
			akArray4[i] = none
			foundInvalidArmor = true
		endIf
		i += 1
	endWhile
	if foundInvalidArmor
		CommonArrayHelper.LinkedArraySortArmors(akArray1, akArray2, akArray3, akArray4, 0)
		return true
	else
		return false
	endIf
endFunction

Int function ArrayCountAlias(Alias[] akArray) global

	Int i = 0
	Int myCount = 0
	while i < akArray.length
		if akArray[i] != none
			myCount += 1
			i += 1
		else
			i += 1
		endIf
	endWhile
	return myCount
endFunction

Bool function ArraySortActiveMagicEffect(ActiveMagicEffect[] akArray, Int i = 0) global

	Bool bFirstNoneFound = false
	Int iFirstNonePos = i
	while i < akArray.length
		if !akArray[i]
			akArray[i] = none
			if bFirstNoneFound == false
				bFirstNoneFound = true
				iFirstNonePos = i
				i += 1
			else
				i += 1
			endIf
		elseIf bFirstNoneFound == true
			if akArray[i]
				akArray[iFirstNonePos] = akArray[i]
				akArray[i] = none
				CommonArrayHelper.ArraySortActiveMagicEffect(akArray, iFirstNonePos + 1)
				return true
			else
				i += 1
			endIf
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

Bool function ArrayAddString(String[] asArray, String asValue) global

	Int i = 0
	while i < asArray.length
		if asArray[i] != ""
			asArray[i] = asValue
			return true
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

Bool function LinkedArrayHasArmor(Armor akArmor, Armor[] akArray1, Armor[] akArray2, Armor[] akArray3, Armor[] akArray4) global

	if akArray1.find(akArmor, 0) != -1
		return true
	elseIf akArray2.find(akArmor, 0) != -1
		return true
	elseIf akArray3.find(akArmor, 0) != -1
		return true
	elseIf akArray4.find(akArmor, 0) != -1
		return true
	else
		return false
	endIf
endFunction

Bool function ArrayAddActiveMagicEffect(ActiveMagicEffect[] akArray, ActiveMagicEffect akValue) global

	Int i = 0
	while i < akArray.length
		if akArray[i] == none
			akArray[i] = akValue
			return true
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

Int function LinkedArrayCountArmors(Armor[] akArray1, Armor[] akArray2, Armor[] akArray3, Armor[] akArray4) global

	Int myCount = 0
	Int i = 0
	while i < akArray1.length
		if akArray1[i] != none
			myCount += 1
			i += 1
		else
			i += 1
		endIf
	endWhile
	i = 0
	while i < akArray2.length
		if akArray2[i] != none
			myCount += 1
			i += 1
		else
			i += 1
		endIf
	endWhile
	i = 0
	while i < akArray3.length
		if akArray3[i] != none
			myCount += 1
			i += 1
		else
			i += 1
		endIf
	endWhile
	i = 0
	while i < akArray4.length
		if akArray4[i] != none
			myCount += 1
			i += 1
		else
			i += 1
		endIf
	endWhile
	return myCount
endFunction

Bool function ArraySortActivator(Activator[] akArray, Int i = 0) global

	Bool bFirstNoneFound = false
	Int iFirstNonePos = i
	while i < akArray.length
		if CommonArrayHelper.IsNone(akArray[i] as Form)
			akArray[i] = none
			if bFirstNoneFound == false
				bFirstNoneFound = true
				iFirstNonePos = i
				i += 1
			else
				i += 1
			endIf
		elseIf bFirstNoneFound == true
			if !CommonArrayHelper.IsNone(akArray[i] as Form)
				akArray[iFirstNonePos] = akArray[i]
				akArray[i] = none
				CommonArrayHelper.ArraySortActivator(akArray, iFirstNonePos + 1)
				return true
			else
				i += 1
			endIf
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

Bool function ArrayAddActivator(Activator[] akArray, Activator akValue) global

	Int i = 0
	while i < akArray.length
		if CommonArrayHelper.IsNone(akArray[i] as Form)
			akArray[i] = akValue
			return true
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

Bool function ArraySortFormList(FormList[] akArray, Int i = 0) global

	Bool bFirstNoneFound = false
	Int iFirstNonePos = i
	while i < akArray.length
		if CommonArrayHelper.IsNone(akArray[i] as Form)
			akArray[i] = none
			if bFirstNoneFound == false
				bFirstNoneFound = true
				iFirstNonePos = i
				i += 1
			else
				i += 1
			endIf
		elseIf bFirstNoneFound == true
			if !CommonArrayHelper.IsNone(akArray[i] as Form)
				akArray[iFirstNonePos] = akArray[i]
				akArray[i] = none
				CommonArrayHelper.ArraySortFormList(akArray, iFirstNonePos + 1)
				return true
			else
				i += 1
			endIf
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

Bool function ArrayRemoveMessage(Message[] akArray, Message akValue, Bool abSort = false) global

	Int i = 0
	while i < akArray.length
		if akArray[i] == akValue
			akArray[i] = none
			if abSort == true
				CommonArrayHelper.ArraySortMessage(akArray, 0)
			endIf
			return true
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

Bool function ArrayRemoveActiveMagicEffect(ActiveMagicEffect[] akArray, ActiveMagicEffect akValue, Bool abSort = false) global

	Int i = 0
	while i < akArray.length
		if akArray[i] == akValue
			akArray[i] = none
			if abSort == true
				CommonArrayHelper.ArraySortActiveMagicEffect(akArray, 0)
			endIf
			return true
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

Bool function ArraySortAlias(Alias[] akArray, Int i = 0) global

	Bool bFirstNoneFound = false
	Int iFirstNonePos = i
	while i < akArray.length
		if !akArray[i]
			akArray[i] = none
			if bFirstNoneFound == false
				bFirstNoneFound = true
				iFirstNonePos = i
				i += 1
			else
				i += 1
			endIf
		elseIf bFirstNoneFound == true
			if akArray[i]
				akArray[iFirstNonePos] = akArray[i]
				akArray[i] = none
				CommonArrayHelper.ArraySortAlias(akArray, iFirstNonePos + 1)
				return true
			else
				i += 1
			endIf
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

Int function ArrayCountActiveMagicEffect(ActiveMagicEffect[] akArray) global

	Int i = 0
	Int myCount = 0
	while i < akArray.length
		if akArray[i] != none
			myCount += 1
			i += 1
		else
			i += 1
		endIf
	endWhile
	return myCount
endFunction

Bool function ArrayAddInt(Int[] aiArray, Int aiValue, Int aiInsertAtValue) global

	Int i = 0
	while i < aiArray.length
		if aiArray[i] == aiInsertAtValue
			aiArray[i] = aiValue
			return true
		else
			i += 1
		endIf
	endWhile
	return false
endFunction

; Skipped compiler generated GetState

; Skipped compiler generated GotoState

function onBeginState()
{Event received when this state is switched to}

	; Empty function
endFunction

function onEndState()
{Event received when this state is switched away from}

	; Empty function
endFunction
