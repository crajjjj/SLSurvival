;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname SLV_ColdharbourSex11 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
Actor player = Game.getplayer()

;player.RemoveSpell(DLC1VampireChange)
;player.AddSpell(DLC1VampireChange)
;player.RemovePerk(DLC1VampireTurnPerk)			
;player.AddPerk(DLC1VampireTurnPerk)

SLV_MolagBal.GetActorRef().SetAV("Aggression", 0)
SLV_MolagBal.GetActorRef().SetAV("Confidence", 0)

SLV_Sanguine.GetActorRef().SetAV("Aggression", 0)
SLV_Sanguine.GetActorRef().SetAV("Confidence", 0)

SLV_MehrunesDagon.GetActorRef().SetAV("Aggression", 0)
SLV_MehrunesDagon.GetActorRef().SetAV("Confidence", 0)

SLV_Malacath.GetActorRef().SetAV("Aggression", 0)
SLV_Malacath.GetActorRef().SetAV("Confidence", 0)

Utility.wait(2.0)

DLC1VampireChange.cast(player)

SLV_MolagBal.GetActorRef().SetAV("Aggression", 0)
SLV_MolagBal.GetActorRef().SetAV("Confidence", 0)

SLV_Sanguine.GetActorRef().SetAV("Aggression", 0)
SLV_Sanguine.GetActorRef().SetAV("Confidence", 0)

SLV_MehrunesDagon.GetActorRef().SetAV("Aggression", 0)
SLV_MehrunesDagon.GetActorRef().SetAV("Confidence", 0)

SLV_Malacath.GetActorRef().SetAV("Aggression", 0)
SLV_Malacath.GetActorRef().SetAV("Confidence", 0)

;END CODE
EndFunction
;END FRAGMENT
;END FRAGMENT CODE - Do not edit anything between this and the begin comment
Perk Property DLC1VampireTurnPerk Auto
Spell Property DLC1VampireChange Auto 
Spell Property DLC1RevertForm Auto

ReferenceAlias Property SLV_MolagBal Auto
ReferenceAlias Property SLV_Sanguine Auto
ReferenceAlias Property SLV_MehrunesDagon Auto
ReferenceAlias Property SLV_Malacath Auto



