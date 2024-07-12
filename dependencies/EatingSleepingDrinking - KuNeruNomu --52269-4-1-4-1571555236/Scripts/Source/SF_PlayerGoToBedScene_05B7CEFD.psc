;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 10
Scriptname SF_PlayerGoToBedScene_05B7CEFD Extends Scene Hidden

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
(GetowningQuest() as aaaKNNPlayerGoToBedQuest).WakeUpScene()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
(GetOwningQuest() as aaaKNNPlayerGoToBedQuest).SetShowSleepMenu()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
;(GetOwningQuest() as aaaKNNPlayerGoToBedQuest).StartScene()
(GetowningQuest() as aaaKNNPlayerGoToBedQuest).StartPlayerAI()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
(GetowningQuest() as aaaKNNPlayerGoToBedQuest).CheckScene()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_3
Function Fragment_3()
;BEGIN CODE
(GetOwningQuest() as aaaKNNPlayerGoToBedQuest).EndScene()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
