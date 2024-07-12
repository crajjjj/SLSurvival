Scriptname _STA_DialogOutput extends ActiveMagicEffect  

_STA_SexDialogUtil Property DialogUtil Auto
_STA_SpankUtil Property SpankUtil Auto
_STA_Mcm Property Menu Auto

SexlabFramework Property Sexlab Auto

Formlist Property _STA_DialogQueue Auto
Formlist Property _STA_DialogQueuePriority Auto

Topic Property _STA_SpankingPlayerDenigrateTopic Auto
Topic Property _STA_SpankingPlayerSpankRequestTopic Auto
Topic Property _STA_PlayerGaggedDialogTopic Auto

ObjectReference Property _STA_PlayerTactRef Auto

Actor Property PlayerRef Auto
ActorBase Property _STA_PlayerDuplicate Auto

Spell Property _STA_SpankPlayerDetectSpell Auto

; No subtitles in freecam mode but since the player dialog is voiced it doesn't matter all that much. 

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If !DialogUtil .DialogOutInProgress
		DialogUtil .DialogOutInProgress = true
		Topic WhatToSay
		Int LastComment
		ObjectReference PlayerSpeaker
		Formlist QueueSelect
		ObjectReference PlayerDuplicate
		While Sexlab.IsActorActive(PlayerRef) || _STA_DialogQueue.GetSize() > 0 || _STA_DialogQueuePriority.GetSize() > 0
			If _STA_DialogQueue.GetSize() > 0 || _STA_DialogQueuePriority.GetSize() > 0
				If Game.GetCameraState() == 3 ; Talking activators don't work in freecam
					If PlayerDuplicate == None
						PlayerDuplicate = PlayerRef.PlaceAtMe(_STA_PlayerDuplicate)
					EndIf
					PlayerDuplicate.MoveTo(PlayerRef, abMatchRotation = true)
					PlayerSpeaker = PlayerDuplicate
				ElseIf Menu.AlwaysUseDummy
					_STA_PlayerTactRef.Enable()
					_STA_PlayerTactRef.MoveTo(PlayerRef, abMatchRotation = true)
					PlayerSpeaker = _STA_PlayerTactRef
				Else
					PlayerSpeaker = PlayerRef as ObjectReference
				EndIf
				
				If _STA_DialogQueuePriority.GetSize() > 0
					QueueSelect = _STA_DialogQueuePriority
					LastComment = QueueSelect.GetSize() - 1 ; New comments are added at zero
					WhatToSay = QueueSelect.GetAt(LastComment) as Topic
					_STA_DialogQueuePriority.RemoveAddedForm(WhatToSay)
				Else
					QueueSelect = _STA_DialogQueue
					LastComment = QueueSelect.GetSize() - 1 ; New comments are added at zero
					WhatToSay = QueueSelect.GetAt(LastComment) as Topic
				EndIf

				Debug.Trace("_STA_: DialogQueue: Q Size: " + QueueSelect.GetSize() + ". Speaking: " + WhatToSay + ". Index: " + QueueSelect.Find(WhatToSay))
				PlayerSpeaker.Say(WhatToSay)
				
				If WhatToSay == _STA_SpankingPlayerDenigrateTopic || (!DialogUtil.IsPlayerMasochist && WhatToSay == _STA_PlayerGaggedDialogTopic)
					DialogUtil.SpankCooldown += DialogUtil.DenigrateTick
					Debug.Trace("_STA_: SpankCooldown: Dirty talk: " + DialogUtil.DenigrateTick)
				ElseIf WhatToSay == _STA_SpankingPlayerSpankRequestTopic || (DialogUtil.IsPlayerMasochist && WhatToSay == _STA_PlayerGaggedDialogTopic && Sexlab.IsActorActive(PlayerRef))
					Utility.Wait(1.0)
					SpankUtil.DoSexSpank(DialogUtil.SexPartner)
					SpankUtil.ModArousal(DialogUtil.SexPartner, 2.0)
				EndIf

				Utility.Wait(2.0)
				If QueueSelect == _STA_DialogQueue
					QueueSelect.RemoveAddedForm(WhatToSay As Form)
				EndIf
				If !_STA_PlayerTactRef.IsDisabled()
					_STA_PlayerTactRef.Disable() ; Otherwise subtitles won't disappear and will begin quickly flickering between all of them (Not in freecam mode and AlwaysUseDummy = true)
				EndIf
			
			Else
				Utility.Wait(0.2)				
			EndIf
		EndWhile
		_STA_DialogQueue.Revert()
		_STA_DialogQueuePriority.Revert()
		DialogUtil .DialogOutInProgress = false
		If PlayerDuplicate
			PlayerDuplicate.Disable()
			PlayerDuplicate.Delete()
		EndIf
		_STA_PlayerTactRef.Disable()
	EndIf
EndEvent
