;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname PRKF_RND_GrillFoodPerk_0613C8A1 Extends Perk Hidden

;BEGIN FRAGMENT Fragment_1
Function Fragment_1(ObjectReference akTargetRef, Actor akActor)
;BEGIN CODE
BeefCount = PlayerREF.GetItemCount(FoodBeef) as Int
ChickenCount = PlayerREF.GetItemCount(FoodChicken) as Int
GoatCount = PlayerREF.GetItemCount(FoodGoatMeat) as Int
HorkerCount = PlayerREF.GetItemCount(FoodHorkerMeat) as Int
HorseCount = PlayerREF.GetItemCount(FoodHorseMeat) as Int
MammothCount = PlayerREF.GetItemCount(FoodMammothMeat) as Int	
PheasantCount = PlayerREF.GetItemCount(FoodPheasant) as Int
RabbitCount = PlayerREF.GetItemCount(FoodRabbit) as Int
VenisonCount = PlayerREF.GetItemCount(FoodVenison) as Int
SalmonCount = PlayerREF.GetItemCount(FoodSalmon) as Int
LeekCount = PlayerREF.GetItemCount(FoodLeek) as Int
PotatoCount = PlayerREF.GetItemCount(FoodPotato) as Int
CrabCount = PlayerREF.GetItemCount(BYOHFoodMudcrabLegs) as Int
FoodGrouse = Game.GetFormFromFile(0x000170FE, "Real Wildlife Skyrim 0.1.esp")
FoodGrilledGrouse = Game.GetFormFromFile(0x00017100, "Real Wildlife Skyrim 0.1.esp")
FoodWolf = Game.GetFormFromFile(0x00001011, "Real Wildlife Skyrim 0.1.esp")
FoodGrilledWolf = Game.GetFormFromFile(0x00001030, "Real Wildlife Skyrim 0.1.esp")
GrouseCount = PlayerREF.GetItemCount(FoodGrouse) as Int
PlayerREF.RemoveItem(FoodBeef, BeefCount, true)
PlayerREF.Additem(FoodBeefCooked, BeefCount, true)
PlayerREF.RemoveItem(FoodChicken, ChickenCount, true)
PlayerREF.Additem(FoodChickenCooked, ChickenCount, true)
PlayerREF.RemoveItem(FoodGoatMeat, GoatCount, true)
PlayerREF.Additem(FoodGoatMeatCooked, GoatCount, true)
PlayerREF.RemoveItem(FoodHorkerMeat, HorkerCount, true)
PlayerREF.Additem(FoodHorkerMeatCooked, HorkerCount, true)
PlayerREF.RemoveItem(FoodHorseMeat, HorseCount, true)
PlayerREF.Additem(FoodHorseMeatCooked, HorseCount, true)
PlayerREF.RemoveItem(FoodMammothMeat, MammothCount, true)
PlayerREF.Additem(FoodMammothMeatCooked, MammothCount, true)	
PlayerREF.RemoveItem(FoodPheasant, PheasantCount, true)
PlayerREF.Additem(FoodPheasantCooked, PheasantCount, true)
PlayerREF.RemoveItem(FoodRabbit, RabbitCount, true)
PlayerREF.Additem(FoodRabbitCooked, RabbitCount, true)
PlayerREF.RemoveItem(FoodVenison, VenisonCount, true)
PlayerREF.Additem(FoodVenisonCooked, VenisonCount, true)
PlayerREF.RemoveItem(FoodSalmon, SalmonCount, true)
PlayerREF.Additem(FoodSalmonCooked01, SalmonCount, true)
PlayerREF.RemoveItem(FoodLeek, LeekCount, true)
PlayerREF.Additem(FoodLeeksGrilled, LeekCount, true)
PlayerREF.RemoveItem(FoodPotato, PotatoCount, true)
PlayerREF.Additem(FoodPotatoesBaked, PotatoCount, true)
PlayerREF.RemoveItem(BYOHFoodMudcrabLegs, CrabCount, true)
PlayerREF.Additem(BYOHFoodMudcrabLegsCooked, CrabCount, true)
PlayerREF.RemoveItem(FoodGrouse, GrouseCount, true)
PlayerREF.Additem(FoodGrilledGrouse, GrouseCount, true)
PlayerREF.RemoveItem(FoodWolf, WolfCount, true)
PlayerREF.Additem(FoodGrilledWolf, WolfCount, true)
Int CompleteCount = BeefCount + ChickenCount + GoatCount + HorkerCount + HorseCount + MammothCount + PheasantCount + RabbitCount + VenisonCount + SalmonCount + LeekCount + PotatoCount + GrouseCount + WolfCount as Int
Debug.Notification("You've grilled " + CompleteCount + " pieces of food!")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Int BeefCount
Int ChickenCount
Int GoatCount
Int HorkerCount
Int HorseCount
Int MammothCount
Int PheasantCount
Int RabbitCount
Int SalmonCount
Int VenisonCount
Int LeekCount
Int PotatoCount
Int CrabCount
Int GrouseCount
Int WolfCount

Form FoodGrouse
Form FoodGrilledGrouse
Form FoodWolf
Form FoodGrilledWolf

Actor Property PlayerREF Auto
Potion Property FoodBeef Auto
Potion Property FoodBeefCooked Auto
Potion Property FoodChicken Auto
Potion Property FoodChickenCooked Auto
Potion Property FoodGoatMeat Auto
Potion Property FoodGoatMeatCooked Auto
Potion Property FoodHorkerMeat Auto
Potion Property FoodHorkerMeatCooked Auto
Potion Property FoodHorseMeat Auto
Potion Property FoodHorseMeatCooked Auto
Potion Property FoodMammothMeat Auto
Potion Property FoodMammothMeatCooked Auto
Potion Property FoodPheasant Auto
Potion Property FoodPheasantCooked Auto
Potion Property FoodRabbit Auto
Potion Property FoodRabbitCooked Auto
Potion Property FoodSalmon Auto
Potion Property FoodSalmonCooked01 Auto
Potion Property FoodVenison Auto
Potion Property FoodVenisonCooked Auto
Potion Property FoodLeek Auto
Potion Property FoodLeeksGrilled Auto
Potion Property FoodPotato Auto
Potion Property FoodPotatoesBaked Auto
Potion Property BYOHFoodMudcrabLegs Auto
Potion Property BYOHFoodMudcrabLegsCooked Auto