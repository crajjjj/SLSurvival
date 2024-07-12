;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 5
Scriptname TIF_DFlow_07039D7B Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_3
Function Fragment_3(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
    ; Gambling game
    Float pot = _DFlowGambleJPot.GetValue()
    Int roll = Utility.RandomInt(1, 6)
	MCM.NotiGam(pot, roll)
    
    Float win = 0.0
    Float loss = 0.6
    
	if roll == 2
        win = 0.134
        loss = 0.534
	elseif roll == 3
        win = 0.267
        loss = 0.4667
	elseif roll == 4
        win = 0.334
        loss = 0.4
	elseif roll == 5
        win = 0.467
        loss = 0.334
	elseif roll == 6
        win = 1.0
        loss = 0.267
	endif
    
    Int winGold = (pot * win) As Int
    Float lossGold = ((pot * loss) As Int) As Float
    
    Game.GetPlayer().Additem(Gold001, winGold)
    q.AddDebt(lossGold) ; low level debt addition

	Float lives = _DFlives.GetValue()
	lives -= 1.0
	_DFlives.SetValue(lives)
    
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

QF__Gift_09000D62 Property q Auto
MiscObject Property Gold001  Auto  
GlobalVariable property _DFlives auto
GlobalVariable property _DFlowGambleJPot auto
_DflowMCM property MCM Auto
