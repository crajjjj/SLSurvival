;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_RiftenJailRape1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_SexlabStripNPC(Game.GetPlayer())
Debug.notification("Maul begins to search your inventory")

game.getplayer().equipitem(prisonrags)

Debug.MessageBox("Vaul knocks you down with one hit, and you loose consciousness.")

ActorUtil.ClearPackageOverride(akSpeaker)
akSpeaker.evaluatePackage()

Game.GetPlayer().moveto(newMarker)
Utility.wait(20)

GetOwningQuest().SetObjectiveCompleted(0)
GetOwningQuest().SetStage(500)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
ObjectReference Property newMarker Auto
SLV_Utilities Property myScripts auto
Armor Property prisonrags auto
