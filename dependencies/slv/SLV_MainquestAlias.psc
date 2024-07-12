Scriptname SLV_MainquestAlias extends ReferenceAlias  

Event OnPlayerLoadGame()
Utility.wait(5)
;MiscUtil.PrintConsole("MCM Jarl of Whiterun= " + pJarlBackup.GetActorRef().getActorBase().getName())
pJarl.ForceRefTo(pJarlBackup.GetActorRef())
;MiscUtil.PrintConsole("Jarl of Whiterun= " + pJarl.GetActorRef().getActorBase().getName())

;MiscUtil.PrintConsole("Slaverun is looking for the carriage drivers..." )

if Game.GetModByName("CFTO.esp") != 255
   	Actor whiterundriver = Game.GetFormFromFile(0x0bbf6d, "CFTO.esp") as Actor
	SLV_WhiterunCarriageDriver.ForceRefTo(whiterundriver)

   	Actor markarthdriver = Game.GetFormFromFile(0x09d8bf, "CFTO.esp") as Actor
	SLV_MarkarthCarriageDriver.ForceRefTo(markarthdriver )

   	Actor riftendriver = Game.GetFormFromFile(0x0bbf7f, "CFTO.esp") as Actor
	SLV_RiftenCarriageDriver.ForceRefTo(riftendriver )

   	Actor solitudedriver = Game.GetFormFromFile(0x0bbf76, "CFTO.esp") as Actor
	SLV_SolitudeCarriageDriver.ForceRefTo(solitudedriver )

   	Actor windhelmdriver = Game.GetFormFromFile(0x0bbf6e, "CFTO.esp") as Actor
	SLV_WindhelmCarriageDriver.ForceRefTo(windhelmdriver )
else
   	Actor whiterundriver = Game.GetFormFromFile(0x013698, "Skyrim.esm") as Actor
	SLV_WhiterunCarriageDriver.ForceRefTo(whiterundriver)

   	Actor markarthdriver = Game.GetFormFromFile(0x03f220, "Skyrim.esm") as Actor
	SLV_MarkarthCarriageDriver.ForceRefTo(markarthdriver )

   	Actor riftendriver = Game.GetFormFromFile(0x09b7b4, "Skyrim.esm") as Actor
	SLV_RiftenCarriageDriver.ForceRefTo(riftendriver )

   	Actor solitudedriver = Game.GetFormFromFile(0x09b7b1, "Skyrim.esm") as Actor
	SLV_SolitudeCarriageDriver.ForceRefTo(solitudedriver )

   	Actor windhelmdriver = Game.GetFormFromFile(0x09b7c8, "Skyrim.esm") as Actor
	SLV_WindhelmCarriageDriver.ForceRefTo(windhelmdriver )
endif

EndEvent
ReferenceAlias Property pJarl Auto 
ReferenceAlias Property pJarlBackup Auto 

ReferenceAlias Property SLV_WhiterunCarriageDriver Auto
ReferenceAlias Property SLV_MarkarthCarriageDriver Auto
ReferenceAlias Property SLV_RiftenCarriageDriver Auto
ReferenceAlias Property SLV_SolitudeCarriageDriver Auto
ReferenceAlias Property SLV_WindhelmCarriageDriver Auto

