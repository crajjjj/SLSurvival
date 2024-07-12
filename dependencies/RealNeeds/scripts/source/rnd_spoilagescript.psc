Scriptname RND_SpoilageScript extends ReferenceAlias  

GlobalVariable Property RND_State Auto
GlobalVariable Property RND_HasSKSE Auto
GlobalVariable Property RND_HasSkyUI Auto
GlobalVariable Property RND_FoodSpoilage Auto

Form [] FoodList
float [] TimeStampList

Keyword [] Property SpoilTable0 Auto
Potion [] Property SpoilTable1 Auto

Actor Player

int error = 0
bool recount = false

Event OnInit()
	Player = Game.GetPlayer()
	FoodList = new Form [128]
	TimeStampList = new Float [128]

	if foodSpoilageEnabled()
		countFood()
	endif
	RegisterForSingleUpdateGameTime(2)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)

	if foodSpoilageEnabled() && akBaseItem.GetType() == 46 && (akBaseItem as Potion).isFood()
		float timestamp = calExpiry(akBaseItem)
		if timestamp > 0.0
			int count = aiItemCount
			while count > 0
				foodAdded(akBaseItem, timestamp)
				count -= 1
			endWhile			
		endif
	endif
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
  if foodSpoilageEnabled() && akBaseObject.GetType() == 46 && (akBaseObject as Potion).isFood()
		float timestamp = calExpiry(akBaseObject)
		if timestamp > 0.0			
			foodRemoved(akBaseObject)
		endif
	endif
endEvent

Event OnItemRemoved(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akDestContainer)

	if akItemReference || akDestContainer
		if foodSpoilageEnabled() && akBaseItem.GetType() == 46 && (akBaseItem as Potion).isFood()
			float timestamp = calExpiry(akBaseItem)
			if timestamp > 0.0
				int count = aiItemCount
				while count > 0
					foodRemoved(akBaseItem)
					count -= 1
				endWhile
			endif
		endif	
	endif
EndEvent

Event OnUpdateGameTime()
	if foodSpoilageEnabled()
		if recount == true || error >= 2
			syncList()			
			recount = false
			error = 0
		endif
		checkSpoilage()
	endif
	RegisterForSingleUpdateGameTime(2)
EndEvent

bool Function foodSpoilageEnabled()
	if RND_HasSKSE.GetValue() == 1 && RND_FoodSpoilage.GetValue() == 1
		Return True
	else
		Return False
	endif
EndFunction

float Function calExpiry(Form food)

	float timestamp = 0.0
	if food.hasKeyWord(RND_SpoilageCategory0)
			timestamp = Utility.GetCurrentGameTime() + RND_SpoilDaysCat0.GetValue()
	elseif food.hasKeyWord(RND_SpoilageCategory1)
			timestamp = Utility.GetCurrentGameTime() + RND_SpoilDaysCat1.GetValue()
	elseif food.hasKeyWord(RND_SpoilageCategory2)
			timestamp = Utility.GetCurrentGameTime() + RND_SpoilDaysCat2.GetValue()
	elseif food.hasKeyWord(RND_SpoilageCategory3)
			timestamp = Utility.GetCurrentGameTime() + RND_SpoilDaysCat3.GetValue()
	elseif food.hasKeyWord(RND_SpoilageCategory4)
			timestamp = Utility.GetCurrentGameTime() + RND_SpoilDaysCat4.GetValue()
	elseif food.hasKeyWord(RND_SpoilageCategory5)
			timestamp = Utility.GetCurrentGameTime() + RND_SpoilDaysCat5.GetValue()
	elseif food.hasKeyWord(RND_SpoilageCategory6)
			timestamp = Utility.GetCurrentGameTime() + RND_SpoilDaysCat6.GetValue()
	elseif food.hasKeyWord(RND_SpoilageCategory7)
			timestamp = Utility.GetCurrentGameTime() + RND_SpoilDaysCat7.GetValue()
	elseif food.hasKeyWord(RND_SpoilageCategory8)
			timestamp = Utility.GetCurrentGameTime() + RND_SpoilDaysCat8.GetValue()
	elseif food.hasKeyWord(RND_SpoilageCategory9)
			timestamp = Utility.GetCurrentGameTime() + RND_SpoilDaysCat9.GetValue()
	endif
	Return timestamp
EndFunction

bool Function foodAdded(Form food, float expire)

	int i = 0
	while i < FoodList.Length	
		if FoodList[i] == None
			FoodList[i] = food
			TimeStampList[i] = expire
			;Debug.Trace("RND: " + food.GetName() + " Added")
			Return True
		endif
		i += 1	
	endWhile
	error += 1
	Return False
EndFunction

bool Function foodRemoved(Form food)

	int p = -1
	float ts = 0.0

	int i = 0
	while i < FoodList.Length	
		if FoodList[i] == food
			if p == -1 || ts > TimeStampList[i]
				p = i
				ts = TimeStampList[i]
			endif			
		endif
		i += 1
	endWhile
	
	if p >= 0
		FoodList[p] = None
		TimeStampList[p] = 0.0
		;Debug.Trace("RND: " + food.GetName() + " Removed")
		Return True
	else
		error += 1
		Return False
	endif
EndFunction

Function foodSpoiled(Form food)

	if Player.getItemCount(food) >= 1
		Player.RemoveItem(food, 1, true)
		if RND_RemoveSpoiledFood.getValue() == 0
			int i = 0
			while i < SpoilTable0.Length
				if food.hasKeyword(SpoilTable0[i])
					Player.AddItem(SpoilTable1[i], 1, true)
					Return
				endif
				i += 1
			endWhile
		
			if food.hasKeyword(RND_STRottenMeat)
				Player.AddItem(RND_SpoiledJunkB, 1, true)
			else
				Player.AddItem(RND_SpoiledJunk, 1, true)
			endif
		endif
	endif
EndFunction

Function checkSpoilage()

	int i = 0
	float CurrentTime = Utility.GetCurrentGameTime()
	while i < FoodList.Length	
		if FoodList[i] != None && TimeStampList[i] <= CurrentTime
			foodSpoiled(FoodList[i])
			FoodList[i] = None
			TimeStampList[i] = 0.0
		endif
		i += 1
	endWhile
EndFunction

Function countFood(bool refresh = false)

	if refresh == true
		int i = 0
		while i < FoodList.Length	
			FoodList[i] = None
			TimeStampList[i] = 0.0
			i += 1
		endWhile	
	endif

	int max = 0
	
	Form item
	int num = Player.GetNumItems()
	while num > 0
		num -= 1
		item = Player.GetNthForm(num)
		if item != None && item.GetType() == 46 && (item as Potion).isFood()
			float timestamp = calExpiry(item)
			if timestamp > 0.0	
				int count = Player.getItemCount(item)
				while count > 0 && max < FoodList.Length
					max += 1
					foodAdded(item, timestamp)
					count -= 1
				endWhile			
			endif
		endif
	endWhile
EndFunction

Function syncList()

	int i = 0
	while i < FoodList.Length	
		if FoodList[i] != None
			if Player.getItemCount(FoodList[i]) <= 0
				FoodList[i] = None
				TimeStampList[i] = 0.0
			endif
		endif
		i += 1	
	endWhile

	Form item
	int num = Player.GetNumItems()
	while num > 0
		num -= 1
		item = Player.GetNthForm(num)
		if item != None && item.GetType() == 46 && (item as Potion).isFood()
			float timestamp = calExpiry(item)
			if timestamp > 0.0	
				int count = Player.getItemCount(item)
				int count_l = countInList(item)
				int diff = count - count_l		
				while diff < 0
					foodRemoved(item)
					diff += 1
				endWhile
				while diff > 0
					foodAdded(item, timestamp)
					diff -= 1
				endWhile
			endif
		endif
	endWhile

EndFunction

int Function countInList(Form food)
	int i = 0
	int num = 0
	while i < FoodList.Length	
		if FoodList[i] == food
			num += 1
		endif
		i += 1	
	endWhile
	Return num
EndFunction

Function refresh()
	recount = true
EndFunction

KeyWord Property RND_SpoilageCategory0 Auto
KeyWord Property RND_SpoilageCategory1 Auto
KeyWord Property RND_SpoilageCategory2 Auto
KeyWord Property RND_SpoilageCategory3 Auto
KeyWord Property RND_SpoilageCategory4 Auto
KeyWord Property RND_SpoilageCategory5 Auto
KeyWord Property RND_SpoilageCategory6 Auto
KeyWord Property RND_SpoilageCategory7 Auto
KeyWord Property RND_SpoilageCategory8 Auto
KeyWord Property RND_SpoilageCategory9 Auto

GlobalVariable Property RND_SpoilDaysCat0 Auto
GlobalVariable Property RND_SpoilDaysCat1 Auto
GlobalVariable Property RND_SpoilDaysCat2 Auto
GlobalVariable Property RND_SpoilDaysCat3 Auto
GlobalVariable Property RND_SpoilDaysCat4 Auto
GlobalVariable Property RND_SpoilDaysCat5 Auto
GlobalVariable Property RND_SpoilDaysCat6 Auto
GlobalVariable Property RND_SpoilDaysCat7 Auto
GlobalVariable Property RND_SpoilDaysCat8 Auto
GlobalVariable Property RND_SpoilDaysCat9 Auto
GlobalVariable Property RND_RemoveSpoiledFood Auto

Potion Property RND_SpoiledJunk Auto
Potion Property RND_SpoiledJunkB Auto
Keyword Property RND_STRottenMeat Auto

