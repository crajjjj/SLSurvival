;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_EnslavePC3e Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if MCMMenu.useSexlabVirginity
	bool isVirgin = myScripts.SLV_PlayerIsAVirgin()
	int  isVictim = myScripts.SLV_GetPlayerSexSkill("Victim")

	if isVirgin
		SLV_PlayerIsAVirgin.setValue(1)
	elseif isVictim > 0		
		SLV_PlayerIsAVirgin.setValue(2)
	else
		SLV_PlayerIsAVirgin.setValue(0)
	endif
else
	SLV_PlayerIsAVirgin.setValue(10)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_PlayerIsAVirgin Auto
SLV_MCMMenu Property MCMMenu Auto
SLV_Utilities Property myScripts auto