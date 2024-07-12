Scriptname EggFactoryItemAdder295 extends Quest

leveleditem property EggFactoryPotions auto
leveleditem property EggFactoryJewelry auto

leveleditem property LItemPotionMagicEffects auto
leveleditem property LItemPotionMagicEffectsBest auto
leveleditem property LItemApothecaryPotionMagicEffects75 auto

leveleditem property LItemEnchJewelryAll auto
leveleditem property LItemEnchJewelryAll15 auto
leveleditem property LItemEnchJewelryAll75 auto

leveleditem property EggFactortyLItemCursedEgg15 auto
leveleditem property DeathItemBandit auto

leveleditem property EggFactoryLItemCursedDragonTablet auto
leveleditem property DeathItemDragon01 auto

leveleditem property DeathItemChaurusEggs25 auto
leveleditem property EggFActoryLItemCursedChaurusEgg05 auto

leveleditem property DeathItemSlaughterFish auto
leveleditem property EggFactoryDeathItemSlaugterfishEggs25 auto

leveleditem property LItemTomes00AllSpells auto
leveleditem property EggFactoryTomesAlteration auto

Event OnInit()
	debug.trace("Egg Factory 2.9.5 items adding.")
	LItemPotionMagicEffects.AddForm(EggFactoryPotions,1,1)
	LItemPotionMagicEffectsBest.AddForm(EggFactoryPotions,1,1)
	LItemApothecaryPotionMagicEffects75.AddForm(EggFactoryPotions,1,1)
	
	LItemEnchJewelryAll.AddForm(EggFactoryJewelry,1,1)
	LItemEnchJewelryAll15.AddForm(EggFactoryJewelry,1,1)
	LItemEnchJewelryAll75.AddForm(EggFactoryJewelry,1,1)
	
	DeathItemBandit.AddForm(EggFactortyLItemCursedEgg15,1,1)
	DeathItemDragon01.AddForm(EggFactoryLItemCursedDragonTablet,1,1)
	DeathItemChaurusEggs25.AddForm(EggFActoryLItemCursedChaurusEgg05,1,1)
	DeathItemSlaughterFish.AddForm(EggFactoryDeathItemSlaugterfishEggs25,1,1)
	
	LItemTomes00AllSpells.AddForm(EggFactoryTomesAlteration,1,1)
EndEvent