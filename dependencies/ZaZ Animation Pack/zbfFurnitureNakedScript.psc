Scriptname zbfFurnitureNakedScript extends ObjectReference
 

spell property zbfFurnitureNakedSpell auto
armor property zbfNaked auto  

Event OnSitEnter(ObjectReference furnitureRef)  
Actor akactionRef = furnitureRef as Actor 
if (akActionRef != game.getplayer() && !akActionRef.isincombat())  
zbfFurnitureNakedSpell.cast(akactionref,akactionref) 
endif 
endEvent 

Event OnSitLeave(ObjectReference sitRef) 
Actor akactionRef = sitRef as Actor 
if (akActionRef != game.getplayer())  
akActionRef.dispelspell(zbfFurnitureNakedSpell)
akActionRef.removeitem(zbfNaked,1,true)  
endif 
endEvent
