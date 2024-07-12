Scriptname dcc_sgo_EffectInflate_Main extends ActiveMagicEffect
{this script is responsible for expanding the belly for cum inflation.}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NiOverride Keys ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; NPC Belly -> SGO.Inflate

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

dcc_sgo_QuestController Property SGO Auto

Actor Property Who Auto Hidden
Float Property Value Auto Hidden
Float Property ValueMax Auto Hidden
Bool  Property Done Auto Hidden

Event OnEffectStart(Actor Target, Actor From)
	self.Who = Target
	self.Value = 1.0
	self.ValueMax = SGO.OptScaleBellyCum
	self.Done = FALSE

	;; if we were told to hold it then we will keep adding to it for the lulz.
	If(SGO.OptCumInflationHold)
		self.Value = SGO.BoneGetScale(Target,"NPC Belly","SGO.Inflate")
		self.ValueMax += (self.Value - 1)
	EndIf

	self.ValueMax = SGO.BoneCurveValue(Target,"NPC Belly",self.ValueMax)
	self.OnUpdate()
	Return
EndEvent

Event OnUpdate()
	self.Value += 0.02
	If(self.Value >= self.ValueMax)
		self.Value = self.ValueMax
		self.Done = TRUE
	EndIf

	SGO.BoneSetScale(self.Who,"NPC Belly","SGO.Inflate",self.Value)

	If(!self.Done)
		self.RegisterForSingleUpdate(0.01)
	Else
		self.Who.RemoveSpell(SGO.dcc_sgo_SpellInflate)

		If(SGO.OptCumInflationHold && self.Who == SGO.Player)
			self.Who.AddSpell(SGO.dcc_sgo_SpellDeflateTrigger)
		Else
			self.Who.AddSpell(SGO.dcc_sgo_SpellDeflate,TRUE)
		EndIf
	EndIf

	Return
EndEvent
