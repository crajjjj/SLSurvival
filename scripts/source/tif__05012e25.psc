;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__05012E25 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
actor[] sexActors = new actor[2]
SexActors[0] = PlayerRef
SexActors[1] = akSpeaker
String animationTags
String supressTags
animationTags = "Oral,Blowjob,Dog"
supressTags = "Cunninglingus"
sslBaseAnimation[] animations = SexLab.GetCreatureAnimationsByTags(2, animationTags, TagSuppress = supressTags)
Sexlab.StartSex(sexActors, animations)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

SexLabFramework Property SexLab Auto
Actor Property PlayerRef Auto
