Scriptname zbfFurnitureNakedEffectsScript extends activemagiceffect

armor property zbfnaked auto 
armor property JewelryRingGold auto 

Event OnEffectStart(Actor akTarget, Actor akCaster)  
akTarget.unequipall() 
akTarget.additem(zbfNaked,1,true) 
akTarget.equipitem(zbfNaked,1,true)
akTarget.UnequipItemSlot(30)
akTarget.UnequipItemSlot(33)
akTarget.UnequipItemSlot(34)
akTarget.UnequipItemSlot(37)
endEvent 

Event OnEffectFinish(Actor akTarget, Actor akCaster)  
akTarget.additem(JewelryRingGold,1,true) 
akTarget.equipitem(JewelryRingGold,false,true)
akTarget.removeitem(jewelryringgold,1,true)  
 
endEvent  
