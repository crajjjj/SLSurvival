ScriptName		_SUB_ChildActorScript		Extends		Actor

string	myName	=	"Kiddo"								; string to store this kid's name

event	OnLoad()
	RegModEvents()
endEvent

event	OnCellAttach()
	RegModEvents()
endEvent

event	OnPackageChange(package whoCares)
	RegModEvents()
endEvent

function	RegModEvents()

	RegisterForModEvent("FMChildRenamed", "IsItMe")
	RegisterForModEvent("FMCheckNames", "CheckMyName")
	CheckMyName()

endFunction

event	IsItMe(form theActor, string theName)

	if theActor == self as form
		myName = theName
		CheckMyName()
	endIf

endEvent

event	CheckMyName(string eventName = "", string strArg = "", float numArg = 0.0, Form sender = none)

	SetDisplayName(myName, false)

endEvent
