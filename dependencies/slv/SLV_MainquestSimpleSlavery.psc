;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_MainquestSimpleSlavery Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
if Game.GetModByName("SimpleSlavery.esp") != 255
	ObjectReference SSLV_CageMark = Game.GetFormFromFile(0x025304,"SimpleSlavery.esp") as ObjectReference
	Game.getplayer().moveto(SSLV_CageMark) 
	SSLV_CageMark.Activate(Game.GetPlayer())
	GameHour.Mod(2.0) ; wait 2 hours game time 
	Game.getplayer().unequipall()
endif
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
GlobalVariable Property GameHour Auto 