Scriptname _JSW_BB_DetectFertilityScript extends ActiveMagicEffect  

_JSW_BB_Storage Property Storage  Auto            ; Storage data helper

GlobalVariable Property CycleDuration  Auto       ; Full duration of the menstrual cycle, eg. 28 days
GlobalVariable Property OvulationBegin  Auto      ; Starting day of ovulation, eg. day 8
GlobalVariable Property OvulationEnd  Auto        ; Ending day of ovulation, eg. day 16
GlobalVariable Property EggLife  Auto             ; The age an egg can reach before it is no longer viable, eg 1.0 days

EffectShader Property LifeDetected  Auto          ; Fired for ovulating actors
EffectShader Property LifeDetectedEnemy  Auto     ; Fired for pregnant actors

; Const values: relevant form types for the cell scan
int _kNPC = 43
int _kLeveledCharacter = 44
int _kCharacter = 62

event OnEffectStart(Actor akTarget, Actor akCaster)
	int n = Storage.TrackedActors.Length
	
	while (n)
		n -= 1
		
		Actor kActor = Storage.TrackedActors[n] as Actor
		
		if (kActor.Is3DLoaded())
			int cycleDay = ((Storage.LastGameHours[n] as int) + Storage.LastGameHoursDelta[n]) % (CycleDuration.GetValueInt() + 1)
			
			if (Storage.LastConception[n] > 0.0)
				LifeDetectedEnemy.Play(kActor)
			elseIf ((cycleDay >= OvulationBegin.GetValueInt() && cycleDay <= OvulationEnd.GetValueInt()) || \
					(Storage.LastOvulation[n] > 0.0 && Storage.LastOvulation[n] <= EggLife.GetValue()))
				
				LifeDetected.Play(kActor)
			endIf
		endIf
	endWhile
endEvent

event OnEffectFinish(Actor akTarget, Actor akCaster)
	int n = Storage.TrackedActors.Length
	
	while (n)
		n -= 1
		LifeDetectedEnemy.Stop(Storage.TrackedActors[n] as Actor)
		LifeDetected.Stop(Storage.TrackedActors[n] as Actor)
	endWhile
endEvent

Form[] function GetAllCellActors()
{Scan for all relevant NPCs in the current cell}
	; Game.GetPlayer() is very slow compared to a property, but
	; we're only calling it once in this case, so it should be fine
	Cell currentCell = Game.GetPlayer().GetParentCell()
	Form[] result
	int n1 = currentCell.GetNumRefs(_kNPC) as int
	int n2 = currentCell.GetNumRefs(_kCharacter) as int
	int n3 = currentCell.GetNumRefs(_kLeveledCharacter) as int
	int n = n1 + n2 + n3
	int index = 0
	
	if (!n)
		return result
	endIf
	
	result = Utility.ResizeFormArray(result, result.Length + n, none)
	
	while (n1)
		n1 -= 1
		result[index] = currentCell.GetNthRef(n1, _kNPC) as Actor
		index += 1
	endWhile
	
	while (n2)
		n2 -= 1
		result[index] = currentCell.GetNthRef(n2, _kCharacter) as Actor
		index += 1
	endWhile
	
	while (n3)
		n3 -= 1
		result[index] = currentCell.GetNthRef(n3, _kLeveledCharacter) as Actor
		index += 1
	endWhile
	
	return result
endFunction