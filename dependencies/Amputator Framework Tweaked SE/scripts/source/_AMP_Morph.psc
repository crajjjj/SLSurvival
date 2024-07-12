Scriptname _AMP_Morph extends Quest

String Property SLT_KEY = "Amputator.esp" AutoReadOnly

; NiNodes

string Property NINODE_RIGHT_UpperarmTwist1 = "NPC R UpperarmTwist1 [RUt1]" AutoReadOnly
string Property NINODE_LEFT_UpperarmTwist1= "NPC L UpperarmTwist1 [LUt1]" AutoReadOnly

string Property NINODE_RIGHT_Upperarm = "NPC R UpperArm [RUar]" AutoReadOnly
string Property NINODE_LEFT_Upperarm= "NPC L UpperArm [LUar]" AutoReadOnly

string Property NINODE_RIGHT_UpperarmTwist2 = "NPC R UpperarmTwist2 [RUt2]" AutoReadOnly
string Property NINODE_LEFT_UpperarmTwist2= "NPC L UpperarmTwist2 [LUt2]" AutoReadOnly

string Property NINODE_RIGHT_Forearm = "NPC R Forearm [RLar]" AutoReadOnly
string Property NINODE_LEFT_Forearm = "NPC L Forearm [LLar]" AutoReadOnly

string Property NINODE_RIGHT_ForearmTwist1 = "NPC R ForearmTwist1 [RLt1]" AutoReadOnly
string Property NINODE_LEFT_ForearmTwist1 = "NPC L ForearmTwist1 [LLt1]" AutoReadOnly

string Property NINODE_RIGHT_Calf = "NPC R Calf [RClf]" AutoReadOnly
string Property NINODE_LEFT_Calf = "NPC L Calf [LClf]" AutoReadOnly

string Property NINODE_RIGHT_Thigh = "NPC R Thigh [RThg]" AutoReadOnly
string Property NINODE_LEFT_Thigh = "NPC L Thigh [LThg]" AutoReadOnly

string Property NINODE_RIGHT_Hand = "NPC R Hand [RHnd]" AutoReadOnly
string Property NINODE_LEFT_Hand = "NPC L Hand [LHnd]" AutoReadOnly

string Property NINODE_RIGHT_Foot = "NPC R Foot [Rft ]" AutoReadOnly
string Property NINODE_LEFT_Foot = "NPC L Foot [Lft ]" AutoReadOnly

Function ResetAllLimbs(Actor akActor)
	SetNodeScale(akActor, NINODE_RIGHT_UpperarmTwist2, 1.0)
	SetNodeScale(akActor, NINODE_LEFT_UpperarmTwist2, 1.0)

	SetNodeScale(akActor, NINODE_RIGHT_Forearm, 1.0)
	SetNodeScale(akActor, NINODE_LEFT_Forearm, 1.0)

	SetNodeScale(akActor, NINODE_RIGHT_Calf, 1.0)
	SetNodeScale(akActor, NINODE_LEFT_Calf , 1.0)

	SetNodeScale(akActor, NINODE_RIGHT_Thigh, 1.0)
	SetNodeScale(akActor, NINODE_LEFT_Thigh, 1.0)
	SetNodeScale(akActor, NINODE_RIGHT_Hand, 1.0)
	SetNodeScale(akActor, NINODE_LEFT_Hand, 1.0)
	SetNodeScale(akActor, NINODE_RIGHT_Foot, 1.0)
	SetNodeScale(akActor, NINODE_LEFT_Foot , 1.0)
	SetNodeScale(akActor, NINODE_RIGHT_Upperarm, 1.0)
	SetNodeScale(akActor, NINODE_LEFT_Upperarm, 1.0)
EndFunction

Function MorphActor(Actor akActor , int morphType, int LeftRight)
	; LeftRight: 1 - Left, 2 - right
	; morphType: 0 - Heal, 1 - Feet, 2 - Lower leg, 3 - Upper leg, 4 - hand, 5 - Forearm, 6 - Upper arm
	
	if(morphType == 0)
		ResetAllLimbs(akactor)

	elseif(morphType == 1) ; FEET
		If(LeftRight == 2 )
			SetNodeScale(akActor,NINODE_RIGHT_Foot, 0.01)
		else
			SetNodeScale(akActor,NINODE_LEFT_Foot , 0.01)
		endif
		
	elseif(morphType == 2) ; LOWER LEGS
		If(LeftRight == 2 )
			SetNodeScale(akActor,NINODE_RIGHT_Calf, 0.01)
		else
			SetNodeScale(akActor,NINODE_LEFT_Calf , 0.01)
		endif
		
	elseif(morphType == 3) ; UPPER LEGS
	If(LeftRight == 2 )
		SetNodeScale(akActor,NINODE_RIGHT_Thigh, 0.01)
	else
		SetNodeScale(akActor,NINODE_LEFT_Thigh, 0.01)
	endif
	
	elseif(morphType == 4) ; HANDS
		If(LeftRight == 2 )
			SetNodeScale(akActor,NINODE_RIGHT_Hand, 0.01)
		else
			SetNodeScale(akActor,NINODE_LEFT_Hand, 0.01)
		endif
		
	elseif(morphType == 5) ;FOREARM
		If(LeftRight == 2 )
			SetNodeScale(akActor,NINODE_RIGHT_Forearm, 0.01)
		else
			SetNodeScale(akActor,NINODE_LEFT_Forearm, 0.01)
		endif
		
	elseif(morphType == 6) ;UPPERARM
		If(LeftRight == 2 )
			SetNodeScale(akActor,NINODE_RIGHT_Upperarm, 0.01)
		else
			SetNodeScale(akActor,NINODE_LEFT_Upperarm, 0.01)
		endif
	Endif
	NiOverride.UpdateModelWeight(akActor)
EndFunction

Function RemoveNodeTransforms(Actor akActor, bool isFemale, string nodeName)
	NiOverride.RemoveNodeTransformScale(akActor, false, isFemale, nodeName, SLT_KEY)
	NiOverride.RemoveNodeTransformScale(akActor, true, isFemale, nodeName, SLT_KEY)
EndFunction

Function SetNodeScale(Actor akActor, string nodeName, float value)
	;Debug.Trace("_AMP_: Set " + nodeName + " on " + akActor + " to " + value)
	if (akActor)
		if (Game.GetModbyName("SexLab Inflation Framework.esp") != 255)
			If value != 1.0
				int SLIF_hideNode = ModEvent.Create("SLIF_hideNode")
				If (SLIF_hideNode)
					ModEvent.PushForm(SLIF_hideNode, akActor)
					ModEvent.PushString(SLIF_hideNode, "Amputator Framework")
					ModEvent.PushString(SLIF_hideNode, nodeName)
					ModEvent.PushFloat(SLIF_hideNode, value)
					ModEvent.PushString(SLIF_hideNode, SLT_KEY)
					ModEvent.Send(SLIF_hideNode)
				EndIf
			Else
				int SLIF_showNode = ModEvent.Create("SLIF_showNode")
				If (SLIF_showNode)
					ModEvent.PushForm(SLIF_showNode, akActor)
					ModEvent.PushString(SLIF_showNode, "Amputator Framework")
					ModEvent.PushString(SLIF_showNode, nodeName)
					ModEvent.Send(SLIF_showNode)
				EndIf
			Endif
		
		else
			bool isFemale = akActor.GetActorBase().GetSex() == 1
			If value == 1.0
				NiOverride.RemoveNodeTransformScale(akActor, false, isFemale, nodeName, SLT_KEY)
				NiOverride.RemoveNodeTransformScale(akActor, true, isFemale, nodeName, SLT_KEY)
			Else
				NiOverride.AddNodeTransformScale(akActor, false, isFemale, nodeName, SLT_KEY, value)
				NiOverride.AddNodeTransformScale(akActor, true, isFemale, nodeName, SLT_KEY, value)
			Endif
			NiOverride.UpdateNodeTransform(akActor, false, isFemale, nodeName)
			NiOverride.UpdateNodeTransform(akActor, true, isFemale, nodeName)
		endif
	endif
EndFunction

float Function GetNodeScale(Actor akActor, bool isFemale, string nodeName)
	return NiOverride.GetNodeTransformScale(akActor, false, isFemale, nodeName, SLT_KEY)
EndFunction
