;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_SexSlaveTraining2_13 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetOwningQuest().SetObjectiveCompleted(6500)
GetOwningQuest().SetStage(7000)

if ThisMenu.SkipScenes
	return
endif

SLV_Slaver.ForceRefTo(akSpeaker)
;Debug.notification("New Slaver= " + SLV_Slaver.getActorRef().getActorBase().getName())

SLV_Animal.ForceRefTo(Animal)
;Debug.notification("New Animal= " + SLV_Animal.getActorRef().getActorBase().getName())

SendModEvent("dhlp-Suspend")
game.DisablePlayerControls(1, 1, 1, 0, 0, 1, 1)
game.SetPlayerAIDriven(true)

PunishScene.Start()
Utility.wait(2.0)
SLV_SexIsRunning.setValue(2)

int IsRunning = SLV_SexIsRunning.getValue() as int

while IsRunning == 2
	Utility.wait(1.0)
	IsRunning = SLV_SexIsRunning.getValue() as int
endwhile

PunishScene2.Start()

Utility.wait(15)

; iinfect with chaurus eggs
int ECTrap = ModEvent.Create("ECStartAnimation"); Int Int does not have to be named "ECTrap" any name would do
if (ECTrap)
    ModEvent.PushForm(ECTrap, self)          ; Form Pass the calling form to the event
    ModEvent.PushForm(ECTrap, Game.getplayer())       ; Form The animation target
    ModEvent.PushInt(ECTrap, -1) ; Int The animation required -1 = Impregnation only with No Amimation,
                                             ; 0 = Tentacles, 1 = Machines 2 = Slime 3 = Ooze
    ModEvent.PushBool(ECTrap, false)          ; Bool Apply the linked EC effect (Ovipostion for Tentacles, Slime & Ooze,
;                                             ; Exhaustion for Machine)
    ModEvent.Pushint(ECTrap, 0)            ; Int Alarm radius in units (0 to disable)
    ModEvent.PushBool(ECTrap, false)          ; Bool Use EC (basic) crowd control on hostiles if the Player is trapped
    ModEvent.Send(ECtrap)
 else
    ;EC is not installed
endIf
;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_MCMMenu Property ThisMenu auto
Scene Property PunishScene  Auto
ReferenceAlias Property SLV_Animal Auto  
Actor Property Animal Auto

Scene Property PunishScene2  Auto
ReferenceAlias Property SLV_Slaver Auto 
GlobalVariable Property SLV_SexIsRunning Auto  
