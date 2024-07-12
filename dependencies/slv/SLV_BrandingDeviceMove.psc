Scriptname SLV_BrandingDeviceMove extends Quest  

ObjectReference function SLV_createBrandingDevice()
if Game.GetModByName("BrandingDeviceOfDoom.esp")!= 255
	return TPBDOD()
endif
endfunction
ObjectReference function TPBDOD()
if Game.GetModByName("BrandingDeviceOfDoom.esp")!= 255
    Quest xbQ=Game.GetFormFromFile(0x001854, "BrandingDeviceOfDoom.esp") As Quest
    objectReference bdodObjRef=(xbQ as xxbQuestScript).BdodInDungeonObjRef
    (bdodObjRef as xxBrandingDeviceScript).MoveBDODFromDungeonToObjRef(SLV_DeviceWaymarker, 5) ;25.0
    return(bdodObjRef as xxBrandingDeviceScript).BDODGetTPStocksRef()
endif
endfunction
ObjectReference Property SLV_DeviceWaymarker Auto