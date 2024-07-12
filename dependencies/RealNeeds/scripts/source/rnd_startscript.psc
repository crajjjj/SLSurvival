Scriptname RND_StartScript extends Quest

Actor Property PlayerREF Auto
Spell Property RND_Maintenance Auto
GlobalVariable Property RND_DisableWeightGlobal Auto
GlobalVariable Property RND_DefaultWeightGlobal Auto
GlobalVariable Property RND_CurrentWeightGlobal Auto
Bool DoOnce = false

Event OnInit()

	RND_Maintenance.Cast(Game.GetPlayer(), Game.GetPlayer())
	If DoOnce == false
		RND_DefaultWeightGlobal.SetValue(Game.GetPlayer().GetActorBase().GetWeight() as float)
		DoOnce = true
	EndIf	
	Maintenance()	
	
EndEvent

Event OnPlayerLoadGame()

	If DoOnce == false
		RND_DefaultWeightGlobal.SetValue(Game.GetPlayer().GetActorBase().GetWeight() as float)
		DoOnce = true
	EndIf	
	Maintenance()
	
EndEvent

Function Maintenance()

	If RND_DisableWeightGlobal.GetValueInt() == 1
		Game.GetPlayer().GetActorBase().SetWeight(RND_CurrentWeightGlobal.GetValue())
		If !PlayerREF.IsOnMount()
			PlayerREF.QueueNiNodeUpdate()
		EndIf		
	ElseIf RND_DisableWeightGlobal.GetValueInt() == 0
		Game.GetPlayer().GetActorBase().SetWeight(RND_DefaultWeightGlobal.GetValue())
	EndIf

EndFunction
