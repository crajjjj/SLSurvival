Scriptname SLV_ReviveNPC extends Quest  

function resurrectNPC_Mainquest()
Int oldNPCs= NPCResurrect_Mainquest.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_Mainquest[oldNPCs])

	;if NPCResurrect_Mainquest[oldNPCs].isdead()
	;	NPCResurrect_Mainquest[oldNPCs].resurrect()
	;endif
	;NPCResurrect_Mainquest[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_Mainquest Auto


function resurrectNPC_Whiterun()
Int oldNPCs= NPCResurrect_Whiterun.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_Whiterun[oldNPCs])

	;if NPCResurrect_Whiterun[oldNPCs].isdead()
	;	NPCResurrect_Whiterun[oldNPCs].resurrect()
	;endif	
	;NPCResurrect_Whiterun[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_Whiterun Auto


function resurrectNPC_Riverwood()
Int oldNPCs= NPCResurrect_Riverwood.Length
While oldNPCs
	oldNPCs-= 1	
	checkNPC(NPCResurrect_Riverwood[oldNPCs])

	if NPCResurrect_Riverwood[oldNPCs].isdead()
		NPCResurrect_Riverwood[oldNPCs].resurrect()
	endif
	NPCResurrect_Riverwood[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_Riverwood Auto


function resurrectNPC_Falkreath()
Int oldNPCs= NPCResurrect_Falkreath.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_Falkreath[oldNPCs])

	if NPCResurrect_Falkreath[oldNPCs].isdead()
		NPCResurrect_Falkreath[oldNPCs].resurrect()
	endif
	NPCResurrect_Falkreath[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_Falkreath Auto


function resurrectNPC_Dawnstar()
Int oldNPCs= NPCResurrect_Dawnstar.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_Dawnstar[oldNPCs])

	if NPCResurrect_Dawnstar[oldNPCs].isdead()
		NPCResurrect_Dawnstar[oldNPCs].resurrect()
	endif
	NPCResurrect_Dawnstar[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_Dawnstar Auto


function resurrectNPC_Markarth()
Int oldNPCs= NPCResurrect_Markarth.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_Markarth[oldNPCs])

	if NPCResurrect_Markarth[oldNPCs].isdead()
		NPCResurrect_Markarth[oldNPCs].resurrect()
	endif
	NPCResurrect_Markarth[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_Markarth Auto


function resurrectNPC_Riften()
Int oldNPCs= NPCResurrect_Riften.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_Riften[oldNPCs])

	if NPCResurrect_Riften[oldNPCs].isdead()
		NPCResurrect_Riften[oldNPCs].resurrect()
	endif
	NPCResurrect_Riften[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_Riften Auto


function resurrectNPC_Morthal()
Int oldNPCs= NPCResurrect_Morthal.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_Morthal[oldNPCs])

	if NPCResurrect_Morthal[oldNPCs].isdead()
		NPCResurrect_Morthal[oldNPCs].resurrect()
	endif
	NPCResurrect_Morthal[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_Morthal Auto


function resurrectNPC_Windhelm()
Int oldNPCs= NPCResurrect_Windhelm.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_Windhelm[oldNPCs])

	if NPCResurrect_Windhelm[oldNPCs].isdead()
		NPCResurrect_Windhelm[oldNPCs].resurrect()
	endif
	NPCResurrect_Windhelm[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_Windhelm Auto


function resurrectNPC_Solitude()
Int oldNPCs= NPCResurrect_Solitude.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_Solitude[oldNPCs])

	if NPCResurrect_Solitude[oldNPCs].isdead()
		NPCResurrect_Solitude[oldNPCs].resurrect()
	endif
	NPCResurrect_Solitude[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_Solitude Auto



function resurrectNPC_RavenRock()
Int oldNPCs= NPCResurrect_RavenRock.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_RavenRock[oldNPCs])

	if NPCResurrect_RavenRock[oldNPCs].isdead()
		NPCResurrect_RavenRock[oldNPCs].resurrect()
	endif
	NPCResurrect_RavenRock[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_RavenRock Auto



function resurrectNPC_MainquestSpecial1()
Int oldNPCs= NPCResurrect_MainquestSpecial1.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_MainquestSpecial1[oldNPCs])

	if NPCResurrect_MainquestSpecial1[oldNPCs].isdead()
		NPCResurrect_MainquestSpecial1[oldNPCs].resurrect()
	endif
	NPCResurrect_MainquestSpecial1[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_MainquestSpecial1 Auto


function resurrectNPC_MainquestSpecial2()
Int oldNPCs= NPCResurrect_MainquestSpecial2.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_MainquestSpecial2[oldNPCs])

	if NPCResurrect_MainquestSpecial2[oldNPCs].isdead()
		NPCResurrect_MainquestSpecial2[oldNPCs].resurrect()
	endif
	NPCResurrect_MainquestSpecial2[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_MainquestSpecial2 Auto


function resurrectNPC_MainquestSpecial3()
Int oldNPCs= NPCResurrect_MainquestSpecial3.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_MainquestSpecial3[oldNPCs])

	if NPCResurrect_MainquestSpecial3[oldNPCs].isdead()
		NPCResurrect_MainquestSpecial3[oldNPCs].resurrect()
	endif
	NPCResurrect_MainquestSpecial3[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_MainquestSpecial3 Auto


function resurrectNPC_MainquestSpecial4()
Int oldNPCs= NPCResurrect_MainquestSpecial4.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_MainquestSpecial4[oldNPCs])

	if NPCResurrect_MainquestSpecial4[oldNPCs].isdead()
		NPCResurrect_MainquestSpecial4[oldNPCs].resurrect()
	endif
	NPCResurrect_MainquestSpecial4[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_MainquestSpecial4 Auto


function resurrectNPC_MainquestSpecial5()
Int oldNPCs= NPCResurrect_MainquestSpecial5.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_MainquestSpecial5[oldNPCs])

	if NPCResurrect_MainquestSpecial5[oldNPCs].isdead()
		NPCResurrect_MainquestSpecial5[oldNPCs].resurrect()
	endif
	NPCResurrect_MainquestSpecial5[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_MainquestSpecial5 Auto


function resurrectNPC_MainquestSpecial6()
Int oldNPCs= NPCResurrect_MainquestSpecial6.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_MainquestSpecial6[oldNPCs])

	if NPCResurrect_MainquestSpecial6[oldNPCs].isdead()
		NPCResurrect_MainquestSpecial6[oldNPCs].resurrect()
	endif
	NPCResurrect_MainquestSpecial6[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_MainquestSpecial6 Auto


function resurrectNPC_MainquestSpecial7()
Int oldNPCs= NPCResurrect_MainquestSpecial7.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_MainquestSpecial7[oldNPCs])

	if NPCResurrect_MainquestSpecial7[oldNPCs].isdead()
		NPCResurrect_MainquestSpecial7[oldNPCs].resurrect()
	endif
	NPCResurrect_MainquestSpecial7[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_MainquestSpecial7 Auto

function resurrectNPC_MainquestSpecial8()
Int oldNPCs= NPCResurrect_MainquestSpecial8.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_MainquestSpecial8[oldNPCs])

	if NPCResurrect_MainquestSpecial8[oldNPCs].isdead()
		NPCResurrect_MainquestSpecial8[oldNPCs].resurrect()
	endif
	NPCResurrect_MainquestSpecial8[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_MainquestSpecial8 Auto

function resurrectNPC_MainquestSpecial10()
Int oldNPCs= NPCResurrect_MainquestSpecial10.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_MainquestSpecial10[oldNPCs])

	if NPCResurrect_MainquestSpecial10[oldNPCs].isdead()
		NPCResurrect_MainquestSpecial10[oldNPCs].resurrect()
	endif
	NPCResurrect_MainquestSpecial10[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_MainquestSpecial10 Auto


function resurrectNPC_Wedding()
Int oldNPCs= NPCResurrect_Wedding.Length
While oldNPCs
	oldNPCs-= 1
	checkNPC(NPCResurrect_Wedding[oldNPCs])

	if NPCResurrect_Wedding[oldNPCs].isdead()
		NPCResurrect_Wedding[oldNPCs].resurrect()
	endif
	NPCResurrect_Wedding[oldNPCs].getActorbase().setessential(true)
EndWhile
endfunction
Actor[] Property NPCResurrect_Wedding Auto


function checkNPC(Actor NPCActor)
	ActorBase NPCActorBase = NPCActor.getActorbase()
	myScripts.SLV_DisplayInformation("Resurrect check for :" + NPCActorBase.getName())
	if NPCActor.isdead()
		myScripts.SLV_DisplayInformation(NPCActorBase.getName() + " is dead")
		NPCActor.resurrect()
		NPCActor.moveto(Game.GetPlayer())
	endif
	NPCActorBase.setessential(true)
endfunction

SLV_Utilities Property myScripts auto

