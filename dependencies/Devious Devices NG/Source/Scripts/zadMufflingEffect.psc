Scriptname zadMufflingEffect extends ActiveMagicEffect  
{On start and finish of an effect with this script, calls the muffling state master script to check whether muffling devices are worn and modify sound accordingly.}

zadLibs Property libs Auto
Actor Property PlayerRef Auto

zadMufflingStateScript Property MufflingStateScript Auto
{Reference to the muffling state script attached to the player alias in zadQuest.}

Event OnEffectStart(actor akTarget, actor akCaster)
	if akTarget == libs.PlayerRef
		libs.Log("OnEffectStart(muffle)")
		if !libs.config.MuffleTooltip
			libs.config.MuffleTooltip = True
			libs.NotifyPlayer("The Devious Devices sound muffling effect is now active. While wearing any device that covers the ears, the volume of sounds will be decreased.", 1)
		EndIf
		MufflingStateScript.UpdateMuffleState()
       	RegisterForModEvent("zadMuffleEffectUpdate", "UpdateEvent") ; Register for MCM settings updates.
	Else
		; Nothing for now: no functionality atm for muffling on NPCs.
	EndIf
EndEvent

Event OnEffectFinish(actor akTarget, actor akCaster)
	If akTarget == PlayerRef
		; Effect is gone, reset to normal
		MufflingStateScript.UpdateMuffleState()
		libs.Log("OnEffectFinish(muffle)")
	Else
		; Nothing for now: no functionality atm for muffling on NPCs.
	EndIf
EndEvent

Event UpdateEvent(string eventName, string strArg, float numArg, Form sender)
   MufflingStateScript.UpdateMuffleState()
EndEvent

