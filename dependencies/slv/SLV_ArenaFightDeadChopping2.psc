;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 43
Scriptname SLV_ArenaFightDeadChopping2 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
myScripts.SLV_DisplayInformation("Phase4")

;SlaveTats.remove_tattoos(SLV_DeadPlayer.getActorRef(), 0, true, true)

;myScripts.SLV_DisplayInformation("activate by Bones")
;SLV_ChoppingBlock.GetReference().activate(SLV_Bones.getActorRef())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_40
Function Fragment_40()
;BEGIN CODE
SLV_ChoppingBlock2.getReference().disable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24()
;BEGIN CODE
SLV_ChoppingBlock2.getReference().enable()

SlaveTats.remove_tattoos(SLV_DeadPlayer.getActorRef(), 0, true, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
myScripts.SLV_DisplayInformation("Phase2")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_42
Function Fragment_42()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN CODE
deadPlayer.resurrectDeadPlayer()
myScripts.SLV_SexlabStripNPC2(SLV_deadplayer.getActorRef(), false)

SLV_DeadPlayer.getActorRef().moveto(SLV_ChoppingBlock2.getReference())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_38
Function Fragment_38()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_31
Function Fragment_31()
;BEGIN CODE
;SlaveTats.remove_tattoos(SLV_DeadPlayer.getActorRef(), 0, true, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_21
Function Fragment_21()
;BEGIN CODE
myScripts.SLV_DisplayInformation("Phase5")

;SlaveTats.remove_tattoos(SLV_DeadPlayer.getActorRef(), 0, true, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
myScripts.SLV_DisplayInformation("Phase5")
;myScripts.SLV_DisplayInformation("activate by Player")
;SlaveTats.remove_tattoos(SLV_DeadPlayer.getActorRef(), 0, true, true)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SLV_ChoppingBlock2.getReference().disable()

SLV_ArenaResurrectionScene.Start()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
myScripts.SLV_DisplayInformation("Phase3")
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_32
Function Fragment_32()
;BEGIN CODE
;SlaveTats.remove_tattoos(SLV_DeadPlayer.getActorRef(), 0, true, true)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property SLV_ArenaResurrectionScene Auto 
Scene Property SLV_ArenaSpittingScene Auto 

GlobalVariable Property SLV_SexIsRunning Auto 
SLV_PrepareDeadPlayer Property deadPlayer Auto

ReferenceAlias Property SLV_ChoppingBlock Auto
ReferenceAlias Property SLV_ChoppingBlock2 Auto
SLV_Utilities Property myScripts auto

ReferenceAlias Property SLV_Gladiator Auto
ReferenceAlias Property SLV_DeadPlayer Auto
ReferenceAlias Property SLV_Bones Auto
ReferenceAlias Property SLV_Player Auto


