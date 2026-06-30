Scriptname FWAbilityBeeingNUFemale extends ActiveMagicEffect

actor ActorRef

bool IsCreature = false

Keyword Property ActorTypeCreature Auto
FWSystemConfig property cfg Auto
armor property Tampon_Normal auto
potion property ContraceptionMid auto
potion property ContraceptionLow auto
Scroll property CallChildren2 auto

;Event OnInit()
;	RegisterForSleep()
;endEvent

;function OnGameLoad()
;	UnregisterForSleep()
;	RegisterForSleep()
;endFunction

;Event OnDeath(Actor akKiller)
;	FWChildActor ca = akKiller as FWChildActor
;	if ca;/!=none/;
;		ca.AddExp(ActorRef.GetLevel() * 2)
;	endif
;EndEvent


; Event received when this effect is first started (OnInit may not have been run yet!)
Event OnEffectStart(Actor akTarget, Actor akCaster)
	ActorRef = akTarget
	IsCreature = akTarget.GetRace().HasKeyword(ActorTypeCreature)
	
	if IsCreature ;Tkc (Loverslab): optimization
	else;if IsCreature==false
		if cfg.NPCHaveItems
			if cfg.Difficulty >= 0
				if cfg.Difficulty < 3	
					if cfg.Difficulty < 2
						if cfg.Difficulty==0
							GiveItems_DifficultyPainless(akTarget)
						else;if cfg.Difficulty==1
							GiveItems_DifficultyEasy(akTarget)
						endIf
					else;if cfg.Difficulty==2
						GiveItems_DifficultyNormal(akTarget)
					endIf
				else
					if cfg.Difficulty==3
						GiveItems_DifficultyAdvanced(akTarget)
					elseif cfg.Difficulty==4
						GiveItems_DifficultyHeavy(akTarget)
					endif
				endIf
			endIf
		endif
	endif
EndEvent

function GiveItems_DifficultyPainless(actor akTarget)
	;if Utility.RandomInt(0,5)>=4
		int rnd1=Utility.RandomInt(0,20)
		int rnd2=Utility.RandomInt(0,20)
		int rnd3=Utility.RandomInt(0,50)
		if rnd1>=12
			if rnd1>=18
				akTarget.AddItem(Tampon_Normal, Utility.RandomInt(3,8), true)
			else;if rnd1>=12
				akTarget.AddItem(Tampon_Normal, Utility.RandomInt(2,5), true)
			endIf
		else
			akTarget.AddItem(Tampon_Normal, 2, true)
		endif
		if rnd2>=3
			if rnd2>=9
				if rnd2>=18
					akTarget.AddItem(ContraceptionMid, Utility.RandomInt(1,2), true)
				else;if rnd2>=9
					akTarget.AddItem(ContraceptionLow, Utility.RandomInt(1,3), true)
				endIf
			else;if rnd2>=3
				akTarget.AddItem(ContraceptionLow, 1, true)
			endIf
		endif
		if rnd3>32
			akTarget.AddItem(CallChildren2,1,true)
		endif
	;endif
endFunction

function GiveItems_DifficultyEasy(actor akTarget)
	if Utility.RandomInt(0,7)>=4
		int rnd1=Utility.RandomInt(0,20)
		int rnd2=Utility.RandomInt(0,20)
		int rnd3=Utility.RandomInt(0,50)
		if rnd1>=6
			if rnd1>=9
				if rnd1>=14
					if rnd1>=18
						akTarget.AddItem(Tampon_Normal, Utility.RandomInt(3,8), true)
					else;if rnd1>=14
						akTarget.AddItem(Tampon_Normal, Utility.RandomInt(2,6), true)
					endIf
				else;if rnd1>=9
					akTarget.AddItem(Tampon_Normal, Utility.RandomInt(1,4), true)
				endIf
			else;if rnd1>=6
				akTarget.AddItem(Tampon_Normal, Utility.RandomInt(1,2), true)
			endIf
		else
			akTarget.AddItem(Tampon_Normal, 1, true)
		endif
		if rnd2>=8
			if rnd2>=12
				if rnd2>=18
					akTarget.AddItem(ContraceptionMid, Utility.RandomInt(1,2), true)
				else;if rnd2>=12
					akTarget.AddItem(ContraceptionLow, Utility.RandomInt(1,3), true)
				endIf
			else;if rnd2>=8
				akTarget.AddItem(ContraceptionLow, 1, true)
			endif
		endIf
		if rnd3>39
			akTarget.AddItem(CallChildren2,1,true)
		endif
	endif
endFunction

function GiveItems_DifficultyNormal(actor akTarget)
	if Utility.RandomInt(0,5)>=4
		int rnd1=Utility.RandomInt(0,20)
		int rnd2=Utility.RandomInt(0,20)
		int rnd3=Utility.RandomInt(0,50)
		if rnd1>=12
			if rnd1>=18
				akTarget.AddItem(Tampon_Normal, Utility.RandomInt(2,4), true)
			else;if rnd1>=12
				akTarget.AddItem(Tampon_Normal, Utility.RandomInt(1,2), true)
			endIf
		else
			akTarget.AddItem(Tampon_Normal, 1, true)
		endif
		if rnd2>=8
			if rnd2>=14
				if rnd2>=19
					akTarget.AddItem(ContraceptionMid, Utility.RandomInt(1,2), true)
				else;if rnd2>=14
					akTarget.AddItem(ContraceptionLow, Utility.RandomInt(1,3), true)
				endIf
			else;if rnd2>=8
				akTarget.AddItem(ContraceptionLow, 1, true)
			endIf
		endif
		if rnd3>45
			akTarget.AddItem(CallChildren2,1,true)
		endif
	endif
endFunction

function GiveItems_DifficultyAdvanced(actor akTarget)
	if Utility.RandomInt(0,9)>=8
		int rnd1=Utility.RandomInt(0,30)
		int rnd2=Utility.RandomInt(0,30)
		int rnd3=Utility.RandomInt(0,50)
		if rnd1>=21
			if rnd1>=27
				akTarget.AddItem(Tampon_Normal, Utility.RandomInt(2,4), true)
			else;if rnd1>=21
				akTarget.AddItem(Tampon_Normal, Utility.RandomInt(1,2), true)
			endIf
		else
			akTarget.AddItem(Tampon_Normal, 1, true)
		endif
		if rnd2>=12
			if rnd2>=23
				if rnd2>=28
					akTarget.AddItem(ContraceptionMid, Utility.RandomInt(1,2), true)
				else;if rnd2>=23
					akTarget.AddItem(ContraceptionLow, Utility.RandomInt(1,3), true)
				endIf
			else;if rnd2>=12
				akTarget.AddItem(ContraceptionLow, 1, true)
			endIf
		endif
		if rnd3>48
			akTarget.AddItem(CallChildren2,1,true)
		endif
	endif
endFunction

function GiveItems_DifficultyHeavy(actor akTarget)
	; On Heavy, no items will be added
endFunction

; 02.06.2019 Tkc (Loverslab) optimizations: Changes marked with "Tkc (Loverslab)" comment