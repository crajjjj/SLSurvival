;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSoftEvent3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor player = Game.GetPlayer()
SlaveTats.simple_remove_tattoo(player , "Slutmarks", "Cunt (right cheek)", silent = true)
SlaveTats.simple_remove_tattoo(player , "Slave Marks", "Slave (left cheek)", silent = true)
SlaveTats.simple_remove_tattoo(player , "Slave Marks", "Slave (forehead)", silent = true)
SlaveTats.simple_remove_tattoo(player , "Slave Marks", "Slave (left hand)", silent = true)
SlaveTats.simple_remove_tattoo(player , "Slave Marks", "Slave (right hand)", silent = true)

SlaveTats.simple_add_tattoo(player , "Slutmarks", "Cunt (right cheek)", silent = true)
SlaveTats.simple_add_tattoo(player , "Slave Marks", "Slave (left cheek)", silent = true)
SlaveTats.simple_add_tattoo(player , "Slave Marks", "Slave (forehead)", silent = true)
SlaveTats.simple_add_tattoo(player , "Slave Marks", "Slave (left hand)", silent = true)
SlaveTats.simple_add_tattoo(player , "Slave Marks", "Slave (right hand)", silent = true)

headshaving.RefreshProgressiveSlaveTats(player )
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_HeadShaving Property headshaving auto