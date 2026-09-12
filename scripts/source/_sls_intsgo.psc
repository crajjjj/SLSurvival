Scriptname _SLS_IntSgo Hidden
{Wrappers around Soulgem Oven IV - Insemination Fantasies (SGO4IF.esp).

SGO4IF publishes every per-actor value as a faction RANK (its "For Modders/Factions.txt"):
percentage factions carry 0-100, flag factions 0 or 1, and enum factions an archetype id.
An actor SGO4IF has never touched is simply not in the faction, so GetFactionRank gives -1.

Reading factions rather than casting SGO4IF's quests to dse_sgo_QuestDatabase_Main is
deliberate: the faction names are the author's documented modder API, the script names are
not - the previous integration here died silently when SGO3's dcc_sgo_QuestController went
away. It also keeps SGO4IF's script chain (MCM, CBPC, iWant_Widgets) out of the SLS build.}

Int Function GetRank(Faction akFaction, Actor akTarget) Global
{Raw rank, or -1 when SGO4IF is not tracking this actor.}
	If !akFaction || !akTarget
		Return -1
	EndIf
	Return akTarget.GetFactionRank(akFaction)
EndFunction

Float Function GetPercent(Faction akFaction, Actor akTarget) Global
{A 0-100 percentage faction. Untracked actors read as 0.}
	Int Rank = _SLS_IntSgo.GetRank(akFaction, akTarget)
	If Rank <= 0
		Return 0.0
	ElseIf Rank > 100
		Return 100.0
	EndIf
	Return Rank as Float
EndFunction

Int Function GetEnum(Faction akFaction, Actor akTarget) Global
{An archetype/flag faction, where SGO4IF's own 0 means "untracked" - so -1 folds into 0.}
	Int Rank = _SLS_IntSgo.GetRank(akFaction, akTarget)
	If Rank < 0
		Return 0
	EndIf
	Return Rank
EndFunction

Bool Function GetIsMember(Faction akFaction, Actor akTarget) Global
{Membership-only faction (the corruption flags); their rank carries no meaning.}
	If !akFaction || !akTarget
		Return false
	EndIf
	Return akTarget.IsInFaction(akFaction)
EndFunction
