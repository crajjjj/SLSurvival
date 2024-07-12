Scriptname SLSF_FunctionAccess extends Quest  

;+---------------------------
;|	HARD DEPENDANCY FUNCTIONS
;|	----------------------------------------------------------------------------------------------------+
;|	This script is used to provide, via Hard dependancy, easy access to the features of this Framework	|
;|	with simple function, references, info and instructions about How to do things with the SLSF		|
;|	instead to access other function. I raccomand you to use THIS, and NOT access other functions 		|
;|	directly, their purpose could be different from yours and they could be changed in other			|
;|	version of the SLSF, breaking the compatibility and eventually compromising the stability of both	|
;|	mods.																							 	|
;|	If you don't find a function that suits your need here, let me know in the Support Topic.			|
;|	http://www.loverslab.com/topic/54621-sex-lab-sexual-fame-framework/									|
;|																			-Versh						|
;|																	P.S.: USE THIS FOR GOD'S SAKE!		|
;|	----------------------------------------------------------------------------------------------------+
;+-------------------------------------------------------------------------------------------------------

;+--------
;|	-----+
;|	INDEX|
;|	-----+
;|	0. How Access This In Hard Dependancy
;|	1. Reference Charts
;|		1.1 RoleType
;|		1.2 FameList NPC
;|		1.3 FameList PC
;|		1.4 Locations BASE
;|		1.5 Equip Surfaces
;|		1.6 ReactionsType
;|	2. Fame Functions
;|		2.1 FameModEvent
;|		2.2 ModFameValueByNum
;|		2.3 ModFameValueByCurrent
;|		2.4 ModFameValueByLocation
;|		2.5 PeriodicFameGain
;|		2.6 GetCurrentSingleFameValue
;|		2.7 GetCurrentFameValues
;|	3. Location Functions
;|		3.1 LocationNum
;|		3.2 TemporaryLocationAdd
;|		3.3 TemporaryLocationRemoveByNum
;|		3.4 TemporaryLocationRemoveByCurrent
;|		3.5 TemporaryLocationRemoveByLoc
;|		3.6 SyncLocation
;|		3.7 ContageFame
;|		3.8 ModMorbosty
;|		3.9 ModMorbosityReq
;|	4. Actor Functions	
;|		4.1 SetRoleType
;|		4.2 UpdateEquip
;|		4.3 CheckEquipStatusEffect
;|		4.4 RequestSuspendShameAnim
;|		4.5 GetReactionType
;|		4.6 GetRoleType
;|		4.7 GetRoleGroup
;|		4.8 ToggleNPCExclusionSLSF
;|		4.9 ToggleNPCNoCommentSLSF
;|	5. Misc Functions
;|		5.1 RequestSetCommentProbability
;|		5.2 CheckSceneInUse
;|		5.3 RequestSceneInUse
;|		5.4 CheckSLSFLoaded
;|	6. PapyrusUtil Element
;|		6.1 FameStorages
;|		6.2 FameLimits
;|		6.3 GetAllLocationForm
;|	7. List Of StorageUtil Used
;|
;+------------------------------------------------------------------------------

;************************************************************************
;+----------------------------------------								*
;|	-------------------------------------+								*
;|	0. How Access This In Hard Dependancy|								*
;|	-------------------------------------+								*
;|Tutorial about hard dependancy.										*
;+---------------------------------------------------------------------+*

;	1.0 Are you serious!?
;	(Step By Step)
;		0.1 ...Really?
;		0.2 Com'on!
;		0.3 A Damn Standard Access at this Script!
;		0.4 You know? Property, CK?
;		0.5 This is redicolous...
;		0.6 Still here? Get a job!




;************************************************************************
;+---------------------													*
;|	------------------+													*
;|	1 Reference Charts|													*
;|	------------------+													*
;|Those are a simple Memo about numeric references of the mods,			*
;|divided by type.														*
;+---------------------------------------------------------------------+*

;-------------------*
;1.1 RoleType Chart:|
;-------------------*
;0 Dominant Kind
;1 Dominant Normal
;2 Dominant Bastard
;...
;20 Neutral Kind
;21 Neutral Normal
;22 Neutral Bastard
;...
;40 Submissive Kind
;41 Submissive Normal
;42 Submissive Bastard

;-----------------------*
;1.2 FameList Chart NPC:|
;-----------------------*
;0  NPC.Libertine
;1  NPC.Prostitution
;2  NPC.Raper
;3  NPC.Slavery
;4  NPC.Zoophilie
;5  NPC.Misogyny
;6  NPC.Misandry

;----------------------*
;1.3 FameList Chart PC:|
;----------------------*
;0  PC.Anal
;1  PC.Argonian
;2  PC.Beastiality
;3  PC.Dominant/Master
;4  PC.Exhibitionist/Exposed
;5  PC.GentleLover
;6  PC.Group
;7  PC.Khajiit
;8  PC.LikeMan
;9  PC.LikeWoman
;10 PC.Masochist
;11 PC.Nasty
;12 PC.Oral
;13 PC.Orc
;14 PC.Pregnant
;15 PC.Sadic
;16 PC.SkoomaUser
;17 PC.Slut
;18 PC.Submissive/Slave
;19 PC.Whore

;-------------------------*
;1.4 Locations BASE Chart:|
;-------------------------*
;0	Dawnstar
;1	Falkreath
;2	Markarth
;3	Morthal
;4	Riften
;5	Solitude
;6	Whiterun
;7	Windhelm
;8	Winterhold
;9	DragonBridge
;10	Ivarstead
;11	Karthwasten
;12	Riverwood
;13	Rorikstead
;14	ShorsStone
;15	WinterholdCollege
;16	DushnikhYal
;17	Largashbur
;18	MorKhazgur
;19	Narzulbur
;20	CastleVolkihar (Or None if Dawnguard Isn't Installed)
;21	FortDawnguard(DaySpringCanyon) (or None if DG Not Inst.)
;22	SkaalVillage (Or None If DragonBorn Isn't insalled)
;23	RavenRock (or None if DB Not Inst.)

;Note: The Temporary Location could change multiple times, so to find those use the specific commands.

;-------------------------*
;1.5 Equip Surfaces Chart:|
;-------------------------*
;
;There's 4 Group [Body Locations] of Equip Surfaces
;SLSF_EquipSurfaceBody_X
;SLSF_EquipSurfaceHead_X
;SLSF_EquipSurfaceFeet_X
;SLSF_EquipSurfaceHand_X
;
;
;With 9 Level for Each one:
;0 Empty (Future Use)
;1 SlaveTats Surface (Skin)
;2 Dirt (Slavetas/BathingInSkyrim)
;3 Cum (Over Skin)
;4 Empty (Future Use)
;5 Devices, Zaz/DD that could be Masked, (Under Clothings)
;6 Empty (Future Use)
;7 Clothing
;8 Empty (Future Use)
;
;And a Last One, common for every 'Body locations'
;SLSF_EquipSurfaceOther_9, Common Surface related to Big/Unmaskable Devices (DD or Zaz)

;------------------------*
;1.6 ReactionsType Chart:|
;------------------------*
;0 None/Gagged
;1 Normal
;2 Friendly
;3 Affective
;4 Very Affective
;5 Offensive
;6 Very Offensive
;
;-------+-------------------+---------------+-------------------+
;		|	RoleTypes		|	RoleTypes	|	RoleTypes		|
;		| 	Kind 			|	Normal		|	Bastard			|
;-------+-------------------+---------------+-------------------+
;Enemy	|	Neutral(1)		|Offensive(5)	|	Offensive+(6)	|
;Neutral|	Friendly(2)		|Neutral(1)		|	Offensive(5)	|
;Friend	|	Affective(3)	|Friendly(2)	|	Neutral(1)		|
;Lover	|	Affective+(4)	|Affective(3)	|	Friendly(2)		|
;-------+-------------------+---------------+-------------------+



;************************************************************************
;*+----------------														*
;*|	----------------+													*
;*|	2 Fame Functions|													*
;*|	----------------+													*
;*|These are the functions used to manipulate the fame level via SLSF.	*
;*|You'll need the Location Number to identify the fame level that		*
;*|you're looking for, you could use both the Reference Chart or		*
;*|the Location functions. You could also manipulate the values			*
;*|via PapyrusUtil (See the specific Section for that).					*
;*+--------------------------------------------------------------------+*


;2.1 FameModEvent----------------------------------------------------+
;	[PC; Increase; Current Location;]										|
;																			|
;This will trigger a Fame gain event like those send by the SLSF itself.	|
; It cause an Increase of PC FAME in the CURRENT location (if Any) based	|
; on the SLSF Rules, using the preferences set in the MCM by the user.		|
; The base calc of gain is: 1 Point of Fame for each ActorNpc with LOS		|
; on the PC (or without LOS if distance under a MCM value) If the NPC pass a|
; probability check based on the RelationshipRank with the PC (for example:	|
; the lovers have 10% to add 1 point, the enemy 100%, configurable in MCM).	|
;																			|
;Usage:	Simple Gain events, your mod does something that should make gain	|
;		fame? Here a ready to use, already balanced, Function.				|
;																			|
;Values:	String TempBuffer, this is the name of the Global PapyrusUtil	|
;							   where you store the Fame type that should be |
;							   Gained from this event, with their MAX Level.|
;							   The Buffer get cleared after use.			|
;			Float Multiplier, a generic multiplier of the fame gained from	|
;							  this event, for example 0.5 for 50% of what 	|
;							  it normally should gain.						|
;																			|
;Return:	Bool, True at least 1 point added								|
;				  False, no points added.									|
;																			|
;Note:	The FameModEvent needs some seconds to complete the increase,		|
;		and could be delayed by other request on course.					|
;---------------------------------------------------------------------------+

Bool Function FameModEvent(String Name, Int[] FameList, Float Multiplier)
	Return FameMain.FamePcExternalMod(FameList, Multiplier)
EndFunction

;Example:
;
;Function IncreaseForWhipping()
;	Int[] FameList = New Int[20]
;	String Name = "Slaverun.Whipping"
;	Float Multiplier = 1.0
;	
;	FameList[10] = 100		;Increase PC.Masochist Max To 100
;	FameList[18] = 50		;Increase PC.Submissive/Slave Max To 50
;	
;	FameModEvent(Name, FameList, Multiplier)
;;		Obviously this should be call with the Property that identify this script
;;			For Example SLSF.FameModEvent(Name, FameList, Multiplier).
;EndFunction




;2.2 ModFameValueByNum------------------------------------------------------+
;	[PC; NPC; INCREASE; DECREASE; ANY LOCATION;]							|
;																			|
;This function is maded to INCREASE or DECREASE arbitrarily the level of 	|
; fame, following only the BASIC rules of the SLSF. In specific you could 	|
; set PC and NPC fame, for a specified Location (By Num, See the chart or 	|
; the Locations Functions). It changes a Single Value at time and it's		|
; configurable with multiple element.										|
;																			|
;Usage: A simple Gain of an arbitrary value for a Location Specified.		|
;																			|
;Values:	Int FameGroup, Identify the Fame NPC(0) or PC(1)				|
;			Int FameNum, Identify the Fame Num to increase, See the Fame	|
;						 Reference Chart.									|
;			Int LocNum, The Location Num where increase the fame, See the	|
;						Location chart or use the Location Functions.		|
;			Int Many, The Amount of Fame to add/subtract.					|
;			Bool ApplyUserMod, Apply or not the User Multplier for the 		|
;								 Fame Gain/Lost, Default True.				|
;			Int LimitMin, Minimum Limit that the Fame level could reach		|
;						  with that Decrease, Default 0.					|
;			Int LimitMax, Maxium limit that the Fame level could reach with	|
;						  that Increase, Default 100.						|
;Return:	Bool, True Executed an add/subtract.							|
;				  False, Interrupted by error (es. LocNum wrong).			|
;---------------------------------------------------------------------------+

Bool Function ModFameValueByNum(Int FameGroup, Int FameNum, Int LocNum, Int Many, Bool ApplyUserMod = True, Int LimitMin = 0, Int LimitMax = 100)
	Return FameMain.ModFameValueByNum(FameGroup, FameNum, LocNum, Many, ApplyUserMod, LimitMin, LimitMax)
EndFunction

;Example:
;
;Function ImposeSlaveryFameAtDawnstar()
;	ModFameValueByNum(0, 3, 0, 50, False, 50, 100)
;		;Inc Fame Npc.Slavery, at Dawnstar, by +50, Without Apply the User Fame Gain Multiplier
;		; the Minimum result should be 50, the Maximum 100.
;	
;	ModFameValueByNum(1, 18, 0, 20, True, 0, 80)
;		;Inc the fame Pc.Submissive/Slave, at Dawnstar, by +20, Apply the User Fame Gain multiplier
;		; Min Result 0, Max 80
;	
;	ModFameValueByNum(1, 3, 0, -30, True, 0, 40)
;		;Dec the fame Pc.Dominant/Master, at Dawnstar, by -30, apply the User fame Lost Mutiplier
;		;Min Result 0, Max Result 40
;
;;		Obviously this should be call with the Property that identify this script
;;			For Example SLSF.ModFameValueByNum(FameGroup, FameNum, LocNum, Many, ApplyUserMod, LimitMin, LimitMax)
;EndFunction




;2.3 ModFameValueByCurrent--------------------------------------------------+
;	[PC; NPC; INCREASE; DECREASE; CURRENT LOCATION;]						|
;																			|
;This function is maded to INCREASE or DECREASE arbitrarily the level of 	|
; fame, following only the BASIC rules of the SLSF. In specific you could 	|
; set PC and NPC fame, for the CURRENT location (if Any). It changes a 		|
; Single Value at time and it's configurable with multiple element.			|
;																			|
;Usage: A simple Gain of an arbitrary value, for the Current Location.		|
;																			|
;Values:	Int FameGroup, Identify the Fame NPC(0) or PC(1)				|
;			Int FameNum, Identify the Fame Num to increase, See the Fame	|
;						 Reference Chart.									|
;			Int Many, The Amount of Fame to add/subtract.					|
;			Bool ApplyUserMod, Apply or not the User Multplier for the 		|
;								 Fame Gain/Lost, Default True.				|
;			Int LimitMin, Minimum Limit that the Fame level could reach		|
;						  with that Decrease, Default 0.					|
;			Int LimitMax, Maxium limit that the Fame level could reach with	|
;						  that Increase, Default 100.						|
;Return:	Bool, True Executed an add/subtract.							|
;				  False, Interrupted by error (es. LocNum wrong).			|
;---------------------------------------------------------------------------+

Bool Function ModFameValueByCurrent(Int FameGroup, Int FameNum, Int Many, Bool ApplyUserMod = True, Int LimitMin = 0, Int LimitMax = 100)
	Return FameMain.ModFameValueByCurrent(FameGroup, FameNum, Many, ApplyUserMod, LimitMin, LimitMax)
EndFunction

;Example:
;
;Function GainHereSomeFame()
;	ModFameValueByCurrent(0, 0, 10, False)
;		;Inc Fame Npc.Libertine, in current Location (if Any), by +10, Without Apply the User Fame Gain Multiplier
;		; In a range between 0 and 100
;	
;	ModFameValueByCurrent(1, 5, -20, True, 0, 80)
;		;Dec the fame Pc.GentleLover, in current Location (if Any), by -20, Apply the User Fame Lost multiplier
;		; Min Result 0, Max 80
;	
;;		Obviously this should be call with the Property that identify this script
;;			For Example SLSF.ModFameValueByCurrent(FameGroup, FameNum, LocNum, Many, ApplyUserMod, LimitMin, LimitMax)
;EndFunction




;2.4 FameValueByLocation----------------------------------------------------+
;	[PC; NPC; INCREASE; DECREASE; SPECIFIC LOCATION;]						|
;																			|
;This function is maded to INCREASE or DECREASE arbitrarily the level of 	|
; fame, following only the BASIC rules of the SLSF. In specific you could 	|
; set PC and NPC fame, for the Location given (if tracked). It changes a 	|
; Single Value at time and it's configurable with multiple element.			|
;																			|
;Usage: A simple Gain of an arbitrary value, using a Location as parameter.	|
;																			|
;Values:	Int FameGroup, Identify the Fame NPC(0) or PC(1)				|
;			Int FameNum, Identify the Fame Num to increase, See the Fame	|
;						 Reference Chart.									|
;			Location Where, The Location that will register the Inc/Dec of	|
;							Fame.											|
;			Int Many, The Amount of Fame to add/subtract.					|
;			Bool ApplyUserMod, Apply or not the User Multplier for the 		|
;								 Fame Gain/Lost, Default True.				|
;			Int LimitMin, Minimum Limit that the Fame level could reach		|
;						  with that Decrease, Default 0.					|
;			Int LimitMax, Maxium limit that the Fame level could reach with	|
;						  that Increase, Default 100.						|
;Return:	Bool, True Executed an add/subtract.							|
;				  False, Interrupted by error (es. LocNum wrong).			|
;---------------------------------------------------------------------------+

Bool Function ModFameValueByLocation(Int FameGroup, Int FameNum, Location Where, Int Many, Bool ApplyUserMod = True, Int LimitMin = 0, Int LimitMax = 100)
	Return FameMain.ModFameValueByLocation(FameGroup, FameNum, Where, Many, ApplyUserMod, LimitMin, LimitMax)
EndFunction

;Example:
;
;Function TryToAddFameToThatLocation()
;	Location OneCasualLocation
;	
;	ModFameValueByLocation(1, 0, OneCasualLocation, 5)
;		;Inc the Fame Pc.Anal, in the given Location (if tracked), by 5, Apply the User Fame Gain multiplier
;		; Min Result 0, Max 100
;		
;	ModFameValueByLocation(0, 3, OneCasualLocation, 10, False)
;		;Inc the Fame Npc.Slavery, in the given Location (if tracked), by 10, Not Apply the User Fame Gain multiplier
;		; Min Result 0, Max 100
;
;;		Obviously this should be call with the Property that identify this script
;;			For Example SLSF.ModFameValueByLocation(FameGroup, FameNum, LocNum, Many, ApplyUserMod, LimitMin, LimitMax)	
;EndFunction




;2.5 PeriodicFameGain------------------------------------------------+
;	[PC; INCREASE; CURRENT LOCATION; PERIODIC GAIN;]						|
;																			|
;This function enable the INCREASE over time of a specific Type of PC fame	|
; until it reaches a given Max amount (unless something else allow the PC	|
; to gain more). It's like telling to the SLSF that there's something who	|
; let everyone knows a particular info about the PC, for Example the PC is	|
; locked in a Pillory, or similar.											|
;																			|
;Usage: Enable/Disable when needed to make the fame of the PC grow according|
; to the other Periodic increase of the SLSF, instead to call an increase	|
; multiple times.															|
;																			|
;Values:	String Sender, To avoid problem with different requests use 	|
;						   your mod name here, if someone DIFFERENT request	|
;						   a periodic increase for a minor value in the SAME|
;						   Fame type, it will be ignored (The periodic is 	|
;						   already doing that). If it request a Periodic	|
;						   gain for a Superior Limit it will overwrite the 	|
;						   previous request. If the the actual SENDER		|
;						   makes a new request, it will be accepted 		|
;						   indipendently from the Max value request.		|
;			Int FameNum, Identify the PC Fame Num to increase, See the Fame	|
;						 PC Reference Chart.								|
;			Int LimitMax, Maxium limit that the Fame level could reach with	|
;						  the periodic increase, Default 100.				|
;																			|
;Return:	Bool, True Accepted												|
;				  False Refused.											|
;																			|
;Note:	As safe mesure the PeriodicGain Disable itself at Every Load Game	|
;		Refresh the request if needed.										|
;Note2:	I know that there's an obvious trick to bypass the 'Sender' system	|
;		It's only an helper to avoid conflict, not a safe mesure.			|
;---------------------------------------------------------------------------+

Bool Function PeriodicFameGain(String Sender, Int FameNum, Int LimitMax = 100)
	Return SLSFUtil.PeriodicFameGain(Sender, FameNum, LimitMax)
EndFunction

;Examples:
;
;Function StartPeriodicGain()
;	PeriodicFameGain("DovahMolestFlowers", 11, 90)
;		;The mod "DovahMolestFlowers" request to enable the Periodic gain for Nasty Fame, because the Dovahkiin
;		;	started to rub his penis with Crimsons Nirnroot. Max gain 90.
;
;;		Obviously this should be call with the Property that identify this script
;;			For Example SLSF.PeriodicFameGain("DovahMolestFlowers", 11)
;EndFunction
;
;Now, for example another mod request to increase the Nasty Fame for a minor value with:
;	PeriodicFameGain("DovahPickHisNose", 11, 30)
;		Because the sender is different and the value is minor, this will be ignored
;		
;Then the Dovah does something else disgusting:
;	PeriodicFameGain("DovahPickFalmerNose", 11, 100)
;		The Sender is Different, but the value bigger, Now the Sender 'in Charge' is "DovahPickFalmerNose"
;		for a value of 100
;
;Finally the disgusting things ends and the mods call:
;	PeriodicFameGain("DovahPickFalmerNose", 11, 0)
;		The Value is minor, but the sender is the same, The Periodic Gain get disabled, and the Sender Cleared




;2.6 GetCurrentSingleFameValue----------------------------------------------+
;	[PC; CURRENT LOCATION; FAME;]											|
;																			|
;This function Recover the Values actually stored in the Global Variables 	|
; about the fame of the Current Location (if any, otherwise you get a 0).	|
;																			|
;Usage: Useful to recover a single Fame value. Those values are just MIRRORS|
;		of the Storage, every change directly on this will be discarted.	|
;																			|
;Values:	Bool AboutPC, if True the return value will be the PC FameList	|
;						 if False the return value will be the NPC FameList.|
;			Int FameNum, The FameNum based n the Fame Reference Chart 		|
;						(PC/NPC).											|
;																			|
;Return:	Int, the Fame Level, -1 If SLSF not loaded.						|
;																			|
;Note:	If you don't need the Whole list you could create your own Function	|
;		dismantling this.													|
;---------------------------------------------------------------------------+

Int Function GetCurrentSingleFameValue(Bool AboutPC, Int FameNum)
	Return SLSFUtil.GetCurrentSingleFameValue(AboutPC, FameNum)
EndFunction

;Example:
;
;Int Function LetsCheckTheCurrentFame(Bool PCOrNot, Int FameNum)
;	Return GetCurrentSingleFameValue(PCOrNot, FameNum)
;
;;		Obviously this should be call with the Property that identify this script
;;			For Example SLSF.GetCurrentSingleFameValue(PCOrNot, FameNum)
;EndFunction




;2.7 GetCurrentFameValues---------------------------------------------------+
;	[PC; NPC; CURRENT LOCATION; FAME;]										|
;																			|
;This function Recover the Values actually stored in the Global Variables 	|
; about the fame of the Current Location (if any, otherwise you get a 0).	|
;																			|
;Usage: Useful to recover the Whole Famelist of the Location. Those values	|
;		are just MIRRORS of the Storage, every	change directly on this will|
;		 be discarted.														|
;																			|
;Values:	Bool AboutPC, if True the return List will be the PC FameList	|
;						 if False the return List will be the NPC FameList.	|
;																			|
;Return:	Int[], the Fame Level, The whole list							|
;				   Empty List is SLSF not loaded.							|
;---------------------------------------------------------------------------+

Int[] Function GetCurrentFameValues(Bool AboutPC = True)
	Return SLSFUtil.GetCurrentFameValues(AboutPC)
EndFunction

;Example:
;
;Bool Function InThislocationASlaversLocation()
;	Int[] NpcFameList = GetCurrentFameValues(False)
;	If NpcFameList[3] >= 50
;		Return True
;	EndIf
;	Return False
;;		Obviously this should be call with the Property that identify this script
;;			For Example SLSF.GetCurrentFameValues(False)
;EndFunction




;************************************************************************
;+-----------------------												*
;|	--------------------+												*
;|	3 Location Functions|												*
;|	--------------------+												*
;|This functions are used to interact with the Locations, add, remove,	*
;|find Locations, Trigger contages, etc.								*
;+---------------------------------------------------------------------+*

;3.1 ObtainLocationNum------------------------------------------------------+
;	[ANY LOCATION;]															|
;This function is used to know the LocNum assigned By SLSF for a specified	|
; Location. It could be used also to check if a Location is actually tracked|
; or not. Note that the Base locations (Like Town, Villages etc.) are STATIC|
; (Check the Locations BASE Chart) so mostly this could be use for Script 	|
; interactions or to find the number of a temporary location.				|
;																			|
;Usage:	Know the LocNum or if a location is Tracked or not.					|
;																			|
;Values:	Location Which, obviously the location that you need to check.	|
;																			|
;Return:	Int, -1 Location Not Tracked									|
;				 any other Num is the Location Num that could be used in	|
;				 the scripts.												|
;																			|
;Note:	The request will take at least 1 second to complete itself, to		|
;		avoid problem.														|
;---------------------------------------------------------------------------+

Int Function ObtainLocationNum(Location Which)
	Return SLSFUtil.ObtainFameLocationNum(Which)
EndFunction

;Example
;
;Int Function IsLocationTracked(Location TheLocation)
;	Int LocNum = ObtainLocationNum(TheLocation)
;	
;	If LocNum >= 0
;		Debug.Notification("The Location Checked is Tracked by SLSF with the Number "+LocNum+".")
;	Else
;		Debug.Notification("This Location Isn't Tracked By SLSF.")
;	EndIf
;	
;;		Obviously this should be call with the Property that identify this script
;;			For Example SLSF.ObtainLocationNum(TheLocation)
;EndFunction




;3.2 TemporaryLocationAdd---------------------------------------------------+
;	[TRACK; LOCATION;]														|
;This function is used to add a Location in the list of tracked locations	|
; as one of the temporary. There are max 10 Temporary Location, The User	|
; could always remove the location via MCM or re-configure the parameter.	|
; The Location Temporary will decay (if not flagged as Cannot Decay) if 	|
; unused for some time (no Gain/Lose fame for a Configured by User period 	|
; of Time).																	|
;																			|
;Usage:	Start to track a specific Location for... reasons... For example 	|
;		Dungeons, Mines, Ruins, Camp.										|
;																			|
;Values:	Location Which, obviously the location that you need to track.	|
;			Bool CannotDecay, set if this location could decay or not if	|
;							  not used for some time. Default = False.		|
;			Float Morbosity, is a value that defines the probability that	|
;							 THIS location contage another with part of it's|
;							 Level of Fame. Values from 0.0 to 1.0.			|
;			Float MorbosityReq, The level of morbosity that ANOTHER Location|
;								should at least have to contage This.		|
;								Values from 0.0 to 1.0.						|
;																			|
;Return:	Int, -1 Fail, Location None.									|
;				 -2 Fail, Location Already Tracked.							|
;				 -3 Fail, No track Slot Disponible.							|
;				 -4 Fail, Can't Track Holds and Bigger Location.			|
;				 -5 Fail, Can't track Houses.								|
;				 Any positive Number it the Slot Used to Track.				|
;																			|
;Note:	The User could always modify the location parameter via MCM, or even|
;		clear the slot from the Location.									|
;		Some Locations Couldn't be tracked, for example single Houses or	|
;		Holds and obviously not the Entire Skyrim.							|
;---------------------------------------------------------------------------+

Int Function TemporaryLocationAdd(Location Which, Bool CannotDecay = False, Float Morbosity = 0.5, Float MorbosityReq = 0.2)
	Return FameMain.RegisterTemporaryLocation(Which, False, CannotDecay, Morbosity, MorbosityReq)
EndFunction

;Example:
;
;Function StarTrackThis(Location Which)
;	TemporaryLocationAdd(Which, True, Utility.RandomFloat(0.4, 0.7), Utility.RandomFloat(0.2, 0.5))
;		;Track The given Location, avoid the decadence over time if unused, with random level 
;		;	of morbosity and MorbosityRequired.
;		
;;		Obviously this should be call with the Property that identify this script
;;			For Example SLSF.TemporaryLocationAdd(Which, True, Utility.RandomFloat(0.4, 0.7), Utility.RandomFloat(0.2, 0.5))
;EndFunction




;3.3 TemporaryLocationRemoveByNum-------------------------------------------+
;	[UNTRACK; LOCATION;]													|
;This function is used to remove a Location from the list of tracked 		|
; locations. The use is obviously inverse from the Track Function.			|
; Only the Temporary location could be removed (the 10 Location Other than	|
; those in the Base Location reference Chart), The Base Location will be 	|
; simply Cleared (all fame To 0 and LimitMin and Max Reset to 0 and 100).	|
; Obviously it ignores the 'Cannot Decay' parameter of the location			|
;																			|
;Usage:	Stop to track the Specified Location.								|
;																			|
;Values:	Int LocNum, the Location Num that you need to Remove.			|
;																			|
;Return:	Int, 0 Removed													|
;				 -1 Only Cleared (Or location invalid).						|
;																			|
;Note:	The User could always remove the location via MCM or Re-add.		|
;---------------------------------------------------------------------------+

Int Function TemporaryLocationRemoveByNum(Int LocNum)
	Return FameMain.ResetFameByNum(LocNum)
EndFunction

;Example:
;
;Function FindAndRemove(Location TheLocation)
;	Int LocNum = RequestLocationNum("MyModName", TheLocation)
;	TemporaryLocationRemoveByNum(LocNum)
;	
;;		Obviously this should be call with the Property that identify this script	
;;			For Example SLSF.TemporaryLocationRemoveByNum(LocNum)
;EndFunction




;3.4 TemporaryLocationRemoveByCurrent---------------------------------------+
;	[UNTRACK; CURRENT LOCATION;]											|
;This function is used to remove the CURRENT Location from the list of 		|
; tracked locations. The use is obviously inverse from the add Function.	|
; Only the Temporary location could be removed (the 10 Location Other than	|
; those in the Base Location reference Chart), The Base Location will be	|
; simply Cleared (all fame To 0 and LimitMin and max Reset To 0 and 100).	|
; Obviously it ignores the 'Cannot Decay' parameter of the location.		|
;																			|
;Usage:	Stop to track the Specified Location.								|
;																			|
;Return:	Int, 0 Removed													|
;				 -1 Only Cleared (Or location invalid).						|
;																			|
;Note:	The User could always remove the location via MCM or Re-add.		|
;---------------------------------------------------------------------------+

Function TemporaryLocationRemoveByCurrent()
	FameMain.ResetFameByCurrent()
EndFunction

;Example:
;
;Function StopTrackThis()
;	TemporaryLocationRemoveByCurrent()
;;		Obviously this should be call with the Property that identify this script	
;;			For Example SLSF.TemporaryLocationRemoveByCurrent()
;EndFunction




;3.5 TemporaryLocationRemoveByLoc-------------------------------------------+
;	[UNTRACK; LOCATION;]													|
;This function is used to remove a Location from the list of tracked 		|
; locations. The use is obviously inverse from the add Function.			|
; Only the Temporary location could be removed (the 10 Location Other than	|
; those in the Base Location reference Chart), The Base Location will be 	|
; simply Cleared (all fame To 0 and LimitMin and Max Reset To 0 and 100).	|
; Obviously it ignores the 'Cannot Decay' parameter of the location			|
;																			|
;Usage:	Stop to track the Specified Location.								|
;																			|
;Values:	Location Which, the Location that you need to Remove.			|
;																			|
;Return:	Int, 0 Removed													|
;				 -1 Only Cleared (Or location invalid).						|
;																			|
;Note:	The User could always remove the location via MCM or Re-add.		|
;---------------------------------------------------------------------------+

Int Function RequestTemporaryLocationRemoveByLoc(Location Which)
	Return FameMain.ResetFameByLocation(Which)
EndFunction

;Example:
;
;Function RemoveLocation(Location That)
;	RequestTemporaryLocationRemoveByLoc(That)
;;		Obviously this should be call with the Property that identify this script		
;;			For Example SLSF.RequestTemporaryLocationRemoveByLoc(That)
;EndFunction




;3.6 SyncLocation-----------------------------------------------------------+
;	[SYNC; CURRENT LOCATION; PAPYRUS;]										|
;This function is used force a Syncronyzation between the Storage of the 	|
; Fame and the Globals used by various Purposes from other Mods (like the	|
; Comment plugin, etc.), Is meant to be used when interacting with the 		|
; Fame storage Directly with the PapyrusUtil Function, All the Commands		|
; of Fame Increase/decrease in this Script already execute the update by	|
; Itself, so there's no need to use this after those. Also does the 		|
; Add/remove tracking.														|
;																			|
;Usage:	Sync Globals with the current Location after interaction VIA 		|
;		Papyrus with the Fame Storage.										|
;---------------------------------------------------------------------------+

Function SyncLocation()
	SLSFUtil.CallSyncFameLocation()
EndFunction

;Example:
;
;Function MessingWithTheFameStorageWithPapyrusInsteadToUseOneOfThisDAMNGodzillionOfFunctions(Location TheLocation)
;	Int LocNum = RequestLocationNum("MyModName", TheLocation)
;	
;	If LocNum != -1
;		StorageUtil.IntListSet(None, "SLSF.LocationsFame.PC.Anal", LocNum, Utility.RandomInt(0,50))
;		StorageUtil.IntListSet(None, "SLSF.LocationsFame.PC.Argonian", LocNum, Utility.RandomInt(50,75))
;		StorageUtil.IntListSet(None, "SLSF.LocationsFame.PC.Beastiality", LocNum, Utility.RandomInt(0,100))
;		StorageUtil.IntListSet(None, "SLSF.LocationsFame.PC.Dominant/Master", LocNum, Utility.RandomInt(20,70))
;		StorageUtil.IntListSet(None, "SLSF.LocationsFame.PC.Exhibitionist/Exposed", LocNum, Utility.RandomInt(10,30))
;			;Change some Location Values Randomly if the Location is Tracked.
;	EndIf
;	
;	If Game.GetPlayer().GetCurrentLocation() == TheLocation
;		SyncLocation()
;		;If The PC is in the location that has been modified, Update the Globals
;		;	Note: Game.GetPlayer() is only for the Example and should be avoided.
;	EndIf
;
;;		Obviously this should be call with the Property that identify this script		
;;			For Example SLSF.SyncLocation()
;EndFunction




;3.7 ContageFame------------------------------------------------------------+
;	[PC; CONTAGE; LOCATION;]												|
;This function is used to trigger a PC Fame Contage between two Locations,	|
; using their LocNum. This function will ignore the Morbosity Required		|
; for the contage and will try to contage the fame by the base probability	|
; valid for every standard contage, OR it could be set to ignore the		|
; base probability and be always successful. The Amount of Fame Contaged	|
; Could also be overrided or left by the Set of the User in MCM.			|
; The Contager Is Always Needed, but if The contaged is left to -1 one		|
; Location will be chosen randomly. Consider the contage as a spreading of	|
; the fame of the PC.														|
;																			|
;Usage:	Contage the fame level of the PC between different Locations.		|
;																			|
;Values:	Int LocContager, The LocNum of the Location that will try		|
;							 to contage the other.							|
;			Int ToContage, The LocNum that will be contaged from the		|
;						   Contager, if set to -1 it will be chosen 		|
;						   randomly.										|
;			Bool AssuredContage, Override the probability of contage, the	|
;								 Location should obviously at least have	|
;								 one Pc Fame Type bigger than the Minimum	|
;								 fame needed for the contage.				|
;			Float OverrideContageAmount, Override the % of fame that will	|
;										 be used for the contage.			|
;										 If 0.0 will be used the MCM Value.	|
;																			|
;Return:	Bool, False Not contaged any point.								|
;				  True Contaged at least one element.						|
;																			|
;Note:	If Contager and Contage are the same location the Gain will be half	|
;		If they're not the same, if the Contager have a bigger fame Level a	|
;		percentual of that fame (MCM defined Or overrided) will be added to	|
;		the Contaged. If the Contaged have the Bigger value it will gain	|
;		the Half.															|
;---------------------------------------------------------------------------+

Bool Function ContageFame(Int LocContager, Int ToContage, Bool AssuredContage = False, Float OverrideContageAmount = 0.0 )
	Return SLSFUtil.ContageFame(LocContager, ToContage, AssuredContage, OverrideContageAmount)
EndFunction

;Example:
;
;Function ContageWhiterunFameToRiften()
;	ContageFame(6, 4, True)
;		;Contage The PC Fame from Witherun to Riften, override the Probability of Contage 
;		;	but use the percentages of Fame contage (Amount) setted in the MCM by the user.
;
;;		Obviously this should be call with the Property that identify this script		
;;			For Example SLSF.ContageFame(6, 4, True)
;EndFunction




;3.8 ModMorbosty------------------------------------------------------------+
;	[PC; CONTAGE; LOCATION; MORBOSITY;]										|
;This function is used to modify the Morbosity value of a specified			|
; Location (by Num). The Morbosity defines the probability that a location	|
; is chosen during the selection of the Contager in the standard Contage	|
; event.																	|
;																			|
;Usage:	To customize the Morbosity level of a Location. Like the other		|
;		parameter, it could be changed by the User via MCM.					|
;																			|
;Values:	Int LocNum, The LocNum of the Location where change the			|
;						Morbosity Value.									|
;			Float Value, This is the Value considered in the Mod Request,	|
;						 Range from -1.0 to 1.0.							|
;			Bool SetTheValue, If True the 'Value' will be SET as Morbosity,	|
;							  if False will be Added. Default False.		|
;																			|
;Return:	Bool, True Done													|
;				  False Failed (LocNum Wrong).								|
;																			|
;Note:	The current location, if tracked, will always be considered between	|
;		the possible Contager.												|
;		If SetTheValue is true and The Value is Negative, it will be		|
;		Considered as 0.0.													|
;---------------------------------------------------------------------------+

Bool Function ModMorbosty(Int LocNum, Float Value, Bool SetTheValue = False)
	Return SLSFUtil.ModMorbosty(LocNum, Value, SetTheValue)
EndFunction


;Example:
;
;Function ChangeTheMorbosityOfSomeLocations()
;	ModMorbosty(12, 0.5, True)
;		;Set The Morbosity of Riverwood as 50%.
;	
;	ModMorbosty(5, 0.2, False)
;		;Add 20% to the Morbosity of Solitude.
;	
;	ModMorbosty(3, -0.3, False)
;		;Subtract 30% to the Morbosity of Morthal.
;
;;		Obviously this should be call with the Property that identify this script		
;;			For Example SLSF.ModMorbosty(12, 0.5, True)	
;EndFunction




;3.9 ModMorbosityReq--------------------------------------------------------+
;	[PC; CONTAGE; LOCATION; MORBOSITY;]										|
;This function is used to modify the MorbosityReq value of a specified		|
; Location (by Num). The MorbosityReq defines the Morbosity required from	|
; other locations to contage this.											|
;																			|
;Usage:	To customize the MorbosityReq level of a Location. Like the other	|
;		parameter, it could be changed by the User via MCM.					|
;																			|
;Values:	Int LocNum, The LocNum of the Location where change the			|
;						Morbosity Value.									|
;			Float Value, This is the Value considered in the Mod Request,	|
;						 Range from -1.0 to 1.0.							|
;			Bool SetTheValue, If True the 'Value' will be SET as Morbosity,	|
;							  if False will be Added. Default False.		|
;																			|
;Return:	Bool, True Done													|
;				  False Failed (LocNum Wrong).								|
;																			|
;Note:	If SetTheValue is true and The Value is Negative, it will be		|
;		Considered as 0.0.													|
;---------------------------------------------------------------------------+

Bool Function ModMorbosityReq(Int LocNum, Float Value, Bool SetTheValue = False)
	Return SLSFUtil.ModMorbosityReq(LocNum, Value, SetTheValue)
EndFunction

;Example:
;
;Function ChangeTheMorbosityRequiredFromSomeLocations()
;	ModMorbosityReq(12, 0.5, True)
;		;Set The MorbosityReq of Riverwood as 50%.
;	
;	ModMorbosityReq(5, 0.2, False)
;		;Add 20% to the MorbosityReq of Solitude.
;	
;	ModMorbosityReq(3, -0.3, False)
;		;Subtract 30% to the MorbosityReq of Morthal.
;
;;		Obviously this should be call with the Property that identify this script
;;			For Example SLSF.ChangeTheMorbosityRequiredFromSomeLocations()
;EndFunction




;************************************************************************
;+--------------------													*
;|	-----------------+													*
;|	4 Actor Functions|													*
;|	-----------------+													*
;|These functions are used to interact/customize the Actors used in the	*
;| SLSF.																*
;+---------------------------------------------------------------------+*

;4.1 SetRoleType------------------------------------------------------------+
;	[PC; NPC; ROLETYPE;]													|
;This function is used to change the RoleType assigned to a specified 		|
; PC/NPC. As compatibility mesure, the Change of Roletype to the PC should	|
; be authorized by the User (a Request will be show). The Roletypes could 	|
; be manually changed by the user Via MCM and Debug Spell.					|
;																			|
;Usage:	Change the RoleType of the PC/NPC, allowing other Mods to treat it 	|
;		according of that RoleType.											|
;																			|
;Values:	String Sender, Is an identification used to notify to the Player|
;						   which mod is asking for the change of the 		|
;						   RoleType. Could be empty if Setting an NPC.		|
;			Actor Who, The PC/NPC where set the new Roletype.				|
;			Int RoleNum, The Num of the RoleType to set, according to the	|
;						 RoleTypes Chart.									|
;																			|
;Note: There's also other way to customize the Npc Roletype/other via 		|
;	   Overrides that could be more efficient, see the Papyrus Section.		|
;---------------------------------------------------------------------------+

Bool Function SetRoleType(String Sender, Actor Who, Int RoleNum)
	Return SLSFUtil.SetRoleType(Sender, Who, RoleNum)
EndFunction

;Example:
;
;Function GetEnslavedFrom(Actor Master, Actor Slave)
;	SetRoleType("MyModName", Master, 1, -1)
;		;If Master is the PC, a Request from "MyModName" will be showed to the User
;		;	That could choose if Accept it or not. The Roletype will be set for the
;		;	CURRENT Location.
;		;If Master is an NPC, it will be simply set with the new RoleType.
;	
;	SetRoleType("MyModName", Slave, Utility.RandomInt(40, 42), -1)
;		;Same as Above, but this time the Slave Npc will have a Random assignment of Submissive Type.
;
;;		Obviously this should be call with the Property that identify this script		
;;			For Example SLSF.SetRoleType("MyModName", Master, 1, -1)
;EndFunction




;4.2 UpdateEquip------------------------------------------------------------+
;	[PC; EQUIPSTATUS;]														|
;This function is used to ask for an immediate Equip status Update instead	|
; to wait for the next. Considering that most of the Update of the Equip 	|
; are immediate, the effective use of this could be only about the add of	|
; a new Slavetats (considering that the SlaveTats added doesn't send any	|
; standard/custom event).													|
;																			|
;Usage:	When you need to be sure that the Equip status is updated.			|
;																			|
;Values:	Int WhichSurface, The SurfaceNum (see The Chart) that you need	|
;							  Update, If -1 All surfaces.					|
;																			|
;Note: Really, I don't really know why I've made this function...			|
;---------------------------------------------------------------------------+

Function UpdateEquip(Int WhichSurface = -1)
	SLSFUtil.UpdateEquip(WhichSurface)
EndFunction

;Example:
;
;Function UpdateStatusEquip()
;	UpdateEquip()
;
;;		Obviously this should be call with the Property that identify this script		
;;			For Example SLSF.UpdateEquip()
;EndFunction




;4.3 CheckEquipStatusEffect-------------------------------------------------+
;	[PC; EQUIPSTATUS;]														|
;This is just an example about how to get the MagicEffects used by the		|
; Equip Status of SLSF. It Allow access to a more detailed equip check on  	|
; the PC, ready to use, instead to redo the check all the times.			|
;																			|
;Usage:	Simplification of the Equip Status on the PC, Know if a Device is	|
;		on sight or Hidden, it a Tats is Visible, The Pc is Naked, etc.		|
;																			|
;Note: All The glory to the Equip Status!									|
;---------------------------------------------------------------------------+

;There's no a Real Function about this, you simply Dismantle the example script in the part
;that you need to Check, remember that the Body Location are 4 (Body, Head, Hands, Feets)
;the Surfaces are 10, 9 for every Body Location and one Common for All (the 9).
;To know Which Surfaces check What, use the Surfaces Reference Chart.

;Example:
;
;Int Function CheckEquipStatusEffect()
;	Int Result = -1
;	If CheckSLSFLoaded()
;		Actor PlayerRef = Game.GetPlayer()
;			;Game.GetPlayer() Should be avoided, used as example.
;		
;		MagicEffect BodySlaveTatsHidden = Game.GetFormFromFile(0x00001DB2, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;		MagicEffect BodySlaveTatsInSight = Game.GetFormFromFile(0x00001DB3, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;		
;		If PlayerRef.HasMagicEffect(BodySlaveTatsHidden)
;			Result = 1
;		ElseIf PlayerRef.HasMagicEffect(BodySlaveTatsInSight)
;			Result = 2
;		Else
;			Result = 0
;		EndIf
;	EndIf
;	Return Result
;		; -1 No SLSF Loaded, 0 No SlaveTats, 1 Slavetats Hidden, 2 Slavetats In Sight.
;
;;		Obviously this should be call with the Property that identify this script		
;;			For Example SLSF.SurfacesStatus()
;EndFunction

;Here the Whole List of the MagicEffects used by the Equip Status.
;	MagicEffect MgeffBody_Sur1_H = Game.GetFormFromFile(0x00001DB2, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffBody_Sur1_S = Game.GetFormFromFile(0x00001DB3, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffBody_Sur2L_H = Game.GetFormFromFile(0x000221F6, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffBody_Sur2L_S = Game.GetFormFromFile(0x000221F7, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffBody_Sur2_S = Game.GetFormFromFile(0x000221F5, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffBody_Sur3_H = Game.GetFormFromFile(0x00001DB1, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffBody_Sur3_S = Game.GetFormFromFile(0x00001DB0, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffBody_Sur3_S_High = Game.GetFormFromFile(0x0002CE69, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffBody_Sur5_H = Game.GetFormFromFile(0x00001DAF, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffBody_Sur5_S = Game.GetFormFromFile(0x00001DAE, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffBody_Sur7_Naked = Game.GetFormFromFile(0x00001DAD, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	
;	MagicEffect MgeffFeet_Sur1_H = Game.GetFormFromFile(0x00001DA3, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffFeet_Sur1_S = Game.GetFormFromFile(0x00001DA2, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	
;	MagicEffect MgeffHand_Sur1_H = Game.GetFormFromFile(0x00001DA4, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffHand_Sur1_S = Game.GetFormFromFile(0x00001DA5, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	
;	MagicEffect MgeffHead_Sur1_H = Game.GetFormFromFile(0x00001DAB, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffHead_Sur1_S = Game.GetFormFromFile(0x00001DAC, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffHead_Sur3_H = Game.GetFormFromFile(0x00001DA7, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffHead_Sur3_S = Game.GetFormFromFile(0x00001DA8, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffHead_Sur3_S_High = Game.GetFormFromFile(0x0002C3A3, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffHead_Sur5_H = Game.GetFormFromFile(0x00001DAA, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffHead_Sur5_S = Game.GetFormFromFile(0x00001DA9, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffHead_Sur7_Anonymus = Game.GetFormFromFile(0x00001DA6, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffHead_Sur7_HeadCover = Game.GetFormFromFile(0x0002DE90, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;		;The Anonymus is present Only if the User has the Allow Anonymous Enabled, The headcover always. Only the Anonymous prevent the Fame Gain.
;
;	MagicEffect MgeffHead_Sur9 = Game.GetFormFromFile(0x00001D90, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;		;The Surface 9 is one for All the Body Location, is used for "Big Devices Not Hiddable"
;
;	MagicEffect MgeffSum_Sur1 = Game.GetFormFromFile(0x00003351, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffSum_Sur3 = Game.GetFormFromFile(0x00003352, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;	MagicEffect MgeffSum_Sur5 = Game.GetFormFromFile(0x00003350, "SexLab - Sexual Fame [SLSF].esm") As MagicEffect
;		;The "Sum" are Cumulative Check use to know if 	




;4.4 RequestSuspendShameAnim------------------------------------------------+
;	[PC; ANIMATION; SHAME;]													|
;This function is used to request the suspension of the shame anim trigger	|
; from the SLSF. This is a compatibility features to avoid Animation 		|
; conflict.																	|
;																			|
;Usage:	When your mod trigger an Animation that -could- coincide with the	|
;		Shame Anim event (PC Naked, Not Exhibitionist and Shame Anim Enabled|
;		in the MCM).														|
;																			|
;Values:	Bool YesOrNot, if the Shame Anim shou... Really? I must explain |
;						   This!?											|
;																			|
;Note: As Safe mesure The Suspension is revoked at every LoadGame, In case	|
;	   refresh the suspension.												|
;---------------------------------------------------------------------------+

Function RequestShameAnimSuspension(Bool YesOrNot = True)
	SLSFUtil.SuspendShameAnimByRequest(YesOrNot)
EndFunction

;Example:
;
;Function PlayTheDefinitiveAnimationWithoutSLSFMessingAround()
;	RequestShameAnimSuspension()
;	Debug.SendAnimationEvent(Game.GetPlayer(), "IdleWipeBrow")
;		;Do not use Game.GetPlayer(), Is Evil.
;	RequestShameAnimSuspension(False)
;
;;		Obviously this should be call with the Property that identify this script		
;;			For Example SLSF.RequestShameAnimSuspension()
;EndFunction




;4.5 GetReactionType--------------------------------------------------------+
;	[NPC; REACTIONTYPE;]													|
;The Reactions are shortcuts used to get a Reaction Type based on the		|
; Relationship with the PC of the NPC and his RoleType, allowing a 			|
; differentiation between the NPC for various Interactions. Is This NPC		|
; Socially friendly to the PC? Affactive? Offensive?						|
;																			|
;Usage:	Differentiation of the NPCs, used to Immersive purposes and to give	|
;		some personality to the NPCs.										|
;																			|
;Values:	Actot Who, The Npc to Check.									|
;																			|
;Return:	Int, The ReactionType Num, See the ReactionType Reference Chat.	|
;				 -1 If SLSF Not loaded.										|
;---------------------------------------------------------------------------+

Int Function GetReactionType(Actor Who)
	Return SLSFUtil.GetReactionType(Who)
EndFunction

;Example:
;
;Bool Function IsFriendly(Actor Who)
;	Int ReactionType = GetReactionType(Who)
;	If ReactionType > 1 && ReactionType < 5
;		Return True
;	Else
;		Return False
;	EndIf
;;		Obviously this should be call with the Property that identify this script		
;;			For Example SLSF.GetReactionType(Who)
;EndFunction




;4.6 GetRoleType------------------------------------------------------------+
;	[PC; NPC; ROLETYPE;]													|
;This Function Is meant to Get the RoleType of the NPC/PC without the need	|
; of use directly the SLSF, good for compatibility. This way you could 		|
; eventually check if the User have the SLSF loaded and, in that, case use	|
; the SLSF references to get an appropriate Npc instead that a Random One.	| 
;																			|
;Usage:	Check the RoleTypes of an NPC/PC with Soft Dependancy.				|
;																			|
;Values:	Actot Who, The NPC/PC to Check.									|
;																			|
;Return:	Int, The RoleType Num, See the RoleType Reference Chat.			|
;				 -1 If SLSF Not loaded										|
;				 -2 Who not in the Roletype Faction, not initialized By SLSF|
;				 -3 Who Excluded from the checks for Roletypes.				|
;---------------------------------------------------------------------------+

Int Function GetRoleType(Actor Who)
	Return SLSFUtil.AccessFunctionGetRoleType(Who)
EndFunction

;Example:
;
;Actor Function FindAnNPCDominant(Actor[] ListOfNPC)
;	Int a = ListOfNPC.Length
;	Int b
;	Int Found
;	While a > 0
;		a -= 1
;		b =  GetRoleType(ListOfNPC[a])
;		If b >= 0 && b <= 2
;			Found = a
;			a = 0
;		EndIf
;	EndWhile
;	
;	Return ListOfNPC[Found]
;;		Obviously this should be call with the Property that identify this script		
;;			For Example SLSF.GetRoleType(Who)
;EndFunction




;4.7 GetRoleGroup-----------------------------------------------------------+
;	[PC; NPC; ROLETYPE;]													|
;This Function is a simple Shortcut to check the RoleType Group of the 		|
; PC/NPC, instead to Return the RoleType Num it simply tell in which group	|
; of RoleTypes the PC/NPC is between Dominant(0), Neutral(1), Submissive(2).|
;																			|
;Usage:	Read again the name...												|
;																			|
;Values:	Actot Who, The NPC/PC to Check.									|
;																			|
;Return:	Int, The RoleGroup Num, Dominant(0), Neutral(1), Submissive(2).	|
;				 -1 If SLSF Not loaded										|
;				 -2 Who not in the Roletype Faction, not initialized By SLSF|
;				 -3 Who Excluded from the checks for Roletypes.				|
;---------------------------------------------------------------------------+

Int Function GetRoleGroup(Actor Who)
	Return SLSFUtil.GetRoleGroup(Who)
EndFunction

;Example:
;
;Actor Function FindAnNPCDominant(Actor[] ListOfNPC)
;	Int a = ListOfNPC.Length
;	Int b
;	Int Found
;	While a > 0
;		a -= 1
;		b =  GetRoleGroup(ListOfNPC[a])
;		If b == 0
;			Found = a
;			a = 0
;		EndIf
;	EndWhile
;	
;	Return ListOfNPC[Found]
;;		Obviously this should be call with the Property that identify this script		
;;			For Example SLSF.GetRoleGroup(Who)
;EndFunction




;4.8 ToggleNPCExclusionSLSF-------------------------------------------------+
;	[NPC; EXCLUSION;]														|
;This Function is used to Toggle the Exclusion of an Npc from the SLSF, it	|
; will be ignored from all the system of the SLSF.							|
;																			|
;Usage:	Toggle the Exclusion of an NPC from SLSF.							|
;																			|
;Values:	Actor Who, The NPC where toggle the Exclusion.					|
;																			|
;Return:	Bool, The New status of the Npc about Exclusion.				|
;																			|
;Note: To Check f an Npc is already Excluded use The Papyrus Command,		|
;	   StorageUtil.GetIntValue(Who, "SLSF.Exclusion"),						|
;	   if Return 1 The NPC is Excluded, 0 is Not.							|
;---------------------------------------------------------------------------+

Bool Function ToggleNPCExclusionSLSF(Actor Who)
	Return SLSFUtil.ToggleNPCExclusionSLSF(Who)
EndFunction

;Example:
;
;Function MySacredNPCThatShouldntBeUsedNEVER(Actor Who)
;	Bool Result = ToggleNPCExclusionSLSF(Who)
;	
;	If Result
;		Debug.Notification("Phewww! It's Safe Now!")
;	Else
;		Debug.Notification("OMG! SOMEONE CALL THE POLICE! IT ISN'T EXCLUDED!")
;	EndIf
;;		Obviously this should be call with the Property that identify this script		
;;			For Example SLSF.ToggleNPCExclusionSLSF(Who)	
;EndFunction




;4.9 ToggleNPCNoCommentSLSF-------------------------------------------------+
;	[NPC; NOCOMMENT;]														|
;The NoComment is a status where The NPC always get the ReactionType 0		|
; It should Prevent the NPC from spoke lines of dialogue based on the SLSF	|
; IF the comment plugin has the right condition set. In alternative there	|
; are others command that could suit your needs, like the RequestSceneInUse	|
; or the RequestSetCommentProbability.										|
;																			|
;Usage:	Toggle the NoComment Status of an NPC from SLSF.					|
;																			|
;Values:	Actor Who, The NPC where toggle the NoComment.					|
;																			|
;Return:	Bool, The New status of the Npc about NoComment.				|
;																			|
;Note: To Check f an Npc is already NoComment use The Papyrus Command,		|
;	   StorageUtil.GetIntValue(Who, "SLSF.NoComment"),						|
;	   if Return 1 The NPC is NoComment, 0 is Not.							|
;---------------------------------------------------------------------------+

Bool Function ToggleNPCNoCommentSLSF(Actor Who)
	Return SLSFUtil.ToggleNPCNoCommentSLSF(Who)
EndFunction

;Example:
;
;Function MyInvisibleScenicNpcThatShouldStayMute(Actor Who)
;	Bool Result = ToggleNPCNoCommentSLSF(Who)
;	
;	If Result
;		Debug.Notification("Damn... It's speaks again...")
;	Else
;		Debug.Notification("All right, Keep that Mouth shut.")
;	EndIf
;;		Obviously this should be call with the Property that identify this script		
;;			For Example SLSF.ToggleNPCNoCommentSLSF(Who)	
;EndFunction




;************************************************************************
;+-------------------													*
;|	----------------+													*
;|	5 Misc Functions|													*
;|	----------------+													*
;|These functions are Too hot to share the same space with the 'others'.*
;+---------------------------------------------------------------------+*

;5.1 RequestSetCommentProbability-------------------------------------------+
;	[COMMENT; MISC;]														|
;This function is used to change the Comment probability that the SLSF uses	|
; for the comment plugins, as Safe Mesure the value will return to the 		|
; previously setted value if the User load the game.						|
;																			|
;Usage: In case you need to reduce the verbose mode from the Plugin.		|
;																			|
;Values:	Float HowMuch, The value that the Comment Probability should get|
;						   From 0.0 to 1.0, Negative number will restore the|
;						   Value set by the User.							|
;																			|
;Note: As Safe mesure the value is restored to the User settings when the	|
;	   Game is Load.														|
;	   You could also exclude individual Npc from the Comment System 		|
;	   instead to change the Comment probability, see the Papyrus section 	|
;	   for more info.														|
;	   Note that the RequestSceneInUse also block all the Comment via SLSF,	|
;	   so there's no need to use both this command, but just the right one.	|
;---------------------------------------------------------------------------+

Function RequestSetCommentProbability(Float HowMuch = -1.0)
	SLSFUtil.SetCommentProbability(HowMuch)
EndFunction

;Example:
;
;Function ReduceTheVerboseMode()
;	RequestSetCommentProbability(0.3)
;	
;	;...Do things...
;	
;	RequestSetCommentProbability(-1.0)
;		;Return to the Previous Value.
;		
;;		Obviously this should be call with the Property that identify this script		
;;			For Example SLSF.RequestSetCommentProbability(0.3)	
;EndFunction




;5.2 CheckSceneInUse--------------------------------------------------------+
;	[SCENE; MISC; COMPATIBILITY;]											|
;This function is only to know if a SLSF scene is currently running, It's 	|
; only a compatibilty function to avoid multiple mod playing scenes at the	|
; same time. When a Modder use the 'RequestSceneinUse()' function it change	|
; the return value of this, allowing all who check to know that the scene	|
; is 'occupied'. It doesn't Stop/Start/Block any scene, it also prevent		|
; the SLSF comments to be spoken, to avoid interferences.					|
;																			|
;Usage: Know if someone has declared to use a Scene.						|
;																			|
;Return:	Bool, True someone has declared to using the scene				|
;				  False no one has declared to using the scene or SLSF not	|
;				  Loaded.													|
;																			|
;Note: the value is stored in a Global Variable so it could also be used 	|
;	   directly in the CK.													|
;	   When the Scene is in use also the Comment probability is disabled 	|
;	   to avoid interferences.												|
;---------------------------------------------------------------------------+

Bool Function CheckSceneinUse()
	Return SLSFUtil.CheckSceneinUse()
EndFunction

;Example:
;
;Function IsTheSLSFUsingTheScene()
;	If CheckSceneinUse()
;		Debug.Notification("The Scene is In Use.")
;	Else
;		Debug.Notification("The Scene is free.")
;	EndIf
;;		Obviously this should be call with the Property that identify this script		
;;			For Example SLSF.CheckSceneinUse()	
;EndFunction




;5.3 RequestSceneInUse------------------------------------------------------+
;	[SCENE; MISC; COMPATIBILITY;]											|
;This function is used to declare the use of the scene, It doesn't put a	|
; real limit to other scene, is only a way to let know to other modders that|
; there's a scene in use with the SLSF, Like the "Sex Lab Animating" faction|
; for the PC/NPC. Enabling the request will also stop the SLSF comment to 	|
; be used, to avoid general interferences.									|
;																			|
;Usage: Declare the you're using the scene and allow other to know that.	|
;																			|
;Values:	Bool RequestUse, Specific if you're requesting for the use or 	|
;							 the release of the Scene.						|
;																			|
;Return:	Bool, True The scene as been requested successfully.			|
;				  False the scene is already in use by someone else.		|
;																			|
;Note: When the Scene is in use also the Comment probability is disabled 	|
;	   to avoid interferences.												|
;	   'Requested Successfully' means that now the command is executed (Use	|
;	   of the Scene or Release).											|
;---------------------------------------------------------------------------+

Bool Function RequestSceneInUse(Bool RequestUse)
	Return SLSFUtil.Request_SceneInUse(RequestUse)
EndFunction

;Example:
;
;Function PlayingTheAwesomeScene()
;	If !RequestSceneInUse(True)
;		Debug.Notification("I Can't start the awesome scene because the SLSF says that someone is playing a scene lesser awesome.")
;	Else
;		Debug.Notification("Ok, I could play the awesome scene, but I decided that is Too awesome for people like You.")
;		RequestSceneInUse(False)
;	EndIf
;	
;;		Obviously this should be call with the Property that identify this script		
;;			For Example SLSF.RequestSceneInUse(True)	
;EndFunction




;5.3 CheckSLSFLoaded--------------------------------------------------------+
;	[SLSF; MISC; COMPATIBILITY;]											|
;NOT NEEDED IN HARD DEPENDANCY												|
;---------------------------------------------------------------------------+

Bool Function CheckSLSFLoaded()
	Return True
EndFunction

;Example:
;
;Function DoStuff()
;	Bool IsSLSFLoad = CheckSLSFLoaded()
;	If IsSLSFLoad
;		Debug.Notification("SLSF is loaded.")
;	Else
;		Debug.Notification("SLSF isn't loaded, Start the procedure to randomly change the Load Order of this guy...")
;	EndIf
;
;;		Obviously this should be call with the Property that identify this script		
;;			For Example SLSF.CheckSLSFLoaded(True)
;EndFunction



	
;************************************************************************
;+------------------------												*
;|	---------------------+												*
;|	6 PapyrusUtil Element|												*
;|	---------------------+												*
;|These Papyrus Element are used for various purposes allowing access	*
;| to simple effects in the SLSF, Use with caution, NEVER Unset or		*
;| clear.																*
;+---------------------------------------------------------------------+*

;6.1 FameStorages-----------------------------------------------------------+
;	[FAME; STORAGE; PAPYRUS;]												|
;These are simple Papyrus Util element used to store the fame values and	|
; other elements useful for the Fame System. You could Freely access this	|
; but using the adequate Functions above is better for various reasons.		|
; Anyway, if SETTING with this remember to call a RequestSyncLocation (3.6).|
; Their best use is to GET the Fame values.									|
;																			|
;Usage: Good for Get the Values and eventually also for Set them, in that	|
;		case remember to Call the Function 3.6, but as said, is best to use	|
;		the specific function to modify the Fame levels.					|
;																			|
;Note: The 'KeyName' are a composite of a Base Prefix plus the Exact name	|
;	   of the fame Type, use the FameList Reference Chart (PC/NPC).			|
;	   For the Location Num use the Location Base Chart, or the Function	|
;	   RequestLocationNum (3.1).											|
;	   When Setting/modifing Etc. Try to avoid to set the Value to Negative	|
;	   The system has no problem with them (autoFix) still there's could be	|
;	   strange behavior for Mods that directly access the fame via Papyrus.	|
;---------------------------------------------------------------------------+

;Theres No Functions for this, only Simple command to use directly, here the list.

;Examples:
;Function ExamplesPapyrusCommandsFame(String FameType, Int LocNum, Int ValueToSet, Int Modifier)
;	Int Value
;	Value = StorageUtil.IntListGet(None, "SLSF.LocationsFame."+FameType, LocNum)
;		;With this Get the Value of that type of Fame (Es. "PC.Anal" or "NPC.LIbertine", etc.),
;		;	for the Location Num provided (es. 0 = Dawnstar)
;		
;	StorageUtil.IntListSet(None, "SLSF.LocationsFame."+FameType, LocNum, ValueToSet)
;		;With this you set an absolute value that will take the Place of the previous,
;		;	As above, FameType on the FameList Chart PC/NPC, LocNum is the Location Num,
;		;	And ValueToSet is the new Value.
;	
;	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame."+FameType, LocNum, Modifier)
;		;With this you will CHANGE the value stored Increasing or Decreasing with the Modifier Value
;		;	the value already Stored, avoid to left set negative values.
;EndFunction




;6.2 FameLimits-------------------------------------------------------------+
;	[FAME; STORAGE; LIMITS; PAPYRUS;]										|
;These are simple Papyrus Util element used to Set the fame Limit Min/Max	|
; Every Fame Type have it's proper FameLimit Min/Max for each Location		|
; tracked. Those limits are simply the Range of the Fame level inside the	|
; more general limit of 0-100.												|
;																			|
;Usage: Change the Min/Max values for a specified FameType in a Specified 	|
;		Location															|
;																			|
;Note: The 'KeyName' are a composite of a Base Prefix plus the Exact name	|
;	   of the fame Type [FameList Reference Chart (PC/NPC)] and a last Part |
;	   with the Identifier of the Limit Min/Max.							|
;	   For the Location Num use the Location Base Chart, or the Function	|
;	   RequestLocationNum (3.1).											|
;	   When Setting/modifing Etc. Try to avoid to set the Value to Negative	|
;	   The system has no problem with them (autoFix) still there's could be	|
;	   strange behavior for Mods that directly access the fame via Papyrus.	|
;---------------------------------------------------------------------------+

;Theres No Functions for this, only Simple command to use directly, here the list.

;Examples:
;Function ExamplesPapyrusCommandsFameLimit(String FameType, Int LocNum, Int ValueToSet, Int Modifier)
;	Int ValueMin
;	Int ValueMax
;	ValueMin = StorageUtil.IntListGet(None, "SLSF.LocationsFame."+FameType+".LevelMin", LocNum)
;	ValueMax = StorageUtil.IntListGet(None, "SLSF.LocationsFame."+FameType+".LevelMax", LocNum)
;		;With this Get the Value of the Limit Min/Max of FameType (Es. "PC.Anal" or "NPC.LIbertine", etc.),
;		;	for the Location Num provided (es. 6 = Whiterun)
;		
;	StorageUtil.IntListSet(None, "SLSF.LocationsFame."+FameType+".LevelMin", LocNum, ValueToSet)
;	StorageUtil.IntListSet(None, "SLSF.LocationsFame."+FameType+".LevelMax", LocNum, ValueToSet)
;		;With this you set an absolute value that will take the Place of the previous,
;		;	As above, FameType on the FameList Chart PC/NPC, LocNum is the Location Num,
;		;	And ValueToSet is the new Value.
;	
;	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame."+FameType+".LevelMin", LocNum, Modifier)
;	StorageUtil.IntListAdjust(None, "SLSF.LocationsFame."+FameType+".LevelMax", LocNum, Modifier)
;		;With this you will CHANGE the value stored Increasing or Decreasing with the Modifier Value
;		;	the value already Stored, avoid to left set negative values.
;EndFunction




;6.3 GetAllLocationForm-----------------------------------------------------+
;	[LOCATION; PAPYRUS;]													|
;This is a simple Function used to recover the whole Actual list of the 	|
; Locations currently loaded on the SLSF. For various use.					|
;																			|
;Usage: Get a Location[] list of the current Loaded Locations.				|
;																			|
;Return:	Location[], The list.											|
;																			|
;Note: Do Not Change/Set/Unset/Clear This, it should be considered ReadOnly.|
;---------------------------------------------------------------------------+

Location[] Function GetAllLocationForm()
	Return SLSFUtil.GetAllLocationForm()
EndFunction

;Example:
;
;Bool Function IsThisLocationTrackedBySLSF(Location This)
;	Location[] ListSLSFLoc = GetAllLocationForm()
;	
;	If ListSLSFLoc.Find(This) != -1
;		Return True
;	Else
;		Return False
;	EndIf
;;	Note: Poor Example, a check of this Type is more efficient if done with the RequestLocationNum (3.1).
;
;;		Obviously this should be call with the Property that identify this script		
;;			For Example SLSF.GetAllLocationForm()	
;EndFunction




;************************************************************************
;+-----------------------------											*
;|	--------------------------+											*
;|	7 List Of StorageUtil Used|											*
;|	--------------------------+											*
;|This is a simple list of the StorageUtil used for various puproses.	*
;+---------------------------------------------------------------------+*

;;Globals
;LIST:
;"SLSF.LocationsFame."+FameName -> [Int] List of Fame Storage, The Index is The LocNum (see the Chart).
;"SLSF.LocationsFame."+FameName+".LevelMin" -> [Int] List of Level Min for the fame Storage, The index is The LocNum (see the Chart).
;"SLSF.LocationsFame."+FameName+".LevelMax" -> [Int] List of Level Max for the fame Storage, The index is The LocNum (see the Chart).
;"SLSF.LocationsFame.CannotDecay" -> [Int] List of the Flags 'Cannot Decay' a way to avoid The Reset of a Temporary location when not uses for some time, 0 Not, 1 Yes.
;"SLSF.LocationsFame.Form" -> [Form] List of the Form of the Various Location Currently Tracked, The index is the LocNum.
;
;;On Npc
;SINGLE:
;"SLSF.Exclusion" -> [Int] Npc Excluded From SLSF, 0 Not, 1 Yes.
;"SLSF.NoComment" -> [Int] Npc get a Reaction Type = 0 (no Reaction), 0 Not, 1 Yes.
;"SLSF.Override.RoleType" -> [Int] Override for the Assignment of a RoleType to an Npc when Initialized by SLSF. ONLY for Unique.
;"SLSF.Override.Exhibitionism" -> Override to Set an Npc as Exhibitionist when Initialized by SLSF, 0 Not, 1 Yes. ONLY for Unique.





;-----------------------------------------------------------+
;DO NOT ACCESS THIS, Internal, High possibility to make mess|
;-----------------------------------------------------------+

;Reciving Event From Compatibility
Function MaintenanceForEvents()
	Self.UnregisterForAllModEvents()
	Utility.Wait(0.5)
	;Fame Functions
	RegisterForModEvent("SLSF_Request_CreateFameModEvent", "Request_FameModEvent")
	RegisterForModEvent("SLSF_Request_ModFameValueByNum", "Request_ModFameValueByNum")
	RegisterForModEvent("SLSF_Request_ModFameValueByCurrent", "Request_ModFameValueByCurrent")
	RegisterForModEvent("SLSF_Request_ModFameValueByLocation", "Request_ModFameValueByLocation")
	RegisterForModEvent("SLSF_Request_PeriodicFameGain", "Request_PeriodicFameGain")
	;Location Functions
	RegisterForModEvent("SLSF_Request_LocationNum", "Request_LocationNum")
	RegisterForModEvent("SLSF_Request_TemporaryLocationAdd", "Request_TemporaryLocationAdd")
	RegisterForModEvent("SLSF_Request_TemporaryLocationRemoveByNum", "Request_TemporaryLocationRemoveByNum")
	RegisterForModEvent("SLSF_Request_TemporaryLocationRemoveByCurrent", "Request_TemporaryLocationRemoveByCurrent")
	RegisterForModEvent("SLSF_Request_TemporaryLocationRemoveByLoc", "Request_TemporaryLocationRemoveByLoc")
	RegisterForModEvent("SLSF_Request_SyncLocation", "Request_SyncLocation")
	RegisterForModEvent("SLSF_Request_Contage", "Request_Contage")
	RegisterForModEvent("SLSF_Request_ModMorbosity", "Request_ModMorbosity")
	RegisterForModEvent("SLSF_Request_ModMorbosityReq", "Request_ModMorbosityReq")
	;Actor Functions
	RegisterForModEvent("SLSF_Request_SetRoleType", "Request_SetRoleType")
	RegisterForModEvent("SLSF_Request_UpdateEquip", "UpdatePlayerEquipStatus")
	RegisterForModEvent("SLSF_Request_ShameAnimPause", "SuspendShameAnimByRequest")
	;Misc Functions
	RegisterForModEvent("SLSF_Request_SetCommentProbability", "SetCommentProbability")
	RegisterForModEvent("SLSF_RequestSceneUse", "Request_SceneInUse")
	
	;Compatibility with other Mods
	RegisterForModEvent("DeviceVibrateEffectStart", "FameIncreaseByDD")
	RegisterForModEvent("ECBirthCompleted", "EsChaurus_BirthCompleted")
	RegisterForModEvent("SGO.OnBirthed", "SGO_BirthCompleted")
EndFunction

Event Request_FameModEvent(String TempBuffer, Float Multiplier = 1.0)
	Int[] List = StorageUtil.IntListToArray(None, TempBuffer)
	StorageUtil.IntListClear(None, TempBuffer)
	FameMain.FamePcExternalMod(List, Multiplier)
EndEvent

Event Request_ModFameValueByNum(Int FameGroup, Int FameNum, Int LocNum, Int Many, Bool ApplyUserMod = True, Int LimitMin = 0, Int LimitMax = 100)
	FameMain.ModFameValueByNum(FameGroup, FameNum, LocNum, Many, ApplyUserMod, LimitMin, LimitMax)
EndEvent

Event Request_ModFameValueByCurrent(Int FameGroup, Int FameNum, Int Many, Bool ApplyUserMod = True, Int LimitMin = 0, Int LimitMax = 100)
	FameMain.ModFameValueByCurrent(FameGroup, FameNum, Many, ApplyUserMod, LimitMin, LimitMax)
EndEvent

Event Request_ModFameValueByLocation(Int FameGroup, Int FameNum, Form Where, Int Many, Bool ApplyUserMod = True, Int LimitMin = 0, Int LimitMax = 100)
	If Where As Location
		FameMain.ModFameValueByLocation(FameGroup, FameNum, Where As Location, Many, ApplyUserMod, LimitMin, LimitMax)
	EndIf
EndEvent

Event Request_PeriodicFameGain(String Sender, Int FameNum, Int LimitMax)
	SLSFUtil.PeriodicFameGain(Sender, FameNum, LimitMax)
EndEvent

Event Request_LocationNum(String Sender, Form Which)
	If Sender == ""
		Return
	EndIf
	
	Int Response = -1
	If Which as Location
		Response = SLSFUtil.ObtainFameLocationNum(Which as Location)
	EndIf
	StorageUtil.SetIntValue(None, "SLSF.RequestedLocNum."+Sender, Response)
EndEvent

Event Request_TemporaryLocationAdd(Form Which, Bool CannotDecay, Float Morbosity, Float MorbosityReq )
	If Which as Location
		FameMain.RegisterTemporaryLocation(Which as Location, False, CannotDecay, Morbosity, MorbosityReq)
	EndIf
EndEvent

Event Request_TemporaryLocationRemoveByNum(Int LocNum)
	FameMain.ResetFameByNum(LocNum)
EndEvent

Event Request_TemporaryLocationRemoveByCurrent()
	FameMain.ResetFameByCurrent()
EndEvent

Event Request_TemporaryLocationRemoveByLoc(Form Which)
	If Which as Location
		FameMain.ResetFameByLocation(Which as Location)
	EndIf
EndEvent

Event Request_SyncLocation()
	SLSFUtil.CallSyncFameLocation()
EndEvent

Event Request_Contage(Int ContagerNum, Int ToContageNum, Bool AssuredContage, Float OverrideContageAmount = 0.0)
	SLSFUtil.ContageFame(ContagerNum, ToContageNum, AssuredContage, OverrideContageAmount)
EndEvent

Event Request_ModMorbosity(Int LocNum, Float Value, Bool SetTheValue = False)
	SLSFUtil.ModMorbosty(LocNum, Value, SetTheValue)
EndEvent

Event Request_ModMorbosityReq(Int LocNum, Float Value, Bool SetTheValue)
	SLSFUtil.ModMorbosityReq(LocNum, Value, SetTheValue)
EndEvent

Event Request_SetRoleType(String Sender, Form Who, Int RoleNum)
	If Who as Actor
		SLSFUtil.SetRoleType(Sender, Who as Actor, RoleNum)
	EndIf
EndEvent

Event UpdatePlayerEquipStatus(Int WhichSurface)
	SLSFUtil.UpdateEquip(WhichSurface)
EndEvent

Event SuspendShameAnimByRequest(Bool YesOrNot)
	SLSFUtil.SuspendShameAnimByRequest(YesOrNot)
EndEvent

Event SetCommentProbability(Float HowMuch)
	SLSFUtil.SetCommentProbability(HowMuch)
EndEvent

Event Request_SceneInUse(Bool RequestUse)
	SLSFUtil.Request_SceneInUse(RequestUse)
EndEvent

SLSF_Utility Property SLSFUtil Auto
SLSF_FameMaintenance Property FameMain Auto
