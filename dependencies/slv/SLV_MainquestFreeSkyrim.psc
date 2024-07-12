;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 126
Scriptname SLV_MainquestFreeSkyrim Extends Quest Hidden

;BEGIN ALIAS PROPERTY SLV_Ivana
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Ivana Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Delphine
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Delphine Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_SlaveFollower
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_SlaveFollower Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Maven
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Maven Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_JarlWhiterun1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_JarlWhiterun1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Bellamy
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Bellamy Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_LadyMaraPriestess
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_LadyMaraPriestess Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Titus
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Titus Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Elenwen
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Elenwen Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Fang
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Fang Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_JarlMorthal2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_JarlMorthal2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_LadyMara
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_LadyMara Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Murphy
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Murphy Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_JarlWhiterun2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_JarlWhiterun2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Mundus
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Mundus Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_MolagBal
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_MolagBal Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Slave
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Slave Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Diamond
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Diamond Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Eric
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Eric Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Slaver
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Slaver Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Slaver2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Slaver2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_JarlMorthal1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_JarlMorthal1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Pike
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Pike Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_DremoraLord
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_DremoraLord Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_You
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_You Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Igor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Igor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Maria
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Maria Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_41
Function Fragment_41()
;BEGIN CODE
SetObjectiveDisplayed(7800)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24()
;BEGIN CODE
SetObjectiveDisplayed(4000)

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

myScripts.SLV_restoreNPCOutfitsforZone(11)

cleanguards.SLV_RemoveRavenRockGuards()
cleanguards.SLV_RemoveRavenRockSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_31
Function Fragment_31()
;BEGIN CODE
SetObjectiveDisplayed(12000)

zdd.disable_whiterun()
hydraslavegirls.disable_whiterun()

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

myScripts.SLV_restoreNPCOutfitsforZone(1)

cleanguards.SLV_RemoveWhiterunGuards()
cleanguards.SLV_RemoveWhiterunSlaver()

zdd.disable_all()
hydraslavegirls.disable_all()
myScripts.SLV_disableBrutus()
myScripts.SLV_disableZaid()
myScripts.SLV_disableMundus()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_125
Function Fragment_125()
;BEGIN CODE
SetObjectiveDisplayed(11800)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_44
Function Fragment_44()
;BEGIN CODE
SetObjectiveDisplayed(4800)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_27
Function Fragment_27()
;BEGIN CODE
SetObjectiveDisplayed(7000)

hydraslavegirls.disable_riften()

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

myScripts.SLV_restoreNPCOutfitsforZone(6)

cleanguards.SLV_RemoveRiftenGuards()
cleanguards.SLV_RemoveRiftenSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveDisplayed(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25()
;BEGIN CODE
SetObjectiveDisplayed(5000)

hydraslavegirls.disable_winterhold()

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

myScripts.SLV_restoreNPCOutfitsforZone(8)

cleanguards.SLV_RemoveWinterholdGuards()
cleanguards.SLV_RemoveWinterholdSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
SetObjectiveDisplayed(0)
Game.getPlayer().moveto(MolagBalsRoom)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_40
Function Fragment_40()
;BEGIN CODE
SetObjectiveDisplayed(8800)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_99
Function Fragment_99()
;BEGIN CODE
SetObjectiveDisplayed(11000)

hydraslavegirls.disable_riverwood()

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

myScripts.SLV_restoreNPCOutfitsforZone(2)

cleanguards.SLV_RemoveRiverwoodGuards()
cleanguards.SLV_RemoveRiverwoodSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_13
Function Fragment_13()
;BEGIN CODE
SetObjectiveDisplayed(1800)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_124
Function Fragment_124()
;BEGIN CODE
SetObjectiveDisplayed(180)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_37
Function Fragment_37()
;BEGIN CODE
SetObjectiveDisplayed(280)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN CODE
SetObjectiveDisplayed(3000)

zdd.disable_windhelm()
hydraslavegirls.disable_windhelm()

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

myScripts.SLV_restoreNPCOutfitsforZone(9)

cleanguards.SLV_RemoveWindhelmGuards()
cleanguards.SLV_RemoveWindhelmSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_5
Function Fragment_5()
;BEGIN CODE
setObjectiveDisplayed(150)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
setObjectiveDisplayed(250)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_42
Function Fragment_42()
;BEGIN CODE
SetObjectiveDisplayed(6800)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_45
Function Fragment_45()
;BEGIN CODE
SetObjectiveDisplayed(3800)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_39
Function Fragment_39()
;BEGIN CODE
SetObjectiveDisplayed(9800)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_43
Function Fragment_43()
;BEGIN CODE
setObjectiveDisplayed(5800)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_85
Function Fragment_85()
;BEGIN CODE
SetObjectiveDisplayed(2800)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
setObjectiveDisplayed(1000)

SLV_ForcePeriodicCheck.setValue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_34
Function Fragment_34()
;BEGIN CODE
SetObjectiveDisplayed(50000)
zdd.disable_all()
hydraslavegirls.disable_all()
myScripts.SLV_disableBrutus()
myScripts.SLV_disableZaid()
myScripts.SLV_disableMundus()
myScripts.SLV_disableMaria()

cleanguards.SLV_RemoveAllSlaver()
cleanguards.SLV_RemoveAllGuards()

stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_28
Function Fragment_28()
;BEGIN CODE
setObjectiveDisplayed(8000)

hydraslavegirls.disable_markarth()
zdd.disable_markarth()

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

myScripts.SLV_restoreNPCOutfitsforZone(5)

cleanguards.SLV_RemoveMarkarthGuards()
cleanguards.SLV_RemoveMarkarthSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_29
Function Fragment_29()
;BEGIN CODE
SetObjectiveDisplayed(9000)

hydraslavegirls.disable_dawnstar()

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

myScripts.SLV_restoreNPCOutfitsforZone(4)

cleanguards.SLV_RemoveDawnstarGuards()
cleanguards.SLV_RemoveDawnstarSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_122
Function Fragment_122()
;BEGIN CODE
setObjectiveDisplayed(500)
stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
setObjectiveDisplayed(100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN CODE
SetObjectiveDisplayed(6000)

hydraslavegirls.disable_morthal()

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

myScripts.SLV_restoreNPCOutfitsforZone(7)

cleanguards.SLV_RemoveMorthalGuards()
cleanguards.SLV_RemoveMorthalSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
SetObjectiveDisplayed(2000)

zdd.disable_solitude()
hydraslavegirls.disable_solitude()

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

myScripts.SLV_restoreNPCOutfitsforZone(10)
cleanguards.SLV_RemoveSolitudeGuards()
cleanguards.SLV_RemoveSolitudeSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_30
Function Fragment_30()
;BEGIN CODE
SetObjectiveDisplayed(10000)

hydraslavegirls.disable_falkreath()

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

myScripts.SLV_restoreNPCOutfitsforZone(3)

cleanguards.SLV_RemoveFalkreathGuards()
cleanguards.SLV_RemoveFalkreathSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
setObjectiveDisplayed(200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_96
Function Fragment_96()
;BEGIN CODE
SetObjectiveDisplayed(10800)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Softzdd  Property  zdd Auto
SLV_SoftHydraSlavegirls  Property  hydraslavegirls Auto
SLV_SwapJarl Property jarlswap Auto
SLV_EventHandler Property events Auto
SLV_Utilities Property myScripts auto
SLV_SlaverOutfit Property slaveroutfit auto
SLV_SlaveGuardsUtilities Property cleanguards auto


GlobalVariable Property SLV_ForcePeriodicCheck  Auto 
GlobalVariable Property SLV_WhiterunTask  Auto 
GlobalVariable Property SLV_WhiterunCiticen  Auto  
ObjectReference Property MolagBalsRoom Auto

