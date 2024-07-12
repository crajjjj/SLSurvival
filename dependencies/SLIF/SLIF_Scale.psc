Scriptname SLIF_Scale Hidden

;/
	Function to check if a compatible version of NiOverride is installed.
/;
bool function IsValidNiOverrideVersion() global
	return StorageUtil.GetIntValue(none, "slif_valid_nioverride", 0) as bool
endFunction

bool function IsFemale(Actor kActor) global
	return kActor.GetLeveledActorBase().GetSex() == 1
endFunction

bool function IsPlayer(Actor kActor) global
	return kActor == Game.GetPlayer()
endFunction

bool function IsUnique(Actor kActor) global
	return kActor.GetLeveledActorBase().IsUnique() || (SLIF_Config.GetInt("non_unique_npcs_use_nio") as bool)
endFunction

bool function Is3DLoaded(Actor kActor) global
	return kActor.Is3DLoaded()
endFunction

;/
	Method to set the value of the given node
/;
Function SetNodeScale(Actor kActor, String aToString, string node, float value) global
	SLIF_Util.SetFloatValue(kActor, "All Mods", node, value)
	if (StorageUtil.GetIntValue(kActor, node + "_hidden") as bool)
		HideNodeScale(kActor, node)
		return
	endIf
	String slif = "SexLab Inflation Framework.esp"
	float start = Utility.GetCurrentRealTime()
	if (kActor)
		bool isFemale   = IsFemale(kActor)
		bool isPlayer   = IsPlayer(kActor)
		bool isUnique   = IsUnique(kActor)
		bool isLoaded   = Is3DLoaded(kActor)
		bool isValidNiO = IsValidNiOverrideVersion()
		
		int  gender     = SLIF_Main.GetGender(kActor)
		bool genderless = (gender == 4)
		
		if (node != "")
			StorageUtil.SetFloatValue(kActor, slif + node, value)
			if (genderless)
				RemoveNodeTransforms(kActor, node, slif, isLoaded)
				SetBodyMorphsByArray(kActor, slif, GetPathByNode(node), isPlayer)
				NetImmerse.SetNodeScale(kActor, node, 1.0, false)
				if (isPlayer)
					NetImmerse.SetNodeScale(kActor, node, 1.0, true)
				endIf
			elseIf (isUnique && isValidNiO)
				String path = GetPathByNode(node)
				if (path != "")
					SetMorphValue(kActor, slif, path, value, isPlayer, isFemale, isLoaded)
				else
					SetNodeTransformValue(kActor, slif, node, value, 100.0, isPlayer, isFemale, isLoaded)
					UpdateNodeTransformsConditional(kActor, node, slif, isLoaded)
				endIf
			else
				if (NetImmerse.HasNode(     kActor, node,        false))
					NetImmerse.SetNodeScale(kActor, node, value, false)
				endIf
			endIf
		endIf
		float end = Utility.GetCurrentRealTime()
		SLIF_Debug.Trace("[SLIF_Scale] SetNodeScale:        " + aToString + " node: " + node + ", value: " + value + ", time_diff: " + (end - start))
	endIf
	
EndFunction

Function SetNodeScales(Actor kActor, String aToString, String leftNode, String rightNode, float leftValue, float rightValue) global
	float value = SLIF_Math.Average(leftValue, rightValue)
	SLIF_Util.SetFloatValue(kActor, "All Mods", leftNode,  value)
	SLIF_Util.SetFloatValue(kActor, "All Mods", rightNode, value)
	if (StorageUtil.GetIntValue(kActor, leftNode + "_hidden") as bool || StorageUtil.GetIntValue(kActor, rightNode + "_hidden") as bool)
		SetNodeScale(kActor, aToString, leftNode,  value)
		SetNodeScale(kActor, aToString, rightNode, value)
		return
	endIf
	String slif = "SexLab Inflation Framework.esp"
	float start = Utility.GetCurrentRealTime()
	if (kActor)
		bool isFemale   = IsFemale(kActor)
		bool isPlayer   = IsPlayer(kActor)
		bool isUnique   = IsUnique(kActor)
		bool isLoaded   = Is3DLoaded(kActor)
		bool isValidNiO = IsValidNiOverrideVersion()
		
		int  gender     = SLIF_Main.GetGender(kActor)
		bool genderless = (gender == 4)
		
		String syncKey   = SLIF_Util.GetSyncKeyFromNodes(leftNode, rightNode)
		
		if (leftNode != "" && rightNode != "")
			StorageUtil.SetFloatValue(kActor, slif + leftNode,  value)
			StorageUtil.SetFloatValue(kActor, slif + rightNode, value)
			if (genderless)
				RemoveNodeTransforms(kActor, leftNode,  slif, isLoaded)
				RemoveNodeTransforms(kActor, rightNode, slif, isLoaded)
				SetBodyMorphsByArray(kActor, slif, GetPathByDualNode(leftNode, rightNode), isPlayer)
				if (NetImmerse.HasNode(     kActor, leftNode,      false))
					NetImmerse.SetNodeScale(kActor, leftNode, 1.0, false)
					if (isPlayer)
						NetImmerse.SetNodeScale(kActor, leftNode, 1.0, true)
					endIf
				endIf
				if (NetImmerse.HasNode(     kActor, rightNode,      false))
					NetImmerse.SetNodeScale(kActor, rightNode, 1.0, false)
					if (isPlayer)
						NetImmerse.SetNodeScale(kActor, rightNode, 1.0, true)
					endIf
				endIf
			elseIf (isUnique && isValidNiO)
				String path = GetPathByDualNode(leftNode, rightNode)
				if (path != "")
					SetMorphValue(kActor, slif, path, value, isPlayer, isFemale, isLoaded)
				else
					SetNodeTransformValue(kActor, slif, leftNode,  value, 100.0, isPlayer, isFemale, isLoaded)
					SetNodeTransformValue(kActor, slif, rightNode, value, 100.0, isPlayer, isFemale, isLoaded)
					UpdateNodeTransformsConditional(kActor, leftNode,  slif, isLoaded)
					UpdateNodeTransformsConditional(kActor, rightNode, slif, isLoaded)
				endIf
			else
				if (NetImmerse.HasNode(     kActor, leftNode,        false))
					NetImmerse.SetNodeScale(kActor, leftNode, value, false)
				endIf
				if (NetImmerse.HasNode(     kActor, rightNode,        false))
					NetImmerse.SetNodeScale(kActor, rightNode, value, false)
				endIf
			endIf
		endIf
		float end = Utility.GetCurrentRealTime()
		SLIF_Debug.Trace("[SLIF_Scale] SetNodeScales:       " + aToString + " node: " + syncKey + ", value: " + value + ", time_diff: " + (end - start))
	endIf
	
EndFunction

function HideNodeScale(Actor kActor, String node) global
	String slif   = "SexLab Inflation Framework.esp"
	bool isPlayer = IsPlayer(kActor)
	bool isFemale = IsFemale(kActor)
	bool isLoaded = Is3DLoaded(kActor)
	float value   = StorageUtil.GetFloatValue(kActor, node + "_hidden", 0.0000001)
	SetNodeTransformValue(kActor, slif, node, value, 100.0, isPlayer, isFemale, isLoaded)
	UpdateNodeTransformsConditional(kActor, node, slif, isLoaded)
endFunction

string function GetPathByDualNode(String leftNode, String rightNode) global
	if (leftNode == "NPC L Breast" && rightNode == "NPC R Breast")
		return ".breasts."
	elseIf (leftNode == "NPC L Butt" && rightNode == "NPC R Butt")
		return ".butt."
	endIf
	return ""
endFunction

string function GetPathByNode(String node) global
	if (node == "NPC Belly")
		return ".belly."
	elseIf (node == "NPC L Breast" || node == "NPC R Breast")
		return ".breasts."
	elseIf (node == "NPC L Butt" || node == "NPC R Butt")
		return ".butt."
	endIf
	return ""
endFunction

function SetMorphValue(Actor kActor, String slif, String path, float value, bool isPlayer, bool isFemale, bool isLoaded) global
	String json = "SexLab Inflation Framework/NiOverride.json"
	String[] members  = JsonUtil.PathMembers(json, path)
	int idx = 0
	while(idx < members.length)
		String member  = members[idx]
		String[] nodes = SLIF_Util.GetPathNodes(json, path, member)
		float default = 0.0
		if (member == "NiOverride")
			default = 100.0
		endIf
		float nio = SLIF_Morphs.GetValue("NiOverride", path, member, 0, isPlayer, default)
		int size  = nodes.length
		int i = 0
		while(i < size)
			String node = nodes[i]
			value = StorageUtil.GetFloatValue(kActor, slif + node, value)
			SetNodeTransformValue(kActor, slif, node, value, nio, isPlayer, isFemale, isLoaded)
			i += 1
		endWhile
			i = 0
		while(i < size)
			String node = nodes[i]
			UpdateNodeTransformsConditional(kActor, node, slif, isLoaded)
			i += 1
		endWhile
		idx += 1
	endWhile
	
	SetBodyMorphsByArray(kActor, slif, path, isPlayer)
endFunction

function SetBodyMorphsByArray(Actor kActor, String slif, String path, bool isPlayer) global
	if (path != "")
		String json            = "SexLab Inflation Framework/Bodymorphs.json"
		String[] breast_morphs = JsonUtil.PathMembers(json, ".breasts.")
		String[] belly_morphs  = JsonUtil.PathMembers(json, ".belly.")
		String[] butt_morphs   = JsonUtil.PathMembers(json, ".butt.")
		bool has_breasts       = StorageUtil.HasFloatValue(kActor, slif + "NPC L Breast") || StorageUtil.HasFloatValue(kActor, slif + "NPC R Breast")
		bool has_belly         = StorageUtil.HasFloatValue(kActor, slif + "NPC Belly")
		bool has_butt          = StorageUtil.HasFloatValue(kActor, slif + "NPC L Butt") || StorageUtil.HasFloatValue(kActor, slif + "NPC R Butt")
		float breast_value     = (StorageUtil.GetFloatValue(kActor, slif + "NPC L Breast", 1.0) + StorageUtil.GetFloatValue(kActor, slif + "NPC R Breast", 1.0)) / 2
		float belly_value      = StorageUtil.GetFloatValue(kActor, slif + "NPC Belly", 1.0)
		float butt_value       = (StorageUtil.GetFloatValue(kActor, slif + "NPC L Butt", 1.0) + StorageUtil.GetFloatValue(kActor, slif + "NPC R Butt", 1.0)) / 2
		String[] morphs
		if (path == ".breasts.")
			morphs = breast_morphs
		elseIf (path == ".belly.")
			morphs = belly_morphs
		elseIf (path == ".butt.")
			morphs = butt_morphs
		endIf
		int size = morphs.length
		int idx  = 0
		while(idx < size)
			String morphName = morphs[idx]
			if (SLIF_Morphs.GetValue("BodyMorph", path, morphName, 0, isPlayer, 0.0) > 0.0)
				SetBodyMorphs(kActor, slif, json, isPlayer, morphName, breast_morphs, belly_morphs, butt_morphs, has_breasts, has_belly, has_butt, breast_value, belly_value, butt_value)
			endIf
			idx += 1
		endWhile
		UpdateMorphs(kActor)
	endIf
endFunction

function SetBodyMorphs(Actor kActor, String slif, String json, bool isPlayer, String morphName, String[] breast_morphs, String[] belly_morphs, String[] butt_morphs, bool has_breasts, bool has_belly, bool has_butt, float breast_value, float belly_value, float butt_value) global
	float value_breasts = 0.0
	float value_belly   = 0.0
	float value_butt    = 0.0
	if (has_breasts && SLIF_Util.StringArrayHas(breast_morphs, morphName))
		value_breasts = CalculateBodyMorphValue(json, ".breasts.", morphName, isPlayer, breast_value)
	endIf
	if (has_belly && SLIF_Util.StringArrayHas(belly_morphs, morphName))
		value_belly   = CalculateBodyMorphValue(json, ".belly.",   morphName, isPlayer, belly_value)
	endIf
	if (has_butt && SLIF_Util.StringArrayHas(butt_morphs, morphName))
		value_butt    = CalculateBodyMorphValue(json, ".butt.",    morphName, isPlayer, butt_value)
	endIf
	StorageUtil.SetFloatValue(kActor, "slif_scale_" + morphName, value_breasts + value_belly + value_butt)
	float value = (StorageUtil.GetFloatValue(kActor, "slif_scale_" + morphName) + StorageUtil.GetFloatValue(kActor, "slif_" + morphName))
	SetBodyMorph(kActor, slif, morphName, value)
endFunction

float function CalculateBodyMorphValue(String json, String path, String morphName, bool isPlayer, float value) global
	int default   = SLIF_Util.GetPathReverse(json, path, morphName) as int
	float percent = SLIF_Morphs.GetValue("BodyMorph", path, morphName, 0, isPlayer,  0.0)
	bool reverse  = SLIF_Morphs.GetValue("BodyMorph", path, morphName, 1, isPlayer, default)
	float steps   = SLIF_Morphs.GetValue("BodyMorph", path, morphName, 2, isPlayer, 10.0)
	float minimum = SLIF_Morphs.GetValue("BodyMorph", path, morphName, 3, isPlayer,  0.0)
	float maximum = SLIF_Morphs.GetValue("BodyMorph", path, morphName, 4, isPlayer, 20.0)
	value = SLIF_Math.MaxFloat(0.0, value)
	if (value < minimum)
		value = (value - minimum)
	else
		value -= minimum
	endIf
	value = SLIF_Math.MinFloat(value, (maximum - minimum))
	value *= (percent / 100.0)
	value /= steps
	if (reverse)
		return -value
	endIf
	return value
endFunction

bool function SetBodyMorph(Actor kActor, String slif, String morphName, float value) global
	if value != 0.0
		NiOverride.SetBodyMorph(kActor, morphName, slif, value)
		return true
	endIf
	if (NiOverride.HasBodyMorph(kActor, morphName, slif))
		NiOverride.ClearBodyMorph(kActor, morphName, slif)
	endIf
	return false
endFunction

bool function HasMorphs(Actor kActor) global
	return NiOverride.GetMorphNames(kActor).length > 0
endFunction

function UpdateMorphs(Actor kActor) global
	if (Is3DLoaded(kActor) && HasMorphs(kActor))
		NiOverride.UpdateModelWeight(kActor)
	endIf
endFunction

function SetNodeTransformValue(Actor kActor, String slif, String node, float value, float percent, bool isPlayer, bool isFemale, bool isLoaded) global
	value = SLIF_Math.SetBounds(value, 0.0000001, 100.0) ;SLIF_Util.AbsoluteZero(node)
	value *= (percent / 100.0)
	RemoveNodeTransformScale(kActor, node, slif, true,  !isFemale, isLoaded)
	RemoveNodeTransformScale(kActor, node, slif, false, !isFemale, isLoaded)
	if (percent > 0.0)
		if (isPlayer)
			SetNodeTransformScale(kActor, node, slif, value, false, isFemale)
			SetNodeTransformScale(kActor, node, slif, value, true,  isFemale)
		else
			SetNodeTransformScale(   kActor, node, slif, value, false, isFemale)
			RemoveNodeTransformScale(kActor, node, slif,        true,  isFemale, isLoaded)
		endIf
	else
		RemoveNodeTransformScale(kActor, node, slif, false, isFemale, isLoaded)
		RemoveNodeTransformScale(kActor, node, slif, true,  isFemale, isLoaded)
	endIf
endFunction

function SetNodeTransformScale(Actor kActor, String node, String slif, float value, bool firstPerson, bool isFemale) global
	If (NetImmerse.HasNode(kActor, node, firstPerson))
		If value != 1.0
			NiOverride.AddNodeTransformScale(kActor, firstPerson, isFemale, node, slif, value)
		Else
			NiOverride.RemoveNodeTransformScale(kActor, firstPerson, isFemale, node, slif)
		Endif
	Endif
endFunction

;/
	Function to the remove the certain node from the actor
/;
Function RemoveNodeScale(Actor kActor, String aToString, String node, String slif) global
	float start = Utility.GetCurrentRealTime()
	
	if (kActor)
		bool isPlayer = IsPlayer(kActor)
		bool isLoaded = Is3DLoaded(kActor)
		
		SLIF_Util.UnsetFloatValueConditional(kActor, slif + node)
		
		RemoveNodeTransforms(kActor, node, slif, isLoaded)
		SetBodyMorphsByArray(kActor, slif, GetPathByNode(node), isPlayer)
		
		float end = Utility.GetCurrentRealTime()
		SLIF_Debug.Trace("[SLIF_Scale] RemoveNodeScale:     " + aToString + " node: " + node + ", time_diff: " + (end - start))
	endIf
	
endFunction

function RemoveNodeTransformScales(Actor kActor, String node, String slif) global
	if (kActor)
		bool isLoaded = Is3DLoaded(kActor)
		RemoveNodeTransformScale(kActor, node, slif, true,  true,  isLoaded)
		RemoveNodeTransformScale(kActor, node, slif, true,  false, isLoaded)
		RemoveNodeTransformScale(kActor, node, slif, false, true,  isLoaded)
		RemoveNodeTransformScale(kActor, node, slif, false, false, isLoaded)
	endIf
endFunction

function RemoveNodeTransformScale(Actor kActor, String node, String slif, bool firstPerson, bool isFemale, bool isLoaded) global
	if (NiOverride.HasNodeTransformScale(kActor, firstPerson, isFemale, node, slif))
		NiOverride.RemoveNodeTransformScale(kActor, firstPerson, isFemale, node, slif)
		if (isLoaded)
			NiOverride.UpdateNodeTransform(kActor, firstPerson, isFemale, node)
		endIf
	endIf
endFunction

function RemoveNode(Actor kActor, String node, bool firstPerson) global
	if (NetImmerse.HasNode(kActor, node, firstPerson))
		NetImmerse.SetNodeScale(kActor, node, 1.0, firstPerson)
	endIf
endFunction
	
function RemoveNodes(Actor kActor, String node) global
	RemoveNode(kActor, node, true)
	RemoveNode(kActor, node, false)
endFunction

function RemoveNodeTransforms(Actor kActor, String node, String slif, bool isLoaded) global
	if (node != "")
		RemoveNodeTransformScale(kActor, node, slif, true,  true,  isLoaded)
		RemoveNodeTransformScale(kActor, node, slif, true,  false, isLoaded)
		RemoveNodeTransformScale(kActor, node, slif, false, true,  isLoaded)
		RemoveNodeTransformScale(kActor, node, slif, false, false, isLoaded)
	endIf
endFunction

function UpdateNodeTransformsConditional(Actor kActor, String node, String slif, bool isLoaded) global
	UpdateNodeTransformConditional(kActor, false, true,  node, slif, isLoaded)
	UpdateNodeTransformConditional(kActor, true,  true,  node, slif, isLoaded)
	UpdateNodeTransformConditional(kActor, false, false, node, slif, isLoaded)
	UpdateNodeTransformConditional(kActor, true,  false, node, slif, isLoaded)
endFunction

function UpdateNodeTransformConditional(Actor kActor, bool firstPerson, bool isFemale, String node, String slif, bool isLoaded) global
	if (NiOverride.HasNodeTransformScale(kActor, firstPerson, isFemale, node, slif) && isLoaded)
		NiOverride.UpdateNodeTransform(kActor, firstPerson, isFemale, node)
	endIf
endFunction
