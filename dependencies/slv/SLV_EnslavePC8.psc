;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname SLV_EnslavePC8 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.MessageBox("Pike grabs your breast, butt and then he puts his fingers in your holes. You see his crotch to inflate and feel ashamed noticing that you get wet between your legs. Then he starts inspecting you.")

slaveroutfit.initSlaverSchlongs()

GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(3500)

myScripts.SLV_IvanaMoodChange(false,1)

if SLV_StoryMode.getValue() == 1
	myScripts.SLV_PlayScene(PunishScene)
else
	myScripts.SLV_PlaySex2Synchron(Game.GetPlayer(),akSpeaker , "Sex", true)
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property PunishScene  Auto
SLV_Utilities Property myScripts auto
GlobalVariable Property SLV_StoryMode Auto
SLV_SlaverOutfit Property slaveroutfit auto

