;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__02001D92 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int n = akSpeaker.GetItemCount(FNISSMCoin)
If ( n == 0 )
;	int av1 = akSpeaker.GetAnimationVariableInt("FNISvaa_FNISSexyMove")
	n = akSpeaker.GetAnimationVariableInt("FNISaa_mt") - FNISSMQuest.FNISsmMtBase + 1
	if n > 9
		n = 0
	endif
endIf
If ( n > 0 )
	Debug.Notification("FNIS Sexy Move using: " + n )
endIf

;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject property FNISSMCoin Auto 
FNISSMQuestScript Property FNISSMQuest Auto