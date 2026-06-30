Scriptname FWInfectionSpell extends FWSpell  

;FWSystem property System auto
Potion[] property HealDrink auto
float CurDamage = 1.0
actor ActorRef

Event OnWoman(Actor akTarget, Actor akCaster)
	ActorRef=akTarget
	RegisterForSingleUpdateGameTime(1)
endEvent

Event OnMan(Actor akTarget, Actor akCaster)
	Dispel()
endEvent

Event OnUpdateGameTime()
	;doDamage(actor A, float Percentage, bool Silent = false, bool DoBleedOut = true, ImageSpaceModifier Effect = none)

	; Find the list of fathers
	int my_num_men = StorageUtil.FormListCount(ActorRef, "FW.ChildFather")
	float my_Abortus_DamageScale = 0
	float temp_Abortus_DamageScale = 0
	actor a = none
	race abr = none
	while my_num_men > 0
		my_num_men -= 1
		a = (StorageUtil.FormListGet(ActorRef, "FW.ChildFather", my_num_men) As Actor)
		if a
			temp_Abortus_DamageScale = StorageUtil.GetFloatValue(a, "FW.AddOn.Modify_Pain_Abortus_by_FatherRace", 1.0)
			if(temp_Abortus_DamageScale == 1.0)
				abr = a.GetRace()
				if abr
					temp_Abortus_DamageScale = StorageUtil.GetFloatValue(abr, "FW.AddOn.Modify_Pain_Abortus_by_FatherRace", 1.0)
				endIf
			endIf

			if(temp_Abortus_DamageScale > my_Abortus_DamageScale)
				my_Abortus_DamageScale = temp_Abortus_DamageScale
			endIf
		endIf
	endWhile
	my_Abortus_DamageScale *= (CurDamage * (System.getDamageScale(5, ActorRef)))

	if(my_Abortus_DamageScale > 0)
		System.doDamage(ActorRef, my_Abortus_DamageScale, 13)
		if CurDamage < 15
			CurDamage+=1.0
		elseif CurDamage>=15 && CurDamage < 35
			CurDamage+=1.2
		elseif CurDamage>=35 && CurDamage < 50
			CurDamage+=1.8
		elseif CurDamage>=50
			CurDamage+=2.5
		else
			CurDamage+=1.0
		endif
	endIf
	RegisterForSingleUpdateGameTime(1)
endEvent

Event OnSpellCast(Form akSpell)
	if(akSpell)
		int i=HealDrink.length
		while i>0
			i-=1
			if akSpell==HealDrink[i]
				Dispel()
			endif
		endWhile
	endIf
endEvent