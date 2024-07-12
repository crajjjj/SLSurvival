Scriptname SLV_SwapAllJarls extends Quest  

function updateAllJarls()
	;Debug.notification("Whiterun...")
	if JarlWhiterun1.GetActorRef().IsInFaction(JobJarlFaction ) == 1
		JarlWhiterun.ForceRefTo(JarlWhiterun1.GetActorRef())
		mainquest.isWhiterunImperial = true
	else
		JarlWhiterun.ForceRefTo(JarlWhiterun2.GetActorRef())
		mainquest.isWhiterunImperial = false 
	endif
	;MiscUtil.PrintConsole("Jarl of Whiterun = " + JarlWhiterun.GetActorRef().getActorBase().getName())

	;Debug.notification("Falkreath...")
	if JarlFalkreath1.GetActorRef().IsInFaction(JobJarlFaction ) == 1
		JarlFalkreath.ForceRefTo(JarlFalkreath1.GetActorRef())
		JarlFalkreHCarl.ForceRefTo(JarlFalkreHCarl1.GetActorRef())
	else
		JarlFalkreath.ForceRefTo(JarlFalkreath2.GetActorRef())
		JarlFalkreHCarl.ForceRefTo(JarlFalkreHCarl2.GetActorRef())
	endif
	;MiscUtil.PrintConsole("Jarl of Falkreath= " + JarlFalkreath.GetActorRef().getActorBase().getName())
	;MiscUtil.PrintConsole("Housecarl of Falkreath= " + JarlFalkreHCarl.GetActorRef().getActorBase().getName())

	;Debug.notification("Dawnstar...")
	if JarlDawnstar1.GetActorRef().IsInFaction(JobJarlFaction ) == 1
		JarlDawnstar.ForceRefTo(JarlDawnstar1.GetActorRef())
		JarlDawnsHCarl.ForceRefTo(JarlDawnsHCarl1.GetActorRef())
	else
		JarlDawnstar.ForceRefTo(JarlDawnstar2.GetActorRef())
		JarlDawnsHCarl.ForceRefTo(JarlDawnsHCarl2.GetActorRef())
	endif
	;MiscUtil.PrintConsole("Jarl of Dawnstar= " + JarlDawnstar.GetActorRef().getActorBase().getName())
	;MiscUtil.PrintConsole("Housecarl of Dawnstar= " + JarlDawnsHCarl.GetActorRef().getActorBase().getName())

	;Debug.notification("Markarth...")
	if JarlMarkarth1.GetActorRef().IsInFaction(JobJarlFaction ) == 1
		JarlMarkarth.ForceRefTo(JarlMarkarth1.GetActorRef())
		JarlMarkaHCarl.ForceRefTo(JarlMarkaHCarl1.GetActorRef())
	else
		JarlMarkarth.ForceRefTo(JarlMarkarth2.GetActorRef())
		JarlMarkaHCarl.ForceRefTo(JarlMarkaHCarl2.GetActorRef())
	endif
	;MiscUtil.PrintConsole("Jarl of Markarth= " + JarlMarkarth.GetActorRef().getActorBase().getName())
	;MiscUtil.PrintConsole("Housecarl of Markarth= " + JarlMarkaHCarl.GetActorRef().getActorBase().getName())

	;Debug.notification("Riften...")
	if JarlRiften1.GetActorRef().IsInFaction(JobJarlFaction ) == 1
		JarlRiften.ForceRefTo(JarlRiften1.GetActorRef())
	else
		JarlRiften.ForceRefTo(JarlRiften2.GetActorRef())
	endif
	;MiscUtil.PrintConsole("Jarl of Riftenl= " + JarlRiften.GetActorRef().getActorBase().getName())

	;Debug.notification("Morthal...")
	if JarlMorthal1.GetActorRef().IsInFaction(JobJarlFaction ) == 1
		JarlMorthal.ForceRefTo(JarlMorthal1.GetActorRef())
	else
		JarlMorthal.ForceRefTo(JarlMorthal2.GetActorRef())
	endif
	;MiscUtil.PrintConsole("Jarl of Morthal= " + JarlMorthal.GetActorRef().getActorBase().getName())

	;Debug.notification("Winterhold...")
	if JarlWinterhold1.GetActorRef().IsInFaction(JobJarlFaction ) == 1
		JarlWinterhold.ForceRefTo(JarlWinterhold1.GetActorRef())
	else
		JarlWinterhold.ForceRefTo(JarlWinterhold2.GetActorRef())
	endif
	;MiscUtil.PrintConsole("Jarl of Winterhold= " + JarlWinterhold.GetActorRef().getActorBase().getName())

	;Debug.notification("Windhelm...")
	if JarlWindhelm1.GetActorRef().IsInFaction(JobJarlFaction ) == 1
		JarlWindhelm.ForceRefTo(JarlWindhelm1.GetActorRef())
	else
		JarlWindhelm.ForceRefTo(JarlWindhelm2.GetActorRef())
	endif
	;MiscUtil.PrintConsole("Jarl of Windhelm= " + JarlWindhelm.GetActorRef().getActorBase().getName())

	;Debug.notification("Solitude...")
	if GeneralSolitude1.GetActorRef().IsDead() ;|| civilwar.iscompleted()
		GeneralSolitude.ForceRefTo(GeneralSolitude2.GetActorRef())
	else
		GeneralSolitude.ForceRefTo(GeneralSolitude1.GetActorRef())
	endif
	;MiscUtil.PrintConsole("Genearl of Solitude= " + GeneralSolitude.GetActorRef().getActorBase().getName())
endfunction

ReferenceAlias Property JarlWhiterun Auto
ReferenceAlias Property JarlWhiterun1 Auto
ReferenceAlias Property JarlWhiterun2 Auto

ReferenceAlias Property JarlFalkreath Auto
ReferenceAlias Property JarlFalkreath1 Auto
ReferenceAlias Property JarlFalkreath2 Auto

ReferenceAlias Property JarlFalkreHCarl Auto
ReferenceAlias Property JarlFalkreHCarl1 Auto
ReferenceAlias Property JarlFalkreHCarl2 Auto

ReferenceAlias Property JarlDawnstar Auto
ReferenceAlias Property JarlDawnstar1 Auto
ReferenceAlias Property JarlDawnstar2 Auto

ReferenceAlias Property JarlDawnsHCarl Auto
ReferenceAlias Property JarlDawnsHCarl1 Auto
ReferenceAlias Property JarlDawnsHCarl2 Auto

ReferenceAlias Property JarlMarkarth Auto
ReferenceAlias Property JarlMarkarth1 Auto
ReferenceAlias Property JarlMarkarth2 Auto

ReferenceAlias Property JarlMarkaHCarl Auto
ReferenceAlias Property JarlMarkaHCarl1 Auto
ReferenceAlias Property JarlMarkaHCarl2 Auto

ReferenceAlias Property JarlRiften Auto
ReferenceAlias Property JarlRiften1 Auto
ReferenceAlias Property JarlRiften2 Auto

ReferenceAlias Property JarlMorthal Auto
ReferenceAlias Property JarlMorthal1 Auto
ReferenceAlias Property JarlMorthal2 Auto

ReferenceAlias Property JarlWinterhold Auto
ReferenceAlias Property JarlWinterhold1 Auto
ReferenceAlias Property JarlWinterhold2 Auto

ReferenceAlias Property JarlWindhelm Auto
ReferenceAlias Property JarlWindhelm1 Auto
ReferenceAlias Property JarlWindhelm2 Auto

ReferenceAlias Property GeneralSolitude Auto
ReferenceAlias Property GeneralSolitude1 Auto
ReferenceAlias Property GeneralSolitude2 Auto

Faction Property JobJarlFaction Auto
Quest Property civilwar Auto

SLV_SoftDependency Property mainquest auto
