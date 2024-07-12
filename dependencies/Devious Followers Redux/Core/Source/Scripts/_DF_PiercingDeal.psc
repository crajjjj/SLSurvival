Scriptname _DF_PiercingDeal extends _DDeal Conditional

Key Property PTool Auto

Function CleanUp()
    Parent.CleanUp()
    Game.GetPlayer().Additem(PTool, 1)
EndFunction