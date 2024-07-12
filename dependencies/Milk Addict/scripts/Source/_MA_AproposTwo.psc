Scriptname _MA_AproposTwo extends Quest  

Function IF_AproposHeal(Alias AproposAlias, Int HealAmount)
	Apropos2ActorAlias AproposScript = AproposAlias as Apropos2ActorAlias
	If AproposScript.ActorRef == PlayerRef
		Debug.Trace("_MA_: Applying apropos W&T healing of " + HealAmount)
		AproposScript.ApplyReducedVaginalWearAndTearAmount(healAmount)
		AproposScript.ApplyReducedAnalWearAndTearAmount(healAmount)
		AproposScript.ApplyReducedOralWearAndTearAmount(healAmount)

		AproposScript.ApplyReducedVaginalAbuseWearAndTearAmount(healAmount)
		AproposScript.ApplyReducedAnalAbuseWearAndTearAmount(healAmount)
		AproposScript.ApplyReducedOralAbuseWearAndTearAmount(healAmount)
		AproposScript.ApplyEffectsAndTextures(increasingAbuse=False)

		If AproposScript.Config.ConsumablesIncreaseArousal 
			UpdateActorArousalExposure(PlayerRef)
			sslBaseVoice voice = SexLab.PickVoice(PlayerRef)
			voice.Moan(PlayerRef, 10, False)
		EndIf
	Else
		Debug.Trace("_MA_: _MA_Apropos - ActorRef != PlayerRef")
	EndIf
EndFunction

Function UpdateActorArousalExposure(Actor anActor, Float amount = 2.0) Global
    Int eid = ModEvent.Create("slaUpdateExposure")
    ModEvent.PushForm(eid, anActor)
    ModEvent.PushFloat(eid, amount)
    ModEvent.Send(eid)
EndFunction

SexLabFramework Property SexLab Auto
Actor Property PlayerRef Auto