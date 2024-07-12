Scriptname zbfNakedScript extends ObjectReference

spell property zbfNakedSpell auto 

Event OnTriggerEnter(ObjectReference triggerRef) 
;debug.notification("found something!") 
Actor akactionRef = triggerRef as Actor 
if (akActionRef != game.getplayer() && !akActionRef.isincombat()) 
;debug.notification("effect applied") 
zbfNakedSpell.cast(akactionref,akactionref) 
endif 
endEvent 

Event OnTriggerLeave(ObjectReference triggerRef) 
Actor akactionRef = triggerRef as Actor 
if (akActionRef != game.getplayer()) 
;debug.notification("effect removed") 
akActionRef.dispelspell(zbfNakedSpell) 
endif 
endEvent 
  
