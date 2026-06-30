Scriptname BFA_AbilityHungry extends ActiveMagicEffect

Formlist property FoodList auto
Spell property StomachGrowl auto
Sound property FoodEat auto

Actor PlayerRef
float lastEatenTime
float lastEatenGTime
bool NeedToCheck = true
bool bIsPlayer = false
faction _SNHungryFaction = none

Actor Property PlayerRefActor Auto
GlobalVariable Property GameDaysPassed Auto

; Event received when this effect is first started (OnInit may not have been run yet!)
Event OnEffectStart(Actor akTarget, Actor akCaster)
	PlayerRef = akTarget
	bIsPlayer = PlayerRef==PlayerRefActor
	RegisterForSingleUpdate(10)
	RegisterForModEvent("_SN_PlayerConsumes","OnPlayerEaten")
EndEvent

Event OnPlayerEaten(string hookName, string argString, float argNum, form sender)
	;if PlayerRef==PlayerRefActor
	if bIsPlayer ;Tkc (Loverslab): optimization. check for bool IsPlayer wich is already set on the effect start is much faster than execute PlayerRef==PlayerRefActor on each eaten food
		lastEatenTime = Utility.GetCurrentRealTime()
		lastEatenGTime = GameDaysPassed.GetValue()
	endif
endEvent

; Event received when this effect is finished (effect may already be deleted, calling
; functions on this effect will fail)
Event OnEffectFinish(Actor akTarget, Actor akCaster)
	UnregisterForModEvent("_SN_PlayerConsumes")
	UnregisterForUpdate()
EndEvent

Event OnUpdate()
	float t = Utility.GetCurrentRealTime()
	float g = GameDaysPassed.GetValue()
	float w = 90
	
	if t >= lastEatenTime + w || g > lastEatenGTime + 2.0
		; Actor is hungry
		if CheckInventoryForFood()
			RegisterForSingleUpdate(w * 0.65) ; Actor just ate something, make the wait duration a bit longer
		else
			RegisterForSingleUpdate(Utility.RandomFloat(w*0.5,w*1.5))
		endif
	else
		RegisterForSingleUpdate(10)
	endif
endEvent

Event OnSpellCast(Form akSpell)
	if(akSpell)
		if (akSpell as potion);/!=none/;
			if FoodList.Find(akSpell) || ((akSpell as potion).IsFood() && (akSpell as potion).IsPoison()==false)
				; Actor just ate something
				lastEatenTime = Utility.GetCurrentRealTime()
				lastEatenGTime = GameDaysPassed.GetValue()
			endif
		endif
	endIf
EndEvent

bool function CheckinventoryForFood()
	int c = PlayerRef.GetNumItems()
	
	; If NeedToCheck is false, the actor won't have a FoodItem
	if NeedToCheck;/ == true/;
		bool bFound=false
		int HungerChance = Utility.RandomInt(0,40)
		int ItemsToEat = 1
		if HungerChance>38
			ItemsToEat = Utility.RandomInt(2,4)
		elseif HungerChance>35
			ItemsToEat = Utility.RandomInt(2,3)
		elseif HungerChance>30
			ItemsToEat = Utility.RandomInt(1,3)
		elseif HungerChance>20
			ItemsToEat = Utility.RandomInt(1,2)
		endif
		
		while ItemsToEat>0
			while c>0
				c-=1
				if Eat(PlayerRef.GetNthForm(c))
					c=0
					bFound = true
				endif
			endwhile
			ItemsToEat-=1
		endWhile
		
		if bFound
			return true
		endif
	endif
	
	; Set need to check to false, until an Item was added to the actors inventory.
	NeedToCheck = false
	;if(StomachGrowl;/!=none/; && bIsPlayer)
	if bIsPlayer ;Tkc (Loverslab): optimization
		if StomachGrowl
			; No food found, check for playing sound
			StomachGrowl.Cast(PlayerRef)
			PlayerRef.CreateDetectionEvent(PlayerRef, Utility.RandomInt(20,100))
			return false
		endif
	endif
endFunction

bool function Eat(Form itm)
	;FW_log.WriteLog("Hungry Check Eat: " + itm.GetName())
	if (itm as potion);/!=none/;
		potion p = itm as potion
		if p.IsFood();/ == true/;
			if p.IsHostile() ;Tkc (Loverslab): optimization
			else;if p.IsHostile() == false
				if FoodList.Find(p)>=0
					if PlayerRef.GetItemCount(p)>0
						lastEatenTime = Utility.GetCurrentRealTime()
						lastEatenGTime = GameDaysPassed.GetValue()
						
						;CastEffects(p)
						
						;PlayerRef.OnSpellCast(p)
						PlayerRef.EquipItem(p,false,false)		;PlayerRef.RemoveItem(p,1,true)
						;FoodEat.Play(PlayerRef)
						
						if _SNHungryFaction;/!=none/;
							PlayerRef.RemoveFromFaction(_SNHungryFaction)
						endif
						return true
					endif
				endif
			endif
		endif
	endif
	return false
endFunction

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if FoodList.Find(akBaseItem)>=0
		NeedToCheck=true
	endif
EndEvent

Function CastEffects(potion itm)
	int c = itm.GetNumEffects()
	while c>0
		c-=1
		MagicEffect mfx = itm.GetNthEffectMagicEffect(c)
		float mag = itm.GetNthEffectMagnitude(c)
		int mid = mfx.GetFormID()
		
		if mid==0xf33cb ; Food Restore health
			PlayerRef.RestoreActorValue("Health", mag)
		elseif mid==0x1058A2 ; Food Restore health Duration
			PlayerRef.RestoreActorValue("Health", mag)
		elseif mid==0x1058A7 ; Food restore magicka duration
			PlayerRef.RestoreActorValue("Magicka", mag)
		elseif mid==0xF33CC ; Food restore stamina
			PlayerRef.RestoreActorValue("Stamina", mag)
		elseif mid==0x1058A3 ; Food restore stamina duration
			PlayerRef.RestoreActorValue("Stamina", mag)
		endif
	endWhile
endFunction

;Event On


;int Function GetNumItems() native
;Form Function GetNthForm(int index) native
;float Function GetTotalItemWeight() native
;float Function GetTotalArmorWeight() native

;int Function GetItemCount(Form akItem) native
;Function RemoveItem(Form akItemToRemove, int aiCount = 1, bool abSilent = false, ObjectReference akOtherContainer = None) native
;Function EquipItem(Form akItem, bool abPreventRemoval = false, bool abSilent = false) native

; 02.06.2019 Tkc (Loverslab) optimizations: Changes marked with "Tkc (Loverslab)" comment