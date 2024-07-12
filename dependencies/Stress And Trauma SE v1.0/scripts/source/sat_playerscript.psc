Scriptname SAT_PlayerScript extends ReferenceAlias

Potion[] Property alcohol  Auto  
Potion[] Property drugs  Auto  
SAT_UpkeepScript Property main auto

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)

	if alcohol.find(akBaseObject as Potion) >= 0
		main.alcohol()
	elseif drugs.find(akBaseObject as Potion) >= 0
		main.drug()
	endif

endEvent

