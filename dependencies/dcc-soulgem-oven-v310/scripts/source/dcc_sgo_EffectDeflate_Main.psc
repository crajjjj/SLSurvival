Scriptname dcc_sgo_EffectDeflate_Main extends ActiveMagicEffect
{this script is responsible for expanding the belly for cum deflation.}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NiOverride Keys ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; NPC Belly -> SGO.Inflate

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

dcc_sgo_QuestController Property SGO Auto

Actor Property Who Auto Hidden
Float Property Value Auto Hidden
Bool  Property Done Auto Hidden

Event OnEffectStart(Actor Target, Actor From)
	self.Who = Target
	self.Value = SGO.BoneGetScale(Target,"NPC Belly","SGO.Inflate")
	self.Done = FALSE

	Target.EquipItem(SGO.dcc_sgo_ArmorSquirtingCum,TRUE,TRUE)

	self.OnUpdate()
	Return
EndEvent

Event OnUpdate()
	self.Value -= 0.02
	If(self.Value <= 1.0)
		self.Value = 1.0
		self.Done = TRUE
	EndIf

	SGO.BoneSetScale(self.Who,"NPC Belly","SGO.Inflate",self.Value)

	If(!self.Done)
		self.RegisterForSingleUpdate(0.01)
	Else
		self.Who.RemoveItem(SGO.dcc_sgo_ArmorSquirtingCum,69,TRUE)
		self.Who.RemoveSpell(SGO.dcc_sgo_SpellDeflate)
		self.Who.RemoveSpell(SGO.dcc_sgo_SpellDeflateTrigger)
	EndIf

	Return
EndEvent
