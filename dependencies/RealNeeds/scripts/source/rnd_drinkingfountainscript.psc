Scriptname RND_DrinkingFountainScript extends ObjectReference  

GlobalVariable Property RND_ThirstPoints Auto
GlobalVariable Property RND_ThirstPointsPerHour Auto
GlobalVariable Property RND_ThirstLastUpdateTimeStamp Auto

RND_PlayerScript Property RND_Player Auto

Event OnActivate(ObjectReference akActionRef)

	If akActionRef == Game.GetPlayer()
	
		If Game.GetPlayer().IsSneaking()
			If RND_Player.isVampire()	
				RemoveThirstSpells()
			Else
				RND_ThirstPoints.SetValue(0)
				RND_ThirstLastUpdateTimeStamp.SetValue(Utility.GetCurrentGameTime())				
				If !Game.GetPlayer().HasSpell(RND_ThirstSpell00)			
					RemoveThirstSpells()
					Game.GetPlayer().AddSpell(RND_ThirstSpell00, False)					
				EndIf
				RND_ThirstLevel00ConsumeMessage.Show()
			EndIf
		Else		
			bool BottlesRefilled = false
		
			Int bCount = 0		
			bCount = akActionRef.GetItemCount(RND_WaterskinEmpty)
			If bCount >= 1
				akActionRef.RemoveItem(RND_WaterskinEmpty, bCount)
				akActionRef.AddItem(RND_WaterskinSpring00, bCount)
				BottlesRefilled = true
			EndIf
		
			bCount = akActionRef.GetItemCount(RND_EmptyBottle01)
			If bCount >= 1
				akActionRef.RemoveItem(RND_EmptyBottle01, bCount)
				akActionRef.AddItem(RND_SpringWater01, bCount)
				BottlesRefilled = true
			EndIf
		
			bCount = akActionRef.GetItemCount(RND_EmptyBottle02)
			If bCount >= 1
				akActionRef.RemoveItem(RND_EmptyBottle02, bCount)
				akActionRef.AddItem(RND_SpringWater02, bCount)
				BottlesRefilled = true
			EndIf
		
			bCount = akActionRef.GetItemCount(RND_EmptyBottle03)
			If bCount >= 1
				akActionRef.RemoveItem(RND_EmptyBottle03, bCount)
				akActionRef.AddItem(RND_SpringWater03, bCount)
				BottlesRefilled = true
			EndIf

			if BottlesRefilled
				if RND_AnimMisc.GetValue() == 1
					if !Game.GetPlayer().GetAnimationVariableInt("i1stPerson") == 1
						Game.GetPlayer().Playidle(idleTake)
					endif
				endif
			else
				RND_NoEmptyBottles.Show()
			endif
		EndIf
	Endif
EndEvent

Idle Property idleTake  Auto
GlobalVariable Property RND_AnimMisc Auto

Potion Property RND_EmptyBottle01  Auto  
Potion Property RND_EmptyBottle02  Auto  
Potion Property RND_EmptyBottle03  Auto
Potion Property RND_WaterskinEmpty Auto

Potion Property RND_SpringWater01  Auto  
Potion Property RND_SpringWater02  Auto  
Potion Property RND_SpringWater03  Auto
Potion Property RND_WaterskinSpring00 Auto

Function RemoveThirstSpells()
	Actor PlayerRef = Game.GetPlayer()
	PlayerRef.RemoveSpell(RND_ThirstSpell00)
	PlayerRef.RemoveSpell(RND_ThirstSpell01)
	PlayerRef.RemoveSpell(RND_ThirstSpell02)
	PlayerRef.RemoveSpell(RND_ThirstSpell03)
	PlayerRef.RemoveSpell(RND_ThirstSpell04)
EndFunction

Spell Property RND_ThirstSpell00 Auto
Spell Property RND_ThirstSpell01 Auto
Spell Property RND_ThirstSpell02 Auto
Spell Property RND_ThirstSpell03 Auto
Spell Property RND_ThirstSpell04 Auto

GlobalVariable Property RND_ThirstLevel00 Auto
Message Property RND_ThirstLevel00ConsumeMessage Auto

Message Property RND_NoEmptyBottles Auto





