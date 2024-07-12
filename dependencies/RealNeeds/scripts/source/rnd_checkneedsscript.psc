Scriptname RND_CheckNeedsScript extends activemagiceffect  
{this script displays a needs message in the top left corner of the screen}

GlobalVariable Property RND_HungerPoints Auto
GlobalVariable Property RND_ThirstPoints Auto
GlobalVariable Property RND_SleepPoints Auto
GlobalVariable Property RND_InebriationPoints Auto

GlobalVariable Property RND_DebugMode Auto
GlobalVariable Property RND_1stPersonMsg Auto
Message Property RND_NeedsMessageDebug Auto

RND_PlayerScript Property RND_Player Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	ShowNeedsMessage()
	
	if RND_DebugMode.GetValue() == 1
		RND_NeedsMessageDebug.Show(RND_HungerPoints.GetValue(), \
			RND_ThirstPoints.GetValue(), RND_SleepPoints.GetValue(), RND_InebriationPoints.GetValue())
	endif

EndEvent

Function ShowNeedsMessage()

	if RND_HungerPoints.GetValue() < RND_HungerLevel01.GetValue()
		HungerStatus = HungerStatus00
	
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel01.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel02.GetValue()
		HungerStatus = HungerStatus01
	
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel02.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel03.GetValue()
		HungerStatus = HungerStatus02
	
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel03.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel04.GetValue()
		HungerStatus = HungerStatus03
	
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel04.GetValue() && RND_HungerPoints.GetValue() < RND_HungerLevel05.GetValue()
		HungerStatus = HungerStatus04
	
	elseif RND_HungerPoints.GetValue() >= RND_HungerLevel05.GetValue()
		HungerStatus = HungerStatus05
	
	endif

	
	if RND_ThirstPoints.GetValue() < RND_ThirstLevel01.GetValue()
		ThirstStatus = ThirstStatus00
	
	elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel01.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel02.GetValue()
		ThirstStatus = ThirstStatus01
	
	elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel02.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel03.GetValue()
		ThirstStatus = ThirstStatus02
	
	elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel03.GetValue() && RND_ThirstPoints.GetValue() < RND_ThirstLevel04.GetValue()
		ThirstStatus = ThirstStatus03
	
	elseif RND_ThirstPoints.GetValue() >= RND_ThirstLevel04.GetValue()
		ThirstStatus = ThirstStatus04
	
	endif

	if RND_SleepPoints.GetValue() < RND_SleepLevel01.GetValue()
		SleepStatus = SleepStatus00
		
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel01.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel02.GetValue()
		SleepStatus = SleepStatus01
	
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel02.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel03.GetValue()
		SleepStatus = SleepStatus02
	
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel03.GetValue() && RND_SleepPoints.GetValue() < RND_SleepLevel04.GetValue()
		SleepStatus = SleepStatus03
	
	elseif RND_SleepPoints.GetValue() >= RND_SleepLevel04.GetValue()
		SleepStatus = SleepStatus04
	
	endif
	
	if RND_InebriationPoints.GetValue() < RND_InebriationLevel01.GetValue()
		InebriationStatus = InebriationStatus00
		
	
	elseif RND_InebriationPoints.GetValue() >= RND_InebriationLevel01.GetValue() && RND_InebriationPoints.GetValue() < RND_InebriationLevel02.GetValue()
		InebriationStatus = InebriationStatus01
	
	elseif RND_InebriationPoints.GetValue() >= RND_InebriationLevel02.GetValue() && RND_InebriationPoints.GetValue() < RND_InebriationLevel03.GetValue()
		InebriationStatus = InebriationStatus02
	
	elseif RND_InebriationPoints.GetValue() >= RND_InebriationLevel03.GetValue() && RND_InebriationPoints.GetValue() < RND_InebriationLevel04.GetValue()
		InebriationStatus = InebriationStatus03
	
	elseif RND_InebriationPoints.GetValue() >= RND_InebriationLevel04.GetValue()
		InebriationStatus = InebriationStatus03

	endif
	
	String NeedsMessage
	
	if RND_1stPersonMsg.getValue() == 1
		NeedsMessage = NeedsStatus
	else
		NeedsMessage = NeedsStatusB
	endif
	
	if RND_Player.isVampire()
		NeedsMessage = NeedsMessage + " " + SleepStatus
	else
		NeedsMessage = NeedsMessage + " " + HungerStatus + ", " + ThirstStatus + ", " + SleepStatus + ", " + InebriationStatus
	endif
	
	Debug.Notification(NeedsMessage)

EndFunction

String Property NeedsStatus Auto
String Property NeedsStatusB Auto

String Property HungerStatus Auto
String Property HungerStatus00 Auto
String Property HungerStatus01 Auto
String Property HungerStatus02 Auto
String Property HungerStatus03 Auto
String Property HungerStatus04 Auto
String Property HungerStatus05 Auto

GlobalVariable Property RND_HungerLevel00 Auto
GlobalVariable Property RND_HungerLevel01 Auto
GlobalVariable Property RND_HungerLevel02 Auto
GlobalVariable Property RND_HungerLevel03 Auto
GlobalVariable Property RND_HungerLevel04 Auto
GlobalVariable Property RND_HungerLevel05 Auto

String Property ThirstStatus Auto
String Property ThirstStatus00 Auto
String Property ThirstStatus01 Auto
String Property ThirstStatus02 Auto
String Property ThirstStatus03 Auto
String Property ThirstStatus04 Auto

GlobalVariable Property RND_ThirstLevel00 Auto
GlobalVariable Property RND_ThirstLevel01 Auto
GlobalVariable Property RND_ThirstLevel02 Auto
GlobalVariable Property RND_ThirstLevel03 Auto
GlobalVariable Property RND_ThirstLevel04 Auto

String Property SleepStatus Auto
String Property SleepStatus00 Auto
String Property SleepStatus01 Auto
String Property SleepStatus02 Auto
String Property SleepStatus03 Auto
String Property SleepStatus04 Auto

GlobalVariable Property RND_SleepLevel00 Auto
GlobalVariable Property RND_SleepLevel01 Auto
GlobalVariable Property RND_SleepLevel02 Auto
GlobalVariable Property RND_SleepLevel03 Auto
GlobalVariable Property RND_SleepLevel04 Auto

String Property InebriationStatus Auto
String Property InebriationStatus00 Auto
String Property InebriationStatus01 Auto
String Property InebriationStatus02 Auto
String Property InebriationStatus03 Auto

GlobalVariable Property RND_InebriationLevel00 Auto
GlobalVariable Property RND_InebriationLevel01 Auto
GlobalVariable Property RND_InebriationLevel02 Auto
GlobalVariable Property RND_InebriationLevel03 Auto
GlobalVariable Property RND_InebriationLevel04 Auto
