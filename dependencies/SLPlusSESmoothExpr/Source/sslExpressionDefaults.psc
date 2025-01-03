scriptname sslExpressionDefaults extends sslExpressionFactory

function LoadExpressions()
	; Prepare factory resources
	PrepareFactory()
	; Regsiter expressions
	RegisterExpression("Pleasure")
	RegisterExpression("Happy")
	RegisterExpression("Joy")
	RegisterExpression("Shy")
	RegisterExpression("Sad")
	RegisterExpression("Afraid")
	RegisterExpression("Pained")
	RegisterExpression("Angry")

	; Regsiter Ahegao expressions
	RegisterExpression("AhegaoPleasure")
	RegisterExpression("AhegaoHappy")
	RegisterExpression("AhegaoJoy")
	RegisterExpression("AhegaoShy")
	RegisterExpression("AhegaoSad")
	RegisterExpression("AhegaoAfraid")
	RegisterExpression("AhegaoPained")
	RegisterExpression("AhegaoAngry")

	RegisterExpression("AhegaoBeastPleasure")
	RegisterExpression("AhegaoBeastHappy")
	RegisterExpression("AhegaoBeastJoy")
	RegisterExpression("AhegaoBeastShy")
	RegisterExpression("AhegaoBeastSad")
	RegisterExpression("AhegaoBeastAfraid")
	RegisterExpression("AhegaoBeastPained")
	RegisterExpression("AhegaoBeastAngry")

	; Empty customizable expressions
	RegisterExpression("Custom1")
	RegisterExpression("Custom2")
	RegisterExpression("Custom3")
	RegisterExpression("Custom4")
	RegisterExpression("Custom5")

endFunction

function Pleasure(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Pleasure"
	Base.SetTags("Normal,Happy,Consensual,Pleasure")

	; Female
	Base.SetMood(1, Female, 2, 30)
	Base.SetPhoneme(1, Female, 5, 30)
	Base.SetPhoneme(1, Female, 6, 10)

	Base.SetMood(2, Female, 10, 50)
	Base.SetModifier(2, Female, 4, 30)
	Base.SetModifier(2, Female, 5, 30)
	Base.SetModifier(2, Female, 6, 20)
	Base.SetModifier(2, Female, 7, 20)
	Base.SetPhoneme(2, Female, 0, 20)
	Base.SetPhoneme(2, Female, 3, 30)

	Base.SetMood(3, Female, 10, 70)
	Base.SetModifier(3, Female, 2, 50)
	Base.SetModifier(3, Female, 3, 50)
	Base.SetModifier(3, Female, 4, 30)
	Base.SetModifier(3, Female, 5, 30)
	Base.SetModifier(3, Female, 6, 70)
	Base.SetModifier(3, Female, 7, 40)
	Base.SetPhoneme(3, Female, 12, 30)
	Base.SetPhoneme(3, Female, 13, 10)

	Base.SetMood(4, Female, 10, 100)
	Base.SetModifier(4, Female, 0, 10)
	Base.SetModifier(4, Female, 1, 10)
	Base.SetModifier(4, Female, 2, 25)
	Base.SetModifier(4, Female, 3, 25)
	Base.SetModifier(4, Female, 6, 100)
	Base.SetModifier(4, Female, 7, 100)
	Base.SetModifier(4, Female, 12, 30)
	Base.SetModifier(4, Female, 13, 30)
	Base.SetPhoneme(4, Female, 4, 35)
	Base.SetPhoneme(4, Female, 10, 20)
	Base.SetPhoneme(4, Female, 12, 30)

	Base.SetMood(5, Female, 12, 60)
	Base.SetModifier(5, Female, 0, 15)
	Base.SetModifier(5, Female, 1, 15)
	Base.SetModifier(5, Female, 2, 25)
	Base.SetModifier(5, Female, 3, 25)
	Base.SetModifier(5, Female, 4, 60)
	Base.SetModifier(5, Female, 5, 60)
	Base.SetModifier(5, Female, 11, 100)
	Base.SetModifier(5, Female, 12, 70)
	Base.SetModifier(5, Female, 13, 30)
	Base.SetPhoneme(5, Female, 0, 40)
	Base.SetPhoneme(5, Female, 5, 20)
	Base.SetPhoneme(5, Female, 12, 80)
	Base.SetPhoneme(5, Female, 15, 20)

	; Male
	Base.SetMood(1, Male, 13, 40)
	Base.SetModifier(1, Male, 6, 20)
	Base.SetModifier(1, Male, 7, 20)
	Base.SetPhoneme(1, Male, 5, 20)

	Base.SetMood(2, Male, 8, 40)
	Base.SetModifier(2, Male, 12, 40)
	Base.SetModifier(2, Male, 13, 40)
	Base.SetPhoneme(2, Male, 2, 50)
	Base.SetPhoneme(2, Male, 13, 20)

	Base.SetMood(3, Male, 13, 80)
	Base.SetModifier(3, Male, 6, 80)
	Base.SetModifier(3, Male, 7, 80)
	Base.SetModifier(3, Male, 12, 30)
	Base.SetModifier(3, Male, 13, 30)
	Base.SetPhoneme(3, Male, 0, 30)

	Base.Save(id)
endFunction

function Shy(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Shy"
	Base.SetTags("Normal,Consensual,Nervous,Sad,Shy")

	; Male + Female
	Base.SetMood(1, MaleFemale, 4, 90)
	Base.SetModifier(1, MaleFemale, 11, 20)
	Base.SetPhoneme(1, MaleFemale, 1, 10)
	Base.SetPhoneme(1, MaleFemale, 11, 10)

	Base.SetMood(2, MaleFemale, 3, 50)
	Base.SetModifier(2, MaleFemale, 8, 50)
	Base.SetModifier(2, MaleFemale, 9, 40)
	Base.SetModifier(2, MaleFemale, 12, 30)

	Base.SetMood(3, MaleFemale, 3, 50)
	Base.SetModifier(3, MaleFemale, 8, 50)
	Base.SetModifier(3, MaleFemale, 9, 40)
	Base.SetModifier(3, MaleFemale, 12, 30)
	Base.SetPhoneme(3, MaleFemale, 1, 10)
	Base.SetPhoneme(3, MaleFemale, 11, 10)

	Base.Save(id)
endFunction

function Afraid(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Afraid"
	Base.SetTags("Aggressor,Afraid,Scared,Pain,Negative")

	; Male + Female
	Base.SetMood(1, MaleFemale, 3, 100)
	Base.SetModifier(1, MaleFemale, 2, 10)
	Base.SetModifier(1, MaleFemale, 3, 10)
	Base.SetModifier(1, MaleFemale, 6, 50)
	Base.SetModifier(1, MaleFemale, 7, 50)
	Base.SetModifier(1, MaleFemale, 1, 30)
	Base.SetModifier(1, MaleFemale, 12, 30)
	Base.SetModifier(1, MaleFemale, 13, 30)
	Base.SetPhoneme(1, MaleFemale, 0, 20)

	Base.SetMood(2, MaleFemale, 8, 100)
	Base.SetModifier(2, MaleFemale, 0, 100)
	Base.SetModifier(2, MaleFemale, 1, 100)
	Base.SetModifier(2, MaleFemale, 2, 100)
	Base.SetModifier(2, MaleFemale, 3, 100)
	Base.SetModifier(2, MaleFemale, 4, 100)
	Base.SetModifier(2, MaleFemale, 5, 100)
	Base.SetPhoneme(2, MaleFemale, 2, 100)
	Base.SetPhoneme(2, MaleFemale, 2, 100)
	Base.SetPhoneme(2, MaleFemale, 5, 40)

	Base.SetMood(3, MaleFemale, 3, 100)
	Base.SetModifier(3, MaleFemale, 11, 50)
	Base.SetModifier(3, MaleFemale, 13, 40)
	Base.SetPhoneme(3, MaleFemale, 2, 50)
	Base.SetPhoneme(3, MaleFemale, 13, 20)
	Base.SetPhoneme(3, MaleFemale, 15, 40)

	Base.SetMood(4, MaleFemale, 9, 100)
	Base.SetModifier(4, MaleFemale, 2, 100)
	Base.SetModifier(4, MaleFemale, 3, 100)
	Base.SetModifier(4, MaleFemale, 4, 100)
	Base.SetModifier(4, MaleFemale, 5, 100)
	Base.SetModifier(4, MaleFemale, 11, 90)
	Base.SetPhoneme(4, MaleFemale, 0, 30)
	Base.SetPhoneme(4, MaleFemale, 2, 30)


	Base.Save(id)
endFunction

function Pained(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Pained"
	Base.SetTags("Victim,Afraid,Pain,Pained,Negative")

	; Male + Female
	Base.SetMood(1, MaleFemale, 3, 100)
	Base.SetModifier(1, MaleFemale, 2, 10)
	Base.SetModifier(1, MaleFemale, 3, 10)
	Base.SetModifier(1, MaleFemale, 6, 50)
	Base.SetModifier(1, MaleFemale, 7, 50)
	Base.SetModifier(1, MaleFemale, 1, 30)
	Base.SetModifier(1, MaleFemale, 12, 30)
	Base.SetModifier(1, MaleFemale, 13, 30)
	Base.SetPhoneme(1, MaleFemale, 0, 20)

	Base.SetMood(2, MaleFemale, 3, 100)
	Base.SetModifier(2, MaleFemale, 11, 50)
	Base.SetModifier(2, MaleFemale, 13, 40)
	Base.SetPhoneme(2, MaleFemale, 2, 50)
	Base.SetPhoneme(2, MaleFemale, 13, 20)
	Base.SetPhoneme(2, MaleFemale, 15, 40)

	Base.SetMood(3, MaleFemale, 8, 100)
	Base.SetModifier(3, MaleFemale, 0, 100)
	Base.SetModifier(3, MaleFemale, 1, 100)
	Base.SetModifier(3, MaleFemale, 2, 100)
	Base.SetModifier(3, MaleFemale, 3, 100)
	Base.SetModifier(3, MaleFemale, 4, 100)
	Base.SetModifier(3, MaleFemale, 5, 100)
	Base.SetPhoneme(3, MaleFemale, 2, 100)
	Base.SetPhoneme(3, MaleFemale, 5, 40)

	Base.SetMood(4, MaleFemale, 9, 100)
	Base.SetModifier(4, MaleFemale, 2, 100)
	Base.SetModifier(4, MaleFemale, 3, 100)
	Base.SetModifier(4, MaleFemale, 4, 100)
	Base.SetModifier(4, MaleFemale, 5, 100)
	Base.SetModifier(4, MaleFemale, 11, 90)
	Base.SetPhoneme(4, MaleFemale, 0, 30)
	Base.SetPhoneme(4, MaleFemale, 2, 30)

	Base.Save(id)
endFunction

function Angry(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Angry"
	Base.SetTags("Aggressor,Victim,Mad,Angry,Upset")

	; Male + Female
	Base.SetMood(1, MaleFemale, 8, 40)
	Base.SetModifier(1, MaleFemale, 12, 30)
	Base.SetModifier(1, MaleFemale, 13, 30)
	Base.SetPhoneme(1, MaleFemale, 4, 40)

	Base.SetMood(2, MaleFemale, 8, 55)
	Base.SetModifier(2, MaleFemale, 12, 50)
	Base.SetModifier(2, MaleFemale, 13, 50)
	Base.SetPhoneme(2, MaleFemale, 4, 40)

	Base.SetMood(3, MaleFemale, 8, 100)
	Base.SetModifier(3, MaleFemale, 12, 65)
	Base.SetModifier(3, MaleFemale, 13, 65)
	Base.SetPhoneme(3, MaleFemale, 4, 50)
	Base.SetPhoneme(3, MaleFemale, 3, 40)

	Base.Save(id)
endFunction

function Happy(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Happy"
	Base.SetTags("Normal,Happy,Consensual")

	; Male + Female
	Base.SetMood(1, MaleFemale, 2, 50)
	Base.SetModifier(1, MaleFemale, 12, 50)
	Base.SetModifier(1, MaleFemale, 13, 50)
	Base.SetPhoneme(1, MaleFemale, 5, 50)

	Base.SetMood(2, MaleFemale, 2, 70)
	Base.SetModifier(2, MaleFemale, 12, 70)
	Base.SetModifier(2, MaleFemale, 13, 70)
	Base.SetPhoneme(2, MaleFemale, 5, 50)
	Base.SetPhoneme(2, MaleFemale, 8, 50)

	Base.SetMood(3, MaleFemale, 2, 80)
	Base.SetModifier(3, MaleFemale, 12, 80)
	Base.SetModifier(3, MaleFemale, 13, 80)
	Base.SetPhoneme(3, MaleFemale, 5, 50)
	Base.SetPhoneme(3, MaleFemale, 11, 60)

	Base.Save(id)
endFunction

function Sad(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Sad"
	Base.SetTags("Normal,Victim,Sad")

	; Male + Female
	Base.SetMood(1, MaleFemale, 2, 50)
	Base.SetModifier(1, MaleFemale, 12, 50)
	Base.SetModifier(1, MaleFemale, 13, 50)
	Base.SetPhoneme(1, MaleFemale, 5, 50)

	Base.SetMood(2, MaleFemale, 2, 70)
	Base.SetModifier(2, MaleFemale, 12, 70)
	Base.SetModifier(2, MaleFemale, 13, 70)
	Base.SetPhoneme(2, MaleFemale, 5, 50)
	Base.SetPhoneme(2, MaleFemale, 8, 50)

	Base.SetMood(3, MaleFemale, 2, 80)
	Base.SetModifier(3, MaleFemale, 12, 80)
	Base.SetModifier(3, MaleFemale, 13, 80)
	Base.SetPhoneme(3, MaleFemale, 5, 50)
	Base.SetPhoneme(3, MaleFemale, 11, 60)

	Base.Save(id)
endFunction

function Joy(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Joy"
	Base.SetTags("Normal,Happy,Joy,Pleasure,Consensual")

	; Female
	Base.SetMood(1, Female, 10, 45)
	Base.SetPhoneme(1, Female, 0, 30)
	Base.SetPhoneme(1, Female, 7, 60)
	Base.SetPhoneme(1, Female, 12, 60)
	Base.SetModifier(1, Female, 0, 30)
	Base.SetModifier(1, Female, 1, 30)
	Base.SetModifier(1, Female, 4, 100)
	Base.SetModifier(1, Female, 5, 100)
	Base.SetModifier(1, Female, 12, 70)
	Base.SetModifier(1, Female, 13, 70)

	Base.SetMood(2, Female, 10, 60)
	Base.SetPhoneme(2, Female, 7, 100)
	Base.SetPhoneme(2, Female, 15, 50)
	Base.SetModifier(2, Female, 0, 30)
	Base.SetModifier(2, Female, 1, 30)
	Base.SetModifier(2, Female, 4, 100)
	Base.SetModifier(2, Female, 5, 100)
	Base.SetModifier(2, Female, 12, 70)
	Base.SetModifier(2, Female, 13, 70)

	Base.SetMood(3, Female, 10, 60)
	Base.SetPhoneme(3, Female, 7, 100)
	Base.SetPhoneme(3, Female, 15, 50)
	Base.SetModifier(3, Female, 0, 30)
	Base.SetModifier(3, Female, 1, 30)
	Base.SetModifier(3, Female, 4, 100)
	Base.SetModifier(3, Female, 5, 100)
	Base.SetModifier(3, Female, 12, 70)
	Base.SetModifier(3, Female, 13, 70)

	Base.SetMood(4, Female, 10, 45)
	Base.SetPhoneme(4, Female, 0, 10)
	Base.SetPhoneme(4, Female, 6, 50)
	Base.SetPhoneme(4, Female, 7, 50)
	Base.SetModifier(4, Female, 0, 30)
	Base.SetModifier(4, Female, 1, 30)
	Base.SetModifier(4, Female, 2, 70)
	Base.SetModifier(4, Female, 3, 70)
	Base.SetModifier(4, Female, 4, 100)
	Base.SetModifier(4, Female, 5, 100)
	Base.SetModifier(4, Female, 12, 70)
	Base.SetModifier(4, Female, 13, 70)

	Base.SetMood(5, Female, 10, 60)
	Base.SetPhoneme(5, Female, 0, 60)
	Base.SetPhoneme(5, Female, 6, 50)
	Base.SetPhoneme(5, Female, 7, 50)
	Base.SetModifier(5, Female, 0, 30)
	Base.SetModifier(5, Female, 1, 30)
	Base.SetModifier(5, Female, 2, 70)
	Base.SetModifier(5, Female, 3, 70)
	Base.SetModifier(5, Female, 4, 100)
	Base.SetModifier(5, Female, 5, 100)
	Base.SetModifier(5, Female, 12, 70)
	Base.SetModifier(5, Female, 13, 70)

	; Male (copy of pleasure)
	Base.SetMood(1, Male, 13, 40)
	Base.SetModifier(1, Male, 6, 20)
	Base.SetModifier(1, Male, 7, 20)
	Base.SetPhoneme(1, Male, 5, 20)

	Base.SetMood(2, Male, 8, 40)
	Base.SetModifier(2, Male, 12, 40)
	Base.SetModifier(2, Male, 13, 40)
	Base.SetPhoneme(2, Male, 2, 50)
	Base.SetPhoneme(2, Male, 13, 20)

	Base.SetMood(3, Male, 13, 80)
	Base.SetModifier(3, Male, 6, 80)
	Base.SetModifier(3, Male, 7, 80)
	Base.SetModifier(3, Male, 12, 30)
	Base.SetModifier(3, Male, 13, 30)
	Base.SetPhoneme(3, Male, 0, 30)

	Base.Save(id)
endFunction

function AhegaoPleasure(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Ahegao Pleasure"
	Base.SetTags("Normal,Happy,Consensual,Pleasure,NoBeast,Ahegao")

	; Female
	Base.SetMood(1, Female, 2, 30)
	Base.SetPhoneme(1, Female, 5, 30)
	Base.SetLipFixedPhase(1, Female, 1)
	Base.SetEquipmentPhase(1, Female, Slots.Config.GetFaceItem(5))
	Base.SetPhoneme(1, Female, 1, 100)
	Base.SetPhoneme(1, Female, 0, 50)
	Base.SetPhoneme(1, Female, 6, 50)
	Base.SetModifier(1, Female, 11, 20)

	Base.SetMood(2, Female, 10, 50)
	Base.SetModifier(2, Female, 4, 30)
	Base.SetModifier(2, Female, 5, 30)
	Base.SetModifier(2, Female, 6, 20)
	Base.SetModifier(2, Female, 7, 20)
	Base.SetPhoneme(2, Female, 3, 30)
	Base.SetLipFixedPhase(2, Female, 1)
	Base.SetEquipmentPhase(2, Female, Slots.Config.GetFaceItem(3))
	Base.SetPhoneme(2, Female, 1, 50)
	Base.SetPhoneme(2, Female, 0, 25)
	Base.SetPhoneme(2, Female, 6, 25)
	Base.SetModifier(2, Female, 11, 40)

	Base.SetMood(3, Female, 10, 70)
	Base.SetModifier(3, Female, 2, 50)
	Base.SetModifier(3, Female, 3, 50)
	Base.SetModifier(3, Female, 4, 30)
	Base.SetModifier(3, Female, 5, 30)
	Base.SetModifier(3, Female, 6, 70)
	Base.SetModifier(3, Female, 7, 40)
	Base.SetPhoneme(3, Female, 12, 30)
	Base.SetPhoneme(3, Female, 13, 10)
	Base.SetLipFixedPhase(3, Female, 1)
	Base.SetEquipmentPhase(3, Female, Slots.Config.GetFaceItem(10))
	Base.SetPhoneme(3, Female, 1, 80)
	Base.SetPhoneme(3, Female, 0, 40)
	Base.SetPhoneme(3, Female, 6, 40)
	Base.SetModifier(3, Female, 11, 60)

	Base.SetMood(4, Female, 10, 100)
	Base.SetModifier(4, Female, 0, 10)
	Base.SetModifier(4, Female, 1, 10)
	Base.SetModifier(4, Female, 2, 25)
	Base.SetModifier(4, Female, 3, 25)
	Base.SetModifier(4, Female, 6, 100)
	Base.SetModifier(4, Female, 7, 100)
	Base.SetModifier(4, Female, 12, 30)
	Base.SetModifier(4, Female, 13, 30)
	Base.SetPhoneme(4, Female, 4, 35)
	Base.SetPhoneme(4, Female, 10, 20)
	Base.SetPhoneme(4, Female, 12, 30)
	Base.SetLipFixedPhase(4, Female, 1)
	Base.SetEquipmentPhase(4, Female, Slots.Config.GetFaceItem(4))
	Base.SetPhoneme(4, Female, 1, 100)
	Base.SetPhoneme(4, Female, 0, 50)
	Base.SetPhoneme(4, Female, 6, 50)
	Base.SetModifier(4, Female, 11, 100)

	Base.SetMood(5, Female, 12, 60)
	Base.SetModifier(5, Female, 0, 15)
	Base.SetModifier(5, Female, 1, 15)
	Base.SetModifier(5, Female, 2, 25)
	Base.SetModifier(5, Female, 3, 25)
	Base.SetModifier(5, Female, 4, 60)
	Base.SetModifier(5, Female, 5, 60)
	Base.SetModifier(5, Female, 12, 70)
	Base.SetModifier(5, Female, 13, 30)
	Base.SetPhoneme(5, Female, 5, 20)
	Base.SetPhoneme(5, Female, 12, 80)
	Base.SetPhoneme(5, Female, 15, 20)
	Base.SetLipFixedPhase(5, Female, 1)
	Base.SetEquipmentPhase(5, Female, Slots.Config.GetFaceItem(7))
	Base.SetPhoneme(5, Female, 1, 50)
	Base.SetPhoneme(5, Female, 0, 25)
	Base.SetPhoneme(5, Female, 6, 25)
	Base.SetModifier(5, Female, 11, 100)

	; Male
	Base.SetMood(1, Male, 13, 40)
	Base.SetModifier(1, Male, 6, 20)
	Base.SetModifier(1, Male, 7, 20)
	Base.SetPhoneme(1, Male, 5, 20)
	Base.SetLipFixedPhase(1, Male, 1)
	Base.SetEquipmentPhase(1, Male, Slots.Config.GetFaceItem(3))
	Base.SetPhoneme(1, Male, 1, 100)
	Base.SetModifier(1, Male, 11, 20)

	Base.SetMood(2, Male, 8, 40)
	Base.SetModifier(2, Male, 12, 40)
	Base.SetModifier(2, Male, 13, 40)
	Base.SetPhoneme(2, Male, 2, 50)
	Base.SetPhoneme(2, Male, 13, 20)
	Base.SetLipFixedPhase(2, Male, 1)
	Base.SetEquipmentPhase(2, Male, Slots.Config.GetFaceItem(10))
	Base.SetPhoneme(2, Male, 1, 100)
	Base.SetModifier(2, Male, 11, 40)

	Base.SetMood(3, Male, 13, 80)
	Base.SetModifier(3, Male, 6, 80)
	Base.SetModifier(3, Male, 7, 80)
	Base.SetModifier(3, Male, 12, 30)
	Base.SetModifier(3, Male, 13, 30)
	Base.SetPhoneme(3, Male, 0, 30)
	Base.SetLipFixedPhase(3, Male, 1)
	Base.SetEquipmentPhase(3, Male, Slots.Config.GetFaceItem(7))
	Base.SetPhoneme(3, Male, 1, 100)
	Base.SetModifier(3, Male, 11, 80)

	Base.Save(id)
	Base.Enabled   = false
endFunction

function AhegaoShy(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Ahegao Shy"
	Base.SetTags("Normal,Consensual,Nervous,Sad,Shy,NoBeast,Ahegao")

	; Male + Female
	Base.SetMood(1, MaleFemale, 4, 90)
	Base.SetModifier(1, MaleFemale, 11, 20)
	Base.SetPhoneme(1, MaleFemale, 1, 10)
	Base.SetPhoneme(1, MaleFemale, 11, 10)

	Base.SetMood(2, MaleFemale, 3, 50)
	Base.SetModifier(2, MaleFemale, 8, 50)
	Base.SetModifier(2, MaleFemale, 9, 40)
	Base.SetModifier(2, MaleFemale, 12, 30)

	Base.SetMood(3, MaleFemale, 3, 50)
	Base.SetModifier(3, MaleFemale, 8, 50)
	Base.SetModifier(3, MaleFemale, 9, 40)
	Base.SetModifier(3, MaleFemale, 12, 30)
	Base.SetPhoneme(3, MaleFemale, 1, 10)
	Base.SetPhoneme(3, MaleFemale, 11, 10)
	Base.SetLipFixedPhase(3, MaleFemale, 1)
	Base.SetEquipmentPhase(3, MaleFemale, Slots.Config.GetFaceItem(6))

	; Female
	Base.SetPhoneme(3, Female, 1, 80)
	Base.SetPhoneme(3, Female, 0, 40)
	Base.SetPhoneme(3, Female, 6, 40)

	; Male
	Base.SetPhoneme(3, Male, 1, 30)
	Base.SetPhoneme(3, Male, 0, 15)
	Base.SetPhoneme(3, Male, 6, 15)

	Base.Save(id)
	Base.Enabled   = false
endFunction

function AhegaoAfraid(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Ahegao Afraid"
	Base.SetTags("Aggressor,Afraid,Scared,Pain,Negative,NoBeast,Ahegao")

	; Male + Female
	Base.SetMood(1, MaleFemale, 3, 100)
	Base.SetModifier(1, MaleFemale, 2, 10)
	Base.SetModifier(1, MaleFemale, 3, 10)
	Base.SetModifier(1, MaleFemale, 6, 50)
	Base.SetModifier(1, MaleFemale, 7, 50)
	Base.SetModifier(1, MaleFemale, 1, 30)
	Base.SetModifier(1, MaleFemale, 12, 30)
	Base.SetModifier(1, MaleFemale, 13, 30)
	Base.SetPhoneme(1, MaleFemale, 0, 20)

	Base.SetMood(2, MaleFemale, 8, 100)
	Base.SetModifier(2, MaleFemale, 0, 100)
	Base.SetModifier(2, MaleFemale, 1, 100)
	Base.SetModifier(2, MaleFemale, 2, 100)
	Base.SetModifier(2, MaleFemale, 3, 100)
	Base.SetModifier(2, MaleFemale, 4, 100)
	Base.SetModifier(2, MaleFemale, 5, 100)
	Base.SetPhoneme(2, MaleFemale, 2, 100)
	Base.SetPhoneme(2, MaleFemale, 2, 100)
	Base.SetPhoneme(2, MaleFemale, 5, 40)

	Base.SetMood(3, MaleFemale, 3, 100)
	Base.SetModifier(3, MaleFemale, 11, 50)
	Base.SetModifier(3, MaleFemale, 13, 40)
	Base.SetPhoneme(3, MaleFemale, 2, 50)
	Base.SetPhoneme(3, MaleFemale, 13, 20)
	Base.SetPhoneme(3, MaleFemale, 15, 40)
	Base.SetLipFixedPhase(3, MaleFemale, 1)
	Base.SetEquipmentPhase(3, MaleFemale, Slots.Config.GetFaceItem(8))

	Base.SetMood(4, MaleFemale, 9, 100)
	Base.SetModifier(4, MaleFemale, 2, 100)
	Base.SetModifier(4, MaleFemale, 3, 100)
	Base.SetModifier(4, MaleFemale, 4, 100)
	Base.SetModifier(4, MaleFemale, 5, 100)
	Base.SetPhoneme(4, MaleFemale, 2, 30)
	Base.SetLipFixedPhase(4, MaleFemale, 1)
	Base.SetEquipmentPhase(4, MaleFemale, Slots.Config.GetFaceItem(5))
	Base.SetModifier(4, MaleFemale, 11, 90)

	; Female

	Base.SetPhoneme(3, Female, 1, 50)
	Base.SetPhoneme(3, Female, 0, 25)
	Base.SetPhoneme(3, Female, 6, 25)

	Base.SetPhoneme(4, Female, 1, 100)
	Base.SetPhoneme(4, Female, 0, 50)
	Base.SetPhoneme(4, Female, 6, 50)

	; Male

	Base.SetPhoneme(3, Male, 1, 100)

	Base.SetPhoneme(4, Male, 1, 50)
	Base.SetPhoneme(4, Male, 6, 25)


	Base.Save(id)
	Base.Enabled   = false
endFunction

function AhegaoPained(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Ahegao Pained"
	Base.SetTags("Victim,Afraid,Pain,Pained,Negative,NoBeast,Ahegao")

	; Male + Female
	Base.SetMood(1, MaleFemale, 3, 100)
	Base.SetModifier(1, MaleFemale, 2, 10)
	Base.SetModifier(1, MaleFemale, 3, 10)
	Base.SetModifier(1, MaleFemale, 6, 50)
	Base.SetModifier(1, MaleFemale, 7, 50)
	Base.SetModifier(1, MaleFemale, 1, 30)
	Base.SetModifier(1, MaleFemale, 12, 30)
	Base.SetModifier(1, MaleFemale, 13, 30)
	Base.SetLipFixedPhase(1, MaleFemale, 1)
	Base.SetEquipmentPhase(1, MaleFemale, Slots.Config.GetFaceItem(6))

	Base.SetMood(2, MaleFemale, 3, 100)
	Base.SetModifier(2, MaleFemale, 11, 50)
	Base.SetModifier(2, MaleFemale, 13, 40)
	Base.SetPhoneme(2, MaleFemale, 2, 50)
	Base.SetPhoneme(2, MaleFemale, 13, 20)
	Base.SetPhoneme(2, MaleFemale, 15, 40)
	Base.SetLipFixedPhase(2, MaleFemale, 1)

	Base.SetMood(3, MaleFemale, 8, 100)
	Base.SetModifier(3, MaleFemale, 0, 100)
	Base.SetModifier(3, MaleFemale, 1, 100)
	Base.SetModifier(3, MaleFemale, 2, 100)
	Base.SetModifier(3, MaleFemale, 3, 100)
	Base.SetModifier(3, MaleFemale, 4, 100)
	Base.SetModifier(3, MaleFemale, 5, 100)
	Base.SetPhoneme(3, MaleFemale, 2, 100)
	Base.SetPhoneme(3, MaleFemale, 5, 40)
	Base.SetModifier(3, MaleFemale, 9, 60)
	Base.SetModifier(3, MaleFemale, 11, 80)

	Base.SetMood(4, MaleFemale, 9, 100)
	Base.SetModifier(4, MaleFemale, 2, 100)
	Base.SetModifier(4, MaleFemale, 3, 100)
	Base.SetModifier(4, MaleFemale, 4, 100)
	Base.SetModifier(4, MaleFemale, 5, 100)
	Base.SetModifier(4, MaleFemale, 11, 90)
	Base.SetPhoneme(4, MaleFemale, 2, 30)
	Base.SetLipFixedPhase(4, MaleFemale, 1)
	Base.SetEquipmentPhase(4, MaleFemale, Slots.Config.GetFaceItem(1))
	Base.SetModifier(4, MaleFemale, 9, 40)
	Base.SetModifier(4, MaleFemale, 11, 100)

	; Female
	Base.SetPhoneme(1, Female, 1, 80)
	Base.SetPhoneme(1, Female, 0, 40)
	Base.SetPhoneme(1, Female, 6, 40)

	Base.SetEquipmentPhase(2, Female, Slots.Config.GetFaceItem(2))
	Base.SetPhoneme(2, Female, 1, 100)
	Base.SetPhoneme(2, Female, 0, 50)
	Base.SetPhoneme(2, Female, 6, 50)

	Base.SetPhoneme(4, Female, 1, 100)
	Base.SetPhoneme(4, Female, 0, 50)
	Base.SetPhoneme(4, Female, 6, 50)

	; Male
	Base.SetPhoneme(1, Male, 1, 30)
	Base.SetPhoneme(1, Male, 0, 15)
	Base.SetPhoneme(1, Male, 6, 15)

	Base.SetEquipmentPhase(2, Male, Slots.Config.GetFaceItem(8))
	Base.SetPhoneme(2, Male, 1, 100)

	Base.SetPhoneme(4, Male, 1, 50)
	Base.SetPhoneme(4, Male, 6, 25)

	Base.Save(id)
	Base.Enabled   = false
endFunction

function AhegaoAngry(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Ahegao Angry"
	Base.SetTags("Aggressor,Victim,Mad,Angry,Upset,NoBeast,Ahegao")

	; Male + Female
	Base.SetMood(1, MaleFemale, 8, 40)
	Base.SetModifier(1, MaleFemale, 12, 30)
	Base.SetModifier(1, MaleFemale, 13, 30)
	Base.SetPhoneme(1, MaleFemale, 4, 40)

	Base.SetMood(2, MaleFemale, 8, 55)
	Base.SetModifier(2, MaleFemale, 12, 50)
	Base.SetModifier(2, MaleFemale, 13, 50)
	Base.SetPhoneme(2, MaleFemale, 4, 40)
	Base.SetLipFixedPhase(2, MaleFemale, 1)

	Base.SetMood(3, MaleFemale, 8, 100)
	Base.SetModifier(3, MaleFemale, 12, 65)
	Base.SetModifier(3, MaleFemale, 13, 65)
	Base.SetPhoneme(3, MaleFemale, 4, 50)
	Base.SetPhoneme(3, MaleFemale, 3, 40)
	Base.SetLipFixedPhase(3, MaleFemale, 1)
	Base.SetEquipmentPhase(3, MaleFemale, Slots.Config.GetFaceItem(1))
	Base.SetModifier(3, MaleFemale, 11, 10)

	; Female
	Base.SetEquipmentPhase(2, Female, Slots.Config.GetFaceItem(2))
	Base.SetPhoneme(2, Female, 1, 100)
	Base.SetPhoneme(2, Female, 0, 50)
	Base.SetPhoneme(2, Female, 6, 50)

	Base.SetPhoneme(3, Female, 1, 100)
	Base.SetPhoneme(3, Female, 0, 50)
	Base.SetPhoneme(3, Female, 6, 50)

	; Male
	Base.SetEquipmentPhase(2, Male, Slots.Config.GetFaceItem(8))
	Base.SetPhoneme(2, Male, 1, 100)

	Base.SetPhoneme(3, Male, 1, 50)
	Base.SetPhoneme(3, Male, 6, 25)

	Base.Save(id)
	Base.Enabled   = false
endFunction

function AhegaoHappy(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Ahegao Happy"
	Base.SetTags("Normal,Happy,Consensual,NoBeast,Ahegao")

	; Male + Female
	Base.SetMood(1, MaleFemale, 2, 50)
	Base.SetModifier(1, MaleFemale, 12, 50)
	Base.SetModifier(1, MaleFemale, 13, 50)
	Base.SetPhoneme(1, MaleFemale, 5, 50)

	Base.SetMood(2, MaleFemale, 2, 70)
	Base.SetModifier(2, MaleFemale, 12, 70)
	Base.SetModifier(2, MaleFemale, 13, 70)
	Base.SetPhoneme(2, MaleFemale, 5, 50)
	Base.SetPhoneme(2, MaleFemale, 8, 50)

	Base.SetMood(3, MaleFemale, 2, 80)
	Base.SetModifier(3, MaleFemale, 12, 80)
	Base.SetModifier(3, MaleFemale, 13, 80)
	Base.SetPhoneme(3, MaleFemale, 5, 50)
	Base.SetPhoneme(3, MaleFemale, 11, 60)
	Base.SetLipFixedPhase(3, MaleFemale, 1)
	Base.SetEquipmentPhase(3, MaleFemale, Slots.Config.GetFaceItem(7))
	Base.SetModifier(3, MaleFemale, 11, 80)

	; Female
	Base.SetPhoneme(3, Female, 1, 50)
	Base.SetPhoneme(3, Female, 0, 25)
	Base.SetPhoneme(3, Female, 6, 25)

	; Male
	Base.SetPhoneme(3, Male, 1, 100)


	Base.Save(id)
	Base.Enabled   = false
endFunction

function AhegaoSad(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Ahegao Sad"
	Base.SetTags("Normal,Victim,Sad,NoBeast,Ahegao")

	; Male + Female
	Base.SetMood(1, MaleFemale, 2, 50)
	Base.SetModifier(1, MaleFemale, 12, 50)
	Base.SetModifier(1, MaleFemale, 13, 50)
	Base.SetPhoneme(1, MaleFemale, 5, 50)

	Base.SetMood(2, MaleFemale, 2, 70)
	Base.SetModifier(2, MaleFemale, 12, 70)
	Base.SetModifier(2, MaleFemale, 13, 70)
	Base.SetPhoneme(2, MaleFemale, 5, 50)
	Base.SetPhoneme(2, MaleFemale, 8, 50)

	Base.SetMood(3, MaleFemale, 2, 80)
	Base.SetModifier(3, MaleFemale, 12, 80)
	Base.SetModifier(3, MaleFemale, 13, 80)
	Base.SetPhoneme(3, MaleFemale, 5, 50)
	Base.SetPhoneme(3, MaleFemale, 11, 60)
	Base.SetLipFixedPhase(3, MaleFemale, 1)
	Base.SetEquipmentPhase(3, MaleFemale, Slots.Config.GetFaceItem(1))
	Base.SetModifier(3, MaleFemale, 9, 40)
	Base.SetModifier(3, MaleFemale, 11, 100)

	; Female
	Base.SetPhoneme(3, Female, 1, 100)
	Base.SetPhoneme(3, Female, 0, 50)
	Base.SetPhoneme(3, Female, 6, 50)

	; Male
	Base.SetPhoneme(3, Male, 1, 50)
	Base.SetPhoneme(3, Male, 6, 25)

	Base.Save(id)
	Base.Enabled   = false
endFunction

function AhegaoJoy(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Ahegao Joy"
	Base.SetTags("Normal,Happy,Joy,Pleasure,Consensual,NoBeast,Ahegao")

	; Female
	Base.SetMood(1, Female, 10, 45)
	Base.SetPhoneme(1, Female, 0, 30)
	Base.SetPhoneme(1, Female, 7, 60)
	Base.SetPhoneme(1, Female, 12, 60)
	Base.SetModifier(1, Female, 0, 30)
	Base.SetModifier(1, Female, 1, 30)
	Base.SetModifier(1, Female, 4, 100)
	Base.SetModifier(1, Female, 5, 100)
	Base.SetModifier(1, Female, 12, 70)
	Base.SetModifier(1, Female, 13, 70)

	Base.SetMood(2, Female, 10, 60)
	Base.SetPhoneme(2, Female, 7, 100)
	Base.SetPhoneme(2, Female, 15, 50)
	Base.SetModifier(2, Female, 0, 30)
	Base.SetModifier(2, Female, 1, 30)
	Base.SetModifier(2, Female, 4, 100)
	Base.SetModifier(2, Female, 5, 100)
	Base.SetModifier(2, Female, 12, 70)
	Base.SetModifier(2, Female, 13, 70)
	Base.SetLipFixedPhase(2, Female, 1)
	Base.SetEquipmentPhase(2, Female, Slots.Config.GetFaceItem(6))
	Base.SetPhoneme(2, Female, 1, 80)
	Base.SetPhoneme(2, Female, 0, 40)
	Base.SetPhoneme(2, Female, 6, 40)

	Base.SetMood(3, Female, 10, 60)
	Base.SetPhoneme(3, Female, 7, 50)
	Base.SetPhoneme(3, Female, 15, 50)
	Base.SetModifier(3, Female, 0, 30)
	Base.SetModifier(3, Female, 1, 30)
	Base.SetModifier(3, Female, 4, 100)
	Base.SetModifier(3, Female, 5, 100)
	Base.SetModifier(3, Female, 12, 70)
	Base.SetModifier(3, Female, 13, 70)
	Base.SetLipFixedPhase(3, Female, 1)
	Base.SetEquipmentPhase(3, Female, Slots.Config.GetFaceItem(9))
	Base.SetPhoneme(3, Female, 1, 75)
	Base.SetPhoneme(3, Female, 0, 25)
	Base.SetPhoneme(3, Female, 6, 25)
	Base.SetModifier(3, Female, 8, 20)
	Base.SetModifier(3, Female, 10, 10)

	Base.SetMood(4, Female, 10, 45)
	Base.SetPhoneme(4, Female, 7, 50)
	Base.SetModifier(4, Female, 0, 30)
	Base.SetModifier(4, Female, 1, 30)
	Base.SetModifier(4, Female, 2, 70)
	Base.SetModifier(4, Female, 3, 70)
	Base.SetModifier(4, Female, 4, 100)
	Base.SetModifier(4, Female, 5, 100)
	Base.SetModifier(4, Female, 12, 70)
	Base.SetModifier(4, Female, 13, 70)
	Base.SetLipFixedPhase(4, Female, 1)
	Base.SetEquipmentPhase(4, Female, Slots.Config.GetFaceItem(10))
	Base.SetPhoneme(4, Female, 1, 75)
	Base.SetPhoneme(4, Female, 0, 25)
	Base.SetPhoneme(4, Female, 6, 25)
	Base.SetModifier(4, Female, 8, 20)
	Base.SetModifier(4, Female, 10, 10)

	Base.SetMood(5, Female, 10, 60)
	Base.SetPhoneme(5, Female, 7, 50)
	Base.SetModifier(5, Female, 0, 30)
	Base.SetModifier(5, Female, 1, 30)
	Base.SetModifier(5, Female, 2, 70)
	Base.SetModifier(5, Female, 3, 70)
	Base.SetModifier(5, Female, 4, 100)
	Base.SetModifier(5, Female, 5, 100)
	Base.SetModifier(5, Female, 12, 70)
	Base.SetModifier(5, Female, 13, 70)
	Base.SetLipFixedPhase(5, Female, 1)
	Base.SetEquipmentPhase(5, Female, Slots.Config.GetFaceItem(2))
	Base.SetPhoneme(5, Female, 1, 100)
	Base.SetPhoneme(5, Female, 0, 50)
	Base.SetPhoneme(5, Female, 6, 50)
	Base.SetModifier(5, Female, 11, 100)

	; Male (copy of pleasure)
	Base.SetMood(1, Male, 13, 40)
	Base.SetModifier(1, Male, 6, 20)
	Base.SetModifier(1, Male, 7, 20)
	Base.SetPhoneme(1, Male, 5, 20)

	Base.SetMood(2, Male, 8, 40)
	Base.SetModifier(2, Male, 12, 40)
	Base.SetModifier(2, Male, 13, 40)
	Base.SetPhoneme(2, Male, 2, 50)
	Base.SetPhoneme(2, Male, 13, 20)
	Base.SetLipFixedPhase(2, Male, 1)
	Base.SetEquipmentPhase(2, Male, Slots.Config.GetFaceItem(3))
	Base.SetPhoneme(2, Male, 1, 100)
	Base.SetModifier(2, Male, 8, 20)
	Base.SetModifier(2, Male, 10, 10)

	Base.SetMood(3, Male, 13, 80)
	Base.SetModifier(3, Male, 6, 80)
	Base.SetModifier(3, Male, 7, 80)
	Base.SetModifier(3, Male, 12, 30)
	Base.SetModifier(3, Male, 13, 30)
	Base.SetPhoneme(3, Male, 0, 30)
	Base.SetLipFixedPhase(3, Male, 1)
	Base.SetEquipmentPhase(3, Male, Slots.Config.GetFaceItem(2))
	Base.SetPhoneme(3, Male, 1, 50)
	Base.SetPhoneme(3, Male, 6, 25)
	Base.SetModifier(3, Male, 11, 90)

	Base.Save(id)
	Base.Enabled   = false
endFunction

function AhegaoBeastPleasure(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Ahegao Beast Pleasure"
	Base.SetTags("Normal,Happy,Consensual,Pleasure,BeastOnly,Ahegao")

	; Female
	Base.SetMood(1, Female, 2, 30)
	Base.SetPhoneme(1, Female, 5, 30)
	Base.SetLipFixedPhase(1, Female, 1)
	Base.SetEquipmentPhase(1, Female, Slots.Config.GetFaceItem(5))
	Base.SetPhoneme(1, Female, 1, 100)
	Base.SetPhoneme(1, Female, 0, 50)
	Base.SetPhoneme(1, Female, 6, 50)
	Base.SetModifier(1, Female, 11, 20)

	Base.SetMood(2, Female, 10, 50)
	Base.SetModifier(2, Female, 4, 30)
	Base.SetModifier(2, Female, 5, 30)
	Base.SetModifier(2, Female, 6, 20)
	Base.SetModifier(2, Female, 7, 20)
	Base.SetPhoneme(2, Female, 3, 30)
	Base.SetLipFixedPhase(2, Female, 1)
	Base.SetEquipmentPhase(2, Female, Slots.Config.GetFaceItem(3))
	Base.SetPhoneme(2, Female, 1, 50)
	Base.SetPhoneme(2, Female, 0, 25)
	Base.SetPhoneme(2, Female, 6, 25)
	Base.SetModifier(2, Female, 11, 40)

	Base.SetMood(3, Female, 10, 70)
	Base.SetModifier(3, Female, 2, 50)
	Base.SetModifier(3, Female, 3, 50)
	Base.SetModifier(3, Female, 4, 30)
	Base.SetModifier(3, Female, 5, 30)
	Base.SetModifier(3, Female, 6, 70)
	Base.SetModifier(3, Female, 7, 40)
	Base.SetPhoneme(3, Female, 12, 30)
	Base.SetPhoneme(3, Female, 13, 10)
	Base.SetLipFixedPhase(3, Female, 1)
	Base.SetEquipmentPhase(3, Female, Slots.Config.GetFaceItem(10))
	Base.SetPhoneme(3, Female, 1, 50)
	Base.SetPhoneme(3, Female, 0, 25)
	Base.SetPhoneme(3, Female, 6, 25)
	Base.SetModifier(3, Female, 11, 60)

	Base.SetMood(4, Female, 10, 100)
	Base.SetModifier(4, Female, 0, 10)
	Base.SetModifier(4, Female, 1, 10)
	Base.SetModifier(4, Female, 2, 25)
	Base.SetModifier(4, Female, 3, 25)
	Base.SetModifier(4, Female, 6, 100)
	Base.SetModifier(4, Female, 7, 100)
	Base.SetModifier(4, Female, 12, 30)
	Base.SetModifier(4, Female, 13, 30)
	Base.SetPhoneme(4, Female, 4, 35)
	Base.SetPhoneme(4, Female, 10, 20)
	Base.SetPhoneme(4, Female, 12, 30)
	Base.SetLipFixedPhase(4, Female, 1)
	Base.SetEquipmentPhase(4, Female, Slots.Config.GetFaceItem(4))
	Base.SetPhoneme(4, Female, 1, 100)
	Base.SetPhoneme(4, Female, 0, 50)
	Base.SetPhoneme(4, Female, 6, 50)
	Base.SetModifier(4, Female, 11, 100)

	Base.SetMood(5, Female, 12, 60)
	Base.SetModifier(5, Female, 0, 15)
	Base.SetModifier(5, Female, 1, 15)
	Base.SetModifier(5, Female, 2, 25)
	Base.SetModifier(5, Female, 3, 25)
	Base.SetModifier(5, Female, 4, 60)
	Base.SetModifier(5, Female, 5, 60)
	Base.SetModifier(5, Female, 12, 70)
	Base.SetModifier(5, Female, 13, 30)
	Base.SetPhoneme(5, Female, 5, 20)
	Base.SetPhoneme(5, Female, 12, 80)
	Base.SetPhoneme(5, Female, 15, 20)
	Base.SetLipFixedPhase(5, Female, 1)
	Base.SetEquipmentPhase(5, Female, Slots.Config.GetFaceItem(7))
	Base.SetPhoneme(5, Female, 1, 50)
	Base.SetPhoneme(5, Female, 0, 25)
	Base.SetPhoneme(5, Female, 6, 25)
	Base.SetModifier(5, Female, 11, 100)

	; Male
	Base.SetMood(1, Male, 13, 40)
	Base.SetModifier(1, Male, 6, 20)
	Base.SetModifier(1, Male, 7, 20)
	Base.SetPhoneme(1, Male, 5, 20)
	Base.SetLipFixedPhase(1, Male, 1)
	Base.SetEquipmentPhase(1, Male, Slots.Config.GetFaceItem(3))
	Base.SetPhoneme(1, Male, 1, 50)
	Base.SetPhoneme(1, Male, 0, 25)
	Base.SetPhoneme(1, Male, 6, 25)
	Base.SetModifier(1, Male, 11, 20)

	Base.SetMood(2, Male, 8, 40)
	Base.SetModifier(2, Male, 12, 40)
	Base.SetModifier(2, Male, 13, 40)
	Base.SetPhoneme(2, Male, 2, 50)
	Base.SetPhoneme(2, Male, 13, 20)
	Base.SetLipFixedPhase(2, Male, 1)
	Base.SetEquipmentPhase(2, Male, Slots.Config.GetFaceItem(10))
	Base.SetPhoneme(2, Male, 1, 50)
	Base.SetPhoneme(2, Male, 0, 25)
	Base.SetPhoneme(2, Male, 6, 25)
	Base.SetModifier(2, Male, 11, 40)

	Base.SetMood(3, Male, 13, 80)
	Base.SetModifier(3, Male, 6, 80)
	Base.SetModifier(3, Male, 7, 80)
	Base.SetModifier(3, Male, 12, 30)
	Base.SetModifier(3, Male, 13, 30)
	Base.SetLipFixedPhase(3, Male, 1)
	Base.SetEquipmentPhase(3, Male, Slots.Config.GetFaceItem(7))
	Base.SetPhoneme(3, Male, 1, 50)
	Base.SetPhoneme(3, Male, 0, 25)
	Base.SetPhoneme(3, Male, 6, 25)
	Base.SetModifier(3, Male, 11, 80)

	Base.Save(id)
	Base.Enabled   = false
endFunction

function AhegaoBeastShy(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Ahegao Beast Shy"
	Base.SetTags("Normal,Consensual,Nervous,Sad,Shy,BeastOnly,Ahegao")

	; Male + Female
	Base.SetMood(1, MaleFemale, 4, 90)
	Base.SetModifier(1, MaleFemale, 11, 20)
	Base.SetPhoneme(1, MaleFemale, 1, 10)
	Base.SetPhoneme(1, MaleFemale, 11, 10)

	Base.SetMood(2, MaleFemale, 3, 50)
	Base.SetModifier(2, MaleFemale, 8, 50)
	Base.SetModifier(2, MaleFemale, 9, 40)
	Base.SetModifier(2, MaleFemale, 12, 30)

	Base.SetMood(3, MaleFemale, 3, 50)
	Base.SetModifier(3, MaleFemale, 8, 50)
	Base.SetModifier(3, MaleFemale, 9, 40)
	Base.SetModifier(3, MaleFemale, 12, 30)
	Base.SetPhoneme(3, MaleFemale, 1, 10)
	Base.SetPhoneme(3, MaleFemale, 11, 10)
	Base.SetLipFixedPhase(3, MaleFemale, 1)
	Base.SetEquipmentPhase(3, MaleFemale, Slots.Config.GetFaceItem(6))
	Base.SetPhoneme(3, MaleFemale, 1, 80)
	Base.SetPhoneme(3, MaleFemale, 0, 40)
	Base.SetPhoneme(3, MaleFemale, 6, 40)

	Base.Save(id)
	Base.Enabled   = false
endFunction

function AhegaoBeastAfraid(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Ahegao Beast Afraid"
	Base.SetTags("Aggressor,Afraid,Scared,Pain,Negative,BeastOnly,Ahegao")

	; Male + Female
	Base.SetMood(1, MaleFemale, 3, 100)
	Base.SetModifier(1, MaleFemale, 2, 10)
	Base.SetModifier(1, MaleFemale, 3, 10)
	Base.SetModifier(1, MaleFemale, 6, 50)
	Base.SetModifier(1, MaleFemale, 7, 50)
	Base.SetModifier(1, MaleFemale, 1, 30)
	Base.SetModifier(1, MaleFemale, 12, 30)
	Base.SetModifier(1, MaleFemale, 13, 30)
	Base.SetPhoneme(1, MaleFemale, 0, 20)

	Base.SetMood(2, MaleFemale, 8, 100)
	Base.SetModifier(2, MaleFemale, 0, 100)
	Base.SetModifier(2, MaleFemale, 1, 100)
	Base.SetModifier(2, MaleFemale, 2, 100)
	Base.SetModifier(2, MaleFemale, 3, 100)
	Base.SetModifier(2, MaleFemale, 4, 100)
	Base.SetModifier(2, MaleFemale, 5, 100)
	Base.SetPhoneme(2, MaleFemale, 2, 100)
	Base.SetPhoneme(2, MaleFemale, 2, 100)
	Base.SetPhoneme(2, MaleFemale, 5, 40)

	Base.SetMood(3, MaleFemale, 3, 100)
	Base.SetModifier(3, MaleFemale, 11, 50)
	Base.SetModifier(3, MaleFemale, 13, 40)
	Base.SetPhoneme(3, MaleFemale, 2, 50)
	Base.SetPhoneme(3, MaleFemale, 13, 20)
	Base.SetPhoneme(3, MaleFemale, 15, 40)
	Base.SetLipFixedPhase(3, MaleFemale, 1)
	Base.SetEquipmentPhase(3, MaleFemale, Slots.Config.GetFaceItem(8))
	Base.SetPhoneme(3, MaleFemale, 1, 50)
	Base.SetPhoneme(3, MaleFemale, 0, 25)
	Base.SetPhoneme(3, MaleFemale, 6, 25)

	Base.SetMood(4, MaleFemale, 9, 100)
	Base.SetModifier(4, MaleFemale, 2, 100)
	Base.SetModifier(4, MaleFemale, 3, 100)
	Base.SetModifier(4, MaleFemale, 4, 100)
	Base.SetModifier(4, MaleFemale, 5, 100)
	Base.SetPhoneme(4, MaleFemale, 2, 30)
	Base.SetLipFixedPhase(4, MaleFemale, 1)
	Base.SetEquipmentPhase(4, MaleFemale, Slots.Config.GetFaceItem(5))
	Base.SetPhoneme(4, MaleFemale, 1, 60)
	Base.SetPhoneme(4, MaleFemale, 0, 50)
	Base.SetPhoneme(4, MaleFemale, 6, 50)
	Base.SetModifier(4, MaleFemale, 11, 90)

	Base.Save(id)
	Base.Enabled   = false
endFunction

function AhegaoBeastPained(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Ahegao Beast Pained"
	Base.SetTags("Victim,Afraid,Pain,Pained,Negative,BeastOnly,Ahegao")

	; Male + Female
	Base.SetMood(1, MaleFemale, 3, 100)
	Base.SetModifier(1, MaleFemale, 2, 10)
	Base.SetModifier(1, MaleFemale, 3, 10)
	Base.SetModifier(1, MaleFemale, 6, 50)
	Base.SetModifier(1, MaleFemale, 7, 50)
	Base.SetModifier(1, MaleFemale, 1, 30)
	Base.SetModifier(1, MaleFemale, 12, 30)
	Base.SetModifier(1, MaleFemale, 13, 30)
	Base.SetLipFixedPhase(1, MaleFemale, 1)
	Base.SetEquipmentPhase(1, MaleFemale, Slots.Config.GetFaceItem(6))

	Base.SetMood(2, MaleFemale, 3, 100)
	Base.SetModifier(2, MaleFemale, 11, 50)
	Base.SetModifier(2, MaleFemale, 13, 40)
	Base.SetPhoneme(2, MaleFemale, 2, 50)
	Base.SetPhoneme(2, MaleFemale, 13, 20)
	Base.SetPhoneme(2, MaleFemale, 15, 40)
	Base.SetLipFixedPhase(2, MaleFemale, 1)

	Base.SetMood(3, MaleFemale, 8, 100)
	Base.SetModifier(3, MaleFemale, 0, 100)
	Base.SetModifier(3, MaleFemale, 1, 100)
	Base.SetModifier(3, MaleFemale, 2, 100)
	Base.SetModifier(3, MaleFemale, 3, 100)
	Base.SetModifier(3, MaleFemale, 4, 100)
	Base.SetModifier(3, MaleFemale, 5, 100)
	Base.SetPhoneme(3, MaleFemale, 2, 100)
	Base.SetPhoneme(3, MaleFemale, 5, 40)
	Base.SetModifier(3, MaleFemale, 9, 60)
	Base.SetModifier(3, MaleFemale, 11, 80)

	Base.SetMood(4, MaleFemale, 9, 100)
	Base.SetModifier(4, MaleFemale, 2, 100)
	Base.SetModifier(4, MaleFemale, 3, 100)
	Base.SetModifier(4, MaleFemale, 4, 100)
	Base.SetModifier(4, MaleFemale, 5, 100)
	Base.SetModifier(4, MaleFemale, 11, 90)
	Base.SetPhoneme(4, MaleFemale, 2, 30)
	Base.SetLipFixedPhase(4, MaleFemale, 1)
	Base.SetEquipmentPhase(4, MaleFemale, Slots.Config.GetFaceItem(1))
	Base.SetModifier(4, MaleFemale, 9, 40)
	Base.SetModifier(4, MaleFemale, 11, 100)

	; Female
	Base.SetPhoneme(1, Female, 1, 80)
	Base.SetPhoneme(1, Female, 0, 40)
	Base.SetPhoneme(1, Female, 6, 40)

	Base.SetEquipmentPhase(2, Female, Slots.Config.GetFaceItem(2))
	Base.SetPhoneme(2, Female, 1, 60)
	Base.SetPhoneme(2, Female, 0, 50)
	Base.SetPhoneme(2, Female, 6, 50)

	Base.SetPhoneme(4, Female, 1, 100)
	Base.SetPhoneme(4, Female, 0, 50)
	Base.SetPhoneme(4, Female, 6, 50)

	; Male
	Base.SetPhoneme(1, Male, 1, 30)
	Base.SetPhoneme(1, Male, 0, 15)
	Base.SetPhoneme(1, Male, 6, 15)

	Base.SetEquipmentPhase(2, Male, Slots.Config.GetFaceItem(8))
	Base.SetPhoneme(2, Male, 1, 60)

	Base.SetPhoneme(4, Male, 1, 50)
	Base.SetPhoneme(4, Male, 6, 25)

	Base.Save(id)
	Base.Enabled   = false
endFunction

function AhegaoBeastAngry(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Ahegao Beast Angry"
	Base.SetTags("Aggressor,Victim,Mad,Angry,Upset,BeastOnly,Ahegao")

	; Male + Female
	Base.SetMood(1, MaleFemale, 8, 40)
	Base.SetModifier(1, MaleFemale, 12, 30)
	Base.SetModifier(1, MaleFemale, 13, 30)
	Base.SetPhoneme(1, MaleFemale, 4, 40)

	Base.SetMood(2, MaleFemale, 8, 55)
	Base.SetModifier(2, MaleFemale, 12, 50)
	Base.SetModifier(2, MaleFemale, 13, 50)
	Base.SetPhoneme(2, MaleFemale, 4, 40)
	Base.SetLipFixedPhase(2, MaleFemale, 1)

	Base.SetMood(3, MaleFemale, 8, 100)
	Base.SetModifier(3, MaleFemale, 12, 65)
	Base.SetModifier(3, MaleFemale, 13, 65)
	Base.SetPhoneme(3, MaleFemale, 4, 50)
	Base.SetPhoneme(3, MaleFemale, 3, 40)
	Base.SetLipFixedPhase(3, MaleFemale, 1)
	Base.SetEquipmentPhase(3, MaleFemale, Slots.Config.GetFaceItem(1))
	Base.SetPhoneme(3, MaleFemale, 1, 60)
	Base.SetPhoneme(3, MaleFemale, 0, 50)
	Base.SetPhoneme(3, MaleFemale, 6, 50)
	Base.SetModifier(3, MaleFemale, 11, 10)

	; Female
	Base.SetEquipmentPhase(2, Female, Slots.Config.GetFaceItem(2))
	Base.SetPhoneme(2, Female, 1, 60)
	Base.SetPhoneme(2, Female, 0, 50)
	Base.SetPhoneme(2, Female, 6, 50)


	; Male
	Base.SetEquipmentPhase(2, Male, Slots.Config.GetFaceItem(8))
	Base.SetPhoneme(2, Male, 1, 50)
	Base.SetPhoneme(2, Male, 0, 25)
	Base.SetPhoneme(2, Male, 6, 25)

	Base.Save(id)
	Base.Enabled   = false
endFunction

function AhegaoBeastHappy(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Ahegao Beast Happy"
	Base.SetTags("Normal,Happy,Consensual,BeastOnly,Ahegao")

	; Male + Female
	Base.SetMood(1, MaleFemale, 2, 50)
	Base.SetModifier(1, MaleFemale, 12, 50)
	Base.SetModifier(1, MaleFemale, 13, 50)
	Base.SetPhoneme(1, MaleFemale, 5, 50)

	Base.SetMood(2, MaleFemale, 2, 70)
	Base.SetModifier(2, MaleFemale, 12, 70)
	Base.SetModifier(2, MaleFemale, 13, 70)
	Base.SetPhoneme(2, MaleFemale, 5, 50)
	Base.SetPhoneme(2, MaleFemale, 8, 50)

	Base.SetMood(3, MaleFemale, 2, 80)
	Base.SetModifier(3, MaleFemale, 12, 80)
	Base.SetModifier(3, MaleFemale, 13, 80)
	Base.SetPhoneme(3, MaleFemale, 5, 50)
	Base.SetPhoneme(3, MaleFemale, 11, 60)
	Base.SetLipFixedPhase(3, MaleFemale, 1)
	Base.SetEquipmentPhase(3, MaleFemale, Slots.Config.GetFaceItem(7))
	Base.SetPhoneme(3, MaleFemale, 1, 50)
	Base.SetPhoneme(3, MaleFemale, 0, 25)
	Base.SetPhoneme(3, MaleFemale, 6, 25)
	Base.SetModifier(3, MaleFemale, 11, 80)

	Base.Save(id)
	Base.Enabled   = false
endFunction

function AhegaoBeastSad(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Ahegao Beast Sad"
	Base.SetTags("Normal,Victim,Sad,BeastOnly,Ahegao")

	; Male + Female
	Base.SetMood(1, MaleFemale, 2, 50)
	Base.SetModifier(1, MaleFemale, 12, 50)
	Base.SetModifier(1, MaleFemale, 13, 50)
	Base.SetPhoneme(1, MaleFemale, 5, 50)

	Base.SetMood(2, MaleFemale, 2, 70)
	Base.SetModifier(2, MaleFemale, 12, 70)
	Base.SetModifier(2, MaleFemale, 13, 70)
	Base.SetPhoneme(2, MaleFemale, 5, 50)
	Base.SetPhoneme(2, MaleFemale, 8, 50)

	Base.SetMood(3, MaleFemale, 2, 80)
	Base.SetModifier(3, MaleFemale, 12, 80)
	Base.SetModifier(3, MaleFemale, 13, 80)
	Base.SetPhoneme(3, MaleFemale, 5, 50)
	Base.SetPhoneme(3, MaleFemale, 11, 60)
	Base.SetLipFixedPhase(3, MaleFemale, 1)
	Base.SetEquipmentPhase(3, MaleFemale, Slots.Config.GetFaceItem(1))
	Base.SetPhoneme(3, MaleFemale, 1, 50)
	Base.SetPhoneme(3, MaleFemale, 0, 50)
	Base.SetPhoneme(3, MaleFemale, 6, 50)
	Base.SetModifier(3, MaleFemale, 9, 40)
	Base.SetModifier(3, MaleFemale, 11, 100)

	Base.Save(id)
	Base.Enabled   = false
endFunction

function AhegaoBeastJoy(int id)
	sslBaseExpression Base = Create(id)

	Base.Name = "Ahegao Beast Joy"
	Base.SetTags("Normal,Happy,Joy,Pleasure,Consensual,BeastOnly,Ahegao")

	; Female
	Base.SetMood(1, Female, 10, 45)
	Base.SetPhoneme(1, Female, 0, 30)
	Base.SetPhoneme(1, Female, 7, 60)
	Base.SetPhoneme(1, Female, 12, 60)
	Base.SetModifier(1, Female, 0, 30)
	Base.SetModifier(1, Female, 1, 30)
	Base.SetModifier(1, Female, 4, 100)
	Base.SetModifier(1, Female, 5, 100)
	Base.SetModifier(1, Female, 12, 70)
	Base.SetModifier(1, Female, 13, 70)

	Base.SetMood(2, Female, 10, 60)
	Base.SetPhoneme(2, Female, 7, 50)
	Base.SetPhoneme(2, Female, 15, 50)
	Base.SetModifier(2, Female, 0, 30)
	Base.SetModifier(2, Female, 1, 30)
	Base.SetModifier(2, Female, 4, 100)
	Base.SetModifier(2, Female, 5, 100)
	Base.SetModifier(2, Female, 12, 70)
	Base.SetModifier(2, Female, 13, 70)
	Base.SetLipFixedPhase(2, Female, 1)
	Base.SetEquipmentPhase(2, Female, Slots.Config.GetFaceItem(6))
	Base.SetPhoneme(2, Female, 1, 80)
	Base.SetPhoneme(2, Female, 0, 40)
	Base.SetPhoneme(2, Female, 6, 40)

	Base.SetMood(3, Female, 10, 60)
	Base.SetPhoneme(3, Female, 7, 50)
	Base.SetPhoneme(3, Female, 15, 50)
	Base.SetModifier(3, Female, 0, 30)
	Base.SetModifier(3, Female, 1, 30)
	Base.SetModifier(3, Female, 4, 100)
	Base.SetModifier(3, Female, 5, 100)
	Base.SetModifier(3, Female, 12, 70)
	Base.SetModifier(3, Female, 13, 70)
	Base.SetLipFixedPhase(3, Female, 1)
	Base.SetEquipmentPhase(3, Female, Slots.Config.GetFaceItem(9))
	Base.SetPhoneme(3, Female, 1, 75)
	Base.SetPhoneme(3, Female, 0, 25)
	Base.SetPhoneme(3, Female, 6, 25)
	Base.SetModifier(3, Female, 8, 20)
	Base.SetModifier(3, Female, 10, 10)

	Base.SetMood(4, Female, 10, 45)
	Base.SetPhoneme(4, Female, 7, 50)
	Base.SetModifier(4, Female, 0, 30)
	Base.SetModifier(4, Female, 1, 30)
	Base.SetModifier(4, Female, 2, 70)
	Base.SetModifier(4, Female, 3, 70)
	Base.SetModifier(4, Female, 4, 100)
	Base.SetModifier(4, Female, 5, 100)
	Base.SetModifier(4, Female, 12, 70)
	Base.SetModifier(4, Female, 13, 70)
	Base.SetLipFixedPhase(4, Female, 1)
	Base.SetEquipmentPhase(4, Female, Slots.Config.GetFaceItem(10))
	Base.SetPhoneme(4, Female, 1, 50)
	Base.SetPhoneme(4, Female, 0, 25)
	Base.SetPhoneme(4, Female, 6, 25)
	Base.SetModifier(4, Female, 8, 20)
	Base.SetModifier(4, Female, 10, 10)

	Base.SetMood(5, Female, 10, 60)
	Base.SetPhoneme(5, Female, 7, 50)
	Base.SetModifier(5, Female, 0, 30)
	Base.SetModifier(5, Female, 1, 30)
	Base.SetModifier(5, Female, 2, 70)
	Base.SetModifier(5, Female, 3, 70)
	Base.SetModifier(5, Female, 4, 100)
	Base.SetModifier(5, Female, 5, 100)
	Base.SetModifier(5, Female, 12, 70)
	Base.SetModifier(5, Female, 13, 70)
	Base.SetLipFixedPhase(5, Female, 1)
	Base.SetEquipmentPhase(5, Female, Slots.Config.GetFaceItem(2))
	Base.SetPhoneme(5, Female, 1, 70)
	Base.SetPhoneme(5, Female, 0, 50)
	Base.SetPhoneme(5, Female, 6, 50)
	Base.SetModifier(5, Female, 11, 100)

	; Male (copy of pleasure)
	Base.SetMood(1, Male, 13, 40)
	Base.SetModifier(1, Male, 6, 20)
	Base.SetModifier(1, Male, 7, 20)
	Base.SetPhoneme(1, Male, 5, 20)

	Base.SetMood(2, Male, 8, 40)
	Base.SetModifier(2, Male, 12, 40)
	Base.SetModifier(2, Male, 13, 40)
	Base.SetPhoneme(2, Male, 2, 50)
	Base.SetPhoneme(2, Male, 13, 20)
	Base.SetLipFixedPhase(2, Male, 1)
	Base.SetEquipmentPhase(2, Male, Slots.Config.GetFaceItem(3))
	Base.SetPhoneme(2, Male, 1, 50)
	Base.SetPhoneme(2, Male, 0, 25)
	Base.SetPhoneme(2, Male, 6, 25)
	Base.SetModifier(2, Male, 8, 20)
	Base.SetModifier(2, Male, 10, 10)

	Base.SetMood(3, Male, 13, 80)
	Base.SetModifier(3, Male, 6, 80)
	Base.SetModifier(3, Male, 7, 80)
	Base.SetModifier(3, Male, 12, 30)
	Base.SetModifier(3, Male, 13, 30)
	Base.SetLipFixedPhase(3, Male, 1)
	Base.SetEquipmentPhase(3, Male, Slots.Config.GetFaceItem(2))
	Base.SetPhoneme(3, Male, 1, 70)
	Base.SetPhoneme(3, Male, 0, 50)
	Base.SetPhoneme(3, Male, 6, 50)
	Base.SetModifier(3, Male, 11, 90)

	Base.Save(id)
	Base.Enabled   = false
endFunction

function Custom1(int id)
	sslBaseExpression Base = Create(id)
	Base.Name = "Custom 1"
	Base.Enabled   = false
	Base.Save(id)
endFunction
function Custom2(int id)
	sslBaseExpression Base = Create(id)
	Base.Name = "Custom 2"
	Base.Enabled   = false
	Base.Save(id)
endFunction
function Custom3(int id)
	sslBaseExpression Base = Create(id)
	Base.Name = "Custom 3"
	Base.Enabled   = false
	Base.Save(id)
endFunction
function Custom4(int id)
	sslBaseExpression Base = Create(id)
	Base.Name = "Custom 4"
	Base.Enabled   = false
	Base.Save(id)
endFunction
function Custom5(int id)
	sslBaseExpression Base = Create(id)
	Base.Name = "Custom 5"
	Base.Enabled   = false
	Base.Save(id)
endFunction
