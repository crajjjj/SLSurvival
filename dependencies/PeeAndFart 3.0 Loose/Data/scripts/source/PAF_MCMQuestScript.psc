Scriptname PAF_MCMQuestScript extends SKI_ConfigBase

PAF_MainQuestScript property PAF_MainQuest auto
PAF_DDQuestScript property PAF_DDQuest auto

int function GetVersion()
	return 283;
endfunction

; Config
int property PAF_ActionKey auto
int property PAF_InfoKey auto
int property PAF_MenuKey auto

bool property PAF_Dirt auto
bool property PAF_PeeToiletPaper auto
bool property PAF_Disable_Fart auto
bool property PAF_Disable_Pee auto
bool property PAF_Disable_Fart_Sex auto
bool property PAF_Disable_Pee_Sex auto

int property PAF_PeeRate auto
int property PAF_PoopRate auto

bool property PAF_Scaling auto

float property PAF_ScalingFactor auto
float property PAF_ButtScalingFactor auto

bool property PAF_Stripping auto
bool property PAF_LimitedStripping auto
bool[] property PAF_StrippingSlots auto
bool property PAF_PlayUndressAnim auto
int property PAF_UndressAnim auto

bool property PAF_PlayerToilet auto
bool property PAF_NPCToilet auto

int property PAF_PeeDuration auto
int property PAF_PoopDuration auto
int property PAF_BathDuration auto
bool property PAF_DiablePlayerNeeds auto

bool property PAF_FacialExpression auto
bool property PAF_AutoLeak auto
bool property PAF_PressureAnimation auto
bool property PAF_LeakAnimation auto
bool property PAF_PlayMoaningSounds auto
bool property PAF_PlayCleanAnimation auto
bool property PAF_GuardPenalty auto
int property PAF_CrimeValue auto
bool property PAF_DiaperPenalty auto
float property PAF_DiaperPenaltyTime auto

bool property PAF_DisablePeeDebuff auto
bool property PAF_DisablePoopDebuff auto
bool property PAF_DisableDirtDebuff auto

bool[] property PAF_Animation_F auto
bool[] property PAF_Animation_M auto

bool[] property PAF_AnimationPoop_F auto
bool[] property PAF_AnimationPoop_M auto

bool property PAF_PlacePuddles auto
bool property PAF_AddSpells auto
bool property PAF_MenuSpell auto

bool property PAF_SexlabIntegration auto
int property PAF_SexlabStagePee auto
int property PAF_SexlabStagePoop auto
int property PAF_SexlabTarget auto

string[] _SexlabTarget
string[] _SexlabPee
string[] _SexlabPoop
string[] _StrippingAnim
string[] _currentAnimations

string property PAF_AnimationF_Pee auto
string property PAF_AnimationF_Fart auto
string property PAF_AnimationF_Both auto

string property PAF_AnimationM_Pee auto
string property PAF_AnimationM_Fart auto
string property PAF_AnimationM_Both auto

string property PAF_AnimationPeeFM_Pee auto
string property PAF_AnimationPeeMF_Pee auto
string property PAF_AnimationPeeMM_Pee auto
string property PAF_AnimationPeeFF_Pee auto

string property PAF_AnimationPeeFM_Fart auto
string property PAF_AnimationPeeMF_Fart auto
string property PAF_AnimationPeeMM_Fart auto
string property PAF_AnimationPeeFF_Fart auto

string property PAF_AnimationPeeFM_Both auto
string property PAF_AnimationPeeMF_Both auto
string property PAF_AnimationPeeMM_Both auto
string property PAF_AnimationPeeFF_Both auto

; OID
int _value_PeeRate
int _value_PoopRate
int _keymap_Action
int _keymap_Info
int _keymap_Menu
int _toggle_Fart
int _toggle_Pee
int _toggle_Fart_Sex
int _toggle_Pee_Sex
int _toggle_Scaling
int _value_ScalingFactor
int _value_ButtScalingFactor
int _toggle_Stripping
int _toggle_PlayUndressAnim
int _menu_UndressAnim
int _toggle_Dirt
int _toggle_Reset
int _toggle_LimitedStrippting
int _toggle_PlayerToilet
int _toggle_NPCToilet
int _toggle_FacialExpressions
int _toggle_AutoLeak
int _toggle_PeeToiletPaper
int _toggle_PressureAnimation
int _toggle_PlayMoaningSounds
int _toggle_PlacePuddles
int _value_SexlabStagePee
int _value_SexlabStagePoop
int _toggle_SexlabIntegration
int _menu_SexlabTarget
int _toggle_PeeDebuff
int _toggle_PoopDebuff
int _toggle_DirtDebuff
int _toggle_PlayerNeeds
int _toggle_LeakAnimation
int _toggle_CleanAnimation
int _toggle_GuardPenalty
int _value_CrimeValue
int _toggle_DiaperPenalty
int _value_DiaperPenaltyTime
int _toggle_AddSpells
int _toggle_AddMenuSpell

int _menu_AnimationFPee
int _menu_AnimationFFart
int _menu_AnimationFBoth


int _menu_AnimationMPee
int _menu_AnimationMFart
int _menu_AnimationMBoth

int _menu_AnimationFFPee
int _menu_AnimationFMPee
int _menu_AnimationMFPee
int _menu_AnimationMMPee

int _menu_AnimationFFFart
int _menu_AnimationFMFart
int _menu_AnimationMFFart
int _menu_AnimationMMFart

int _menu_AnimationFFBoth
int _menu_AnimationFMBoth
int _menu_AnimationMFBoth
int _menu_AnimationMMBoth

int _toggle_Animation_F01
int _toggle_Animation_F02
int _toggle_Animation_F03
int _toggle_Animation_F04
int _toggle_Animation_F05
int _toggle_Animation_F06
int _toggle_Animation_F07
int _toggle_Animation_F08
int _toggle_Animation_F09
int _toggle_Animation_F10
int _toggle_Animation_F11
int _toggle_Animation_F12
int _toggle_Animation_F13
int _toggle_Animation_M01
int _toggle_Animation_M02
int _toggle_Animation_M03
int _toggle_Animation_M04
int _toggle_Animation_M05
int _toggle_Animation_M06
int _toggle_Animation_M07
int _toggle_Animation_M08
int _toggle_Animation_M09
int _toggle_Animation_M10
int _toggle_Animation_M11
int _toggle_Animation_M12

int _toggle_AnimationPoop_F01
int _toggle_AnimationPoop_F02
int _toggle_AnimationPoop_F03
int _toggle_AnimationPoop_F04
int _toggle_AnimationPoop_F05
int _toggle_AnimationPoop_F06
int _toggle_AnimationPoop_F07
int _toggle_AnimationPoop_F08
int _toggle_AnimationPoop_F09
int _toggle_AnimationPoop_F10
int _toggle_AnimationPoop_F11
int _toggle_AnimationPoop_F12
int _toggle_AnimationPoop_F13
int _toggle_AnimationPoop_M01
int _toggle_AnimationPoop_M02
int _toggle_AnimationPoop_M03
int _toggle_AnimationPoop_M04
int _toggle_AnimationPoop_M05
int _toggle_AnimationPoop_M06
int _toggle_AnimationPoop_M07
int _toggle_AnimationPoop_M08
int _toggle_AnimationPoop_M09
int _toggle_AnimationPoop_M10
int _toggle_AnimationPoop_M11
int _toggle_AnimationPoop_M12

int _toggle_Slot30
int _toggle_Slot31
int _toggle_Slot32
int _toggle_Slot33
int _toggle_Slot34
int _toggle_Slot35
int _toggle_Slot36
int _toggle_Slot37
int _toggle_Slot38
int _toggle_Slot39
int _toggle_Slot40
int _toggle_Slot41
int _toggle_Slot42
int _toggle_Slot43
int _toggle_Slot44
int _toggle_Slot45
int _toggle_Slot46
int _toggle_Slot47
int _toggle_Slot48
int _toggle_Slot49
int _toggle_Slot50
int _toggle_Slot51
int _toggle_Slot52
int _toggle_Slot53
int _toggle_Slot54
int _toggle_Slot55
int _toggle_Slot56
int _toggle_Slot57
int _toggle_Slot58
int _toggle_Slot59
int _toggle_Slot60
int _toggle_Slot61
int _toggle_SlotWeapons

; Dependencies
int sexlab_version = 0
int raceMenu_version = 0
string slaveTats_version = "not found"
int zaz_version = 0
string ddx_version = "not found"

Actor property PlayerREF auto

event OnConfigInit()
	ModName = "Pee And Fart"
	SetupMCM()
	SetupPAF()
endevent

function SetupMCM()
	Pages = new string[6]
	Pages[0] = "Mod Status"
	Pages[1] = "Time Settings"
	Pages[2] = "Misc Settings"
	Pages[3] = "Stripping Settings"
	Pages[4] = "Animation Settings"
	Pages[5] = "Tracked Objects"
endfunction

function SetupPAF()
	Debug.Notification("PAF: Starting...")
	CheckDependencies()
	PAF_PeeRate = 4
	PAF_PoopRate = 8
	PAF_DiablePlayerNeeds = false
	PAF_Disable_Fart = false
	PAF_Disable_Pee = false
	PAF_Scaling = false
	PAF_ScalingFactor = 0.75
	PAF_ButtScalingFactor = 0.25
	PAF_Stripping = true
	PAF_Dirt = true
	PAF_ActionKey = 48
	PAF_InfoKey = 49
	PAF_MenuKey = 37
	PAF_StrippingSlots = new bool[33] ;sexlab stripping slots!
	PAF_StrippingSlots[2] = true
	PAF_LimitedStripping = false
	PAF_PlayerToilet = false
	PAF_NPCToilet = false
	PAF_FacialExpression = true
	PAF_PlayUndressAnim = true
	PAF_PlayMoaningSounds = false
	PAF_UndressAnim = 0
	_StrippingAnim = new string[4]
	_StrippingAnim[0] = "1"
	_StrippingAnim[1] = "2"
	_StrippingAnim[2] = "3"
	_StrippingAnim[3] = "4"
	PAF_AutoLeak = true
	PAF_PressureAnimation = true
	PAF_PeeToiletPaper = false
	PAF_PlacePuddles = true
	PAF_Animation_F = new bool[13]
	PAF_Animation_M = new bool[12]
	PAF_AnimationPoop_F = new bool[13]
	PAF_AnimationPoop_M = new bool[12]
	PAF_SexlabIntegration = false
	PAF_DisablePeeDebuff = false
	PAF_DisablePoopDebuff = false
	PAF_DisableDirtDebuff = false
	PAF_PlayCleanAnimation = false
	PAF_SexlabStagePee = 1
	PAF_SexlabStagePoop = 1
	PAF_SexlabTarget = 0
	PAF_LeakAnimation = false
	PAF_LeakAnimation = false
	PAF_PlayCleanAnimation = false
	PAF_GuardPenalty = false
	PAF_AddSpells = false
	PAF_MenuSpell = true
	PAF_CrimeValue = 2000
	PAF_DiaperPenalty = false
	PAF_DiaperPenaltyTime = 12.0
	PAF_Disable_Pee_Sex = false
	PAF_Disable_Fart_Sex = false
	_SexlabTarget = new string[5]
	_SexlabTarget[0] = "Player Only"
	_SexlabTarget[1] = "NPC Only"
	_SexlabTarget[2] = "Everyone"
	_SexlabTarget[3] = "Male Only"
	_SexlabTarget[4] = "Female Only"
	_SexlabPee = new string[4]
	_SexlabPee[2] = "None"
	_SexlabPee[0] = "Female Only"
	_SexlabPee[1] = "Male Only"
	_SexlabPee[2] = "Both"
	_SexlabPoop = new string[4]
	_SexlabPoop[2] = "None"
	_SexlabPoop[0] = "Female Only"
	_SexlabPoop[1] = "Male Only"
	_SexlabPoop[2] = "Both"
	ResetSexlabAnimations()
	EnableAnimations()
	AddMenuSpell()
	PAF_MainQuest.InitPAF()
endfunction

function CheckDependencies()

	zaz_version = zbfUtil.GetVersion()
	sexlab_version = SexLabUtil.GetVersion()
	slaveTats_version = SlaveTats.Version() ; slavetats seems secretive about its integer version number...
	raceMenu_version = NiOverride.GetScriptVersion()
	ddx_version = PAF_DDQuest.GetDDVersion()

endfunction

function EnableAnimations()
	int i = 0
	while (i < 13)
		PAF_Animation_F[i] = true
		PAF_AnimationPoop_F[i] = true
		if (i < 12)
			PAF_Animation_M[i] = true
			PAF_AnimationPoop_M[i] = true
		endif
		i += 1
	endwhile
endfunction

string[] function CreateSexLabAnimList(int actorCount, int male, int female)
	string[] data = new string[128]
	sslBaseAnimation[] anim = PAF_MainQuest.Sexlab.GetAnimationsByType(actorCount, Males = male, Females = female, Aggressive = false)
	int i = 0
	int len = 0
	if (anim.length > 126)
		len = 126
	else
		len = anim.length
	endif
	while i < len
		data[i] = anim[i].Name
		i += 1
	endwhile
	data[i] = "Mitos Female Facedom"
	data[i+1] = "Arrok Blowjob"
	return data
endfunction

function RemoveSpells()
	PAF_MainQuest.PlayerREF.RemoveSpell(PAF_MainQuest.PAF_Spell)
	PAF_MainQuest.PlayerREF.RemoveSpell(PAF_MainQuest.PAF_NPCSpell)
	PAF_MainQuest.PlayerREF.RemoveSpell(PAF_MainQuest.PAF_PeeSpell)
	PAF_MainQuest.PlayerREF.RemoveSpell(PAF_MainQuest.PAF_PoopSpell)
endfunction

function AddSpells()
	PAF_MainQuest.PlayerREF.AddSpell(PAF_MainQuest.PAF_Spell, false)
	PAF_MainQuest.PlayerREF.AddSpell(PAF_MainQuest.PAF_NPCSpell, false)
	PAF_MainQuest.PlayerREF.AddSpell(PAF_MainQuest.PAF_PeeSpell, false)
	PAF_MainQuest.PlayerREF.AddSpell(PAF_MainQuest.PAF_PoopSpell, false)
endfunction

function AddMenuSpell()
	PAF_MainQuest.PlayerREF.AddSpell(PAF_MainQuest.PAF_MenuSpell, false)
endfunction

function RemoveMenuSpell()
	PAF_MainQuest.PlayerREF.RemoveSpell(PAF_MainQuest.PAF_MenuSpell)
endfunction

event OnVersionUpdate(int a_version)

	if (Pages.length < 4)
		SetupMCM()
	endif

	if (a_version >= 200 && CurrentVersion < 200 && CurrentVersion != 0)
		PAF_Animation_F = new bool[9]
		PAF_Animation_M = new bool[8]
		EnableAnimations()
		PAF_ButtScalingFactor = 0.5
		PAF_PlacePuddles = true
		PAF_PlayMoaningSounds = true
		;Debug.Notification("Updating to PAF 2.0")
	endif

	if (a_version >= 210 && CurrentVersion < 210 && CurrentVersion != 0)
		PAF_SexlabIntegration = false
		PAF_SexlabStagePee = 1
		PAF_SexlabStagePoop = 1
		PAF_SexlabTarget = 0
		_SexlabTarget = new string[5]
		_SexlabTarget = new string[5]
		_SexlabTarget[0] = "Player Only"
		_SexlabTarget[1] = "NPC Only"
		_SexlabTarget[2] = "Everyone"
		_SexlabTarget[3] = "Male Only"
		_SexlabTarget[4] = "Female Only"
		;Debug.Notification("Updating to PAF 2.1")
	endif

	if (a_version >= 220 && CurrentVersion < 220)
		PAF_MainQuest.DeinitPAF()
		SetupPAF()
		;Debug.Notification("Updating to PAF 2.2")
	endif

	if (a_version >= 230 && CurrentVersion < 230)

		PAF_MainQuest.PAF_ToiletQuest.PAF_CurrentToiletAlias.ForceRefto(PAF_MainQuest.PAF_ToiletQuest.PAF_DummyNPC)
		PAF_MainQuest.PAF_ToiletQuest.PAF_ToiletUserAlias.ForceRefto(PAF_MainQuest.PAF_ToiletQuest.PAF_DummyNPC)

		;Debug.Notification("Updating to PAF 2.3")
	endif

	if (a_version >= 240 && CurrentVersion < 240)

		PAF_MainQuest.PAF_ToiletQuest.PAF_CurrentToiletAlias.ForceRefto(PAF_MainQuest.PAF_ToiletQuest.PAF_DummyNPC)
		PAF_MainQuest.PAF_ToiletQuest.PAF_ToiletUserAlias.ForceRefto(PAF_MainQuest.PAF_ToiletQuest.PAF_DummyNPC)
		PAF_MainQuest.PAF_NPCQuest.PAF_StayPutAlias.ForceRefTo(PAF_MainQuest.PAF_NPCQuest.PAF_DummyNPC)

		PAF_DisableDirtDebuff = false
		PAF_DisablePeeDebuff = false
		PAF_DisablePoopDebuff = false
		PAF_DiablePlayerNeeds = false

		;Debug.Notification("Updating to PAF 2.4")
	endif

	if (a_version >= 260 && CurrentVersion < 260)
		PAF_LeakAnimation = false
		;Debug.Notification("Updating to PAF 2.6")
	endif

	if (a_version >= 270 && CurrentVersion < 270)
		PAF_LeakAnimation = false
		PAF_Animation_M = new bool[12]
		PAF_Animation_F = new bool[13]
		PAF_AnimationPoop_M = new bool[12]
		PAF_AnimationPoop_F = new bool[13]
		EnableAnimations()
		PAF_PlayCleanAnimation = false
		PAF_GuardPenalty = false
		PAF_AddSpells = false
		PAF_MenuSpell = true
		RemoveSpells()
		AddMenuSpell()
		PAF_CrimeValue = 2000
		PAF_DiaperPenalty = false
		PAF_DiaperPenaltyTime = 12.0
		;Debug.Notification("Updating to PAF 2.7")
	endif

	if (a_version >= 282 && CurrentVersion < 283)
		PAF_Disable_Pee_Sex = false
		PAF_Disable_Fart_Sex = false
		ResetSexlabAnimations()
		Debug.Notification("Updating to PAF 2.8")
	endif
	CheckRND()

endevent

function ResetSexlabAnimations()
		PAF_AnimationM_Pee = "Arrok Male Masturbation"
		PAF_AnimationM_Fart = "Arrok Male Masturbation"
		PAF_AnimationM_Both = "Arrok Male Masturbation"
		PAF_AnimationF_Pee = "Leito Female Masturbation"
		PAF_AnimationF_Fart = "Leito Female Masturbation"
		PAF_AnimationF_Both = "Leito Female Masturbation"
		PAF_AnimationPeeFM_Pee = "Mitos Female Facedom"
		PAF_AnimationPeeMF_Pee = "Arrok 69"
		PAF_AnimationPeeMM_Pee = "Arrok Blowjob"
		PAF_AnimationPeeFF_Pee = "Zyn Licking"
		PAF_AnimationPeeFM_Fart = "Mitos Female Facedom"
		PAF_AnimationPeeMF_Fart = "Mitos Female Facedom"
		PAF_AnimationPeeMM_Fart = "Mitos Female Facedom"
		PAF_AnimationPeeFF_Fart = "Mitos Female Facedom"
		PAF_AnimationPeeFM_Both = "Mitos Female Facedom"
		PAF_AnimationPeeMF_Both = "Mitos Female Facedom"
		PAF_AnimationPeeMM_Both = "Mitos Female Facedom"
		PAF_AnimationPeeFF_Both	= "Mitos Female Facedom"
endfunction

function CheckRND()
	PAF_MainQuest.RND_EmptyBottle01 = Game.GetFormFromFile(0x000043b0, "RealisticNeedsAndDiseases.esp")
	PAF_MainQuest.RND_EmptyBottle02 = Game.GetFormFromFile(0x000043b2, "RealisticNeedsAndDiseases.esp")
	PAF_MainQuest.RND_EmptyBottle03 = Game.GetFormFromFile(0x000043b4, "RealisticNeedsAndDiseases.esp")
endfunction

event OnPageReset(string a_page)

	if (a_page == "Mod Status")
		CheckDependencies()
		AddTextOption("Bladder:", GetNeedState(PAF_MainQuest.PeeState))
		AddEmptyOption()
		if (PAF_Disable_Fart)
			AddTextOption("Bowels:", "Disabled")
		else
			AddTextOption("Bowels:", GetNeedState(PAF_MainQuest.PoopState))
		endif
		AddEmptyOption()
		if (PAF_Dirt)
			AddTextOption("Dirt:", GetDirtState(PAF_MainQuest.DirtState))
		else
			AddTextOption("Dirt:", "Disabled")
		endif
		AddEmptyOption()
		AddEmptyOption()
		AddEmptyOption()
		_toggle_Pee = AddToggleOption("Disable Pee (Survival)", PAF_Disable_Pee)
		_toggle_Pee_Sex = AddToggleOption("Disable Pee (Sex)", PAF_Disable_Pee_Sex)
		_toggle_Fart = AddToggleOption("Disable Poop (Survival)", PAF_Disable_Fart)
		_toggle_Fart_Sex = AddToggleOption("Disable Poop (Sex)", PAF_Disable_Fart_Sex)
		AddEmptyOption()
		AddEmptyOption()
		if (sexlab_version > 1)
			AddTextOption("Sexlab version:", sexlab_version)
		else
			AddTextOption("SexLab version:", "not found", OPTION_FLAG_DISABLED)
		endif
		if (zaz_version > 0)
			AddTextOption("ZAZ version:", zaz_version)
		else
			AddTextOption("ZAZ version:", "not found", OPTION_FLAG_DISABLED)
		endif

		AddTextOption("SlaveTats version:", slaveTats_Version)

		if (raceMenu_version < 1)
			AddTextOption("NiOverride version:", "not found", OPTION_FLAG_DISABLED)
		else
			AddTextOption("NiOverride version:", raceMenu_version)
		endif

		if (ddx_version == "not found")
			AddTextOption("DD Integration:", "not found", OPTION_FLAG_DISABLED)
		else
			AddTextOption("DD Integration:", ddx_version)
		endif
		;AddEmptyOption()
		AddEmptyOption()
		AddEmptyOption()
		AddEmptyOption()
		_toggle_Reset = AddTextOption("Reset", "Click Me!")
	elseif (a_page == "Time Settings")
		AddHeaderOption("Time Settings")
		AddEmptyOption()
		_value_PeeRate = AddSliderOption("Pee Rate", PAF_PeeRate)
		AddEmptyOption()
		_value_PoopRate = AddSliderOption("Poop Rate", PAF_PoopRate)
		AddEmptyOption()
		AddEmptyOption()
		AddEmptyOption()
		AddEmptyOption()
		AddEmptyOption()
		_toggle_PlayerNeeds = AddToggleOption("Disable needs for player", PAF_DiablePlayerNeeds)
	elseif (a_page == "Misc Settings")
		AddHeaderOption("Misc Settings")
		AddHeaderOption("Key Mapping")
		_toggle_PlayerToilet = AddToggleOption("Player used as toilet", PAF_PlayerToilet)
		_keymap_Action = AddKeyMapOption("Action Key", PAF_ActionKey)
		_toggle_NPCToilet = AddToggleOption("NPC use other NPC as toilet", PAF_NPCToilet)
		_keymap_Info = AddKeyMapOption("Info Key", PAF_InfoKey)
		if (slaveTats_Version > 0)
			_toggle_Dirt = AddToggleOption("Enable dirt", PAF_Dirt)
		else
			_toggle_Dirt = AddToggleOption("Enable dirt", false, OPTION_FLAG_DISABLED)
		endif
		_keymap_Menu = AddKeyMapOption("Menu Key", PAF_MenuKey)
		_toggle_FacialExpressions = AddToggleOption("Toggle facial expressions", PAF_FacialExpression)
		AddEmptyOption()
		_toggle_AutoLeak = AddToggleOption("Toggle auto leak", PAF_AutoLeak)
		AddEmptyOption()
		;_toggle_PeeToiletPaper = AddToggleOption("Toiletpaper is needed after peeing", PAF_PeeToiletPaper)
		;AddEmptyOption()
		_toggle_PlayMoaningSounds = AddToggleOption("Moan during pooping", PAF_PlayMoaningSounds)
		AddEmptyOption()
		_toggle_PlacePuddles = AddToggleOption("Place peeing puddles", PAF_PlacePuddles)
		AddEmptyOption()
		_toggle_PeeDebuff = AddToggleOption("Disable bladder debuffs", PAF_DisablePeeDebuff)
		AddEmptyOption()
		_toggle_PoopDebuff = AddToggleOption("Disable bowels debuffs", PAF_DisablePoopDebuff)
		AddEmptyOption()
		_toggle_DirtDebuff = AddToggleOption("Disable dirt debuffs", PAF_DisableDirtDebuff)
		AddEmptyOption()
		_toggle_AddSpells = AddToggleOption("Add spells to control mod", PAF_AddSpells)
		AddEmptyOption()
		_toggle_AddMenuSpell = AddToggleOption("Add menu spell", PAF_MenuSpell)
		AddEmptyOption()
		AddHeaderOption("Crime Settings")
		AddEmptyOption()
		_toggle_GuardPenalty = AddToggleOption("Enable guard penalties", PAF_GuardPenalty)
		AddEmptyOption()
		_value_CrimeValue = AddSliderOption("Bounty value", PAF_CrimeValue)
		AddEmptyOption()
		_toggle_DiaperPenalty = AddToggleOption("Guards force diapers on you", PAF_DiaperPenalty)
		AddEmptyOption()
		_value_DiaperPenaltyTime = AddSliderOption("Diaper force duration (hours)", PAF_DiaperPenaltyTime, "{2}")
		AddEmptyOption()
		AddHeaderOption("Sexlab Integration")
		AddEmptyOption()
		_toggle_SexlabIntegration = AddToggleOption("Pee/Poop in every Sexlab Scene", PAF_SexlabIntegration)
		AddEmptyOption()
		_value_SexlabStagePee = AddSliderOption("Stage to start peeing", PAF_SexlabStagePee)
		AddEmptyOption()
		_value_SexlabStagePoop = AddSliderOption("Stage to start pooping", PAF_SexlabStagePoop)
		AddEmptyOption()
		_menu_SexlabTarget = AddMenuOption("Target Actor", _SexlabTarget[PAF_SexlabTarget])
	elseif (a_page == "Stripping Settings")
		AddHeaderOption("Stripping Settings")
		AddEmptyOption()
		_toggle_Stripping = AddToggleOption("Enable Stripping", PAF_Stripping)
		AddEmptyOption()
		_toggle_LimitedStrippting = AddToggleOption("Limited Stripping", PAF_LimitedStripping)
		AddEmptyOption()
		_toggle_PlayUndressAnim = AddToggleOption("Play undress animations", PAF_PlayUndressAnim)
		_menu_UndressAnim = AddMenuOption("Stripping Animation", _StrippingAnim[PAF_UndressAnim])
		AddHeaderOption("Slots to strip")
		AddEmptyOption()
		_toggle_Slot30 = AddToggleOption("Slot 30 (Head)", PAF_StrippingSlots[0])
		_toggle_Slot31 = AddToggleOption("Slot 31 (Hair)", PAF_StrippingSlots[1])
		_toggle_Slot32 = AddToggleOption("Slot 32 (Body)", PAF_StrippingSlots[2])
		_toggle_Slot33 = AddToggleOption("Slot 33 (Hands)", PAF_StrippingSlots[3])
		_toggle_Slot34 = AddToggleOption("Slot 34 (Forearms)", PAF_StrippingSlots[4])
		_toggle_Slot35 = AddToggleOption("Slot 35 (Amulet)", PAF_StrippingSlots[5])
		_toggle_Slot36 = AddToggleOption("Slot 36 (Ring)", PAF_StrippingSlots[6])
		_toggle_Slot37 = AddToggleOption("Slot 37 (Feet)", PAF_StrippingSlots[7])
		_toggle_Slot38 = AddToggleOption("Slot 38 (Calves)", PAF_StrippingSlots[8])
		_toggle_Slot39 = AddToggleOption("Slot 39 (Shield)", PAF_StrippingSlots[9])
		_toggle_Slot40 = AddToggleOption("Slot 40", PAF_StrippingSlots[10])
		_toggle_Slot41 = AddToggleOption("Slot 41 (LongHair)", PAF_StrippingSlots[10])
		_toggle_Slot42 = AddToggleOption("Slot 42 (Circlet)", PAF_StrippingSlots[12])
		_toggle_Slot43 = AddToggleOption("Slot 43 (Ears)", PAF_StrippingSlots[13])
		_toggle_Slot44 = AddToggleOption("Slot 44", PAF_StrippingSlots[14])
		_toggle_Slot45 = AddToggleOption("Slot 45", PAF_StrippingSlots[15])
		_toggle_Slot46 = AddToggleOption("Slot 46", PAF_StrippingSlots[16])
		_toggle_Slot47 = AddToggleOption("Slot 47", PAF_StrippingSlots[17])
		_toggle_Slot48 = AddToggleOption("Slot 48", PAF_StrippingSlots[18])
		_toggle_Slot49 = AddToggleOption("Slot 49", PAF_StrippingSlots[19])
		_toggle_Slot50 = AddToggleOption("Slot 50", PAF_StrippingSlots[20])
		_toggle_Slot51 = AddToggleOption("Slot 51", PAF_StrippingSlots[21])
		_toggle_Slot52 = AddToggleOption("Slot 52 (Schlong/Diaper)", PAF_StrippingSlots[22])
		_toggle_Slot53 = AddToggleOption("Slot 53", PAF_StrippingSlots[23])
		_toggle_Slot54 = AddToggleOption("Slot 54", PAF_StrippingSlots[24])
		_toggle_Slot55 = AddToggleOption("Slot 55", PAF_StrippingSlots[25])
		_toggle_Slot56 = AddToggleOption("Slot 56", PAF_StrippingSlots[26])
		_toggle_Slot57 = AddToggleOption("Slot 57", PAF_StrippingSlots[27])
		_toggle_Slot58 = AddToggleOption("Slot 58", PAF_StrippingSlots[28])
		_toggle_Slot59 = AddToggleOption("Slot 59", PAF_StrippingSlots[29])
		_toggle_Slot60 = AddToggleOption("Slot 60", PAF_StrippingSlots[30])
		_toggle_Slot61 = AddToggleOption("Slot 61 (FX)", PAF_StrippingSlots[31])
		_toggle_SlotWeapons = AddToggleOption("Weapons", PAF_StrippingSlots[32])
	elseif (a_page == "Animation Settings")
		AddHeaderOption("Scaling Settings")
		AddEmptyOption()
		if (raceMenu_version > 0 && !PAF_Disable_Fart)
			_toggle_Scaling = AddToggleOption("Enable Scaling", PAF_Scaling)
			AddEmptyOption()
			_value_ScalingFactor = AddSliderOption("Scaling Factor", PAF_ScalingFactor, "{2}")
			AddEmptyOption()
			_value_ButtScalingFactor = AddSliderOption("Butt Scaling Factor", PAF_ButtScalingFactor, "{2}")
		else
			_toggle_Scaling = AddToggleOption("Enable Scaling", PAF_Scaling, OPTION_FLAG_DISABLED)
			AddEmptyOption()
			_value_ScalingFactor = AddSliderOption("Scaling Factor", PAF_ScalingFactor, "{2}", OPTION_FLAG_DISABLED)
			AddEmptyOption()
			_value_ButtScalingFactor = AddSliderOption("Butt Scaling Factor", PAF_ButtScalingFactor, "{2}", OPTION_FLAG_DISABLED)
		endif
		AddEmptyOption()
		AddHeaderOption("Misc Animation Setting")
		AddEmptyOption()
		_toggle_PressureAnimation = AddToggleOption("Enable pressure animations", PAF_PressureAnimation)
		AddEmptyOption()
		_toggle_LeakAnimation = AddToggleOption("Enable animations while leaking", PAF_LeakAnimation)
		_toggle_CleanAnimation = AddToggleOption("Enable animation for cleaning yourself", PAF_PlayCleanAnimation)
		AddHeaderOption("Female Animations peeing")
		AddHeaderOption("Male Animations peeing")
		_toggle_Animation_F01 = AddToggleOption("Leito standing 1", PAF_Animation_F[0])
		_toggle_Animation_M01 = AddToggleOption("Leito standing", PAF_Animation_M[0])
		_toggle_Animation_F02 = AddToggleOption("Leito standing 2", PAF_Animation_F[1])
		_toggle_Animation_M02 = AddToggleOption("Arrok standing two handed", PAF_Animation_M[1])
		_toggle_Animation_F03 = AddToggleOption("Leito kneeling", PAF_Animation_F[2])
		_toggle_Animation_M03 = AddToggleOption("Arrok standing one handed", PAF_Animation_M[2])
		_toggle_Animation_F04 = AddToggleOption("Leito squatting", PAF_Animation_F[3])
		_toggle_Animation_M04 = AddToggleOption("ZAZ squatting 1", PAF_Animation_M[3])
		_toggle_Animation_F05 = AddToggleOption("ZAZ squatting arms on legs", PAF_Animation_F[4])
		_toggle_Animation_M05 = AddToggleOption("ZAZ standing one handed left hand", PAF_Animation_M[4])
		_toggle_Animation_F06 = AddToggleOption("ZAZ squatting arms on breast", PAF_Animation_F[5])
		_toggle_Animation_M06 = AddToggleOption("ZAZ standing hand behind back", PAF_Animation_M[5])
		_toggle_Animation_F07 = AddToggleOption("ZAZ standing arms on butt", PAF_Animation_F[6])
		_toggle_Animation_M07 = AddToggleOption("ZAZ standing arms on hips", PAF_Animation_M[6])
		_toggle_Animation_F08 = AddToggleOption("ZAZ standing arms on crotch", PAF_Animation_F[7])
		_toggle_Animation_M08 = AddToggleOption("ZAZ squatting 2", PAF_Animation_M[7])
		_toggle_Animation_F09 = AddToggleOption("ZAZ standing arms on hips", PAF_Animation_F[8])
		_toggle_Animation_M09 = AddToggleOption("PAF Doggystyle", PAF_Animation_M[8])
		_toggle_Animation_F10 = AddToggleOption("PAF Doggystyle", PAF_Animation_F[9])
		_toggle_Animation_M10 = AddToggleOption("ZAZ Doggystyle", PAF_Animation_M[9])
		_toggle_Animation_F11 = AddToggleOption("ZAZ Doggystyle", PAF_Animation_F[10])
		_toggle_Animation_M11 = AddToggleOption("PAF on back", PAF_Animation_M[10])
		_toggle_Animation_F12 = AddToggleOption("PAF on back", PAF_Animation_F[11])
		_toggle_Animation_M12 = AddToggleOption("Leito Bendover", PAF_Animation_M[11])
		_toggle_Animation_F13 = AddToggleOption("Leito Bendover", PAF_Animation_F[12])
		AddEmptyOption()
		AddHeaderOption("Female Animations pooping")
		AddHeaderOption("Male Animations pooping")
		_toggle_AnimationPoop_F01 = AddToggleOption("Leito standing 1", PAF_AnimationPoop_F[0])
		_toggle_AnimationPoop_M01 = AddToggleOption("Leito standing", PAF_AnimationPoop_M[0])
		_toggle_AnimationPoop_F02 = AddToggleOption("Leito standing 2", PAF_AnimationPoop_F[1])
		_toggle_AnimationPoop_M02 = AddToggleOption("Arrok standing two handed", PAF_AnimationPoop_M[1])
		_toggle_AnimationPoop_F03 = AddToggleOption("Leito kneeling", PAF_AnimationPoop_F[2])
		_toggle_AnimationPoop_M03 = AddToggleOption("Arrok standing one handed", PAF_AnimationPoop_M[2])
		_toggle_AnimationPoop_F04 = AddToggleOption("Leito squatting", PAF_AnimationPoop_F[3])
		_toggle_AnimationPoop_M04 = AddToggleOption("ZAZ squatting 1", PAF_AnimationPoop_M[3])
		_toggle_AnimationPoop_F05 = AddToggleOption("ZAZ squatting arms on legs", PAF_AnimationPoop_F[4])
		_toggle_AnimationPoop_M05 = AddToggleOption("ZAZ standing one handed left hand", PAF_AnimationPoop_M[4])
		_toggle_AnimationPoop_F06 = AddToggleOption("ZAZ squatting arms on breast", PAF_AnimationPoop_F[5])
		_toggle_AnimationPoop_M06 = AddToggleOption("ZAZ standing hand behind back", PAF_AnimationPoop_M[5])
		_toggle_AnimationPoop_F07 = AddToggleOption("ZAZ standing arms on butt", PAF_AnimationPoop_F[6])
		_toggle_AnimationPoop_M07 = AddToggleOption("ZAZ standing arms on hips", PAF_AnimationPoop_M[6])
		_toggle_AnimationPoop_F08 = AddToggleOption("ZAZ standing arms on crotch", PAF_AnimationPoop_F[7])
		_toggle_AnimationPoop_M08 = AddToggleOption("ZAZ squatting 2", PAF_AnimationPoop_M[7])
		_toggle_AnimationPoop_F09 = AddToggleOption("ZAZ standing arms on hips", PAF_AnimationPoop_F[8])
		_toggle_AnimationPoop_M09 = AddToggleOption("PAF Doggystyle", PAF_AnimationPoop_M[8])
		_toggle_AnimationPoop_F10 = AddToggleOption("PAF Doggystyle", PAF_AnimationPoop_F[9])
		_toggle_AnimationPoop_M10 = AddToggleOption("ZAZ Doggystyle", PAF_AnimationPoop_M[9])
		_toggle_AnimationPoop_F11 = AddToggleOption("ZAZ Doggystyle", PAF_AnimationPoop_F[10])
		_toggle_AnimationPoop_M11 = AddToggleOption("PAF on back", PAF_AnimationPoop_M[10])
		_toggle_AnimationPoop_F12 = AddToggleOption("PAF on back", PAF_AnimationPoop_F[11])
		_toggle_AnimationPoop_M12 = AddToggleOption("Leito Bendover", PAF_AnimationPoop_M[11])
		_toggle_AnimationPoop_F13 = AddToggleOption("Leito Bendover", PAF_AnimationPoop_F[12])
		AddEmptyOption()
		AddHeaderOption("Sexlab Animations Selection")
		AddEmptyOption()
		AddTextOption("Female Solo Peeing:", "")
		_menu_AnimationFPee = AddMenuOption("", PAF_AnimationF_Pee)
		AddTextOption("Female Solo Pooping:", "")
		_menu_AnimationFFart = AddMenuOption("", PAF_AnimationF_Fart)
		AddTextOption("Female Solo Peeing/Pooping:", "")
		_menu_AnimationFBoth = AddMenuOption("", PAF_AnimationF_Both)
		AddTextOption("Male Solo Peeing:", "")
		_menu_AnimationMPee = AddMenuOption("", PAF_AnimationM_Pee)
		AddTextOption("Male Solo Pooping:", "")
		_menu_AnimationMFart = AddMenuOption("", PAF_AnimationM_Fart)
		AddTextOption("Male Solo Peeing/Pooping:", "")
		_menu_AnimationMBoth = AddMenuOption("", PAF_AnimationM_Both)
		AddTextOption("Female->Female Peeing:", "")
		_menu_AnimationFFPee = AddMenuOption("", PAF_AnimationPeeFF_Pee)
		AddTextOption("Female->Male Peeing:", "")
		_menu_AnimationFMPee = AddMenuOption("", PAF_AnimationPeeFM_Pee)
		AddTextOption("Male->Female Peeing:", "")
		_menu_AnimationMFPee = AddMenuOption("", PAF_AnimationPeeMF_Pee)
		AddTextOption("Male->Male Peeing:", "")
		_menu_AnimationMMPee = AddMenuOption("", PAF_AnimationPeeMM_Pee)
		AddTextOption("Female->Female Pooping:", "")
		_menu_AnimationFFFart = AddMenuOption("", PAF_AnimationPeeFF_Fart)
		AddTextOption("Female->Male Pooping:", "")
		_menu_AnimationFMFart = AddMenuOption("", PAF_AnimationPeeFM_Fart)
		AddTextOption("Male->Female Pooping:", "")
		_menu_AnimationMFFart = AddMenuOption("", PAF_AnimationPeeMF_Fart)
		AddTextOption("Male->Male Pooping:", "")
		_menu_AnimationMMFart = AddMenuOption("", PAF_AnimationPeeMM_Fart)
		AddTextOption("Female->Female Peeing/Pooping:", "")
		_menu_AnimationFFBoth = AddMenuOption("", PAF_AnimationPeeFF_Both)
		AddTextOption("Female->Male Peeing/Pooping:", "")
		_menu_AnimationFMBoth = AddMenuOption("", PAF_AnimationPeeFM_Both)
		AddTextOption("Male->Female Peeing/Pooping:", "")
		_menu_AnimationMFBoth = AddMenuOption("", PAF_AnimationPeeMF_Both)
		AddTextOption("Male->Male Peeing/Pooping:", "")
		_menu_AnimationMMBoth = AddMenuOption("", PAF_AnimationPeeMM_Both)
	elseif (a_page == "Tracked Objects")
		if (PAF_MainQuest.PAF_NPCQuest.PAF_TrackedActors[0] != none)
			AddTextOption("NPC 1:", PAF_MainQuest.PAF_NPCQuest.PAF_TrackedActors[0].GetActorBase().GetName())
			AddTextOption("Needs:", "P: " + PAF_MainQuest.PAF_NPCQuest.NPC_PeeState[0] + " F: " + PAF_MainQuest.PAF_NPCQuest.NPC_PoopState[0] + " D: " + PAF_MainQuest.PAF_NPCQuest.NPC_DirtState[0])
		else
			AddTextOption("NPC 1: ", "No actor selected")
			AddEmptyOption()
		endif
		if (PAF_MainQuest.PAF_NPCQuest.PAF_TrackedActors[1] != none)
			AddTextOption("NPC 2: ", PAF_MainQuest.PAF_NPCQuest.PAF_TrackedActors[1].GetActorBase().GetName())
			AddTextOption("Needs:", "P: " + PAF_MainQuest.PAF_NPCQuest.NPC_PeeState[1] + " F: " + PAF_MainQuest.PAF_NPCQuest.NPC_PoopState[1] + " D: " + PAF_MainQuest.PAF_NPCQuest.NPC_DirtState[1])
		else
			AddTextOption("NPC 2: ", "No actor selected")
			AddEmptyOption()
		endif
		if (PAF_MainQuest.PAF_NPCQuest.PAF_TrackedActors[2] != none)
			AddTextOption("NPC 3: ", PAF_MainQuest.PAF_NPCQuest.PAF_TrackedActors[2].GetActorBase().GetName())
			AddTextOption("Needs:", "P: " + PAF_MainQuest.PAF_NPCQuest.NPC_PeeState[2] + " F: " + PAF_MainQuest.PAF_NPCQuest.NPC_PoopState[2] + " D: " + PAF_MainQuest.PAF_NPCQuest.NPC_DirtState[2])
		else
			AddTextOption("NPC 3: ", "No actor selected")
			AddEmptyOption()
		endif
		if (PAF_MainQuest.PAF_NPCQuest.PAF_TrackedActors[3] != none)
			AddTextOption("NPC 4: ", PAF_MainQuest.PAF_NPCQuest.PAF_TrackedActors[3].GetActorBase().GetName())
			AddTextOption("Needs:", "P: " + PAF_MainQuest.PAF_NPCQuest.NPC_PeeState[3] + " F: " + PAF_MainQuest.PAF_NPCQuest.NPC_PoopState[3] + " D: " + PAF_MainQuest.PAF_NPCQuest.NPC_DirtState[3])
		else
			AddTextOption("NPC 4: ", "No actor selected")
			AddEmptyOption()
		endif
		if (PAF_MainQuest.PAF_NPCQuest.PAF_TrackedActors[4] != none)
			AddTextOption("NPC 5: ", PAF_MainQuest.PAF_NPCQuest.PAF_TrackedActors[4].GetActorBase().GetName())
			AddTextOption("Needs:", "P: " + PAF_MainQuest.PAF_NPCQuest.NPC_PeeState[4] + " F: " + PAF_MainQuest.PAF_NPCQuest.NPC_PoopState[4] + " D: " + PAF_MainQuest.PAF_NPCQuest.NPC_DirtState[4])
		else
			AddTextOption("NPC 5: ", "No actor selected")
			AddEmptyOption()
		endif

		AddEmptyOption()
		AddEmptyOption()
		AddTextOption("Number of toilets:", PAF_MainQuest.PAF_ToiletQuest.PAF_NumberToilets)

	endif
endevent

Event OnOptionSelect(int a_option)
	if (a_option == _toggle_Fart)
		PAF_Disable_Fart = !PAF_Disable_Fart
		SetToggleOptionValue(a_option, PAF_Disable_Fart)
		if (PAF_Disable_Fart)
			PAF_Scaling = false
			SetToggleOptionValue(_toggle_Scaling, false, OPTION_FLAG_DISABLED)
		endif
	elseif (a_option == _toggle_Pee)
		PAF_Disable_Pee = !PAF_Disable_Pee
		SetToggleOptionValue(a_option, PAF_Disable_Pee)
	elseif (a_option == _toggle_Pee_Sex)
		PAF_Disable_Pee_Sex = !PAF_Disable_Pee_Sex
		SetToggleOptionValue(a_option, PAF_Disable_Pee_Sex)
	elseif (a_option == _toggle_Fart_Sex)
		PAF_Disable_Fart_Sex = !PAF_Disable_Fart_Sex
		SetToggleOptionValue(a_option, PAF_Disable_Fart_Sex)
	elseif (a_option == _toggle_Stripping)
		PAF_Stripping = !PAF_Stripping
		SetToggleOptionValue(a_option, PAF_Stripping)
	elseif (a_option == _toggle_PlayerNeeds)
		PAF_DiablePlayerNeeds = !PAF_DiablePlayerNeeds
		SetToggleOptionValue(a_option, PAF_DiablePlayerNeeds)
	elseif (a_option == _toggle_Scaling)
		PAF_Scaling = !PAF_Scaling
		if (!PAF_Scaling)
			NiOverride.AddNodeTransformScale(PlayerREF, false, true, "NPC Belly", "PAF_Belly_Scale", 1)
			NiOverride.UpdateNodeTransform(PlayerREF, false, true, "NPC Belly")
		endif
		SetToggleOptionValue(a_option, PAF_Scaling)
	elseif (a_option == _toggle_LimitedStrippting)
		PAF_LimitedStripping = !PAF_LimitedStripping
		SetToggleOptionValue(a_option, PAF_LimitedStripping)
	elseif (a_option == _toggle_PlayUndressAnim)
		PAF_PlayUndressAnim = !PAF_PlayUndressAnim
		SetToggleOptionValue(a_option, PAF_PlayUndressAnim)
	elseif (a_option == _toggle_LeakAnimation)
		PAF_LeakAnimation = !PAF_LeakAnimation
		SetToggleOptionValue(a_option, PAF_LeakAnimation)
	elseif (a_option == _toggle_PressureAnimation)
		PAF_PressureAnimation = !PAF_PressureAnimation
		SetToggleOptionValue(a_option, PAF_PressureAnimation)
	elseif (a_option == _toggle_CleanAnimation)
		PAF_PlayCleanAnimation = !PAF_PlayCleanAnimation
		SetToggleOptionValue(a_option, PAF_PlayCleanAnimation)
	elseif (a_option == _toggle_GuardPenalty)
		PAF_GuardPenalty = !PAF_GuardPenalty
		SetToggleOptionValue(a_option, PAF_GuardPenalty)
	elseif (a_option == _toggle_DiaperPenalty)
		PAF_DiaperPenalty = !PAF_DiaperPenalty
		SetToggleOptionValue(a_option, PAF_DiaperPenalty)
	elseif (a_option == _toggle_SexlabIntegration)
		PAF_SexlabIntegration = !PAF_SexlabIntegration
		SetToggleOptionValue(a_option, PAF_SexlabIntegration)
		if (PAF_SexlabIntegration)
			PAF_MainQuest.RegisterSexlabHooks()
		else
			PAF_MainQuest.UnregisterSexlabHooks()
		endif
	elseif (a_option == _toggle_Dirt)
		PAF_Dirt = !PAF_Dirt
		if (!PAF_Dirt)
			PAF_MainQuest.DirtState = 0
			PAF_MainQuest.RemoveInvalidOverlay(PAF_MainQuest.PlayerREF, 0)
			SlaveTats.synchronize_tattoos(PlayerREF, silent = true)
		endif
		SetToggleOptionValue(a_option, PAF_Dirt)
	elseif (a_option == _toggle_AddSpells)
		PAF_AddSpells = !PAF_AddSpells
		SetToggleOptionValue(a_option, PAF_AddSpells)
		if (PAF_AddSpells)
			AddSpells()
		else
			RemoveSpells()
		endif
	elseif (a_option == _toggle_AddMenuSpell)
		PAF_MenuSpell = !PAF_MenuSpell
		SetToggleOptionValue(a_option, PAF_MenuSpell)
		if (PAF_MenuSpell)
			AddMenuSpell()
		else
			RemoveMenuSpell()
		endif
	elseif (a_option == _toggle_PlayerToilet)
		PAF_PlayerToilet = !PAF_PlayerToilet
		SetToggleOptionValue(a_option, PAF_PlayerToilet)
	elseif (a_option == _toggle_NPCToilet)
		PAF_NPCToilet = !PAF_NPCToilet
		SetToggleOptionValue(a_option, PAF_NPCToilet)
	elseif (a_option == _toggle_FacialExpressions)
		PAF_FacialExpression = !PAF_FacialExpression
		SetToggleOptionValue(a_option, PAF_FacialExpression)
	elseif (a_option == _toggle_AutoLeak)
		PAF_AutoLeak = !PAF_AutoLeak
		SetToggleOptionValue(a_option, PAF_AutoLeak)
	elseif (a_option == _toggle_PeeToiletPaper)
		PAF_PeeToiletPaper = !PAF_PeeToiletPaper
		SetToggleOptionValue(a_option, PAF_PeeToiletPaper)
	elseif (a_option == _toggle_PlayMoaningSounds)
		PAF_PlayMoaningSounds = !PAF_PlayMoaningSounds
		SetToggleOptionValue(a_option, PAF_PlayMoaningSounds)
	elseif (a_option == _toggle_PlacePuddles)
		PAF_PlacePuddles = !PAF_PlacePuddles
		SetToggleOptionValue(a_option, PAF_PlacePuddles)
	elseif (a_option == _toggle_PeeDebuff)
		PAF_DisablePeeDebuff = !PAF_DisablePeeDebuff
		SetToggleOptionValue(a_option, PAF_DisablePeeDebuff)
	elseif (a_option == _toggle_PoopDebuff)
		PAF_DisablePoopDebuff = !PAF_DisablePoopDebuff
		SetToggleOptionValue(a_option, PAF_DisablePoopDebuff)
	elseif (a_option == _toggle_DirtDebuff)
		PAF_DisableDirtDebuff = !PAF_DisableDirtDebuff
		SetToggleOptionValue(a_option, PAF_DisableDirtDebuff)
	elseif (a_option == _toggle_Reset)
		SetTextOptionValue(a_option, "Resetting... Close Menu!")
		SetOptionFlags(a_option, OPTION_FLAG_DISABLED)
		PAF_MainQuest.DeinitPAF()
		SetupPAF()
	elseif (a_option == _toggle_Animation_F01)
		PAF_Animation_F[0] = !PAF_Animation_F[0]
		SetToggleOptionValue(a_option, PAF_Animation_F[0])
	elseif (a_option == _toggle_Animation_F02)
		PAF_Animation_F[1] = !PAF_Animation_F[1]
		SetToggleOptionValue(a_option, PAF_Animation_F[1])
	elseif (a_option == _toggle_Animation_F03)
		PAF_Animation_F[2] = !PAF_Animation_F[2]
		SetToggleOptionValue(a_option, PAF_Animation_F[2])
	elseif (a_option == _toggle_Animation_F04)
		PAF_Animation_F[3] = !PAF_Animation_F[3]
		SetToggleOptionValue(a_option, PAF_Animation_F[3])
	elseif (a_option == _toggle_Animation_F05)
		PAF_Animation_F[4] = !PAF_Animation_F[4]
		SetToggleOptionValue(a_option, PAF_Animation_F[4])
	elseif (a_option == _toggle_Animation_F06)
		PAF_Animation_F[5] = !PAF_Animation_F[5]
		SetToggleOptionValue(a_option, PAF_Animation_F[5])
	elseif (a_option == _toggle_Animation_F07)
		PAF_Animation_F[6] = !PAF_Animation_F[6]
		SetToggleOptionValue(a_option, PAF_Animation_F[6])
	elseif (a_option == _toggle_Animation_F08)
		PAF_Animation_F[7] = !PAF_Animation_F[7]
		SetToggleOptionValue(a_option, PAF_Animation_F[7])
	elseif (a_option == _toggle_Animation_F09)
		PAF_Animation_F[8] = !PAF_Animation_F[8]
		SetToggleOptionValue(a_option, PAF_Animation_F[8])
	elseif (a_option == _toggle_Animation_F10)
		PAF_Animation_F[9] = !PAF_Animation_F[9]
		SetToggleOptionValue(a_option, PAF_Animation_F[9])
	elseif (a_option == _toggle_Animation_F11)
		PAF_Animation_F[10] = !PAF_Animation_F[10]
		SetToggleOptionValue(a_option, PAF_Animation_F[10])
	elseif (a_option == _toggle_Animation_F12)
		PAF_Animation_F[11] = !PAF_Animation_F[11]
		SetToggleOptionValue(a_option, PAF_Animation_F[11])
	elseif (a_option == _toggle_Animation_F13)
		PAF_Animation_F[12] = !PAF_Animation_F[12]
		SetToggleOptionValue(a_option, PAF_Animation_F[12])
	elseif (a_option == _toggle_Animation_M01)
		PAF_Animation_M[0] = !PAF_Animation_M[0]
		SetToggleOptionValue(a_option, PAF_Animation_M[0])
	elseif (a_option == _toggle_Animation_M02)
		PAF_Animation_M[1] = !PAF_Animation_M[1]
		SetToggleOptionValue(a_option, PAF_Animation_M[1])
	elseif (a_option == _toggle_Animation_M03)
		PAF_Animation_M[2] = !PAF_Animation_M[2]
		SetToggleOptionValue(a_option, PAF_Animation_M[2])
	elseif (a_option == _toggle_Animation_M04)
		PAF_Animation_M[3] = !PAF_Animation_M[3]
		SetToggleOptionValue(a_option, PAF_Animation_M[3])
	elseif (a_option == _toggle_Animation_M05)
		PAF_Animation_M[4] = !PAF_Animation_M[4]
		SetToggleOptionValue(a_option, PAF_Animation_M[4])
	elseif (a_option == _toggle_Animation_M06)
		PAF_Animation_M[5] = !PAF_Animation_M[5]
		SetToggleOptionValue(a_option, PAF_Animation_M[5])
	elseif (a_option == _toggle_Animation_M07)
		PAF_Animation_M[6] = !PAF_Animation_M[6]
		SetToggleOptionValue(a_option, PAF_Animation_M[6])
	elseif (a_option == _toggle_Animation_M08)
		PAF_Animation_M[7] = !PAF_Animation_M[7]
		SetToggleOptionValue(a_option, PAF_Animation_M[7])
	elseif (a_option == _toggle_Animation_M09)
		PAF_Animation_M[8] = !PAF_Animation_M[8]
		SetToggleOptionValue(a_option, PAF_Animation_M[8])
	elseif (a_option == _toggle_Animation_M10)
		PAF_Animation_M[9] = !PAF_Animation_M[9]
		SetToggleOptionValue(a_option, PAF_Animation_M[9])
	elseif (a_option == _toggle_Animation_M11)
		PAF_Animation_M[10] = !PAF_Animation_M[10]
		SetToggleOptionValue(a_option, PAF_Animation_M[10])
	elseif (a_option == _toggle_Animation_M12)
		PAF_Animation_M[11] = !PAF_Animation_M[11]
		SetToggleOptionValue(a_option, PAF_Animation_M[11])
	elseif (a_option == _toggle_AnimationPoop_F01)
		PAF_AnimationPoop_F[0] = !PAF_AnimationPoop_F[0]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_F[0])
	elseif (a_option == _toggle_AnimationPoop_F02)
		PAF_AnimationPoop_F[1] = !PAF_AnimationPoop_F[1]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_F[1])
	elseif (a_option == _toggle_AnimationPoop_F03)
		PAF_AnimationPoop_F[2] = !PAF_AnimationPoop_F[2]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_F[2])
	elseif (a_option == _toggle_AnimationPoop_F04)
		PAF_AnimationPoop_F[3] = !PAF_AnimationPoop_F[3]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_F[3])
	elseif (a_option == _toggle_AnimationPoop_F05)
		PAF_AnimationPoop_F[4] = !PAF_AnimationPoop_F[4]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_F[4])
	elseif (a_option == _toggle_AnimationPoop_F06)
		PAF_AnimationPoop_F[5] = !PAF_AnimationPoop_F[5]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_F[5])
	elseif (a_option == _toggle_AnimationPoop_F07)
		PAF_AnimationPoop_F[6] = !PAF_AnimationPoop_F[6]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_F[6])
	elseif (a_option == _toggle_AnimationPoop_F08)
		PAF_AnimationPoop_F[7] = !PAF_AnimationPoop_F[7]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_F[7])
	elseif (a_option == _toggle_AnimationPoop_F09)
		PAF_AnimationPoop_F[8] = !PAF_AnimationPoop_F[8]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_F[8])
	elseif (a_option == _toggle_AnimationPoop_F10)
		PAF_AnimationPoop_F[9] = !PAF_AnimationPoop_F[9]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_F[9])
	elseif (a_option == _toggle_AnimationPoop_F11)
		PAF_AnimationPoop_F[10] = !PAF_AnimationPoop_F[10]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_F[10])
	elseif (a_option == _toggle_AnimationPoop_F12)
		PAF_AnimationPoop_F[11] = !PAF_AnimationPoop_F[11]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_F[11])
	elseif (a_option == _toggle_AnimationPoop_F13)
		PAF_AnimationPoop_F[12] = !PAF_AnimationPoop_F[12]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_F[12])
	elseif (a_option == _toggle_AnimationPoop_M01)
		PAF_AnimationPoop_M[0] = !PAF_AnimationPoop_M[0]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_M[0])
	elseif (a_option == _toggle_AnimationPoop_M02)
		PAF_AnimationPoop_M[1] = !PAF_AnimationPoop_M[1]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_M[1])
	elseif (a_option == _toggle_AnimationPoop_M03)
		PAF_AnimationPoop_M[2] = !PAF_AnimationPoop_M[2]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_M[2])
	elseif (a_option == _toggle_AnimationPoop_M04)
		PAF_AnimationPoop_M[3] = !PAF_AnimationPoop_M[3]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_M[3])
	elseif (a_option == _toggle_AnimationPoop_M05)
		PAF_AnimationPoop_M[4] = !PAF_AnimationPoop_M[4]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_M[4])
	elseif (a_option == _toggle_AnimationPoop_M06)
		PAF_AnimationPoop_M[5] = !PAF_AnimationPoop_M[5]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_M[5])
	elseif (a_option == _toggle_AnimationPoop_M07)
		PAF_AnimationPoop_M[6] = !PAF_AnimationPoop_M[6]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_M[6])
	elseif (a_option == _toggle_AnimationPoop_M08)
		PAF_AnimationPoop_M[7] = !PAF_AnimationPoop_M[7]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_M[7])
	elseif (a_option == _toggle_AnimationPoop_M09)
		PAF_AnimationPoop_M[8] = !PAF_AnimationPoop_M[8]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_M[8])
	elseif (a_option == _toggle_AnimationPoop_M10)
		PAF_AnimationPoop_M[9] = !PAF_AnimationPoop_M[9]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_M[9])
	elseif (a_option == _toggle_AnimationPoop_M11)
		PAF_AnimationPoop_M[10] = !PAF_AnimationPoop_M[10]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_M[10])
	elseif (a_option == _toggle_AnimationPoop_M12)
		PAF_AnimationPoop_M[11] = !PAF_AnimationPoop_M[11]
		SetToggleOptionValue(a_option, PAF_AnimationPoop_M[11])
	elseif (a_option == _toggle_Slot30)
		PAF_StrippingSlots[0] = !PAF_StrippingSlots[0]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[0])
	elseif (a_option == _toggle_Slot31)
		PAF_StrippingSlots[1] = !PAF_StrippingSlots[1]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[1])
	elseif (a_option == _toggle_Slot32)
		PAF_StrippingSlots[2] = !PAF_StrippingSlots[2]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[2])
	elseif (a_option == _toggle_Slot33)
		PAF_StrippingSlots[3] = !PAF_StrippingSlots[3]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[3])
	elseif (a_option == _toggle_Slot34)
		PAF_StrippingSlots[4] = !PAF_StrippingSlots[4]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[4])
	elseif (a_option == _toggle_Slot35)
		PAF_StrippingSlots[5] = !PAF_StrippingSlots[5]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[5])
	elseif (a_option == _toggle_Slot36)
		PAF_StrippingSlots[6] = !PAF_StrippingSlots[6]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[6])
	elseif (a_option == _toggle_Slot37)
		PAF_StrippingSlots[7] = !PAF_StrippingSlots[7]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[7])
	elseif (a_option == _toggle_Slot38)
		PAF_StrippingSlots[8] = !PAF_StrippingSlots[8]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[8])
	elseif (a_option == _toggle_Slot39)
		PAF_StrippingSlots[9] = !PAF_StrippingSlots[9]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[9])
	elseif (a_option == _toggle_Slot40)
		PAF_StrippingSlots[10] = !PAF_StrippingSlots[10]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[10])
	elseif (a_option == _toggle_Slot41)
		PAF_StrippingSlots[11] = !PAF_StrippingSlots[11]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[11])
	elseif (a_option == _toggle_Slot42)
		PAF_StrippingSlots[12] = !PAF_StrippingSlots[12]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[12])
	elseif (a_option == _toggle_Slot43)
		PAF_StrippingSlots[13] = !PAF_StrippingSlots[13]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[13])
	elseif (a_option == _toggle_Slot44)
		PAF_StrippingSlots[14] = !PAF_StrippingSlots[14]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[14])
	elseif (a_option == _toggle_Slot45)
		PAF_StrippingSlots[15] = !PAF_StrippingSlots[15]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[15])
	elseif (a_option == _toggle_Slot46)
		PAF_StrippingSlots[16] = !PAF_StrippingSlots[16]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[16])
	elseif (a_option == _toggle_Slot47)
		PAF_StrippingSlots[17] = !PAF_StrippingSlots[17]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[17])
	elseif (a_option == _toggle_Slot48)
		PAF_StrippingSlots[18] = !PAF_StrippingSlots[18]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[18])
	elseif (a_option == _toggle_Slot49)
		PAF_StrippingSlots[19] = !PAF_StrippingSlots[19]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[19])
	elseif (a_option == _toggle_Slot50)
		PAF_StrippingSlots[20] = !PAF_StrippingSlots[20]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[20])
	elseif (a_option == _toggle_Slot51)
		PAF_StrippingSlots[21] = !PAF_StrippingSlots[21]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[21])
	elseif (a_option == _toggle_Slot52)
		PAF_StrippingSlots[22] = !PAF_StrippingSlots[22]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[22])
	elseif (a_option == _toggle_Slot53)
		PAF_StrippingSlots[23] = !PAF_StrippingSlots[23]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[23])
	elseif (a_option == _toggle_Slot54)
		PAF_StrippingSlots[24] = !PAF_StrippingSlots[24]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[24])
	elseif (a_option == _toggle_Slot55)
		PAF_StrippingSlots[25] = !PAF_StrippingSlots[25]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[25])
	elseif (a_option == _toggle_Slot56)
		PAF_StrippingSlots[26] = !PAF_StrippingSlots[26]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[26])
	elseif (a_option == _toggle_Slot57)
		PAF_StrippingSlots[27] = !PAF_StrippingSlots[27]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[27])
	elseif (a_option == _toggle_Slot58)
		PAF_StrippingSlots[28] = !PAF_StrippingSlots[28]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[28])
	elseif (a_option == _toggle_Slot59)
		PAF_StrippingSlots[29] = !PAF_StrippingSlots[29]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[29])
	elseif (a_option == _toggle_Slot60)
		PAF_StrippingSlots[30] = !PAF_StrippingSlots[30]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[30])
	elseif (a_option == _toggle_Slot61)
		PAF_StrippingSlots[31] = !PAF_StrippingSlots[31]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[31])
	elseif (a_option == _toggle_SlotWeapons)
		PAF_StrippingSlots[32] = !PAF_StrippingSlots[32]
		SetToggleOptionValue(a_option, PAF_StrippingSlots[32])
	endif

EndEvent

event OnOptionHighlight(int a_option)
    if (a_option == _toggle_Fart)
        SetInfoText("Disable filthy pooping.\nDefault: false")
    elseIf (a_option == _toggle_Stripping)
        SetInfoText("Enable Stripping of clothing. (Uses Sexlab Configuration)\nDefault: true")
	elseIf (a_option == _toggle_Scaling)
        SetInfoText("Enable Belly Scaling. (Uses NiOverride, so it should be comaptible with other scaling mods)\nDefault: false")
	elseIf (a_option == _toggle_Dirt)
        SetInfoText("Enable Dirt. You will need toilet paper to keep clean. (Uses SlaveTats)\nDefault: true")
	elseIf (a_option == _value_PeeRate)
        SetInfoText("Hours it takes to advance the state of your needs. There are 4 stages.\nExample: If it is set to 4, it will take 12 hours to advance to the last Stage.\nDefault: 4")
	elseIf (a_option == _value_PoopRate)
        SetInfoText("Hours it takes to advance the state of your needs. There are 4 stages.\nExample: If it is set to 8, it will take 24 hours to advance to the last Stage.\nDefault: 8")
	elseIf (a_option == _keymap_Action)
        SetInfoText("Press to pee and poop. Press and hold for longer than a second to poop.\nDefault: B")
	elseIf (a_option == _keymap_Info)
        SetInfoText("Key to display information about your needs and that of tracked actors, if you aim at them.\nDefault: N")
	elseIf (a_option == _keymap_Menu)
        SetInfoText("Display the PAF Menu.\nDefault: K")
	elseIf (a_option == _value_ScalingFactor)
        SetInfoText("Scaling Factor for belly adjustment. It is multiplied with you bowels state + 1 [1 - 4]!\nDefault: 0.75")
	elseIf (a_option == _value_ButtScalingFactor)
        SetInfoText("Scaling Factor for butt adjustment. This is relevant if you wear diapers!\nDefault: 0.25")
	elseIf (a_option == _toggle_Reset)
        SetInfoText("Reset the mod an rescan mod dependencies")
	elseIf (a_option == _toggle_LimitedStrippting)
        SetInfoText("Strips only the selected slots.\nDefault: false")
	elseIf (a_option == _toggle_PlayerToilet)
        SetInfoText("Tracked NPC use the player as toilet, if they are near (triggers sexlab scenes).\nDefault: false")
	elseIf (a_option == _toggle_FacialExpressions)
        SetInfoText("Toggles the facial expression during actions.\nDefault: true")
	elseIf (a_option == _toggle_PressureAnimation)
        SetInfoText("Toggles playing of animations if bladder or bowels state is very high.\nDefault: true")
	elseIf (a_option == _toggle_PeeToiletPaper)
        SetInfoText("Toggles the need for toilet paper after peeing. (You probably want to replace dirt texture, if you toggle this)\nDefault: false")
	elseIf (a_option == _toggle_AutoLeak)
        SetInfoText("Toggles automatic release of needs. (Player only)\nDefault: true")
	elseIf (a_option == _toggle_PlayUndressAnim)
        SetInfoText("Toggles undressing animations.\nDefault: true")
	elseIf (a_option == _menu_UndressAnim)
        SetInfoText("Changes the animation for undressing.\nDefault: 1")
	elseIf (a_option == _toggle_NPCToilet)
        SetInfoText("NPC have fun with each other if they need to relieve themselves. (Higher priority than using player, triggers sexlab scenes)\nDefault: false")
	elseIf (a_option == _toggle_PlayMoaningSounds)
        SetInfoText("Plays moaning sounds during pooping.\nDefault: false")
	elseIf (a_option == _toggle_PlacePuddles)
        SetInfoText("Places peeing puddles when peeing.\nDefault: true")
	elseIf (a_option == _toggle_SexlabIntegration)
        SetInfoText("Toggles peeing animation for every sexlab scene (experimental).\nDefault: false")
	elseIf (a_option == _value_SexlabStagePee)
        SetInfoText("The stage of a sexlab animation where actors start to pee.\nDefault: 1")
	elseIf (a_option == _value_SexlabStagePoop)
        SetInfoText("The stage of a sexlab animation where actors start to poop.\nDefault: 1")
	elseIf (a_option == _menu_SexlabTarget)
        SetInfoText("The actors who will play the peeing/pooping animations.\nDefault: player only")
    endIf
endEvent

string function GetNeedState(int a_state)
	string result = "pressure too high..."
	if (a_state == 0)
		result = "no pressure"
	elseif (a_state == 1)
		result = "low pressure"
	elseif (a_state == 2)
		result = "medium pressure"
	elseif (a_state == 3)
		result = "high pressure"
	endif
	return result
endfunction

string function GetDirtState(int a_state)
	string result = "not dirty"
	if (a_state == 0)
		result = "not dirty"
	elseif (a_state == 1)
		result = "slightly dirty"
	elseif (a_state == 2)
		result = "dirty"
	elseif (a_state == 3)
		result = "very dirty"
	endif
	return result
endfunction

event OnOptionKeyMapChange(int a_option, int a_keyCode, string a_conflictControl, string a_conflictName)
	if (a_option == _keymap_Action)
		PAF_MainQuest.UnregisterForKey(PAF_ActionKey)
		bool continue = true
		if (a_conflictControl != "")
			string msg
			if (a_conflictName != "")
				msg = "This key is already mapped to:\n'" + a_conflictControl + "'\n(" + a_conflictName + ")\n\nAre you sure you want to continue?"
			else
				msg = "This key is already mapped to:\n'" + a_conflictControl + "'\n\nAre you sure you want to continue?"
			endIf
			continue = ShowMessage(msg, true, "$Yes", "$No")
		endIf
		if (continue)
			PAF_ActionKey = a_keyCode
			SetKeymapOptionValue(a_option, a_keyCode)
			PAF_MainQuest.RegisterForKey(PAF_ActionKey)
		endIf
	elseif (a_option == _keymap_Info)
		PAF_MainQuest.UnregisterForKey(PAF_InfoKey)
		bool continue = true
		if (a_conflictControl != "")
			string msg
			if (a_conflictName != "")
				msg = "This key is already mapped to:\n'" + a_conflictControl + "'\n(" + a_conflictName + ")\n\nAre you sure you want to continue?"
			else
				msg = "This key is already mapped to:\n'" + a_conflictControl + "'\n\nAre you sure you want to continue?"
			endIf
			continue = ShowMessage(msg, true, "$Yes", "$No")
		endIf
		if (continue)
			PAF_InfoKey = a_keyCode
			SetKeymapOptionValue(a_option, a_keyCode)
			PAF_MainQuest.RegisterForKey(PAF_InfoKey)
		endIf
	elseif (a_option == _keymap_Menu)
		PAF_MainQuest.UnregisterForKey(PAF_MenuKey)
		bool continue = true
		if (a_conflictControl != "")
			string msg
			if (a_conflictName != "")
				msg = "This key is already mapped to:\n'" + a_conflictControl + "'\n(" + a_conflictName + ")\n\nAre you sure you want to continue?"
			else
				msg = "This key is already mapped to:\n'" + a_conflictControl + "'\n\nAre you sure you want to continue?"
			endIf
			continue = ShowMessage(msg, true, "$Yes", "$No")
		endIf
		if (continue)
			PAF_MenuKey = a_keyCode
			SetKeymapOptionValue(a_option, a_keyCode)
			PAF_MainQuest.RegisterForKey(PAF_MenuKey)
		endIf
	endIf
endEvent

event OnOptionSliderOpen(int a_option)
	if (a_option == _value_PeeRate)
		SetSliderDialogStartValue(PAF_PeeRate)
		SetSliderDialogDefaultValue(4)
		SetSliderDialogRange(1, 48)
		SetSliderDialogInterval(1)
	elseif(a_option == _value_PoopRate)
		SetSliderDialogStartValue(PAF_PoopRate)
		SetSliderDialogDefaultValue(8)
		SetSliderDialogRange(1, 48)
		SetSliderDialogInterval(1)
	elseif(a_option == _value_ScalingFactor)
		SetSliderDialogStartValue(PAF_ScalingFactor)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.1, 10.0)
		SetSliderDialogInterval(0.05)
	elseif(a_option == _value_ButtScalingFactor)
		SetSliderDialogStartValue(PAF_ButtScalingFactor)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.1, 10.0)
		SetSliderDialogInterval(0.05)
	elseif(a_option == _value_SexlabStagePee)
		SetSliderDialogStartValue(PAF_SexlabStagePee)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(0, 10)
		SetSliderDialogInterval(1)
	elseif(a_option == _value_SexlabStagePoop)
		SetSliderDialogStartValue(PAF_SexlabStagePoop)
		SetSliderDialogDefaultValue(1)
		SetSliderDialogRange(0, 10)
		SetSliderDialogInterval(1)
	elseif(a_option == _value_CrimeValue)
		SetSliderDialogStartValue(PAF_CrimeValue)
		SetSliderDialogDefaultValue(2000)
		SetSliderDialogRange(1, 10000)
		SetSliderDialogInterval(10)
	elseif(a_option == _value_DiaperPenaltyTime)
		SetSliderDialogStartValue(PAF_DiaperPenaltyTime)
		SetSliderDialogDefaultValue(1.0)
		SetSliderDialogRange(0.5, 72)
		SetSliderDialogInterval(0.5)
	endif
endEvent

event OnOptionSliderAccept(int a_option, float a_value)
	if (a_option == _value_PeeRate)
		PAF_PeeRate = a_value as int
		SetSliderOptionValue(a_option, a_value)
	elseif(a_option == _value_PoopRate)
		PAF_PoopRate = a_value as int
		SetSliderOptionValue(a_option, a_value)
	elseif(a_option == _value_ScalingFactor)
		PAF_ScalingFactor = a_value
		SetSliderOptionValue(a_option, a_value, "{2}")
	elseif(a_option == _value_ButtScalingFactor)
		PAF_ButtScalingFactor = a_value
		SetSliderOptionValue(a_option, a_value, "{2}")
	elseif(a_option == _value_SexlabStagePee)
		PAF_SexlabStagePee = a_value as int
		SetSliderOptionValue(a_option, a_value)
	elseif(a_option == _value_SexlabStagePoop)
		PAF_SexlabStagePoop = a_value as int
		SetSliderOptionValue(a_option, a_value)
	elseif(a_option == _value_CrimeValue)
		PAF_CrimeValue = a_value as int
		SetSliderOptionValue(a_option, a_value)
	elseif(a_option == _value_DiaperPenaltyTime)
		PAF_DiaperPenaltyTime = a_value
		SetSliderOptionValue(a_option, a_value, "{2}")
	endif
endEvent

event OnOptionMenuOpen(int a_option)
	if (a_option == _menu_SexlabTarget)
		SetMenuDialogStartIndex(PAF_SexlabTarget)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(_SexlabTarget)
	elseif (a_option == _menu_UndressAnim)
		SetMenuDialogStartIndex(PAF_UndressAnim)
		SetMenuDialogDefaultIndex(0)
		SetMenuDialogOptions(_StrippingAnim)
	elseif (a_option == _menu_AnimationFPee)
		_currentAnimations = CreateSexLabAnimList(1, 0, 1)
		SetMenuDialogDefaultIndex(-1)
		SetMenuDialogStartIndex(-1)
		SetMenuDialogOptions(_currentAnimations)
	elseif (a_option == _menu_AnimationFFart)
		_currentAnimations = CreateSexLabAnimList(1, 0, 1)
		SetMenuDialogDefaultIndex(-1)
		SetMenuDialogStartIndex(-1)
		SetMenuDialogOptions(_currentAnimations)
	elseif (a_option == _menu_AnimationFBoth)
		_currentAnimations = CreateSexLabAnimList(1, 0, 1)
		SetMenuDialogDefaultIndex(-1)
		SetMenuDialogStartIndex(-1)
		SetMenuDialogOptions(_currentAnimations)
	elseif (a_option == _menu_AnimationMPee)
		_currentAnimations = CreateSexLabAnimList(1, 1, 0)
		SetMenuDialogDefaultIndex(-1)
		SetMenuDialogStartIndex(-1)
		SetMenuDialogOptions(_currentAnimations)
	elseif (a_option == _menu_AnimationMFart)
		_currentAnimations = CreateSexLabAnimList(1, 1, 0)
		SetMenuDialogDefaultIndex(-1)
		SetMenuDialogStartIndex(-1)
		SetMenuDialogOptions(_currentAnimations)
	elseif (a_option == _menu_AnimationMBoth)
		_currentAnimations = CreateSexLabAnimList(1, 1, 0)
		SetMenuDialogDefaultIndex(-1)
		SetMenuDialogStartIndex(-1)
		SetMenuDialogOptions(_currentAnimations)
	elseif (a_option == _menu_AnimationFFPee)
		_currentAnimations = CreateSexLabAnimList(2, 0, 2)
		SetMenuDialogDefaultIndex(-1)
		SetMenuDialogStartIndex(-1)
		SetMenuDialogOptions(_currentAnimations)
	elseif (a_option == _menu_AnimationFMPee)
		_currentAnimations = CreateSexLabAnimList(2, 1, 1)
		SetMenuDialogDefaultIndex(-1)
		SetMenuDialogStartIndex(-1)
		SetMenuDialogOptions(_currentAnimations)
	elseif (a_option == _menu_AnimationMFPee)
		_currentAnimations = CreateSexLabAnimList(2, 1, 1)
		SetMenuDialogDefaultIndex(-1)
		SetMenuDialogStartIndex(-1)
		SetMenuDialogOptions(_currentAnimations)
	elseif (a_option == _menu_AnimationMMPee)
		_currentAnimations = CreateSexLabAnimList(2, 2, 0)
		SetMenuDialogDefaultIndex(-1)
		SetMenuDialogStartIndex(-1)
		SetMenuDialogOptions(_currentAnimations)
	elseif (a_option == _menu_AnimationFFFart)
		_currentAnimations = CreateSexLabAnimList(2, 0, 2)
		SetMenuDialogDefaultIndex(-1)
		SetMenuDialogStartIndex(-1)
		SetMenuDialogOptions(_currentAnimations)
	elseif (a_option == _menu_AnimationFMFart)
		_currentAnimations = CreateSexLabAnimList(2, 1, 1)
		SetMenuDialogDefaultIndex(-1)
		SetMenuDialogStartIndex(-1)
		SetMenuDialogOptions(_currentAnimations)
	elseif (a_option == _menu_AnimationMFFart)
		_currentAnimations = CreateSexLabAnimList(2, 1, 1)
		SetMenuDialogDefaultIndex(-1)
		SetMenuDialogStartIndex(-1)
		SetMenuDialogOptions(_currentAnimations)
	elseif (a_option == _menu_AnimationMMFart)
		_currentAnimations = CreateSexLabAnimList(2, 2, 0)
		SetMenuDialogDefaultIndex(-1)
		SetMenuDialogStartIndex(-1)
		SetMenuDialogOptions(_currentAnimations)
	elseif (a_option == _menu_AnimationFFBoth)
		_currentAnimations = CreateSexLabAnimList(2, 0, 2)
		SetMenuDialogDefaultIndex(-1)
		SetMenuDialogStartIndex(-1)
		SetMenuDialogOptions(_currentAnimations)
	elseif (a_option == _menu_AnimationFMBoth)
		_currentAnimations = CreateSexLabAnimList(2, 1, 1)
		SetMenuDialogDefaultIndex(-1)
		SetMenuDialogStartIndex(-1)
		SetMenuDialogOptions(_currentAnimations)
	elseif (a_option == _menu_AnimationMFBoth)
		_currentAnimations = CreateSexLabAnimList(2, 1, 1)
		SetMenuDialogDefaultIndex(-1)
		SetMenuDialogStartIndex(-1)
		SetMenuDialogOptions(_currentAnimations)
	elseif (a_option == _menu_AnimationMMBoth)
		_currentAnimations = CreateSexLabAnimList(2, 2, 0)
		SetMenuDialogDefaultIndex(-1)
		SetMenuDialogStartIndex(-1)
		SetMenuDialogOptions(_currentAnimations)
	endif
endEvent

event OnOptionMenuAccept(int a_option, int a_index)
	if (a_option == _menu_SexlabTarget)
		PAF_SexlabTarget = a_index
		SetMenuOptionValue(a_option, _SexlabTarget[PAF_SexlabTarget])
	elseif (a_option == _menu_UndressAnim)
		if(a_index == -1)
			PAF_UndressAnim = 0
		else
			PAF_UndressAnim = a_index
		endif
		SetMenuOptionValue(a_option, _StrippingAnim[PAF_UndressAnim])
	elseif (a_option == _menu_AnimationFPee)
		if(a_index == -1)
			return
		endif
		PAF_AnimationF_Pee = _currentAnimations[a_index]
		SetMenuOptionValue(a_option, PAF_AnimationF_Pee)
	elseif (a_option == _menu_AnimationFFart)
		if(a_index == -1)
			return
		endif
		PAF_AnimationF_Fart = _currentAnimations[a_index]
		SetMenuOptionValue(a_option, PAF_AnimationF_Fart)
	elseif (a_option == _menu_AnimationFBoth)
		if(a_index == -1)
			return
		endif
		PAF_AnimationF_Both = _currentAnimations[a_index]
		SetMenuOptionValue(a_option, PAF_AnimationF_Both)
	elseif (a_option == _menu_AnimationMPee)
		if(a_index == -1)
			return
		endif
		PAF_AnimationM_Pee = _currentAnimations[a_index]
		SetMenuOptionValue(a_option, PAF_AnimationM_Pee)
	elseif (a_option == _menu_AnimationMFart)
		if(a_index == -1)
			return
		endif
		PAF_AnimationM_Fart = _currentAnimations[a_index]
		SetMenuOptionValue(a_option, PAF_AnimationM_Fart)
	elseif (a_option == _menu_AnimationMBoth)
		if(a_index == -1)
			return
		endif
		PAF_AnimationM_Both = _currentAnimations[a_index]
		SetMenuOptionValue(a_option, PAF_AnimationM_Both)
	elseif (a_option == _menu_AnimationFFPee)
		if(a_index == -1)
			return
		endif
		PAF_AnimationPeeFF_Pee = _currentAnimations[a_index]
		SetMenuOptionValue(a_option, PAF_AnimationPeeFF_Pee)
	elseif (a_option == _menu_AnimationFMPee)
		if(a_index == -1)
			return
		endif
		PAF_AnimationPeeFM_Pee = _currentAnimations[a_index]
		SetMenuOptionValue(a_option, PAF_AnimationPeeFM_Pee)
	elseif (a_option == _menu_AnimationMFPee)
		if(a_index == -1)
			return
		endif
		PAF_AnimationPeeMF_Pee = _currentAnimations[a_index]
		SetMenuOptionValue(a_option, PAF_AnimationPeeMF_Pee)
	elseif (a_option == _menu_AnimationMMPee)
		if(a_index == -1)
			return
		endif
		PAF_AnimationPeeMM_Pee = _currentAnimations[a_index]
		SetMenuOptionValue(a_option, PAF_AnimationPeeMM_Pee)
	elseif (a_option == _menu_AnimationFFFart)
		if(a_index == -1)
			return
		endif
		PAF_AnimationPeeFF_Fart = _currentAnimations[a_index]
		SetMenuOptionValue(a_option, PAF_AnimationPeeFF_Fart)
	elseif (a_option == _menu_AnimationFMFart)
		if(a_index == -1)
			return
		endif
		PAF_AnimationPeeFM_Fart = _currentAnimations[a_index]
		SetMenuOptionValue(a_option, PAF_AnimationPeeFM_Fart)
	elseif (a_option == _menu_AnimationMFFart)
		if(a_index == -1)
			return
		endif
		PAF_AnimationPeeMF_Fart = _currentAnimations[a_index]
		SetMenuOptionValue(a_option, PAF_AnimationPeeMF_Fart)
	elseif (a_option == _menu_AnimationMMFart)
		if(a_index == -1)
			return
		endif
		PAF_AnimationPeeMM_Fart = _currentAnimations[a_index]
		SetMenuOptionValue(a_option, PAF_AnimationPeeMM_Fart)
	elseif (a_option == _menu_AnimationFFBoth)
		if(a_index == -1)
			return
		endif
		PAF_AnimationPeeFF_Both = _currentAnimations[a_index]
		SetMenuOptionValue(a_option, PAF_AnimationPeeFF_Both)
	elseif (a_option == _menu_AnimationFMBoth)
		if(a_index == -1)
			return
		endif
		PAF_AnimationPeeFM_Both = _currentAnimations[a_index]
		SetMenuOptionValue(a_option, PAF_AnimationPeeFM_Both)
	elseif (a_option == _menu_AnimationMFBoth)
		if(a_index == -1)
			return
		endif
		PAF_AnimationPeeMF_Both = _currentAnimations[a_index]
		SetMenuOptionValue(a_option, PAF_AnimationPeeMF_Both)
	elseif (a_option == _menu_AnimationMMBoth)
		if(a_index == -1)
			return
		endif
		PAF_AnimationPeeMM_Both = _currentAnimations[a_index]
		SetMenuOptionValue(a_option, PAF_AnimationPeeMM_Both)
	endIf
endEvent
