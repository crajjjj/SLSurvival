Scriptname dcc_sgo_QuestController_UpdateLoop extends Quest
{This script will do nothing but perform the update loop for recalculating the
tracked actors. It has been separated from the main QuestController API to
hopefully make integration from ther mods a bit cleaner. this also implements
the single update process to prevent thread stacking, as well as delays to
throttle how fast it can try and chug the lists.}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; StorageUtil Keys ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Global SGO.Actorlist.Gem
;; Global SGO.ActorList.Milk
;; Global SGO.ActorList.Semen

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

dcc_sgo_QuestController Property SGO Auto

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Event OnUpdate()
	If(!SGO.Enabled)
		Return
	EndIf


	;;SGO.PrintLog("UpdateLoop:Begin")

	;; maintenance.
	;;debug.messagebox("clean lost")
	self.OnUpdate_CleanLostData()
	;;debug.messagebox("clean persist")
	self.OnUpdate_CleanPersistHack()

	;; data processing.
	;;debug.messagebox("update fertility")
	SGO.ActorFertilityUpdateData(SGO.Player)
	;;debug.messagebox("update gem")
	self.OnUpdate_GemData()
	;;debug.messagebox("update milk")
	self.OnUpdate_MilkData()
	;;debug.messagebox("update semen")
	self.OnUpdate_SemenData()

	;;SGO.PrintLog("UpdateLoop:Done")

	self.RegisterForSingleUpdate(SGO.OptUpdateInterval)
EndEvent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Function OnUpdate_CleanLostData()
{pull any lost references out of the lists.}

	;; cleanup things the engine fucked us over on.
	
	;;StorageUtil.FormListRemove(None,"SGO.ActorList.Persist",None,TRUE)
	;;StorageUtil.FormListRemove(None,"SGO.ActorList.Gem",None,TRUE)
	;;StorageUtil.FormListRemove(None,"SGO.ActorList.Milk",None,TRUE)
	;;StorageUtil.FormListRemove(None,"SGO.ActorList.Semen",None,TRUE)
	;; ^^ these appeared not effective. probably not really none until
	;; after it tries to evaluate it after retrieval.

	SGO.FormListFlushLost(None,"SGO.ActorList.Persist")
	SGO.FormListFlushLost(None,"SGO.ActorList.Gem")
	SGO.FormListFlushLost(None,"SGO.ActorList.Milk")
	SGO.FormListFlushLost(None,"SGO.ActorList.Semen")

	Return
EndFunction

Function OnUpdate_GemData()
{run through the list to process gem data for actors on the list.}

	Form[] ActorList = StorageUtil.FormListToArray(None,"SGO.ActorList.Gem")
	Int Iter = 0
	Actor Who

	While(Iter < ActorList.Length)
		Who = ActorList[Iter] as Actor

		If(Who != None && Who.Is3dLoaded())
			;;SGO.PrintLog("UpdateLoop:GemData " + Who.GetDisplayName())
			SGO.ActorGemUpdateData(Who)
		EndIf

		Utility.Wait(SGO.OptUpdateDelay)
		Iter += 1
	EndWhile

	Return
EndFunction

Function OnUpdate_MilkData()
{run through the list to process the milk data for actors on the list.}

	Form[] ActorList = StorageUtil.FormListToArray(None,"SGO.ActorList.Milk")
	Int Iter = 0
	Actor Who

	While(Iter < ActorList.Length)
		Who = ActorList[Iter] as Actor

		If(Who != None && Who.Is3dLoaded())
			;;SGO.PrintLog("UpdateLoop:MilkData " + Who.GetDisplayName())
			SGO.ActorMilkUpdateData(Who)
		EndIf

		Iter += 1
		Utility.Wait(SGO.OptUpdateDelay)
	EndWhile

	Return
EndFunction

Function OnUpdate_SemenData()
{run through the list to process the semen data for actors on the list.}

	Form[] ActorList = StorageUtil.FormListToArray(None,"SGO.ActorList.Semen")
	Int Iter = 0
	Actor Who

	While(Iter < ActorList.Length)
		Who = ActorList[Iter] as Actor

		If(Who != None && Who.Is3dLoaded())
			;;SGO.PrintLog("UpdateLoop:SemenData " + Who.GetDisplayName())
			SGO.ActorSemenUpdateData(Who)
			Utility.Wait(SGO.OptUpdateDelay)
		EndIf

		Iter += 1
		Utility.Wait(SGO.OptUpdateDelay)
	EndWhile

	Return
EndFunction

Function OnUpdate_CleanPersistHack()
{run through the list of persistance hacks to remove any that need to be
removed.}

	Form[] ActorList = StorageUtil.FormListToArray(None,"SGO.ActorList.Persist")
	Int Iter = 0
	Actor Who

	Int Gem
	Int Milk
	Int Semen

	While(Iter < ActorList.Length)
		Who = ActorList[Iter] as Actor

		If(Who != None)
			;; check if this actor exists in the other lists. if not, remove it.
			Gem = StorageUtil.FormListFind(None,"SGO.ActorList.Gem",Who)
			Milk = StorageUtil.FormListFind(None,"SGO.ActorList.Milk",Who)
			Semen = StorageUtil.FormListFind(None,"SGO.ActorList.Semen",Who)

			If(Gem == -1 && Milk == -1 && Semen == -1)
				;;SGO.PrintLog("UpdateLoop:CleanPersistHack " + Who.GetDisplayName())
				SGO.PersistHackClear(Who)
			EndIf
		EndIf

		Iter += 1
		Utility.Wait(SGO.OptUpdateDelay)
	EndWhile

	Return
EndFunction