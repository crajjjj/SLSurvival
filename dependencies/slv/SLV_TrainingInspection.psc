;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname SLV_TrainingInspection Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Debug.MessageBox("Pike firmly touches your breast, butt and then he moves to your holes. You see his crotch to inflate and feel ashamed noticing that you get wet between your legs. Then he suddenly knocks you on the ground and starts penetrating your ass.")

GetOwningQuest().SetObjectiveCompleted(400)
GetOwningQuest().SetStage(500)

myScripts.SLV_IvanaMoodChange(true,1)
myScripts.SLV_Play2Sex(Game.GetPlayer(),akSpeaker,"Sex", true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto

