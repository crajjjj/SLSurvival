;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 17
Scriptname SLV_SlavetrainingGang Extends Scene Hidden

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
;Game.EnablePlayerControls()
;game.SetPlayerAIDriven(false)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
debug.notification("Zaid leads you to a dungeon")

Alias_Farkas.getRef().moveto(Alias_Fang.getRef())
Alias_Ria.getRef().moveto(Alias_Fang.getRef())
Alias_Aela.getRef().moveto(Alias_Fang.getRef())
Alias_Eric.getRef().moveto(Alias_Fang.getRef())
Alias_Brutus.getRef().moveto(Alias_Fang.getRef())
Alias_Sven.getRef().moveto(Alias_Fang.getRef())
;Alias_Zaid.getRef().moveto(Alias_Fang.getRef())
;Alias_Fang.getRef().moveto(Alias_Fang.getRef())


ActorUtil.AddPackageOverride(Alias_Eric.getRef() as Actor , gotoMarket ,100)
(Alias_Eric.getRef() as Actor).evaluatePackage()

ActorUtil.AddPackageOverride(Alias_Zaid.getRef() as Actor , gotoMarket ,100)
(Alias_Zaid.getRef() as Actor).evaluatePackage()

ActorUtil.AddPackageOverride(Alias_Sven.getRef() as Actor , gotoMarket ,100)
(Alias_Sven.getRef() as Actor).evaluatePackage()

ActorUtil.AddPackageOverride(Alias_Farkas.getRef() as Actor , gotoMarket ,100)
(Alias_Farkas.getRef() as Actor).evaluatePackage()

ActorUtil.AddPackageOverride(Alias_Brutus.getRef() as Actor , gotoMarket ,100)
(Alias_Brutus.getRef() as Actor).evaluatePackage()

ActorUtil.AddPackageOverride(Alias_Fang.getRef() as Actor , gotoMarket ,100)
(Alias_Fang.getRef() as Actor).evaluatePackage()

ActorUtil.AddPackageOverride( Alias_Ria.getRef() as Actor , gotoMarket ,100)
(Alias_Ria.getRef() as Actor).evaluatePackage()

ActorUtil.AddPackageOverride(Alias_Aela.getRef() as Actor , gotoMarket ,100)
(Alias_Aela.getRef() as Actor).evaluatePackage()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
ActorUtil.RemoveAllPackageOverride(gotoMarket )
SendModEvent("dhlp-Resume")
Game.EnablePlayerControls()
game.SetPlayerAIDriven(false)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

;BEGIN ALIAS PROPERTY Brutus
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Brutus Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Farkas
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Farkas Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Sven
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Sven Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Aela
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Aela Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Zaid
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Zaid Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Eric
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Eric Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Ria
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Ria Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Fang
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Fang Auto
;END ALIAS PROPERTY

Package Property gotoMarket Auto
GlobalVariable Property SLV_SexIsRunning Auto  

