Scriptname _DFCrawlingEffect extends activemagiceffect  

_Dtick Property tick  Auto  
_DFlowMCM Property MCM Auto
zadBoundCombatScript property zbc auto
Int Effect = 0

event OnEffectStart(Actor akActor, Actor akCaster)
	if MCM.FNISCompatibility
	;	Effect = 0
	;	int animSet = 5
		Keyword HB = Keyword.GetKeyword("zad_DeviousHeavyBondage")
		If !Akactor.WornHasKeyword(HB) 
				FNIS_aa.SetAnimGroup(akActor, "_mtidle", tick.mtIdleBase, 0, "DeviousFollowers",true)
				FNIS_aa.SetAnimGroup(akActor, "_mt", tick.mtBase, 0, "DeviousFollowers",true)
				FNIS_aa.SetAnimGroup(akActor, "_mtx", tick.mtxBase, 0, "DeviousFollowers",true)
				FNIS_aa.SetAnimGroup(akActor, "_sneakidle", tick.sneakBase, 0, "DeviousFollowers",true)
				FNIS_aa.SetAnimGroup(akActor, "_sneakmt", tick.sneakmtBase, 0, "DeviousFollowers",true)
				FNIS_aa.SetAnimGroup(akActor, "_h2heqp", tick.h2heqp, 0, "DeviousFollowers", True)
				FNIS_aa.SetAnimGroup(akActor, "_h2hidle", tick.h2hidle, 0, "DeviousFollowers", True)
				FNIS_aa.SetAnimGroup(akActor, "_h2hatkpow", tick.h2hatkpow, 0, "DeviousFollowers", True)
				FNIS_aa.SetAnimGroup(akActor, "_h2hatk", tick.h2hatk, 0, "DeviousFollowers", True)
				FNIS_aa.SetAnimGroup(akActor, "_h2hstag", tick.h2hstag, 0, "DeviousFollowers", True)
				FNIS_aa.SetAnimGroup(akActor, "_jump", tick.jump, 0, "DeviousFollowers", True)
				FNIS_aa.SetAnimGroup(akActor, "_sprint", tick.sprint, 0, "DeviousFollowers", True)
				FNIS_aa.SetAnimGroup(akActor, "_shout", tick.shout1, 0, "DeviousFollowers", True)
				FNIS_aa.SetAnimGroup(akActor, "_mtturn", tick.mtturn, 0, "DeviousFollowers", True)
				Effect = 1
		endif
	endIf
endevent

event OnEffectFinish(Actor akActor, Actor akCaster)
	if MCM.FNISCompatibility
		if Effect == 1
		FNIS_aa.SetAnimGroup(akActor, "_mtidle", 0, 0, "DeviousFollowers",true)
		FNIS_aa.SetAnimGroup(akActor, "_mt", 0, 0, "DeviousFollowers",true)
		FNIS_aa.SetAnimGroup(akActor, "_mtx", 0, 0, "DeviousFollowers",true)
		FNIS_aa.SetAnimGroup(akActor, "_sneakidle", 0, 0, "DeviousFollowers",true)
		FNIS_aa.SetAnimGroup(akActor, "_sneakmt", 0, 0, "DeviousFollowers",true)
		FNIS_aa.SetAnimGroup(akActor, "_h2heqp", 0, 0, "DeviousFollowers", True)
		FNIS_aa.SetAnimGroup(akActor, "_h2hidle", 0, 0, "DeviousFollowers", True)
		FNIS_aa.SetAnimGroup(akActor, "_h2hatkpow", 0, 0, "DeviousFollowers", True)
		FNIS_aa.SetAnimGroup(akActor, "_h2hatk", 0, 0, "DeviousFollowers", True)
		FNIS_aa.SetAnimGroup(akActor, "_h2hstag", 0, 0, "DeviousFollowers", True)
		FNIS_aa.SetAnimGroup(akActor, "_jump", 0, 0, "DeviousFollowers", True)
		FNIS_aa.SetAnimGroup(akActor, "_sprint", 0, 0, "DeviousFollowers", True)
		FNIS_aa.SetAnimGroup(akActor, "_shout", 0, 0, "DeviousFollowers", True)
		FNIS_aa.SetAnimGroup(akActor, "_mtturn",0, 0, "DeviousFollowers", True)
		Effect = 0
		endif
	endIf
endevent