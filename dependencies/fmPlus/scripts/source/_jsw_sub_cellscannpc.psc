ScriptName	_JSW_SUB_CellScanNPC	Extends	ActiveMagicEffect

_JSW_SUB_MiscUtilAlias		Property	MiscUtilAlias		Auto	; 
_JSW_SUB_GVAlias			Property	GVAlias				Auto	; 

Int							Property	gender				Auto	;	Actor's gender passed in by ME
; 2.24
Formlist					Property	ExcludeAT			Auto	; associations used for eliminating random inseminators
; 2.26
; 2.26a removed
;Form						Property	NoScanPot			Auto	; potion to prevent immediately re-running this on actors
; 2.26a no need to remember this
;bool		sent		=	false
form		thisActor	=	none
; 2.24
int			flags		=	0										; AssociationType Flags
string		locName		=	""
location	where		=	none

event OnEffectStart(Actor akTarget, Actor akCaster)

	if !akTarget
		return
	endIf
	thisActor = akTarget as form
	if (gender == 1)
		if (GVAlias.TACopy.Find(thisActor) != -1)
			return
		endIf
	else
		if (GVAlias.TFCopy.Find(thisActor) != -1)
			return
		endIf
	endIf
	string myName = akTarget.GetDisplayName()
    if (!myName || (GVAlias.BlacklistCopy.Find(thisActor) != -1) || (GVAlias.BLByNameCopy.Find(myName) != -1))
		return
	endIf
	; 2.26a
;	where = GVAlias.here
	where = akTarget.GetCurrentLocation()
	if where
		locName = where.GetName()
		if locName == ""
			locName = "Skyrim"
		endIf
	else
		locName = "Tamriel"
	endIf
	; 2.25
	if !akTarget.GetLeveledActorBase().IsUnique()
		flags = -1
	elseIf akTarget.HasFamilyRelationship()
		flags = 0x01
		int FLLength = ExcludeAT.GetSize()
		int count = 0
		while (count < FLLength)
			if akTarget.HasAssociation(ExcludeAT.GetAt(count) as AssociationType)
				flags = Math.LogicalOR(flags, Math.LeftShift(0x01, (count + 1)))
			endIf
			count += 1
		endWhile
	endIf
	OnUpdate()

endEvent

event	OnUpdate()

;	sent = MiscUtilAlias.Queue(thisActor, locName, where as form, (gender == 1), flags)
	; 2.26a disable potion, it was being left in inventory with certain mod combinations
;/	if sent
		(thisActor as actor).Additem(NoScanPot, 1, true)
		(thisActor as actor).EquipItem(NoScanPot, true, true)
	else/;
	if MiscUtilAlias.Queue(thisActor, locName, where as form, (gender == 1), flags)
		return
	endIf
	RegisterForSingleUpdate(0.012)

endEvent
