Scriptname SLV_VersionCheck extends Quest  

bool function SLV_doVersionCheck()
bool result = true

string ZAP_version = zbfUtil.GetVersionStr()

if ZAP_version != "8.0"
	debug.MessageBox("Slaverun Reloaded V3.x requires ZAP Framework Version 8.0")
	result = false
endif

string DDI_version = devices.SLV_getDeviousIntegrationVersion()
string DDX_version = devices.SLV_getDeviousExpansionVersion()

if  (DDI_version  != "4.0" && DDI_version  != "4.1")
	debug.MessageBox("Slaverun Reloaded V3.x requires Devious Devices Integration Version 4.0 or 4.1")
	result = false
endif

if (DDX_version != "4.0" && DDX_version !="4.1")
	debug.MessageBox("Slaverun Reloaded V3.x requires Devious Devices Expansion Version 4.0 or 4.1")
	result = false
endif

return result
endfunction

SLV_DeviousDevices Property devices Auto