Scriptname FWAbilityFever extends FWSpell  

;FWSystem property System auto
actor ActorRef
bool IsPlayer = false
float Interval = 0.4
int SkipChance = 20

Actor Property PlayerRef Auto
ImageSpaceModifier Property AbortusFever Auto

Event OnWoman(Actor akTarget, Actor akCaster)
	IsPlayer = akTarget==PlayerRef
	ActorRef=akTarget
	CastMe()
endEvent

Event OnMan(Actor akTarget, Actor akCaster)
	Dispel()
endEvent

Event OnUpdateGameTime()
	CastMe()
endEvent

function CastMe()
;	if Utility.RandomInt(0,100)>SkipChance
	if(Utility.RandomInt(1, 100) > SkipChance)
		if SkipChance<70
			SkipChance+=Utility.RandomInt(0,2)
		endif
		if IsPlayer
			AbortusFever.Apply(Utility.RandomFloat(0.3,1.0))
		endif
	endif
	if Interval<2
		Interval+=Utility.RandomFloat(0.1,0.6)
	else
		Dispel()
	endif
	RegisterForSingleUpdateGameTime(Interval)
endfunction