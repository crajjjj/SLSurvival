scriptname CommonHelperFunctions hidden

bool function IsEven(int aiValue) global
    return aiValue % 2 == 0
endFunction

float function GetDistance2D(ObjectReference akReference, ObjectReference akOther) global
	float x1 = akReference.x
	float y1 = akReference.y
	float x2 = akOther.x
	float y2 = akOther.y

	float dx = x2 - x1
	float dy = y2 - y1

	return math.sqrt((dx * dx) + (dy * dy))
endFunction

float function GetDistance2DCoords(float afOriginX, float afOriginY, float afNewX, float afNewY) global
	float dx = afNewX - afOriginX
	float dy = afNewY - afOriginY

	return math.sqrt((dx * dx) + (dy * dy))
endFunction