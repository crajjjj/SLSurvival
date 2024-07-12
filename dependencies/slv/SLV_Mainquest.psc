;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 137
Scriptname SLV_Mainquest Extends Quest Hidden

;BEGIN ALIAS PROPERTY SLV_Ivana
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Ivana Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Animal1
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Animal1 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_SlaveFollower
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_SlaveFollower Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Titus
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Titus Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Mundus
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Mundus Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_SolitudeCarriageDriver
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_SolitudeCarriageDriver Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Belethor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Belethor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Amren
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Amren Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_JarlWhiterun2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_JarlWhiterun2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Diamond
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Diamond Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_LucanValerius
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_LucanValerius Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Finn
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Finn Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Maria
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Maria Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Farengar
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Farengar Auto
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

;BEGIN ALIAS PROPERTY SLV_Slave
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Slave Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Slaver2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Slaver2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Fang
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Fang Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_WhiterunCarriageDriver
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_WhiterunCarriageDriver Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_RiftenCarriageDriver
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_RiftenCarriageDriver Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Murphy
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Murphy Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_PlayerSlave
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_PlayerSlave Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Igor
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Igor Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_DremoraLord
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_DremoraLord Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Nazeem
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Nazeem Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_WindhelmCarriageDriver
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_WindhelmCarriageDriver Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Eric
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Eric Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Animal2
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Animal2 Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Slaver
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Slaver Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Valentina
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Valentina Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Pike
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Pike Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_MarkarthCarriageDriver
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_MarkarthCarriageDriver Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_You
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_You Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_Caesar
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_Caesar Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY SLV_MariaSlave
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_SLV_MariaSlave Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_118
Function Fragment_118()
;BEGIN CODE
SetObjectiveDisplayed(10250)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_24
Function Fragment_24()
;BEGIN CODE
SetObjectiveDisplayed(4000)
hydraslavegirls.enable_dawnstar()
slaveroutfit.setSlaverOutfit(3)

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

slaveguards.SLV_AddDawnstarSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_105
Function Fragment_105()
;BEGIN CODE
SetObjectiveDisplayed(3550)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_31
Function Fragment_31()
;BEGIN CODE
SetObjectiveDisplayed(12000)

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_125
Function Fragment_125()
;BEGIN CODE
SetObjectiveDisplayed(8500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_50
Function Fragment_50()
;BEGIN CODE
SetObjectiveDisplayed(4200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_111
Function Fragment_111()
;BEGIN CODE
SetObjectiveDisplayed(4600)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_119
Function Fragment_119()
;BEGIN CODE
SetObjectiveDisplayed(10300)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_109
Function Fragment_109()
;BEGIN CODE
SetObjectiveDisplayed(6350)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_82
Function Fragment_82()
;BEGIN CODE
SetObjectiveDisplayed(29000)

waittimer.StartMainquestTimer()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_68
Function Fragment_68()
;BEGIN CODE
SetObjectiveDisplayed(6250)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_103
Function Fragment_103()
;BEGIN CODE
SetObjectiveDisplayed(4500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25()
;BEGIN CODE
SetObjectiveDisplayed(5000)
hydraslavegirls.enable_markarth()
zdd.enable_markarth()
slaveroutfit.setSlaverOutfit(4)

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

slaveguards.SLV_AddMarkarthSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_131
Function Fragment_131()
;BEGIN CODE
setObjectiveDisplayed(1430)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_1
Function Fragment_1()
;BEGIN CODE
self.setactive(true)
zdd.disable_all()
hydraslavegirls.disable_all()
jarlswap.updateJarlOfWhiterun()

SetObjectiveDisplayed(0)
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

;BEGIN FRAGMENT Fragment_136
Function Fragment_136()
;BEGIN CODE
SetObjectiveDisplayed(29500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_99
Function Fragment_99()
;BEGIN CODE
SetObjectiveDisplayed(11000)

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

slaveguards.SLV_AddRavenRockSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_84
Function Fragment_84()
;BEGIN CODE
SetObjectiveDisplayed(2350)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN CODE
SetObjectiveDisplayed(2100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_129
Function Fragment_129()
;BEGIN CODE
SetObjectiveDisplayed(1600)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_30
Function Fragment_30()
;BEGIN CODE
SetObjectiveDisplayed(10000)
zdd.enable_solitude()
hydraslavegirls.enable_solitude()
slaveroutfit.setSlaverOutfit(9)

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

slaveguards.SLV_AddSolitudeSlaver()
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

;BEGIN FRAGMENT Fragment_116
Function Fragment_116()
;BEGIN CODE
SetObjectiveDisplayed(8400)
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

;BEGIN FRAGMENT Fragment_93
Function Fragment_93()
;BEGIN CODE
SetObjectiveDisplayed(2500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
setObjectiveDisplayed(250)
myScripts.SLV_EnableBrutus()
slaveroutfit.setSlaverOutfit(0)
slaveroutfit.initSlaverSchlongs()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_117
Function Fragment_117()
;BEGIN CODE
SetObjectiveDisplayed(8350)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_67
Function Fragment_67()
;BEGIN CODE
SetObjectiveDisplayed(6500)
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

;BEGIN FRAGMENT Fragment_135
Function Fragment_135()
;BEGIN CODE
SetObjectiveDisplayed(31500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_113
Function Fragment_113()
;BEGIN CODE
SetObjectiveDisplayed(4350)
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

;BEGIN FRAGMENT Fragment_35
Function Fragment_35()
;BEGIN CODE
SetObjectiveDisplayed(2200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_54
Function Fragment_54()
;BEGIN CODE
SetObjectiveDisplayed(5300)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_78
Function Fragment_78()
;BEGIN CODE
SetObjectiveDisplayed(20000)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_126
Function Fragment_126()
;BEGIN CODE
SetObjectiveDisplayed(30200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_112
Function Fragment_112()
;BEGIN CODE
SetObjectiveDisplayed(4400)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_107
Function Fragment_107()
;BEGIN CODE
SetObjectiveDisplayed(6550)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_37
Function Fragment_37()
;BEGIN CODE
SetObjectiveDisplayed(2800)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_127
Function Fragment_127()
;BEGIN CODE
SetObjectiveDisplayed(30500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_95
Function Fragment_95()
;BEGIN CODE
SetObjectiveDisplayed(3400)
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
slaveguards.SLV_RemoveAllSlaver()
slaveguards.SLV_RemoveAllGuards()

stop()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_28
Function Fragment_28()
;BEGIN CODE
setObjectiveDisplayed(8000)
hydraslavegirls.enable_winterhold()
slaveroutfit.setSlaverOutfit(7)

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

slaveguards.SLV_AddWinterholdSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_62
Function Fragment_62()
;BEGIN CODE
SetObjectiveDisplayed(8200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_102
Function Fragment_102()
;BEGIN CODE
SetObjectiveDisplayed(6600)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_94
Function Fragment_94()
;BEGIN CODE
SetObjectiveDisplayed(3350)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_88
Function Fragment_88()
;BEGIN CODE
SetObjectiveDisplayed(3500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_49
Function Fragment_49()
;BEGIN CODE
SetObjectiveDisplayed(4100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_51
Function Fragment_51()
;BEGIN CODE
SetObjectiveDisplayed(4300)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_53
Function Fragment_53()
;BEGIN CODE
SetObjectiveDisplayed(5200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_101
Function Fragment_101()
;BEGIN CODE
SetObjectiveDisplayed(5400)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_121
Function Fragment_121()
;BEGIN CODE
SetObjectiveDisplayed(7400)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_132
Function Fragment_132()
;BEGIN CODE
setObjectiveDisplayed(1480)
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

;BEGIN FRAGMENT Fragment_36
Function Fragment_36()
;BEGIN CODE
SetObjectiveDisplayed(2300)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_92
Function Fragment_92()
;BEGIN CODE
SetObjectiveDisplayed(2450)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_76
Function Fragment_76()
;BEGIN CODE
SetObjectiveDisplayed(8250)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_134
Function Fragment_134()
;BEGIN CODE
SetObjectiveDisplayed(29200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN CODE
SetObjectiveDisplayed(6000)
hydraslavegirls.enable_riften()
slaveroutfit.setSlaverOutfit(5)

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

slaveguards.SLV_AddRiftenSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_29
Function Fragment_29()
;BEGIN CODE
SetObjectiveDisplayed(9000)
zdd.enable_windhelm()
hydraslavegirls.enable_windhelm()
slaveroutfit.setSlaverOutfit(8)

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

slaveguards.SLV_AddWindhelmSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_71
Function Fragment_71()
;BEGIN CODE
SetObjectiveDisplayed(5250)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
setObjectiveDisplayed(1400)
SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
setObjectiveDisplayed(1000)

zdd.enable_whiterun()
hydraslavegirls.enable_whiterun()
myScripts.SLV_enableZaid()
slaveroutfit.initSlaverSchlongs()
slaveroutfit.setSlaverOutfit(0)
SLV_ForcePeriodicCheck.setValue(1)

slaveguards.SLV_AddWhiterunSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_41
Function Fragment_41()
;BEGIN CODE
SetObjectiveDisplayed(7800)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_73
Function Fragment_73()
;BEGIN CODE
SetObjectiveDisplayed(3250)
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

;BEGIN FRAGMENT Fragment_75
Function Fragment_75()
;BEGIN CODE
SetObjectiveDisplayed(7250)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_104
Function Fragment_104()
;BEGIN CODE
SetObjectiveDisplayed(3600)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_20
Function Fragment_20()
;BEGIN CODE
SetObjectiveDisplayed(10)
zdd.disable_all()
hydraslavegirls.disable_all()
jarlswap.updateJarlOfWhiterun()

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

waittimer.StartMainquestTimer()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_60
Function Fragment_60()
;BEGIN CODE
SetObjectiveDisplayed(7300)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_57
Function Fragment_57()
;BEGIN CODE
SetObjectiveDisplayed(6300)
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

;BEGIN FRAGMENT Fragment_106
Function Fragment_106()
;BEGIN CODE
SetObjectiveDisplayed(4450)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_27
Function Fragment_27()
;BEGIN CODE
SetObjectiveDisplayed(7000)
hydraslavegirls.enable_morthal()
slaveroutfit.setSlaverOutfit(6)

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

slaveguards.SLV_AddMorthalSlaver()
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

;BEGIN FRAGMENT Fragment_65
Function Fragment_65()
;BEGIN CODE
SetObjectiveDisplayed(9200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_48
Function Fragment_48()
;BEGIN CODE
SetObjectiveDisplayed(3100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_124
Function Fragment_124()
;BEGIN CODE
SetObjectiveDisplayed(8450)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_63
Function Fragment_63()
;BEGIN CODE
SetObjectiveDisplayed(8300)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_74
Function Fragment_74()
;BEGIN CODE
SetObjectiveDisplayed(2250)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_114
Function Fragment_114()
;BEGIN CODE
SetObjectiveDisplayed(4550)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
setObjectiveDisplayed(1100)

zdd.enable_whiterun()
hydraslavegirls.enable_whiterun()

myScripts.SLV_enableBrutus()
myScripts.SLV_enableZaid()
slaveroutfit.initSlaverSchlongs()
slaveroutfit.setSlaverOutfit(0)
SLV_ForcePeriodicCheck.setValue(1)
slaveguards.SLV_AddWhiterunSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
SetObjectiveDisplayed(2000)
hydraslavegirls.enable_riverwood()
myScripts.SLV_enableMundus()
slaveroutfit.setSlaverOutfit(1)

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)
slaveguards.SLV_AddRiverwoodSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_83
Function Fragment_83()
;BEGIN CODE
setObjectiveDisplayed(1500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_97
Function Fragment_97()
;BEGIN CODE
SetObjectiveDisplayed(10200)
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

;BEGIN FRAGMENT Fragment_128
Function Fragment_128()
;BEGIN CODE
SetObjectiveDisplayed(1550)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_123
Function Fragment_123()
;BEGIN CODE
SetObjectiveDisplayed(7500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_46
Function Fragment_46()
;BEGIN CODE
SetObjectiveDisplayed(3300)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
SetObjectiveDisplayed(1200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_52
Function Fragment_52()
;BEGIN CODE
SetObjectiveDisplayed(5100)
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

;BEGIN FRAGMENT Fragment_79
Function Fragment_79()
;BEGIN CODE
SetObjectiveDisplayed(30000)
zdd.enable_all() 
hydraslavegirls.enable_all()

waittimer.StartMainquestTimer()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_120
Function Fragment_120()
;BEGIN CODE
SetObjectiveDisplayed(7350)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_11
Function Fragment_11()
;BEGIN CODE
setObjectiveDisplayed(1050)

zdd.enable_whiterun()
hydraslavegirls.enable_whiterun()
myScripts.SLV_enableZaid()
slaveroutfit.initSlaverSchlongs()
slaveroutfit.setSlaverOutfit(0)
SLV_ForcePeriodicCheck.setValue(1)
slaveguards.SLV_AddWhiterunSlaver()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_70
Function Fragment_70()
;BEGIN CODE
SetObjectiveDisplayed(6450)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_55
Function Fragment_55()
;BEGIN CODE
SetObjectiveDisplayed(6100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_87
Function Fragment_87()
;BEGIN CODE
SetObjectiveDisplayed(2550)
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

;BEGIN FRAGMENT Fragment_89
Function Fragment_89()
;BEGIN CODE
SetObjectiveDisplayed(3450)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
setObjectiveDisplayed(1300)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_81
Function Fragment_81()
;BEGIN CODE
setObjectiveDisplayed(1450)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_133
Function Fragment_133()
;BEGIN CODE
SetObjectiveDisplayed(31200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_85
Function Fragment_85()
;BEGIN CODE
SetObjectiveDisplayed(2400)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_122
Function Fragment_122()
;BEGIN CODE
SetObjectiveDisplayed(7450)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_58
Function Fragment_58()
;BEGIN CODE
SetObjectiveDisplayed(7100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_66
Function Fragment_66()
;BEGIN CODE
SetObjectiveDisplayed(9300)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_47
Function Fragment_47()
;BEGIN CODE
SetObjectiveDisplayed(3200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_110
Function Fragment_110()
;BEGIN CODE
SetObjectiveDisplayed(5500)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_91
Function Fragment_91()
;BEGIN CODE
SetObjectiveDisplayed(1650)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_86
Function Fragment_86()
;BEGIN CODE
SetObjectiveDisplayed(2600)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_130
Function Fragment_130()
;BEGIN CODE
SetObjectiveDisplayed(25)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_77
Function Fragment_77()
;BEGIN CODE
SetObjectiveDisplayed(9250)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_98
Function Fragment_98()
;BEGIN CODE
SetObjectiveDisplayed(10100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_72
Function Fragment_72()
;BEGIN CODE
SetObjectiveDisplayed(4250)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_80
Function Fragment_80()
;BEGIN CODE
SetObjectiveDisplayed(31000)
zdd.enable_all() 
hydraslavegirls.enable_all()

waittimer.StartMainquestTimer()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_108
Function Fragment_108()
;BEGIN CODE
SetObjectiveDisplayed(5350)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_59
Function Fragment_59()
;BEGIN CODE
SetObjectiveDisplayed(7200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_64
Function Fragment_64()
;BEGIN CODE
SetObjectiveDisplayed(9100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_56
Function Fragment_56()
;BEGIN CODE
SetObjectiveDisplayed(6200)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_100
Function Fragment_100()
;BEGIN CODE
SetObjectiveDisplayed(6400)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_61
Function Fragment_61()
;BEGIN CODE
SetObjectiveDisplayed(8100)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_115
Function Fragment_115()
;BEGIN CODE
SetObjectiveDisplayed(5450)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_90
Function Fragment_90()
;BEGIN CODE
SetObjectiveDisplayed(1700)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN CODE
SetObjectiveDisplayed(3000)
hydraslavegirls.enable_falkreath()
slaveroutfit.setSlaverOutfit(2)

SLV_WhiterunTask.setValue(0)
UpdateCurrentInstanceGlobal(SLV_WhiterunTask)

slaveguards.SLV_AddFalkreathSlaver()
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
SLV_SlaveGuardsUtilities Property slaveguards auto

GlobalVariable Property SLV_ForcePeriodicCheck  Auto 
GlobalVariable Property SLV_WhiterunTask  Auto 
GlobalVariable Property SLV_WhiterunCiticen  Auto  

SLV_Mainquest_Timer  Property waittimer auto

