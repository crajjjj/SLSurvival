Scriptname FWAddOn_MiscBasicCamera extends FWAddOn_Misc

float property FreeCamSpeed = 3.5 Auto

function StartCamera()
	;FW_log.WriteLog("Free Camera started")
	bool InFreeCamera = Game.GetCameraState() == 3
	if InFreeCamera ;Tkc (Loverslab): optimization
	else;if !InFreeCamera
		MiscUtil.SetFreeCameraSpeed(FreeCamSpeed)
		MiscUtil.ToggleFreeCamera()
	endIf
endFunction

function StopCamera()
	;FW_log.WriteLog("Free Camera ended")
	bool InFreeCamera = Game.GetCameraState() == 3
	If InFreeCamera
		MiscUtil.ToggleFreeCamera()
	endIf
endFunction