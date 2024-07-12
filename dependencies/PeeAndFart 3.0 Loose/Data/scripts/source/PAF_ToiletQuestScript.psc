Scriptname PAF_ToiletQuestScript extends Quest

PAF_MainQuestScript property PAF_MainQuest auto

Actor property PlayerREF auto

Furniture property PAF_ToiletHouseFurniture auto
Furniture property PAF_IndoorToiletFurniture auto
Door property PAF_ToiletDoor auto
ReferenceAlias property PAF_CurrentToiletAlias auto
ReferenceAlias property PAF_ToiletUserAlias auto
Package property PAF_UseToiletPackage auto
int property PAF_NumberToilets auto

ObjectReference[] property PAF_Toilets auto
ObjectReference[] property PAF_ToiletDoors auto

Actor property PAF_DummyNPC auto

int MAX_TOILET_COUNT
int property _toilet_index auto

bool _lock_toilets

Event OnUpdate()		
	PAF_NumberToilets = _toilet_index
	RegisterForSingleUpdate(10)
EndEvent

function ResetToilets()		
	PAF_Toilets = new ObjectReference[20]
	PAF_ToiletDoors = new ObjectReference[20]	
	MAX_TOILET_COUNT = 20
	_toilet_index = 0
	_lock_toilets = false
endfunction

int function GetToiletInRange(Actor a_actor)
	int i = 0
	float nearest = -1
	int nearest_index = -1	
	while i < _toilet_index
		if ((PAF_Toilets[i].GetParentCell() == a_actor.GetParentCell()) && PAF_Toilets[i].Is3DLoaded())			
			float distanceToActor = a_actor.GetDistance(PAF_Toilets[i])						
			if (nearest > distanceToActor || nearest_index == -1)
				nearest = distanceToActor
				nearest_index = i
			endif
		endif
		i += 1
	endwhile	
	return nearest_index
endfunction

int function GetToilet(Actor a_actor)
	if (PAF_MainQuest.HasDiaper(a_actor))
		return -1
	endif	
	_lock_toilets = true	
	int i = GetToiletInRange(a_actor)
	if (i != -1)	
		PAF_CurrentToiletAlias.ForceRefto(PAF_Toilets[i])
		PAF_ToiletUserAlias.ForceRefto(a_actor)		
		Utility.Wait(10)		
		int j = 0
		while j < 6
			if (a_actor.GetSitState() == 3)
				if (PAF_ToiletDoors[i] != PAF_Toilets[i])
					PAF_ToiletDoors[i].Activate(a_actor)
				endif
				if (PAF_ToiletDoors[i] != PAF_Toilets[i])
					PAF_MainQuest.PAF_NPCQuest.UseToilet(a_actor)
				else
					PAF_MainQuest.PAF_NPCQuest.UseToilet(a_actor, true)
				endif
				if (PAF_ToiletDoors[i] != PAF_Toilets[i])
					PAF_ToiletDoors[i].Activate(a_actor)
				endif				
				PAF_ToiletUserAlias.ForceRefto(PAF_Toilets[i])
				PAF_CurrentToiletAlias.ForceRefto(PAF_Toilets[i])
				Utility.Wait(5)
				_lock_toilets = false
				PAF_CurrentToiletAlias.ForceRefto(PAF_DummyNPC)
				PAF_ToiletUserAlias.ForceRefto(PAF_DummyNPC)
				return 0
			else
				if (a_actor.GetParentCell() != PAF_MainQuest.PlayerREF.GetParentCell())
					PAF_CurrentToiletAlias.ForceRefto(PAF_DummyNPC)
					PAF_ToiletUserAlias.ForceRefto(PAF_DummyNPC)
					return -1
				endif						
			endif			
			j += 1
			Utility.Wait(5)
		endwhile
	endif
	_lock_toilets = false
	PAF_CurrentToiletAlias.ForceRefto(PAF_DummyNPC)
	PAF_ToiletUserAlias.ForceRefto(PAF_DummyNPC)
	return -1
endfunction

int function WaitLockedToilets()
	int j = 0;
	while(_lock_toilets || j >= 120)
		j += 1
		Utility.Wait(1)
	endWhile	
	if (j == 120)
		_lock_toilets = false
		return -1		
	endif	
	_lock_toilets = true
	return 0
endfunction

function DeleteToilets()
 	
	_lock_toilets = false
	Debug.Notification("PAF: Resetting toilets...")		
	int i = 0;
	while i < MAX_TOILET_COUNT
		if (PAF_Toilets[i] != none)
			PAF_Toilets[i].Disable()
			PAF_ToiletDoors[i].Disable()
			PAF_Toilets[i].Delete()
			PAF_ToiletDoors[i].Delete()			
		endif
		PAF_Toilets[i] = none
		PAF_ToiletDoors[i] = none
		i += 1
	endwhile
	_toilet_index = 0
			
endfunction

function PlaceToilet(ObjectReference target, bool bucket = false)

	if (WaitLockedToilets() == -1)
		Debug.Notification("PAF: could not process toilet...")	
		return
	endif

	int i = IsTrackedToilet(target)
	if (i != -1)
		RemoveToilet(i)
		_lock_toilets = false
		return
	endif
	
	if (bucket)		
		float z_player_pos = PlayerREF.GetPositionZ()
		float z_player = PlayerREF.GetAngleZ()
		float x_offset = PlayerREF.GetPositionX() + 100.0 * Math.Sin(z_player)
		float y_offset = PlayerREF.GetPositionY() + 100.0 * Math.Cos(z_player)	
		ObjectReference toilet = PlayerREF.PlaceAtMe(PAF_IndoorToiletFurniture, abForcePersist = true)
		toilet.SetPosition(x_offset, y_offset, z_player_pos)
		toilet.SetAngle(0, 0, ((z_player + 180) as int) % 360)
		toilet.SetScale(1.3)
		if (AddToilet(toilet, toilet) == -1)
			toilet.Disable()
			toilet.Delete()
		endif	
	else	
		ObjectReference toilet = PlayerREF.PlaceAtMe(PAF_ToiletHouseFurniture, abForcePersist = true)
		float z_player = PlayerREF.GetAngleZ()
		float x_offset = PlayerREF.GetPositionX() + 200.0 * Math.Sin(z_player)
		float y_offset = PlayerREF.GetPositionY() + 200.0 * Math.Cos(z_player)	
		toilet.SetPosition(x_offset, y_offset, PlayerREF.GetPositionZ() + 3)
		toilet.SetAngle(0, 0, ((z_player + 180) as int) % 360)
		toilet.SetScale(1.0)	
		ObjectReference toiletDoor = PlayerREF.PlaceAtMe(PAF_ToiletDoor, abForcePersist = true)
		x_offset = PlayerREF.GetPositionX() + 130.0 * Math.Sin(z_player)
		y_offset = PlayerREF.GetPositionY() + 130.0 * Math.Cos(z_player)
		toiletDoor.SetPosition(x_offset, y_offset, PlayerREF.GetPositionZ() + 15)
		toiletDoor.SetAngle(0, 0, ((z_player + 180) as int) % 360)
		toiletDoor.SetScale(0.70)
		
		if (AddToilet(toilet, toiletDoor) == -1)
			toilet.Disable()
			toilet.Delete()
			toiletDoor.Disable()
			toiletDoor.Delete()
		endif		
	endif
	

	_lock_toilets = false
endfunction

int function AddToilet(ObjectReference a_toilet, ObjectReference a_door)	
	int i = IsTrackedToilet(a_toilet)
	if (i != -1)		
		RemoveToilet(i)
		return 0
	else		
		if (_toilet_index <= MAX_TOILET_COUNT - 1)
			PAF_Toilets[_toilet_index] = a_toilet
			PAF_ToiletDoors[_toilet_index] = a_door			
			_toilet_index += 1			
			Debug.Notification("PAF: Adding toilet.")
			return 0
		else
			Debug.Notification("PAF: You cannot add more toilets! Please deconstruct some...")
			return -1
		endif	
	endif
endfunction

function RemoveToilet(int i)
	if (_toilet_index == 1) ; one actor	
		PAF_Toilets[0].Disable()
		PAF_ToiletDoors[0].Disable()
		PAF_Toilets[0].Delete()
		PAF_ToiletDoors[0].Delete()
		PAF_Toilets[0] = none
		PAF_ToiletDoors[0] = none
	else
		if (i == _toilet_index - 1) ; last actor
			PAF_Toilets[i].Disable()
			PAF_ToiletDoors[i].Disable()
			PAF_Toilets[i].Delete()
			PAF_ToiletDoors[i].Delete()
			PAF_Toilets[i] = none
			PAF_ToiletDoors[i] = none
		else	; switch actor with last			
			PAF_Toilets[i].Disable()
			PAF_ToiletDoors[i].Disable()
			PAF_Toilets[i].Delete()
			PAF_ToiletDoors[i].Delete()
			PAF_Toilets[i] = PAF_Toilets[_toilet_index - 1]
			PAF_ToiletDoors[i] = PAF_ToiletDoors[_toilet_index - 1]
			PAF_Toilets[_toilet_index - 1] = none
			PAF_ToiletDoors[_toilet_index - 1] = none
		endif
	endif
	_toilet_index -= 1	
	Debug.Notification("PAF: Toilet removed.")
endfunction

int function IsTrackedToilet(ObjectReference a_toilet)
	int i = 0	
	while (i < MAX_TOILET_COUNT)
		if (PAF_Toilets[i] != none)
			if (PAF_Toilets[i] == a_toilet)	
				return i
			endif
		endif
		if (PAF_ToiletDoors[i] != none)
			if (PAF_ToiletDoors[i] == a_toilet)	
				return i
			endif
		endif		
		i += 1
	endwhile	
	return -1
endfunction