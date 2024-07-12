ScriptName Apropos2ActorAlias Extends ReferenceAlias

Import Apropos2Util
Import ApUtil
;Import SlaveTats

Actor Property ActorRef Auto
Actor Property PlayerRef  Auto
Apropos2SystemConfig Property Config Auto
Apropos2Framework Property Framework Auto
Apropos2DescriptionDb Property Database Auto
Apropos2Descriptions Property Descriptions Auto
SexLabFramework Property SexLab Auto
slaUtilScr Property SlaUtil Auto

Int _lastVaginalSexPass = 0
Int _lastAnalSexPass = 0
Int _lastOralSexPass = 0

; raw w&t values.
Int _vaginalWearTear = 0
Int _analWearTear = 0
Int _oralWearTear = 0

; 0 - 9 state variables - indices into W&T effect labels.
Int _vaginalState = 0
Int _analState = 0
Int _oralState = 0

; raw w&t general abuse values
Int _abuseVaginalWearTear = 0
Int _abuseAnalWearTear = 0
Int _abuseOralWearTear = 0

; 0 - 9 state variables - indices into W&T Textures
Int _abuseVaginalState = 0
Int _abuseAnalState = 0
Int _abuseOralState = 0

; raw w&t Creature abuse values
Int _creatureAbuseVaginalWearTear = 0
Int _creatureAbuseAnalWearTear = 0
Int _creatureAbuseOralWearTear = 0

; 0 - 9 state variables - indices into W&T Textures
Int _creatureAbuseVaginalState = 0
Int _creatureAbuseAnalState = 0
Int _creatureAbuseOralState = 0

; raw w&t Daedric abuse values
Int _daedricAbuseVaginalWearTear = 0
Int _daedricAbuseAnalWearTear = 0
Int _daedricAbuseOralWearTear = 0

; 0 - 9 state variables - indices into W&T Textures
Int _daedricAbuseVaginalState = 0
Int _daedricAbuseAnalState = 0
Int _daedricAbuseOralState = 0

String _deferredWTChange = ""
String _deferredWTChangeEffectiveVoice = ""
String _deferredWTChangeBodyPart = ""

Int _lastAfterEffectsBodyTxrMapId
Int _lastAfterEffectsFaceTxrMapId
Int _lastCutsScratchesTxrMapId
Int _lastDaedricScarsTxrMapId
Int _lastTearsSobsTxrMapId
Int _lastMascaraSmearTxrMapId1
Int _lastMascaraSmearTxrMapId2

Int _currentHour = 0
Float _lastGameTime = 0.0

Int _aproposId = -1

Int _lastActiveActorArousal = 0 

Int Property Id 
    Int Function get()
        Return _aproposId
    EndFunction
    Function set(Int new_value)
        _aproposId = new_value
    EndFunction
EndProperty

String Property VaginalWearTear
    String Function get()
        Return Database.GetRandomWearAndTearDescriptor(_vaginalState)
    EndFunction
EndProperty

String Property AnalWearTear
    String Function get()
        Return Database.GetRandomWearAndTearDescriptor(_analState)
    EndFunction
EndProperty

String Property OralWearTear
    String Function get()
        Return Database.GetRandomWearAndTearDescriptor(_oralState)
    EndFunction
EndProperty

Int Property AverageAbuseState
    Int Function get()
        Return Average3(_abuseVaginalState, _abuseAnalState, _abuseOralState)
    EndFunction
EndProperty

Int Property AverageCreatureAbuseState
    Int Function get()
        Return Average2(_creatureAbuseVaginalState, _creatureAbuseAnalState)
    EndFunction
EndProperty

Int Property AverageDaedricAbuseState
    Int Function get()
        Return Average2(_daedricAbuseVaginalState, _daedricAbuseAnalState)
    EndFunction
EndProperty

Int Property VaginalWearTearState
    Int Function get()
        Return _vaginalState
    EndFunction
EndProperty

Function OverrideVaginalWearTearState(Int newValue, Bool updateAbuse, Bool updateCreatureAbuse, Bool updateDaedricAbuse)
    If Config.DebugMessagesEnabled
        Log("Overriding VaginalWearTearState to " + newValue)
    EndIf
    _vaginalState = newValue
    ; make sure we update the wear tear amount inferred from state.
    Int wearTearAmount = MapWearTearStateToAmount(newValue)
    _vaginalWearTear = wearTearAmount

    If updateAbuse 
        _abuseVaginalState = newValue
        _abuseVaginalWearTear = wearTearAmount
    EndIf

    If updateCreatureAbuse
        _creatureAbuseVaginalState = newValue
        _creatureAbuseVaginalWearTear = wearTearAmount
    EndIf

    If updateDaedricAbuse
        _daedricAbuseVaginalState = newValue
        _daedricAbuseVaginalWearTear = wearTearAmount
    EndIf

EndFunction

Int Property AnalWearTearState
    Int Function get()
        Return _analState
    EndFunction
EndProperty

Function OverrideAnalWearTearState(Int newValue, Bool updateAbuse, Bool updateCreatureAbuse, Bool updateDaedricAbuse) 
    If Config.DebugMessagesEnabled 
        Log("Overriding AnalWearTearState to " + newValue)
    EndIf
    _analState = newValue
    ; make sure we update the wear tear amount inferred from state.
    Int inferredAmount = MapWearTearStateToAmount(newValue)      
    _analWearTear = inferredAmount

    If updateAbuse 
        _abuseAnalState = newValue
        _abuseAnalWearTear = inferredAmount
    EndIf

    If updateCreatureAbuse
        _creatureAbuseAnalState = newValue
        _creatureAbuseAnalWearTear = inferredAmount
    EndIf

    If updateDaedricAbuse
        _daedricAbuseAnalState = newValue
        _daedricAbuseAnalWearTear = inferredAmount
    EndIf
         
EndFunction

Int Property OralWearTearState
    Int Function get()
        Return _oralState
    EndFunction
EndProperty

Function OverrideOralWearTearState(Int newValue, Bool updateAbuse, Bool updateCreatureAbuse, Bool updateDaedricAbuse) 
    If Config.DebugMessagesEnabled
        Log("Overriding OralWearTearState to " + newValue)
    EndIf
    _oralState = newValue
    ; make sure we update the wear tear amount inferred from state.
    Int inferredAmount = MapWearTearStateToAmount(newValue)   
    _oralWearTear = inferredAmount     

    If updateAbuse 
        _abuseOralState = newValue
        _abuseOralWearTear = inferredAmount
    EndIf

    If updateCreatureAbuse
        ; Leaving these two commented out for now - oral creature and daedric is
        ; in limbo right now since we don't ever actually increase these values.        
        _creatureAbuseOralState = newValue
        ;_creatureAbuseOralWearTear = inferredAmount
    EndIf

    If updateDaedricAbuse
        ; Leaving these two commented out for now - oral creature and daedric is
        ; in limbo right now since we don't ever actually increase these values.
        _daedricAbuseOralState = newValue
        ;_daedricAbuseOralWearTear = inferredAmount
    EndIf    
EndFunction

Actor Function GetActor()
    Return ActorRef
EndFunction

Event OnInit() 
    ;GotoState("ReadyForTracking")
EndEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
    ApplyConsumable(akBaseObject)
EndEvent

Auto State ReadyForTracking
    Event OnBeginState()
        If Config.TraceMessagesEnabled
            Log("ReadyForTracking.OnBeginState")
        EndIf
        ActorRef = none
        _currentHour = 0
        _lastGameTime = 0.0        
        Clear()
    EndEvent
    
    Event OnUpdate()
        ; catch any pending updates
    EndEvent

    Function Track(Actor anActor, Int actorSlot)
        If config.TraceMessagesEnabled
            LogActor(anActor, "Track(), slot=" + actorSlot)
        EndIf
        ForceRefTo(anActor)
        ActorRef = GetActorRef()
        Id = actorSlot
        GoToState("Tracking")
    EndFunction        
EndState

State Tracking
    Event OnBeginState()
        If Config.TraceMessagesEnabled
            Log("Tracking.OnBeginState")
        EndIf
        _lastGameTime = Utility.GetCurrentGameTime()
        RegisterForSingleUpdateGameTime(Config.FrequencyWearTearDegrade)
    EndEvent

    Event OnUpdate()
        If Config.TraceMessagesEnabled
            Log("Tracking.OnUpdate()")
            Log("_deferredWTChange: " + _deferredWTChange + ", _deferredWTChangeEffectiveVoice: " + _deferredWTChangeEffectiveVoice + ", _deferredWTChangeBodyPart: " + _deferredWTChangeBodyPart)
        EndIf
        If _deferredWTChange != "" ; was there a deferred WT change message?
            DisplayWearTearChangedMessage(_deferredWTChange, _deferredWTChangeEffectiveVoice, _deferredWTChangeBodyPart, True)
        EndIf
    EndEvent

    Event OnUpdateGameTime()
        UnregisterForUpdateGameTime()

        If _lastGameTime == 0.0
            _lastGameTime  = Utility.GetCurrentGameTime()
        EndIf       

        Float currentTime = Utility.GetCurrentGameTime()
        Float hoursPassedFloat = (currentTime - _lastGameTime) * 24
        Int hoursPassed = hoursPassedFloat As Int

        If hoursPassed <= 0
            hoursPassed = 1
        EndIf

        Int timePeriodsPassed = hoursPassed / Config.FrequencyWearTearDegrade

        Log("hoursPassed=" + hoursPassed + ", periods=" + timePeriodsPassed)

        Int periodCount = 0
        Float chanceDegrade = Config.ChanceWTDegrade

        While periodCount < timePeriodsPassed
            If Utility.RandomInt() <= chanceDegrade 
                DegradeWearAndTear()
            EndIf
            periodCount += 1
            Log("... computed period: " + periodCount)
        EndWhile

        _lastGameTime = currentTime
        ApplyEffectsAndTextures(increasingAbuse=False)

        RegisterForSingleUpdateGameTime(Config.FrequencyWearTearDegrade)
    EndEvent

    Function ProcessStageStart(Actor[] all_actors)
        If all_actors.Length <= 1
            Return
        EndIf

        Int i = 0
        Int tot = 0
        While i < all_actors.Length 
            Actor test = all_actors[i]
            If test != GetActor()
                tot += SlaUtil.GetActorArousal(all_actors[i])
            EndIf
            i += 1
        EndWhile
        ;Console("tot: " + tot)
        _lastActiveActorArousal = tot / (all_actors.Length - 1)
        ;Console("LastArousal: " + _lastActiveActorArousal)
    EndFunction

    Function ProcessOrgasm(SslThreadController thread, Actor activeActor, Bool hasVictimOrAggressive, String damageClass, String[] bodyPartsAffected)
        SslBaseAnimation animation = thread.Animation
        String primaryName = GetActor().GetDisplayName()
        String activeName = activeActor.GetDisplayName()
        If Config.TraceMessagesEnabled 
            Log("ProcessOrgasm:" + primaryName + "," + activeName + "," + StringIfElse(hasVictimOrAggressive, "VictimOrAggro") + "," + damageClass + "," + bodyPartsAffected)
        EndIf

        String effectiveVoice = Config.GetEffectiveNarrativeVoice(GetActor() == PlayerRef)

        String partner
        If thread.HasCreature
            partner = GetCreatureFromAnimation(animation, activeActor)
        Else
            partner = "Male"
        EndIf

        Utility.Wait(1)
        ;Descriptions.DisplayArbitraryTokenizedString(tokenizedString, true, activeActor, GetActor())         
        Descriptions.DisplayFemaleActorHugeOrLargeLoadDescriptions(thread, partner, hasVictimOrAggressive, activeActor, GetActor(), effectiveVoice, bodyPartsAffected[0], _lastActiveActorArousal)

    EndFunction

    Function DoDisplayWearTearChangedMessage(Actor anActor, String change, String effectiveVoice, String bodyPart)
        If Config.DebugMessagesEnabled
            LogActor(anActor, "DisplayWearTearChangedMessage: actor is not in combat or searching or animating.")
            Log("... Displaying WT changed message...")
        EndIf

        sslBaseVoice voice = SexLab.PickVoice(anActor)
        Int level = Min(AverageAbuseState * 10, 30)
        If change == "Increased"
            Config.WTStaggerSpell.cast(anActor)
            voice.Moan(anActor, level, True)
        Else
            Int arousal = Framework.GetActorArousal(anActor)
            If Config.AutoMasturbateEnabled && (arousal >= Config.MinArousalAutoMasturbate) && Framework.IsValidForAutoMasturbate(anActor)

                String msg = ""
                If effectiveVoice == "1st Person"
                    msg = "There's an itch ... and I'm so horny..."
                ElseIf effectiveVoice == "2nd Person"
                    msg = "There's an itch ... and you're so horny..."
                Else
                    msg = "There's an itch ... and she's so horny..."
                EndIf

                If (PlayerRef == anActor)
                    Game.DisablePlayerControls()
                EndIf
                Framework.Masturbate(anActor)
                Descriptions.PresentMessage(msg, None)
                If (PlayerRef == anActor)
                    Game.EnablePlayerControls()
                EndIf
            Else
                voice.Moan(anActor, level, False)                    
            EndIf
        EndIf
        Descriptions.DisplayFemaleActorWearTearChangedMessage(change, anActor, effectiveVoice, bodyPart)    
    EndFunction

    Function DisplayWearTearChangedMessage(String change, String effectiveVoice, String bodyPart, Bool scheduled = False)
        If Config.TraceMessagesEnabled
            Log("DisplayWearTearChangedMessage(change=" + change + ", effectiveVoice=" + effectiveVoice + ", bodyPart=" + bodyPart +")")
        EndIf
        Actor anActor = GetActor()

        If !Framework.IsValidActor(anActor)
            Return ; do nothing if not a valid (e.g. dead) actor
        EndIf
        
        If !Framework.IsActorQuiesced(anActor)
            Int randomWait

            If scheduled
                ; re-schedule
                randomWait = Utility.RandomInt(1, 5) * 60; wait 1 - 5 minutes                
                If Config.DebugMessagesEnabled
                    LogActor(anActor, "DisplayWearTearChangedMessage: actor is in combat or searching or animating. Waiting " + randomWait + "sec.")
                EndIf
                RegisterForSingleUpdate(randomWait)
            ElseIf _deferredWTChange == "" && _deferredWTChangeEffectiveVoice == "" && _deferredWTChangeBodyPart == ""
                ; Only schedule a random update to display the message if we aren't already scheduled!
                _deferredWTChange = change
                _deferredWTChangeEffectiveVoice = effectiveVoice
                _deferredWTChangeBodyPart = bodyPart

                randomWait = Utility.RandomInt(1, 5) * 60; wait 1 - 5 minutes 
                If Config.DebugMessagesEnabled
                    LogActor(anActor, "DisplayWearTearChangedMessage: actor is in combat or searching or animating. Waiting " + randomWait + "sec.")
                EndIf
                RegisterForSingleUpdate(randomWait)
            EndIf

        Else
            DoDisplayWearTearChangedMessage(anActor, change, effectiveVoice, bodyPart)
            
            _deferredWTChange = ""
            _deferredWTChangeEffectiveVoice = ""
            _deferredWTChangeBodyPart = ""               
        EndIf
    EndFunction

    Function UpdateWearTearEffects()

        If !Config.WTEffectsEnabled
            Return
        EndIf

        If Config.TraceMessagesEnabled
            DebugActor(GetActor(), "UpdateWearTearEffects for actor")
        EndIf   

        Actor anActor = GetActor()

        Int oralMagickaRegenDebuff
        Int oralSpeechDebuff

        Int vaginalSHRegenDebuff
        Int vaginalMovementDebuff

        Int analSHRegenDebuff
        Int analMovementDebuff

        Bool castOralDebuff = False
        Bool castVaginalDebuff = False
        Bool castAnalDebuff = False

        String level

        DispellAllSpells(anActor)

        If _oralState >= 4

            castOralDebuff = True

            String oral = "oral"

            If config.HardcoreWTEffectsEnabled
                oral += "-hc"
            EndIf             
               
            String keyBase = QueryKey("wearteareffects", oral, "level" + _oralState)

            String oralMagickaRegenDebuffKey = keyBase + ".magickaregen"
            If Config.TraceMessagesEnabled
                Log("oralMagickaRegenDebuffKey = " + oralMagickaRegenDebuffKey)
            EndIf
            oralMagickaRegenDebuff = JDB.solveInt(oralMagickaRegenDebuffKey)

            String oralSpeechDebuffKey = keyBase + ".speech"
            If Config.TraceMessagesEnabled
                Log("oralSpeechDebuffKey = " + oralSpeechDebuffKey)
            EndIf            
            oralSpeechDebuff = JDB.solveInt(oralSpeechDebuffKey)                
        EndIf

        If _vaginalState >= 4

            castVaginalDebuff = True

            String vaginal = "vaginal"

            If config.HardcoreWTEffectsEnabled
                vaginal += "-hc"
            EndIf             
               
            String keyBase = QueryKey("wearteareffects", vaginal, "level" + _vaginalState)

            String vaginalSHRegenDebuffKey = keyBase + ".shregen"
            If Config.TraceMessagesEnabled
                Log("vaginalSHRegenDebuffKey = " + vaginalSHRegenDebuffKey)
            EndIf
            vaginalSHRegenDebuff = JDB.solveInt(vaginalSHRegenDebuffKey)

            String vaginalMovementDebuffKey = keyBase + ".movement"
            If Config.TraceMessagesEnabled
                Log("vaginalMovementDebuffKey = " + vaginalMovementDebuffKey)
            EndIf            
            vaginalMovementDebuff = JDB.solveInt(vaginalMovementDebuffKey)                
        EndIf    

        If _analState >= 4

            castAnalDebuff = True

            String anal = "anal"

            If config.HardcoreWTEffectsEnabled
                anal += "-hc"
            EndIf             
               
            String keyBase = QueryKey("wearteareffects", anal, "level" + _analState)

            String analSHRegenDebuffKey = keyBase + ".shregen"
            If Config.TraceMessagesEnabled
                Log("analSHRegenDebuffKey = " + analSHRegenDebuffKey)
            EndIf
            analSHRegenDebuff = JDB.solveInt(analSHRegenDebuffKey)

            String analMovementDebuffKey = keyBase + ".movement"
            If Config.TraceMessagesEnabled
                Log("analMovementDebuffKey = " + analMovementDebuffKey)
            EndIf            
            analMovementDebuff = JDB.solveInt(analMovementDebuffKey)                
        EndIf

        If castOralDebuff
            If oralMagickaRegenDebuff > 0
                Config.OralMagickaDebuffSpell.SetNthEffectMagnitude(0, oralMagickaRegenDebuff)
                anActor.AddSpell(Config.OralMagickaDebuffSpell, False)
                Debug("Added oral WT Magicka Debuff spell to actor with magnitude=" + oralMagickaRegenDebuff)
            EndIf

            If oralSpeechDebuff > 0
                Config.OralSpeechDebuffSpell.SetNthEffectMagnitude(0, oralSpeechDebuff)
                anActor.AddSpell(Config.OralSpeechDebuffSpell, False)
                Debug("Added oral WT Speech Debuff spell to actor with magnitude=" + oralSpeechDebuff)
            EndIf
        EndIf

        If castVaginalDebuff
            If vaginalSHRegenDebuff > 0
                Config.VaginalHealthDebuffSpell.SetNthEffectMagnitude(0, vaginalSHRegenDebuff)
                Config.VaginalStaminaDebuffSpell.SetNthEffectMagnitude(0, vaginalSHRegenDebuff)
                anActor.AddSpell(Config.VaginalHealthDebuffSpell, False)
                anActor.AddSpell(Config.VaginalStaminaDebuffSpell, False)
                Debug("Added vaginal WT S&H Debuff spell to actor with magnitude=" + vaginalSHRegenDebuff)
            EndIf

            If vaginalMovementDebuff > 0
                Config.VaginalSpeedDebuffSpell.SetNthEffectMagnitude(0, vaginalMovementDebuff)
                anActor.AddSpell(Config.VaginalSpeedDebuffSpell, False)
                Debug("Added vaginal WT Speed Debuff spell to actor with magnitude=" + vaginalMovementDebuff)
            EndIf
        EndIf

        If castAnalDebuff
            If analSHRegenDebuff > 0
                Config.AnalHealthDebuffSpell.SetNthEffectMagnitude(0, analSHRegenDebuff)
                Config.AnalStaminaDebuffSpell.SetNthEffectMagnitude(0, analSHRegenDebuff)
                anActor.AddSpell(Config.AnalHealthDebuffSpell, False)
                anActor.AddSpell(Config.AnalStaminaDebuffSpell, False)
                Debug("Added anal WT S&H Debuff spell to actor with magnitude=" + analSHRegenDebuff)
            EndIf
            
            If analMovementDebuff > 0
                Config.AnalSpeedDebuffSpell.SetNthEffectMagnitude(0, analMovementDebuff)
                anActor.AddSpell(Config.AnalSpeedDebuffSpell, False)
                Debug("Added anal WT Speed Debuff spell to actor with magnitude=" + analMovementDebuff)
            EndIf   
        EndIf

    EndFunction      

    Function UpdateAbuseTextures(bool increasingAbuse)
        If !Config.EnableSkinTextures
            Return
        EndIf
        ; Int Function AddTattoo(Actor anActor, String name, String texture, String section, String area, Int slot, Int colorTint)

        Actor anActor = GetActor()
        ; remove previous textures
        RemoveAllAbuseTextures(anActor) ; even if its not enabled, remove, in case MCM was changed

        If Config.EnableAfterEffects || Config.EnableTearsAndSobs ; general abuse
            Int slot = -1; 1

            If Config.EnableTearsAndSobs
                Int metric = AverageAbuseState
                If metric == 9
                    _lastAfterEffectsFaceTxrMapId = AddTattoo(anActor, "battered", "After Effects\\face_battered.dds", "After Effects", "Face", slot)
                ElseIf metric == 8 && increasingAbuse
                    _lastTearsSobsTxrMapId = AddTattoo(anActor, "Sob 2", "Sob Tears\\sob_2.dds", "Tears", "Face", slot)
                ElseIf metric == 7 && increasingAbuse
                    _lastTearsSobsTxrMapId = AddTattoo(anActor, "Sob 1", "Sob Tears\\sob_1.dds", "Tears", "Face", slot)
                ElseIf metric == 6 && increasingAbuse
                    _lastTearsSobsTxrMapId = AddTattoo(anActor, "Tears 3", "Sob Tears\\tears_3.dds", "Tears", "Face", slot)
                ElseIf metric == 5 && increasingAbuse
                    _lastTearsSobsTxrMapId = AddTattoo(anActor, "Tears 2", "Sob Tears\\tears_2.dds", "Tears", "Face", slot)
                ElseIf metric == 4 && increasingAbuse
                    _lastTearsSobsTxrMapId = AddTattoo(anActor, "Tears 1", "Sob Tears\\tears_1.dds", "Tears", "Face", slot)
                EndIf
            EndIf     

            If Config.EnableMascaraSmears && increasingAbuse
                Int metric = AverageAbuseState
                If metric <= 3 && metric > 0
                    _lastMascaraSmearTxrMapId1 = AddTattoo(anActor, "Running Mascara (left)", "makeup\\left_cheek_tears.dds", "Makeup", "Face", slot, colorTint=Config.MascaraTatsColorTint)
                    _lastMascaraSmearTxrMapId2 = AddTattoo(anActor, "Running Mascara (right)", "makeup\\right_cheek_tears.dds", "Makeup", "Face", slot, colorTint=Config.MascaraTatsColorTint)
                EndIf
            EndIf      

            If Config.EnableAfterEffects
                Int metric = Max4(AverageAbuseState, _abuseAnalState, _abuseOralState, _abuseVaginalState)
                If metric == 9
                    _lastAfterEffectsBodyTxrMapId = AddTattoo(anActor, "After Effects 4", "After Effects\\after_effects_4.dds", "After Effects", "Body", slot)
                ElseIf metric >= 7
                    _lastAfterEffectsBodyTxrMapId = AddTattoo(anActor, "After Effects 3", "After Effects\\after_effects_3.dds", "After Effects", "Body", slot)
                ElseIf metric >= 6
                    _lastAfterEffectsBodyTxrMapId = AddTattoo(anActor, "After Effects 2", "After Effects\\after_effects_2.dds", "After Effects", "Body", slot)
                ElseIf metric >= 5
                    _lastAfterEffectsBodyTxrMapId = AddTattoo(anActor, "After Effects 1", "After Effects\\after_effects_1.dds", "After Effects", "Body", slot)
                EndIf
            EndIf

        EndIf

        If Config.EnableCutScratches ; creature abuse
            Int metric = Max4(AverageCreatureAbuseState, _creatureAbuseAnalState, _creatureAbuseOralState, _creatureAbuseVaginalState)
            Int slot = -1; 2
            If metric == 9
                _lastCutsScratchesTxrMapId = AddTattoo(anActor, "Cuts 3", "After Effects\\cuts_3.dds", "Cuts", "Body", slot)
            ElseIf metric >= 7
                _lastCutsScratchesTxrMapId = AddTattoo(anActor, "Cuts 2", "After Effects\\cuts_2.dds", "Cuts", "Body", slot)
            ElseIf metric >= 5
                _lastCutsScratchesTxrMapId = AddTattoo(anActor, "Cuts 1", "After Effects\\cuts_1.dds", "Cuts", "Body", slot) 
            EndIf
        EndIf

        If Config.EnableDaedricScars
            Int metric = Max4(AverageDaedricAbuseState, _daedricAbuseAnalState, _daedricAbuseOralState, _daedricAbuseVaginalState)
            Int slot = -1; 3
            If metric == 9
                _lastDaedricScarsTxrMapId = AddTattoo(anActor, "Scars 3", "Scars Dirt\\scarred_3.dds", "Scars", "Body", slot)
            ElseIf metric >= 7
                _lastDaedricScarsTxrMapId = AddTattoo(anActor, "Scars 2", "Scars Dirt\\scarred_2.dds", "Scars", "Body", slot)
            ElseIf metric >= 5
                _lastDaedricScarsTxrMapId = AddTattoo(anActor, "Scars 1", "Scars Dirt\\scarred_1.dds", "Scars", "Body", slot)
            EndIf
        EndIf

        If Slavetats.synchronize_tattoos(anActor, True)
            If Config.DebugMessagesEnabled
                Debug("Failed to synchronize_tattoos")
            EndIf
        EndIf

    EndFunction

    Function RemoveAllAbuseTextures(Actor anActor, Bool synchronize = False)
        RemoveAfterEffectsTextures(anActor)
        RemoveTearsSobsTextures(anActor)
        RemoveMascaraSmearTextures(anActor)
        RemoveCutsScratchesTextures(anActor)
        RemoveDaedricScarsTextures(anActor)
        If synchronize && Slavetats.synchronize_tattoos(anActor, True)
            Debug("Failed to synchronize_tattoos")
        EndIf
    EndFunction

    Function RemoveAfterEffectsTextures(Actor anActor)
        Debug("AproposActorAlias.RemoveAfterEffectsTexture")
        If _lastAfterEffectsBodyTxrMapId != 0
            If Slavetats.remove_tattoos(anActor, _lastAfterEffectsBodyTxrMapId)
                Debug("Failed to remove tattoo - AfterEffectsBody")
            EndIf
            JValue.release(_lastAfterEffectsBodyTxrMapId)
            _lastAfterEffectsBodyTxrMapId = 0
        EndIf
    EndFunction

    Function RemoveMascaraSmearTextures(Actor anActor)
        Debug("AproposActorAlias.RemoveMascaraSmearTextures")
        If _lastMascaraSmearTxrMapId1 != 0
            If Slavetats.remove_tattoos(anActor, _lastMascaraSmearTxrMapId1)
                Debug("Failed to remove tattoo - Mascara Tears")
            EndIf
            JValue.release(_lastMascaraSmearTxrMapId1)
            _lastMascaraSmearTxrMapId1 = 0        
        EndIf
        If _lastMascaraSmearTxrMapId2 != 0
            If Slavetats.remove_tattoos(anActor, _lastMascaraSmearTxrMapId2)
                Debug("Failed to remove tattoo - Mascara Tears")
            EndIf
            JValue.release(_lastMascaraSmearTxrMapId2)
            _lastMascaraSmearTxrMapId2 = 0        
        EndIf 
    EndFunction

    Function RemoveTearsSobsTextures(Actor anActor)
        Debug("AproposActorAlias.RemoveTearsSobsTexture")
        If _lastTearsSobsTxrMapId != 0
            If Slavetats.remove_tattoos(anActor, _lastTearsSobsTxrMapId)
                Debug("Failed to remove tattoo - TearsSobs")
            EndIf
            JValue.release(_lastTearsSobsTxrMapId)
            _lastTearsSobsTxrMapId = 0        
        EndIf
        If _lastAfterEffectsFaceTxrMapId != 0
            If Slavetats.remove_tattoos(anActor, _lastAfterEffectsFaceTxrMapId)
                Debug("Failed to remove tattoo - AfterEffectsFace")
            EndIf
            JValue.release(_lastAfterEffectsFaceTxrMapId)
            _lastAfterEffectsFaceTxrMapId = 0        
        EndIf    
    EndFunction

    Function RemoveCutsScratchesTextures(Actor anActor)
        Debug("AproposActorAlias.RemoveCutsScratchesTexture")
        If _lastCutsScratchesTxrMapId != 0
            If Slavetats.remove_tattoos(anActor, _lastCutsScratchesTxrMapId)
                Debug("Failed to remove tattoo - CutsScratches")
            EndIf
            JValue.release(_lastCutsScratchesTxrMapId)
            _lastCutsScratchesTxrMapId = 0             
        EndIf 
    EndFunction

    Function RemoveDaedricScarsTextures(Actor anActor)
        Debug("AproposActorAlias.RemoveDaedricScarsTexture")
        If _lastDaedricScarsTxrMapId != 0
            If Slavetats.remove_tattoos(anActor, _lastDaedricScarsTxrMapId)
                Debug("Failed to remove tattoo - DaedricScars")
            EndIf
            JValue.release(_lastDaedricScarsTxrMapId)
            _lastDaedricScarsTxrMapId = 0            
        EndIf    
    EndFunction         

    Function DispellAllSpells(Actor anActor)
        If Config.DebugMessagesEnabled
            Log("Removing debuff spells from " + anACtor.GetLeveledActorBase().GetName())
        EndIf

        If anActor.HasSpell(Config.OralMagickaDebuffSpell)
            anActor.RemoveSpell(Config.OralMagickaDebuffSpell)
        EndIf
        If anActor.HasSpell(Config.OralSpeechDebuffSpell)
            anActor.RemoveSpell(Config.OralSpeechDebuffSpell)
        EndIf
        If anActor.HasSpell(Config.AnalHealthDebuffSpell)
            anActor.RemoveSpell(Config.AnalHealthDebuffSpell)
        EndIf
        If anActor.HasSpell(Config.AnalStaminaDebuffSpell)
            anActor.RemoveSpell(Config.AnalStaminaDebuffSpell)
        EndIf    
        If anActor.HasSpell(Config.AnalSpeedDebuffSpell)
            anActor.RemoveSpell(Config.AnalSpeedDebuffSpell)
        EndIf
        If anActor.HasSpell(Config.VaginalHealthDebuffSpell)
            anActor.RemoveSpell(Config.VaginalHealthDebuffSpell)
        EndIf
        If anActor.HasSpell(Config.VaginalStaminaDebuffSpell)
            anActor.RemoveSpell(Config.VaginalStaminaDebuffSpell)
        EndIf    
        If anActor.HasSpell(Config.VaginalSpeedDebuffSpell)
            anActor.RemoveSpell(Config.VaginalSpeedDebuffSpell)
        EndIf                    
    EndFunction

    Function ApplyEffectsAndTextures(bool increasingAbuse)
        UpdateWearTearEffects()
        UpdateAbuseTextures(increasingAbuse=increasingAbuse)
    EndFunction 
         
    Function DegradeWearAndTear()
        String name = GetActor().GetLeveledActorBase().GetName()

        If Config.DebugMessagesEnabled
            Log("Reducing " + name + "'s sexual wear and tear...")

            Log("DegradeWearAndTear")
            Log(name + ": Last Vaginal Sex Pass : " + _lastVaginalSexPass)
            Log(name + ": Last Anal Sex Pass : " + _lastAnalSexPass)
            Log(name + ": Last Oral Sex Pass : " + _lastOralSexPass)            
        EndIf

        Float degradeFactor = config.WTDegradeFactor
        
        Int vaginalWTReduction =  (Math.pow(_lastVaginalSexPass, degradeFactor) * 15.0) As Int
        Int analWTReduction =  (Math.pow(_lastAnalSexPass, degradeFactor) * 15.0) As Int
        Int oralWTReduction =  (Math.pow(_lastOralSexPass, degradeFactor) * 15.0) As Int
        
        If config.DebugMessagesEnabled
            Log("WTDegradeFactor : " + degradeFactor)
            Log(name + ": Vaginal WT reduction amount : " + vaginalWTReduction)
            Log(name + ": Anal WT reduction amount : " + analWTReduction)
            Log(name + ": Oral WT reduction amount : " + oralWTReduction)
        EndIf 
        
        ApplyReducedVaginalWearAndTearAmount(vaginalWTReduction)
        ApplyReducedAnalWearAndTearAmount(analWTReduction)
        ApplyReducedOralWearAndTearAmount(oralWTReduction)

        ApplyReducedVaginalAbuseWearAndTearAmount(vaginalWTReduction)
        ApplyReducedAnalAbuseWearAndTearAmount(analWTReduction)
        ApplyReducedOralAbuseWearAndTearAmount(oralWTReduction * 2); double the reduction on oral-abuse so face textures change faster

        LogAllWearAndTear()
        UpdateWearTearEffects()
        UpdateAbuseTextures(increasingAbuse=False)
        
        _lastVaginalSexPass += 1
        _lastAnalSexPass += 1
        _lastOralSexPass += 1

        If (_vaginalWearTear <= 1 && _analWearTear <= 1 && _oralWearTear <= 1)
            GoToState("ClearTracking")
        EndIf
    EndFunction

    Function LogAllWearAndTear()
        If !Config.DebugMessagesEnabled
            Return
        EndIf
        Debug("Vaginal=" + _vaginalState + "(" + _vaginalWearTear +")")
        Debug("- AbuseVaginal=" + _abuseVaginalState + "(" + _abuseVaginalWearTear + ")")
        Debug("- CreatureAbuseVaginal=" + _creatureAbuseVaginalState + "(" + _creatureAbuseVaginalWearTear + ")")
        Debug("- DaedricAbuseVaginal=" + _daedricAbuseVaginalState + "(" + _daedricAbuseVaginalWearTear + ")")

        Debug("Anal=" + AnalWearTearState + "(" + AnalWearTear +")")
        Debug("- AbuseAnal=" + _abuseAnalState + "(" + _abuseAnalWearTear + ")")
        Debug("- CreatureAbuseAnal=" + _creatureAbuseAnalState + "(" + _creatureAbuseAnalWearTear + ")")
        Debug("- DaedricAbuseAnal=" + _daedricAbuseAnalState + "(" + _daedricAbuseAnalWearTear + ")")

        Debug("Oral=" + OralWearTearState + "(" + OralWearTear +")")
        Debug("- AbuseOral=" + _abuseOralState + "(" + _abuseOralWearTear + ")")
        Debug("- CreatureAbuseOral=" + _creatureAbuseOralState + "(" + _creatureAbuseOralWearTear + ")")
        Debug("- DaedricAbuseOral=" + _daedricAbuseOralState + "(" + _daedricAbuseOralWearTear + ")")
        Debug("- avg Abuse = " + AverageAbuseState)
        Debug("- avg Creature Abuse = " + AverageCreatureAbuseState)
        Debug("- avg Daedric Abuse = " + AverageDaedricAbuseState)
    EndFunction

    Function IncreaseVaginalWearAndTear(Int amountApplied)
        If !GuardWearTearEnabled("IncreaseVaginalWearAndTear", amountApplied)
            Return
        EndIf

        Int oldWearAndTearState = _vaginalState
        
        _vaginalWearTear = CalculateIncreasedWearTearValue(amountApplied, _vaginalWearTear)
        _vaginalState = Apropos2Util.MapWearTearAmountToState(_vaginalWearTear)
        
        LogWearTearChange("vaginal", _vaginalWearTear, _vaginalState)

        Int change = _vaginalState - oldWearAndTearState

        If change > 0 && _vaginalState > 0
            String effectiveVoice = Config.GetEffectiveNarrativeVoice(GetActor() == PlayerRef)
            DisplayWearTearChangedMessage("Increased", effectiveVoice, "Vaginal")
        EndIf

        _lastVaginalSexPass = 0
    EndFunction

    Function IncreaseVaginalAbuseWearAndTear(Int amountApplied, Bool isRapeOrAggressive, Bool isDaedricCreatureOrDremora, Bool isCreature)
        If isRapeOrAggressive && Config.EnableSkinTextures

            Debug("AproposActorAlias.IncreaseVaginalAbuseWearAndTear("+amountApplied+","+isRapeOrAggressive+","+isDaedricCreatureOrDremora+","+isCreature+")")
                     
            Int oldAbuseVaginalState = _abuseVaginalState

            _abuseVaginalWearTear = CalculateIncreasedWearTearValue(amountApplied, _abuseVaginalWearTear)
            _abuseVaginalState = Apropos2Util.MapWearTearAmountToState(_abuseVaginalWearTear)
            LogWearTearChange("abuse-vaginal", _abuseVaginalWearTear, _abuseVaginalState)

            If isCreature && Config.EnableCutScratches

                Int oldCreatureAbuseVaginalState = _creatureAbuseVaginalState
                _creatureAbuseVaginalWearTear = CalculateIncreasedWearTearValue(amountApplied, _creatureAbuseVaginalWearTear)
                _creatureAbuseVaginalState = Apropos2Util.MapWearTearAmountToState(_creatureAbuseVaginalWearTear)
                LogWearTearChange("creature-abuse-vaginal", _creatureAbuseVaginalWearTear, _creatureAbuseVaginalState)

            EndIf

            If isDaedricCreatureOrDremora && Config.EnableDaedricScars

                Int oldDaedricAbuseVaginalState = _daedricAbuseVaginalState
                _daedricAbuseVaginalWearTear = CalculateIncreasedWearTearValue(amountApplied, _daedricAbuseVaginalWearTear)
                _daedricAbuseVaginalState = Apropos2Util.MapWearTearAmountToState(_daedricAbuseVaginalWearTear)
                LogWearTearChange("daedric-abuse-vaginal", _daedricAbuseVaginalWearTear, _daedricAbuseVaginalState)                

            EndIf
        EndIf

    EndFunction    

    Function ApplyReducedVaginalWearAndTearAmount(Int amountApplied)
        If !GuardWearTearEnabled("ApplyReducedVaginalWearAndTearAmount", amountApplied)
            Return
        EndIf

        Int oldWearAndTearState = _vaginalState
        
        _vaginalWearTear = CalculateReducedWearTearValue(amountApplied, _vaginalWearTear)
        _vaginalState = Apropos2Util.MapWearTearAmountToState(_vaginalWearTear)
        LogWearTearChange("vaginal", _vaginalWearTear, _vaginalState)

        Int change = _vaginalState - oldWearAndTearState

        If change < 0 && _vaginalState > 0
            String effectiveVoice = Config.GetEffectiveNarrativeVoice(GetActor() == PlayerRef)
            DisplayWearTearChangedMessage("Reduced", effectiveVoice, "Vaginal")
        EndIf
    EndFunction

    Function ApplyReducedVaginalAbuseWearAndTearAmount(Int amountApplied)
        If !Config.EnableSkinTextures
            Return
        EndIf

        Debug("AproposActorAlias.ApplyReducedVaginalWearAndTearAmount("+amountApplied+")")
                 
        Int oldAbuseVaginalState = _abuseVaginalState

        _abuseVaginalWearTear = CalculateReducedWearTearValue(amountApplied, _abuseVaginalWearTear)
        _abuseVaginalState = Apropos2Util.MapWearTearAmountToState(_abuseVaginalWearTear)
        LogWearTearChange("abuse-vaginal", _abuseVaginalWearTear, _abuseVaginalState)

        If Config.EnableCutScratches

            Int oldCreatureAbuseVaginalState = _creatureAbuseVaginalState
            _creatureAbuseVaginalWearTear = CalculateReducedWearTearValue(amountApplied, _creatureAbuseVaginalWearTear)
            _creatureAbuseVaginalState = Apropos2Util.MapWearTearAmountToState(_creatureAbuseVaginalWearTear)
            LogWearTearChange("creature-abuse-vaginal", _creatureAbuseVaginalWearTear, _creatureAbuseVaginalState)

        ElseIf Config.EnableDaedricScars

            Int oldDaedricAbuseVaginalState = _daedricAbuseVaginalState
            _daedricAbuseVaginalWearTear = CalculateReducedWearTearValue(amountApplied, _daedricAbuseVaginalWearTear)
            _daedricAbuseVaginalState = Apropos2Util.MapWearTearAmountToState(_daedricAbuseVaginalWearTear)
            LogWearTearChange("daedric-abuse-vaginal", _daedricAbuseVaginalWearTear, _daedricAbuseVaginalState)                

        EndIf
    EndFunction

    Function IncreaseAnalWearAndTear(Int amountApplied)
        If !GuardWearTearEnabled("ApplyIncreasedAnalWearAndTearAmount", amountApplied)
            Return
        EndIf

        Int oldWearAndTearState = _analState
        
        _analWearTear = CalculateIncreasedWearTearValue(amountApplied, _analWearTear)
        _analState = Apropos2Util.MapWearTearAmountToState(_analWearTear)
        
        LogWearTearChange("anal", _analWearTear, _analState)

        Int change = _analState - oldWearAndTearState

        If change > 0 && _analState > 0
            String effectiveVoice = Config.GetEffectiveNarrativeVoice(GetActor() == PlayerRef)
            DisplayWearTearChangedMessage("Increased", effectiveVoice, "Anal")
        EndIf            
        
        _lastAnalSexPass = 0
    EndFunction

    Function IncreaseAnalAbuseWearAndTear(Int amountApplied, Bool isRapeOrAggressive, Bool isDaedricCreatureOrDremora, Bool isCreature)
        If isRapeOrAggressive && Config.EnableSkinTextures

            Debug("AproposActorAlias.IncreaseAnalAbuseWearAndTear("+amountApplied+","+isRapeOrAggressive+","+isDaedricCreatureOrDremora+","+isCreature+")")

            Int oldAbuseAnalState = _abuseAnalState

            _abuseAnalWearTear = CalculateIncreasedWearTearValue(amountApplied, _abuseAnalWearTear)
            _abuseAnalState = Apropos2Util.MapWearTearAmountToState(_abuseAnalWearTear)
            LogWearTearChange("abuse-anal", _abuseAnalWearTear, _abuseAnalState)

            If isCreature && Config.EnableCutScratches

                Int oldCreatureAbuseAnalState = _creatureAbuseAnalState
                _creatureAbuseAnalWearTear = CalculateIncreasedWearTearValue(amountApplied, _creatureAbuseAnalWearTear)
                _creatureAbuseAnalState = Apropos2Util.MapWearTearAmountToState(_creatureAbuseAnalWearTear)
                LogWearTearChange("creature-abuse-anal", _creatureAbuseAnalWearTear, _creatureAbuseAnalState)

            EndIf

            If isDaedricCreatureOrDremora && Config.EnableDaedricScars

                Int oldDaedricAbuseAnalState = _daedricAbuseAnalState
                _daedricAbuseAnalWearTear = CalculateIncreasedWearTearValue(amountApplied, _daedricAbuseAnalWearTear)
                _daedricAbuseAnalState = Apropos2Util.MapWearTearAmountToState(_daedricAbuseAnalWearTear)
                LogWearTearChange("daedric-abuse-anal", _daedricAbuseAnalWearTear, _daedricAbuseAnalState)                
            EndIf
        EndIf                
    EndFunction    

    Function ApplyReducedAnalWearAndTearAmount(Int amountApplied)
        If !GuardWearTearEnabled("ApplyReducedAnalWearAndTearAmount", amountApplied)
            Return
        EndIf

        Int oldWearAndTearState = _analState
        
        _analWearTear = CalculateReducedWearTearValue(amountApplied, _analWearTear)
        _analState = Apropos2Util.MapWearTearAmountToState(_analWearTear)
        LogWearTearChange("anal", _analWearTear, _analState)  

        Int change = _analState - oldWearAndTearState

        If change < 0 && _analState > 0
            String effectiveVoice = Config.GetEffectiveNarrativeVoice(GetActor() == PlayerRef)
            DisplayWearTearChangedMessage("Reduced", effectiveVoice, "Anal")
        EndIf        
    EndFunction

    Function ApplyReducedAnalAbuseWearAndTearAmount(Int amountApplied)
        If !Config.EnableSkinTextures
            Return
        EndIf

        Debug("AproposActorAlias.ApplyReducedAnalAbuseWearAndTearAmount("+amountApplied+")")

        Int oldAbuseAnalState = _abuseAnalState

        _abuseAnalWearTear = CalculateReducedWearTearValue(amountApplied, _abuseAnalWearTear)
        _abuseAnalState = Apropos2Util.MapWearTearAmountToState(_abuseAnalWearTear)
        LogWearTearChange("abuse-anal", _abuseAnalWearTear, _abuseAnalState)

        If Config.EnableCutScratches

            Int oldCreatureAbuseAnalState = _creatureAbuseAnalState
            _creatureAbuseAnalWearTear = CalculateReducedWearTearValue(amountApplied, _creatureAbuseAnalWearTear)
            _creatureAbuseAnalState = Apropos2Util.MapWearTearAmountToState(_creatureAbuseAnalWearTear)
            LogWearTearChange("creature-abuse-anal", _creatureAbuseAnalWearTear, _creatureAbuseAnalState)

        ElseIf Config.EnableDaedricScars

            Int oldDaedricAbuseAnalState = _daedricAbuseAnalState
            _daedricAbuseAnalWearTear = CalculateReducedWearTearValue(amountApplied, _daedricAbuseAnalWearTear)
            _daedricAbuseAnalState = Apropos2Util.MapWearTearAmountToState(_daedricAbuseAnalWearTear)
            LogWearTearChange("daedric-abuse-anal", _daedricAbuseAnalWearTear, _daedricAbuseAnalState)                
        EndIf
    EndFunction   

    Function IncreaseOralWearAndTear(Int amountApplied)
        If !GuardWearTearEnabled("ApplyIncreasedOralWearAndTearAmount", amountApplied)
            Return
        EndIf

        Int oldWearAndTearState = _oralState
        
        _oralWearTear = CalculateIncreasedWearTearValue(amountApplied, _oralWearTear)
        _oralState = Apropos2Util.MapWearTearAmountToState(_oralWearTear)
        
        LogWearTearChange("oral", _oralWearTear, _oralState)

        Int change = _oralState - oldWearAndTearState

        If change > 0 && _oralState > 0
            String effectiveVoice = Config.GetEffectiveNarrativeVoice(GetActor() == PlayerRef)
            DisplayWearTearChangedMessage("Increased", effectiveVoice, "Oral")
        EndIf 
        
        _lastOralSexPass = 0
    EndFunction

    Function IncreaseOralAbuseWearAndTear(Int amountApplied, Bool isRapeOrAggressive, Bool isDaedricCreatureOrDremora, Bool isCreature)
        If isRapeOrAggressive && Config.EnableSkinTextures

            Debug("AproposActorAlias.IncreaseOralAbuseWearAndTear("+amountApplied+","+isRapeOrAggressive+","+isDaedricCreatureOrDremora+","+isCreature+")")

            Int oldAbuseOralState = _abuseOralState

            _abuseOralWearTear = CalculateIncreasedWearTearValue(amountApplied, _abuseOralWearTear)
            _abuseOralState = Apropos2Util.MapWearTearAmountToState(_abuseOralWearTear)
            LogWearTearChange("abuse-oral", _abuseOralWearTear, _abuseOralState)

            If isCreature && Config.EnableCutScratches

                Int oldCreatureAbuseOralState = _creatureAbuseOralState
                _creatureAbuseOralWearTear = CalculateIncreasedWearTearValue(amountApplied, _creatureAbuseOralWearTear)
                _creatureAbuseOralState = Apropos2Util.MapWearTearAmountToState(_creatureAbuseOralWearTear)
                LogWearTearChange("creature-abuse-oral", _creatureAbuseOralWearTear, _creatureAbuseOralState)

            EndIf

            If isDaedricCreatureOrDremora && Config.EnableDaedricScars

                Int oldDaedricAbuseOralState = _daedricAbuseOralState
                _daedricAbuseOralWearTear = CalculateIncreasedWearTearValue(amountApplied, _daedricAbuseOralWearTear)
                _daedricAbuseOralState = Apropos2Util.MapWearTearAmountToState(_daedricAbuseOralWearTear)
                LogWearTearChange("daedric-abuse-oral", _daedricAbuseOralWearTear, _daedricAbuseOralState)                

            EndIf
        EndIf                
    EndFunction    

    Function ApplyReducedOralWearAndTearAmount(Int amountApplied)
        If !GuardWearTearEnabled("ApplyReducedOralWearAndTearAmount", amountApplied)
            Return
        EndIf

        Int oldWearAndTearState = _oralState

        _oralWearTear = CalculateReducedWearTearValue(amountApplied, _oralWearTear)
        _oralState = Apropos2Util.MapWearTearAmountToState(_oralWearTear)
        LogWearTearChange("oral", _oralWearTear, _oralState)  

        Int change = _oralState - oldWearAndTearState

        If change < 0 && _oralState > 0
            String effectiveVoice = Config.GetEffectiveNarrativeVoice(GetActor() == PlayerRef)
            DisplayWearTearChangedMessage("Reduced", effectiveVoice, "Oral")
        EndIf         
    EndFunction     

    Function ApplyReducedOralAbuseWearAndTearAmount(Int amountApplied)
        If !Config.EnableSkinTextures
            Return
        EndIf

        Debug("AproposActorAlias.ApplyReducedOralAbuseWearAndTearAmount("+amountApplied+")")

        Int oldAbuseOralState = _abuseOralState

        _abuseOralWearTear = CalculateReducedWearTearValue(amountApplied, _abuseOralWearTear)
        _abuseOralState = Apropos2Util.MapWearTearAmountToState(_abuseOralWearTear)
        LogWearTearChange("abuse-oral", _abuseOralWearTear, _abuseOralState)

        If Config.EnableCutScratches

            Int oldCreatureAbuseOralState = _creatureAbuseOralState
            _creatureAbuseOralWearTear = CalculateReducedWearTearValue(amountApplied, _creatureAbuseOralWearTear)
            _creatureAbuseOralState = Apropos2Util.MapWearTearAmountToState(_creatureAbuseOralWearTear)
            LogWearTearChange("creature-abuse-oral", _creatureAbuseOralWearTear, _creatureAbuseOralState)

        ElseIf Config.EnableDaedricScars

            Int oldDaedricAbuseOralState = _daedricAbuseOralState
            _daedricAbuseOralWearTear = CalculateReducedWearTearValue(amountApplied, _daedricAbuseOralWearTear)
            _daedricAbuseOralState = Apropos2Util.MapWearTearAmountToState(_daedricAbuseOralWearTear)
            LogWearTearChange("daedric-abuse-oral", _daedricAbuseOralWearTear, _daedricAbuseOralState)                

        EndIf
    EndFunction    

    Int Function AddTattoo(Actor anActor, String name, String texture, String section, String area, Int slot, Int colorTint = -1)
        ; AddTattoo(anActor, "Sob 2", "Sob Tears\\sob_2.dds", "Tears", "Face", slot)
        If colorTint == -1 
            colorTint = Config.TatsColorTint
        EndIf
        Int map = RetainedMap4Pair("name", name, "texture", texture, "section", section, "area", area)
        JMap.setInt(map, "color", colorTint)
        If Config.TraceMessagesEnabled
            Debug("AddTattoo, calling add_tattoo")
            Debug("... section : " + section)
            Debug("... area : " + area)
            Debug("... name : " + name)
            Debug("... texture : " + texture)
            Debug("... slot : " + slot)
            Debug("... color: " + colorTint)
            Debug("... actor : " + anActor.GetDisplayName())
        EndIf    
        If Slavetats.add_tattoo(anActor, map, slot)
            Debug("Failed to add tattoo")
        EndIf
        Return map
    EndFunction

    Function ApplyConsumable(Form consumable)

        Int healAmount = 0
        String name = consumable.GetName()
        Bool ingredientOrPotion = False
        If consumable As Potion
            Debug("Drank a healing potion: " + name)
            ingredientOrPotion = True
        ElseIf consumable As Ingredient
            Debug("Ate an healing ingredient: " + name)
            ingredientOrPotion = True
        EndIf

        If !ingredientOrPotion
            Return
        EndIf
        
        healAmount = Config.Database.GetWearTearConsumableHealAmount(name)

        If healAmount == 0 
            Return
        EndIf

        ApplyReducedVaginalWearAndTearAmount(healAmount)
        ApplyReducedAnalWearAndTearAmount(healAmount)
        ApplyReducedOralWearAndTearAmount(healAmount)

        ApplyReducedVaginalAbuseWearAndTearAmount(healAmount)
        ApplyReducedAnalAbuseWearAndTearAmount(healAmount)
        ApplyReducedOralAbuseWearAndTearAmount(healAmount)
        ApplyEffectsAndTextures(increasingAbuse=False)

        If Config.ConsumablesIncreaseArousal 
            Actor anActor = GetActor()
            Int arousal = Config.Database.GetScaledArousalAmountForConsumable(name)
            UpdateActorArousalExposure(anActor, arousal As Float)
            sslBaseVoice voice = SexLab.PickVoice(anActor)
            voice.Moan(anActor, 10, False)
        EndIf        
    EndFunction    

    Event OnEndState()
    EndEvent        
    
    Event OnDeath(Actor akKiller)
        GoToState("ReadyForTracking")
    EndEvent
EndState

State ClearTracking
    Event OnBeginState()
        Debug("ClearTracking.OnBeginState")
        UnregisterForUpdate()

        Actor anActor = GetActor()

        If anActor
            RemoveAllAbuseTextures(anActor, True)
            DispellAllSpells(anActor)
        EndIf

        _oralState = 0
        _oralWearTear = 0
        _lastOralSexPass = 0

        _analState = 0
        _analWearTear = 0
        _lastAnalSexPass = 0

        _vaginalState = 0
        _vaginalWearTear = 0
        _lastVaginalSexPass = 0    

        _abuseVaginalWearTear = 0
        _abuseAnalWearTear = 0
        _abuseOralWearTear = 0

        _abuseVaginalState = 0
        _abuseAnalState = 0
        _abuseOralState = 0

        _creatureAbuseVaginalWearTear = 0
        _creatureAbuseAnalWearTear = 0
        _creatureAbuseOralWearTear = 0

        _creatureAbuseVaginalState = 0
        _creatureAbuseAnalState = 0
        _creatureAbuseOralState = 0

        _daedricAbuseVaginalWearTear = 0
        _daedricAbuseAnalWearTear = 0
        _daedricAbuseOralWearTear = 0

        _daedricAbuseVaginalState = 0
        _daedricAbuseAnalState = 0
        _daedricAbuseOralState = 0        

        _deferredWTChange = ""
        _deferredWTChangeEffectiveVoice = ""
        _deferredWTChangeBodyPart = ""        

        _currentHour = 0
        _lastGameTime = 0.0

        _lastActiveActorArousal = 0

        GoToState("ReadyForTracking")
    EndEvent
    
    Event OnEndState()
        
    EndEvent
    
    Event OnUpdate()
        
    EndEvent
EndState

String Function TestIsAlive()
    Return "Alive"
EndFunction

Function LogWearTearChange(String type, Int wearTearValue, Int wearTearState)
    If Config.DebugMessagesEnabled
        LogActor(ActorRef, type + " Wear & Tear = " + wearTearValue + " (value) " + wearTearState + " (state)")
    EndIf  
EndFunction

Function SendDisplayWearAndTearChangeEvent(String change, Actor anActor, String effectiveVoice, String bodyPart)
    Int eid = ModEvent.Create("APR2_DisplayWearAndTearChange")
    ModEvent.PushString(eid, change)
    ModEvent.PushForm(eid, anActor)
    ModEvent.PushString(eid, effectiveVoice)
    ModEvent.PushString(eid, bodyPart)
    ModEvent.Send(eid)
EndFunction

Bool Function GuardWearTearEnabled(String label, Int amount)
    If amount == 0
        Return False
    EndIf

    If !Config.WearAndTearEnabled
        Return False
    EndIf
    
    If ActorRef != PlayerRef && !Config.NPCWearAndTearEnabled
        Debug("NPC W&T disabled and this is not the player")
        Return False
    EndIf    
    
    If Config.TraceMessagesEnabled
        LogActor(ActorRef, label + "(" + amount + ")" )
    EndIf    
    
    Return True
EndFunction

Int Function CalculateIncreasedWearTearValue(Int amountApplied, Int wearTearAmount)
    If Config.TraceMessagesEnabled
        Log("CalculateIncreasedWearTearValue(" + amountApplied + "," + wearTearAmount + ")")
    EndIf
    Int range = amountApplied / 5
    Int randomAmount = Utility.RandomInt(-range, range) + amountApplied
    Return SslUtility.ClampInt(wearTearAmount + randomAmount, 0, Config.MaxWearTearAmount)
EndFunction

Int Function CalculateReducedWearTearValue(Int amountApplied, Int wearTearAmount)
    Int range = amountApplied / 5
    Int randomAmount = Utility.RandomInt(-range, range) + amountApplied
    If amountApplied > wearTearAmount
        wearTearAmount = 1
    ElseIf amountApplied < wearTearAmount
        wearTearAmount -= randomAmount
    EndIf
    Return SslUtility.ClampInt(wearTearAmount, 0, Config.MaxWearTearAmount)
EndFunction

Function LogAllWearAndTear()
    Debug("Attempts to call LogAllWearAndTear while in empty state. Should be called in ReadyForTracking state")
    ; Specifically do nothing in the default state     
EndFunction

Function UpdateWearTearEffects()
    Debug("Attempts to call ApplyWearTearEffects while in empty state. Should be called in ReadyForTracking state")
    ; Specifically do nothing in the default state  
EndFunction

Function UpdateAbuseTextures(bool increasingAbuse)
    Debug("Attempts to call ApplyAbuseTextures while in empty state. Should be called in ReadyForTracking state")
    ; Specifically do nothing in the default state  
EndFunction

Function IncreaseVaginalWearAndTear(Int amountApplied)
    Debug("Attempts to call IncreaseVaginalWearAndTear while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state
EndFunction

Function IncreaseVaginalAbuseWearAndTear(Int amountApplied, Bool isRapeOrAggressive, Bool isDaedricCreatureOrDremora, Bool isCreature)
    Debug("Attempts to call IncreaseVaginalAbuseWearAndTear while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state
EndFunction

Function IncreaseAnalWearAndTear(Int amountApplied)
    Debug("Attempts to call IncreaseAnalWearAndTear while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state
EndFunction

Function IncreaseAnalAbuseWearAndTear(Int amountApplied, Bool isRapeOrAggressive, Bool isDaedricCreatureOrDremora, Bool isCreature)
    Debug("Attempts to call IncreaseAnalAbuseWearAndTear while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state
EndFunction

Function IncreaseOralWearAndTear(Int amountApplied)
    Debug("Attempts to call IncreaseOralWearAndTear while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state
EndFunction

Function IncreaseOralAbuseWearAndTear(Int amountApplied, Bool isRapeOrAggressive, Bool isDaedricCreatureOrDremora, Bool isCreature)
    Debug("Attempts to call IncreaseOralAbuseWearAndTear while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state
EndFunction

Function Track(Actor anActor, Int actorSlot)
    Debug("Attempts to call Track while in empty state. Should be called in ReadyForTracking state")
    ; Specifically do nothing in the default state
EndFunction

Function DisplayWearTearChangedMessage(String change, String effectiveVoice, String bodyPart, Bool scheduled = False)
    Debug("Attempts to call DisplayWearTearChangedMessage while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state    
EndFunction

Function DegradeWearAndTear()
    Debug("Attempts to call DegradeWearAndTear while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state    
EndFunction

Int Function AddTattoo(Actor anActor, String name, String texture, String section, String area, Int slot, Int colorTint = -1)
    Debug("Attempts to call AddTattoo while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state    
    Return -1
EndFunction

Function ApplyReducedVaginalWearAndTearAmount(Int amountApplied)
    Debug("Attempts to call ApplyReducedVaginalWearAndTearAmount while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state        
EndFunction

Function ApplyReducedVaginalAbuseWearAndTearAmount(Int amountApplied)
    Debug("Attempts to call ApplyReducedVaginalWearAndTearAmount while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state        
EndFunction

Function ApplyReducedAnalWearAndTearAmount(Int amountApplied)
    Debug("Attempts to call ApplyReducedVaginalWearAndTearAmount while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state      
EndFunction

Function ApplyReducedAnalAbuseWearAndTearAmount(Int amountApplied)
    Debug("Attempts to call ApplyReducedAnalAbuseWearAndTearAmount while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state
EndFunction    

Function ApplyReducedOralWearAndTearAmount(Int amountApplied)
    Debug("Attempts to call ApplyReducedOralWearAndTearAmount while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state      
EndFunction

Function ApplyReducedOralAbuseWearAndTearAmount(Int amountApplied)
    Debug("Attempts to call ApplyReducedOralAbuseWearAndTearAmount while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state
EndFunction

Function DispellAllSpells(Actor anActor)
    Debug("Attempts to call DispellAllSpells while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state        
EndFunction

Function RemoveAllAbuseTextures(Actor anActor, Bool synchronize = False)
    Debug("Attempts to call RemoveAllAbuseTextures while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state        
EndFunction

Function RemoveAfterEffectsTextures(Actor anActor)
    Debug("Attempts to call RemoveAfterEffectsTextures while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state    
EndFunction

Function RemoveTearsSobsTextures(Actor anActor)
    Debug("Attempts to call RemoveTearsSobsTextures while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state       
EndFunction

Function RemoveCutsScratchesTextures(Actor anActor)
    Debug("Attempts to call RemoveCutsScratchesTextures while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state       
EndFunction

Function RemoveDaedricScarsTextures(Actor anActor)
    Debug("Attempts to call RemoveDaedricScarsTextures while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state       
EndFunction

Function RemoveMascaraSmearTextures(Actor anActor)
    Debug("Attempts to call RemoveMascaraSmearTextures while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state       
EndFunction

Function ApplyConsumable(Form consumable) 
    Debug("Attempts to call ApplyConsumable while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state       
EndFunction

Function ApplyEffectsAndTextures(Bool increasingAbuse) 
    Debug("Attempts to call ApplyEffectsAndTextures while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state       
EndFunction

Function DoDisplayWearTearChangedMessage(Actor anActor, String change, String effectiveVoice, String bodyPart)
    Debug("Attempts to call DoDisplayWearTearChangedMessage while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state     
EndFunction

Function ProcessOrgasm(SslThreadController thread, Actor activeActor, Bool hasVictimOrAggressive, String damageClass, String[] bodyPartsAffected)
    Debug("Attempts to call ProcessOrgasm while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state       
EndFunction

Function ProcessStageStart(Actor[] all_actors)
    Debug("Attempts to call ProcessStageStart while in empty state. Should be called in Tracking state")
    ; Specifically do nothing in the default state       
EndFunction

Function CheckLibLoaded(Form frm, String msg)
    If !frm
        Debug(msg + " did not load!")
    EndIf
EndFunction

Function Setup()
    ; Reset function Libraries - SexLabQuestFramework
    If !Config || !Descriptions || !Database || !Framework
        Form api = GetFramework()
        If api
            Config        = api As Apropos2SystemConfig
            Descriptions  = api As Apropos2Descriptions
            Database      = api As Apropos2DescriptionDb
            Framework     = api As Apropos2Framework

            CheckLibLoaded(Config, "Config")
            CheckLibLoaded(Descriptions, "Descriptions")
            CheckLibLoaded(Database, "Database")
            CheckLibLoaded(Framework, "Framework")
        EndIf
        
        If !SexLab
            SexLab = GetSexLab()
        EndIf        

        If !SlaUtil
            SlaUtil = GetSLA()
        EndIf

    EndIf
    PlayerRef = Game.GetPlayer()
    GotoState("ReadyForTracking")
EndFunction

Function LogActor(Actor anActor, String msg)
    Config.LogActor(anActor, msg, Source="Apropos2ActorAlias")
EndFunction

Function DebugActor(Actor anActor, String msg)
    Config.DebugActor(anActor, msg, Source="Apropos2ActorAlias")
EndFunction

Function Log(String msg)
    Config.Log(msg, Source="Apropos2ActorAlias")
EndFunction

Function Debug(String msg)
    Config.Debug(msg, Source="Apropos2ActorAlias")
EndFunction