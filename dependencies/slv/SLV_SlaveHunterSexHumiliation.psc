;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 6
Scriptname SLV_SlaveHunterSexHumiliation Extends Scene Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
int nextScene = Utility.RandomInt(1,6)
myScripts.SLV_Displayinformation("Random scene: " + nextScene)

if nextScene == 1
	myScripts.SLV_Displayinformation("nextSceneSexNone" + nextSceneSexNone)

	nextSceneSexNone.forcestart()

elseif nextScene == 2
	myScripts.SLV_Displayinformation("nextSceneSexWhipping" + nextSceneSexWhipping)

	nextSceneSexWhipping.forcestart()

elseif nextScene == 3
	myScripts.SLV_Displayinformation("nextSceneSexHunter" + nextSceneSexHunter)

	nextSceneSexHunter.forcestart()

elseif nextScene == 4
	myScripts.SLV_Displayinformation("nextSceneSexDog" + nextSceneSexDog)

	nextSceneSexDog.forcestart()

elseif nextScene == 5
	myScripts.SLV_Displayinformation("nextSceneSexHorse" + nextSceneSexHorse)

	nextSceneSexHorse.forcestart()

else	
	myScripts.SLV_Displayinformation("nextSceneSexGuest" + nextSceneSexGuest)

	nextSceneSexGuest.forcestart()
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
SLV_Utilities Property myScripts auto
ReferenceAlias Property SLV_You Auto
GlobalVariable Property SLV_SexIsRunning Auto 
SLV_FindSpecators Property spectators auto
SLV_SlaveHunter Property slaveHunter auto


Scene Property nextSceneSexDog auto
Scene Property nextSceneSexGuest auto
Scene Property nextSceneSexHorse auto
Scene Property nextSceneSexHunter auto
Scene Property nextSceneSexNone auto
Scene Property nextSceneSexWhipping auto
