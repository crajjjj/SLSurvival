Scriptname mndSLDelegateScript Extends Quest Conditional

SexLabFramework SexLab
Actor Property PlayerRef Auto
mndController mnd
Actor[] thePlayer

Function doInit()
	if Game.GetModByName("SexLab.esm")!=-1 && Game.GetModByName("SexLab.esm")!=255
		SexLab = Game.GetFormFromFile(0xD62, "SexLab.esm") as SexLabFramework
		mnd = mndController.instance()
	endIf
	if !thePlayer
		thePlayer = new Actor[1]
		thePlayer[0] = PlayerRef
	endIf
endFunction

Event hookSexLabAnim(int tid)
	mnd.lastTimeSex = Utility.GetCurrentGameTime()
	sslThreadController tc = SexLab.GetController(tid)
	if tc.Positions[0]==PlayerRef
		sslBaseAnimation anim = tc.Animation
		if anim.IsOral && anim.hasTag("Blowjob") && (anim.GetCum(0)==2 || anim.GetCum(0)==4 || anim.GetCum(0)==6 || anim.GetCum(0)==7)
			if mnd.enableEat
				mnd.lastTimeEat = Utility.GetCurrentGameTime()
			endIf
		endIf
	endIf
endEvent

function doMasturbation()
	if mnd.noSexInPublic
		Actor looking = None
		Actor[] around = MiscUtil.ScanCellNPCs(PlayerRef)
		int num=around.length
		while num
			num-=1
			Actor a=around[num]
			if a && a!=PlayerRef && !a.isDisabled() && !a.isDead() && a.HasLOS(PlayerRef)
				looking = a
				num=0
			endIf
		endWhile
		if looking
			mnd.showTranslatedString("CantMasturbate")
			PlayerRef.sheatheWeapon()
			if Utility.randomInt(0, 2)==0
				debug.SendAnimationEvent(PlayerRef, "mndHorny")
			else
				debug.SendAnimationEvent(PlayerRef, "IdleForceDefaultState")
			endIf
			return
		endIf
	endIf
	if SexLab.GetGender(PlayerRef)==0
		SexLab.StartSex(thePlayer, SexLab.GetAnimationsByDefault(1, 0, false, false, true), none, none, true, "")
	else
		SexLab.StartSex(thePlayer, SexLab.GetAnimationsByDefault(0, 1, false, false, true), none, none, true, "")
	endIf
endFunction

function removeCum()
	SexLab.ClearCum(PlayerRef)
endFunction



form[] Function StripActor(bool animate, bool full)
 return SexLab.StripActor(PlayerRef, none, animate, LeadIn = !full)
endFunction
 
function UnStripActor(form[] items)
	SexLab.UnstripActor(PlayerRef, items)
endFunction

int function CountCum()
	return SexLab.CountCum(PlayerRef)
endFunction
