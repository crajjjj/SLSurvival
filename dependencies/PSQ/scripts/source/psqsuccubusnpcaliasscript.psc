Scriptname PSQSuccubusNPCAliasScript Extends ReferenceAlias

PlayerSuccubusQuestScript Property PSQ Auto
PSQSuccubusNPCAliasScript Property NPCSuccubusQ Auto

;�܂�����͂ǂ��ɂ��A�^�b�`����Ă��Ȃ��̂ōD���ɏ����Ă悢�B

;�v���C���[�̂��̂قǕ��G�Ȃ��Ƃ͂��Ȃ��B

Event OnInit()
	;����Actor���T�L���o�X�ƂȂ鏈���������ł��
	
	RegisterForSingleUpdateGameTime(0.01)
EndEvent

Event OnUpdateGameTime()
	;If �v���C���[�t�H�����[�ł͂Ȃ��ꍇ|�v���C���[���Q�Ă���ꍇ�́ASatiation = 80%�ɋ߂Â��悤��Satiaty�𑝌�������B
	;�v�͌��ĂȂ��Ƃ���ŐF�X����Ă���ĕ\���B���łɐ��o�����ϓ����������B
	
	;ElseIf �v���C���[�t�H�����[�̏ꍇ��Satiation Threshold�ɂ���čD�����珇�ɐH�ׂĂ����B
	;�D��/�����Ȃ��̂͂�����x�͈̔͂Őݒ�\�B���悢��ꂵ���Ȃ�����܂������̂ł��H�ׂ�B
EndEvent

;�T�L���o�X���@�̔���͂Ȃ��B�ώG�ɂȂ邽�߁B
;���֌W�̔���͂Ȃ��BNPC�͔�ׂȂ��������Ȃ����߁B

;�I�[�g�ŋ����������������邽�߂̂��
Event OnHit(ObjectReference akAggressor, Form akSrc, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	If PSQ.PlayerIsSuccubus.GetValue() == 1 && PSQ.EnablePSQRape
		Actor Aggressor = akAggressor as Actor
		If IsRaper(Aggressor) && RapeIncidentOccurrence()
			If !PSQ.PlayerRef.HasKeywordString("SexLabActive")
				Debug.SendAnimationEvent(PSQ.PlayerRef, "BleedoutStart")
				Aggressor.AddToFaction(PSQ.PSQRapeNoAttackFaction)
				PSQ.PlayerRef.AddToFaction(PSQ.PSQRapeNoAttackFaction)
				Actor[] SexActors = new Actor[2]
				SexActors[0] = PSQ.PlayerRef
				SexActors[1] = Aggressor
				sslBaseAnimation[] anims = PSQ.SexLab.GetAnimationsByType(2, Aggressive = True)
				PSQ.SexLab.StartSex(SexActors, anims, Victim = PSQ.PlayerRef)
			EndIf
		EndIf
	EndIf
Endevent

;�\�s���̐��~�𔻒�
Bool Function IsRaper(Actor Target)
	If PSQ.SexLab.ValidateActor(Target) == 1
		If Target.HasMagicEffectWithKeyword(PSQ.MagicInfluence) || PSQ.SlaUtil.GetActorArousal(Target) >= PSQ.RapeArousalThreshold
			Return True
		EndIf
	EndIf
	Return False
EndFunction

;�v���C���[�̗̑͂Ɨ������狭�����������𔻒�
Bool Function RapeIncidentOccurrence()
	If Utility.RandomInt(1, 100) <= PSQ.RapeChance && PSQ.PlayerRef.GetActorValuePercentage("Health") * 100 <= PSQ.RapeHealthThreshold
		Return True
	Endif
	Return False
EndFunction
