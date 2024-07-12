Scriptname _DFlowFollowerEvents extends ReferenceAlias  
Bool Property Run auto
_DFGoldConQScript Property GoldCon Auto
Event OnEnterBleedout()
Run = True
Utility.Wait(4)
if Run 
	Run = False
 	if (Q.Getstage() < 100 && Q.Getstage() >= 10)
		GoldCon.FollowerKnockeddown()
		If  Lives.GetValue() as int > 0
			INT a = Lives.getvalue() as INT  - 1
 			Lives.SetValue(a)  
		Else
                    q.PunDebt()
			int temp = Utility.RandomInt(1,10)
			if temp >=4
			MCM.noti("NoL")
			endif
 		endif
	endif
endif
endEvent

GlobalVariable Property Lives  Auto  
QF__Gift_09000D62 Property q  Auto
_DFlowMCM Property MCM Auto