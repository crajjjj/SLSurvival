Scriptname ZazStaticObjectsOnOffScript extends ObjectReference  

ObjectReference property zbfStaticFurnitureOn Auto
ObjectReference property zbfStaticFurnitureOff Auto

Event OnTriggerEnter(ObjectReference akActionRef)
If akActionRef == Game.GetPlayer()

zbfStaticFurnitureOff.Disable()
zbfStaticFurnitureOn.Enable()

Endif
EndEvent
