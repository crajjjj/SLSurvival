Scriptname FWContraceptionItem extends FWSpell 

;FWSystem property System auto

Imagespacemodifier property iModContraception0 auto
Imagespacemodifier property iModContraception1 auto
Imagespacemodifier property iModContraception2 auto
Imagespacemodifier property iModContraception3 auto
Imagespacemodifier property iModContraception4 auto
Imagespacemodifier property iModContraception5 auto
Imagespacemodifier property iModContraception6 auto
Imagespacemodifier property iModContraception7 auto
Imagespacemodifier property iModContraception8 auto
Imagespacemodifier property iModContraception9 auto

actor ActorRef
bool bInit=false

Actor Property PlayerRef Auto

function execute()

	if bInit==false || ActorRef==none
		return
	endif
	float mag = GetMagnitude()
	if mag <2
		mag=2
	endif
	if ActorRef==PlayerRef && mag >2
		float f=1.0 - (FWUtility.floatModulo(mag,10.0)/30)
		if mag < 80
			if mag < 40
				if mag < 20
					if mag<10
						iModContraception0.apply(f)
					else;if mag<20
						iModContraception1.apply(f)
					endIf
				else
					if mag<30
						iModContraception2.apply(f)
					else;if mag<40
						iModContraception3.apply(f)
					endIf
				endIf
			else
				if mag < 60
					if mag<50
						iModContraception4.apply(f)
					else;if mag<60
						iModContraception5.apply(f)
					endIf
				else
					if mag<70
						iModContraception6.apply(f)
					else;if mag<80
						iModContraception7.apply(f)
					endIf
				endIf
			endIf
		else
			if mag<90
				iModContraception8.apply(f)
			else
				iModContraception9.apply(f)
			endif
		endIf
	endif
	Controller.AddContraception(ActorRef, mag)
	Controller.DamageBaby(ActorRef, mag)
endfunction

Event OnWoman(Actor akTarget, Actor akCaster)
	ActorRef = akCaster
	execute()
endEvent

Event OnInit()
	bInit=true
	parent.OnInit()
	execute()
endEvent