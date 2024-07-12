Scriptname zbfNakedEffectScript extends activemagiceffect

armor property JewelryRingGold auto 

Event OnEffectStart(Actor akTarget, Actor akCaster) 
;debug.notification("effect script: adding effect") 
akTarget.unequipall() 
endEvent 

Event OnEffectFinish(Actor akTarget, Actor akCaster) 
;debug.notification("effect script: removing effect") 
akTarget.additem(jewelryringgold,1,true) 
akTarget.equipitem(jewelryringgold,false,true) 
akTarget.removeitem(jewelryringgold,1,true) 
endEvent 

