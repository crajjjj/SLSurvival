Scriptname SLV_SOSSchlong extends Quest  

function SLV_SchlongSize(Actor NPCActor, int size)
if Game.GetModByName("Schlongs of Skyrim.esp")!= 255 && MCMMenu.SOSSlaverSchlong
	SOS_API sos = SOS_API.Get()
	int oldmaxsize = sos.GetMaxSchlongSize()
	sos.SetMaxSchlongSize(20)
	sos.SetSize(NPCActor, size)
	Utility.wait(1.0)
	sos.SetMaxSchlongSize(oldmaxsize)
endif
EndFunction

function SLV_SlaverSchlong(Actor NPCActor)
if Game.GetModByName("Schlongs of Skyrim.esp")!= 255 && MCMMenu.SOSSlaverSchlong
	SOS_API sos = SOS_API.Get()
	int oldmaxsize = sos.GetMaxSchlongSize()
	sos.SetMaxSchlongSize(20)
	if sos.getSize(NPCActor) < 10
		sos.SetSize(NPCActor, 10)
	endif
	Utility.wait(1.0)
	sos.SetMaxSchlongSize(oldmaxsize)
endif
EndFunction

function SLV_IncleaseSchlong(Actor NPCActor)
if Game.GetModByName("Schlongs of Skyrim.esp")!= 255 && MCMMenu.SOSSlaverSchlong
	SOS_API sos = SOS_API.Get()
	int oldmaxsize = sos.GetMaxSchlongSize()
	sos.SetMaxSchlongSize(20)
	sos.SetSize(NPCActor, sos.getSize(NPCActor) + 1)
	Utility.wait(1.0)
	sos.SetMaxSchlongSize(oldmaxsize)
endif
EndFunction


int function SLV_GetSchlongSize(Actor NPCActor)
if Game.GetModByName("Schlongs of Skyrim.esp")!= 255 && MCMMenu.SOSSlaverSchlong
	SOS_API sos = SOS_API.Get()
	return sos.getSize(NPCActor)
endif
return 0
EndFunction

SLV_MCMMenu Property MCMMenu Auto