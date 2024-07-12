Scriptname SLIF_Main Hidden

;/
	Mod authors read this first:
	see this blog, for implementation examples:
	http://www.loverslab.com/blog/396/entry-2043-sexlab-inflation-framework-implementation/
	
	If you have any questions, feel free to ask me in the forum thread for this mod:
	https://www.loverslab.com/topic/53219-sexlab-inflation-framework/
	
	this mod makes heavy use of PapyrusUtil:
	www.loverslab.com/files/file/484-papyrusutil/
	which is required for this mod to work.
	
	values:
		Actor kActor:   the actor that is mainpulated.
		String modName: the name you chose for your mod (can be multiples, but has to be unique and with blanks in between words, since that is needed for my mcm menu)
						(example: "Beeing Female")
		String node:    the node you want to do something with. (listed below)
		
		check if an actor is registered for your mod:
		SLIF_Main.IsRegistered(Actor kActor, String modName)
		
		check if an actor has been scaled with my mod for your and the chosen node:
		SLIF_Main.HasScale(Actor kActor, String modName, String node)
		
		String list of all registered mods for each actor:
		SLIF_Config.GetMod(index)
		
		Form list of all registered actors:
		StorageUtil.FormListGet(none, "slif_actor_list", index)
		String list of all names of the actors:
		StorageUtil.StringListGet(none, "slif_actor_name_list", index)
		
		use the following methods to access the nodes (returns String):
		SLIF_Main.ConvertToNode(String var)
		or for multiple nodes at the same time (returns String[]):
		SLIF_Main.ConvertMultipleToNode(String[] vars)
		
		Get the gender of the actor (the gender variable will set the gender if it isn't already):
		SLIF_Main.GetGender(Actor kActor, int gender = -1)
		Valid genders are:
		bool male            = gender == 0
		bool female          = gender == 1
		bool shemale         = gender == 2
		bool futanari        = gender == 3
		bool genderless      = gender == 4
		bool male_creature   = gender == 5
		bool female_creature = gender == 6
		
		The list of nodes can be found in Lists.json, located in SKSE\Plugins\StorageUtilData\SexLab Inflation Framework\
		
		All keys are constructed like this:
		Node + _min _max _mult _increment
		
		example:
		NPC L Breast
		NPC L Breast_min
		NPC L Breast_max
		NPC L Breast_mult
		NPC L Breast_increment
		
		accessed like this, returns float:
		SLIF_Main.GetValue(Actor kActor, string modName, string node, float default = 0.0)
		SLIF_Main.GetMinValue(Actor kActor, string modName, string node, float default = 0.0)
		SLIF_Main.GetMaxValue(Actor kActor, string modName, string node, float default = 100.0)
		SLIF_Main.GetMultValue(Actor kActor, string modName, string node, float default = 1.0)
		SLIF_Main.GetIncrValue(Actor kActor, string modName, string node, float default = 0.1)
		
		float default: the default value to return, if no value is set for that specific node
/;

Int Function GetScriptVersion() Global
	return 121
EndFunction

String Function GetScriptVersionString() Global
	return "1.2.1a beta"
EndFunction

; checks, if slif is installed
Bool Function IsInstalled() Global
	return StorageUtil.GetIntValue(none, "slif_installed") as bool
EndFunction

; checks, if slif is in the process of updating
Bool Function IsUpdating() Global
	return StorageUtil.GetIntValue(none, "slif_updating") as bool
EndFunction

; checks, if slif's menu is working at the moment
Bool Function IsWorking() Global
	return StorageUtil.GetIntValue(none, "slif_working") as bool
EndFunction

; checks, if slif's menu is in maintenance mode
Bool Function IsInMaintenance() Global
	return StorageUtil.GetIntValue(none, "slif_maintenance") as bool
EndFunction

;/
	Returns either:
		- the value set by inflate()
		- the minimum set by registerActor()
		- the maximum set by registerActor()
		- the multiply set by registerActor()
		- the increment set by registerActor()
	for the kActor, with your modName and the respective node.
	
	Actor kActor:	the actor, who the value belongs to
	String modName:	(example: "Beeing Female") the name you chose for your mod (can be multiples, but has to be unique and with blanks in between words, since that is needed for my mcm menu)
	String node:	the respective node
	
	optional:
	float default:	the value that is returned, if no value was set previously or given:
		- default value is 0.0
		- default minimum is 0.0
		- default maximum is 100.0
		- default multiply is 1.0
		- default increment is 0.1
/;
Float Function GetValue(Actor kActor, string modName, string node, float default = 0.0) Global
	if (SLIF_Util.validParameters(modName, node))
		int index = SLIF_Util.FindListEntry("stringList", "sync_keys", node)
		if (index != -1)
			String leftNode   = SLIF_Util.GetListEntry("stringList", "left_nodes",  index)
			String rightNode  = SLIF_Util.GetListEntry("stringList", "right_nodes", index)
			float leftValue  = StorageUtil.GetFloatValue(kActor, modName + leftNode,  default)
			float rightValue = StorageUtil.GetFloatValue(kActor, modName + rightNode, default)
			return SLIF_Math.Average(leftValue, rightValue)
		endIf
		node = ConvertToNode(node)
		if (node != "")
			return StorageUtil.GetFloatValue(kActor, modName + node, default)
		endIf
	endIf
	return 0.0
EndFunction

Float Function GetMinValue(Actor kActor, string modName, string node, float default = 0.0) Global
	if (SLIF_Util.validParameters(modName, node))
		int index = SLIF_Util.FindListEntry("stringList", "sync_keys", node)
		if (index != -1)
			String leftNode   = SLIF_Util.GetListEntry("stringList", "left_nodes",  index)
			String rightNode  = SLIF_Util.GetListEntry("stringList", "right_nodes", index)
			float leftValue  = StorageUtil.GetFloatValue(kActor, modName + leftNode  + "_min", default)
			float rightValue = StorageUtil.GetFloatValue(kActor, modName + rightNode + "_min", default)
			return SLIF_Math.Average(leftValue, rightValue)
		endIf
		node = ConvertToNode(node)
		if (node != "")
			return StorageUtil.GetFloatValue(kActor, modName + node + "_min", default)
		endIf
	endIf
	return 0.0
EndFunction

Float Function GetMaxValue(Actor kActor, string modName, string node, float default = 100.0) Global
	if (SLIF_Util.validParameters(modName, node))
		int index = SLIF_Util.FindListEntry("stringList", "sync_keys", node)
		if (index != -1)
			String leftNode   = SLIF_Util.GetListEntry("stringList", "left_nodes",  index)
			String rightNode  = SLIF_Util.GetListEntry("stringList", "right_nodes", index)
			float leftValue  = StorageUtil.GetFloatValue(kActor, modName + leftNode  + "_max", default)
			float rightValue = StorageUtil.GetFloatValue(kActor, modName + rightNode + "_max", default)
			return SLIF_Math.Average(leftValue, rightValue)
		endIf
		node = ConvertToNode(node)
		if (node != "")
			return StorageUtil.GetFloatValue(kActor, modName + node + "_max", default)
		endIf
	endIf
	return 100.0
EndFunction

Float Function GetMultValue(Actor kActor, string modName, string node, float default = 1.0) Global
	if (SLIF_Util.validParameters(modName, node))
		int index = SLIF_Util.FindListEntry("stringList", "sync_keys", node)
		if (index != -1)
			String leftNode   = SLIF_Util.GetListEntry("stringList", "left_nodes",  index)
			String rightNode  = SLIF_Util.GetListEntry("stringList", "right_nodes", index)
			float leftValue  = StorageUtil.GetFloatValue(kActor, modName + leftNode  + "_mult", default)
			float rightValue = StorageUtil.GetFloatValue(kActor, modName + rightNode + "_mult", default)
			return SLIF_Math.Average(leftValue, rightValue)
		endIf
		node = ConvertToNode(node)
		if (node != "")
			return StorageUtil.GetFloatValue(kActor, modName + node + "_mult", default)
		endIf
	endIf
	return 1.0
EndFunction

Float Function GetIncrValue(Actor kActor, string modName, string node, float default = 0.1) Global
	if (SLIF_Util.validParameters(modName, node))
		int index = SLIF_Util.FindListEntry("stringList", "sync_keys", node)
		if (index != -1)
			String leftNode   = SLIF_Util.GetListEntry("stringList", "left_nodes",  index)
			String rightNode  = SLIF_Util.GetListEntry("stringList", "right_nodes", index)
			float leftValue  = StorageUtil.GetFloatValue(kActor, modName + leftNode  + "_increment", default)
			float rightValue = StorageUtil.GetFloatValue(kActor, modName + rightNode + "_increment", default)
			return SLIF_Math.Average(leftValue, rightValue)
		endIf
		node = ConvertToNode(node)
		if (node != "")
			return StorageUtil.GetFloatValue(kActor, modName + node + "_increment", default)
		endIf
	endIf
	return 0.1
EndFunction

;/
	Sets the value for either:
		- the minimum
		- the maximum
		- the multiply
		- the increment
	for the kActor, with your modName and the respective node.
	
	Actor kActor:	the actor, who the value belongs to
	String modName:	(example: "Beeing Female") the name you chose for your mod (can be multiples, but has to be unique and with blanks in between words, since that is needed for my mcm menu)
	String node:	the respective node
	
	float value:	the value that is set:
		- the minimum   has to be greater than or equal to 0.0  and smaller than or equal to 100.0
		- the maximum   has to be greater than or equal to 0.0  and smaller than or equal to 100.0
		- the multiply  has to be greater than or equal to 0.01 and smaller than or equal to  10.0
		- the increment has to be greater than or equal to 0.01 and smaller than or equal to   1.0
/;
Function SetMinValue(Actor kActor, string modName, string node, float value) Global
	if (SLIF_Util.validParameters(modName, node))
		int index = SLIF_Util.FindListEntry("stringList", "sync_keys", node)
		if (index != -1)
			String leftNode  = SLIF_Util.GetListEntry("stringList", "left_nodes",  index)
			String rightNode = SLIF_Util.GetListEntry("stringList", "right_nodes", index)
			SetMinValue(kActor, modName, leftNode,  value)
			SetMinValue(kActor, modName, rightNode, value)
			return
		endIf
		node = ConvertToNode(node)
		if (node != "")
			value = SLIF_Math.SetBounds(value, 0.0, 100.0)
			SLIF_Util.SetFloatValue(kActor, modName, node, value, "_min", false)
		endIf
	endIf
EndFunction

Function SetMaxValue(Actor kActor, string modName, string node, float value) Global
	if (SLIF_Util.validParameters(modName, node))
		int index = SLIF_Util.FindListEntry("stringList", "sync_keys", node)
		if (index != -1)
			String leftNode  = SLIF_Util.GetListEntry("stringList", "left_nodes",  index)
			String rightNode = SLIF_Util.GetListEntry("stringList", "right_nodes", index)
			SetMaxValue(kActor, modName, leftNode,  value)
			SetMaxValue(kActor, modName, rightNode, value)
			return
		endIf
		node = ConvertToNode(node)
		if (node != "")
			value = SLIF_Math.SetBounds(value, 0.0, 100.0)
			SLIF_Util.SetFloatValue(kActor, modName, node, value, "_max", false)
		endIf
	endIf
EndFunction

Function SetMultValue(Actor kActor, string modName, string node, float value) Global
	if (SLIF_Util.validParameters(modName, node))
		int index = SLIF_Util.FindListEntry("stringList", "sync_keys", node)
		if (index != -1)
			String leftNode  = SLIF_Util.GetListEntry("stringList", "left_nodes",  index)
			String rightNode = SLIF_Util.GetListEntry("stringList", "right_nodes", index)
			SetMultValue(kActor, modName, leftNode,  value)
			SetMultValue(kActor, modName, rightNode, value)
			return
		endIf
		node = ConvertToNode(node)
		if (node != "")
			value = SLIF_Math.SetBounds(value, 0.01, 10.0)
			SLIF_Util.SetFloatValue(kActor, modName, node, value, "_mult", false)
		endIf
	endIf
EndFunction

Function SetIncrValue(Actor kActor, string modName, string node, float value) Global
	if (SLIF_Util.validParameters(modName, node))
		int index = SLIF_Util.FindListEntry("stringList", "sync_keys", node)
		if (index != -1)
			String leftNode  = SLIF_Util.GetListEntry("stringList", "left_nodes",  index)
			String rightNode = SLIF_Util.GetListEntry("stringList", "right_nodes", index)
			SetIncrValue(kActor, modName, leftNode,  value)
			SetIncrValue(kActor, modName, rightNode, value)
			return
		endIf
		node = ConvertToNode(node)
		if (node != "")
			value = SLIF_Math.SetBounds(value, 0.01, 1.0)
			SLIF_Util.SetFloatValue(kActor, modName, node, value, "_increment", false)
		endIf
	endIf
EndFunction

Function SetMinMaxValue(Actor kActor, string modName, string node, float minimum, float maximum) Global
	if (SLIF_Util.validParameters(modName, node))
		int index = SLIF_Util.FindListEntry("stringList", "sync_keys", node)
		if (index != -1)
			String leftNode  = SLIF_Util.GetListEntry("stringList", "left_nodes",  index)
			String rightNode = SLIF_Util.GetListEntry("stringList", "right_nodes", index)
			SetMinMaxValue(kActor, modName, leftNode,  minimum, maximum)
			SetMinMaxValue(kActor, modName, rightNode, minimum, maximum)
			return
		endIf
		node = ConvertToNode(node)
		if (node != "")
			minimum = SLIF_Math.SetBounds(minimum, 0.0, 100.0)
			maximum = SLIF_Math.SetBounds(maximum, 0.0, 100.0)
			float tempMin = minimum
			float tempMax = maximum
			if (tempMin != tempMax)
				minimum = SLIF_Math.MinFloat(tempMin, tempMax)
				maximum = SLIF_Math.MaxFloat(tempMin, tempMax)
			endIf
			SLIF_Util.SetFloatValue(kActor, modName, node, minimum, "_min", false)
			SLIF_Util.SetFloatValue(kActor, modName, node, maximum, "_max", false)
		endIf
	endIf
EndFunction

Function SetMinMaxMultIncrValue(Actor kActor, string modName, string node, float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0) Global
	if (SLIF_Util.validParameters(modName, node))
		int index = SLIF_Util.FindListEntry("stringList", "sync_keys", node)
		if (index != -1)
			String leftNode  = SLIF_Util.GetListEntry("stringList", "left_nodes",  index)
			String rightNode = SLIF_Util.GetListEntry("stringList", "right_nodes", index)
			SetMinMaxMultIncrValue(kActor, modName, leftNode,  minimum, maximum, multiplier, increment)
			SetMinMaxMultIncrValue(kActor, modName, rightNode, minimum, maximum, multiplier, increment)
			return
		endIf
		node = ConvertToNode(node)
		if (node != "")
			
			bool setMin = minimum != -1.0
			bool setMax = maximum != -1.0
			
			if (setMin && !setMax)
				SetMinValue(kActor, modName, node, minimum)
				SLIF_Util.SetFloatValue(kActor, modName, node, 100.0, "_max", false)
			elseIf (!setMin && setMax)
				SLIF_Util.SetFloatValue(kActor, modName, node,   0.0, "_min", false)
				SetMaxValue(kActor, modName, node, maximum)
			elseIf (setMin && setMax)
				SetMinMaxValue(kActor, modName, node, minimum, maximum)
			else
				SLIF_Util.SetFloatValue(kActor, modName, node,   0.0, "_min", false)
				SLIF_Util.SetFloatValue(kActor, modName, node, 100.0, "_max", false)
			endIf
			
			if (multiplier != -1.0)
				SetMultValue(kActor, modName, node, multiplier)
			else
				SLIF_Util.SetFloatValue(kActor, modName, node,   1.0, "_mult", false)
			endIf
			
			if (increment != -1.0)
				SetIncrValue(kActor, modName, node, increment)
			else
				SLIF_Util.SetFloatValue(kActor, modName, node,   0.1, "_increment", false)
			endIf
		endIf
	endIf
EndFunction

;/
	Main function of the entire mod, use this function instead of
	NiOverride.AddNodeTransformScale( kActor, firstPerson, isFemale, node, modName, value)
	or
	NetImmerse.SetNodeScale( kActor, node, value, firstPerson)
	
	The first time calling this function will register the actor this is called for.
		
		Actor kActor:		the actor which is going to be inflated.
		String modName:		(example: "Beeing Female") the name you chose for your mod (can be multiples, but has to be unique and with blanks in between words, since that is needed for my mcm menu (looks nicer))
		String node:		either the node which is inflated of the actor. ("slif_belly" = "NPC Belly")
		float value:		the value, which the node is inflated to for your mod, has to be absolute, since it's added to the values of the other mods.
		
		optional:
		int gender:			(deprecated) the gender either set your default or let my mod handle it (default = -1 will let my mod handle the gender) (see GetGender(Actor kActor, int gender = -1))
		int perspective:	(deprecated) if you want to set the first and third person value individually (0 for first, 1 for third person, default = -1 will set both)
		String oldModName:	the old key used for NiOverride, which will be removed if present and handled by my mod
		float minimum:		if you want to set the minimal value for this node (default 0.0)
		float maximum:		if you want to set the maximal value for this node (default 100.0)
		float multiplier:	if you want to set the multiplier value for this node (default 1.0)
		float increment:	if you want to set the increment value for this node (default 0.1)
		
		inflation_type:		inflation_types[0] = Incremental
							inflation_types[1] = Instant
		calculation_type:	calculation_types[0] = Top X
							calculation_types[1] = Highest Wins
							calculation_types[2] = Substract and add one
							calculation_types[3] = Square Root
							calculation_types[4] = Average
							calculation_types[5] = Additive
		
		String oldModName	<-- will remove the old NiOverride TransformScale, if present, since my mod combines the values into a single TransformScale
		
		float minimum		<-- will set the minimum
		float maximum		<-- will set the maximum
		float multiplier	<-- will set the multiplier
		float increment		<-- will set the increment
/;
Function inflate(Actor kActor, string modName, string node, float value, int gender = -1, int perspective = -1, string oldModName = "", float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0) Global
	float start = Utility.GetCurrentRealTime()
	
	if (!SLIF_Util.validParameters(modName, node) || IsUpdating())
		return
	endIf
	node = SLIF_Util.ConvertToSyncKey(node)
	if (SLIF_Util.IgnoreKey(node))
		return
	endIf
	if (SLIF_Util.HasListEntry("stringList", "sync_keys", node))
		inflateBoth(kActor, modName, node, value, gender, perspective, oldModName, minimum, maximum, multiplier, increment)
		return
	endIf
	
	if (SLIF_Util.IsValidActor(kActor))
		
		       gender    = GetGender(kActor)
		String name      = SLIF_Util.GetActorName(kActor)
		String aToString = SLIF_Util.ActorToString(kActor, name)
			   node      = ConvertToNode(node)
		
		if (node != "")
			
			if (SLIF_Util.AddEntry("node_lists", "000_nodes", node))
				SLIF_Util.SaveJson("SexLab Inflation Framework/Lists.json")
			endIf
			
			if (IsValidNodeForGender(kActor, node, gender))
				
				if (modName != "")
					
					registerActor(kActor, modName, node, gender, oldModName, minimum, maximum, multiplier, increment)
					
					float oldValue = GetValue(kActor, "All Mods", node, 1.0)
					
					float old      = GetValue(kActor, modName, node)
					
					SLIF_Util.inflateNode(kActor, aToString, modName, node, oldValue, value)
					
					float end = Utility.GetCurrentRealTime()
					SLIF_Debug.Trace("[SLIF_Main] Inflation:            " + aToString + " node: " + node + ", value: " + value + ", old: " + old + ", diff: " + (value - old) + ", mod: " + modName + SLIF_Util.OldModNameToString(oldModName) + ", time_diff: " + (end - start))
					
				endIf
			else
				
				SLIF_Scale.RemoveNodeScale(kActor, aToString, node, "SexLab Inflation Framework.esp")
				
			endIf
			
		endIf
		
	endIf
	
EndFunction

;/
	Function to inflate two nodes at once via syncKeys.
	
	The list of available syncKeys is found in "SexLab Inflation Framework/Lists.json/sync_keys".
/;
Function inflateBoth(Actor kActor, string modName, string syncKey, float value, int gender = -1, int perspective = -1, string oldModName = "", float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0) Global
	float start = Utility.GetCurrentRealTime()
	
	if (!SLIF_Util.validParameters(modName, syncKey) || IsUpdating())
		return
	endIf
	syncKey = SLIF_Util.ConvertToSyncKey(syncKey)
	if (SLIF_Util.IgnoreKey(syncKey))
		return
	endIf
	
	if (SLIF_Util.IsValidActor(kActor))
		
		int index = SLIF_Util.FindListEntry("stringList", "sync_keys", syncKey)
		if (index != -1)
			
				   gender       = GetGender(kActor)
			String name         = SLIF_Util.GetActorName(kActor)
			String aToString    = SLIF_Util.ActorToString(kActor, name)
			
			String leftNode     = SLIF_Util.GetListEntry("stringList", "left_nodes",  index)
			String rightNode    = SLIF_Util.GetListEntry("stringList", "right_nodes", index)
			
			if (leftNode != "" && rightNode != "")
				
				if (SLIF_Util.AddEntry("node_lists", "000_nodes", leftNode) || SLIF_Util.AddEntry("node_lists", "000_nodes", rightNode))
					SLIF_Util.SaveJson("SexLab Inflation Framework/Lists.json")
				endIf
				
				if (IsValidNodeForGender(kActor, leftNode, gender) && IsValidNodeForGender(kActor, rightNode, gender))
					
					registerActor(kActor, modName, leftNode,  gender, oldModName, minimum, maximum, multiplier, increment)
					registerActor(kActor, modName, rightNode, gender, oldModName, minimum, maximum, multiplier, increment)
					
					float leftValue  = GetValue(kActor, "All Mods", leftNode,  1.0)
					float rightValue = GetValue(kActor, "All Mods", rightNode, 1.0)
					float oldValue   = SLIF_Math.Average(leftValue, rightValue)
					
					float leftVal  = GetValue(kActor, modName, leftNode)
					float rightVal = GetValue(kActor, modName, rightNode)
					float old      = SLIF_Math.Average(leftVal, rightVal)
					
					SLIF_Util.inflateNodes(kActor, aToString, modName, syncKey, leftNode, rightNode, oldValue, value)
					
					float end = Utility.GetCurrentRealTime()
					SLIF_Debug.Trace("[SLIF_Main] Inflate Both:         " + aToString + " node: " + syncKey + ", value: " + value + ", old: " + old + ", diff: " + (value - old) + ", mod: " + modName + SLIF_Util.OldModNameToString(oldModName) + ", time_diff: " + (end - start))
				
				else
					SLIF_Scale.RemoveNodeScale(kActor, aToString, leftNode,  "SexLab Inflation Framework.esp")
					SLIF_Scale.RemoveNodeScale(kActor, aToString, rightNode, "SexLab Inflation Framework.esp")
				endIf
			
			endIf
			
		endIf
		
	endIf
	
EndFunction

;/
	Function to inflate multiple nodes at the same time.
	
	No optionals this time, since arrays can't be none and have to be initialized with an array of a size of at least 1.
	
	example:
		String[] nodes = new String[2]
		nodes[0] = "NPC L Breast"
		nodes[1] = "NPC R Breast"
		Float[] values = new Float[2]
		values[0] = SomeValue
		values[1] = SomeValue
		SLIF_Main.inflateMultiple(PlayerRef, "SomeModName", nodes, values, -1, -1, "", new float[1], new float[1], new float[1], new float[1])
	
	There is sadly nothing I can do about this.
/;
Function inflateMultiple(Actor kActor, string modName, string[] nodes, float[] values, int gender, int perspective, string oldModName, float[] minimum, float[] maximum, float[] multiplier, float[] increment) Global
	float start = Utility.GetCurrentRealTime()
	
	if (!IsInstalled() || SLIF_Util.IsEmpty(modName) || IsUpdating())
		return
	endIf
	if (SLIF_Util.IsValidActor(kActor))
		
		       gender       = GetGender(kActor)
		String name         = SLIF_Util.GetActorName(kActor)
		String aToString    = SLIF_Util.ActorToString(kActor, name)
		
		int size = nodes.length
		if (size > 0)
			nodes = ConvertMultipleToNode(nodes)
			
			if (minimum.length != size)
				minimum = Utility.CreateFloatArray(size)
			endIf
			if (maximum.length != size)
				maximum = Utility.CreateFloatArray(size, 100.0)
			endIf
			if (multiplier.length != size)
				multiplier = Utility.CreateFloatArray(size, 1.0)
			endIf
			if (increment.length != size)
				increment = Utility.CreateFloatArray(size, 0.1)
			endIf
			float[] oldValues = Utility.CreateFloatArray(size, 1.0)
			float[] old       = Utility.CreateFloatArray(size)
			
			String tempNode = ""
			float tempValue = 0.0
			float tempMin   = 0.0
			float tempMax   = 0.0
			float tempMult  = 0.0
			float tempIncr  = 0.0
			
			int newSize = size
			int i = 0
			while(i < size)
				if (SLIF_Util.IgnoreKey(nodes[i]))
					newSize -= 1
				else
					tempNode  = nodes[i]
					tempValue = values[i]
					tempMin   = minimum[i]
					tempMax   = maximum[i]
					tempMult  = multiplier[i]
					tempIncr  = increment[i]
				endIf
				i += 1
			endWhile
			
			int index = 0
			bool processArrayComplete = true
			String[] tempNodes  = Utility.CreateStringArray(newSize)
			float[] tempValues = Utility.CreateFloatArray(newSize)
			
			if (newSize == 0)
				return
			elseIf (newSize == 1)
				inflate(kActor, modName, tempNode, tempValue, gender, perspective, oldModName, tempMin, tempMax, tempMult, tempIncr)
				return
			elseIf (newSize < size)
				oldValues = Utility.CreateFloatArray(newSize, 1.0)
				old       = Utility.CreateFloatArray(newSize)
				processArrayComplete = false
			endIf
			
			i = 0
			while(i < size)
				if (nodes[i] != "" && (processArrayComplete || !SLIF_Util.IgnoreKey(nodes[i])))
					registerActor(kActor, modName, nodes[i], gender, oldModName, minimum[i], maximum[i], multiplier[i], increment[i])
					
					if (processArrayComplete)
						oldValues[i] = GetValue(kActor, "All Mods", nodes[i], 1.0)
						old[i]       = GetValue(kActor, modName,    nodes[i])
					else
						tempNodes[index]  = nodes[i]
						tempValues[index] = values[i]
						oldValues[index]  = GetValue(kActor, "All Mods", nodes[i], 1.0)
						old[index]        = GetValue(kActor, modName,    nodes[i])
						index += 1
					endIf
				endIf
				i += 1
			endWhile
			
			if (processArrayComplete)
				SLIF_Util.inflateMultipleNodes(kActor, aToString, modName, nodes, oldValues, values)
			else
				SLIF_Util.inflateMultipleNodes(kActor, aToString, modName, tempNodes, oldValues, tempValues)
			endIf
			
			float end = Utility.GetCurrentRealTime()
			i = 0
			while(i < size)
				if (nodes[i] != "" && (processArrayComplete || !SLIF_Util.IgnoreKey(nodes[i])))
					SLIF_Debug.Trace("[SLIF_Main] Multiple Inflation:   " + aToString + " node: " + nodes[i] + ", value: " + values[i] + ", old: " + old[i] + ", diff: " + (values[i] - old[i]) + ", mod: " + modName + SLIF_Util.OldModNameToString(oldModName) + ", time_diff: " + (end - start))
				endIf
				i += 1
			endWhile
			
		endIf
	
	endIf
	
EndFunction

;/
	Function to hide the node, which will not be inflated by this mod and reduced to the given value.
	
	Actor kActor:		the actor, for whom the node is supposed to be hidden
	String modName:		(example: "Beeing Female") the name you chose for your mod (can be multiples, but has to be unique and with blanks in between words, since that is needed for my mcm menu)
	String node:		the node, which is supposed to be hidden
	
	optional:
	float value:		the value to which the node is reduced to
	String oldModName:	the old scale, which will be removed, if present and oldModName is not empty
/;
Function hideNode(Actor kActor, String modName, String node, float value = 0.0000001, string oldModName = "") Global
	if (!IsInstalled() || SLIF_Util.IsEmpty(node))
		return
	endIf
	node = ConvertToNode(node)
	if (!IsNodeHidden(kActor, node))
		String name      = SLIF_Util.GetActorName(kActor)
		String aToString = SLIF_Util.ActorToString(kActor, name)
		StorageUtil.SetIntValue(kActor, node + "_hidden", 1)
		if (oldModName != "")
			SLIF_Scale.RemoveNodeScale(kActor, aToString, node, oldModName)
		endIf
		if (value < 0.0000001)
			value = 0.0000001
		endIf
		SLIF_Debug.Trace("[SLIF_Main] Hiding Node:          " + aToString + " node: " + node + ", value: " + value)
		StorageUtil.SetFloatValue(kActor, node + "_hidden", value)
		SLIF_Scale.SetNodeScale(kActor, aToString, node, value)
	endIf
EndFunction

;/
	Function to show the hidden node again.
	
	Actor kActor:	the actor, for whom the node is supposed to be shown again
	String modName:	(example: "Beeing Female") the name you chose for your mod (can be multiples, but has to be unique and with blanks in between words, since that is needed for my mcm menu)
	String node:	the node, which is supposed to be shown again
/;
Function showNode(Actor kActor, String modName, String node) Global
	if (!SLIF_Util.IsEmpty(node))
		node = ConvertToNode(node)
		if (IsNodeHidden(kActor, node))
			String name      = SLIF_Util.GetActorName(kActor)
			String aToString = SLIF_Util.ActorToString(kActor, name)
			StorageUtil.UnsetIntValue(kActor, node + "_hidden")
			SLIF_Debug.Trace("[SLIF_Main] Showing Node:         " + aToString + " node: " + node)
			StorageUtil.UnsetFloatValue(kActor, node + "_hidden")
			SLIF_Scale.SetNodeScale(kActor, aToString, node, SLIF_Util.GetValueByCalculationType(kActor, node))
		endIf
	endIf
EndFunction

;/
	Function to check, if the node is hidden for that actor.
	
	Actor kActor:	the actor, that has the node
	String node:	the node, which is checked, if it's hidden
/;
Bool Function IsNodeHidden(Actor kActor, String node) Global
	if (IsInstalled() && !SLIF_Util.IsEmpty(node))
		return StorageUtil.GetIntValue(kActor, ConvertToNode(node) + "_hidden") as bool
	endIf
	return false
EndFunction

;/
	Function to check, if the chosen actor is registered for the mod.
	
	Returns true, if the actor is registered for the mod, false otherwise.
/;
Bool Function IsRegistered(Actor kActor, String modName) Global
	return StorageUtil.HasIntValue(kActor, modName + "slif_initialize")
EndFunction

;/
	Function to check, if the chosen actor has the scale for the node and mod.
	
	Returns true, if the actor has that scale, false otherwise.
/;
Bool Function HasScale(Actor kActor, String modName, String node) Global
	if (SLIF_Util.validParameters(modName, node))
		return StorageUtil.HasFloatValue(kActor, modName + ConvertToNode(node))
	endIf
	return false
EndFunction

;/
	Registers the actor for the mod.
	If not called first, it will be automatically called the first time the function "inflate" is called for the actor.
	(as long as the integer value "slif_initialize" is not set for the actor, else the method will do nothing)
	
	Actor kActor:		the actor, which will be registered
	String modName:		(example: "Beeing Female") the name you chose for your mod (can be multiples, but has to be unique and with blanks in between words, since that is needed for my mcm menu)
	
	optional:
	int gender:			(deprecated) the gender either set your default or let my mod handle it (default = -1 will let my mod handle the gender) (see GetGender(Actor kActor, int gender = -1))
	String oldModName:	the old key used for NiOverride, which will be removed if present and handled by my mod
	float minimum:		if you want to set the minimal value for this node    (default   0.0)
	float maximum:		if you want to set the maximal value for this node    (default 100.0)
	float multiplier:	if you want to set the multiplier value for this node (default   1.0)
	float increment:	if you want to set the increment value for this node  (default   0.1)
	
	example:
		registerActor(kActor, "Beeing Female", "slif_left_breast", gender, "BeeingFemale", minimum, maximum, multiplier, increment)
		the modname will then be used to create the keywords for the actor, for example:
		"Beeing Female" + "slif_left_breast"     = "Beeing Female"+"slif_left_breast"        <-- the inflation value for the particular mod and node,
		                                                                                         which can then be accessed via the kActor
		         StorageUtil.GetFloatValue(kActor, "Beeing Female"+"slif_left_breast")
				
		"Beeing Female"+"slif_left_breast"+"_min"       = "Beeing Female"+"slif_left_breast_min"       <-- the inflation minimum    for this constellation
		                StorageUtil.GetFloatValue(kActor, "Beeing Female"+"slif_left_breast_min")
				
		"Beeing Female"+"slif_left_breast"+"_max"       = "Beeing Female"+"slif_left_breast_max"       <-- the inflation maximum    for this constellation
		                StorageUtil.GetFloatValue(kActor, "Beeing Female"+"slif_left_breast_max")
				
		"Beeing Female"+"slif_left_breast"+"_mult"      = "Beeing Female"+"slif_left_breast_mult"      <-- the inflation multiplier for this constellation
		                StorageUtil.GetFloatValue(kActor, "Beeing Female"+"slif_left_breast_mult")
				
		"Beeing Female"+"slif_left_breast"+"_increment" = "Beeing Female"+"slif_left_breast_increment" <-- the inflation increment  for this constellation
		                StorageUtil.GetFloatValue(kActor, "Beeing Female"+"slif_left_breast_increment")
		
		"BeeingFemale" <-- will remove the old NiOverride TransformScale, if present, since my mod combines the values into a single TransformScale
		
		minimum        <-- will set the minimum
		maximum        <-- will set the maximum
		multiplier     <-- will set the multiplier
		increment      <-- will set the increment
/;
Function registerActor(Actor kActor, string modName, string node = "", int gender = -1, string oldModName = "", float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0) Global
	
	if (!IsInstalled() || SLIF_Util.IsEmpty(modName))
		return
	endIf
	
	node = SLIF_Util.ConvertToSyncKey(node)
	if (SLIF_Util.IgnoreKey(node))
		return
	endIf
	
	node = ConvertToNode(node)
	
	int index = SLIF_Util.FindListEntry("stringList", "sync_keys", node)
	if (index != -1)
		String leftNode  = SLIF_Util.GetListEntry("stringList", "left_nodes",  index)
		String rightNode = SLIF_Util.GetListEntry("stringList", "right_nodes", index)
		registerActor(kActor, modName, leftNode,  gender, oldModName, minimum, maximum, multiplier, increment)
		registerActor(kActor, modName, rightNode, gender, oldModName, minimum, maximum, multiplier, increment)
		return
	endIf
	
	if (modName != "All Mods")
		if (SLIF_Util.IsValidActor(kActor))
			
			String name      = SLIF_Util.GetActorName(kActor)
			String aToString = SLIF_Util.ActorToString(kActor, name)
				 gender      = GetGender(kActor)
			
			if (name != "")
				
				SLIF_Util.AddActorToList(kActor, name, aToString)
				SLIF_Util.registerSLIF(kActor, name, aToString)
				
				if (modName != "SL Inflation Framework")
					SLIF_Util.registerMod(kActor, name, aToString, modName)
				endIf
				
				if (node != "")
					if (!HasScale(kActor, modName, node))
						SLIF_Calc.InitializeDefaultValues(kActor, aToString, modName, node, oldModName, minimum, maximum, multiplier, increment)
						SLIF_Util.StringListAdd(kActor, modName, node)
						SLIF_Util.SetAllModsKey(kActor, node)
					endIf
				endIf
				
			endIf
		
		endIf
	
	endIf
	
EndFunction

;/
	The opposite of the registerActor() function, to state the obvious.
	
	Will unregister the actor for the mod (default "All Mods", will unregister the actor for all mods).
/;
Function unregisterActor(Actor kActor, string modName = "All Mods") Global
	
	if (SLIF_Util.IsEmpty(modName))
		return
	endIf
	if (kActor)
		if (!IsRegistered(kActor, modName))
			return
		endIf
		
		String name      = SLIF_Util.GetActorName(kActor)
		String aToString = SLIF_Util.ActorToString(kActor, name)
		
		if (modName != "All Mods")
			
			SLIF_Util.unregisterMod(kActor, aToString, modName)
			
		else
			
			int modCount = StorageUtil.StringListCount(kActor, "slif_mod_list")
			if (modCount > 1)
				while(modCount > 1)
					modCount -= 1
					SLIF_Util.unregisterMod(kActor, aToString, StorageUtil.StringListGet(kActor, "slif_mod_list", modCount))
				endWhile
			else
				SLIF_Util.unregisterActorForAllMods(kActor, aToString)
			endIf
			
		endIf
		
	endIf
	
EndFunction

;/
	Functions to update/reset the actor.
	
	Actor kActor:		the actor, which will be updated/reset
	
	optional:
	string modName:		(example: "Beeing Female") the name you chose for your mod (can be multiples, but has to be unique and with blanks in between words, since that is needed for my mcm menu)
						(default "All Mods" will update/reset for all mods)
	string node:		specifies if either all nodes are updated/reset (empty string) or a specific node
	float value:		the value to reset the actor to (only for resetActor)
	int gender:			(deprecated) the gender either set your default or let my mod handle it (default -1 will let my mod handle the gender) (see GetGender(Actor kActor, int gender = -1))
	int newGender:		(deprecated) a new gender, you want to update/reset the actor to.
	int perspective:	(deprecated) the chosen perspective, that is supposed to be updated/reset (default -1 will update/reset first and third perspective)
	string oldModName:	the old name used for NiOverride, which will be removed if present and handled by my mod
	float minimum:		if you want to set a minimal value (default 0.0)
	float maximum:		if you want to set a maximal value (default 100.0)
	float multiplier:	if you want to set a multiplier value (default 1.0)
	float increment:	if you want to set a increment value (default 0.1)
/;
Function updateActor(Actor kActor, string modName = "All Mods", string node = "", int gender = -1, int newGender = -1, int perspective = -1, string oldModName = "", float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0) Global
	if (!IsInstalled() || SLIF_Util.IsEmpty(modName))
		return
	endIf
	       node      = ConvertToNode(node)
	String name      = SLIF_Util.GetActorName(kActor)
	String aToString = SLIF_Util.ActorToString(kActor, name)
	SLIF_Util.updateActor(kActor, aToString, modName, node, oldModName, minimum, maximum, multiplier, increment)
EndFunction

Function resetActor(Actor kActor, string modName = "All Mods", string node = "", float value = 1.0, int gender = -1, int newGender = -1, int perspective = -1, string oldModName = "", float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0) Global
	if (!IsInstalled() || SLIF_Util.IsEmpty(modName))
		return
	endIf
	       node      = ConvertToNode(node)
	String name      = SLIF_Util.GetActorName(kActor)
	String aToString = SLIF_Util.ActorToString(kActor, name)
	SLIF_Util.updateActor(kActor, aToString, modName, node, oldModName, minimum, maximum, multiplier, increment, value)
EndFunction

;/
	Functions to update/reset same as update/resetActor, but the whole actor list instead.
/;
Function updateActorList(String modName = "All Mods", string node = "", int gender = -1, int newGender = -1, int perspective = -1, string oldModName = "", float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0) Global
	if (!IsInstalled() || SLIF_Util.IsEmpty(modName))
		return
	endIf
	SLIF_Util.updateActorList(modName, node, oldModName, minimum, maximum, multiplier, increment)
EndFunction

Function resetActorList(String modName = "All Mods", string node = "", float value = 1.0, int gender = -1, int newGender = -1, int perspective = -1, string oldModName = "", float minimum = -1.0, float maximum = -1.0, float multiplier = -1.0, float increment = -1.0) Global
	if (!IsInstalled() || SLIF_Util.IsEmpty(modName))
		return
	endIf
	SLIF_Util.updateActorList(modName, node, oldModName, minimum, maximum, multiplier, increment, value)
EndFunction

;/
	Function to call unregisterNode() for two nodes at once via syncKeys.
	
	The list of available syncKeys is found in "SexLab Inflation Framework/Lists.json/sync_keys".
/;
Function unregisterBothNodes(Actor kActor, string syncKey, string modName = "All Mods") Global
	syncKey = SLIF_Util.ConvertToSyncKey(syncKey)
	int index = SLIF_Util.FindListEntry("stringList", "sync_keys", syncKey)
	if (index != -1)
		String leftNode  = SLIF_Util.GetListEntry("stringList", "left_nodes",  index)
		String rightNode = SLIF_Util.GetListEntry("stringList", "right_nodes", index)
		unregisterNode(kActor, leftNode,  modName)
		unregisterNode(kActor, rightNode, modName)
	endIf
EndFunction

;/
	Function to call unregisterNode() for multiple nodes at once.
/;
Function unregisterMultipleNodes(Actor kActor, string[] nodes, string modName = "All Mods") Global
	int i = 0
	while (i < nodes.length)
		unregisterNode(kActor, nodes[i], modName)
		i += 1
	endWhile
EndFunction

;/
	Function to unregister a node for the specified actor and mod (default "All Mods" will unregister that node for all mods).
/;
Function unregisterNode(Actor kActor, string node, string modName = "All Mods") Global
	node = SLIF_Util.ConvertToSyncKey(node)
	if (SLIF_Util.IgnoreKey(node))
		return
	endIf
	node = ConvertToNode(node)
	if (SLIF_Util.HasListEntry("stringList", "sync_keys", node))
		unregisterBothNodes(kActor, node, modName)
		return
	endIf
	if (kActor)
		if (!IsRegistered(kActor, modName))
			return
		endIf
		String name      = SLIF_Util.GetActorName(kActor)
		String aToString = SLIF_Util.ActorToString(kActor, name)
		if (node != "")
			if (!StorageUtil.HasFloatValue(kActor, modName + node))
				return
			endIf
			SLIF_Util.unregisterNode(kActor, aToString, node, modName)
		endIf
	endIf
EndFunction

;/
	Function to get the key from the respective node and vice versa.
	
	sKey: the key to get the respective node from
	node: the node to get the respective key from
	
	examples:
		GetKeyFromNode("NPC L Breast")     = "slif_left_breast"
		GetNodeFromKey("slif_left_breast") = "NPC L Breast"
	
	return: the key for the respective node and vice versa (empty string, if the node/sKey is not valid)
/;
String Function GetKeyFromNode(String node, int index = -1) Global
	;/
	int size = SLIF_Util.GetListSize("key_lists", "000_keys")
	if (index == -1 && node != "")
		index = SLIF_Util.FindListEntry("node_lists", "000_nodes", node)
	endIf
	if (index >= 0 && index < size)
		return SLIF_Util.GetListEntry("key_lists", "000_keys", index)
	endIf
	/;
	SLIF_Debug.Trace("[SLIF_ERROR] Deprecated function: 'SLIF_Main.GetKeyFromNode', do not use, use 'SLIF_Main.ConvertToNode' instead! Node: " + node)
	Debug.Trace("SLIF_ERROR: Deprecated function 'SLIF_Main.GetKeyFromNode', do not use, use 'SLIF_Main.ConvertToNode' instead! Node: " + node)
	return ConvertToNode(node)
EndFunction

String Function GetNodeFromKey(String sKey, int index = -1) Global
	;/
	int size = SLIF_Util.GetListSize("node_lists", "000_nodes")
	if (index == -1 && sKey != "")
		index = SLIF_Util.FindListEntry("key_lists", "000_keys", sKey)
	endIf
	if (index >= 0 && index < size)
		return SLIF_Util.GetListEntry("node_lists", "000_nodes", index)
	endIf
	/;
	SLIF_Debug.Trace("[SLIF_ERROR] Deprecated function: 'SLIF_Main.GetNodeFromKey', do not use, use 'SLIF_Main.ConvertToNode' instead! Key: " + sKey)
	Debug.Trace("SLIF_ERROR: Deprecated function 'SLIF_Main.GetNodeFromKey', do not use, use 'SLIF_Main.ConvertToNode' instead! Key: " + sKey)
	return ConvertToNode(sKey)
EndFunction

;/
	Function to convert the variable to a key/node.
	
	return: the respective key/node, else an empty string, if the variable isn't either a valid key or a node
/;
String Function ConvertToKey(String var) Global
	;/
	if (SLIF_Util.HasListEntry("key_lists", "000_keys", var))
		return var
	elseIf (SLIF_Util.HasListEntry("node_lists", "000_nodes", var))
		return GetKeyFromNode(var)
	endIf
	return ""
	/;
	SLIF_Debug.Trace("[SLIF_ERROR] Deprecated function: 'SLIF_Main.ConvertToKey', do not use, use 'SLIF_Main.ConvertToNode' instead! Key: " + var)
	Debug.Trace("SLIF_ERROR: Deprecated function 'SLIF_Main.ConvertToKey', do not use, use 'SLIF_Main.ConvertToNode' instead! Key: " + var)
	return ConvertToNode(var)
EndFunction

String Function ConvertToNode(String var) Global
	;/
	if (SLIF_Util.HasListEntry("node_lists", "000_nodes", var))
		return var
	elseIf (SLIF_Util.HasListEntry("key_lists", "000_keys", var))
		return GetNodeFromKey(var)
	endIf
	return ""
	/;
	int index = SLIF_Util.FindListEntry("stringList", "convert_keys", var)
	if (index != -1)
		return SLIF_Util.GetListEntry("stringList", "convert_nodes", index)
	endIf
	return var
EndFunction

;/
	Function to convert multiple variables to keys/nodes.
	
	return: a string array filled with respective keys/nodes.
	when an entry is neither a key nor a node, the entry will be set empty.
/;
String[] Function ConvertMultipleToKey(String[] vars) Global
	;/
	int size = vars.length
	String[] result = Utility.CreateStringArray(size)
	int i = 0
	while(i < size)
		result[i] = ConvertToKey(vars[i])
		i += 1
	endWhile
	return result
	/;
	SLIF_Debug.Trace("[SLIF_ERROR] Deprecated function: 'SLIF_Main.ConvertMultipleToKey', do not use, use 'SLIF_Main.ConvertMultipleToNode' instead!")
	Debug.Trace("SLIF_ERROR: Deprecated function 'SLIF_Main.ConvertMultipleToKey', do not use, use 'SLIF_Main.ConvertMultipleToNode' instead!")
	return ConvertMultipleToNode(vars)
EndFunction

String[] Function ConvertMultipleToNode(String[] vars) Global
	int size = vars.length
	String[] result = Utility.CreateStringArray(size)
	int i = 0
	while(i < size)
		result[i] = ConvertToNode(vars[i])
		i += 1
	endWhile	
	return result
EndFunction

;/
	Function to get the gender of an actor.
	if       :  gender != -1, it will call StorageUtil.SetIntValue(kActor, "slif_gender", gender) and return that value, if it's valid.
	else if  :  StorageUtil.GetIntValue(kActor, "slif_gender") is set, it will return that value.
	else if  :  SexLab is installed, it will return that value.
	else     :  it will return the default gender from the game.
	
	kActor:		the actor to get the gender from
	
	optional:
	gender:		the gender either set your default or let my mod handle it (default = -1 will let my mod handle the gender)
	
	male            = 0
	female          = 1
	shemale         = 2
	futanari        = 3
	genderless      = 4
	male_creature   = 5
	female_creature = 6
/;
Int Function GetGender(Actor kActor, int gender = -1) Global
	
	if (StorageUtil.HasIntValue(kActor, "slif_gender"))
		return StorageUtil.GetIntValue(kActor, "slif_gender")
	endIf
	
	gender = SLIF_SexLab_Script.GetGender(kActor, gender)
	
	if (gender >= 0 && gender <= 6)
		return StorageUtil.SetIntValue(kActor, "slif_gender", gender)
	endIf
	
	return StorageUtil.SetIntValue(kActor, "slif_gender", kActor.GetLeveledActorBase().GetSex())
	
EndFunction

;/
	Function more or less deprecated at the moment!
	
	Function to check, if a certain node is valid for the gender of the actor, which is determined by my mod.
	
	kActor:		the actor to be checked to be valid for the node
	node:		the node which the actor is checked to be valid for
	
	optional:
	gender:		(deprecated) if you want to check if the actor is also a certain gender
				(see GetGender(Actor kActor, int gender = -1))
/;
Bool Function IsValidNodeForGender(Actor kActor, string node, int gender = -1) Global
	
	if (kActor)
		
		if (node == "")
			return false
		endIf
		
		if (!NetImmerse.HasNode(kActor, node, true) && !NetImmerse.HasNode(kActor, node, false))
			return false
		endIf
		
		return true
	endIf
	
	return false
	
EndFunction
