;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColdharbourSex10 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
actor[] sexActors = new actor[2]
sexActors[0] = Game.GetPlayer()
sexActors[1] = akSpeaker

myScripts.SLV_decreaseWeight()
myScripts.SLV_PlaySexAnimationSynchron(sexActors,"FunnyBizness Molag Snuff Vamp","Sex", true)
myScripts.SLV_decreaseWeight()

int amputation = 0
SLV_AmputeePlayer.setValue(amputation)
Amputee.SLV_AmputeeActor(Game.GetPlayer(), amputation)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Amputee Property Amputee Auto
GlobalVariable Property SLV_AmputeePlayer Auto 
SLV_Utilities Property myScripts auto