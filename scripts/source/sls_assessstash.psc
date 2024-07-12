Scriptname SLS_AssessStash extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
	Debug.Messagebox(StashTrack.GetStashDescription())
EndEvent

SLS_StashTrackPlayer Property StashTrack Auto
