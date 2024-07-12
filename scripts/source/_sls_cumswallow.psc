Scriptname _SLS_CumSwallow extends ReferenceAlias  

Event OnInit()
	RegForEvents()
	;SetOpenMouthKey()
EndEvent

Event OnPlayerLoadGame()
	RegForEvents()
EndEvent

Function RegForEvents()
	If Game.GetModByName("SLSO.esp") != 255
		RegisterForModEvent("SexLabOrgasmSeparate", "OnSexLabOrgasmSeparate")
	Else
		RegisterForModEvent("HookOrgasmStart", "OnOrgasmStart")
	EndIf
	RegisterForModEvent("HookAnimationStart", "OnAnimationStart")
	RegisterForModEvent("HookAnimationEnd", "OnAnimationEnd")
	;RegisterForKey(35)
EndFunction

Event OnAnimationStart(int tid, bool HasPlayer)
	CheckMouth(HasPlayer)
EndEvent

Event OnAnimationEnd(int tid, bool HasPlayer)
	CheckMouth(HasPlayer)
EndEvent

Function CheckMouth(Bool HasPlayer)
	If HasPlayer
		If StorageUtil.GetIntValue(PlayerRef, "Sexlab.ManualMouthOpen") != 2 ; Ahegao face
			If Devious.IsPlayerGagged()
				StorageUtil.SetIntValue(PlayerRef, "Sexlab.ManualMouthOpen", 0)
			Else
				If sslBaseExpression.IsMouthOpen(PlayerRef)
					StorageUtil.SetIntValue(PlayerRef, "Sexlab.ManualMouthOpen", 1)
				Else
					StorageUtil.SetIntValue(PlayerRef, "Sexlab.ManualMouthOpen", 0)
				EndIf
			EndIf
		EndIf
	EndIf
EndFunction

Event OnOrgasmStart(int tid, bool HasPlayer) ;(string eventName, string argString, float argNum, form sender)
	OrgasmEvent(ActorRef = None, tid = tid, HasPlayer = HasPlayer)
EndEvent

Event OnSexLabOrgasmSeparate(Form ActorRef, Int tid)
	;Bool HasPlayer = Sexlab.FindPlayerController() == tid
	OrgasmEvent(ActorRef = ActorRef as Actor, tid = tid, HasPlayer = Sexlab.FindPlayerController() == tid)
EndEvent

Event OnKeyDown(Int KeyCode)
	;Actor ActorRef = Game.GetCurrentCrosshairRef() as Actor
	;Debug.Messagebox("load size actual: " + Util.GetLoadSizeActual(ActorRef, Util.GetLoadSize(ActorRef)) + "\nLastTime: " + StorageUtil.GetFloatValue(ActorRef, "_SLS_LastOrgasmTime", Missing = -7.0) + "\nLoadTier: " + StorageUtil.GetIntValue(ActorRef.GetRace(), "_SLS_LoadSize"))
	OpenMouth()
EndEvent

Function OpenMouth(Bool Override = false)
	If Override || (!Utility.IsInMenuMode() && !Devious.IsPlayerGagged())
		If sslBaseExpression.IsMouthOpen(PlayerRef)
			StorageUtil.SetIntValue(PlayerRef, "Sexlab.ManualMouthOpen", 0)
			If PlayerRef.WornHasKeyword(AllInOneKey._SLS_TongueKeyword)
				AllInOneKey.ToggleTongue(0)
			EndIf
			sslBaseExpression.CloseMouth(PlayerRef)
		Else
			StorageUtil.SetIntValue(PlayerRef, "Sexlab.ManualMouthOpen", 1)
			sslBaseExpression.OpenMouth(PlayerRef)
		EndIf
	EndIf
EndFunction

Function SetOpenMouthKey(Int KeyCode)
	UnregisterForAllKeys()
	OpenMouthKey = KeyCode
	If KeyCode > 0
		RegisterForKey(OpenMouthKey)
	EndIf
EndFunction

Function OrgasmEvent(Actor ActorRef = None, Int tid, Bool HasPlayer)
	If StorageUtil.FormListCount(None, "_SLS_BlockCumDrinkingSex") > 0
		Return
	EndIf

	If ActorRef == PlayerRef || (ActorRef == None && HasPlayer) ; Player had SLSO orgasm or is Non SLSO orgasm stage. Needs moving ??????????????????????????????????????????????????????????????????????????????
		If Init.MmeInstalled && Init.FrostfallInstalled
			If PlayerRef.HasMagicEffect(Init.MME_LeakingMilk)
				Utility.Wait(2.0)
				_SLS_MilkLeakWet.Cast(PlayerRef, PlayerRef)
			EndIf
		EndIf
	EndIf
	
	;Bool MouthIsManualOpen = sslBaseExpression.IsMouthOpen(PlayerRef)
	
	Bool MouthIsManualOpen = StorageUtil.GetIntValue(PlayerRef, "Sexlab.ManualMouthOpen", Missing = 0) == 1
	
	Int i = 0
	Int Gender
	Actor[] actorList
	If HasPlayer && ActorRef != PlayerRef
		Debug.Trace("SLS_: Actor had orgasm and player is in the same scene")
		;sslThreadController Thread = SexLab.GetController(tid)
		sslBaseAnimation Anim = sexlab.HookAnimation(tid)

		If Anim != None
			actorList = SexLab.HookActors(tid as string)
			
			Int PlayerPos
			Actor Male
			Int MaleCount = 0
			If ActorRef == None ; SLSO not installed gather everything at once
				Actor NextActor
				While i < actorList.Length
					NextActor = actorList[i]
					if NextActor != PlayerRef
						Male = actorList[i]
						If Male.HasKeyword(ActorTypeCreature)
							MaleCount += 1
							;StorageUtil.SetFloatValue(Male, "_SLS_LastOrgasmTime", Utility.GetCurrentGameTime())
						Else
							Gender = Sexlab.GetGender(NextActor) ; Match creature gender disabled but some creatures (horses at least) appear to still return female. So check for creatures above and assume all creatures male.
							If Gender == 0 || Gender == 2
								MaleCount += 1
								;StorageUtil.SetFloatValue(Male, "_SLS_LastOrgasmTime", Utility.GetCurrentGameTime())
							EndIf
						EndIf
					Else
						PlayerPos = i
					EndIf
					i += 1
				EndWhile

			Else ; SLSO installed - process one orgasm at a time.
				If ActorRef.HasKeyword(ActorTypeCreature)
					Male = ActorRef
					MaleCount += 1
					;StorageUtil.SetFloatValue(ActorRef, "_SLS_LastOrgasmTime", Utility.GetCurrentGameTime())
				Else
					Gender = Sexlab.GetGender(ActorRef)
					If Gender == 0 || Gender == 2
						Male = ActorRef
						MaleCount += 1
						;StorageUtil.SetFloatValue(Male, "_SLS_LastOrgasmTime", Utility.GetCurrentGameTime())
					EndIf
				EndIf
			EndIf
			
			Debug.Trace("SLS_: Male count = " + MaleCount)
			If MaleCount > 0
				Float LoadSize = Util.GetLoadSize(Male)
				Bool Swallowed = false
				If ;/MouthIsManualOpen || /;(Anim.HasTag("Oral") || Anim.HasTag("Blowjob")) && (Anim.HasTag("69") || (!Anim.HasTag("Cunnilingus") && !Anim.HasTag("Licking")))
					
					;debug.messagebox("Stage: " + SexLab.GetController(tid).Stage + ". Mouth: " + Anim.UseOpenMouth(0, SexLab.GetController(tid).Stage))
					;Debug.MessageBox("OpenMouths: " + Anim.OpenMouths)
					If MouthIsManualOpen || Anim.UseOpenMouth(PlayerPos, SexLab.GetController(tid).Stage)
						If Sexlab.IsVictim(tid, PlayerRef)
							If DoSwallowCumBonusEnjoyment(Anim, tid, LoadSize)
								Debug.Notification("My traitorous pussy creams as I'm forced to swallow his load")
							Else
								Debug.Notification("I'm forced to swallow down his load")
							EndIf
							Util.DoCumSwallow(CumSource = Male, CumAmount = LoadSize, DidSwallow = true)
							Swallowed = true
							
						Else
							int ibutton
							Int MsgType
							Float CumFullness = Util.GetLoadFullnessMod(Male)
							If Needs.IsDesperate()
								ibutton = 1
								Debug.Notification("I can't help myself such is my desperation")
							
							ElseIf CumAddict.GetHungerState() < 3.0 && PlayerRef.GetItemCount(_SLS_CumEmpty) > 0 && CumFullness > 0.8
								MsgType = 1
								ibutton = _SLS_SwallowCollect.Show()
								
							ElseIf Util.GetSkoomaJunkieLevel(PlayerRef, IsWithdrawing = true) || Util.IsHighOnSkooma(PlayerRef)
								ibutton = 1
								Debug.Notification("Unable to think clearly I drink all of his cum down")
							
							ElseIf IsCumAddictReflexSwallow()
								ibutton = 1
								Debug.Notification("I instinctively swallow his cum without thinking")
							Else
								If PlayerRef.GetItemCount(_SLS_CumEmpty) > 0 && CumFullness > 0.8
									ibutton = _SLS_SpitSwallowCollect.Show()
								Else
									ibutton = _SLS_SpitSwallow.Show()
								EndIf
							EndIf
							
							If MsgType == 1
								ibutton += 1
							EndIf
							
							If ibutton == 0 ; Spit
								Util.DoCumSwallow(CumSource = Male, CumAmount = LoadSize, DidSwallow = false)
								Debug.Notification("I manage to spit most of it out but some still goes down my throat")
							ElseIf ibutton == 1 ; Swallow
								Swallowed = true
								;Debug.MessageBox("Enjoy: " + Slso.GetEnjoyment(tid, PlayerRef))
								If DoSwallowCumBonusEnjoyment(Anim, tid, LoadSize)
									Debug.Notification("My pussy creams as I gulp down his cum greedily")
								Else
									Debug.Notification("I gulp down his cum greedily")
								EndIf
								Util.DoCumSwallow(CumSource = Male, CumAmount = LoadSize, DidSwallow = true)
								
							Else ; Collect
								Debug.Notification("I manage to collect most of it but some still ends up on my face and down my throat")
								PlayerRef.AddItem(CumAddict.GetCumPotionFromActor(Male))
								PlayerRef.RemoveItem(CumAddict._SLS_CumEmpty, 1)
								Util.DoCumSwallow(CumSource = Male, CumAmount = LoadSize, DidSwallow = false)
							EndIf
						EndIf
					EndIf
					If Init.FrostfallInstalled
						If Swallowed
							debug.trace("SLS_: swallowed")
							FrostInterface.ModWetness((LoadSize * 50.0 * MaleCount)/2.0)
							FrostInterface.ModExposure(-(LoadSize * 16.0 * MaleCount))
						Else
							debug.trace("SLS_: Didn't swallow")
							FrostInterface.ModWetness(Math.Ceiling(LoadSize* 50.0 * 4.0* MaleCount*Menu.CumWetMult))
							FrostInterface.ModExposure(-(Math.Ceiling(LoadSize * 32.0 * MaleCount * Menu.CumExposureMult)))
						EndIf
					EndIf
					If Swallowed
						If TollUtil.IsTollSwallowDeal
							Int RanInt = Utility.RandomInt(40,60)
							Debug.Notification("Good girl (Toll reduced by " + RanInt + " septims)")
							_SLS_TollCost.SetValueInt(_SLS_TollCost.GetValueInt() - RanInt)
							TollUtil.IsTollSwallowDeal = false
						EndIf
					EndIf
					If LoadSize >= 4.0 ; Add additional cum layer for bigger balls
						Sexlab.AddCum(PlayerRef, Vaginal = false, Oral = true, Anal = false)
						Debug.trace("SLS_: Added more cum to face")
					EndIf
				Else
					debug.trace("_SLS_: He blew a load in/on you")
					FrostInterface.ModWetness(Math.Ceiling(LoadSize * 50.0 * MaleCount * Menu.CumWetMult))
					FrostInterface.ModExposure(-(Math.Ceiling(LoadSize * 20.0 * MaleCount * Menu.CumExposureMult)))
					
					; Add additional cum layer for bigger balls
					If ;/LoadSize >= 1.0 &&/; (Anim.HasTag("Vaginal") || Anim.HasTag("Anal"))
						If !Swallowed
							DoCumInsideBonusEnjoyment(Anim, tid, LoadSize)
						EndIf
						If LoadSize >= 1.0
							DoCumFillSound(LoadSize)
						EndIf
						If LoadSize >= 4.0
							If Anim.HasTag("Vaginal")
								Sexlab.AddCum(PlayerRef, Vaginal = true, Oral = false, Anal = false)
								Debug.trace("SLS_: Added more cum to pussy")
								
							ElseIf Anim.HasTag("Anal")
								Sexlab.AddCum(PlayerRef, Vaginal = false, Oral = false, Anal = true)
								Debug.trace("SLS_: Added more cum to ass")
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		Else
			Debug.Trace("SLS_: Anim = None...?")
		EndIf
		
	;Else ; Scene hasn't got player. Set male orgasm times
		
	EndIf
	
	; Set last orgasm time for cum fullness
	If ActorRef == None ; SLSO not installed
		Actor NextActor
		While i < actorList.Length
			NextActor = actorList[i]
			If NextActor.HasKeyword(ActorTypeCreature)
				StorageUtil.SetFloatValue(NextActor, "_SLS_LastOrgasmTime", Utility.GetCurrentGameTime())
			Else
				Gender = Sexlab.GetGender(NextActor) ; Match creature gender disabled but some creatures (horses at least) appear to still return female. So check for creatures above and assume all creatures male.
				If Gender == 0 || Gender == 2
					StorageUtil.SetFloatValue(NextActor, "_SLS_LastOrgasmTime", Utility.GetCurrentGameTime())
				EndIf
			EndIf
			i += 1
		EndWhile

	Else ; SLSO installed - process one orgasm at a time.
		If ActorRef.HasKeyword(ActorTypeCreature)
			StorageUtil.SetFloatValue(ActorRef, "_SLS_LastOrgasmTime", Utility.GetCurrentGameTime())
		Else
			Gender = Sexlab.GetGender(ActorRef)
			If Gender == 0 || Gender == 2
				StorageUtil.SetFloatValue(ActorRef, "_SLS_LastOrgasmTime", Utility.GetCurrentGameTime())
			EndIf
		EndIf
	EndIf
	;Debug.Messagebox("After orgasm load size: " + Util.GetLoadSizeActual(ActorRef, Util.GetLoadSize(ActorRef)) + "\nLastTime: " + StorageUtil.GetFloatValue(ActorRef, "_SLS_LastOrgasmTime", Missing = -7.0))
EndFunction

Function DoCumFillSound(Float LoadSize)
	;/
	Float FillAmount = 1.0
	While LoadSize > 0.0
		_SLS_CumFillSM.Play(PlayerRef)
		LoadSize -= FillAmount
		FillAmount = FillAmount * 3.0 ; Increase the amount filled each iteration so it doesn't go on too long. This should give Big: 2 swallows, massive: 3 etc
		If LoadSize > 0.0
			Utility.Wait(2.0 + Utility.RandomFloat(-0.2, 0.2))
		EndIf
	EndWhile
	/;
	
	_SLS_CumFillSoundSpell.SetNthEffectMagnitude(0, LoadSize)
	PlayerRef.AddSpell(_SLS_CumFillSoundSpell, abVerbose = false)
EndFunction

Bool Function IsCumAddictReflexSwallow()
	If _SLS_CumAddictQuest.IsRunning()
		Return CumAddict.IsReflexCumSwallow()
	EndIf
	Return false
EndFunction

Function DoCumInsideBonusEnjoyment(sslBaseAnimation Anim, Int tid, Float LoadSize)
	If CumInsideBonusEnjMult > 0.0
		Float BonusEnj = (LoadSize) * ((1.0 + CumAddict.GetAddictionState() as Float)) * CumInsideBonusEnjMult
		Slso.ModEnjoyment(tid, PlayerRef, BonusEnj as Int)
		;Debug.Messagebox("Cum inside bonus enjoyment: " + BonusEnj + "\nTotal: " + Slso.GetEnjoyment(tid, PlayerRef))
	EndIf
EndFunction

Bool Function DoSwallowCumBonusEnjoyment(sslBaseAnimation Anim, Int tid, Float LoadSize)
	Float EnjBefore = Slso.GetEnjoyment(tid, PlayerRef)
	DoCumInsideBonusEnjoyment(Anim, tid, LoadSize)
	While Sexlab.IsActorActive(PlayerRef) && Slso.GetEnjoyment(tid, PlayerRef) == EnjBefore ; Wait for bonus enjoyment to apply
		Utility.Wait(0.2)
	EndWhile
	;Debug.Messagebox("Before Enj: " + EnjBefore + "\nAfter Enj: " + Slso.GetEnjoyment(tid, PlayerRef))
	If Slso.GetEnjoyment(tid, PlayerRef) >= 100
		If ((CumAddict.GetAddictionState() / 4) * 50.0) + ((CumAddict.CalcSatiationChange(LoadSize) / 4.0) * 50.0) > Utility.RandomFloat(0.0, 100.0)
			Slso.Orgasm(tid, PlayerRef, Force = true)
			Return true
		EndIf
	EndIf
	Return false
EndFunction

Int Property OpenMouthKey Auto Hidden

Float Property CumInsideBonusEnjMult = 1.0 Auto Hidden

Quest Property _SLS_CumAddictQuest Auto

Actor Property PlayerRef Auto

Spell Property _SLS_MilkLeakWet Auto
Spell Property _SLS_CumFillSoundSpell Auto

Potion Property _SLS_CumEmpty Auto

GlobalVariable Property _SLS_TollCost Auto

Message Property _SLS_SpitSwallow Auto
Message Property _SLS_SpitSwallowCollect Auto
Message Property _SLS_SwallowCollect Auto

Keyword Property ActorTypeCreature Auto

Sound Property _SLS_CumFillSM Auto

SexLabFramework Property Sexlab Auto
SLS_Utility Property Util Auto
SLS_Init Property Init Auto
_SLS_InterfaceFrostfall Property FrostInterface Auto
_SLS_InterfaceDevious Property Devious Auto
_SLS_InterfaceSlso Property Slso Auto
SLS_Mcm Property Menu Auto
_SLS_Needs Property Needs Auto
_SLS_CumAddict Property CumAddict Auto
_SLS_AllInOneKey Property AllInOneKey Auto
_SLS_TollUtil Property TollUtil Auto
