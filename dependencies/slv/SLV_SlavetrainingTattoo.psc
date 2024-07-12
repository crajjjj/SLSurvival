;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SlavetrainingTattoo Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slutmarks", "Cunt (right cheek)", silent = true)
SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (left cheek)", silent = true)
SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (forehead)", silent = true)
SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (left hand)", silent = true)
SlaveTats.simple_add_tattoo(Game.GetPlayer(), "Slave Marks", "Slave (right hand)", silent = true)

SlaveTats.simple_add_tattoo(SLV_Valentina.getactorref(), "Slave Marks", "Slave (left hand)", silent = true)
SlaveTats.simple_add_tattoo(SLV_Valentina.getactorref(), "Slave Marks", "Slave (right hand)", silent = true)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ReferenceAlias Property SLV_Valentina Auto 
SLV_MCMMenu Property MCMMenu Auto
