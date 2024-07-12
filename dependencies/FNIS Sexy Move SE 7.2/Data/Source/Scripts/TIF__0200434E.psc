;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__0200434E Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
int i = 5 - akSpeaker.GetItemCount(FNISSMCoin)
if i > 0
	akSpeaker.AddItem(FNISSMCoin,i,true)
elseif i < 0
	akSpeaker.RemoveItem(FNISSMCoin,-i,true)
endif
;akSpeaker.SetAnimationVariableInt("FNISvaa1",5)	
bool bOk = FNIS_aa.SetAnimGroup(akSpeaker, "_mt", FNISSMQuest.FNISsmMtBase, 4, "FNIS Sexy Move", true)		; animvar 1 less than coins
Debug.Trace(akSpeaker.GetItemCount(FNISSMCoin) + " FNISSMCoin given to " + (akSpeaker.GetBaseObject() as ActorBase).GetName(),0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

MiscObject property FNISSMCoin auto
FNISSMQuestScript Property FNISSMQuest Auto