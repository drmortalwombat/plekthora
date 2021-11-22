	
	!zone	Status
		
.dscore		!word	0
.lives		!byte	0
.multiplier	!byte	0
.stars		!byte	0
.starfactor	!byte	10
.trainer	!byte	0

.starfactors	!byte	2, 5, 10, 20, 50, 100

.ScoresScreen	= Screen + 2
.ScoreColor	= Color + 2
.LivesScreen	= Screen + 24
.LivesColor	= Color + 24
.LevelScreen    = Screen + 16
.LevelColor     = Color + 16
.size		= 8
.Digits		= 96

.highscore	!fill	.size, .Digits
.hashigh	!byte	0


; Status line at top of screen
;
;           1         2         3        4
; 0123456789012345678901234567890123456789
; X.00000000.xMM..LVL.00..LlLlLlLlLlLlLl.X

.Init
	lda	#.Digits + 1
	sta	.highscore + .size - 4	

	rts
	
.Reset

	ldy	#0
-
	lda	#.Digits
	sta	.ScoresScreen, y
	lda	#5
	sta	.ScoreColor, y
	iny
	cpy	#.size
	bne	-
	
	jsr	.ResetMultiplier

	lda	#7
	sta	.ScoreColor +  9, y
	sta	.ScoreColor + 10, y
	sta	.ScoreColor + 11, y
	
	lda	#0
	sta	.dscore
	sta	.dscore + 1

	sta	.LevelScreen + 0
	sta	.LevelScreen + 1
	sta	.LevelScreen + 2
	sta	.LevelScreen + 3
	sta	.LevelScreen + 4
	sta	.LevelScreen + 5
	
	sta	.hashigh
		
	lda	#3
	sta	.lives
	
	jsr	.DrawLives
	
	rts

; Level color in Y, level number in A

.bonustext
	!text	"BONUS LIVE",0
	
.SetLevel
	cpy	#0
	bne	+
	iny
+
	sty	.LevelColor + 0
	sty	.LevelColor + 1
	sty	.LevelColor + 2
	sty	.LevelColor + 3
	sty	.LevelColor + 4
	sty	.LevelColor + 5
	
	ldy	#124
	sty	.LevelScreen + 0
	sty	.LevelScreen + 2
	ldy	#154
	sty	.LevelScreen + 1
	ldy	#0
	sty	.LevelScreen + 3
	
	ldy	#.Digits
	cmp	#20
	bcc	+
	iny
	iny
	sbc	#20
+
	cmp	#10
	bcc	+
	iny
	sbc	#10
+
	sty	.LevelScreen + 4
	clc
	adc	#.Digits
	sta	.LevelScreen + 5
	
	
	rts

.ResetMultiplier
	lda	#159
	sta	.ScoresScreen +  9
	lda	#.Digits
	sta	.ScoresScreen + 10
	lda	#.Digits + 1
	sta	.ScoresScreen + 11
	lda	#1
	sta	.multiplier
	lda	#0
	sta	.stars
	rts
	
.IncMultiplier
	lda	.multiplier
	cmp	#99
	bcs	++
	inc	.multiplier
	lda	.ScoresScreen + 11
	cmp	#.Digits + 9
	beq	+
	inc	.ScoresScreen + 11
	rts
+	lda	#.Digits + 0
	sta	.ScoresScreen + 11
	inc	.ScoresScreen + 10
++	rts
	
.AddStar
	inc	.stars
	lda	.stars
	cmp	.starfactor
	bne	+
	lda	#0
	sta	.stars
	jsr	.IncMultiplier
+	rts

; in A from 0 to 24
.DrawBossEnergy
	pha
	lsr
	lsr
	tax
	tay
	pla
	and	#3
	ora	#184
	sta	.LevelScreen, x
	lda	#188
	dex
	bmi	+
-	sta	.LevelScreen, x
	dex
	bpl	-
+	lda	#184
	cpy	#5
	bcs	+
-	iny
	sta	.LevelScreen, y
	cpy	#5
	bcc	-
+	rts
	
.DrawLives
	ldy	#0
	ldx	#0
	lda	.lives
	beq	+
-
	lda	#189
	sta	.LivesScreen, x	
	lda	#190
	sta	.LivesScreen + 1, x
	lda	#14
	sta	.LivesColor, x
	sta	.LivesColor + 1,x
	inx
	inx
	iny	
	cpy	.lives
	bcc	-
+	
	cpy	#7
	bcs	+
	
-
	lda	#0
	sta	.LivesScreen, x	
	sta	.LivesScreen + 1, x
	lda	#15
	sta	.LivesColor, x
	sta	.LivesColor + 1,x
	inx
	inx
	iny	
	cpy	#7
	bcc	-
+
	rts

.AddLive
	lda	.lives
	cmp	#7
	bcs	+
	inc	.lives
	
	lda	#<.bonustext
	ldy	#>.bonustext
	jsr	Starfield.QueueText
	
	jmp	.DrawLives
+
	rts
	
.RemLive
	bit	.trainer
	bpl	+
	rts
+
	dec	.lives
	jmp	.DrawLives
	
; score in y/a
.IncScore
	sta	tmpml
	sty	tmpmh
	lda	.multiplier

	lsr
	bcc	.incloop2
	
.incloop1
	tay
	clc
	lda	.dscore
	adc	tmpml
	sta	.dscore
	lda	.dscore + 1
	adc	tmpmh
	sta	.dscore + 1
	
	tya
	beq	.incdone
	
.incloop2
	asl	tmpml
	rol	tmpmh
	
	lsr
	bcs	.incloop1
	bne	.incloop2
.incdone

	lda	.hashigh
	and	#$7f
	sta	.hashigh

	rts

.TextHighscore	!text	"NEW HIGHSCORE", 0

.CheckHighscore
	lda	.hashigh
	bpl	+
	rts
+
	bne	+
	
	ldy	#.size
	sec
-
	lda	.highscore - 1, y
	sbc	.ScoresScreen - 1, y
	dey
	bne	-
	bcc	+
	lda	#$80
	sta	.hashigh
	rts
	
+
	ldy	#.size
-
	lda	.ScoresScreen - 1, y
	sta	.highscore - 1, y
	dey
	bne	-
	
	lda	.hashigh
	bne	+
	
	lda	#<.TextHighscore
	ldy	#>.TextHighscore
	jsr	Starfield.QueueText

+
	lda	#$81
	sta	.hashigh
	
	rts
	
.Update
	lda	Phase
	and	#$07
	tay

	lda	.ScoreColor, y
	and	#$0f
	cmp	#1
	bne	+
	lda	#13
	!byte	$2C
+	lda	#5
	sta	.ScoreColor, y

	lda	.dscore + 1
	beq	++
	sec
	lda	.dscore
	sbc	#100
	sta	.dscore
	bcs	+
	dec	.dscore + 1
+	ldy	#.size - 2
	jmp	.incn

++	lda	.dscore
	bne	+
	
	jmp	.CheckHighscore

+
	cmp	#200
	bcc	++
	sbc	#100
	sta	.dscore
	ldy	#.size - 2
	jmp	.incn

++	cmp	#20
	bcc	++
	sbc	#10
	sta	.dscore
	ldy	#.size - 1
	jmp	.incn

++	dec	.dscore

	ldy	#.size
.incn
-	lda	#1
	sta	.ScoreColor - 1, y
	lda	.ScoresScreen - 1, y
	cmp	#.Digits + 9
	bcs	+
	adc	#1
	sta	.ScoresScreen - 1, y
	cpy	#.size - 3 
	bcc	.extra
	rts
+	lda	#.Digits
	sta	.ScoresScreen - 1, y
	dey
	bne	-
	rts
.extra
	jmp	.AddLive
	

