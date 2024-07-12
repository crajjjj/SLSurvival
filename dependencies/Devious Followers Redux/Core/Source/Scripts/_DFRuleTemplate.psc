Scriptname _DFRuleTemplate extends ReferenceAlias  

; should be equal to <group name>/<rule file name> without any file extensions 
String Property RuleName Auto

; User functions - override these in your rule script
Function OnModuleInit()
    {any one time work you need to do on new game}
EndFunction

Function OnModuleLoadGame()
    {any work you need to do everytime the player loads into a save}
EndFunction

Bool Function IsValid(Actor Player)
    {any work you need to do to validate a rule e.g. check registered SL anims, settings, etc.}
    return true
EndFunction

Function Start(Actor Player, _LDC DeviceController)
    {any start up work you need to do e.g. equip devices, start quests, etc.}
EndFunction

Function Stop(Actor Player, _LDC DeviceController)
    {any work you need to do to clean up a rule e.g. stop quests, remove devices}
EndFunction

; Internal - do not edit or override use above instead
Float RegisterDelay = 5.0
_LDC DC
Actor PlayerRef

Event OnInit()
    OnModuleInit()
    RegisterForSingleUpdate(RegisterDelay)
EndEvent

Event OnPlayerLoadGame()
    Debug.Trace("DF - Rule - OnPlayerLoadGame - " + RuleName)
    Utility.Wait(RegisterDelay)
    Initialize()
    OnModuleLoadGame()
EndEvent

Event OnUpdate()
    DC = Game.GetFormFromFile(0x1C494F, "DeviousFollowers.esp") as _LDC
    PlayerRef = GetRef() as Actor
    Initialize()
EndEvent

Function Initialize()
    DealManager.SetRuleValid(GetOwningQuest().GetName() + "/" + RuleName, InternalIsValid())
    (GetOwningQuest() as _DFRulePack).RegisterRule(self)
EndFunction

Bool Function InternalIsValid()
    return IsValid(PlayerRef)
EndFunction

Function InternalStart()
    Debug.Trace("DF - Starting Rule - " + RuleName)
    Start(PlayerRef, DC)
    Debug.Notification(DealManager.GetRuleHint(GetOwningQuest().GetName() + "/" + RuleName))
EndFunction

Function InternalStop()
    Debug.Trace("DF - Stopping Rule - " + RuleName)
    Stop(PlayerRef, DC)
EndFunction

