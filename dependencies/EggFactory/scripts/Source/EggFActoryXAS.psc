Scriptname EggFActoryXAS extends Quest

ObjectReference property MyMarker auto

Event OnInit()

    utility.wait(1.5)

    int handle = ModEvent.Create("XAS_Register")
    if (handle)
            modevent.pushform(handle, MyMarker)
            ModEvent.send(handle)
    endif

EndEvent

