Scriptname xRandomFurnitureIdle extends ObjectReference  Conditional

{Instead of the default, Plays a Random Idle by Name from Array.
    Best use animation event names from the same Funiture anmimation declaration in the FNIS-List.
    For exmple with...   

    fu -a myDanceFloorEnter myDanceFloorEnter.hkx
    + -o myDance1 myDance1.hkx
    + -o myDance2 myDance2.hkx
    + -o myDance3 myDance3.hkx
    + -o myDance4 myDance4.hkx
    + -a myDanceFloorExit myDanceFloorExit.hkx
    ... the event names myDance1-myDance4 or a combination thereof will be a good fit.
}

import utility
import Debug
Import MiscUtil

String[] Property AnimationEventNames Auto
{   Fill this in CK with the various possible Furniture event names.
    Taking for example 3 dances: "myDance1", "myDance2", "myDance4"    
}

int Property NumberOfFurnitureMarkers = 1  Auto
{   Set this to the number of available Furnituremarkers on the mesh,
    if you don't overwrite the default, only the first one will play a random
    animtion. Other Markers will play default.
}

Event OnActivate( ObjectReference akActionRef )
    Actor npc = akActionRef as Actor

    MiscUtil.PrintConsole("Activation")
    if (AnimationEventNames.Length); That is: if AnimationNames-Array is NOT empty, check for free Furniture Marker

        MiscUtil.PrintConsole("Found Animations")
        int i=NumberOfFurnitureMarkers
        if (npc == Game.GetPlayer());check for a free marker, we don't to Debug.sendAnimationEvent to Player if no marker is free
            bool isFree=false
            ;MiscUtil.PrintConsole("Searching free Furnituremarker for player")
            while (i)
                i-=1;
                if !self.IsFurnitureMarkerInUse(i,true)
                    isFree=true;
                    i=0;
                endIf
            endwhile
            if (!isFree)
                ;MiscUtil.PrintConsole("No free FurnitureMarker found, exit function!")
                return
            else
                ;MiscUtil.PrintConsole("Free FurnitureMarker found, go on with function!")
                ;"continue"
            endif
        endif

        ; get random event number
        int maxEventIndex=AnimationEventNames.Length - 1                
        int randomEvent=Utility.randomInt(0, maxEventIndex)

        ;MiscUtil.PrintConsole("Playing:"+randomEvent +" out of "+maxEventIndex)

        ;apply random Event from array to npc:
        Debug.sendAnimationEvent(npc, AnimationEventNames[randomEvent])
    endif
EndEvent