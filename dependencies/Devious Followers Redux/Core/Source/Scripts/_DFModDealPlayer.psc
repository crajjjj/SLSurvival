Scriptname _DFModDealPlayer extends ReferenceAlias

Keyword Property ddRestraintsKey Auto
Keyword Property ddChastityKey Auto
Keyword Property ddPiercingKey Auto

GlobalVariable Property _DFKeyFound Auto

Actor Property Player Auto


;Event OnPlayerLoadGame()
;    AddInventoryEventFilter(keyList)
;EndEvent

; This is a hazardous function. If the player takes a bazillion items, this could overload Papyrus.
; And because I don't know the exact items, there's no way to add an event filter that helps. (See above).
; So we try to be as fast here as we possibly can...
Event OnItemAdded(Form addItemBase, Int itemCount, ObjectReference addItemReference, ObjectReference theSourceContainer)

    ; The obvious risk here is that we don't service this list and it grows without bound...
    ; So don't allow that.
    If StorageUtil.FormListCount(Player, "DF_KeyRuleInventoryAddList") < 1000
        If addItemReference
            StorageUtil.FormListAdd(Player, "DF_KeyRuleInventoryAddList", addItemReference)
        Else
            StorageUtil.FormListAdd(Player, "DF_KeyRuleInventoryAddList", addItemBase)
        EndIf
    EndIf
    
    ;If _DFKeyFound.GetValue() > 0.0
    ;    Return
    ;EndIf
    ;If addItemReference
    ;    If addItemReference.HasKeyword(ddRestraintsKey) || addItemReference.HasKeyword(ddChastityKey) || addItemReference.HasKeyword(ddPiercingKey)
    ;        _DFKeyFound.SetValue(1.0)
    ;    EndIf
    ;Else
    ;    If addItemBase.HasKeyword(ddRestraintsKey) || addItemBase.HasKeyword(ddChastityKey) || addItemBase.HasKeyword(ddPiercingKey)
    ;        _DFKeyFound.SetValue(1.0)
    ;    EndIf
    ;EndIf

EndEvent
