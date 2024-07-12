Scriptname SLIF_Sort Hidden

int function CompareLeft(int left, int right, string pivot, bool ascending, String slif_actor) global
	while (left <= right)
		Actor kActor   = StorageUtil.FormListGet(none, slif_actor + "_list", left) as Actor
		String name    = SLIF_Util.GetActorName(kActor)
		String compare = SLIF_Util.ActorToString(kActor, name)
		if (CompareStringsWithOrder(compare, pivot, ascending) < 0)
			left += 1
		else
			return left
		endIf
	endWhile
	return left
endFunction

int function CompareRight(int left, int right, string pivot, bool ascending, String slif_actor) global
	while (right > left)
		Actor kActor   = StorageUtil.FormListGet(none, slif_actor + "_list", right) as Actor
		String name    = SLIF_Util.GetActorName(kActor)
		String compare = SLIF_Util.ActorToString(kActor, name)
		if (CompareStringsWithOrder(compare, pivot, ascending) > 0)
			right -= 1
		else
			return right
		endIf
	endWhile
	return right
endFunction

function SwapActors(int left, int right, String slif_actor) global
	String leftString  = StorageUtil.StringListGet(none, slif_actor + "_name_list", left)
	String rightString = StorageUtil.StringListGet(none, slif_actor + "_name_list", right)
	StorageUtil.StringListSet(none, slif_actor + "_name_list", left, rightString)
	StorageUtil.StringListSet(none, slif_actor + "_name_list", right, leftString)
	Actor leftActor  = StorageUtil.FormListGet(none, slif_actor + "_list", left) as Actor
	Actor rightActor = StorageUtil.FormListGet(none, slif_actor + "_list", right) as Actor
	StorageUtil.FormListSet(none, slif_actor + "_list", left, rightActor)
	StorageUtil.FormListSet(none, slif_actor + "_list", right, leftActor)
endFunction

int function SplitList(int lo, int hi, String slif_actor) global
	int left      = lo + 1
	int right     = hi
	Actor kActor  = StorageUtil.FormListGet(none, slif_actor + "_list", lo) as Actor
	String name   = SLIF_Util.GetActorName(kActor)
	string pivot  = SLIF_Util.ActorToString(kActor, name)
	bool break    = false
	
	while (break == false)
		
		bool ascending = SLIF_Config.GetInt("sort_actors_ascending", 1) as bool
		left  = CompareLeft( left, right, pivot, ascending, slif_actor)
		right = CompareRight(left, right, pivot, ascending, slif_actor)
		
		if (left >= right)
			break = true
		endIf
		
		if (break == false)
			SwapActors(left, right, slif_actor)
			left  += 1
			right -= 1
		endIf
		
	endWhile
	
	int leftMinusOne = left - 1
	SwapActors(lo, leftMinusOne, slif_actor)
	
	return leftMinusOne
endFunction

function SortActors(int lo, int hi, String slif_actor) global
	if ((hi-lo) <= 0)
		return
	endIf
	int splitPoint = SplitList(lo, hi, slif_actor)
	SortActors(lo, splitPoint - 1, slif_actor)
	SortActors(splitPoint + 1, hi, slif_actor)
endFunction

function QuickSortActorList(String slif_actor) global
	Actor PlayerRef = Game.GetPlayer()
	int size = StorageUtil.FormListCount(none, slif_actor + "_list")
	if (StorageUtil.FormListHas(none, slif_actor + "_list", PlayerRef))
		if (size <= 2)
			return
		endIf
		SortActors(1, size - 1, slif_actor)
	else
		if (size <= 1)
			return
		endIf
		SortActors(0, size - 1, slif_actor)
	endIf
endFunction

int function CompareCharsWithOrder(string source, string compare, int index, bool ascending) global
	if (ascending)
		return CompareChars(source, compare, index)
	else
		return CompareChars(compare, source, index)
	endIf
endFunction

int function CompareChars(string source, string compare, int index) global
	return getNumericValueFromChar(source, index) - getNumericValueFromChar(compare, index)
endFunction

int function getNumericValueFromChar(String s, int index) global
	string c = StringUtil.GetNthChar(s, index)
	return StringUtil.AsOrd(c)
endFunction

int function CompareStringsWithOrder(string source, string compare, bool ascending) global
	if (ascending)
		return CompareStrings(source, compare)
	else
		return CompareStrings(compare, source)
	endIf
endFunction

int function CompareStrings(String source, string compare) global
	int len1 = StringUtil.GetLength(source)
	int len2 = StringUtil.GetLength(compare)
	int lim = SLIF_Math.MinInteger(len1, len2)

	int k = 0;
	while (k < lim)
		int c1 = getNumericValueFromChar(source, k)
		int c2 = getNumericValueFromChar(compare, k)
		if (c1 != c2)
			return c1 - c2;
		endIf
		k += 1;
	endWhile
	return len1 - len2;
endFunction
