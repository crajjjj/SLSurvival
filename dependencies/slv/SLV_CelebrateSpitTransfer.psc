;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_CelebrateSpitTransfer Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
zad_BlindfoldLeeches.Apply(0)
zad_BlindfoldModifier.Apply(100)
Utility.wait (3.0)

Utility.wait (3.0)
zad_BlindfoldLeeches.ApplyCrossFade(3)
zad_BlindfoldModifier.Remove()
zad_BlindfoldLeeches.Remove()
Utility.wait (3.0)

ActorUtil.ClearPackageOverride(Game.GetPlayer())
Game.GetPlayer().evaluatePackage()

Game.EnablePlayerControls(0, 0, 1, 1, 1, 0, 0)
Game.EnablePlayerControls(1, 1, 1, 1, 1, 1,1)

;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Package Property Roasting Auto

ImagespaceModifier Property zad_BlindfoldModifier Auto
ImagespaceModifier Property zad_BlindfoldLeeches Auto
