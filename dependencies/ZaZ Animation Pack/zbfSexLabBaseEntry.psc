Scriptname zbfSexLabBaseEntry extends ReferenceAlias

; @section: zbfSexLabBaseEntry
; 
; This script defines basic properties of each SexLab entry.
; 
; These entries are in practice sent through several sessions of filtering in the zbfSexLab:: module. This will
; eliminate most of the default list of entries.
; 
; See zbfSexLab::GetEntriesByTags for more information, or keep on reading.
; 

; Name of the animation, just a simple human readable name
; 
; Example:  
; Skull Fuck  
; Aggressive Missionary  
; Aggressive Doggy Style  
; 
String Property Name Auto

; Identifier for this animation, normally set to the same as BaseName
; 
; Used internally to dynamically build animations.
; 
String Property BaseId Auto

; Identifier for the any corresponding vanilla animation
; 
; Can be used to match an animation base back to its vanilla representation or to find out if a base
; corresponds to a vanilla registration.
; 
String Property VanillaBaseId Auto

; Base name of the animation
;
; These names are used to create the final animation names that are plugged into the 
; support functions in zbfSexLab.
; 
; A typical call to define, say SkullFuck01:
; code:
; zbfSexLab zbfSL = zbfSexLab.GetApi()
; zbfBondageShell zbf = zbfBondageShell.GetApi()
; zbfSexLabBaseEntry entry = .... ; An entry, selected by the modder based on the animation one wants to play
; sslBaseAnimation anim = zbfSL.NewAnimation() ; Fetches the animation we're writing to
; zbfSL.DefineSkullFuck01(anim, "MyModBlowjob", "ZapArmb" + entry.BaseName, entry.VanillaBaseName)
; anim.Save(-1)
; 
; The above code would define the animation skull fuck in the variable anim, allowing it to play
; through SexLab at a later time. Actor1 is set up to be bound with an armbinder, and Actor2 uses
; the default animation set up.
; 
; code: It would be equally possible to set up both actors to be bound by instead calling:  
; zbfSL.DefineSkullFuck01(anim, "MyModBlowjob", "ZapArmb" + entry.BaseName, "ZapYoke" + entry.BaseName)
; 
; In the above code, Actor2 is bound with a yoke instead of an armbinder. Actor1 is still bound in the
; armbinder.
; 
; Example:  
; SkullFuck01  
; Missionary01  
; 
String Property BaseName Auto

; Base name of the vanilla animation
; 
; See ::BaseName for a proper description. Used when setting up custom animations.
; 
String Property VanillaBaseName Auto

; Registered names of this animation.
; 
; Many (most) animations are registered more than once due to several combinations 
; of bound actors and actors in different bindings. Examples are Missionary01 which 
; has variants of Actor1 bound both with armbinder and with regular wrist restraints.
; 
; This property contains all the internal registrations called on zbfSexLab.
; 
String[] Property Registrations Auto

; List of MCM names for each Registration above
; 
; This is a list of $ZapBlahBlahBlah for it to be possible to translate.
; 
String[] Property RegNames Auto

; Global animation tags
; 
; List of tags used by this animation. This is the regular (but slightly truncated) list of SexLab tags.
; 
; Some items are never included here because there already present on all animations, and so there
; is no reason to repeat them here.
;
; Tags not included:  
; ZaZ  
; NoSwap  
; 
; *NOTE:*  
; The list of tags here does not 100% correspond to the list of tags on the final
; animation, as the final animation will have tags such as ZaZ, NoSwap, and so on specified.
; 
String[] Property Tags Auto

; Actor specific tags
; 
; Some actors support different animations than other actors. This set of tags also identifies
; used body parts on each actor. Filter these tags based on if the actor is restrained or similar.
; Chastity belt requires filtering out "vaginal" for that actor, and gags suggest filtering out
; "oral".
; 
; Actor1 typically has the most support.
; 
; Tags here include the animation support of each actor. Note that in the finished animation, 
; only a subset of these should be present.
; 
; Tags used:
; Armbinder - Actor can wear an armbinder
; Yoke - Actor can wear a yoke
; Wrists - Actor can be bound at the wrists
; Oral - Actor needs his/her mouth free for the animation to make sense.
; Vaginal - Actor needs his/her crotch free for the animation to make sense.
; Anal - ....
; Boobs - ....
; Female - Animation slot should only be occupied by a female.
; 
; Example:  
; For Lesbian01,  
; Actor1 = Actor2 = ["Wrists", "Armbinder", "Oral", "Vaginal", "Female"] meaning that both actors can be 
; bound with any combination of armbinder and wrists restraints, or not at all.  
; It also means that both actors need to be females and have the mouth and vagina free for access.
; 
String[] Property Actor1 Auto
String[] Property Actor2 Auto
String[] Property Actor3 Auto
String[] Property Actor4 Auto

; Number of actors this animation is designed for.
; 
; Most animations are designed for two actors, so this is the default value if not explicitly forced to
; something else.
; 
Int Property NumActors Auto

; Returns true if the Entry is (globally) tagged with the keyword.
;
; Equivalent to calling HasTagForActor with aiActor set to zero.
; 
Bool Function HasTag(String asTag)
	Return Tags.Find(asTag) >= 0
EndFunction

; Returns true if any tag is present for the specified actor slot
; 
Bool Function HasAnyTag(Int aiActor, String[] asTags)
	String[] actorTags = GetTags(aiActor)
	Int i = asTags.Length
	While i > 0
		i -= 1
		If (asTags[i] != "") && (actorTags.Find(asTags[i]) >= 0)
			Return True
		EndIf
	EndWhile
	Return False
EndFunction

; Returns true if aiActor (1-4) is tagged with the keyword.
; 
; Used to filter out animations containing support for a certain type of binding. If
; actor is specified as #0, then the global list of tags is returned.
; 
Bool Function HasTagForActor(Int aiActor, String asTag)
	Return GetTags(aiActor).Find(asTag) >= 0
EndFunction

; Check actor tags against forbidden and required tags.
; 
; Return True only if all required tags were found and no blocked tags were found.
; 
Bool Function IsValidTags(Int aiActor, String[] asRequired, String[] asForbidden)
	Int req
	String[] actorTags = GetTags(aiActor)

	req = asRequired.Length
	While (req > 0)
		req -= 1
		If (asRequired[req] != "") && (actorTags.Find(asRequired[req]) < 0)
			Return False
		EndIf
	EndWhile

	req = asForbidden.Length
	While (req > 0)
		req -= 1
		If (asForbidden[req] != "") && (actorTags.Find(asForbidden[req]) >= 0)
			Return False
		EndIf
	EndWhile

	Return True ; Passed all checks
EndFunction

; Returns the tags for the provided argument
; 
; aiActor specifies the actor to retrieve tags for (1-4), or 0 to fetch the global
; tags pool.
; 
String[] Function GetTags(Int aiActor)
	String[] foundTags
	If aiActor == 0
		foundTags = Tags
	ElseIf aiActor == 1
		foundTags = Actor1
	ElseIf aiActor == 2
		foundTags = Actor2
	ElseIf aiActor == 3
		foundTags = Actor3
	ElseIf aiActor == 4
		foundTags = Actor4
	EndIf
	Return foundTags
EndFunction

; Initializes all values to default settings
; 
Function SetDefaults()
	String[] empty

	Name = ""
	BaseId = ""
	VanillaBaseId = ""
	BaseName = ""
	VanillaBaseName = ""

	Registrations = empty
	RegNames = empty

	Tags = empty

	Actor1 = empty
	Actor2 = empty
	Actor3 = empty
	Actor4 = empty

	NumActors = 2
EndFunction

; Do some finalization step
; 
Function Finalize()
	; Currently empty
EndFunction
