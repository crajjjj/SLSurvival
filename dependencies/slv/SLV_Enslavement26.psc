;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname SLV_Enslavement26 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(5000)
GetOwningQuest().SetStage(6000)

SlaveTats.simple_remove_tattoo(Game.GetPlayer(), "Slutmarks", "Cunt (right cheek)", silent = true)
SlaveTats.simple_remove_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (left cheek)", silent = true)
SlaveTats.simple_remove_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (forehead)", silent = true)
SlaveTats.simple_remove_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (left hand)", silent = true)
SlaveTats.simple_remove_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (right hand)", silent = true)

SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slutmarks", "Cunt (right cheek)", silent = true)
SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (left cheek)", silent = true)
SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (forehead)", silent = true)
SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (left hand)", silent = true)
SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (right hand)", silent = true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
