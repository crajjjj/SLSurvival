Scriptname PSQSuccubusNPCAliasScript Extends ReferenceAlias

PlayerSuccubusQuestScript Property PSQ Auto
PSQSuccubusNPCAliasScript Property NPCSuccubusQ Auto

;まだこれはどこにもアタッチされていないので好きに書いてよい。

;プレイヤーのものほど複雑なことはやらない。

Event OnInit()
	;このActorがサキュバスとなる処理をここでやる
	
	RegisterForSingleUpdateGameTime(0.01)
EndEvent

Event OnUpdateGameTime()
	;If プレイヤーフォロワーではない場合|プレイヤーが寝ている場合は、Satiation = 80%に近づくようにSatiatyを増減させる。
	;要は見てないところで色々やってるって表現。ついでに性経験も変動させたい。
	
	;ElseIf プレイヤーフォロワーの場合はSatiation Thresholdによって好物から順に食べていく。
	;好物/嫌いなものはある程度の範囲で設定可能。いよいよ苦しくなったらまずいものでも食べる。
EndEvent

;サキュバス魔法の判定はなし。煩雑になるため。
;翼関係の判定はなし。NPCは飛べないし落ちないため。

;オートで強姦事件が発生するためのやつ
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

;暴行魔の性欲を判定
Bool Function IsRaper(Actor Target)
	If PSQ.SexLab.ValidateActor(Target) == 1
		If Target.HasMagicEffectWithKeyword(PSQ.MagicInfluence) || PSQ.SlaUtil.GetActorArousal(Target) >= PSQ.RapeArousalThreshold
			Return True
		EndIf
	EndIf
	Return False
EndFunction

;プレイヤーの体力と乱数から強姦事件発生を判定
Bool Function RapeIncidentOccurrence()
	If Utility.RandomInt(1, 100) <= PSQ.RapeChance && PSQ.PlayerRef.GetActorValuePercentage("Health") * 100 <= PSQ.RapeHealthThreshold
		Return True
	Endif
	Return False
EndFunction
