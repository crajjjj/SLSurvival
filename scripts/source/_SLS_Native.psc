Scriptname _SLS_Native Hidden
{Natives of SLSurvival.dll (source in plugin\). SL Survival runs without the DLL: check IsLoaded()
before calling a native, because without it they are unbound and every call logs an error.}

; A released native never changes signature: the VM rejects a call whose argument count differs,
; and callers compiled against the old one send the old count forever. New options = new native,
; and a higher GetAPIVersion().

Bool Function IsLoaded() Global
	Return SKSE.GetPluginVersion("SLSurvival") > 0
EndFunction

; 1: FillQuestAliases, HasContraband
Int Function GetAPIVersion() Global Native

; The actors akQuest's reference aliases would hold if it were started now, one entry per alias
; in alias order (None where nothing would fill), from the aliases' own conditions in the plugin
; and closest to the player first. Nothing is started or filled. Only "Find Matching Reference"
; aliases are simulated. A None entry is exact; a filled one can be a guard the engine would
; skip because another quest reserved it.
Actor[] Function FillQuestAliases(Quest akQuest) Global Native

; One of _SLS_LicenceUtil's inventory checks in a single call, by the same rules:
; aiKind 0 ActorHasArmor, 1 HasWeapon, 2 HasMagicItem, 3 HasClothes.
Bool Function HasContraband(ObjectReference akTarget, Int aiKind, FormList akArmorExceptions, FormList akWeaponExceptions, Int aiFollowerLicStyle) Global Native
