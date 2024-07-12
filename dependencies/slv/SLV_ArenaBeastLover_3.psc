;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ArenaBeastLover_3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Game.getPlayer().additem(Gold001 ,5000)

bool equipGagParam=false
bool equipAnalPlugParam=true
bool equipVagPlugParam=true
bool equipHarnessParam=false
bool equipBeltParam=false
bool equipBraParam=false
bool equipCollarParam=true
bool equipLegCuffsParam=true
bool equipArmCuffsParam=true
bool equipArmbinderParam=false
bool equipYokeParam=false
bool equipBlindfoldParam=false
bool equipNPiercingsParam=true
bool equipVPiercingsParam=true
bool equipBootsParam=true
bool equipGlovesParam=true
bool equipCorsetParam=true
bool equipMittensParam=false
bool equipHoodParam=false
bool equipClampsParam=false
bool equipSuitParam=true
bool equipShacklesParam=false
bool equipHobblesSkirtParam=false
bool equipHobblesSkirtRelaxedParam=false
bool equipStraitJacketParam=false

Int Handle = ModEvent.Create("SlaverunReloaded_ManipulateDD")

If (Handle)
	ModEvent.PushForm(Handle, Self)
	ModEvent.PushForm(Handle, Game.getplayer())
	ModEvent.PushBool(Handle, true)
	ModEvent.PushBool(Handle, equipGagParam)
	ModEvent.PushBool(Handle, equipAnalPlugParam)
	ModEvent.PushBool(Handle, equipVagPlugParam)
	ModEvent.PushBool(Handle, equipHarnessParam)
	ModEvent.PushBool(Handle, equipBeltParam)
	ModEvent.PushBool(Handle, equipBraParam)
	ModEvent.PushBool(Handle, equipCollarParam)
	ModEvent.PushBool(Handle, equipLegCuffsParam)
	ModEvent.PushBool(Handle, equipArmCuffsParam)
	ModEvent.PushBool(Handle, equipArmbinderParam)
	ModEvent.PushBool(Handle, equipYokeParam)
	ModEvent.PushBool(Handle, equipBlindfoldParam)
	ModEvent.PushBool(Handle, equipNPiercingsParam)
	ModEvent.PushBool(Handle, equipVPiercingsParam)
	ModEvent.PushBool(Handle, equipBootsParam)
	ModEvent.PushBool(Handle, equipGlovesParam)
	ModEvent.PushBool(Handle, equipCorsetParam)
	ModEvent.PushBool(Handle, equipMittensParam)
	ModEvent.PushBool(Handle, equipHoodParam)
	ModEvent.PushBool(Handle, equipClampsParam)
	ModEvent.PushBool(Handle, equipSuitParam)
	ModEvent.PushBool(Handle, equipShacklesParam)
	ModEvent.PushBool(Handle, equipHobblesSkirtParam)
	ModEvent.PushBool(Handle, equipHobblesSkirtRelaxedParam)
	ModEvent.PushBool(Handle, equipStraitJacketParam)
	ModEvent.Send(Handle)
EndIf

GetOwningQuest().SetObjectiveCompleted(9500)
GetOwningQuest().SetStage(10000)
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
MiscObject Property Gold001 auto
SLV_Utilities Property myScripts auto

