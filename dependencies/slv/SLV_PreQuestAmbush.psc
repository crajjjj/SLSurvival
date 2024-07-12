Scriptname SLV_PreQuestAmbush extends ObjectReference  

Event OnTriggerEnter(ObjectReference akActionRef)
If akActionRef == Game.GetPlayer() ; This condition ensures that only the player will trigger this code
	If RunOnce == 0
		Debug.Notification("Someone is approaching...")
		RunOnce = 1

		bandit1.enable()
		bandit1.StartCombat(Game.getplayer())

		bandit2.enable()
		bandit2.StartCombat(Game.getplayer())

		waypoint.enable()

		Utility.wait(20)

		SLV_Prequest_1.SetObjectiveCompleted(4500)
		SLV_Prequest_1.setstage(5000)
	EndIf
EndIf

EndEvent

Int RunOnce

Actor Property bandit1 Auto
Actor Property bandit2 Auto
ObjectReference Property waypoint auto

Quest Property SLV_Prequest_1 auto