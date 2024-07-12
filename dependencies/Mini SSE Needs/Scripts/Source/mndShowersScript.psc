Scriptname mndShowersScript extends Quest

mndController Property mnd Auto
Activator Property mndShowerBuildableMarker Auto
Activator Property mndShowerBuildableOff Auto
Activator Property mndBathtubBuildableMarker Auto
Activator Property mndBathtub Auto
Static Property mndShowerBuildableOn Auto
Sound Property AMBWaterfallSmallLP Auto
EffectShader Property mndWetShader Auto
Message Property mndPlaceShowerMessage Auto
Book Property mndBuildShowerBook Auto
Book Property mndBuildBathtubBook Auto
Actor Property PlayerRef Auto
ObjectReference shower
Cell playerCell
Cell showerCell

ObjectReference[] Property allShowers Auto
ObjectReference[] Property allBathtubs Auto


bool buildingAShower = false
bool buildingABathtub = false

Function resetBuilding()
	buildingAShower = false
	buildingABathtub = false
	UnregisterForUpdate()
	UnregisterForAllKeys()
	Utility.waitMenuMode(0.2)
	if shower
		shower.stopTranslation()
		shower.delete()
	endIf
endFunction	

function buildAShower()
	if buildingAShower || buildingABathtub
		return
	endIf
	buildingAShower = true
	buildingABathtub = false
	; Create the object
	shower = PlayerRef.placeAtMe(mndShowerBuildableMarker, 1)
	float pZ = PlayerRef.getAngleZ()
	showerCell = shower.getParentCell()
	if shower && showerCell && shower.is3DLoaded()
		shower.translateTo(PlayerRef.X + 150.0 * math.sin(pZ), PlayerRef.Y + 150.0 * math.cos(pZ), PlayerRef.Z, 0.0, 0.0, pZ + 180.0, 250.0)
	endIf
	playerCell = PlayerRef.getParentCell()
	; Until we are moving position the shower in front of the player
	RegisterForKey(18)
	RegisterForKey(276)
	RegisterForSingleUpdate(0.1)
endFunction

function buildABathtub()
	if buildingAShower || buildingABathtub
		return
	endIf
	buildingAShower = false
	buildingABathtub = true
	; Create the object
	shower = PlayerRef.placeAtMe(mndBathtubBuildableMarker, 1)
	float pZ = PlayerRef.getAngleZ()
	showerCell = shower.getParentCell()
	if shower && showerCell && shower.is3DLoaded()
		shower.translateTo(PlayerRef.X + 150.0 * math.sin(pZ), PlayerRef.Y + 150.0 * math.cos(pZ), PlayerRef.Z, 0.0, 0.0, pZ + 90.0, 250.0)
	endIf
	playerCell = PlayerRef.getParentCell()
	; Until we are moving position the shower in front of the player
	RegisterForKey(18)
	RegisterForKey(276)
	RegisterForSingleUpdate(0.1)
endFunction

event OnUpdate()
	if !shower || !shower.is3DLoaded()
		UnregisterForAllKeys()
		return
	endIf
	float pZ = PlayerRef.getAngleZ()
	playerCell = PlayerRef.getParentCell()
	if playerCell != showerCell
		shower.moveTo(PlayerRef)
		showerCell = shower.getParentCell()
		Utility.wait(0.1)
	endIf
	float angle = pZ
	if buildingAShower
		angle += 180.0
	elseIf buildingABathtub
		angle += 90.0
	endIf
	shower.translateTo(PlayerRef.X + 150.0 * math.sin(pZ+1.0), PlayerRef.Y + 150.0 * math.cos(pZ+1.0), PlayerRef.Z, 0.0, 0.0, angle, 250.0)
	RegisterForSingleUpdate(0.2)
endEvent

Event OnKeyUp(int keyCode, float holdTime)
	if keyCode==18 || keyCode==276
		if buildingAShower
			completeBuildingShower()
		elseIf buildingABathtub
			completeBuildingBathtub()
		endIf
	endIf
endEvent

function completeBuildingShower()
	UnregisterForUpdate()
	UnregisterForAllKeys()
	if shower
		int pos = allShowers.find(none)
		if pos==-1
			mnd.showTranslatedString("NoMoreShowers")
			shower.delete()
			return
		endIf
		allShowers[pos] = PlayerRef.placeAtMe(mndShowerBuildableOff, 1)
		float pZ = PlayerRef.getAngleZ()
		allShowers[pos].setPosition(PlayerRef.X + 150.0 * math.sin(pZ+1.0), PlayerRef.Y + 150.0 * math.cos(pZ+1.0), PlayerRef.Z)
		allShowers[pos].setAngle(0.0, 0.0, pZ + 180.0)
		ObjectReference showerActive = PlayerRef.placeAtMe(mndShowerBuildableOn, 1)
		showerActive.setPosition(allShowers[pos].X, allShowers[pos].Y, allShowers[pos].Z)
		showerActive.setAngle(0.0, 0.0, allShowers[pos].getAngleZ())
		showerActive.disable()
		(allShowers[pos] as mndUseShower).mnd = mnd
		(allShowers[pos] as mndUseShower).clothes = new Form[14]
		(allShowers[pos] as mndUseShower).AMBWaterfallSmallLP = AMBWaterfallSmallLP
		(allShowers[pos] as mndUseShower).mndWetShader = mndWetShader
		(allShowers[pos] as mndUseShower).mndShowerOn = showerActive
		shower.stopTranslation()
		shower.delete()
		Utility.wait(5.0)
		; Show the message
		int res = mndPlaceShowerMessage.show()
		buildingAShower = false
		if res==0 ; Place it and remove the book
			PlayerRef.removeItem(mndBuildShowerBook, 1)
		elseIf res==1 ; Move it
			allShowers[pos].delete()
			allShowers[pos] = None
			showerActive.delete()
			buildingAShower = false
			buildAShower()
		elseIf res==2 ; Stop it without removing the book
			allShowers[pos].delete()
			allShowers[pos] = None
			showerActive.delete()
		endIf
	endIf
endFunction


function completeBuildingBathtub()
	UnregisterForUpdate()
	UnregisterForAllKeys()
	if shower
		int pos = allBathtubs.find(none)
		if pos==-1
			mnd.showTranslatedString("NoMoreBathtubs")
			shower.delete()
			UnregisterForAllKeys()
			return
		endIf
		allBathtubs[pos] = PlayerRef.placeAtMe(mndBathtub, 1)
		float pZ = PlayerRef.getAngleZ()
		allBathtubs[pos].setPosition(PlayerRef.X + 150.0 * math.sin(pZ+1.0), PlayerRef.Y + 150.0 * math.cos(pZ+1.0), PlayerRef.Z)
		allBathtubs[pos].setAngle(0.0, 0.0, pZ + 90.0)
		(allBathtubs[pos] as mndUseBathtub).mnd = mnd
		(allBathtubs[pos] as mndUseBathtub).clothes = new Form[14]
		(allBathtubs[pos] as mndUseBathtub).mndWetShader = mndWetShader
		shower.stopTranslation()
		shower.delete()
		Utility.wait(5.0)
		; Show the message
		int res = mndPlaceShowerMessage.show()
		buildingABathtub = false
		if res==0 ; Place it and remove the book
			PlayerRef.removeItem(mndBuildBathtubBook, 1)
		elseIf res==1 ; Move it
			allBathtubs[pos].delete()
			allBathtubs[pos] = None
			buildABathtub()
			return
		elseIf res==2 ; Stop it without removing the book
			allBathtubs[pos].delete()
			allBathtubs[pos] = None
		endIf
	endIf
endFunction
