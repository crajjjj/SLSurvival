Scriptname EggCursedScript extends ObjectReference  

int property pregtype auto

MiscObject Property OwnEgg auto
Ingredient Property InertForm auto

Keyword Property EggFactoryEnchProtection auto

GlobalVariable Property EggFactoryFirstPerson auto
GlobalVariable Property EggFactoryUninstallToggle auto
GlobalVariable Property EggFactoryMaleToggle auto
GlobalVariable Property EggFactoryMultiLimit auto

Faction Property EggFactoryPregCheck auto

;quest property EggFactoryQuest auto
;int property QuestStageToSet auto

perk property EggFactoryCheatBarren auto

bool Function IsChildRace(Race ThisRace)
	; this is handled in EggFactoryTimer now
	return false 
EndFunction

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
	bool firstperson=EggFactoryFirstPerson.GetValue() as bool
	actor newvictim = akNewContainer as actor
	
	if(newvictim && !newvictim.isdead())
		if(newvictim != game.getplayer())
			firstperson = true
		endif
		
		if(IsChildRace(newvictim.GetRace()) == true)
			if(firstperson==true)
				debug.notification(newvictim.GetDisplayName() + ": Hm, nothing's happening.")
			else
				debug.notification("You are too young, so nothing happens.")
			endif
		elseif (newvictim.GetActorBase().GetSex() == 0 && EggFactoryMaleToggle.GetValueInt() as bool != true)
			if(firstperson==true)
				debug.notification(newvictim.GetDisplayName() + ": I'm a boy, so I guess nothing will happen.")
			else
				debug.notification("You are a boy, so nothing happens.")
			endif
		elseif (newvictim.HasEffectKeyword(EggFactoryEnchProtection) || newvictim.hasperk(EggFactoryCheatBarren))
			if(firstperson==true)
				debug.notification(newvictim.GetDisplayName() + ": Nothing happened. I must be barren.")
			else
				debug.notification("Nothing happened. You must be barren.")
			endif
;		elseif (newvictim.GetFactionRank(EggFactoryPregCheck) >= EggFactoryMultiLimit.GetValue() as int)
;			if(firstperson==true)
;				debug.notification(newvictim.GetDisplayName() + ": I don't think I can get more pregnant.")
;			else
;				debug.notification("Nothing happened.")
;			endif
		else
			int handle = ModEvent.Create("EggFactory_Impregnate")
			if (handle)
				modevent.pushform(handle, newvictim)
				ModEvent.PushInt(handle, pregtype)
				ModEvent.PushInt(handle, 1)
				ModEvent.send(handle)
				
;				newvictim.RemoveItem(OwnEgg,1,true)
;				newvictim.AddItem(Inertform,1,true)
				
			endif
			
		endif
	EndIf

EndEvent

