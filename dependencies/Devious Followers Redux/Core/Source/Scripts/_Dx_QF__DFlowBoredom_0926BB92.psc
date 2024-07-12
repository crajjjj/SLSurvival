;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname _Dx_QF__DFlowBoredom_0926BB92 Extends Quest Hidden

;BEGIN ALIAS PROPERTY Follower
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Follower Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN AUTOCAST TYPE _DBoredom
Quest __temp = self as Quest
_DBoredom kmyQuest = __temp as _DBoredom
;END AUTOCAST
;BEGIN CODE
; Get the _DMaster alias actor from _DFlow
;
ReferenceAlias follower = kmyQuest.GetAlias(1) As ReferenceAlias
If follower
    ReferenceAlias master = DFQ.GetAlias(1) As ReferenceAlias
    If master
        Actor masterActor = master.GetActorRef()
        If masterActor
            follower.ForceRefTo(masterActor)
        EndIf
    EndIf
EndIf
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Quest Property DFQ  Auto  
