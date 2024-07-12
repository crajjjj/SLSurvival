scriptname FallbackEventEmitter extends ReferenceAlias
{Allows registration and emitting of mod event using SKSE or in SKSE-less
fallback mode.}

import CommonArrayHelper

Actor property PlayerRef auto
{Link to the Player actor reference.}

Activator property FallbackEventHandleMarker auto
{Link to your event handler marker object. See the CheskoPapyrusShared readme
for more info.}

bool property UseSKSEModEvents = true auto
{Default: true. If false, events from this emitter will only be registered /
sent via Fallback Events.}

bool property UseStaticEventHandler = false auto
{Default: false. If true, the emitter will spawn a single event handler and keep
it loaded in the engine. Good for routine, periodic events where constantly
creating and destroying event handlers is less desirable.}

int property SKSE_MIN_VERSION = 10700 auto hidden ; Version that ModEvent was introduced

int VERSION = 1 ; Fallback Event API version
bool isSKSELoaded = false

Form[] registeredForms
Alias[] registeredAliases
ActiveMagicEffect[] registeredActiveMagicEffects
Form[] handles

Event OnInit()
  registeredForms = new Form[128]
  registeredAliases = new Alias[128]
  registeredActiveMagicEffects = new ActiveMagicEffect[128]
  handles = new Form[128]
  isSKSELoaded = CheckSKSELoaded()
EndEvent

Event OnPlayerLoadGame()
  isSKSELoaded = CheckSKSELoaded()
EndEvent

int function GetVersion()
  return VERSION
endFunction

int function Create(string asEventName)
  if isSKSELoaded
    return ModEvent.Create(asEventName)
  else
    if UseStaticEventHandler
      if !handles[0]
        ObjectReference handle = PlayerRef.PlaceAtMe(FallbackEventHandleMarker)
        debug.trace(self + " generated a new static event handler " + handle)
        (handle as FallbackEventHandler).sender = self
        (handle as FallbackEventHandler).isStaticHandler = true
        (handle as FallbackEventHandler).eventName = asEventName
        handles[0] = handle as Form
      endif
      return 1
    else
      ObjectReference handle = PlayerRef.PlaceAtMe(FallbackEventHandleMarker)
      debug.trace(self + " generated an event handler " + handle)
      (handle as FallbackEventHandler).sender = self
      (handle as FallbackEventHandler).eventName = asEventName
      ArrayAddForm(handles, handle as Form)
      int handleID = handles.Find(handle as Form) + 1
      (handle as FallbackEventHandler).handleID = handleID
      return handleID
    endif
  endif
endFunction

bool function Send(int handle)
  if isSKSELoaded
    ; debug.trace(self + " sending the event via SKSE.")
    return ModEvent.Send(handle)
  else
    ; debug.trace(self + " sending the event via fallback.")
    if UseStaticEventHandler
      if handles[0]
        bool sent = (handles[0] as FallbackEventHandler).Send(registeredForms, registeredAliases, registeredActiveMagicEffects)
        debug.trace(self + " sent event: " + sent)
        return sent
      else
        debug.trace(self + " attempted to send a fallback event before a static handler was created.")
        return false
      endif
    else
      bool sent = (handles[handle - 1] as FallbackEventHandler).Send(registeredForms, registeredAliases, registeredActiveMagicEffects)
      debug.trace(self + " sent event: " + sent)
      return sent
    endif
  endif
endFunction

function Release(int handle)
  if isSKSELoaded
    ModEvent.Release(handle)
  else
    ArrayRemoveForm(handles, handles[handle - 1], true)
  endif
endFunction

function RegisterFormForModEventWithFallback(string asEventName, string asCallbackName, Form akReceiver)
  if isSKSELoaded
    akReceiver.RegisterForModEvent(asEventName, asCallbackName)
  else
    FallbackEventReceiverForm receiver = akReceiver as FallbackEventReceiverForm
    if receiver
      int idx = registeredForms.Find(akReceiver)
      if idx == -1
        ArrayAddForm(registeredForms, akReceiver)
        ArraySortForm(registeredForms)
      endif
    endif
  endif
endFunction

function UnregisterFormForModEventWithFallback(string asEventName, Form akReceiver)
  if isSKSELoaded
    akReceiver.UnregisterForModEvent(asEventName)
  else
    FallbackEventReceiverForm receiver = akReceiver as FallbackEventReceiverForm
    if receiver
      ArrayRemoveForm(registeredForms, akReceiver, true)
    endif
  endif
endFunction

function RegisterAliasForModEventWithFallback(string asEventName, string asCallbackName, Alias akReceiver)
  if isSKSELoaded
    akReceiver.RegisterForModEvent(asEventName, asCallbackName)
  else
    FallbackEventReceiverAlias receiver = akReceiver as FallbackEventReceiverAlias
    if receiver
      int idx = registeredAliases.Find(akReceiver)
      if idx == -1
        ArrayAddAlias(registeredAliases, akReceiver)
        ArraySortAlias(registeredAliases)
      endif
    endif
  endif
endFunction

function UnregisterAliasForModEventWithFallback(string asEventName, Alias akReceiver)
  if isSKSELoaded
    akReceiver.UnregisterForModEvent(asEventName)
  else
    FallbackEventReceiverAlias receiver = akReceiver as FallbackEventReceiverAlias
    if receiver
      ArrayRemoveAlias(registeredAliases, akReceiver, true)
    endif
  endif
endFunction

function RegisterActiveMagicEffectForModEventWithFallback(string asEventName, string asCallbackname, ActiveMagicEffect akReceiver)
  if isSKSELoaded
    akReceiver.RegisterForModEvent(asEventName, asCallbackName)
  else
    FallbackEventReceiverActiveMagicEffect receiver = akReceiver as FallbackEventReceiverActiveMagicEffect
    if receiver
      int idx = registeredActiveMagicEffects.Find(akReceiver)
      if idx == -1
        ArrayAddActiveMagicEffect(registeredActiveMagicEffects, akReceiver)
        ArraySortActiveMagicEffect(registeredActiveMagicEffects)
      endif
    endif
  endif
endFunction

function UnregisterActiveMagicEffectForModEventWithFallback(string asEventName, ActiveMagicEffect akReceiver)
  if isSKSELoaded
    akReceiver.UnregisterForModEvent(asEventName)
  else
    FallbackEventReceiverActiveMagicEffect receiver = akReceiver as FallbackEventReceiverActiveMagicEffect
    if receiver
      ArrayRemoveActiveMagicEffect(registeredActiveMagicEffects, akReceiver, true)
    endif
  endif
endFunction

function PushBool(int handle, bool value)
  if isSKSELoaded
    ModEvent.PushBool(handle, value)
  else
    FallbackEventHandler handleref = handles[handle - 1] as FallbackEventHandler
    if handleref
      int i = 0
      while i < 10 && !handleref.IsInitialized()
        Utility.Wait(0.1)
        i += 1
      endWhile
      handleref.PushBool(value)
    endif
  endif
endFunction

function PushInt(int handle, int value)
  if isSKSELoaded
    ModEvent.PushInt(handle, value)
  else
    FallbackEventHandler handleref = handles[handle - 1] as FallbackEventHandler
    if handleref
      int i = 0
      while i < 10 && !handleref.IsInitialized()
        Utility.Wait(0.1)
        i += 1
      endWhile
      handleref.PushInt(value)
    endif
  endif
endFunction

function PushFloat(int handle, float value)
  if isSKSELoaded
    ModEvent.PushFloat(handle, value)
  else
    FallbackEventHandler handleref = handles[handle - 1] as FallbackEventHandler
    if handleref
      int i = 0
      while i < 10 && !handleref.IsInitialized()
        Utility.Wait(0.1)
        i += 1
      endWhile
      handleref.PushFloat(value)
    endif
  endif
endFunction

function PushString(int handle, string value)
  if isSKSELoaded
    ModEvent.PushString(handle, value)
  else
    FallbackEventHandler handleref = handles[handle - 1] as FallbackEventHandler
    if handleref
      int i = 0
      while i < 10 && !handleref.IsInitialized()
        Utility.Wait(0.1)
        i += 1
      endWhile
      handleref.PushString(value)
    endif
  endif
endFunction

function PushForm(int handle, form value)
  if isSKSELoaded
    ModEvent.PushForm(handle, value)
  else
    FallbackEventHandler handleref = handles[handle - 1] as FallbackEventHandler
    if handleref
      int i = 0
      while i < 10 && !handleref.IsInitialized()
        Utility.Wait(0.1)
        i += 1
      endWhile
      handleref.PushForm(value)
    endif
  endif
endFunction

bool function CheckSKSELoaded()
  if !UseSKSEModEvents
    return false
  endif

	bool skse_loaded = SKSE.GetVersion()
  if skse_loaded
		int skse_version = (SKSE.GetVersion() * 10000) + (SKSE.GetVersionMinor() * 100) + SKSE.GetVersionBeta()
		if skse_version >= SKSE_MIN_VERSION
      return true
    else
      return false
    endif
  else
    return false
  endif
endFunction
