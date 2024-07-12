scriptname CommonArrayHelper hidden
{Global array helper functions.}

int function GetVersion() global
	return 2
endFunction

bool function ArrayAddForm(Form[] akArray, Form akValue) global
	;Adds a form to the first available non-None element in the array.
	;		false		=		Error (array full)
	;		true		=		Success

	int i = 0
	while i < akArray.Length
		if IsNone(akArray[i])
			akArray[i] = akValue
			return true
		else
			i += 1
		endif
	endWhile
	return false
endFunction

bool function ArrayAddAlias(Alias[] akArray, Alias akValue) global
	;Adds a form to the first available non-None element in the array.
	;		false		=		Error (array full)
	;		true		=		Success

	int i = 0
	while i < akArray.Length
		if akArray[i] == None
			akArray[i] = akValue
			return true
		else
			i += 1
		endif
	endWhile
	return false
endFunction

bool function ArrayAddActiveMagicEffect(ActiveMagicEffect[] akArray, ActiveMagicEffect akValue) global
	;Adds a form to the first available non-None element in the array.
	;		false		=		Error (array full)
	;		true		=		Success

	int i = 0
	while i < akArray.Length
		if akArray[i] == None
			akArray[i] = akValue
			return true
		else
			i += 1
		endif
	endWhile
	return false
endFunction

bool function ArrayAddArmor(Armor[] akArray, Armor akValue) global
	;Adds a form to the first available non-None element in the array.
	;		false		=		Error (array full)
	;		true		=		Success

	int i = 0
	while i < akArray.Length
		if IsNone(akArray[i])
			akArray[i] = akValue
			return true
		else
			i += 1
		endif
	endWhile
	return false
endFunction

bool function ArrayAddActivator(Activator[] akArray, Activator akValue) global
	;Adds a form to the first available non-None element in the array.
	;		false		=		Error (array full)
	;		true		=		Success

	int i = 0
	while i < akArray.Length
		if IsNone(akArray[i])
			akArray[i] = akValue
			return true
		else
			i += 1
		endif
	endWhile
	return false
endFunction

bool function ArrayAddRef(ObjectReference[] akArray, ObjectReference akValue) global
    int index = akArray.Find(None)
    if index >= 0
        akArray[index] = akValue
        return true
    else
    	return false
    endif
endFunction

bool function ArrayAddBool(Bool[] abArray, Bool abValue, int aiIndex) global
	;Adds a bool to the given array index.
	;		false		=		Error (array full)
	;		true		=		Success

	if aiIndex < abArray.Length
		abArray[aiIndex] = abValue
		return true
	else
		return false
	endif
endFunction

bool function ArrayAddInt(int[] aiArray, int aiValue, int aiInsertAtValue = 0) global
	;Adds an int to the first element with an instance of the supplied value.
	;		false		=		Error (array full, value not found)
	;		true		=		Success

	int i = 0
	while i < aiArray.Length
		if aiArray[i] == aiInsertAtValue
			aiArray[i] = aiValue
			return true
		else
			i += 1
		endif
	endWhile
	return false
endFunction

bool function ArrayAddFloat(float[] afArray, float afValue, float afInsertAtValue = 0.0) global
	;Adds an int to the first element with an instance of the supplied value.
	;		false		=		Error (array full, value not found)
	;		true		=		Success

	int i = 0
	while i < afArray.Length
		if afArray[i] == afInsertAtValue
			afArray[i] = afValue
			return true
		else
			i += 1
		endif
	endWhile
	return false
endFunction

bool function ArrayAddString(String[] asArray, String asValue) global
	;Adds a form to the first available non-None element in the array.
	;		false		=		Error (array full)
	;		true		=		Success

	int i = 0
	while i < asArray.Length
		if asArray[i] != ""
			asArray[i] = asValue
			return true
		else
			i += 1
		endif
	endWhile
	return false
endFunction

bool function ArrayRemoveForm(Form[] akArray, Form akValue, bool abSort = false) global
    ;Removes a form from the array, if found. Sorts the array using ArraySort() if bSort is true.
    ;       false       =       Error (string not found)
    ;       true        =       Success

    int i = 0
    while i < akArray.Length
        if akArray[i] == akValue
            akArray[i] = None
            if abSort == true
                ArraySortForm(akArray)
            endif
            return true
        else
            i += 1
        endif
    endWhile

    return false

endFunction

bool function ArrayRemoveAlias(Alias[] akArray, Alias akValue, bool abSort = false) global
    ;Removes a form from the array, if found. Sorts the array using ArraySort() if bSort is true.
    ;       false       =       Error (string not found)
    ;       true        =       Success

    int i = 0
    while i < akArray.Length
        if akArray[i] == akValue
            akArray[i] = None
            if abSort == true
                ArraySortAlias(akArray)
            endif
            return true
        else
            i += 1
        endif
    endWhile

    return false
endFunction

bool function ArrayRemoveActiveMagicEffect(ActiveMagicEffect[] akArray, ActiveMagicEffect akValue, bool abSort = false) global
    ;Removes a form from the array, if found. Sorts the array using ArraySort() if bSort is true.
    ;       false       =       Error (string not found)
    ;       true        =       Success

    int i = 0
    while i < akArray.Length
        if akArray[i] == akValue
            akArray[i] = None
            if abSort == true
                ArraySortActiveMagicEffect(akArray)
            endif
            return true
        else
            i += 1
        endif
    endWhile

    return false
endFunction


bool function ArrayRemoveFormList(FormList[] akArray, FormList akValue, bool abSort = false) global
    ;Removes a FormList from the array, if found. Sorts the array using ArraySort() if bSort is true.
    ;       false       =       Error (string not found)
    ;       true        =       Success

    int i = 0
    while i < akArray.Length
        if akArray[i] == akValue
            akArray[i] = None
            if abSort == true
                ArraySortFormList(akArray)
            endif
            return true
        else
            i += 1
        endif
    endWhile

    return false

endFunction

bool function ArrayRemoveMessage(Message[] akArray, Message akValue, bool abSort = false) global
    ;Removes a Message from the array, if found. Sorts the array using ArraySort() if bSort is true.
    ;       false       =       Error (string not found)
    ;       true        =       Success

    int i = 0
    while i < akArray.Length
        if akArray[i] == akValue
            akArray[i] = None
            if abSort == true
                ArraySortMessage(akArray)
            endif
            return true
        else
            i += 1
        endif
    endWhile

    return false

endFunction

bool function ArrayRemoveArmor(Armor[] akArray, Armor akValue, bool abSort = false) global
    ;Removes a form from the array, if found. Sorts the array using ArraySort() if bSort is true.
    ;       false       =       Error (string not found)
    ;       true        =       Success

    int i = 0
    while i < akArray.Length
        if akArray[i] == akValue
            akArray[i] = None
            if abSort == true
                ArraySortArmor(akArray)
            endif
            return true
        else
            i += 1
        endif
    endWhile

    return false

endFunction

bool function ArraySortForm(Form[] akArray, int i = 0) global
	;Removes blank elements by shifting all elements down.
	;		   false		=			   No sorting required
	;		   true			=			   Success

	 bool bFirstNoneFound = false
	 int iFirstNonePos = i
	 while i < akArray.Length
		  if IsNone(akArray[i])
		  	   akArray[i] = none
			   if bFirstNoneFound == false
					bFirstNoneFound = true
					iFirstNonePos = i
					i += 1
			   else
					i += 1
			   endif
		  else
			   if bFirstNoneFound == true
			   ;check to see if it's a couple of blank entries in a row
					if !(IsNone(akArray[i]))
						 akArray[iFirstNonePos] = akArray[i]
						 akArray[i] = none

						 ;Call this function recursively until it returns
						 ArraySortForm(akArray, iFirstNonePos + 1)
						 return true
					else
						 i += 1
					endif
			   else
					i += 1
			   endif
		  endif
	 endWhile
	 return false
endFunction

bool function ArraySortArmor(Armor[] akArray, int i = 0) global
	;Removes blank elements by shifting all elements down.
	;		   false		=			   No sorting required
	;		   true			=			   Success

	 bool bFirstNoneFound = false
	 int iFirstNonePos = i
	 while i < akArray.Length
		  if IsNone(akArray[i])
		  	   akArray[i] = none
			   if bFirstNoneFound == false
					bFirstNoneFound = true
					iFirstNonePos = i
					i += 1
			   else
					i += 1
			   endif
		  else
			   if bFirstNoneFound == true
			   ;check to see if it's a couple of blank entries in a row
					if !(IsNone(akArray[i]))
						 akArray[iFirstNonePos] = akArray[i]
						 akArray[i] = none

						 ;Call this function recursively until it returns
						 ArraySortArmor(akArray, iFirstNonePos + 1)
						 return true
					else
						 i += 1
					endif
			   else
					i += 1
			   endif
		  endif
	 endWhile
	 return false
endFunction

bool function ArraySortActivator(Activator[] akArray, int i = 0) global
	;Removes blank elements by shifting all elements down.
	;		   false		=			   No sorting required
	;		   true			=			   Success

	 bool bFirstNoneFound = false
	 int iFirstNonePos = i
	 while i < akArray.Length
		  if IsNone(akArray[i])
		  	   akArray[i] = none
			   if bFirstNoneFound == false
					bFirstNoneFound = true
					iFirstNonePos = i
					i += 1
			   else
					i += 1
			   endif
		  else
			   if bFirstNoneFound == true
			   ;check to see if it's a couple of blank entries in a row
					if !(IsNone(akArray[i]))
						 akArray[iFirstNonePos] = akArray[i]
						 akArray[i] = none

						 ;Call this function recursively until it returns
						 ArraySortActivator(akArray, iFirstNonePos + 1)
						 return true
					else
						 i += 1
					endif
			   else
					i += 1
			   endif
		  endif
	 endWhile
	 return false
endFunction

bool function ArraySortMessage(Message[] akArray, int i = 0) global
	;Removes blank elements by shifting all elements down.
	;		   false		=			   No sorting required
	;		   true			=			   Success
	 bool bFirstNoneFound = false
	 int iFirstNonePos = i
	 while i < akArray.Length
		  if IsNone(akArray[i])
		  	   akArray[i] = none
			   if bFirstNoneFound == false
					bFirstNoneFound = true
					iFirstNonePos = i
					i += 1
			   else
					i += 1
			   endif
		  else
			   if bFirstNoneFound == true
			   ;check to see if it's a couple of blank entries in a row
					if !(IsNone(akArray[i]))
						 akArray[iFirstNonePos] = akArray[i]
						 akArray[i] = none

						 ;Call this function recursively until it returns
						 ArraySortMessage(akArray, iFirstNonePos + 1)
						 return true
					else
						 i += 1
					endif
			   else
					i += 1
			   endif
		  endif
	 endWhile
	 return false
endFunction

bool function ArraySortFormList(FormList[] akArray, int i = 0) global
	;Removes blank elements by shifting all elements down.
	;		   false		=			   No sorting required
	;		   true			=			   Success
	 bool bFirstNoneFound = false
	 int iFirstNonePos = i
	 while i < akArray.Length
		  if IsNone(akArray[i])
		  	   akArray[i] = none
			   if bFirstNoneFound == false
					bFirstNoneFound = true
					iFirstNonePos = i
					i += 1
			   else
					i += 1
			   endif
		  else
			   if bFirstNoneFound == true
			   ;check to see if it's a couple of blank entries in a row
					if !(IsNone(akArray[i]))
						 akArray[iFirstNonePos] = akArray[i]
						 akArray[i] = none
						 ;Call this function recursively until it returns
						 ArraySortFormList(akArray, iFirstNonePos + 1)
						 return true
					else
						 i += 1
					endif
			   else
					i += 1
			   endif
		  endif
	 endWhile
	 return false
endFunction

bool function ArraySortAlias(Alias[] akArray, int i = 0) global
	;Removes blank elements by shifting all elements down.
	;		   false		=			   No sorting required
	;		   true			=			   Success
	 bool bFirstNoneFound = false
	 int iFirstNonePos = i
	 while i < akArray.Length
		  if !(akArray[i])
		  	   akArray[i] = none
			   if bFirstNoneFound == false
					bFirstNoneFound = true
					iFirstNonePos = i
					i += 1
			   else
					i += 1
			   endif
		  else
			   if bFirstNoneFound == true
			   ;check to see if it's a couple of blank entries in a row
					if (akArray[i])
						 akArray[iFirstNonePos] = akArray[i]
						 akArray[i] = none
						 ;Call this function recursively until it returns
						 ArraySortAlias(akArray, iFirstNonePos + 1)
						 return true
					else
						 i += 1
					endif
			   else
					i += 1
			   endif
		  endif
	 endWhile
	 return false
endFunction

bool function ArraySortActiveMagicEffect(ActiveMagicEffect[] akArray, int i = 0) global
	;Removes blank elements by shifting all elements down.
	;		   false		=			   No sorting required
	;		   true			=			   Success
	 bool bFirstNoneFound = false
	 int iFirstNonePos = i
	 while i < akArray.Length
		  if !(akArray[i])
		  	   akArray[i] = none
			   if bFirstNoneFound == false
					bFirstNoneFound = true
					iFirstNonePos = i
					i += 1
			   else
					i += 1
			   endif
		  else
			   if bFirstNoneFound == true
			   ;check to see if it's a couple of blank entries in a row
					if (akArray[i])
						 akArray[iFirstNonePos] = akArray[i]
						 akArray[i] = none
						 ;Call this function recursively until it returns
						 ArraySortActiveMagicEffect(akArray, iFirstNonePos + 1)
						 return true
					else
						 i += 1
					endif
			   else
					i += 1
			   endif
		  endif
	 endWhile
	 return false
endFunction

int function ArrayCountForm(Form[] akArray) global
	;Counts the number of indices in this array that do not have a "none" type.
	;		int myCount = number of indicies that are not "none"

	int i = 0
	int myCount = 0
	while i < akArray.Length
		if !(IsNone(akArray[i]))
			myCount += 1
			i += 1
		else
			i += 1
		endif
	endWhile
	return myCount
endFunction

int function ArrayCountAlias(Alias[] akArray) global
	;Counts the number of indices in this array that do not have a "none" type.
	;		int myCount = number of indicies that are not "none"

	int i = 0
	int myCount = 0
	while i < akArray.Length
		if akArray[i] != None
			myCount += 1
			i += 1
		else
			i += 1
		endif
	endWhile
	return myCount
endFunction

int function ArrayCountActiveMagicEffect(ActiveMagicEffect[] akArray) global
	;Counts the number of indices in this array that do not have a "none" type.
	;		int myCount = number of indicies that are not "none"

	int i = 0
	int myCount = 0
	while i < akArray.Length
		if akArray[i] != None
			myCount += 1
			i += 1
		else
			i += 1
		endif
	endWhile
	return myCount
endFunction

int function ArrayCountArmor(Armor[] akArray) global
	;Counts the number of indices in this array that do not have a "none" type.
	;		int myCount = number of indicies that are not "none"

	int i = 0
	int myCount = 0
	while i < akArray.Length
		if !(IsNone(akArray[i]))
			myCount += 1
			i += 1
		else
			i += 1
		endif
	endWhile
	return myCount
endFunction

int function ArrayCountActivator(Activator[] akArray) global
	;Counts the number of indices in this array that do not have a "none" type.
	;		int myCount = number of indicies that are not "none"

	int i = 0
	int myCount = 0
	while i < akArray.Length
		if !(IsNone(akArray[i]))
			myCount += 1
			i += 1
		else
			i += 1
		endif
	endWhile
	return myCount
endFunction

int function ArrayCountRef(ObjectReference[] akArray) global
	;Counts the number of indices in this array that do not have a "none" type.
	;		int myCount = number of indicies that are not "none"

	int i = 0
	int myCount = 0
	while i < akArray.Length
		if akArray[i] != None
			myCount += 1
			i += 1
		else
			i += 1
		endif
	endWhile
	return myCount
endFunction


bool function IsNone(Form akForm) global
	; Array elements that contain forms from unloaded mods
	; will fail '== None' checks because they are
	; 'Form<None>' objects. Check FormID as well.
	int i = 0
	if akForm
		i = akForm.GetFormID()
		if i == 0
			return true
		else
			return false
		endif
	else
		return true
	endif
endFunction

bool function LinkedArrayAddForm(Form akForm, Form[] akArray1, Form[] akArray2, Form[] akArray3, Form[] akArray4) global
    ; Adds a form to the first available element in the first available array
	; associated with this ArrayID.

	; Return values
    ; false 	=               Error (linked array full)
    ; true		=               Success

    int idx = -1
    idx = akArray1.Find(none)
    if idx != -1
    	akArray1[idx] = akForm
    	return true
    endif

    idx = -1
    idx = akArray2.Find(none)
    if idx != -1
    	akArray2[idx] = akForm
    	return true
    endif

    idx = -1
    idx = akArray3.Find(none)
    if idx != -1
    	akArray3[idx] = akForm
    	return true
    endif

    idx = -1
    idx = akArray4.Find(none)
    if idx != -1
    	akArray4[idx] = akForm
    	return true
    endif

    return false
endFunction

bool function LinkedArrayRemoveForm(Form akForm, Form[] akArray1, Form[] akArray2, Form[] akArray3, Form[] akArray4, bool abSort = true) global
	; Removes the first occurrence of a form from the array, if found.
	
	; Return values
	; false 	=		Error (Form not found)
	; true		=		Success

	int idx = -1
	idx = akArray1.Find(akForm)
	if idx != -1
		akArray1[idx] = none
		if abSort
			LinkedArraySortForms(akArray1, akArray2, akArray3, akArray4)
		endif
		return true
	endif

	idx = -1
	idx = akArray2.Find(akForm)
	if idx != -1
		akArray2[idx] = none
		if abSort
			LinkedArraySortForms(akArray1, akArray2, akArray3, akArray4)
		endif
		return true
	endif

	idx = -1
	idx = akArray3.Find(akForm)
	if idx != -1
		akArray3[idx] = none
		if abSort
			LinkedArraySortForms(akArray1, akArray2, akArray3, akArray4)
		endif
		return true
	endif

	idx = -1
	idx = akArray4.Find(akForm)
	if idx != -1
		akArray4[idx] = none
		if abSort
			LinkedArraySortForms(akArray1, akArray2, akArray3, akArray4)
		endif
		return true
	endif

	return false
endFunction

bool function LinkedArrayHasForm(Form akForm, Form[] akArray1, Form[] akArray2, Form[] akArray3, Form[] akArray4) global
	; Attempts to find the given form in the associated array ID, and returns true if found
	
	; Return values
	; false		= 		Form not found
	; true 		=		Form found

	if akArray1.Find(akForm) != -1
		return true
	elseif akArray2.Find(akForm) != -1
		return true
	elseif akArray3.Find(akForm) != -1
		return true
	elseif akArray4.Find(akForm) != -1
		return true
	else
		return false
	endif
endFunction

function LinkedArrayClearForms128(Form[] akArray1, Form[] akArray2, Form[] akArray3, Form[] akArray4) global
	; Reinitializes and clears linked arrays into Form[128] arrays.
	
	; Return values
	; none

	akArray1 = new Form[128]
	akArray2 = new Form[128]
	akArray3 = new Form[128]
	akArray4 = new Form[128]
endFunction

function LinkedArrayRemoveInvalidForms(Form[] akArray1, Form[] akArray2, Form[] akArray3, Form[] akArray4) global
	; Clears all arrays of invalid forms ([Form <None>]) and re-sorts.

	; Return values
	; none

	bool foundInvalidForm = false
	int i = 0
	while i < akArray1.Length
		if akArray1[i] == "[Form <None>]"
			akArray1[i] = none
			foundInvalidForm = true
		endif
		i += 1
	endWhile
	
	i = 0
	while i < akArray2.Length
		if akArray2[i] == "[Form <None>]"
			akArray2[i] = none
			foundInvalidForm = true
		endif
		i += 1
	endWhile
	
	i = 0
	while i < akArray3.Length
		if akArray3[i] == "[Form <None>]"
			akArray3[i] = none
			foundInvalidForm = true
		endif
		i += 1
	endWhile
	
	i = 0
	while i < akArray4.Length
		if akArray4[i] == "[Form <None>]"
			akArray4[i] = none
			foundInvalidForm = true
		endif
		i += 1
	endWhile
	
	if foundInvalidForm
		LinkedArraySortForms(akArray1, akArray2, akArray3, akArray4)
	endif
endFunction

int function LinkedArrayCountForms(Form[] akArray1, Form[] akArray2, Form[] akArray3, Form[] akArray4) global
	;Counts the number of indicies in this linked array that do not have a "none" type
	
	; Return values
	; int myCount = number of indicies that are not "none"

	int myCount = 0
	
	int i = 0
	while i < akArray1.Length
		if akArray1[i] != none
			myCount += 1
			i += 1
		else
			i += 1
		endif
	endWhile
	
	i = 0
	while i < akArray2.Length
		if akArray2[i] != none
			myCount += 1
			i += 1
		else
			i += 1
		endif
	endWhile
	
	i = 0
	while i < akArray3.Length
		if akArray3[i] != none
			myCount += 1
			i += 1
		else
			i += 1
		endif
	endWhile
	
	i = 0
	while i < akArray4.Length
		if akArray4[i] != none
			myCount += 1
			i += 1
		else
			i += 1
		endif
	endWhile
	
	return myCount
endFunction

bool function LinkedArraySortForms(Form[] akArray1, Form[] akArray2, Form[] akArray3, Form[] akArray4, int i = 0) global
	; Removes blank elements by shifting all elements down, moving elements
	; to arrays "below" the current one if necessary.
	; Optionally starts sorting from element i.
	
	; Return values
	; false 	=           No sorting required
	; true 		=           Success
	
	;debug.trace("Sort Start")
	bool firstNoneFound = false
	int firstNoneFoundArrayId = 0
	int firstNoneIndex = 0
	while i < 512
		;Which array am I looking in?
		int j = 0					;Actual array index to check
		int myCurrArray				;Current array
		if i < 128
			myCurrArray = 1
			j = i
		elseif i < 256 && i >= 128
			j = i - 128
			myCurrArray = 2
		elseif i < 384 && i >= 256
			j = i - 256
			myCurrArray = 3
		elseif i < 512 && i >= 384
			j = i - 384
			myCurrArray = 4
		endif
		
		if myCurrArray == 1
			if akArray1[j] == none
				if firstNoneFound == false
					firstNoneFound = true
					firstNoneFoundArrayId = myCurrArray
					firstNoneIndex = j
					i += 1
				else
					i += 1
				endif
			else
				if firstNoneFound == true
					;check to see if it's a couple of blank entries in a row
					if !(akArray1[j] == none)
						;notification("Moving element " + i + " to index " + firstNoneIndex)
						if firstNoneFoundArrayId == 1
							akArray1[firstNoneIndex] = akArray1[j]
							akArray1[j] = none
						elseif firstNoneFoundArrayId == 2
							akArray2[firstNoneIndex] = akArray1[j]
							akArray1[j] = none
						elseif firstNoneFoundArrayId == 3
							akArray3[firstNoneIndex] = akArray1[j]
							akArray1[j] = none
						elseif firstNoneFoundArrayId == 4
							akArray4[firstNoneIndex] = akArray1[j]
							akArray1[j] = none
						endif
						;Call this function recursively until it returns
						LinkedArraySortForms(akArray1, akArray2, akArray3, akArray4, firstNoneIndex + 1)
						return true
					else
						i += 1
					endif
				else
					i += 1
				endif
			endif
		elseif myCurrArray == 2
			if akArray2[j] == none
				if firstNoneFound == false
					firstNoneFound = true
					firstNoneFoundArrayId = myCurrArray
					firstNoneIndex = j
					i += 1
				else
					i += 1
				endif
			else
				if firstNoneFound == true
					;check to see if it's a couple of blank entries in a row
					if !(akArray2[j] == none)
						;notification("Moving element " + i + " to index " + firstNoneIndex)
						if firstNoneFoundArrayId == 1
							akArray1[firstNoneIndex] = akArray2[j]
							akArray2[j] = none
						elseif firstNoneFoundArrayId == 2
							akArray2[firstNoneIndex] = akArray2[j]
							akArray2[j] = none
						elseif firstNoneFoundArrayId == 3
							akArray3[firstNoneIndex] = akArray2[j]
							akArray2[j] = none
						elseif firstNoneFoundArrayId == 4
							akArray4[firstNoneIndex] = akArray2[j]
							akArray2[j] = none
						endif
						;Call this function recursively until it returns
						LinkedArraySortForms(akArray1, akArray2, akArray3, akArray4, firstNoneIndex + 1)
						return true
					else
						i += 1
					endif
				else
					i += 1
				endif
			endif
		elseif myCurrArray == 3
			if akArray3[j] == none
				if firstNoneFound == false
					firstNoneFound = true
					firstNoneFoundArrayId = myCurrArray
					firstNoneIndex = j
					i += 1
				else
					i += 1
				endif
			else
				if firstNoneFound == true
					;check to see if it's a couple of blank entries in a row
					if !(akArray3[j] == none)
						;notification("Moving element " + i + " to index " + firstNoneIndex)
						if firstNoneFoundArrayId == 1
							akArray1[firstNoneIndex] = akArray3[j]
							akArray3[j] = none
						elseif firstNoneFoundArrayId == 2
							akArray2[firstNoneIndex] = akArray3[j]
							akArray3[j] = none
						elseif firstNoneFoundArrayId == 3
							akArray3[firstNoneIndex] = akArray3[j]
							akArray3[j] = none
						elseif firstNoneFoundArrayId == 4
							akArray4[firstNoneIndex] = akArray3[j]
							akArray3[j] = none
						endif
						;Call this function recursively until it returns
						LinkedArraySortForms(akArray1, akArray2, akArray3, akArray4, firstNoneIndex + 1)
						return true
					else
						i += 1
					endif
				else
					i += 1
				endif
			endif
		elseif myCurrArray == 4
			if akArray4[j] == none
				if firstNoneFound == false
					firstNoneFound = true
					firstNoneFoundArrayId = myCurrArray
					firstNoneIndex = j
					i += 1
				else
					i += 1
				endif
			else
				if firstNoneFound == true
					;check to see if it's a couple of blank entries in a row
					if !(akArray4[j] == none)
						;notification("Moving element " + i + " to index " + firstNoneIndex)
						if firstNoneFoundArrayId == 1
							akArray1[firstNoneIndex] = akArray4[j]
							akArray4[j] = none
						elseif firstNoneFoundArrayId == 2
							akArray2[firstNoneIndex] = akArray4[j]
							akArray4[j] = none
						elseif firstNoneFoundArrayId == 3
							akArray3[firstNoneIndex] = akArray4[j]
							akArray4[j] = none
						elseif firstNoneFoundArrayId == 4
							akArray4[firstNoneIndex] = akArray4[j]
							akArray4[j] = none
						endif
						;Call this function recursively until it returns
						LinkedArraySortForms(akArray1, akArray2, akArray3, akArray4, firstNoneIndex + 1)
						return true
					else
						i += 1
					endif
				else
					i += 1
				endif
			endif
		endif
	endWhile
	
	return false
endFunction