;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname PSC_Fail_TIF Extends TopicInfo Hidden

PaySexCrimeMCM Property PSC_MCM Auto
GlobalVariable Property Rejected Auto

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;start

	;offer was rejected
	;can player ask again
	if (PSC_MCM.PSC_AllowRetry == false)
		;player cannot ask again
		Rejected.SetValue(1)
		;wait while player moves away before allowing retry
		while (akSpeaker.IsInDialogueWithPlayer())
			Utility.Wait(0.1)
		endWhile
		Rejected.SetValue(0)
	endif

;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;end



;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
