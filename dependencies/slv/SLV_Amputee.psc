Scriptname SLV_Amputee extends Quest  

Function SLV_AmputeeActor(Actor NPCActor, int bodypard)
if MCMMenu.skipAmputee
	return
endif

if Game.GetModByName("Amputator.esm") == 255
	return
endif

AmputatorMainScript  AMS = Quest.GetQuest("AmputatorMain") as AmputatorMainScript 

AMS.ApplyAmputator(NPCActor,bodypard,0)
Utility.wait(2.0)
EndFunction



Function SLV_CopyAmputees(Actor NPCFromActor,Actor NPCToActor)
if MCMMenu.skipAmputee
	return
endif

if Game.GetModByName("Amputator.esm") == 255
	return
endif

AmputatorMainScript  AMS = Quest.GetQuest("AmputatorMain") as AmputatorMainScript 

;1 = Feet
;2 = Lower Legs
;3 = Upper Legs
;4 = Hands
;5 = Forearms
;6 = UpperArms

Spell leftFeet = AMS.AmputeeAbilitiesLeft[0]
Spell leftLowerLegs = AMS.AmputeeAbilitiesLeft[1]
Spell leftUpperLegs = AMS.AmputeeAbilitiesLeft[2]
Spell leftHands = AMS.AmputeeAbilitiesLeft[3]
Spell leftForearms = AMS.AmputeeAbilitiesLeft[4]
Spell leftUpperArms = AMS.AmputeeAbilitiesLeft[5]

Spell rightFeet = AMS.AmputeeAbilitiesRight[0]
Spell rightLowerLegs = AMS.AmputeeAbilitiesRight[1]
Spell rightUpperLegs = AMS.AmputeeAbilitiesRight[2]
Spell rightHands = AMS.AmputeeAbilitiesRight[3]
Spell rightForearms = AMS.AmputeeAbilitiesRight[4]
Spell rightUpperArms = AMS.AmputeeAbilitiesRight[5]

AMS.ApplyAmputator(NPCToActor,0,1)

if NPCFromActor.HasSpell(leftFeet)
	AMS.ApplyAmputator(NPCToActor,1,1)
endif
if NPCFromActor.HasSpell(leftLowerLegs )
	AMS.ApplyAmputator(NPCToActor,2,1)
endif
if NPCFromActor.HasSpell(leftUpperLegs )
	AMS.ApplyAmputator(NPCToActor,3,1)
endif
if NPCFromActor.HasSpell(leftHands )
	AMS.ApplyAmputator(NPCToActor,4,1)
endif
if NPCFromActor.HasSpell(leftForearms )
	AMS.ApplyAmputator(NPCToActor,5,1)
endif
if NPCFromActor.HasSpell(leftUpperArms )
	AMS.ApplyAmputator(NPCToActor,6,1)
endif

if NPCFromActor.HasSpell( rightFeet)
	AMS.ApplyAmputator(NPCToActor,1,2)
endif
if NPCFromActor.HasSpell(rightLowerLegs )
	AMS.ApplyAmputator(NPCToActor,2,2)
endif
if NPCFromActor.HasSpell(rightUpperLegs )
	AMS.ApplyAmputator(NPCToActor,3,2)
endif
if NPCFromActor.HasSpell(rightHands )
	AMS.ApplyAmputator(NPCToActor,4,2)
endif
if NPCFromActor.HasSpell(rightForearms )
	AMS.ApplyAmputator(NPCToActor,5,2)
endif
if NPCFromActor.HasSpell(rightUpperArms )
	AMS.ApplyAmputator(NPCToActor,6,2)
endif
EndFunction



Function SLV_ProgressiveAmputeeActor(Actor NPCActor)
SLV_ProgressiveAmputeeActor2(NPCActor, false)
EndFunction

Function SLV_ProgressiveAmputeeActor2(Actor NPCActor, bool addProstetics= false)
if MCMMenu.skipAmputee
	return
endif

if Game.GetModByName("Amputator.esm") == 255
	return
endif

AmputatorMainScript  AMS = Quest.GetQuest("AmputatorMain") as AmputatorMainScript 

;1 = Feet
;2 = Lower Legs
;3 = Upper Legs
;4 = Hands
;5 = Forearms
;6 = UpperArms

Spell leftFeet = AMS.AmputeeAbilitiesLeft[0]
Spell leftLowerLegs = AMS.AmputeeAbilitiesLeft[1]
Spell leftUpperLegs = AMS.AmputeeAbilitiesLeft[2]
Spell leftHands = AMS.AmputeeAbilitiesLeft[3]
Spell leftForearms = AMS.AmputeeAbilitiesLeft[4]
Spell leftUpperArms = AMS.AmputeeAbilitiesLeft[5]

Spell rightFeet = AMS.AmputeeAbilitiesRight[0]
Spell rightLowerLegs = AMS.AmputeeAbilitiesRight[1]
Spell rightUpperLegs = AMS.AmputeeAbilitiesRight[2]
Spell rightHands = AMS.AmputeeAbilitiesRight[3]
Spell rightForearms = AMS.AmputeeAbilitiesRight[4]
Spell rightUpperArms = AMS.AmputeeAbilitiesRight[5]


Armor leftFeetProt  = Game.GetFormFromFile(0x6931, "Amputator.esm") as Armor
Armor rightFeetProt = Game.GetFormFromFile(0x99AC, "Amputator.esm") as Armor

Armor leftLowerLegProt = Game.GetFormFromFile(0x4370, "Amputator.esm") as Armor
Armor rightLowerLegProt = Game.GetFormFromFile(0x3341, "Amputator.esm") as Armor

Armor leftLegProt = Game.GetFormFromFile(0x5E5E, "Amputator.esm") as Armor
Armor rightLegProt = Game.GetFormFromFile(0x5E63, "Amputator.esm") as Armor

Armor leftForearmsProt = Game.GetFormFromFile(0x3342, "Amputator.esm") as Armor
Armor rightForearmsProt = Game.GetFormFromFile(0x436D, "Amputator.esm") as Armor

Armor leftUpperArmProt = Game.GetFormFromFile(0x5E65, "Amputator.esm") as Armor
Armor rightUpperArmProt = Game.GetFormFromFile(0x5E64, "Amputator.esm") as Armor

int bodypart = 0
int side = 0

if !NPCActor.HasSpell(leftUpperLegs)
	if !NPCActor.HasSpell(leftLowerLegs) 
		if !NPCActor.HasSpell(leftFeet)
			AMS.ApplyAmputator(NPCActor,1,1)
		else
			AMS.ApplyAmputator(NPCActor,2,1)
			if addProstetics
				NPCActor.equipItem(leftFeetProt )
			endif
		endif
	else
		AMS.ApplyAmputator(NPCActor,3,1)
		if addProstetics
			NPCActor.equipItem(leftLegProt)
		endif
	endif
elseif !NPCActor.HasSpell(rightUpperLegs)
	if !NPCActor.HasSpell(rightLowerLegs) 
		if !NPCActor.HasSpell(rightFeet)
			AMS.ApplyAmputator(NPCActor,1,2)
		else
			AMS.ApplyAmputator(NPCActor,2,2)
			if addProstetics
				NPCActor.equipItem(rightFeetProt )
			endif
		endif
	else
		AMS.ApplyAmputator(NPCActor,3,2)
		if addProstetics
			NPCActor.equipItem(rightLegProt)
		endif
	endif
elseif !NPCActor.HasSpell(leftUpperArms)
	if !NPCActor.HasSpell(leftForearms) 
		if !NPCActor.HasSpell(leftHands)
			AMS.ApplyAmputator(NPCActor,4,1)
		else
			AMS.ApplyAmputator(NPCActor,5,1)
			if addProstetics
				NPCActor.equipItem(leftForearmsProt )
			endif
		endif
	else
		AMS.ApplyAmputator(NPCActor,6,1)
			if addProstetics
			NPCActor.equipItem(leftUpperArmProt )
		endif
	endif
elseif !NPCActor.HasSpell(rightUpperArms)
	if !NPCActor.HasSpell(rightForearms) 
		if !NPCActor.HasSpell(rightHands)
			AMS.ApplyAmputator(NPCActor,4,2)
		else
			AMS.ApplyAmputator(NPCActor,5,2)
			if addProstetics
				NPCActor.equipItem(rightForearmsProt )
			endif
		endif
	else
		AMS.ApplyAmputator(NPCActor,6,2)
		if addProstetics
			NPCActor.equipItem(rightUpperArmProt )
		endif
	endif
endif

;Utility.wait(2.0)
EndFunction



Function SLV_OnLoadGameIvanaAmputee()
int IvanaAmputee = SLV_AmputeeIvana.getValue() as int

if SLV_SlavetrainingQuest.IsCompleted() ; .getStage() >= 1200
	SLV_Ivana.getActorRef().getActorBase().setName("Ivana Tittyfuck")
endif

if IvanaAmputee == 0 || SLV_Ivana == none || SLV_Ivana.getActorRef() == none || SLV_Ivana.getActorRef().getCurrentLocation() == none
	return
endif

Utility.wait(2.0)
if !SLV_Ivana.getActorRef().getCurrentLocation().IsSameLocation(SLV_Player.getActorRef().getCurrentLocation())
	return
endif

SLV_AmputeeActor(SLV_Ivana.getActorRef(),IvanaAmputee )
EndFunction



Function SLV_ApplyProstetics(Actor ActorNPC, int bodypart)
if Game.GetModByName("Amputator.esm") == 255
	return
endif
if MCMMenu.skipAmputee
	return
endif

int bodypart2 = 0

if bodypart > 6
	bodypart2 = bodypart - 6	
	bodypart = 6
endif

Armor leftFeet  = Game.GetFormFromFile(0x6931, "Amputator.esm") as Armor
Armor rightFeet = Game.GetFormFromFile(0x99AC, "Amputator.esm") as Armor

Armor leftLowerLeg = Game.GetFormFromFile(0x4370, "Amputator.esm") as Armor
Armor rightLowerLeg = Game.GetFormFromFile(0x3341, "Amputator.esm") as Armor

Armor leftLeg = Game.GetFormFromFile(0x5E5E, "Amputator.esm") as Armor
Armor rightLeg = Game.GetFormFromFile(0x5E63, "Amputator.esm") as Armor

Armor leftForearms = Game.GetFormFromFile(0x3342, "Amputator.esm") as Armor
Armor rightForearms = Game.GetFormFromFile(0x436D, "Amputator.esm") as Armor

Armor leftUpperArm = Game.GetFormFromFile(0x5E65, "Amputator.esm") as Armor
Armor rightUpperArm = Game.GetFormFromFile(0x5E64, "Amputator.esm") as Armor

if(bodypart == 1 || bodypart2 == 1)
	;ActorNPC.equipItem(leftFeet )
	;ActorNPC.equipItem(rightFeet )
endif
if(bodypart == 2 || bodypart2 == 2)
	ActorNPC.equipItem(leftFeet )
	ActorNPC.equipItem(rightFeet )
	;ActorNPC.equipItem(leftLowerLeg )
	;ActorNPC.equipItem(rightLowerLeg )
endif
if(bodypart == 3 || bodypart2 == 3)
	ActorNPC.equipItem(leftLeg)
	ActorNPC.equipItem(rightLeg)
endif
if(bodypart == 5 || bodypart2 == 5)
	ActorNPC.equipItem(leftForearms )
	ActorNPC.equipItem(rightForearms )
endif
if(bodypart == 6 || bodypart2 == 6)
	ActorNPC.equipItem(leftUpperArm )
	ActorNPC.equipItem(rightUpperArm )
endif
EndFunction
ReferenceAlias Property SLV_Ivana Auto
ReferenceAlias Property SLV_Player Auto
GlobalVariable Property SLV_AmputeeIvana Auto 
Quest Property SLV_Main Auto
Quest Property SLV_SlavetrainingQuest Auto
SLV_MCMMenu Property MCMMenu Auto