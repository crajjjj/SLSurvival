;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 2
Scriptname TIF_Dflow_070403EB Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
QF__Gift_09000D62 owning = (GetOwningQuest() as QF__Gift_09000D62)

owning.Tool.PauseAll()

If Utility.RandomInt(1, 99) >= (SSO.GetValue() As Int)

	owning.SetStage(99) ; This prevents the mod pausing itself in the mod event, so has to happen first
	owning.ETimerReset()

	SendModEvent("PlayerRefEnslaved") ; This just sets the enslaved flag, the enslavement behaviours results from the quest stage.

Else
	; If player is sent to Simple Slavery, then remove them from DF.

	SendModEvent("DF-RemoveFollower")

	PlayerRef.RemoveItem(Gold001, 10000)
	owning.SetDebt(0)
	owning.Reset()
	owning.SetStage(0)
	owning.Start()

	SendModEvent("SSLV Entry")

	owning.DDelay()

EndIf

Int maxTattoos = _Dtats.GetValue() As Int

If maxTattoos > 0

       Int t = Utility.RandomInt(1, maxTattoos)
	While t > 0
		t -= 1
              SendModEvent("RapeTattoos_addTattoo")
      	       Utility.wait(3)
       EndWhile

EndIf

owning.Tool.ResumeALL()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

QF__Gift_09000D62 Property q  Auto  

zadlibs Property libs  Auto  
Actor Property PlayerRef  Auto  
Armor Property Collar  Auto  
Armor Property Mitts  Auto  
Armor Property boots  Auto
Message Property msg  Auto  
GlobalVariable Property FreedomCost Auto

MiscObject Property Gold001  Auto  

GlobalVariable Property _Dtats  Auto  

GlobalVariable Property SSO  Auto  

GlobalVariable Property _DflowEndlessMode Auto  
Armor Property I  Auto
Armor Property R  Auto
