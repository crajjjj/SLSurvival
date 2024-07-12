Scriptname RND_ToggleWidgetSpellScript extends activemagiceffect

RND_HungerCountScript Property HungerScript Auto
RND_ThirstCountScript Property ThirstScript Auto
RND_SleepCountScript Property SleepScript Auto
RND_InebriationCountScript Property InebriationScript Auto
RND_WeightCountScript Property WeightScript Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	HungerScript.WidgetFade()
	ThirstScript.WidgetFade()
	SleepScript.WidgetFade()
	InebriationScript.WidgetFade()
	WeightScript.WidgetFade()

EndEvent
