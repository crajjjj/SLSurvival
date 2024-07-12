;/ Decompiled by Champollion V1.0.0
Source   : ConsoleUtil.psc
Modified : 2021-12-06 02:04:39
Compiled : 2021-12-06 02:07:11
User     : ryan_
Computer : DESKTOP-O1MSN1T
/;
scriptName ConsoleUtil

;-- Properties --------------------------------------

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

function SetSelectedReference(ObjectReference a_reference) global native

function ExecuteCommand(String a_command) global native

function PrintMessage(String a_message) global native

Int function GetVersion() global native

String function ReadMessage() global native

ObjectReference function GetSelectedReference() global native

; Skipped compiler generated GetState

function onEndState()
{Event received when this state is switched away from}

	; Empty function
endFunction

; Skipped compiler generated GotoState

function onBeginState()
{Event received when this state is switched to}

	; Empty function
endFunction
