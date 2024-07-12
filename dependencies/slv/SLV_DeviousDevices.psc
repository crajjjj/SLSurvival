Scriptname SLV_DeviousDevices extends Quest  

Function SLV_DeviousProgressiveUnEquipActor(Actor NPCActor,bool random)
bool equipGag = false;
bool equipAnalPlug = false;
bool equipVagPlug = false;
bool equipHarness = false;
bool equipBelt = false;
bool equipBra = false;
bool equipCollar = false;
bool equipLegCuffs = false;
bool equipArmCuffs = false;
bool equipArmbinder = false;
bool equipYoke = false;
bool equipBlindfold = false;
bool equipNPiercings = false;
bool equipVPiercings = false;
bool equipBoots = false;
bool equipGloves = false;
bool equipCorset = false;
bool equipMittens=false;
bool equipHood=false;
bool equipClamps=false;
bool equipSuit=false;
bool equipShackles=false;
bool equipHobblesSkirt=false;
bool equipHobblesSkirtRelaxed=false;
bool equipStraitJacket=false;

; StraitJacket?
if !NPCActor.WornHasKeyword(libs.zad_DeviousStraitJacket) && !NPCActor.WornHasKeyword(libs.zad_DeviousArmbinder) && !NPCActor.WornHasKeyword(libs.zad_DeviousYoke)
	equipStraitJacket = true;
	SLV_DeviousUnEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif

; armbinder?
if !NPCActor.WornHasKeyword(libs.zad_DeviousArmbinder) && !NPCActor.WornHasKeyword(libs.zad_DeviousYoke)
	equipArmbinder = true;
	SLV_DeviousUnEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif

; suit?
if !NPCActor.WornHasKeyword(libs.zad_DeviousSuit) 
	equipSuit = true;
	SLV_DeviousUnEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif

; gag?
if !NPCActor.WornHasKeyword(libs.zad_DeviousGag)
	equipGag = true;
	SLV_DeviousUnEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif

; bra?
if !NPCActor.WornHasKeyword(libs.zad_DeviousBra)
	equipBra = true;
	SLV_DeviousUnEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif

; belt?
if !NPCActor.WornHasKeyword(libs.zad_DeviousBelt) && !NPCActor.WornHasKeyword(libs.zad_DeviousHarness)
	equipBelt = true;
	SLV_DeviousUnEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif

; blindfold?
if !NPCActor.WornHasKeyword(libs.zad_DeviousBlindfold)
	equipBlindfold = true;
	SLV_DeviousUnEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif

; gloves?
if !NPCActor.WornHasKeyword(libs.zad_DeviousGloves)
	equipGloves = true;
	SLV_DeviousUnEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif

; corset?
if !NPCActor.WornHasKeyword(libs.zad_DeviousHarness) && !NPCActor.WornHasKeyword(libs.zad_DeviousCorset)
	equipCorset = true;
	SLV_DeviousUnEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif

; anal plug?
if !NPCActor.WornHasKeyword(libs.zad_DeviousPlugAnal)
	equipAnalPlug = true;
	SLV_DeviousUnEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif

; vaginal plug?
if !NPCActor.WornHasKeyword(libs.zad_DeviousPlugVaginal)
	equipVagPlug = true;
	SLV_DeviousUnEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif

; vaginal piercing?
if !NPCActor.WornHasKeyword(libs.zad_DeviousPiercingsVaginal) && (!NPCActor.WornHasKeyword(libs.zad_DeviousBelt))
	equipVPiercings = true;
	SLV_DeviousUnEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif

; nipple piercings?
if !NPCActor.WornHasKeyword(libs.zad_DeviousPiercingsNipple) && (!NPCActor.WornHasKeyword(libs.zad_DeviousBra) || !NPCActor.WornHasKeyword(libs.zad_DeviousClamps))
	equipNPiercings = true;
	SLV_DeviousUnEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif

; boots?
if !NPCActor.WornHasKeyword(libs.zad_DeviousBoots)
	equipBoots = true;
	SLV_DeviousUnEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif

; arm cuffs?
if !NPCActor.WornHasKeyword(libs.zad_DeviousArmCuffs)
	equipArmCuffs = true;
	SLV_DeviousUnEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif

; leg cuffs?
if !NPCActor.WornHasKeyword(libs.zad_DeviousLegCuffs)
	equipLegCuffs = true;
	SLV_DeviousUnEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif
EndFunction


Function SLV_DeviousProgressiveEquipActor(Actor NPCActor,bool random)
bool equipGag = false;
bool equipAnalPlug = false;
bool equipVagPlug = false;
bool equipHarness = false;
bool equipBelt = false;
bool equipBra = false;
bool equipCollar = false;
bool equipLegCuffs = false;
bool equipArmCuffs = false;
bool equipArmbinder = false;
bool equipYoke = false;
bool equipBlindfold = false;
bool equipNPiercings = false;
bool equipVPiercings = false;
bool equipBoots = false;
bool equipGloves = false;
bool equipCorset = false;
bool equipMittens=false;
bool equipHood=false;
bool equipClamps=false;
bool equipSuit=false;
bool equipShackles=false;
bool equipHobblesSkirt=false;
bool equipHobblesSkirtRelaxed=false;
bool equipStraitJacket=false;


bool npcIsFemale = true
if NPCActor.getActorBase().getSex() == 0
	npcIsFemale = false
endif
if npcIsFemale && MCMMenu.SkipDevices
	return
endif
if !npcIsFemale && MCMMenu.SkipDevicesForMen
	return
endif

bool isAllowedGag = MCMMenu.equipGag;
bool isAllowedAnalPlug = MCMMenu.equipAnalPlug;
bool isAllowedVagPlug = MCMMenu.equipVagPlug;
bool isAllowedHarness = MCMMenu.equipHarness;
bool isAllowedBelt = MCMMenu.equipBelt;
bool isAllowedBra = MCMMenu.equipBra;
bool isAllowedCollar = MCMMenu.equipCollar;
bool isAllowedLegCuffs = MCMMenu.equipLegCuffs;
bool isAllowedArmCuffs = MCMMenu.equipArmCuffs;
bool isAllowedArmbinder = MCMMenu.equipArmbinder;
bool isAllowedYoke = MCMMenu.equipYoke;
bool isAllowedBlindfold = MCMMenu.equipBlindfold;
bool isAllowedNPiercings = MCMMenu.equipNPiercings;
bool isAllowedVPiercings = MCMMenu.equipVPiercings;
bool isAllowedBoots = MCMMenu.equipBoots;
bool isAllowedGloves = MCMMenu.equipGloves;
bool isAllowedCorset = MCMMenu.equipCorset;
bool isAllowedMittens=MCMMenu.equipMittens
bool isAllowedHood=MCMMenu.equipHood
bool isAllowedClamps=MCMMenu.equipClamps
bool isAllowedSuit=MCMMenu.equipSuit
bool isAllowedShackles=MCMMenu.equipShackles
bool isAllowedHobblesSkirt=MCMMenu.equipHobblesSkirt
bool isAllowedHobblesSkirtRelaxed=MCMMenu.equipHobblesSkirtRelaxed
bool isAllowedStraitJacket=MCMMenu.equipStraitJacket

if !npcIsFemale
	isAllowedGag = MCMMenu.equipMaleGag;
	isAllowedAnalPlug = MCMMenu.equipMaleAnalPlug;
	isAllowedVagPlug = MCMMenu.equipMaleVagPlug;
	isAllowedHarness = MCMMenu.equipMaleHarness;
	isAllowedBelt = MCMMenu.equipMaleBelt;
	isAllowedBra = MCMMenu.equipMaleBra;
	isAllowedCollar = MCMMenu.equipMaleCollar;
	isAllowedLegCuffs = MCMMenu.equipMaleLegCuffs;
	isAllowedArmCuffs = MCMMenu.equipMaleArmCuffs;
	isAllowedArmbinder = MCMMenu.equipMaleArmbinder;
	isAllowedYoke = MCMMenu.equipMaleYoke;
	isAllowedBlindfold = MCMMenu.equipMaleBlindfold;
	isAllowedNPiercings = MCMMenu.equipMaleNPiercings;
	isAllowedVPiercings = MCMMenu.equipMaleVPiercings;
	isAllowedBoots = MCMMenu.equipMaleBoots;
	isAllowedGloves = MCMMenu.equipMaleGloves;
	isAllowedCorset = MCMMenu.equipMaleCorset;
	isAllowedMittens=MCMMenu.equipMaleMittens;
	isAllowedHood=MCMMenu.equipMaleHood;
	isAllowedClamps=MCMMenu.equipMaleClamps;
	isAllowedSuit=MCMMenu.equipMaleSuit;
	isAllowedShackles=MCMMenu.equipMaleShackles;
	isAllowedHobblesSkirt=MCMMenu.equipMaleHobblesSkirt;
	isAllowedHobblesSkirtRelaxed=MCMMenu.equipMaleHobblesSkirtRelaxed;
endif

; collar?
if isAllowedCollar && !NPCActor.WornHasKeyword(libs.zad_DeviousCollar) && !NPCActor.WornHasKeyword(libs.zad_DeviousHarness)
	equipCollar = true;
	SLV_DeviousEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif
; arm cuffs?
if isAllowedArmCuffs && !NPCActor.WornHasKeyword(libs.zad_DeviousArmCuffs)
	equipArmCuffs = true;
	SLV_DeviousEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif
; leg cuffs?
if isAllowedLegCuffs && !NPCActor.WornHasKeyword(libs.zad_DeviousLegCuffs)
	equipLegCuffs = true;
	SLV_DeviousEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif
; boots?
if isAllowedBoots && !NPCActor.WornHasKeyword(libs.zad_DeviousBoots)
	equipBoots = true;
	SLV_DeviousEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif
; nipple piercings?
if isAllowedNPiercings && !NPCActor.WornHasKeyword(libs.zad_DeviousPiercingsNipple) && (!NPCActor.WornHasKeyword(libs.zad_DeviousBra) || !NPCActor.WornHasKeyword(libs.zad_DeviousClamps))
	equipNPiercings = true;
	SLV_DeviousEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif
; vaginal piercing?
if isAllowedVPiercings && !NPCActor.WornHasKeyword(libs.zad_DeviousPiercingsVaginal) && (!NPCActor.WornHasKeyword(libs.zad_DeviousBelt))
	equipVPiercings = true;
	SLV_DeviousEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif
; vaginal plug?
if isAllowedVagPlug && !NPCActor.WornHasKeyword(libs.zad_DeviousPlugVaginal)
	equipVagPlug = true;
	SLV_DeviousEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif
; anal plug?
if isAllowedAnalPlug && !NPCActor.WornHasKeyword(libs.zad_DeviousPlugAnal)
	equipAnalPlug = true;
	SLV_DeviousEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif
; corset?
if isAllowedCorset && !NPCActor.WornHasKeyword(libs.zad_DeviousHarness) && !NPCActor.WornHasKeyword(libs.zad_DeviousCorset)
	equipCorset = true;
	SLV_DeviousEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif
; gloves?
if isAllowedGloves && !NPCActor.WornHasKeyword(libs.zad_DeviousGloves)
	equipGloves = true;
	SLV_DeviousEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif
; blindfold?
if isAllowedBlindfold && !NPCActor.WornHasKeyword(libs.zad_DeviousBlindfold)
	equipBlindfold = true;
	SLV_DeviousEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif
; belt?
if isAllowedBelt && !NPCActor.WornHasKeyword(libs.zad_DeviousBelt) && !NPCActor.WornHasKeyword(libs.zad_DeviousHarness)
	equipBelt = true;
	SLV_DeviousEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif
; bra?
if isAllowedBra && !NPCActor.WornHasKeyword(libs.zad_DeviousBra)
	equipBra = true;
	SLV_DeviousEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif
; gag?
if isAllowedGag && !NPCActor.WornHasKeyword(libs.zad_DeviousGag)
	equipGag = true;
	SLV_DeviousEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif
; suit?
if isAllowedSuit && !NPCActor.WornHasKeyword(libs.zad_DeviousSuit) 
	equipSuit = true;
	SLV_DeviousEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif

; armbinder?
if isAllowedArmbinder && !NPCActor.WornHasKeyword(libs.zad_DeviousArmbinder) && !NPCActor.WornHasKeyword(libs.zad_DeviousYoke)
	equipArmbinder = true;
	SLV_DeviousEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif

; StraitJacket?
if isAllowedStraitJacket && !NPCActor.WornHasKeyword(libs.zad_DeviousStraitJacket) && !NPCActor.WornHasKeyword(libs.zad_DeviousArmbinder) && !NPCActor.WornHasKeyword(libs.zad_DeviousYoke)
	equipStraitJacket = true;
	SLV_DeviousEquipActor(NPCActor,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipLegCuffs,equipArmCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed,equipStraitJacket)
	return
endif
EndFunction


Function SLV_DeviousEquipActor(Actor NPCActor,bool equipGag,bool equipAnalPlug,bool equipVagPlug,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipLegCuffs,bool equipArmCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false, bool equipStraitJacket)

string colortag = ""
string tagwhite = ",white"
string tagred = ",red"
string tagblack = ",black"

string tagmetal = ",metal"
string tagleather = ",leather"
string tagebonite = ",ebonite"
string themetag = ""

int color = MCMMenu.equipcolor
if NPCActor != Game.getPlayer()
	color = MCMMenu.npcoutfitcolor
endif
if(color == 1) 
	colortag = tagwhite 
elseif (color == 2)
	colortag = tagred
elseif (color == 3)
	colortag = tagblack
endif

int theme = MCMMenu.equiptheme
if(theme == 1) 
	themetag = tagmetal 
elseif (theme == 2)
	themetag = tagleather 
elseif (theme == 3)
	themetag = tagebonite 
endif

SLV_DeviousEquipActorColor(NPCActor,colortag,themetag,equipGag,equipAnalPlug,equipVagPlug,equipHarness,equipBelt,equipBra,equipCollar,equipArmCuffs,equipLegCuffs,equipArmbinder,equipYoke,equipBlindfold,equipNPiercings,equipVPiercings,equipBoots,equipGloves,equipCorset,equipMittens,equipHood,equipClamps,equipSuit,equipShackles,equipHobblesSkirt,equipHobblesSkirtRelaxed, equipStraitJacket)
EndFunction



Function SLV_DeviousUnEquipActor(Actor NPCActor,bool equipGag,bool equipAnalPlug,bool equipVagPlug,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipLegCuffs,bool equipArmCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=true, bool equipHood=true, bool equipClamps=true, bool equipSuit=true, bool equipShackles=true, bool equipHobblesSkirt=true, bool equipHobblesSkirtRelaxed=true, bool equipStraitJacket=true)


SLV_DisplayInformation("SLV_DeviousUnEquipActor gag: " + equipGag);
SLV_DisplayInformation("SLV_DeviousUnEquipActor collar: " + equipCollar);
SLV_DisplayInformation("SLV_DeviousUnEquipActor suit: " + equipSuit);

string exclTags = "DCexcluded"
string gagTags = "gag,ring"
string beltTags = "belt,open"
string harnessTags = "harness"

if !NPCActor || NPCActor == none
	NPCActor = PlayerRef
endif

if equipGag&& NPCActor.WornHasKeyword(libs.zad_DeviousGag)
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetWornDevice(NPCActor, Libs.zad_DeviousGag), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
if equipBelt&& NPCActor.WornHasKeyword(libs.zad_DeviousBelt)
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetWornDevice(NPCActor, Libs.zad_DeviousBelt), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
if equipVagPlug&& NPCActor.WornHasKeyword(libs.zad_DeviousPlugVaginal)
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetWornDevice(NPCActor, Libs.zad_DeviousPlugVaginal), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
if equipAnalPlug&& NPCActor.WornHasKeyword(libs.zad_DeviousPlugAnal)
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetWornDevice(NPCActor, Libs.zad_DeviousPlugAnal), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
if equipHarness&& NPCActor.WornHasKeyword(libs.zad_DeviousHarness)
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetWornDevice(NPCActor, Libs.zad_DeviousHarness), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif

if equipBra&& NPCActor.WornHasKeyword(libs.zad_DeviousBra)
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetWornDevice(NPCActor, Libs.zad_DeviousBra), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
if equipCollar&& NPCActor.WornHasKeyword(libs.zad_DeviousCollar)
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetWornDevice(NPCActor, Libs.zad_DeviousCollar), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
if equipArmCuffs&& NPCActor.WornHasKeyword(libs.zad_DeviousArmCuffs)
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetWornDevice(NPCActor, Libs.zad_DeviousArmCuffs), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
if equipLegCuffs&& NPCActor.WornHasKeyword(libs.zad_DeviousLegCuffs)
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetWornDevice(NPCActor, Libs.zad_DeviousLegCuffs), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
if equipYoke && NPCActor.WornHasKeyword(libs.zad_DeviousYoke)
	;Libs.ManipulateGenericDevice(NPCActor, Libs.GetWornDevice(NPCActor, Libs.zad_DeviousYoke), FALSE, FALSE, TRUE)
	Armor yoke = Libs.GetWornDevice(NPCActor, Libs.zad_DeviousYoke)
	if yoke
		Libs.ManipulateGenericDevice(NPCActor, yoke, FALSE, FALSE, TRUE)
	endif
	Armor heavyArmor = Libs.GetWornDevice(NPCActor, Libs.zad_DeviousHeavyBondage)
	if heavyArmor
		Libs.ManipulateGenericDevice(NPCActor, heavyArmor, FALSE, FALSE, TRUE)
	endif
	
	;Utility.wait(1.0)
endif
if equipArmbinder && NPCActor.WornHasKeyword(libs.zad_DeviousArmbinder)
	Armor armbinder = Libs.GetWornDevice(NPCActor, Libs.zad_DeviousArmbinder)
	if armbinder
		Libs.ManipulateGenericDevice(NPCActor, armbinder, FALSE, FALSE, TRUE)
	endif
	Armor heavyArmor = Libs.GetWornDevice(NPCActor, Libs.zad_DeviousHeavyBondage)
	if heavyArmor
		Libs.ManipulateGenericDevice(NPCActor, heavyArmor, FALSE, FALSE, TRUE)
	endif
	;Utility.wait(1.0)
endif
if equipBlindfold&& NPCActor.WornHasKeyword(libs.zad_DeviousBlindfold)
	Libs.ManipulateGenericDevice(NPCActor,  Libs.GetWornDevice(NPCActor, Libs.zad_DeviousBlindfold), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
if equipNPiercings&& NPCActor.WornHasKeyword(libs.zad_DeviousPiercingsNipple)
	Libs.ManipulateGenericDevice(NPCActor,  Libs.GetWornDevice(NPCActor, Libs.zad_DeviousPiercingsNipple), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
if equipVPiercings&& NPCActor.WornHasKeyword(libs.zad_DeviousPiercingsVaginal)
	Libs.ManipulateGenericDevice(NPCActor,  Libs.GetWornDevice(NPCActor, Libs.zad_DeviousPiercingsVaginal), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
if equipBoots&& NPCActor.WornHasKeyword(libs.zad_DeviousBoots)
	Libs.ManipulateGenericDevice(NPCActor,  Libs.GetWornDevice(NPCActor, Libs.zad_DeviousBoots), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
if equipGloves&& NPCActor.WornHasKeyword(libs.zad_DeviousGloves)
	Libs.ManipulateGenericDevice(NPCActor,  Libs.GetWornDevice(NPCActor, Libs.zad_DeviousGloves), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
if equipCorset&& NPCActor.WornHasKeyword(libs.zad_DeviousCorset)
	Libs.ManipulateGenericDevice(NPCActor,  Libs.GetWornDevice(NPCActor, Libs.zad_DeviousCorset), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif


if equipMittens&& NPCActor.WornHasKeyword(libs.zad_DeviousBondageMittens)
	Libs.ManipulateGenericDevice(NPCActor,  Libs.GetWornDevice(NPCActor, Libs.zad_DeviousBondageMittens), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
if equipHood&& NPCActor.WornHasKeyword(libs.zad_DeviousHood)
	Libs.ManipulateGenericDevice(NPCActor,  Libs.GetWornDevice(NPCActor, Libs.zad_DeviousHood), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
if equipClamps&& NPCActor.WornHasKeyword(libs.zad_DeviousClamps)
	Libs.ManipulateGenericDevice(NPCActor,  Libs.GetWornDevice(NPCActor, Libs.zad_DeviousClamps), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
if equipSuit&& NPCActor.WornHasKeyword(libs.zad_DeviousSuit)
	Libs.ManipulateGenericDevice(NPCActor,  Libs.GetWornDevice(NPCActor, Libs.zad_DeviousSuit), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
if equipShackles&& NPCActor.WornHasKeyword(libs.zad_DeviousAnkleShackles)
	Armor shackles = Libs.GetWornDevice(NPCActor, Libs.zad_DeviousAnkleShackles)
	if shackles
		Libs.ManipulateGenericDevice(NPCActor, shackles, FALSE, FALSE, TRUE)
	endif
	Armor heavyArmor = Libs.GetWornDevice(NPCActor, Libs.zad_DeviousHeavyBondage)
	if heavyArmor
		Libs.ManipulateGenericDevice(NPCActor, heavyArmor, FALSE, FALSE, TRUE)
	endif

	;Libs.ManipulateGenericDevice(NPCActor,  Libs.GetWornDevice(NPCActor, Libs.zad_DeviousAnkleShackles), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
if equipHobblesSkirt&& NPCActor.WornHasKeyword(libs.zad_DeviousHobbleSkirt)
	Armor hobble = Libs.GetWornDevice(NPCActor, Libs.zad_DeviousHobbleSkirt)
	if hobble
		Libs.ManipulateGenericDevice(NPCActor, hobble, FALSE, FALSE, TRUE)
	else
		Armor suit = Libs.GetWornDevice(NPCActor, Libs.zad_DeviousSuit)
		if suit
			Libs.ManipulateGenericDevice(NPCActor, suit, FALSE, FALSE, TRUE)
		endif
	endif
	;Libs.ManipulateGenericDevice(NPCActor,  Libs.GetWornDevice(NPCActor, Libs.zad_DeviousHobbleSkirt), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
if equipHobblesSkirtRelaxed&& NPCActor.WornHasKeyword(libs.zad_DeviousHobbleSkirtRelaxed)
	Armor hobble = Libs.GetWornDevice(NPCActor, Libs.zad_DeviousHobbleSkirtRelaxed)
	if hobble
		Libs.ManipulateGenericDevice(NPCActor, hobble, FALSE, FALSE, TRUE)
	else
		Armor suit = Libs.GetWornDevice(NPCActor, Libs.zad_DeviousSuit)
		if suit
			Libs.ManipulateGenericDevice(NPCActor, suit, FALSE, FALSE, TRUE)
		endif
	endif
	;Libs.ManipulateGenericDevice(NPCActor,  Libs.GetWornDevice(NPCActor, Libs.zad_DeviousHobbleSkirtRelaxed), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif

if equipStraitJacket&& NPCActor.WornHasKeyword(libs.zad_DeviousStraitJacket)
	Armor straitJacket = Libs.GetWornDevice(NPCActor, Libs.zad_DeviousStraitJacket)
	if straitJacket
		Libs.ManipulateGenericDevice(NPCActor, straitJacket, FALSE, FALSE, TRUE)
	endif
	Armor heavyArmor = Libs.GetWornDevice(NPCActor, Libs.zad_DeviousHeavyBondage)
	if heavyArmor
		Libs.ManipulateGenericDevice(NPCActor, heavyArmor, FALSE, FALSE, TRUE)
	endif
	;Libs.ManipulateGenericDevice(NPCActor,  Libs.GetWornDevice(NPCActor, Libs.zad_DeviousStraitJacket), FALSE, FALSE, TRUE)
	;Utility.wait(1.0)
endif
endfunction



Function SLV_DeviousEquipActorColor(Actor NPCActor,string colortag="",string themetag="",bool equipGag,bool equipAnalPlug,bool equipVagPlug,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipArmCuffs,bool equipLegCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset,bool equipMittens=false, bool equipHood=false, bool equipClamps=false, bool equipSuit=false, bool equipShackles=false, bool equipHobblesSkirt=false, bool equipHobblesSkirtRelaxed=false, bool equipStraitJacket=false)

bool npcIsFemale = true
if NPCActor.getActorBase().getSex() == 0
	npcIsFemale = false
endif
if npcIsFemale && MCMMenu.SkipDevices
	return
endif
if !npcIsFemale && MCMMenu.SkipDevicesForMen
	return
endif

bool isAllowedGag = MCMMenu.equipGag;
bool isAllowedAnalPlug = MCMMenu.equipAnalPlug;
bool isAllowedVagPlug = MCMMenu.equipVagPlug;
bool isAllowedHarness = MCMMenu.equipHarness;
bool isAllowedBelt = MCMMenu.equipBelt;
bool isAllowedBra = MCMMenu.equipBra;
bool isAllowedCollar = MCMMenu.equipCollar;
bool isAllowedLegCuffs = MCMMenu.equipLegCuffs;
bool isAllowedArmCuffs = MCMMenu.equipArmCuffs;
bool isAllowedArmbinder = MCMMenu.equipArmbinder;
bool isAllowedYoke = MCMMenu.equipYoke;
bool isAllowedBlindfold = MCMMenu.equipBlindfold;
bool isAllowedNPiercings = MCMMenu.equipNPiercings;
bool isAllowedVPiercings = MCMMenu.equipVPiercings;
bool isAllowedBoots = MCMMenu.equipBoots;
bool isAllowedGloves = MCMMenu.equipGloves;
bool isAllowedCorset = MCMMenu.equipCorset;
bool isAllowedMittens=MCMMenu.equipMittens
bool isAllowedHood=MCMMenu.equipHood
bool isAllowedClamps=MCMMenu.equipClamps
bool isAllowedSuit=MCMMenu.equipSuit
bool isAllowedShackles=MCMMenu.equipShackles
bool isAllowedHobblesSkirt=MCMMenu.equipHobblesSkirt
bool isAllowedHobblesSkirtRelaxed=MCMMenu.equipHobblesSkirtRelaxed
bool isAllowedStraitJacket=MCMMenu.equipStraitJacket

if !npcIsFemale
	isAllowedGag = MCMMenu.equipMaleGag;
	isAllowedAnalPlug = MCMMenu.equipMaleAnalPlug;
	isAllowedVagPlug = MCMMenu.equipMaleVagPlug;
	isAllowedHarness = MCMMenu.equipMaleHarness;
	isAllowedBelt = MCMMenu.equipMaleBelt;
	isAllowedBra = MCMMenu.equipMaleBra;
	isAllowedCollar = MCMMenu.equipMaleCollar;
	isAllowedLegCuffs = MCMMenu.equipMaleLegCuffs;
	isAllowedArmCuffs = MCMMenu.equipMaleArmCuffs;
	isAllowedArmbinder = MCMMenu.equipMaleArmbinder;
	isAllowedYoke = MCMMenu.equipMaleYoke;
	isAllowedBlindfold = MCMMenu.equipMaleBlindfold;
	isAllowedNPiercings = MCMMenu.equipMaleNPiercings;
	isAllowedVPiercings = MCMMenu.equipMaleVPiercings;
	isAllowedBoots = MCMMenu.equipMaleBoots;
	isAllowedGloves = MCMMenu.equipMaleGloves;
	isAllowedCorset = MCMMenu.equipMaleCorset;
	isAllowedMittens=MCMMenu.equipMaleMittens;
	isAllowedHood=MCMMenu.equipMaleHood;
	isAllowedClamps=MCMMenu.equipMaleClamps;
	isAllowedSuit=MCMMenu.equipMaleSuit;
	isAllowedShackles=MCMMenu.equipMaleShackles;
	isAllowedHobblesSkirt=MCMMenu.equipMaleHobblesSkirt;
	isAllowedHobblesSkirtRelaxed=MCMMenu.equipMaleHobblesSkirtRelaxed;
endif

;if NPCActor == PlayerRef
;	themetag = ""
;endif

;Deviously equip the devices
string exclTags = "DCexcluded"

string bratag = "bra"
string gagTags = "gag,ring"
string beltTags = "belt,open"
string harnesstag = "harness" ;",open"
string corsettag =  "corset" 
string collartag =  "collar" 
string bootstag =  "boots" 
string glovestag =  "gloves" 
string blindfoldtag =  "blindfold" 
string armbindertag =  "armbinder" 
string armcuffstag =  "cuffs,arms" 
string legcuffstag =  "cuffs,legs" 

string mittenstag =  "mittens,paw" 
string hoodtag =  "hood" 
string hoblesskirttag =  "hobble,elegant" ;"dress,hobble,elegant" 
string hoblesskirtrelaxedtag =  "hobble,relaxed" ;"dress,hobble,relaxed" 
string suittag = "suit"
string jackettag = ""

gagTags = gagTags + colortag
harnesstag = harnesstag + colortag 
corsettag = corsettag + colortag 
collartag = collartag + colortag + themetag
bootstag = bootstag + colortag 
glovestag = glovestag + colortag 
blindfoldtag = blindfoldtag + colortag 
armbindertag = armbindertag + colortag 
armcuffstag = armcuffstag + colortag + themetag
legcuffstag = legcuffstag + colortag + themetag
mittenstag = mittenstag + colortag 
hoodtag = hoodtag ; + colortag 
hoblesskirttag = hoblesskirttag + colortag 
hoblesskirtrelaxedtag = hoblesskirtrelaxedtag + colortag 
suittag = suittag + colortag


equipVPiercings = equipVPiercings  && !NPCActor.WornHasKeyword(libs.zad_DeviousPiercingsVaginal) && (!NPCActor.WornHasKeyword(libs.zad_DeviousBelt))
If equipVPiercings && isAllowedVPiercings
	SLV_DisplayDebug1("DD VPiercing");
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousPiercingsVaginal, tags = "piercing,vaginal", tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
Endif


equipClamps =equipClamps && !NPCActor.WornHasKeyword(libs.zad_DeviousClamps) && (!NPCActor.WornHasKeyword(libs.zad_DeviousBra))
If equipClamps && isAllowedClamps 
	SLV_DisplayDebug1("DD Clamps");
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousClamps, tags = "clamps", tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousClamps, tags = "", tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
Endif


equipNPiercings =equipNPiercings && !NPCActor.WornHasKeyword(libs.zad_DeviousPiercingsNipple) && (!NPCActor.WornHasKeyword(libs.zad_DeviousBra) || !NPCActor.WornHasKeyword(libs.zad_DeviousClamps))
If equipNPiercings && isAllowedNPiercings 
	SLV_DisplayDebug1("DD Nipple Piercing");
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousPiercingsNipple, tags = "piercing,nipple", tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
Endif


equipAnalPlug =equipAnalPlug && (!NPCActor.WornHasKeyword(libs.zad_DeviousPlugAnal))
If equipAnalPlug && isAllowedAnalPlug
	if !NPCActor.WornHasKeyword(libs.zad_DeviousPlugAnal)
		SLV_DisplayDebug1("DD Anal Plug");
		Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousPlugAnal, tags = "plug,anal", tagsToSuppress = exclTags), TRUE, TRUE, TRUE)
		;Utility.wait(1.0)
	endif
Endif
equipVagPlug =equipVagPlug && (!NPCActor.WornHasKeyword(libs.zad_DeviousPlugVaginal))
If equipVagPlug && isAllowedVagPlug
	if !NPCActor.WornHasKeyword(libs.zad_DeviousPlugVaginal)
		SLV_DisplayDebug1("DD VaginalPlug");
		Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousPlugVaginal, tags = "plug,vaginal", tagsToSuppress = exclTags), TRUE, TRUE, TRUE)
		;Utility.wait(1.0)
	endif
Endif


equipSuit =equipSuit && !NPCActor.WornHasKeyword(libs.zad_DeviousSuit) 
If equipSuit && isAllowedSuit
	SLV_DisplayDebug1("DD Suit");
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousSuit, tags = suittag, tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
Endif


equipHarness =equipHarness && !NPCActor.WornHasKeyword(libs.zad_DeviousCollar) && !NPCActor.WornHasKeyword(libs.zad_DeviousHarness)
If equipHarness && isAllowedHarness
	SLV_DisplayDebug1("DD Harness");
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousHarness, tags = harnesstag, tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
	equipCollar = FALSE
Endif


equipHobblesSkirt =equipHobblesSkirt && !NPCActor.WornHasKeyword(libs.zad_DeviousHobbleSkirt) && !NPCActor.WornHasKeyword(libs.zad_DeviousHarness)
If equipHobblesSkirt && isAllowedHobblesSkirt
	SLV_DisplayDebug1("DD HobblesSkirt");
	Armor hobblesSkirt = Libs.GetDeviceByTags(Libs.zad_DeviousHobbleSkirt, tags = hoblesskirttag, tagsToSuppress = exclTags, fallBack=false)
	if hobblesSkirt == none
		hobblesSkirt = xlibs.zadx_HobbleDressInventory
		if (colortag == ",white")
			hobblesSkirt = xlibs.zadx_HobbleDressWhiteInventory
		endif
		if (colortag == ",red")
			hobblesSkirt = xlibs.zadx_HobbleDressRedInventory
		endif
	endif
	Libs.ManipulateGenericDevice(NPCActor, hobblesSkirt, TRUE, FALSE, TRUE)
	;Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousHobbleSkirt, tags = hoblesskirttag, tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
Endif


equipHobblesSkirtRelaxed =equipHobblesSkirtRelaxed && !NPCActor.WornHasKeyword(libs.zad_DeviousHobbleSkirtRelaxed) && !NPCActor.WornHasKeyword(libs.zad_DeviousHobbleSkirt) && !NPCActor.WornHasKeyword(libs.zad_DeviousHarness)
If equipHobblesSkirtRelaxed && isAllowedHobblesSkirtRelaxed
	SLV_DisplayDebug1("DD HobblesSkirt");
	Armor hobblesSkirtRelaxed = Libs.GetDeviceByTags(Libs.zad_DeviousHobbleSkirtRelaxed, tags = hoblesskirtrelaxedtag, tagsToSuppress = exclTags, fallBack=false)
	if hobblesSkirtRelaxed == none
		hobblesSkirtRelaxed = xlibs.zadx_HobbleDressRelaxedInventory
		if (colortag == ",white")
			hobblesSkirtRelaxed = xlibs.zadx_HobbleDressWhiteRelaxedInventory
		endif
		if (colortag == ",red")
			hobblesSkirtRelaxed = xlibs.zadx_HobbleDressRedRelaxedInventory
		endif
	endif
	Libs.ManipulateGenericDevice(NPCActor, hobblesSkirtRelaxed, TRUE, FALSE, TRUE)
	;Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousHobbleSkirtRelaxed, tags = hoblesskirtrelaxedtag, tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
Endif

;&& !NPCActor.WornHasKeyword(libs.zad_DeviousBelt) 
equipCorset =equipCorset && !NPCActor.WornHasKeyword(libs.zad_DeviousHarness) && !NPCActor.WornHasKeyword(libs.zad_DeviousCorset)
If equipCorset && isAllowedCorset
	SLV_DisplayDebug1("DD Corset");
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousCorset, tags = corsettag, tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
Endif


equipBelt =equipBelt && !NPCActor.WornHasKeyword(libs.zad_DeviousBelt) && !NPCActor.WornHasKeyword(libs.zad_DeviousHarness)
; && !NPCActor.WornHasKeyword(libs.zad_DeviousCorset)
If equipBelt && isAllowedBelt
	SLV_DisplayDebug1("DD Belt");
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousBelt, tags = beltTags, tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
Endif


equipCollar =equipCollar && !NPCActor.WornHasKeyword(libs.zad_DeviousCollar) && !NPCActor.WornHasKeyword(libs.zad_DeviousHarness)
If equipCollar && isAllowedCollar
	SLV_DisplayDebug1("DD Collar");
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousCollar, tags = collartag, tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
Endif


equipLegCuffs =equipLegCuffs && (!NPCActor.WornHasKeyword(libs.zad_DeviousLegCuffs))
If equipLegCuffs && isAllowedLegCuffs
	if !NPCActor.WornHasKeyword(libs.zad_DeviousLegCuffs)
		SLV_DisplayDebug1("DD Leg Cuffs");
		Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousLegCuffs, tags = legcuffstag , tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
		;Utility.wait(1.0)
	endif
Endif
equipArmCuffs =equipArmCuffs && (!NPCActor.WornHasKeyword(libs.zad_DeviousArmCuffs))
If equipArmCuffs && isAllowedArmCuffs
	if !NPCActor.WornHasKeyword(libs.zad_DeviousArmCuffs)
		SLV_DisplayDebug1("DD Arm Cuffs");
		Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousArmCuffs, tags = armcuffstag , tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
		;Utility.wait(1.0)
	endif
Endif


equipShackles = equipShackles && !NPCActor.WornHasKeyword(libs.zad_DeviousAnkleShackles)
If equipShackles && isAllowedShackles
	SLV_DisplayDebug1("DD Shackles");
	Armor shackles = Libs.GetDeviceByTags(Libs.zad_DeviousAnkleShackles, tags = "", tagsToSuppress = exclTags)
	if shackles
		Libs.ManipulateGenericDevice(NPCActor, shackles, TRUE, FALSE, TRUE)
	else
		SLV_DisplayInformation("No DD zad_DeviousAnkleShackles found for : " + "");
		specialDevices.SLV_equipShackles(NPCActor)
	endif
	;Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousAnkleShackles, tags = "shackles", tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousAnkleShackles, tags = "", tagsToSuppress = exclTags), TRUE, FALSE, TRUE)  ;"shackles"
	;Utility.wait(1.0)
Endif

equipBoots = equipBoots && !NPCActor.WornHasKeyword(libs.zad_DeviousBoots)
If equipBoots && isAllowedBoots
	SLV_DisplayDebug1("DD Boots");
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousBoots, tags = bootstag, tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
Endif


equipGloves =equipGloves && !NPCActor.WornHasKeyword(libs.zad_DeviousGloves)
If equipGloves && isAllowedGloves
	SLV_DisplayDebug1("DD Gloves");
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousGloves, tags = glovestag , tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
Endif


equipMittens =equipMittens && (!NPCActor.WornHasKeyword(libs.zad_DeviousBondageMittens) || !NPCActor.WornHasKeyword(libs.zad_DeviousGloves))
If equipMittens && isAllowedMittens
	SLV_DisplayDebug1("DD Mittens");
	
	;Armor mittens = xlibs.zadx_PawBondageMittensInventory
	;if (colortag == ",white")
	;	mittens = xlibs.zadx_PawBondageMittensWhiteInventory
	;endif
	;if (colortag == ",red")
	;	mittens = xlibs.zadx_PawBondageMittensRedInventory
	;endif
	;Libs.ManipulateGenericDevice(NPCActor, mittens, TRUE, FALSE, TRUE)
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousBondageMittens, tags = mittenstag , tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
Endif


equipBra =equipBra && !NPCActor.WornHasKeyword(libs.zad_DeviousBra)
If equipBra && isAllowedBra
	SLV_DisplayDebug1("DD Bra");
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousBra, tags = bratag , tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
Endif


equipBlindfold =equipBlindfold && !NPCActor.WornHasKeyword(libs.zad_DeviousBlindfold)
If equipBlindfold && isAllowedBlindfold
	SLV_DisplayDebug1("DD Blindfold");
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousBlindfold, tags = blindfoldtag, tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
Endif


equipGag =equipGag && !NPCActor.WornHasKeyword(libs.zad_DeviousGag)
If equipGag && isAllowedGag
	SLV_DisplayDebug1("DD Gag");
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousGag, tags = gagTags, tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
Endif


equipHood =equipHood && (!NPCActor.WornHasKeyword(libs.zad_DeviousHood) || !NPCActor.WornHasKeyword(libs.zad_DeviousBlindfold) || !NPCActor.WornHasKeyword(libs.zad_DeviousGag))
If equipHood && isAllowedHood
	SLV_DisplayDebug1("DD Hood");
	Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousHood, tags = hoodtag, tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
Endif


equipArmbinder =equipArmbinder && (!NPCActor.WornHasKeyword(libs.zad_DeviousArmbinder) || !NPCActor.WornHasKeyword(libs.zad_DeviousYoke))
If equipArmbinder && isAllowedArmbinder
	SLV_DisplayDebug1("DD Armbinder");
	Armor armbinder = Libs.GetDeviceByTags(Libs.zad_DeviousArmbinder, tags = armbindertag, tagsToSuppress = exclTags)
	if armbinder
		Libs.ManipulateGenericDevice(NPCActor, armbinder, TRUE, FALSE, TRUE)
	else
		SLV_DisplayInformation("No DD zad_DeviousArmbinder found for : " + armbindertag);
	endif
	Armor heavyArmor = Libs.GetDeviceByTags(Libs.zad_DeviousHeavyBondage, tags = armbindertag, tagsToSuppress = exclTags)
	if heavyArmor
		Libs.ManipulateGenericDevice(NPCActor, heavyArmor, TRUE, FALSE, TRUE)
	else
		SLV_DisplayInformation("No DD zad_DeviousHeavyBondage found for : " + armbindertag);
	endif

	;Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousArmbinder, tags = armbindertag, tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
Endif


equipYoke =equipYoke && (!NPCActor.WornHasKeyword(libs.zad_DeviousArmbinder) || !NPCActor.WornHasKeyword(libs.zad_DeviousYoke))
If equipYoke && isAllowedYoke
	SLV_DisplayDebug1("DD Yoke");
	Armor yoke = Libs.GetDeviceByTags(Libs.zad_DeviousYoke, tags = "yoke", tagsToSuppress = exclTags)
	if yoke
		Libs.ManipulateGenericDevice(NPCActor, yoke, TRUE, FALSE, TRUE)
	endif
	Armor heavyArmor = Libs.GetDeviceByTags(Libs.zad_DeviousHeavyBondage, tags = "yoke", tagsToSuppress = exclTags)
	if heavyArmor
		Libs.ManipulateGenericDevice(NPCActor, heavyArmor, TRUE, FALSE, TRUE)
	endif
	
	;Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousYoke, tags = "yoke", tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousYoke, tags = "", tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
Endif

equipStraitJacket =equipStraitJacket && !NPCActor.WornHasKeyword(libs.zad_DeviousStraitJacket) && (!NPCActor.WornHasKeyword(libs.zad_DeviousArmbinder) || !NPCActor.WornHasKeyword(libs.zad_DeviousYoke))
If equipStraitJacket && isAllowedStraitJacket
	SLV_DisplayDebug1("DD StraitJacket");
	Libs.ManipulateGenericDeviceByKeyword(NPCActor, Libs.zad_DeviousStraitJacket, true, false, false)
	
	;Armor straitjacket = Libs.GetDeviceByTags(Libs.zad_DeviousStraitJacket, "", false, exclTags, false)
	;if straitjacket
	;	Libs.ManipulateGenericDevice(NPCActor, straitjacket, TRUE, FALSE, TRUE)
	;endif
	;Armor heavyArmor = Libs.GetDeviceByTags(Libs.zad_DeviousHeavyBondage, tags = "", tagsToSuppress = exclTags)
	;if heavyArmor
	;	Libs.ManipulateGenericDevice(NPCActor, heavyArmor, TRUE, FALSE, TRUE)
	;endif
	;Libs.ManipulateGenericDevice(NPCActor, Libs.GetDeviceByTags(Libs.zad_DeviousStraitJacket, tags = "straitjacket" , tagsToSuppress = exclTags), TRUE, FALSE, TRUE)
	;Utility.wait(1.0)
	
	equipStraitJacket =equipStraitJacket && !NPCActor.WornHasKeyword(libs.zad_DeviousStraitJacket) && (!NPCActor.WornHasKeyword(libs.zad_DeviousArmbinder) || !NPCActor.WornHasKeyword(libs.zad_DeviousYoke))
	SLV_DisplayInformation("DD StraitJacket: " + equipStraitJacket + " " + colortag);
	if equipStraitJacket
		specialDevices.SLV_equipStraitJacket(NPCActor, colortag)
	endif
Endif

EndFunction



Function SLV_AddDeviousDevice(Actor NPCActor, int count, bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset)

SLV_AddDeviousDevice2(NPCActor, count, equipGag, equipPlugs, equipHarness, equipBelt, equipBra, equipCollar, equipCuffs, equipArmbinder, equipYoke, equipBlindfold, equipNPiercings, equipVPiercings, equipBoots, equipGloves, equipCorset)
EndFunction

Function SLV_AddDeviousDevice2(Actor NPCActor, int count, bool equipGag,bool equipPlugs,bool equipHarness,bool equipBelt,bool equipBra,bool equipCollar,bool equipCuffs,bool equipArmbinder,bool equipYoke,bool equipBlindfold,bool equipNPiercings,bool equipVPiercings,bool equipBoots,bool equipGloves,bool equipCorset)
;Deviously equip the devices
string exclTags = "DCexcluded"
string gagTags = "gag,ring"
string beltTags = "belt,open"
string harnessTags = "harness,open"

If equipGag
	NPCActor.AddItem(Libs.GetDeviceByTags(Libs.zad_DeviousGag, tags = gagTags, tagsToSuppress = exclTags),count)
Endif

If equipVPiercings
	NPCActor.AddItem(Libs.GetDeviceByTags(Libs.zad_DeviousPiercingsVaginal, tags = "piercing,vaginal", tagsToSuppress = exclTags),count)
Endif

If equipPlugs
	NPCActor.AddItem( Libs.GetDeviceByTags(Libs.zad_DeviousPlugVaginal, tags = "plug,vaginal", tagsToSuppress = exclTags),count)
	NPCActor.AddItem( Libs.GetDeviceByTags(Libs.zad_DeviousPlugAnal, tags = "plug,anal", tagsToSuppress = exclTags),count)
Endif

If equipHarness
	NPCActor.AddItem(Libs.GetDeviceByTags(Libs.zad_DeviousHarness, tags = harnessTags, tagsToSuppress = exclTags),count)
Endif

If equipCorset
	NPCActor.AddItem( Libs.GetDeviceByTags(Libs.zad_DeviousCorset, tags = "corset", tagsToSuppress = exclTags),count)
Endif

If equipBelt
	NPCActor.AddItem(Libs.GetDeviceByTags(Libs.zad_DeviousBelt, tags = beltTags, tagsToSuppress = exclTags),count)
Endif

If equipBra
	NPCActor.AddItem( Libs.GetDeviceByTags(Libs.zad_DeviousBra, tags = "bra", tagsToSuppress = exclTags),count)
Endif

If equipNPiercings
	NPCActor.AddItem(Libs.GetDeviceByTags(Libs.zad_DeviousPiercingsNipple, tags = "piercing,nipple", tagsToSuppress = exclTags),count)
Endif

If equipCollar
	NPCActor.AddItem( Libs.GetDeviceByTags(Libs.zad_DeviousCollar, tags = "collar", tagsToSuppress = exclTags),count)
Endif

If equipCuffs
	NPCActor.AddItem( Libs.GetDeviceByTags(Libs.zad_DeviousArmCuffs, tags = "cuffs,arms", tagsToSuppress = exclTags),count)
	NPCActor.AddItem( Libs.GetDeviceByTags(Libs.zad_DeviousLegCuffs, tags = "cuffs,legs", tagsToSuppress = exclTags),count)
Endif

If equipBlindfold
	NPCActor.AddItem( Libs.GetDeviceByTags(Libs.zad_DeviousBlindfold, tags = "blindfold", tagsToSuppress = exclTags),count)
Endif

If equipArmbinder
	NPCActor.AddItem( Libs.GetDeviceByTags(Libs.zad_DeviousArmbinder, tags = "armbinder", tagsToSuppress = exclTags),count)
Endif

If equipYoke
	NPCActor.AddItem( Libs.GetDeviceByTags(Libs.zad_DeviousYoke, tags = "yoke", tagsToSuppress = exclTags),count)
Endif

If equipBoots
	NPCActor.AddItem(Libs.GetDeviceByTags(Libs.zad_DeviousBoots, tags = "boots", tagsToSuppress = exclTags),count)
Endif

If equipGloves
	NPCActor.AddItem(Libs.GetDeviceByTags(Libs.zad_DeviousGloves, tags = "gloves", tagsToSuppress = exclTags),count)
Endif
EndFunction


Function SLV_StripBothHands(Actor NPCActor)
If NPCActor.GetEquippedObject(0) 
	NPCActor.UnEquipItem(NPCActor.GetEquippedObject(0), True, True)
endif
If NPCActor.GetEquippedObject(1) 
	NPCActor.UnEquipItem(NPCActor.GetEquippedObject(1), True, True)
endif
EndFunction


Function SLV_DisplayUser(String MyMessage)
	SLV_DisplayAMessage(0, MyMessage)
EndFunction
Function SLV_DisplayInformation(String MyMessage)
	SLV_DisplayAMessage(1, MyMessage)
EndFunction
Function SLV_DisplayDebug1(String MyMessage)
	SLV_DisplayAMessage(2, MyMessage)
EndFunction
Function SLV_DisplayDebug2(String MyMessage)
	SLV_DisplayAMessage(3, MyMessage)
EndFunction

Function SLV_DisplayAMessage(Int MessageType, String MyMessage)
	Bool Screen = false
	Bool Console = false
	Bool Log = false
	String ConsoleAndLogMessage = "Slaverun: " + MyMessage + " MT=" + MessageType	
	if MessageType == 0
		Screen = MCMMenu.MTUserScreen
		Console = MCMMenu.MTUserConsole
		Log = MCMMenu.MTUserLog
	elseif MessageType == 1
		Screen = MCMMenu.MTInformationScreen
		Console = MCMMenu.MTInformationConsole
		Log = MCMMenu.MTInformationLog
	elseif MessageType == 2
		Screen = MCMMenu.MTDebug1Screen
		Console = MCMMenu.MTDebug1Console
		Log = MCMMenu.MTDebug1Log
	elseif MessageType == 3
		Screen = MCMMenu.MTDebug2Screen
		Console = MCMMenu.MTDebug2Console
		Log = MCMMenu.MTDebug2Log
	else
		; Unknown type - do nothing with it
	endif
	if Screen
		debug.Notification(MyMessage)
	endif
	if Console
		MiscUtil.PrintConsole(ConsoleAndLogMessage)
	endif
	if Log
		debug.Trace(ConsoleAndLogMessage)
	endif
EndFunction

String function SLV_getDeviousIntegrationVersion()
return libs.GetVersionString()
endfunction
String function SLV_getDeviousExpansionVersion()
return xlibs.GetVersionString()
endfunction


;DEVIOUS DEVICES PROPERTIES
zadxLibs Property xlibs Auto
zadLibs Property libs Auto
SLV_SpecialDevices Property specialDevices Auto

SLV_MCMMenu Property MCMMenu Auto
Actor Property PlayerRef Auto