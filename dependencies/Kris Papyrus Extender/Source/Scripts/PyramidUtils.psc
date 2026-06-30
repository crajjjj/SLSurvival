Scriptname PyramidUtils Hidden 
{
  Legacy Script for compatibility. All functions here have been moved into corresponding SPE_ scripts
}

; Actor
Function SetActorCalmed(Actor akActor, bool abCalmed) global
  SPE_Actor.SetActorCalmed(akActor, abCalmed)
EndFunction
Function SetActorFrozen(Actor akTarget, bool abFrozen) global
  SPE_Actor.SetActorFrozen(akTarget, abFrozen)
EndFunction
Actor[] Function GetDetectedBy(Actor akActor) global
  return SPE_Actor.GetDetectedBy(akActor)
EndFunction
Keyword[] Function WornHasKeywords(Actor akActor, Keyword[] akKwds) global
  return SPE_Actor.WornHasKeywords(akActor, akKwds)
EndFunction
Keyword[] Function WornHasKeywordStrings(Actor akActor, String[] akKwds) global
  return SPE_Actor.WornHasKeywordStrings(akActor, akKwds, false)
EndFunction
Function Dismount(Actor akTarget) global
  SPE_Actor.Dismount(akTarget)
EndFunction

; Inventory Processing
Form[] Function GetItemsByKeyword(ObjectReference akContainer, Keyword[] akKeywords, bool abMatchAll = false) global
  return SPE_ObjectRef.GetItemsByKeyword(akContainer, akKeywords, abMatchAll)
EndFunction
Form[] Function FilterFormsByKeyword(Form[] akForms, Keyword[] akKeywords, bool abMatchAll = false, bool abInvert = false) global
  return SPE_Utility.FilterFormsByKeyword(akForms, akKeywords, abMatchAll, abInvert)
EndFunction
Form[] Function FilterFormsByGoldValue(Form[] akForms, int aiValue, bool abGreaterThan = true, bool abEqual = true) global
  return SPE_Utility.FilterFormsByGoldValue(akForms, aiValue, abGreaterThan, abEqual)
EndFunction
Form[] Function FilterByEnchanted(ObjectReference akContainer, Form[] akForms, bool abEnchanted = true) global
  Form[] itms = SPE_ObjectRef.GetEnchantedItems(akContainer, true, true, false)
  If (abEnchanted)
    return SPE_Utility.IntersectArray_Form(akForms, itms)
  Else
    return SPE_Utility.FilterArray_Form(akForms, itms)
  EndIf
EndFunction
Form[] Function FilterByEquippedSlot(Form[] akForms, int[] aiSlots, bool abAll = false) global
  Armor[] armors = SPE_Utility.FilterBySlot(akForms, aiSlots, abAll)
  Form[] ret = Utility.CreateFormArray(armors.Length)
  int i = 0
  While (i < armors.Length)
    ret[i] = armors[i]
    i += 1
  EndWhile
  return ret
EndFunction
Int Function RemoveForms(ObjectReference akFromCont, Form[] akForms, ObjectReference akToCont = none) global
  return SPE_ObjectRef.RemoveItems(akFromCont, akForms, akToCont)
EndFunction

; Form Processing
bool Function FormHasKeyword(Form akItem, Keyword[] akKwds, bool abAll = false) global
  return SPE_Form.FormHasKeywords(akItem, akKwds, abAll)
EndFunction
bool Function FormHasKeywordStrings(Form akItem, String[] akKwds, bool abAll = false) global
  return SPE_Form.FormHasKeywordStrings(akItem, akKwds, abAll, false)
EndFunction

; Player
Actor Function GetPlayerSpeechTarget() global
  return SPE_Actor.GetPlayerSpeechTarget()
EndFunction

; String Processing
String Function ReplaceAt(String asStr, int aiIndex, String asReplace) global
  return SPE_Utility.ReplaceAt(asStr, aiIndex, asReplace)
EndFunction

; Input
String Function GetButtonForDXScanCode(int aiCode) global
  return SPE_Interface.GetButtonForDXScanCode(aiCode)
EndFunction
Function RegisterForAllAlphaNumericKeys(Form akForm) global
  akForm.RegisterForKey(57)
  int i = 2
  While (i < 12)
    akForm.RegisterForKey(i)
    i += 1
  EndWhile
  i = 16
  While (i < 26)
    akForm.RegisterForKey(i)
    i += 1
  EndWhile
  i = 30
  While i < 39
    akForm.RegisterForKey(i)
    i += 1
  EndWhile
  i = 44
  While (i < 51)
    akForm.RegisterForKey(i)
    i += 1
  EndWhile
EndFunction

Form[] Function GetInventoryNamedObjects(ObjectReference akContainer, String[] asNames) global
  return SPE_ObjectRef.GetInventoryNamedObjects(akContainer, asNames)
EndFunction

; unlike ObjecReference.GetItemHealthPercent, this will work on items in a container (range: 0.0-1.6)
float Function GetTemperFactor(ObjectReference akContainer, Form akItem) global
  return SPE_ObjectRef.GetTemperFactor(akContainer, akItem)
EndFunction

; geography
ObjectReference Function GetQuestMarker(Quest akQuest) global
  return SPE_Quest.GetQuestMarker(akQuest)
EndFunction

; if cell is exterior gets worldspace like normal, if interior looks for external doors and their worldspace
WorldSpace[] Function GetExteriorWorldSpaces(Cell akCell) global
  return SPE_Cell.GetExteriorWorldSpaces(akCell)
EndFunction
Location[] Function GetExteriorLocations(Cell akCell) global
  return SPE_Cell.GetExteriorLocations(akCell)
EndFunction

; unlike GetDistance this works even when one or both refs are in an interior or another cell
float Function GetTravelDistance(ObjectReference akRef1, ObjectReference akRef2) global
  return SPE_ObjectRef.GetTravelDistance(akRef1, akRef2)
EndFunction

; uses worldspace offsets to get absolute position on external refs
float Function GetAbsPosX(ObjectReference akRef) global
  return SPE_ObjectRef.GetAbsPosX(akRef)
EndFunction
float Function GetAbsPosY(ObjectReference akRef) global
  return SPE_ObjectRef.GetAbsPosY(akRef)
EndFunction
float Function GetAbsPosZ(ObjectReference akRef) global
  return SPE_ObjectRef.GetAbsPosZ(akRef)
EndFunction

; misc 
GlobalVariable Function GetGlobal(String asEditorID) global
  return SPE_GlobalVariable.GetGlobal(asEditorID)
EndFunction

; custom console proxy functions - ignore these
String Function ConsoleGetAbsPos(Form akRef) global
  Debug.Trace("ConsoleGetAbsPos - " + akRef)
  ObjectReference ref = akRef as ObjectReference
  If (!ref)
    return "not a valid ref"
  endIf
  float x = GetAbsPosX(ref)
  float y = GetAbsPosY(ref)
  float z = GetAbsPosZ(ref)
  Location loc = ref.GetCurrentLocation()
  String msg = ""
  While (loc)
    msg += loc.GetName() + "\n"
    Location parLoc = SPE_Location.GetParentLocation(loc)
    If (parLoc != loc)
      loc = parLoc
    Else
      loc = none
    EndIf
  EndWhile
  msg += "Position: (" + x + ", " + y + ", " + z + ")"
  return msg
EndFunction

String Function ConsoleGetPlayerAbsDist(Form akRef) global
  ObjectReference ref = akRef as ObjectReference
  If (!ref)
    return "not a valid ref"
  endIf
  return GetTravelDistance(Game.GetPlayer(), ref)
EndFunction

; Script Version Number
; This will no longer change and is only meant for backwards compatibility with mods made while this script was a standalone mod
Float Function GetVersion() global
  return 0.002010
EndFunction
