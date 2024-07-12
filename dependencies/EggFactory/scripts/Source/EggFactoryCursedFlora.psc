Scriptname EggFactoryCursedFlora extends ObjectReference

miscobject property cursedegg auto
globalvariable property cursechancevar auto
globalvariable property EggFactoryRespawnFix auto

Event OnActivate(ObjectReference akActionRef)
  if(utility.randomint(0,100) < (cursechancevar.getvalue() as int))
    akActionRef.additem(cursedegg,1)
  endif
  if((EggFactoryRespawnFix.GetValue() as int) > 0)
      RegisterForSingleUpdateGameTime(Game.GetGameSettingInt("iHoursToRespawnCell"))
  endif
EndEvent

Event OnUpdateGameTime()
  ObjectReference newObj = PlaceAtMe(GetBaseObject(), 1, false, true)
  newObj.SetScale(GetScale())
  newObj.SetAngle(GetAngleX(), GetAngleY(), GetAngleZ())
  newObj.Enable(false)
  Disable()
  Utility.Wait(0.1)
  Delete()
EndEvent