Scriptname EggFactoryMCMScript extends SKI_ConfigBase

;Import StorageUtil
Import Utility

; Initialization ;

; Global Values
GlobalVariable Property EggFactoryUninstallToggle auto
GlobalVariable Property EggFactoryMaleToggle auto
GlobalVariable Property EggFactoryFirstPerson auto
GlobalVariable Property EggFactoryBleedOut auto
GlobalVariable Property EggFactoryDismount auto
GlobalVariable Property EggFactoryUniqueVoice auto
GlobalVariable Property EggFactoryVoiceVolume auto
GlobalVariable Property EggFactoryMaxScale auto

GlobalVariable Property EggFactoryBreastEnable auto
GlobalVariable Property EggFactoryBreastMin auto
GlobalVariable Property EggFactoryBreastMax auto
GlobalVariable Property EggFactoryBreastRate auto
GlobalVariable Property EggFactoryBreastRate2 auto
GlobalVariable Property EggFactoryBellyMult auto
GlobalVariable Property EggFactoryShuffleMode auto

GlobalVariable Property EggFactorySpeedB auto
GlobalVariable Property EggFactorySpeedC auto
GlobalVariable Property EggFactorySpeedF auto
GlobalVariable Property EggFactorySpeedH auto
GlobalVariable Property EggFactorySpeedL auto
GlobalVariable Property EggFactorySpeedS auto

GlobalVariable Property EggFactoryTwinsB auto
GlobalVariable Property EggFactoryTwinsC auto
GlobalVariable Property EggFactoryTwinsF auto
GlobalVariable Property EggFactoryTwinsH auto
GlobalVariable Property EggFactoryTwinsL auto
GlobalVariable Property EggFactoryTwinsS auto

GlobalVariable Property EggFactoryWaterB auto
GlobalVariable Property EggFactoryWaterC auto
GlobalVariable Property EggFactoryWaterF auto
GlobalVariable Property EggFactoryWaterH auto
GlobalVariable Property EggFactoryWaterL auto
GlobalVariable Property EggFactoryWaterS auto

GlobalVariable Property EggFactorySkipB auto
GlobalVariable Property EggFactorySkipC auto
GlobalVariable Property EggFactorySkipF auto
GlobalVariable Property EggFactorySkipH auto
GlobalVariable Property EggFactorySkipL auto
GlobalVariable Property EggFactorySkipS auto

GlobalVariable Property EggFactoryExtraB auto
GlobalVariable Property EggFactoryExtraC auto
GlobalVariable Property EggFactoryExtraF auto
GlobalVariable Property EggFactoryExtraH auto
GlobalVariable Property EggFactoryExtraL auto
GlobalVariable Property EggFactoryExtraS auto

GlobalVariable Property EggFactoryDifB auto
GlobalVariable Property EggFactoryDifC auto
GlobalVariable Property EggFactoryDifF auto
GlobalVariable Property EggFactoryDifH auto
GlobalVariable Property EggFactoryDifL auto
GlobalVariable Property EggFactoryDifS auto

GlobalVariable Property EggFactoryChanceB auto
GlobalVariable Property EggFactoryChanceC auto
GlobalVariable Property EggFactoryChanceF auto
GlobalVariable Property EggFactoryChanceH auto
GlobalVariable Property EggFactoryChanceL auto
GlobalVariable Property EggFactoryChanceS auto

GlobalVariable Property EggFactoryChanceSInvert auto
GlobalVariable Property EggFactoryChanceLInvert auto
GlobalVariable Property EggFactoryChanceHInvert auto

GlobalVariable Property EggFactoryMilkRate auto
;GlobalVariable Property EggFactoryMilkBAMD auto
GlobalVariable Property EggFactoryMilkAlways auto

GlobalVariable Property EggFactoryScaleMethod auto
GlobalVariable Property EggFactoryBreastScaleMethod auto

GlobalVariable Property EggFactoryRespawnFix auto

GlobalVariable Property EggFactoryTwinCount auto
GlobalVariable Property EggFactoryProgress auto

GlobalVariable Property EggFactoryMultiLimit auto

;Spell Property EggFactoryAbility auto
;Spell Property EggFactoryAbilityC auto
;Spell Property EggFactoryAbilityF auto
;Spell Property EggFactoryAbilityH auto
;Spell Property EggFactoryAbilityL auto
;Spell Property EggFactoryAbilityS auto

; Configuration Options
bool Property bMalePreg = False Auto Hidden
bool Property bFirstPerson = False Auto Hidden
bool Property bEggFactoryUninstall = False Auto Hidden
bool Property bBleedOut = False Auto Hidden
bool Property bDismount = False Auto Hidden
bool Property bRespawnFix = True Auto Hidden
bool Property bUniqueVoice = True Auto Hidden
bool property bShuffleMode = False Auto hidden
float Property fVoiceVolume = 1.0 Auto Hidden
float property fMaxSize = 12.0 Auto Hidden
bool Property bMilkHF = False Auto Hidden
bool Property bMilkBAMD = False Auto Hidden
;float Property nSliderA = 1.0 Auto Hidden
;float Property nSliderB = 0.0 Auto Hidden
bool Property bBreastEnable = False Auto Hidden
float property fBreastMin = 1.0 Auto Hidden
float property fBreastMax = 4.0 Auto Hidden
float property fBreastRate = 1.0 Auto Hidden
float property fBreastRate2 = 0.5 Auto Hidden
float property fBellyScaleMult = 1.0 Auto Hidden
int property BellyScaleType = 1 Auto Hidden
int property BreastScaleType = 1 Auto Hidden

spell property EggFactoryBreastAB Auto

faction property EggFactoryCounter Auto 

EggFactoryNIOController Property EggFactoryQuest auto

;int property itemsadded auto
;leveleditem[] property sourcelists auto
;leveleditem[] property destlists auto

; Reference Properties
Actor Property mySelf Auto

int Function GetVersion()
    return 36
EndFunction

Function SendChangeEvent()
	int handle = ModEvent.Create("EggFactory_ConfigChange")
	if (handle)
		if(!modevent.send(handle))
			debug.notification("Mod event could not send.")
		endif
	else
		debug.notification("Could not create mod event, help!")
	endif
EndFunction

Function SendChangeEvent2()
	int handle = ModEvent.Create("EggFactory_ConfigChange2")
	if (handle)
		if(!modevent.send(handle))
			debug.notification("Mod event could not send.")
		endif
	else
		debug.notification("Could not create mod event, help!")
	endif
EndFunction

string function GetStringVer(int iVersion)
    string sNumberVer = StringUtil.Substring(((iVersion as float) / 10.0) as string, 0, 3)
    return sNumberVer
endFunction

string function skseVersionString()
    return SKSE.GetVersion() as string + "." + SKSE.GetVersionMinor() as string  + "." + SKSE.GetVersionBeta() as string
endFunction

int function skseVersionCompare(int major, int minor, int beta)
    int skseMajor = SKSE.GetVersion()
    int skseMinor = SKSE.GetVersionMinor()
    int skseBeta  = SKSE.GetVersionBeta()

    if skseMajor == major
        if skseMinor == minor
            if skseBeta == beta
                return 0
            elseIf skseBeta > beta
                return 1
            else
                return -1
            endIf
        elseIf skseMinor > minor
            return 1
        else
            return -1
        endIf
    elseIf skseMajor > major
        return 1
    else
        return -1
    endIf
endFunction

; Setup ;

Event OnGameReload()
    parent.OnGameReload()
    ; Any other gameload things here.
    
    return
EndEvent

Event OnPlayerLoadGame()
    if ( GetVersion() != CurrentVersion )
        OnConfigInit()
    endif
    
    return
EndEvent

Event OnVersionUpdate(int ver)
    OnConfigInit()
    return
EndEvent

Event OnConfigInit()
    if ( CurrentVersion > 0 && GetVersion() != CurrentVersion )
        Debug.Notification( ModName + " is currently script version " + GetStringVer(CurrentVersion) + "." )
        Debug.Notification( ModName + " is converting script to version " + GetStringVer(GetVersion()) + "..." )
    endif
    
    Pages = new string[10]
    Pages[0] = "General Options"
    Pages[1] = "Bird Egg Options"
	Pages[2] = "Spider Egg Options"
	Pages[3] = "Fish Egg Options"
	Pages[4] = "Large Bird Egg Options"
	Pages[5] = "Chaurus Egg Options"
	Pages[6] = "Dragon Egg Options"
	Pages[7] = "Lactation Options"
    Pages[8] = "Information"
	Pages[9] = "Credits"
    
    ; Update confirmation.
    CurrentVersion = GetVersion()
    Debug.Notification( ModName + " (v" + GetStringVer(CurrentVersion) + ") is up to date." )
    return
EndEvent

Event OnPageReset(string page)
    ; Refresh menu function to scan for version updates.
    if ( CurrentVersion != GetVersion() )
        OnConfigInit()
    endif
    
    UnloadCustomContent()
    
    ; Update any variables
    self.bEggFactoryUninstall == ( EggFactoryUninstallToggle.GetValueInt() as bool )
    
    ; List pages
    if page == "General Options"
        ShowPageGeneral()
    elseif page == "Information"
        ShowPageMisc()
	elseif page == "Bird Egg Options"
        ShowPageBird()
	elseif page == "Spider Egg Options"
        ShowPageSpider()
	elseif page == "Fish Egg Options"
        ShowPageFish()
	elseif page == "Large Bird Egg Options"
        ShowPageLarge()			
	elseif page == "Chaurus Egg Options"
        ShowPageCha()			
	elseif page == "Dragon Egg Options"
        ShowPageDra()	
	elseif page == "Lactation Options"
        ShowPageMilk()
	elseif page == "Credits"
        ShowPageCredits()
    else
        ShowPageIntro()
    endif

    return
EndEvent

; Toggle Options ;

Event OnOptionSelect(int menu)

    if menu == MenuEggFactoryUninstall
        if ( self.bEggFactoryUninstall == false )
            bool bEggFactoryUninstallMsg = ShowMessage("After confirming, you will need to exit the MCM and wait as the mod uncurses anyone affected. Are you sure you want to uninstall this mod?", true, "$Yes", "$No")
            if ( bEggFactoryUninstallMsg == true )
                
                ; Insert any other uninstall parameters here.
                
                bEggFactoryUninstallMsg = false
                self.bEggFactoryUninstall = true
                EggFactoryUninstallToggle.SetValueInt(self.bEggFactoryUninstall as int)
                SetToggleOptionValue(menu,self.bEggFactoryUninstall)
                ; Game.GetPlayer().RemoveSpell(EggFactoryBreastAB)
				EggFactoryBreastEnable.SetValueInt(0)
                ForcePageReset()
                return
            endif
        else
            bool bEggFactoryUninstallMsg = ShowMessage("You have already decided to uninstall this mod. Are you sure you want to reactivate it?", true, "$Yes", "$No")
            if ( bEggFactoryUninstallMsg == true )
                bEggFactoryUninstallMsg = false
                self.bEggFactoryUninstall = false
                EggFactoryUninstallToggle.SetValueInt(self.bEggFactoryUninstall as int)
                SetToggleOptionValue(menu,self.bEggFactoryUninstall)
                ForcePageReset()
                return
            endif
        endif
    elseif menu == MenuRespawnFix
        self.bRespawnFix = !self.bRespawnFix
        EggFactoryRespawnFix.SetValueInt(self.bRespawnFix as int)
        SetToggleOptionValue(menu,self.bRespawnFix)
    elseif menu == MenuBellyType0
        self.BellyScaleType = 0
        EggFactoryScaleMethod.SetValueInt(0)
        SetToggleOptionValue(MenuBellyType0,1)
        SetToggleOptionValue(MenuBellyType1,0)
        SetToggleOptionValue(MenuBellyType2,0)
      	SendChangeEvent()
    elseif menu == MenuBellyType1
        self.BellyScaleType = 1
        EggFactoryScaleMethod.SetValueInt(1)
        SetToggleOptionValue(MenuBellyType0,0)
        SetToggleOptionValue(MenuBellyType1,1)
        SetToggleOptionValue(MenuBellyType2,0)
        SetToggleOptionValue(MenuBellyType3,0)
      	SendChangeEvent()
    elseif menu == MenuBellyType2
        self.BellyScaleType = 2
        EggFactoryScaleMethod.SetValueInt(2)
        SetToggleOptionValue(MenuBellyType0,0)
        SetToggleOptionValue(MenuBellyType1,0)
        SetToggleOptionValue(MenuBellyType2,1)
        SetToggleOptionValue(MenuBellyType3,0)
       	SendChangeEvent()
    elseif menu == MenuBellyType3
        self.BellyScaleType = 3
        EggFactoryScaleMethod.SetValueInt(3)
        SetToggleOptionValue(MenuBellyType0,0)
        SetToggleOptionValue(MenuBellyType1,0)
        SetToggleOptionValue(MenuBellyType2,0)
        SetToggleOptionValue(MenuBellyType3,1)
       	SendChangeEvent()
    elseif menu == MenuBreastType0
        self.BreastScaleType = 0
        EggFactoryBreastScaleMethod.SetValueInt(0)
        SetToggleOptionValue(MenuBreastType0,1)
        SetToggleOptionValue(MenuBreastType1,0)
        SetToggleOptionValue(MenuBreastType2,0)
      	SendChangeEvent()
    elseif menu == MenuBreastType1
        self.BreastScaleType = 1
        EggFactoryBreastScaleMethod.SetValueInt(1)
        SetToggleOptionValue(MenuBreastType0,0)
        SetToggleOptionValue(MenuBreastType1,1)
        SetToggleOptionValue(MenuBreastType2,0)
        SetToggleOptionValue(MenuBreastType3,0)
      	SendChangeEvent()
    elseif menu == MenuBreastType2
        self.BreastScaleType = 2
        EggFactoryBreastScaleMethod.SetValueInt(2)
        SetToggleOptionValue(MenuBreastType0,0)
        SetToggleOptionValue(MenuBreastType1,0)
        SetToggleOptionValue(MenuBreastType2,1)
        SetToggleOptionValue(MenuBreastType3,0)
       	SendChangeEvent()
    elseif menu == MenuBreastType3
        self.BreastScaleType = 3
        EggFactoryBreastScaleMethod.SetValueInt(3)
        SetToggleOptionValue(MenuBreastType0,0)
        SetToggleOptionValue(MenuBreastType1,0)
        SetToggleOptionValue(MenuBreastType2,0)
        SetToggleOptionValue(MenuBreastType3,1)
       	SendChangeEvent()
    elseif menu == MenuMalePreg
        self.bMalePreg = !self.bMalePreg
        EggFactoryMaleToggle.SetValueInt(self.bMalePreg as int)
        SetToggleOptionValue(menu,self.bMalePreg)
    elseif menu == MenuFirstPerson
        self.bFirstPerson = !self.bFirstPerson
        EggFactoryFirstPerson.SetValueInt(self.bFirstPerson as int)
        SetToggleOptionValue(menu,self.bFirstPerson)
    elseif menu == MenuBleedOut
        self.bBleedOut = !self.bBleedOut
        EggFactoryBleedOut.SetValueInt(self.bBleedOut as int)
        SetToggleOptionValue(menu,self.bBleedOut)
    elseif menu == MenuDismount
        self.bDismount = !self.bDismount
        EggFactoryDismount.SetValueInt(self.bDismount as int)
        SetToggleOptionValue(menu,self.bDismount)
    elseif menu == MenuUniqueVoice
        self.bUniqueVoice = !self.bUniqueVoice
        EggFactoryUniqueVoice.SetValueInt(self.bUniqueVoice as int)
        SetToggleOptionValue(menu,self.bUniqueVoice)
	elseif menu == MenuShuffleMode
        self.bShuffleMode = !self.bShuffleMode
        EggFactoryShuffleMode.SetValueInt(self.bShuffleMode as int)
        SetToggleOptionValue(menu,self.bShuffleMode)
	elseif menu == MenuMilkHF
        self.bMilkHF = !self.bMilkHF
        EggFactoryMilkAlways.SetValueInt(self.bMilkHF as int)
        SetToggleOptionValue(menu,self.bMilkHF)
		SendModEvent("EggFactory_LactationOptionsSet")
;	elseif menu == MenuMilkBAMD
;       self.bMilkBAMD = !self.bMilkBAMD
;        EggFactoryMilkBAMD.SetValueInt(self.bMilkBAMD as int)
;        SetToggleOptionValue(menu,self.bMilkBAMD)
;		SendModEvent("EggFactory_LactationOptionsSet")
    elseif menu == MenuBreastEnable
        self.bBreastEnable = !self.bBreastEnable
        EggFactoryBreastEnable.SetValueInt(self.bBreastEnable as int)
        if(self.bBreastEnable)
            Game.GetPlayer().AddSpell(EggFactoryBreastAB)
        else
           ; Game.GetPlayer().RemoveSpell(EggFactoryBreastAB)
        endif
        SetToggleOptionValue(menu,self.bBreastEnable)
    endif
    
    return
EndEvent

; Slider Options ;

Event OnOptionSliderOpen(int menu)
    float val
    float min
    float max
    float interval
    float default
    
    if(menu == MenuSliderA) ; voice volume
        val = self.fVoiceVolume
        min = 0.0
        max = 1.0
        interval = 0.05
        default = 1.0
    elseif(menu == MenuSliderB) ; max belly size
        val = self.fMaxSize
        min = 0.0
        max = 20.0
        interval = 0.1
        default = 10.0
    elseif(menu == MenuSliderC) ; min breast size
        val = self.fBreastMin
        min = 0.0
        max = 20.0
        interval = 0.05
        default = 1.0
    elseif(menu == MenuSliderD) ; max breast size
        val = self.fBreastMax
        min = 0.0
        max = 20.0
        interval = 0.05
        default = 4.0
    elseif(menu == MenuSliderE) ; breast growth rate
        val = self.fBreastRate
        min = 0.0
        max = 5.0
        interval = 0.1
        default = 1.0
	elseif(menu == MenuSliderF) ; breast shrink rate
        val = self.fBreastRate2
        min = 0.0
        max = 5.0
        interval = 0.1
        default = 0.5
	elseif(menu == MenuSliderG) ; belly multiplier
        val = self.fBellyScaleMult
        min = 0.1
        max = 2.0
        interval = 0.1
        default = 1.0
	elseif(menu == MenuSliderM) ; belly multiplier
        val = EggFactoryMilkRate.GetValue()
        min = 0
        max = 100
        interval = 1
        default = 20
	elseif(menu == SliderBirdSpeed)
		val = EggFactorySpeedB.GetValue()
		min = 0.0
		max = 5.0
		interval = 0.1
		default = 1.0
	elseif(menu == SliderSpiderSpeed)
		val = EggFactorySpeedS.GetValue()
		min = 0.0
		max = 5.0
		interval = 0.1
		default = 3.0
	elseif(menu == SliderChaSpeed)
		val = EggFactorySpeedC.GetValue()
		min = 0.0
		max = 5.0
		interval = 0.1
		default = 5.0
	elseif(menu == SliderLargeSpeed)
		val = EggFactorySpeedL.GetValue()
		min = 0.0
		max = 5.0
		interval = 0.1
		default = 0.8
	elseif(menu == SliderDragonSpeed)
		val = EggFactorySpeedH.GetValue()
		min = 0.0
		max = 5.0
		interval = 0.1
		default = 0.1
	elseif(menu == SliderFishSpeed)
		val = EggFactorySpeedF.GetValue()
		min = 0.0
		max = 5.0
		interval = 0.1
		default = 0.4
	elseif(menu == SliderBirdTwins)
		val = EggFactoryTwinsB.GetValue()
		min = 0.0
		max = 50.0
		interval = 1.0
		default = 5.0
	elseif(menu == SliderChaTwins)
		val = EggFactoryTwinsC.GetValue()
		min = 0.0
		max = 50.0
		interval = 1.0
		default = 10.0
	elseif(menu == SliderFishTwins)
		val = EggFactoryTwinsF.GetValue()
		min = 0.0
		max = 50.0
		interval = 1.0
		default = 1.0
	elseif(menu == SliderDragonTwins)
		val = EggFactoryTwinsH.GetValue()
		min = 0.0
		max = 50.0
		interval = 1.0
		default = 20.0
	elseif(menu == SliderLargeTwins)
		val = EggFactoryTwinsL.GetValue()
		min = 0.0
		max = 50.0
		interval = 1.0
		default = 25.0
	elseif(menu == SliderSpiderTwins)
		val = EggFactoryTwinsS.GetValue()
		min = 0.0
		max = 50.0
		interval = 1.0
		default = 10.0
	elseif(menu == SliderBirdExtra)
		val = EggFactoryExtraB.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 0.0
	elseif(menu == SliderBirdWater)
		val = EggFactoryWaterB.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 0.0
	elseif(menu == SliderBirdSkip)
		val = EggFactorySkipB.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 0.0
	elseif(menu == SliderSpiderExtra)
		val = EggFactoryExtraS.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 0.0
	elseif(menu == SliderSpiderWater)
		val = EggFactoryWaterS.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 0.0
	elseif(menu == SliderSpiderSkip)
		val = EggFactorySkipS.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 0.0
	elseif(menu == SliderFishExtra)
		val = EggFactoryExtraF.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 0.0
	elseif(menu == SliderFishWater)
		val = EggFactoryWaterF.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 30.0
	elseif(menu == SliderSpiderSkip)
		val = EggFactorySkipS.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 0.0
    elseif(menu == SliderFishSkip)
		val = EggFactorySkipF.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 0.0
	elseif(menu == SliderLargeExtra)
		val = EggFactoryExtraL.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 25.0
	elseif(menu == SliderLargeWater)
		val = EggFactoryWaterL.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 0.0
	elseif(menu == SliderLargeSkip)
		val = EggFactorySkipL.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 0.0
	elseif(menu == SliderChaExtra)
		val = EggFactoryExtraC.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 0.0
	elseif(menu == SliderChaWater)
		val = EggFactoryWaterC.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 0.0
	elseif(menu == SliderChaSkip)
		val = EggFactorySkipC.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 0.0
	elseif(menu == SliderDragonExtra)
		val = EggFactoryExtraH.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 0.0
	elseif(menu == SliderDragonWater)
		val = EggFactoryWaterH.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 0.0
	elseif(menu == SliderDragonSkip)
		val = EggFactorySkipH.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 0.0
	elseif(menu == SliderBirdDif)
		val = EggFactoryDifB.GetValue()
		min = 0.0
		max = 5.0
		interval = 1.0
		default = 2.0
    elseif(menu == SliderSpiderDif)
		val = EggFactoryDifS.GetValue()
		min = 0.0
		max = 5.0
		interval = 1.0
		default = 2.0
	elseif(menu == SliderChaDif)
		val = EggFactoryDifC.GetValue()
		min = 0.0
		max = 5.0
		interval = 1.0
		default = 3.0
    elseif(menu == SliderLargeDif)
		val = EggFactoryDifL.GetValue()
		min = 0.0
		max = 5.0
		interval = 1.0
		default = 4.0
    elseif(menu == SliderFishDif)
		val = EggFactoryDifF.GetValue()
		min = 0.0
		max = 5.0
		interval = 1.0
		default = 1.0
    elseif(menu == SliderDragonDif)
		val = EggFactoryDifH.GetValue()
		min = 0.0
		max = 5.0
		interval = 1.0
		default = 5.0
    elseif(menu == SliderBirdChance)
		val = EggFactoryChanceB.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 10.0    
    elseif(menu == SliderChaChance)
		val = EggFactoryChanceC.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 20.0    
    elseif(menu == SliderSpiderChance)
		val = EggFactoryChanceS.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 20.0    
    elseif(menu == SliderFishChance)
		val = EggFactoryChanceF.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 15.0
    elseif(menu == SliderLargeChance)
		val = EggFactoryChanceL.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 20.0    
    elseif(menu == SliderDragonChance)
		val = EggFactoryChanceH.GetValue()
		min = 0.0
		max = 100.0
		interval = 1.0
		default = 25.0
    elseif(menu == SliderMultiLimit)
		val = EggFactoryMultiLimit.GetValue()
		min = 0.0
		max = 12.0
		interval = 1.0
		default = 1.0
    endif
    
    SetSliderDialogStartValue(val)
    SetSliderDialogRange(min,max)
    SetSliderDialogInterval(interval)
    SetSliderDialogDefaultValue(default)
    
    return
EndEvent

Event OnOptionSliderAccept(int menu, float val)

    if (menu == MenuSliderA) ; voice volume
        self.fVoiceVolume = val
        SetSliderOptionValue(menu,self.fVoiceVolume,"{2}")
        EggFactoryVoiceVolume.SetValue(val)
    elseif (menu == MenuSliderB) ; belly max size
        self.fMaxSize = val
        SetSliderOptionValue(menu,self.fMaxSize,"{2}")
        EggFactoryMaxScale.SetValue(val)
    elseif (menu == MenuSliderC) ; breast min size
        self.fBreastMin = val
        SetSliderOptionValue(menu,self.fBreastMin,"{2}")
        EggFactoryBreastMin.SetValue(val)
    elseif (menu == MenuSliderD) ; breast max size
        self.fBreastMax = val
        SetSliderOptionValue(menu,self.fBreastMax,"{2}")
        EggFactoryBreastMax.SetValue(val)
	elseif (menu == MenuSliderE) ; breast growth rate
        self.fBreastRate = val
        SetSliderOptionValue(menu,self.fBreastRate,"{2}")
        EggFactoryBreastRate.SetValue(val)
		SendModEvent("EggFactory_ConfigChange")
	elseif (menu == MenuSliderF) ; breast shrink rate
        self.fBreastRate2 = val
        SetSliderOptionValue(menu,self.fBreastRate2,"{2}")
        EggFactoryBreastRate2.SetValue(val)
		SendModEvent("EggFactory_ConfigChange")
	elseif (menu == MenuSliderG) ; belly scale mult
        self.fBellyScaleMult = val
        SetSliderOptionValue(menu,self.fBellyScaleMult,"{2}")
        EggFactoryBellyMult.SetValue(val)
		SendModEvent("EggFactory_ConfigChange")
	elseif (menu == MenuSliderM)
        SetSliderOptionValue(menu,val,"{2}")
        EggFactoryMilkRate.SetValue(val)
	elseif (menu == SliderBirdSpeed)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactorySpeedB.SetValue(val)
	elseif (menu == SliderSpiderSpeed)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactorySpeedS.SetValue(val)
	elseif (menu == SliderChaSpeed)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactorySpeedC.SetValue(val)
	elseif (menu == SliderFishSpeed)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactorySpeedF.SetValue(val)
	elseif (menu == SliderLargeSpeed)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactorySpeedL.SetValue(val)
	elseif (menu == SliderDragonSpeed)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactorySpeedH.SetValue(val)
	elseif (menu == SliderBirdTwins)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryTwinsB.SetValue(val)
	elseif (menu == SliderSpiderTwins)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryTwinsS.SetValue(val)
	elseif (menu == SliderChaTwins)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryTwinsC.SetValue(val)
	elseif (menu == SliderFishTwins)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryTwinsF.SetValue(val)
	elseif (menu == SliderLargeTwins)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryTwinsL.SetValue(val)
	elseif (menu == SliderDragonTwins)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryTwinsH.SetValue(val)
	elseif (menu == SliderBirdExtra)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryExtraB.SetValue(val)
	elseif (menu == SliderBirdWater)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryWaterB.SetValue(val)
	elseif (menu == SliderBirdSkip)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactorySkipB.SetValue(val)
	elseif (menu == SliderSpiderExtra)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryExtraS.SetValue(val)
	elseif (menu == SliderSpiderWater)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryWaterS.SetValue(val)
	elseif (menu == SliderSpiderSkip)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactorySkipS.SetValue(val)
	elseif (menu == SliderFishExtra)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryExtraF.SetValue(val)
	elseif (menu == SliderFishWater)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryWaterF.SetValue(val)
	elseif (menu == SliderFishSkip)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactorySkipF.SetValue(val)
	elseif (menu == SliderLargeExtra)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryExtraL.SetValue(val)
	elseif (menu == SliderLargeWater)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryWaterL.SetValue(val)
	elseif (menu == SliderLargeSkip)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactorySkipL.SetValue(val)
	elseif (menu == SliderChaExtra)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryExtraC.SetValue(val)
	elseif (menu == SliderChaWater)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryWaterC.SetValue(val)
	elseif (menu == SliderChaSkip)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactorySkipC.SetValue(val)
	elseif (menu == SliderDragonExtra)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryExtraH.SetValue(val)
	elseif (menu == SliderDragonWater)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryWaterH.SetValue(val)
	elseif (menu == SliderDragonSkip)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactorySkipH.SetValue(val)
	elseif (menu == SliderBirdDif)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryDifB.SetValue(val)
	elseif (menu == SliderSpiderDif)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryDifS.SetValue(val)
	elseif (menu == SliderChaDif)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryDifC.SetValue(val)
	elseif (menu == SliderFishDif)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryDifF.SetValue(val)
	elseif (menu == SliderLargeDif)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryDifL.SetValue(val)
	elseif (menu == SliderDragonDif)
		SetSliderOptionValue(menu,val,"{2}")
		EggFactoryDifH.SetValue(val)
    elseif (menu == SliderBirdChance)
    	SetSliderOptionValue(menu,val,"{2}")
        EggFactoryChanceB.SetValue(val)
    elseif (menu == SliderFishChance)
    	SetSliderOptionValue(menu,val,"{2}")
        EggFactoryChanceF.SetValue(val)
    elseif (menu == SliderChaChance)
    	SetSliderOptionValue(menu,val,"{2}")
        EggFactoryChanceC.SetValue(val)
    elseif (menu == SliderLargeChance)
    	SetSliderOptionValue(menu,val,"{2}")
        EggFactoryChanceL.SetValue(val)
        EggFactoryChanceLinvert.SetValue(100-val)
    elseif (menu == SliderDragonChance)
    	SetSliderOptionValue(menu,val,"{2}")
        EggFactoryChanceH.SetValue(val)
        EggFactoryChanceHinvert.SetValue(100-val)
    elseif (menu == SliderSpiderChance)
    	SetSliderOptionValue(menu,val,"{2}")
        EggFactoryChanceS.SetValue(val)
        EggFactoryChanceSinvert.SetValue(100-val)
    elseif (menu == SliderMultiLimit)
    	SetSliderOptionValue(menu,val,"{2}")
        EggFactoryMultiLimit.setvalue(val)
    endif
	
	SendChangeEvent()

    return
EndEvent

; Option Descriptions ;

Event OnOptionHighlight(int menu)

    if menu == MenuEggFactoryUninstall
        if( self.bEggFactoryUninstall == false )
            SetInfoText("Uninstall the mod.")
        else
            SetInfoText("Reactivate the mod.")
        endif
    elseif menu == MenuMalePreg
        SetInfoText("Toggle curse to affect male characters.")
    elseif menu == MenuFirstPerson
        SetInfoText("Toggle player character messages to display as first person.")
    elseif menu == MenuBleedOut
        SetInfoText("Toggle whether or not to play the 'bleedout' animation before laying.")
    elseif menu == MenuDismount
        SetInfoText("Toggle whether or not to dismount before preparing to lay.")
    elseif menu == MenuUniqueVoice
        SetInfoText("Toggle whether or not the player character has a unique voice from NPCs.")
	elseif menu == MenuShuffleMode
		SetInfoText("If enabled, non-dragon pregnancies will change egg type after each delivery.")
    elseif menu == MenuSliderA
        SetInfoText("Volume of labor voice effects.")
    elseif menu == MenuSliderB
        SetInfoText("Maximum size of the belly node.")
    elseif menu == MenuModVersion
        SetInfoText("The current version of the mod.")
    elseif menu == MenuSKSEVersion
        SetInfoText("Requires at least SKSE version 1.7.1.")
    elseif menu == MenuBellyNode
        SetInfoText("The player character's skeleton has an 'NPC Belly' node.")
    elseif menu == MenuSliderC
        SetInfoText("Breast size before pregnancy.")
    elseif menu == MenuSliderD
        SetInfoText("Maximum breast size.")
    elseif menu == MenuSliderE
        SetInfoText("Breast size gain rate.")
	elseif menu == MenuSliderF
        SetInfoText("Breast size loss rate.")
	elseif menu == MenuSliderF
        SetInfoText("Belly scale multiplier.")
	elseif menu == MenuSliderM
        SetInfoText("Milk production rate. 100% = 1 bottle per hour.")
	elseif menu == MenuMilkHF
        SetInfoText("Breasts grow and lactate regardless of pregnancy.")
    elseif menu == MenuBreastEnable
        SetInfoText("Toggle breast growth effects.")
    elseif menu == MenuBellyType0
        SetInfoText("Disable belly scaling.")
    elseif menu == MenuBellyType1
        SetInfoText("Scale belly using NetImmerse Override framework.")
    elseif menu == MenuBellyType2
        SetInfoText("Scale belly using racemenu morphs.")
    elseif menu == MenuBellyType3
        SetInfoText("Scale belly using Sexlab Inflation Framework.")
    elseif menu == MenuBreastType0
        SetInfoText("Disable breast scaling.")
    elseif menu == MenuBreastType1
        SetInfoText("Scale breasts using NetImmerse Override framework.")
    elseif menu == MenuBreastType2
        SetInfoText("Scale breasts using racemenu morphs.")
    elseif menu == MenuBreastType3
        SetInfoText("Scale breasts using Sexlab Inflation Framework.")
	elseif(menu == SliderBirdSpeed || menu == SliderChaSpeed || menu == SliderFishSpeed || menu == SliderDragonSpeed || menu == SliderLargeSpeed || menu == SliderSpiderSpeed)
        SetInfoText("Gestation rate. 1.0 = 3 day pregnancy.")
	elseif(menu == SliderBirdTwins || menu == SliderChaTwins || menu == SliderFishTwins || menu == SliderDragonTwins || menu == SliderLargeTwins || menu == SliderSpiderTwins)
		SetInfoText("Percentage chance of twin pregnancy.")
	elseif(menu == SliderBirdSkip || menu == SliderChaSkip || menu == SliderFishSkip || menu == SliderDragonSkip || menu == SliderLargeSkip || menu == SliderSpiderSkip)
		SetInfoText("Skip roughly this percentage of pregnancy.")
	elseif(menu == SliderBirdExtra || menu == SliderChaExtra || menu == SliderFishExtra || menu == SliderDragonExtra || menu == SliderLargeExtra || menu == SliderSpiderExtra)
		SetInfoText("Percentage chance for a rapid pregnancy after a normal delivery.")
	elseif(menu == SliderBirdWater || menu == SliderChaWater || menu == SliderFishWater || menu == SliderDragonWater || menu == SliderLargeWater || menu == SliderSpiderWater)
		SetInfoText("Grow up to this percentage of pregnancy while swimming.")
	elseif(menu == SliderBirdDif || menu == SliderChaDif || menu == SliderFishDif || menu == SliderDragonDif || menu == SliderLargeDif || menu == SliderSpiderDif)
		SetInfoText("How long and intense a labor is required to deliver this egg type.")
    elseif(menu == SliderBirdChance || menu ==  SliderChaChance || menu == SliderfishChance)
        SetInfoText("Chance of finding a cursed egg when harvesting a nest.")
    elseif(menu == SliderSpiderChance)
        SetInfoText("Chance of find a cursed egg in an egg sac.")
    elseif(menu == SliderDragonChance)
        SetInfoText("Chance of find a cursed egg on a slain dragon.")
    elseif(menu == SliderLargeChance)
        SetInfoText("Chance of find a cursed egg in a boss chest.")
    elseif(menu == MenuRespawnFix)
        SetInfoText("Fix an engine bug related to nest respawns.")
    elseif(Menu == SliderMultiLimit)
        SetInfoText("Number of simultaneous pregnancies and actor may have.")
	else
        SetInfoText("Egg Factory")
    endif

    return
EndEvent

; Title Page ;

Function ShowPageIntro()
    ; Initialize the size of the image and center it on the menu.
    int img_width = 400
    int img_height = 400
    int x_offset = (376 - (img_width / 2))
    int y_offset = (223 - (img_height / 2))
    LoadCustomContent("eggfactory/splash.swf", x_offset, y_offset)
    
    return
EndFunction

; Main Menu ;

int MenuEggFactoryUninstall
int MenuMalePreg
int MenuFirstPerson
int MenuBleedout
int MenuDismount
int MenuUniqueVoice
int MenuSliderA
int MenuSliderB
int MenuSliderC
int MenuSliderD
int MenuSliderE
int MenuSliderF
int MenuSliderG
int MenuSliderM
int MenuBreastEnable
int MenuShuffleMode
int MenuMilkBAMD
int MenuMilkHF
int MenuBellyType0
int MenuBellyType1
int MenuBellyType2
int MenuBellyType3
int MenuRespawnFix
int MenuBreastType0
int MenuBreastType1
int MenuBreastType2
int MenuBreastType3
int SliderMultiLimit

Function ShowPageGeneral()
    SetTitleText("General Options")
    SetCursorFillMode(TOP_TO_BOTTOM)

    SetCursorPosition(0)
    AddHeaderOption("Basic Options")
    MenuSliderA = AddSliderOption("Voice Volume",self.fVoiceVolume,"{2}")
	MenuSliderG = AddSliderOption("Belly Scale Multiplier",self.fBellyScaleMult,"{2}")
    MenuSliderB = AddSliderOption("Maximum Belly Size",self.fMaxsize,"{2}")
    MenuMalePreg = AddToggleOption("Enable Males",self.bMalePreg)
    MenuShuffleMode = AddToggleOption("Shuffle Mode",self.bShuffleMode)
    
    AddEmptyOption()
    
    AddHeaderOption("Customization Options")
    MenuFirstPerson = AddToggleOption("First Person Messages",self.bFirstPerson)
    MenuBleedout = AddToggleOption("Alternate Animation",self.bBleedOut)
    MenuDismount = AddToggleOption("Enable Dismount",self.bDismount)
    MenuRespawnFix = AddToggleOption("Fix Nest Respawn Bug",self.bRespawnFix)
	
;	AddEmptyOption()
	
    SetCursorPosition(1)
    AddHeaderOption("Belly Scale Type")
    MenuBellyType0 = AddToggleOption("No Scaling",(self.BellyScaleType==0))
    MenuBellyType1 = AddToggleOption("NIO",(self.BellyScaleType==1))
    MenuBellyType2 = AddToggleOption("Racemenu",(self.BellyScaleType==2))
    MenuBellyType3 = AddToggleOption("SLIF",(self.BellyScaleType==3))
    
    AddEmptyOption()
    AddEmptyOption()

    AddHeaderOption("Other Options")
    SliderMultiLimit = AddSliderOption("Pregnancy Limit",EggFactoryMultiLimit.GetValue(),"{2}")

    return
EndFunction

Function ShowPageMilk()
    SetTitleText("Lactation Options")
	SetCursorFillMode(TOP_TO_BOTTOM)
	
    AddHeaderOption("Growth and Lactation Options")
    MenuBreastEnable = AddToggleOption("Enable Breast Growth",self.bBreastEnable)
    MenuSliderC = AddSliderOption("Minimum Breast Size",self.fBreastMin,"{2}")
    MenuSliderD = AddSliderOption("Maximum Breast Size",self.fBreastMax,"{2}")
    MenuSliderE = AddSliderOption("Breast Growth Rate",self.fBreastRate,"{2}")
	MenuSliderF = AddSliderOption("Breast Shrink Rate",self.fBreastRate2,"{2}")
	MenuSliderM = AddSliderOption("Milk Production Rate",EggFactoryMilkRate.GetValue(),"{2}")
	MenuMilkHF = AddToggleOption("Milkmaid Mode",self.bMilkHF)

    SetCursorPosition(1)
    AddHeaderOption("Breast Scale Type")
    MenuBreastType0 = AddToggleOption("No Scaling",(self.BreastScaleType==0))
    MenuBreastType1 = AddToggleOption("NIO",(self.BreastScaleType==1))
    MenuBreastType2 = AddToggleOption("Racemenu",(self.BreastScaleType==2), OPTION_FLAG_DISABLED)
    MenuBreastType3 = AddToggleOption("SLIF",(self.BreastScaleType==3))
	
EndFunction

int SliderBirdSpeed
int SliderBirdTwins
int SliderBirdSkip
int SliderBirdWater
int SliderBirdExtra
int SliderBirdDif
int SliderBirdchance

int SliderSpiderSpeed
int SliderSpiderTwins
int SliderSpiderSkip
int SliderSpiderWater
int SliderSpiderExtra
int SliderSpiderDif
int SliderSpiderchance

int SliderFishSpeed
int SliderFishTwins
int SliderFishSkip
int SliderFishWater
int SliderFishExtra
int sliderFishDif
int SliderFishChance

int SliderLargeSpeed
int SliderLargeTwins
int SliderLargeSkip
int SliderLargeWater
int SliderLargeExtra
int SliderLargeDif
int SliderLargeChance

int SliderChaSpeed
int SliderChaTwins
int SliderChaSkip
int SliderChaWater
int SliderChaExtra
int SliderChaDif
int SliderChaChance

int SliderDragonSpeed
int SliderDragonTwins
int SliderDragonSkip
int SliderDragonWater
int SliderDragonExtra
int SliderDragonDif
int SliderDragonChance

Function ShowPageBird()
	SetTitleText("Bird Egg Options")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	
	SliderBirdSpeed = AddSliderOption("Gestation Speed",EggFactorySpeedB.GetValue(),"{2}")
	SliderBirdTwins = AddSliderOption("Twin Chance",EggFactoryTwinsB.GetValue(),"{2}")
	SliderBirdExtra = AddSliderOption("Extra Clutch Chance",EggFactoryExtraB.GetValue(),"{2}")
	SliderBirdWater = AddSliderOption("Water Rapid Growth Max",EggFactoryWaterB.GetValue(),"{2}")
	SliderBirdSkip  = AddSliderOption("Skip Early Stages",EggFactorySkipB.GetValue(),"{2}")
	SliderBirdDif   = AddSliderOption("Labor Difficulty",EggFactoryDifB.GetValue(),"{2}")
    SliderBirdChance= AddSliderOption("Cursed Egg Chance",EggFactoryChanceB.GetValue(),"{2}")
	
EndFunction

Function ShowPageSpider()
	SetTitleText("Spider Egg Options")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	
	SliderSpiderSpeed = AddSliderOption("Gestation Speed",EggFactorySpeedS.GetValue(),"{2}")
	SliderSpiderTwins = AddSliderOption("Twin Chance",EggFactoryTwinsS.GetValue(),"{2}")
	SliderSpiderExtra = AddSliderOption("Extra Clutch Chance",EggFactoryExtraS.GetValue(),"{2}")
	SliderSpiderWater = AddSliderOption("Water Rapid Growth Max",EggFactoryWaterS.GetValue(),"{2}")
	SliderSpiderSkip  = AddSliderOption("Skip Early Stages",EggFactorySkipS.GetValue(),"{2}")
	SliderSpiderDif   = AddSliderOption("Labor Difficulty",EggFactoryDifS.GetValue(),"{2}")	
    SliderSpiderChance= AddSliderOption("Cursed Egg Chance",EggFactoryChanceS.GetValue(),"{2}")
	
EndFunction

Function ShowPageFish()
	SetTitleText("Fish Egg Options")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	
	SliderFishSpeed = AddSliderOption("Gestation Speed",EggFactorySpeedF.GetValue(),"{2}")
	SliderFishTwins = AddSliderOption("Twin Chance",EggFactoryTwinsF.GetValue(),"{2}")
	SliderFishExtra = AddSliderOption("Extra Clutch Chance",EggFactoryExtraF.GetValue(),"{2}")
	SliderFishWater = AddSliderOption("Water Rapid Growth Max",EggFactoryWaterF.GetValue(),"{2}")
	SliderFishSkip  = AddSliderOption("Skip Early Stages",EggFactorySkipF.GetValue(),"{2}")
	SliderFishDif   = AddSliderOption("Labor Difficulty",EggFactoryDifF.GetValue(),"{2}")
	SliderFishChance= AddSliderOption("Cursed Egg Chance",EggFactoryChanceF.GetValue(),"{2}")
    
EndFunction

Function ShowPageLarge()
	SetTitleText("Large Bird Egg Options")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	
	SliderLargeSpeed = AddSliderOption("Gestation Speed",EggFactorySpeedL.GetValue(),"{2}")
	SliderLargeTwins = AddSliderOption("Twin Chance",EggFactoryTwinsL.GetValue(),"{2}")
	SliderLargeExtra = AddSliderOption("Extra Clutch Chance",EggFactoryExtraL.GetValue(),"{2}")
	SliderLargeWater = AddSliderOption("Water Rapid Growth Max",EggFactoryWaterL.GetValue(),"{2}")
	SliderLargeSkip  = AddSliderOption("Skip Early Stages",EggFactorySkipL.GetValue(),"{2}")
	SliderLargeDif   = AddSliderOption("Labor Difficulty",EggFactoryDifL.GetValue(),"{2}")
	SliderLargeChance= AddSliderOption("Cursed Egg Chance",EggFactoryChanceL.GetValue(),"{2}")
EndFunction

Function ShowPageCha()
	SetTitleText("Chauras Egg Options")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	
	SliderChaSpeed = AddSliderOption("Gestation Speed",EggFactorySpeedC.GetValue(),"{2}")
	SliderChaTwins = AddSliderOption("Twin Chance",EggFactoryTwinsC.GetValue(),"{2}")
	SliderChaExtra = AddSliderOption("Extra Clutch Chance",EggFactoryExtraC.GetValue(),"{2}")
	SliderChaWater = AddSliderOption("Water Rapid Growth Max",EggFactoryWaterC.GetValue(),"{2}")
	SliderChaSkip  = AddSliderOption("Skip Early Stages",EggFactorySkipC.GetValue(),"{2}")
	SliderchaDif   = AddSliderOption("Labor Difficulty",EggFactoryDifC.GetValue(),"{2}")
	SliderChaChance= AddSliderOption("Cursed Egg Chance",EggFactoryChanceC.GetValue(),"{2}")
EndFunction

Function ShowPageDra()
	SetTitleText("Dragon Egg Options")
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)
	
	SliderDragonSpeed = AddSliderOption("Gestation Speed",EggFactorySpeedH.GetValue(),"{2}")
	SliderDragonTwins = AddSliderOption("Twin Chance",EggFactoryTwinsH.GetValue(),"{2}")
	SliderDragonExtra = AddSliderOption("Extra Clutch Chance",EggFactoryExtraH.GetValue(),"{2}")
	SliderDragonWater = AddSliderOption("Water Rapid Growth Rate",EggFactoryWaterH.GetValue(),"{2}")
	SliderDragonSkip  = AddSliderOption("Skip Early Stages",EggFactorySkipH.GetValue(),"{2}")
	SliderDragonDif   = AddSliderOption("Labor Difficulty",EggFactoryDifH.GetValue(),"{2}")
    SliderDragonChance= AddSliderOption("Cursed Egg Chance",EggFactoryChanceH.GetValue(),"{2}")
EndFunction

	
	
; Info Page ;

int MenuModVersion
int MenuSKSEVersion
int MenuBellyNode

String Function GetTwinStr()
	if(EggFactoryTwinCount.GetValue() >= 3)
		return "Quadruplets"
	elseif(EggFactoryTwinCount.GetValue() == 2)
		return "Triplets"
	elseif(EggFactoryTwinCount.GetValue() == 1)
		return "Twins"
	else
		return ""
	endif
	
Endfunction

Function ShowPageMisc()
    SetTitleText("Information")
    SetCursorFillMode(LEFT_TO_RIGHT)
    SetCursorPosition(0)
	
    int PregCounter = Game.GetPlayer().GetFactionRank(EggFactoryCounter)
    if (PregCounter < 0)
        PregCounter = 0
    endif
	
	AddEmptyOption()
    AddEmptyOption()
    
    AddHeaderOption("Total Births")
    AddTextOption (PregCounter, "", OPTION_FLAG_NONE)
 
    AddEmptyOption()
    AddEmptyOption()

    float Belly = NiOverride.GetNodeTransformScale(Game.GetPlayer(), false, True, "NPC Belly", EggFactoryQuest.FHU_MODKEY)
    string bellStr = Belly As string
    AddHeaderOption("Belly Size")
    AddTextOption (Belly as string, "", OPTION_FLAG_NONE)
	
	float Boobs = NiOverride.GetNodeTransformScale(Game.GetPlayer(), false, True, "NPC L Breast", EggFactoryQuest.FHU_MODKEY)
    string boobStr = Boobs As string
    AddHeaderOption("Breast Size")
    AddTextOption (Boobs as string, "", OPTION_FLAG_NONE)
	
    ;Debug.Notification("Belly size"+BellStr)
    
    AddEmptyOption()
	AddEmptyOption()
        
    AddHeaderOption("Version Check")
    AddHeaderOption("")
    MenuModVersion = AddTextOption(ModName + " v" + GetStringVer(CurrentVersion),"", OPTION_FLAG_NONE)
    AddToggleOption("Version OK", (GetVersion() == CurrentVersion), OPTION_FLAG_DISABLED)
    MenuSKSEVersion = AddTextOption("SKSE v" + skseVersionString(),"", OPTION_FLAG_NONE)
    AddToggleOption("Version OK", (skseVersionCompare(1,7,1) >= 0), OPTION_FLAG_DISABLED)
    MenuBellyNode = AddTextOption("Has Belly Node","", OPTION_FLAG_NONE)
    AddToggleOption("NPC Belly", NetImmerse.HasNode(mySelf, "NPC Belly", false), OPTION_FLAG_DISABLED)

    return
EndFunction

Function ShowPageCredits()
    SetTitleText("Credits")
    SetCursorFillMode(LEFT_TO_RIGHT)
    SetCursorPosition(0)
	
    AddHeaderOption("Credits")
    AddHeaderOption("")
    AddTextOption("MorePrinniesDood", "", OPTION_FLAG_NONE)
    AddTextOption(ModName + " Plugin", "", OPTION_FLAG_NONE)
    
    AddTextOption("ZaZ", "", OPTION_FLAG_NONE)
    AddTextOption("Gush Effects", "", OPTION_FLAG_NONE)
    
    AddTextOption("Jacques00", "", OPTION_FLAG_NONE)
    AddTextOption("Large Egg Meshes", "", OPTION_FLAG_NONE)
    
    AddTextOption("MixedupJim", "", OPTION_FLAG_NONE)
    AddTextOption("'Sarah' Sound Effects", "", OPTION_FLAG_NONE)
    
    AddTextOption("darkconsole", "", OPTION_FLAG_NONE)
    AddTextOption("MCM Formatting Help", "", OPTION_FLAG_NONE)
    
    AddTextOption("xp32, Skulltyrant and Groovtama", "", OPTION_FLAG_NONE)
    AddTextOption("XP32 Maximum Skeleton - Extended", "", OPTION_FLAG_NONE)
    
    AddTextOption("Expired", "", OPTION_FLAG_NONE)
    AddTextOption("NetImmerse Override", "", OPTION_FLAG_NONE)
    
    AddTextOption("bluedanieru", "", OPTION_FLAG_NONE)
    AddTextOption("Flora Respawn Fix Code", "", OPTION_FLAG_NONE)
    
    AddTextOption("Narue", "", OPTION_FLAG_NONE)
    AddTextOption("Racemenu Scaling Code", "", OPTION_FLAG_NONE)
    
    AddTextOption("qotsafan", "", OPTION_FLAG_NONE)
    AddTextOption("SLIF Integration Code", "", OPTION_FLAG_NONE)
    
    AddTextOption("SKSE Development Team", "", OPTION_FLAG_NONE)
    AddTextOption("Skyrim Script Extender", "", OPTION_FLAG_NONE)
    
    AddTextOption("SKYUI Development Team", "", OPTION_FLAG_NONE)
    AddTextOption("Mod Configuration Menu", "", OPTION_FLAG_NONE)
    
    AddTextOption("niftools.sourceforge.net", "", OPTION_FLAG_NONE)
    AddTextOption("NifTools | NifSkope", "", OPTION_FLAG_NONE)
    
    AddTextOption("www.creationkit.com", "", OPTION_FLAG_NONE)
    AddTextOption("Creation Kit", "", OPTION_FLAG_NONE)

	return
Endfunction