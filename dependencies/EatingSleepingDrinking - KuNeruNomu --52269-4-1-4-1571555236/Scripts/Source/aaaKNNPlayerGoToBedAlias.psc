Scriptname aaaKNNPlayerGoToBedAlias extends ReferenceAlias  

Package Property PlayerSleepingPackage auto

Event OnPackageStart(Package akNewPackage)
	;Debug.Trace("OnPackageStart : " + akNewPackage)
	if PlayerSleepingPackage == akNewPackage
		;Debug.Trace("OnPackageStart : " + akNewPackage)
		(GetOwningQuest() as aaaKNNPlayerGoToBedQuest).StartScene()
	endIf
EndEvent

;Event OnPackageChange(Package akOldPackage)
;	Debug.Trace("OnPackageChange : " + akOldPackage)
;	Debug.Trace("OnPackageChange : " + Game.GetPlayer().GetCurrentPackage())
;EndEvent

;Event OnPackageEnd(Package akOldPackage)
;	Debug.Trace("OnPackageEnd : " + akOldPackage)
;EndEvent