Scriptname zadGagVoices extends sslVoiceFactory

Sound Property zadGaggedFemale01Mild  Auto
Sound Property zadGaggedFemale01Medium  Auto
Sound Property zadGaggedFemale01Hot  Auto
Sound Property zadGaggedMale01Mild  Auto
Sound Property zadGaggedMale01Medium  Auto
Sound Property zadGaggedMale01Hot  Auto

function RegisterVoiceEvent()		
	RegisterForModEvent("SexLabSlotVoices", "RegisterVoices")
endFunction

Function RegisterVoices()	
	Slots = (Quest.GetQuest("SexLabQuestRegistry") as sslVoiceSlots)	
	RegisterVoice("FemaleGagged")
	int slot_num	
	Utility.Wait(0.5)
	slot_num = Slots.FindByName("Female Gagged")	
	SendModEvent("GagSoundsRegistered", "FemaleGagged", slot_num as float)
	RegisterVoice("MaleGagged")	
	Utility.Wait(0.5)
	slot_num = Slots.FindByName("Male Gagged")	
	SendModEvent("GagSoundsRegistered", "MaleGagged", slot_num as float)
EndFunction

function MaleGagged(int id)
	debug.trace(self+" Male Given ID:"+id)
	sslBaseVoice Base = Create(id)
	Base.Name = "Male Gagged"
	Base.Gender = Male
	Base.Enabled = false
	Base.Mild = zadGaggedMale01Mild
	Base.Medium = zadGaggedMale01Medium
	Base.Hot = zadGaggedMale01Hot
	Base.AddTag("Male")
	Base.AddTag("Gagged")
	Base.Save(id)	
endFunction

function FemaleGagged(int id)
	debug.trace(self+" Female Given ID:"+id)
	sslBaseVoice Base = Create(id)
	Base.Name = "Female Gagged"
	Base.Gender = Female
	Base.Enabled = false
	Base.Mild = zadGaggedFemale01Mild
	Base.Medium = zadGaggedFemale01Medium
	Base.Hot = zadGaggedFemale01Hot
	Base.AddTag("Female")
	Base.AddTag("Gagged")
	Base.Save(id)
endFunction 