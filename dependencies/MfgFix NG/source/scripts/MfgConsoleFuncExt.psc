Scriptname MfgConsoleFuncExt Hidden

;==============================================================================================================================
;                                            Expression Construct Documentation
;==============================================================================================================================
;All number are floats in range 0.0-1.0
;Only exception is expression[30] where it needs whole number in range 0-16
;
;    =====================Phonems=====================
;    
;    expression[ 0] = Aah       [ 0.0 , 1.0 ]
;    expression[ 1] = BigAah    [ 0.0 , 1.0 ]
;    expression[ 2] = BMP       [ 0.0 , 1.0 ]
;    expression[ 3] = ChJSh     [ 0.0 , 1.0 ]
;    expression[ 4] = DST       [ 0.0 , 1.0 ]
;    expression[ 5] = Eee       [ 0.0 , 1.0 ]
;    expression[ 6] = Eh        [ 0.0 , 1.0 ]
;    expression[ 7] = FV        [ 0.0 , 1.0 ]
;    expression[ 8] = I         [ 0.0 , 1.0 ]
;    expression[ 9] = K         [ 0.0 , 1.0 ]
;    expression[10] = N         [ 0.0 , 1.0 ]
;    expression[11] = Oh        [ 0.0 , 1.0 ]
;    expression[12] = OohQ      [ 0.0 , 1.0 ]
;    expression[13] = R         [ 0.0 , 1.0 ]
;    expression[14] = Th        [ 0.0 , 1.0 ]
;    expression[15] = W         [ 0.0 , 1.0 ]
;    
;    =====================Modifiers=====================
;    (If values are same for paired modifiers (eyes or brows) - they will be applied simultaniously)

;    expression[16] = BlinkLeft      [ 0.0 , 1.0 ]     !Warning, using this will prevent the eye from blinking! 
;    expression[17] = BlinkRight     [ 0.0 , 1.0 ]     !Warning, using this will prevent the eye from blinking! 
;    expression[18] = BrowDownLeft   [ 0.0 , 1.0 ]
;    expression[19] = BrowDownRight  [ 0.0 , 1.0 ]
;    expression[20] = BrowInLeft     [ 0.0 , 1.0 ]
;    expression[21] = BrowInRight    [ 0.0 , 1.0 ]
;    expression[22] = BrowUpLeft     [ 0.0 , 1.0 ]
;    expression[23] = BrowUpRight    [ 0.0 , 1.0 ]
;    expression[24] = LookDown       [ 0.0 , 1.0 ]     !Warning, using this will prevent the eye from blinking! 
;    expression[25] = LookLeft       [ 0.0 , 1.0 ]     !Warning, using this will prevent the eye from blinking! 
;    expression[26] = LookRight      [ 0.0 , 1.0 ]     !Warning, using this will prevent the eye from blinking! 
;    expression[27] = LookUp         [ 0.0 , 1.0 ]     !Warning, using this will prevent the eye from blinking! 
;    expression[28] = SquintLeft     [ 0.0 , 1.0 ]
;    expression[29] = SquintRight    [ 0.0 , 1.0 ]
;    
;    =====================Expression=====================
;    
;    expression[30] =        X: Selected expression, see below [ 0 , 16 ]
;                         0: Dialogue Anger
;                         1: Dialogue Fear
;                         2: Dialogue Happy
;                         3: Dialogue Sad
;                         4: Dialogue Surprise
;                         5: Dialogue Puzzled
;                         6: Dialogue Disgusted
;                         7: Mood Neutral
;                         8: Mood Anger
;                         9: Mood Fear
;                        10: Mood Happy
;                        11: Mood Sad
;                        12: Mood Surprise
;                        13: Mood Puzzled
;                        14: Mood Disgusted
;                        15: Combat Anger
;                        16: Combat Shout - this opens mouth like phoneme, try to not use this unless you have good reason
;    expression[31] = Strength of choosen expression (expression[30]) [ 0.0 , 1.0 ] (If set to 0 - dynamic value will be applied based on condition)
;==============================================================================================================================
;==============================================================================================================================

;Sample:
;"female3" : [ 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0.6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.8, 0.8, 2, 0.8 ],
;expression[5] = Eee 
;Strength 50%
;expression[11] = Oh
;Strength 60%
;expression[28] = SquintLeft
;expression[29] = SquintRight
;Strength 80%
;expression[30] = 2: Dialogue Happy
;Strength 80%

;https://steamcommunity.com/sharedfiles/filedetails/?l=english&id=187155077 - detailed description

;Applying expression array [31] to actor akActor
;        =Arguments=
;akActor            = actor to process
;apExpression       = raw expression construct.
;abOpenMouth        = if true, will skip phonemes
;exprPower          = used if expression is set but expr value is 0 in the preset (dynamic expr strength). 0 to ignore
;exprStrModifier, modStrModifier,  phStrModifier= values will be miltiplied by those (capped by 200)
;speed              = anim speed. 0.1 is close to instant. 0.75 is recomended for smooth transitions 
;        =Return value=
;Return true in case preset was successfully applied

bool Function ApplyExpressionPreset(Actor akActor, float[] aaExpression, bool abOpenMouth, int exprPower, float exprStrModifier, float modStrModifier, float phStrModifier, float speed)  native global

;Reset mfg smoothly
;        =Arguments=
;akActor            = actor to process
;mode      		=  -1 for reset all, 0 for phonemes, 1 for modifiers
;speed              = anim speed. 0.1 is close to instant. 0.75 is recomended for smooth transitions 
;        =Return value=
;Return true if successfully applied
bool function ResetMFGSmooth(Actor akActor, int mode, float speed) native global

;Set mfg smoothly
;        =Arguments=
;akActor            = actor to process
;mode        		=  Reset= -1,Phoneme= 0,Modifier= 1,ExpressionValue = 2,
;id                 = phoneme or modifier or mood id
;value              = phoneme or modifier or expression strength [ 0 , 200 ] — 0 to 100 is the normal range; 101-200 is allowed and may produce exaggerated morphs.
;speed              = anim speed. 0.1 is close to instant. 0.75 is recomended for smooth transitions
;        =Return value=
;Return true if successfully applied
bool function SetPhonemeModifierSmooth(Actor act, int mode, int id, int value, float speed) native global

; Get PC dialogue target
Actor Function GetPlayerSpeechTarget() global native

;Works for NPCs and Player for regular dialogues and chatter also like greetings and bumps. Using dialoguedata object
bool Function IsInDialogue(Actor akActor) global native

; wrapper functions

; set phoneme/modifier, same as console.
bool function SetPhoneme(Actor act, int id, int value, float speed = 0.75) global
	return SetPhonemeModifierSmooth(act, 0, id, value, speed)
endfunction
bool function SetModifier(Actor act, int id, int value, float speed = 0.75) global
	return SetPhonemeModifierSmooth(act, 1, id, value, speed)
endfunction
bool function SetExpression(Actor act, int mood, int value, float speed = 0.75) global
	return SetPhonemeModifierSmooth(act, 2, mood, value, speed)
endfunction
bool Function ApplyExpressionPresetSmooth(Actor akActor, float[] aaExpression, bool abOpenMouth, int exprPower=0, float exprStrModifier=1.0, float modStrModifier=1.0, float phStrModifier=1.0, float speed=0.75) global
	return ApplyExpressionPreset(akActor,aaExpression,abOpenMouth,exprPower,exprStrModifier,modStrModifier,phStrModifier, speed)
endfunction
bool function ResetMfg(Actor act, float speed = 0.75) global
	return ResetMFGSmooth(act,-1, speed)
endfunction
bool function ResetPhonemes(Actor act, float speed = 0.75) global
	return ResetMFGSmooth(act, 0, speed)
endfunction
bool function ResetModifiers(Actor act, float speed = 0.75) global
	return ResetMFGSmooth(act, 1, speed)
endfunction