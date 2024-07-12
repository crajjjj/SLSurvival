Scriptname EggFactoryLactation extends ActiveMagicEffect

EggFactoryNIOController Property EggFactoryQuest auto

actor property mySelf auto hidden
GlobalVariable Property EggFactoryBreastEnable auto

GlobalVariable Property EggFactoryBreastMin auto
GlobalVariable Property EggFactoryBreastMax auto
GlobalVariable Property EggFactoryBreastRate auto
GlobalVariable Property EggFactoryBreastRate2 auto
GlobalVariable Property EggFactoryMilkRate auto

GlobalVariable Property EggFactorybreastpoints auto

float property last_hour_checked=0.0 auto hidden
float property hours_passed auto hidden

float property breastpoints auto hidden
float property milkpoints auto hidden

leveleditem property MilkItems auto

keyword property EggFactoryEnchMilk auto

GlobalVariable Property EggFactoryMilkAlways auto

GlobalVariable Property EggFactoryPlayerMilkState auto
GlobalVariable Property EggFactoryPlayerMilkCooldown auto

GlobalVariable Property EggFactoryBreastScaleMethod auto


Function AddMilkForms()
	MilkItems.Revert()
	MilkItems.AddForm(Game.GetFormFromFile(0x3534, "hearthfires.esm"),1,1)
Endfunction

Event OnConfigChange()
	debug.trace("EggFactory options changed in MCM.")
    ClearAllScaleTypes(myself)
EndEvent

Event OnEffectStart(Actor Target, Actor Caster)
	RegisterForModEvent("EggFactory_ConfigChange2", "OnConfigChange")
    last_hour_checked=Utility.GetCurrentGameTime()*24.0
	mySelf = Caster
	AddMilkForms()
	breastpoints = EggFactorybreastpoints.GetValue() as float
	RegisterForSingleUpdate(1.0)
EndEvent

Function MilkLeaks(Actor who)

	if (MilkItems.GetNumForms()==0)
		debug.notification("Your breasts spray milk, but you can't find a bottle in time.")
	else
		debug.notification("Your breasts spray milk, and you quickly bottle it.")
		who.additem(MilkItems, 1, false)
	endif
	
	milkpoints = 00
	
EndFunction

Function BreastsGrow(Actor who)
	breastpoints += EggFactoryBreastRate.GetValue()
	int milkstate = (EggFactoryPlayerMilkState.GetValue() as int)
	int cooldowntimer = (EggFactoryPlayerMilkCooldown.GetValue() as int)

	if(cooldowntimer > -10)
		cooldowntimer -= 1
		if(cooldowntimer == 0)
			EggFactoryPlayerMilkState.SetValue(0)
			cooldowntimer = -10
			debug.notification("Your breasts feel less heavy.")
		endif
	endif
	
	if(milkstate >= 3 || myself.haseffectkeyword(EggFactoryEnchMilk) || (EggFActoryMilkAlways.GetValue() as int > 0))
		milkpoints += EggFactoryMilkRate.GetValue()
		if(milkpoints > 100)
			MilkLeaks(who)
		endif
	endif
	
	if(breastpoints > 100)
		breastpoints = 100
	endif
	
	EggFactorybreastpoints.SetValue(breastpoints)
	EggFactoryPlayerMilkCooldown.SetValue(cooldowntimer)
	
	;debug.notification("Growing breasts")
	
EndFunction

Function BreastsShrink(Actor who)
	breastpoints -= EggFactoryBreastRate2.GetValue()
	if(breastpoints < 0)
		breastpoints = 0
	endif
	
	EggFactorybreastpoints.SetValue(breastpoints)
	
	;debug.notification("Shrinking breasts")
EndFunction

Event OnUpdate()
	bool BreastActive = (EggFactoryBreastEnable.GetValue() as bool)
	int milkstate = (EggFactoryPlayerMilkState.GetValue() as int)
	if(BreastActive)
		float BreastScale

		hours_passed=Utility.GetCurrentGameTime()*24.0 - last_hour_checked
	
		if(milkstate >= 2 || myself.haseffectkeyword(EggFactoryEnchMilk) || (EggFActoryMilkAlways.GetValue() as int > 0))
		    while(hours_passed>=1.0)
				BreastsGrow(mySelf)
				hours_passed -= 1.0
				last_hour_checked=Utility.GetCurrentGameTime()*24.0
			endwhile
		elseif (milkstate < 1 && EggFactoryBreastRate2.GetValue() > 0.0 )
		    while(hours_passed>=1.0)
				BreastsShrink(mySelf)
				hours_passed -= 1.0
				last_hour_checked=Utility.GetCurrentGameTime()*24.0
			endwhile
		endif
	
		BreastScale = EggFactoryBreastMin.GetValue()+((EggFactoryBreastMax.GetValue()-EggFactoryBreastMin.GetValue())*(breastpoints/100.0))
			
		;debug.notification("Faction rank "+rank2+" setting size to "+BreastScale)
		
		if(BreastScale > 0.0)
            ScaleBreasts(myself,BreastScale)
			;SetNodeScale(mySelf,"NPC L Breast",BreastScale,false)
			;SetNodeScale(mySelf,"NPC R Breast",BreastScale,false)
		
			;SetNodeScale(mySelf,"NPC L Breast01",1.0/BreastScale,false)
			;SetNodeScale(mySelf,"NPC R Breast01",1.0/BreastScale,false)
		endif
	else
        ScaleBreasts(myself,0.0)
		;SetNodeScale(mySelf,"NPC L Breast",0.0,false)
		;SetNodeScale(mySelf,"NPC R Breast",0.0,false)
		;SetNodeScale(mySelf,"NPC L Breast01",0.0,false)
		;SetNodeScale(mySelf,"NPC R Breast01",0.0,false)
		utility.wait(1.0)
		self.dispel()
	endif
	RegisterForSingleUpdate(1.0)
EndEvent

;Some stuff 4onen added to implement inflation frameworks:

;This is a copy/paste of the lovely SetNodeScale function from XPMSElib. I copy/pasted it here to avoid any additional dependencies.
;(Actually, at this point it's hardly the same function, but credit where it's due)

; Sets a transformation with the given key in 3rd and 1st person skeleton to the given scale (Quicker, Recommended if not 3rd or 1st person dependent)
Function SetNodeScaleNIO(Actor akActor, string nodeName, float value, bool dummy)
  
  
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
    
    If value > 0.01
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

Function SetNodeScaleSLIF(Actor akActor, string nodeName, float value)
    string sKey = "slif_breast"

;    If nodeName == "NPC L Breast"
;        sKey = "slif_breast"
;    ElseIf nodeName == "NPC Belly"
;        sKey = "slif_belly"
;    Else
;        Return
;    EndIf

    If (value > 0.0)
        int SLIF_event = ModEvent.Create("SLIF_inflate")
        If (SLIF_event)
            ModEvent.PushForm(SLIF_event, akActor)
            ModEvent.PushString(SLIF_event, "Egg Factory")
            ModEvent.PushString(SLIF_event, sKey)
            ModEvent.PushFloat(SLIF_event, value)
            ModEvent.PushString(SLIF_event, "EGG_MODKEY")
            ModEvent.Send(SLIF_event)
        EndIf
    Else
        int SLIF_event = ModEvent.Create("SLIF_unregisterNode")
        If (SLIF_event)
            ModEvent.PushForm(SLIF_event, akActor)
            ModEvent.PushString(SLIF_event, "Egg Factory")
            ModEvent.PushString(SLIF_event, sKey)
            ModEvent.Send(SLIF_event)
        EndIf
    EndIf
Endfunction

Function ScaleBreasts(actor AkActor, float BreastScale)
    int scalemethod = EggFactoryBreastScaleMethod.GetValue() as int
    if(scalemethod == 1)
        SetNodeScaleNIO(akActor,"NPC L Breast",BreastScale,false)
		SetNodeScaleNIO(akActor,"NPC R Breast",BreastScale,false)
		
		SetNodeScaleNIO(akActor,"NPC L Breast01",1.0/BreastScale,false)
		SetNodeScaleNIO(akActor,"NPC R Breast01",1.0/BreastScale,false)
;    elseif(scalemethod == 2)
    elseif(scalemethod == 3)
        SetnodeScaleSLIF(akActor,"breasts", BreastScale)
    endif
    
EndFunction

Function ClearAllScaleTypes(actor akActor)
    SetNodeScaleNIO(akActor,"NPC L Breast",0.0,false)
	SetNodeScaleNIO(akActor,"NPC R Breast",0.0,false)
		
	SetNodeScaleNIO(akActor,"NPC L Breast01",0.0,false)
	SetNodeScaleNIO(akActor,"NPC R Breast01",0.0,false)
    
    SetnodeScaleSLIF(akActor,"breasts", 0.0)
EndFunction