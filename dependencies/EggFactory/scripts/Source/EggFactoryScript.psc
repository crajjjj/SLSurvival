Scriptname EggFactoryScript extends ActiveMagicEffect

; Controller quest for NIO
EggFactoryNIOController Property EggFactoryQuest auto

actor property mySelf auto hidden
Perk Property EggFactory auto
Faction Property EggFactoryFaction auto
Faction Property EggFactoryActiveFaction auto

faction property EggFactoryMilky auto

Event OnEffectFinish(Actor Target, Actor Caster)
	UnregisterForUpdate()
endEvent

Event OnUpdate()
	SetNodeScale(myself,"NPC Belly",0.0,false)
	mySelf.RemoveFromFaction(EggFactoryFaction)
	mySelf.RemoveFromFaction(EggFactoryMilky)
	mySelf.RemovePerk(EggFactory)
	UnregisterForUpdate()
	Dispel()
	
endEvent

;Some stuff 4onen added to implement inflation frameworks:

;This is a copy/paste of the lovely SetNodeScale function from XPMSElib. I copy/pasted it here to avoid any additional dependencies.
;(Actually, at this point it's hardly the same function, but credit where it's due)

; Sets a transformation with the given key in 3rd and 1st person skeleton to the given scale (Quicker, Recommended if not 3rd or 1st person dependent)
Function SetNodeScale(Actor akActor, string nodeName, float value, bool dummy)
  
  
    bool isFemale = true ;If something goes really fucking wrong and it skips the if/elseif ladder, this assumes the most common case. Most people want females inflated, so assume female skeleton.
    If akActor.GetLeveledActorBase().GetSex()==0
        isFemale=false
    ElseIf akActor.GetLeveledActorBase().GetSex()==1
        isFemale=true
    Else
        return
    EndIf
    String E_Key = "EGG_MODKEY"
    ;Debug.Notification(nodename +" "+ E_key+" "+(Value as string))
    
    If value > 1.0
        NiOverride.AddNodeTransformScale(akActor, false, isFemale, nodeName, E_Key, value)
        NiOverride.AddNodeTransformScale(akActor, true, isFemale, nodeName, E_Key, value)
    Else
        NiOverride.RemoveNodeTransformScale(akActor, false, isFemale, nodeName, E_Key)
        NiOverride.RemoveNodeTransformScale(akActor, true, isFemale, nodeName, E_Key)
    Endif
    NiOverride.UpdateNodeTransform(akActor, false, isFemale, nodeName)
    NiOverride.UpdateNodeTransform(akActor, true, isFemale, nodeName)
EndFunction

float Function GetNodeScale(Actor akActor, string nodeName)
bool isFemale = true
    Return NiOverride.GetNodeTransformScale(akActor, false, isFemale, nodeName, EggFactoryQuest.FHU_MODKEY)
EndFunction