;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSpecial2_6 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(2500)
GetOwningQuest().SetStage(3000)

Camilla.moveto(Game.GetPlayer())
Game.GetPlayer().RemoveItem(DeviousItem1, 5)
Game.GetPlayer().RemoveItem(DeviousItem2, 5)

myScripts.SLV_Play2Sex(Camilla , Game.GetPlayer(), "Sex", false)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
Actor Property Camilla  Auto  
Armor Property DeviousItem1 Auto 
Armor Property DeviousItem2 Auto 


