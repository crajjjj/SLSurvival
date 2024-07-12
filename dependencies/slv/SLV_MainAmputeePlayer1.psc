;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainAmputeePlayer1 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
myScripts.SLV_SexLabStripNPC(Game.getPlayer())
Utility.wait(2.0)

myScripts.SLV_DeviousUnEquip(false,false,false,false,false,false,true,false,false,false,false,false,false,false,false)
;myScripts.SLV_DeviousUnEquip(true,true,true,true,true,true,true,true,true,true,true,true,true,true,true)
;Utility.wait(15.0)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
