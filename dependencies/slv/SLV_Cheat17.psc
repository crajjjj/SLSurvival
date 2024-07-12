;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_Cheat17 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(9000)

if(SLV_Antislavery.IsRunning() && SLV_Antislavery.getStage() >= 0 && SLV_Antislavery.getStage() < 2000)
	SLV_Antislavery.SetObjectiveCompleted(SLV_Antislavery.getStage())
endif

if SLV_Antislavery.IsRunning()
	SLV_Antislavery.SetStage(2500)
endif

Dremora1.getActorRef().enable()
Thalmor1.getActorRef().enable()

Dremora1.getActorRef().additem(Whip)
Thalmor1.getActorRef().additem(Whip)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Weapon Property Whip Auto
ReferenceAlias Property Dremora1 Auto 
ReferenceAlias Property Thalmor1 Auto 
Quest Property SLV_Antislavery Auto
