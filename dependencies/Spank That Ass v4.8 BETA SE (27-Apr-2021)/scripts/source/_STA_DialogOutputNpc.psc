Scriptname _STA_DialogOutputNpc extends ActiveMagicEffect  

_STA_SexDialogUtil Property DialogUtil Auto
_STA_SpankUtil Property SpankUtil Auto
_STA_Mcm Property Menu Auto

SexlabFramework Property Sexlab Auto

Actor Property PlayerRef Auto
ActorBase Property _STA_NpcDuplicate Auto

Faction Property _STA_RapeDialogFaction Auto

ObjectReference Property _STA_NpcTactRef Auto

ObjectReference DummyNpc

Spell Property _STA_DialogOutputNpcKeywordSpell Auto

; There are no subtitles in freecam mode and since the npc dialog isn't voiced we need to use notifications

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Topic WhatToSay = DialogUtil.DummyNpcWhatToSay
	ObjectReference TalkingActor
	
	_STA_NpcTactRef.GetBaseObject().SetName(akTarget.GetBaseObject().GetName())
	While Sexlab.IsActorActive(PlayerRef) || DialogUtil.DummyNpcWhatToSay != None
		WhatToSay = DialogUtil.DummyNpcWhatToSay
		If WhatToSay != None
			DialogUtil.DummyNpcWhatToSay = None
			akTarget.AddToFaction(_STA_RapeDialogFaction)

			If Menu.AlwaysUseDummy ; Use talking activator to say it
				TalkingActor = _STA_NpcTactRef
				_STA_NpcTactRef.Enable()
				
				TalkingActor.MoveTo(akTarget, abMatchRotation = true)
			
			Else ; Get Npc to say it themselves
				TalkingActor = akTarget
				akTarget.AddSpell(_STA_DialogOutputNpcKeywordSpell)
			EndIf

			Utility.Wait(0.5)
			Debug.Trace("_STA_: NpcRapeDialog. TalkingActor: " + TalkingActor + ". Speaking: " + WhatToSay;/ + ". HasMagicEffectWithKeyword: " + akTarget.HasMagicEffectWithKeyword(Game.GetFormFromFile(0x01B44E, "Update.esm") as Keyword)/;)
			;Debug.Messagebox(akTarget + "\nHasMagicKeyword: " + akTarget.HasMagicEffectWithKeyword(Game.GetFormFromFile(0x01B44E, "Update.esm") as Keyword))

			TalkingActor.Say(WhatToSay)
			If Game.GetCameraState() == 3 ; Use debug notifications - No subtitles during free cam at all
				Debug.Notification(akTarget.GetBaseObject().GetName() + ": " + DialogUtil.NpcDialogAsString)
			EndIf

			Utility.Wait(3.0)
			If !_STA_NpcTactRef.IsDisabled()
				_STA_NpcTactRef.Disable() ; Otherwise subtitles won't disappear and will begin quickly flickering between all of them (Not in freecam mode and AlwaysUseDummy = true)
			EndIf
			Utility.Wait(8.5)
			DialogUtil.NpcDialogOutInProgress = false

		Else
			Utility.Wait(0.5)
		EndIf
	EndWhile
	If DummyNpc
		DummyNpc.Disable()
		DummyNpc.Delete()
	EndIf
	_STA_NpcTactRef.Disable()
	akTarget.RemoveFromFaction(_STA_RapeDialogFaction)
	akTarget.RemoveSpell(_STA_DialogOutputNpcKeywordSpell)
	akTarget.EvaluatePackage()
EndEvent
