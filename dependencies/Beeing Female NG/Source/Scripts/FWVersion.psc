Scriptname FWVersion

; Returns the BeeingFemale Version as string
string function GetVersionString() global
	;return "2.8"
	
	;;;;;; ;Tkc (Loverslab) : Check for ini files in BeeingFemale\Version folder then read and return overall version from 0.ini+1.ini...+n.ini
	int vfc = FWUtility.GetFileCount("Version","ini")
	string version = ""
	int i = 0
	while i < vfc
		version += FWUtility.GetIniCString("Version",FWUtility.GetFileName("Version","ini",i),"Version", "BF_Version")
		i+=1
	endwhile
	if version
		;debug.trace("BF: version="+version)
		return version
	else
		return "3.0"
	endif
	;;;;;;;;;;;;;;;;;;;;;;;;;
EndFunction

; Returns the BeeingFemaleVersion as integer
int Function GetVersion() global
	;Return 20800

	;;;;;; ;Tkc (Loverslab) : Check for ini files in BeeingFemale\Version folder then read and return overall version from 0.ini+1.ini...+n.ini
	int vfc = FWUtility.GetFileCount("Version","ini")
	int versionInt = 0
	int i = 0
	while i < vfc
		versionInt += FWUtility.getIniCInt("Version",FWUtility.GetFileName("Version","ini",i),"Version", "BF_VersionInt")
		i+=1
	endwhile
	if versionInt
		;debug.trace("BF: Integer version="+versionInt)
		return versionInt
	else
		return 30000
	endif
	;;;;;;;;;;;;;;;;;;;;;;;;;
EndFunction

; Returns the version of the current MCM Properties
int Function GetMCMVersion() global
	;Return 25
	
	;;;;;; ;Tkc (Loverslab) : Check for ini files in BeeingFemale\Version folder
		Return FWUtility.getIniCInt("Version",FWUtility.GetFileName("Version","ini",0),"Version", "BF_VersionMCM", 25)
	;;;;;;;;;;;;;;;;;;;;;;;;;
EndFunction

int Function GetNativeVersion() global
	;Return 6
	
	;;;;;; ;Tkc (Loverslab) : Check for ini files in BeeingFemale\Version folder
		Return FWUtility.getIniCInt("Version",FWUtility.GetFileName("Version","ini",0),"Version", "BF_VersionNative", 6)
	;;;;;;;;;;;;;;;;;;;;;;;;;
EndFunction

; Returns the  minimum required animation version
int function GetAnimationVersionRequired() global
	;return 1
	
	;;;;;; ;Tkc (Loverslab) : Check for ini files in BeeingFemale\Version folder
		Return FWUtility.getIniCInt("Version",FWUtility.GetFileName("Version","ini",0),"Version", "BF_VersionAnimation", 1)
	;;;;;;;;;;;;;;;;;;;;;;;;;
endfunction
