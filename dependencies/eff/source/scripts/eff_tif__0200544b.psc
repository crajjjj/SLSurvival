;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname EFF_TIF__0200544B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;PluginOutfit.ApplyOutfit(None, PluginOutfit.Outfits_LightArmor[6], false)
XFLMain.XFL_SendActionEvent(PluginOutfit.GetIdentifier(), 0, None, PluginOutfit.Outfits_LightArmor[6], 0)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

EFFPluginOutfit Property PluginOutfit  Auto  

EFFCore Property XFLMain  Auto  