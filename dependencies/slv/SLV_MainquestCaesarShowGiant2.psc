;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestCaesarShowGiant2 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SLV_ArenaShowTask.Reset() 
SLV_ArenaShowTask.Start() 
SLV_ArenaShowTask.SetActive(true) 
SLV_ArenaShowTask.SetStage(0)

SLV_Animal1.Clear()
SLV_Animal2.Clear()
SLV_Animal3.Clear()
SLV_Animal4.Clear()
SLV_Animal5.Clear()
SLV_Animal6.Clear()
SLV_Animal7.Clear()
SLV_Animal8.Clear()
SLV_Animal9.Clear()

SLV_Animal1.ForceRefTo(SLV_Dog1)
SLV_Animal2.ForceRefTo(SLV_Dog2)
SLV_Animal3.ForceRefTo(SLV_Dog3)
SLV_Animal4.ForceRefTo(SLV_Dog4)
SLV_Animal5.ForceRefTo(SLV_Dog5)
SLV_Animal6.ForceRefTo(SLV_Dog6)
SLV_Animal7.ForceRefTo(SLV_Dog7)
SLV_Animal8.ForceRefTo(SLV_Dog8)
SLV_Animal9.ForceRefTo(SLV_Dog9)

SLV_ColosseumBeast.setValue(14)
SLV_ColosseumBeastsNumber.setValue(9)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property SLV_ColosseumBeastsNumber Auto
Actor Property SLV_Dog1 Auto
ReferenceAlias Property SLV_Animal1 Auto
Actor Property SLV_Dog2 Auto
ReferenceAlias Property SLV_Animal2 Auto
Actor Property SLV_Dog3 Auto
ReferenceAlias Property SLV_Animal3 Auto
Actor Property SLV_Dog4 Auto
ReferenceAlias Property SLV_Animal4 Auto
Actor Property SLV_Dog5 Auto
ReferenceAlias Property SLV_Animal5 Auto
Actor Property SLV_Dog6 Auto
ReferenceAlias Property SLV_Animal6 Auto
Actor Property SLV_Dog7 Auto
ReferenceAlias Property SLV_Animal7 Auto
Actor Property SLV_Dog8 Auto
ReferenceAlias Property SLV_Animal8 Auto
Actor Property SLV_Dog9 Auto
ReferenceAlias Property SLV_Animal9 Auto

GlobalVariable Property SLV_ColosseumBeast Auto
Quest Property SLV_ArenaShowTask Auto
