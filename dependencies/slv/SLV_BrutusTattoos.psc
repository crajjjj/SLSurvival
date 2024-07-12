;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 4
Scriptname SLV_BrutusTattoos Extends Scene Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
slv_sexisrunning.setvalue(1)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
if SLV_Hardmode.getValue() == 0
	NextScene3.Start()
else
	NextScene4.Start()
endif
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Scene Property NextScene3  Auto  
Scene Property NextScene4  Auto  
SLV_MCMMenu Property MCMMenu Auto
GlobalVariable Property SLV_Hardmode Auto
GlobalVariable Property SLV_SexIsRunning Auto 
