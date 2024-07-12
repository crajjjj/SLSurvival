Scriptname _SLS_HighlightItem extends ReferenceAlias  

Event OnInit()
	If Self.GetReference()
		RegisterForModEvent("_SLS_HighlightItemsStop", "On_SLS_HighlightItemsStop")
		WhatAmI = Self.GetReference()
		;WhatAmI.Disable()
		;WhatAmI.Enable()
		StorageUtil.FormListAdd(None, "_SLS_HighlightedItemsList", WhatAmI)
		Marker = WhatAmI.PlaceAtMe(_SLS_HighlightItemActivator, abInitiallyDisabled = true)
		Marker.MoveTo(WhatAmI, afZOffset = 20.0, abMatchRotation = false)
		Marker.SetAngle(0.0, 0.0, 0.0)
		;Marker.Enable(true) ; Suspect enabling with fade delays the rest of the script. Enable later
		StorageUtil.SetFormValue(Marker, "_SLS_HighlightedItemObjRef", WhatAmI)
		;Marker.SetDisplayName(WhatAmI.GetDisplayName())
		;Debug.Trace("_SLS_: Test: " + WhatAmI.GetDisplayName() + " - " + WhatAmI.GetBaseObject().GetType())
		
		;GoToState(StorageUtil.GetStringValue(None, ("_SLS_TypeState_" + WhatAmI.GetBaseObject().GetType())))
		
		PlayShader(WhatAmI)
		Marker.Enable(true)
	EndIf
EndEvent

Function PlayShader(ObjectReference ObjRef)
	EffectShader akShader = GetShaderFor(ObjRef.GetBaseObject())
	If akShader
		akShader.Play(ObjRef)
	Else
		Debug.Trace("_SLS_: _SLS_HighlightItem: PlayShader(): Warning: EffectShader not found for: " + ObjRef.GetBaseObject())
	EndIf
EndFunction

Function StopShader(ObjectReference ObjRef)
	EffectShader akShader = GetShaderFor(ObjRef.GetBaseObject())
	If akShader
		akShader.Stop(ObjRef)
	Else
		Debug.Trace("_SLS_: _SLS_HighlightItem: StopShader(): Warning: EffectShader not found for: " + ObjRef.GetBaseObject())
	EndIf
EndFunction

EffectShader Function GetShaderFor(Form akForm)
	Return StorageUtil.GetFormValue(None, "_SLS_EffectShaderType_" + akForm.GetType()) as EffectShader
EndFunction

Event On_SLS_HighlightItemsStop(string eventName, string strArg, float numArg, Form sender)
	;GoToState("")
	StopShader(WhatAmI)
	Marker.Disable(true)
	Marker.Delete()
	StorageUtil.FormListRemove(None, "_SLS_HighlightedItemsList", WhatAmI)
EndEvent
;/
State kArmor ; Armor
	Event OnBeginState()
		Highlight._SLS_HighlightArmor.Play(WhatAmI)
		Marker.Enable(true)
	EndEvent

	Event OnEndState()
		Highlight._SLS_HighlightArmor.Stop(WhatAmI)
	EndEvent
EndState

State kWeapon ; Weapon
	Event OnBeginState()
		Highlight._SLS_HighlightWeapon.Play(WhatAmI)
		Marker.Enable(true)
	EndEvent

	Event OnEndState()
		Highlight._SLS_HighlightWeapon.Stop(WhatAmI)
	EndEvent
EndState

State kAmmo ; Ammo
	Event OnBeginState()
		Highlight._SLS_HighlightAmmo.Play(WhatAmI)
		Marker.Enable(true)
	EndEvent

	Event OnEndState()
		Highlight._SLS_HighlightAmmo.Stop(WhatAmI)
	EndEvent
EndState

State kProjectile ; Projectile
	Event OnBeginState()
		Highlight._SLS_HighlightAmmo.Play(WhatAmI)
		Marker.Enable(true)
	EndEvent

	Event OnEndState()
		Highlight._SLS_HighlightAmmo.Stop(WhatAmI)
	EndEvent
EndState

State kMisc ; Misc
	Event OnBeginState()
		Highlight._SLS_HighlightMisc.Play(WhatAmI)
		Marker.Enable(true)
	EndEvent

	Event OnEndState()
		Highlight._SLS_HighlightMisc.Stop(WhatAmI)
	EndEvent
EndState

State kScrollItem ; Scroll
	Event OnBeginState()
		Highlight._SLS_HighlightScroll.Play(WhatAmI)
		Marker.Enable(true)
	EndEvent

	Event OnEndState()
		Highlight._SLS_HighlightScroll.Stop(WhatAmI)
	EndEvent
EndState

State kBook ; Book
	Event OnBeginState()
		Highlight._SLS_HighlightBook.Play(WhatAmI)
		Marker.Enable(true)
	EndEvent

	Event OnEndState()
		Highlight._SLS_HighlightBook.Stop(WhatAmI)
	EndEvent
EndState

State kPotion ; Potion
	Event OnBeginState()
		Highlight._SLS_HighlightPotion.Play(WhatAmI)
		Marker.Enable(true)
	EndEvent

	Event OnEndState()
		Highlight._SLS_HighlightPotion.Stop(WhatAmI)
	EndEvent
EndState

State kKey ; Key
	Event OnBeginState()
		Highlight._SLS_HighlightKey.Play(WhatAmI)
		Marker.Enable(true)
	EndEvent

	Event OnEndState()
		Highlight._SLS_HighlightKey.Stop(WhatAmI)
	EndEvent
EndState

State kFlora ; Flora
	Event OnBeginState()
		Highlight._SLS_HighlightFlora.Play(WhatAmI)
		Marker.Enable(true)
	EndEvent

	Event OnEndState()
		Highlight._SLS_HighlightFlora.Stop(WhatAmI)
	EndEvent
EndState

State kSoulGem ; Soulgem
	Event OnBeginState()
		Highlight._SLS_HighlightSoul.Play(WhatAmI)
		Marker.Enable(true)
	EndEvent

	Event OnEndState()
		Highlight._SLS_HighlightSoul.Stop(WhatAmI)
	EndEvent
EndState

State kIngredient ; Ingredient
	Event OnBeginState()
		Highlight._SLS_HighlightIngredient.Play(WhatAmI)
		Marker.Enable(true)
	EndEvent

	Event OnEndState()
		Highlight._SLS_HighlightIngredient.Stop(WhatAmI)
	EndEvent
EndState
/;
ObjectReference WhatAmI
ObjectReference Property Marker Auto Hidden

Activator Property _SLS_HighlightItemActivator Auto

_SLS_Highlight Property Highlight Auto
