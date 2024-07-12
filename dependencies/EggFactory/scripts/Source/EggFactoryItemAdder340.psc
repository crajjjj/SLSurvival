Scriptname EggFactoryItemAdder340 extends Quest

leveleditem property EggFactoryPotions auto
leveleditem property EggFactoryJewelry auto

leveleditem property LItemPotionMagicEffects auto
leveleditem property LItemPotionMagicEffectsBest auto
leveleditem property LItemApothecaryPotionMagicEffects75 auto

leveleditem property LItemEnchJewelryAll auto
leveleditem property LItemEnchJewelryAll15 auto
leveleditem property LItemEnchJewelryAll75 auto

leveleditem property EggFactoryLItemCursedDragonEgg auto
leveleditem property DeathItemDragon01 auto

leveleditem property LItemTomes00AllSpells auto
leveleditem property EggFactoryTomesAlteration auto

leveleditem property LItemSpecialLoot100 auto
leveleditem property EggFactoryLItemCursedEggLarge auto

Event OnInit()
	debug.trace("Egg Factory 3.4.0 items adding.")
	LItemPotionMagicEffects.AddForm(EggFactoryPotions,1,1)
	LItemPotionMagicEffectsBest.AddForm(EggFactoryPotions,1,1)
	LItemApothecaryPotionMagicEffects75.AddForm(EggFactoryPotions,1,1)
	
	LItemEnchJewelryAll.AddForm(EggFactoryJewelry,1,1)
	LItemEnchJewelryAll15.AddForm(EggFactoryJewelry,1,1)
	LItemEnchJewelryAll75.AddForm(EggFactoryJewelry,1,1)
	
	LItemSpecialLoot100.AddForm(EggFactoryLItemCursedEggLarge,1,1)
	DeathItemDragon01.AddForm(EggFactoryLItemCursedDragonEgg,1,1)
	
	LItemTomes00AllSpells.AddForm(EggFactoryTomesAlteration,1,1)
EndEvent