;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Enslavement17 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(3000)
GetOwningQuest().SetStage(3500)

;SendModEvent("yps-LockMakeupEvent")
SendModEvent("yps-PermanentMakeupEvent")
SendModEvent("yps-DisableSmudgingEvent")
;Utility.wait(2.0)

;SendModEvent("yps-LipstickEvent", "Dark Red", 0x8b0000)  
SendModEvent("yps-LipstickEvent", "Black" , 0)  
Utility.wait(2.0)
    
SendModEvent("yps-EyeshadowEvent","Black" , 0)    
; apply makeup: send name of color as string (e.g. "red"), and ColorRGBCode as a 0xRRGGBB value.
Utility.wait(2.0)


SendModEvent("yps-FingerNailsEvent", "", 2) 
Utility.wait(2.0)

SendModEvent("yps-ToeNailsEvent",  "", 2)
Utility.wait(2.0)


SendModEvent("yps-PiercingEvent", akSpeaker.getActorBase().getName() ,1)
SendModEvent("yps-PiercingEvent", akSpeaker.getActorBase().getName() ,2)
SendModEvent("yps-PiercingEvent", akSpeaker.getActorBase().getName() ,3)
SendModEvent("yps-PiercingEvent", akSpeaker.getActorBase().getName() ,4)
SendModEvent("yps-PiercingEvent", akSpeaker.getActorBase().getName() ,5)
SendModEvent("yps-PiercingEvent", akSpeaker.getActorBase().getName() ,6)
SendModEvent("yps-PiercingEvent", akSpeaker.getActorBase().getName() ,7)
SendModEvent("yps-PiercingEvent", akSpeaker.getActorBase().getName() ,8)
SendModEvent("yps-PiercingEvent", akSpeaker.getActorBase().getName() ,9)
SendModEvent("yps-PiercingEvent", akSpeaker.getActorBase().getName() ,10)
SendModEvent("yps-PiercingEvent", akSpeaker.getActorBase().getName() ,11)

Utility.wait(2.0)
myScripts.SLV_DeviousUnEquip(true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)
Utility.wait(2.0)

bool equipGag = false
bool equipPlugs = true
bool equipHarness = false
bool equipBelt = false
bool equipBra = false
bool equipCollar = true
bool equipCuffs = true
bool equipArmbinder = true
bool equipYoke = false
bool equipBlindfold = false
bool equipNPiercings = true
bool equipVPiercings = true
bool equipBoots = true
bool equipGloves = true
bool equipCorset = true

myScripts.SLV_DeviousEquip(equipGag,equipPlugs,equipHarness,equipBelt,equipBra,equipCollar,equipCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto