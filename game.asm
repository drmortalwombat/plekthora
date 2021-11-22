!zone Game
	
.state		!byte	0
.twoplayer	!byte	0

.showirq 	=	0
	
.Init
	jsr	EnemyWave.Init
	jsr	Starfield.Init
	jsr	Status.Init
	jsr	.Reset

	rts
	
.Reset
	jsr	Sprites.Reset
	jsr	Player.Init
;	jsr	Player.Update
	jsr	PlayerWeapon.Init
	jsr	Enemies.Init
	jsr	Starfield.Reset
	jsr	Sound.Init
	jsr	Status.Reset
	
	rts
	
.PutHex
	pha
	lsr
	lsr
	lsr
	lsr
	cmp	#$0a
	bcc	+
	adc	#6
+	adc	#96
	sta	Screen, y
	pla
	and	#$0f
	cmp	#$0a
	bcc	+
	adc	#6
+	adc	#96
	sta	Screen + 1, y
	rts
	
.tconfig0	!text	"PLEKTHORA", 0
.tconfig1	!text	"LEVEL  >1", 0
.tconfig2	!text	"PLAYERS 1", 0
.tconfig3	!text	"LIVES   3", 0

.sconfig	!text	"COLLECT STARS TO INCREASE MULTIPLIER.  PRESS SPACE TO PAUSE.  "
		!text	"YOU NEED MORE STARS IF YOU START WITH MORE LIVES.  "
		!text	"COMPLETE LEVELS FOR CONTINUES.", 0

.tready1	!text	"PREPARE",0
.tready2	!text	"FOR",0
.tready3	!text	"COMBAT", 0

.tgameover1	!text	"GAME OVER",0
.tgameover2	!text	"HIGHSCORE",0
.tgameover3	!text	"NEW", 0

.tcompleted1	!text	"MISSION", 0
.tcompleted2	!text	"COMPLETED", 0
.tcompleted3	!text	"YOU ARE", 0
.tcompleted4	!text	"AMAZING", 0

.tcontinue	!text	"CONTINUE",0

.MReadyPlayer		=	0
.MContinue		=	1
.MGameOver		=	2
.MTitle			=	3
.MCompleted		=	4

.menujmpl	!byte	<.MenuReadyPlayer, <.MenuContinue, <.MenuGameOver, <.MenuTitle, <.MenuCompleted
.menujmph	!byte	>.MenuReadyPlayer, >.MenuContinue, >.MenuGameOver, >.MenuTitle, >.MenuCompleted

.mstate		!byte	0
.mdelay		!byte	0
.mcount		!byte	0
.mresult	!byte	0
.moptions	!byte	1, 1, 3
.mindex		!byte	0

.maxoptions	!byte	9, 2, 6

.MenuClear
	lda	.mstate
	cmp	#19
	bcs	+
	tax
	lda	CharLinesL + 1, x
	sta	tmpl
	lda	CharLinesH + 1, x
	sta	tmph
	ldy	#0
	lda	#112
-
	sta	(tmpl),y
	iny
	cpy	#40
	bne	-

	inc	.mstate
	rts
+
	lda	#$ff
	sta	.mstate
	
	rts

.MenuTitle
	lda	.mstate
	bne	+
	lda	.moptions + 0
	ora	#$30
	sta	.tconfig1 + 8
	lda	.moptions + 1
	ora	#$30
	sta	.tconfig2 + 8
	lda	.moptions + 2
	ora	#$30
	sta	.tconfig3 + 8
	
	lda	#<.sconfig
	ldy	#>.sconfig
	jsr	Starfield.QueueText
	
	lda	#0
	sta	.mindex
+
	lda	.mstate
	cmp	#9
	bcs	+

	asl
	adc	#0
	tax
	ldy	#0
	jsr	BigFont.SetCursor

	ldx	#0
	lda	.mstate
	tay
	lda	.tconfig0, y
	
	jsr	BigFont.DrawChar
	inc	.mstate
	
	rts
+
	cmp	#9 + 9
	bcs	+

	asl
	sbc	#17
	tax
	ldy	#5
	jsr	BigFont.SetCursor

	ldx	#0
	lda	.mstate
	tay
	lda	.tconfig1 - 9, y
	
	jsr	BigFont.DrawChar
	inc	.mstate
	
	rts
	
+
	cmp	#9 + 9 + 9
	bcs	+

	asl
	sbc	#17 + 18
	tax
	ldy	#9
	jsr	BigFont.SetCursor

	ldx	#0
	lda	.mstate
	tay
	lda	.tconfig2 - 18, y
	
	jsr	BigFont.DrawChar
	inc	.mstate
	
	rts
+
	cmp	#9 + 9 + 9 + 9
	bcs	+

	asl
	sbc	#17 + 18 + 18
	tax
	ldy	#13
	jsr	BigFont.SetCursor

	ldx	#0
	lda	.mstate
	tay
	lda	.tconfig3 - 27, y
	
	jsr	BigFont.DrawChar
	inc	.mstate
	
	rts
		
+
	lda	Input.button
	and	Input.button + 1
	bne	+

	lda	#$ff
-
	sta	.mresult
	
	lda	#0
	sta	.mstate
	lda	#<.MenuClear
	sta	.mcall + 1
	lda	#>.MenuClear
	sta	.mcall + 2
+	
	lda	Input.dy
	ora	Input.dy + 1
	ora	Input.dx
	ora	Input.dx + 1
	bne	+
	lda	#0
	sta	.mdelay
	rts
+
	lda	.mdelay
	beq	+
	dec	.mdelay
	rts
+	
	lda	Input.dy
	ora	Input.dy + 1
	beq	+++
	
	lda	.mindex
	asl
	asl
	adc	#5
	tay
	ldx	#14
	jsr	BigFont.SetCursor
	ldx	#0
	lda	#32
	jsr	BigFont.DrawChar
	
	lda	Input.dy
	ora	Input.dy + 1
	clc
	adc	.mindex
	bmi	+
	cmp	#3
	bcc	++
	lda	#0
	!byte	$2c
+	lda	#2
++	sta	.mindex
	
	asl
	asl
	adc	#5
	tay
	ldx	#14
	jsr	BigFont.SetCursor
	ldx	#0
	lda	#62
	jsr	BigFont.DrawChar
	lda	#15
	sta	.mdelay
	
	lda	#<Sound.MenuButtonSound1
	ldy	#>Sound.MenuButtonSound1
	jmp	Sound.PlaySound
	
+++
	ldx	.mindex
	lda	Input.dx
	ora	Input.dx + 1
	clc
	adc	.moptions, x
	beq	+
	cmp	.maxoptions, x
	bcc	++
	beq	++
	sbc	#1
	!byte	$2c
+	lda	#1
++	sta	.moptions, x
	
	txa
	asl
	asl
	adc	#5
	tay
	ldx	#16
	jsr	BigFont.SetCursor
	
	ldx	.mindex
	lda	.moptions, x
	ora	#$30
	ldx	#0
	jsr	BigFont.DrawChar
		
	lda	#15
	sta	.mdelay
	
	lda	#<Sound.MenuButtonSound2
	ldy	#>Sound.MenuButtonSound2
	jmp	Sound.PlaySound

	
	
.MenuContinue
	lda	.mstate
	cmp	#8
	bcs	+

	asl
	adc	#1
	tax
	ldy	#2
	jsr	BigFont.SetCursor

	ldx	#0
	lda	.mstate
	tay
	lda	.tcontinue, y
	
	jsr	BigFont.DrawChar
	inc	.mstate
	
	lda	#7
	sta	.mcount
	lda	#1
	sta	.mdelay
	rts
	
+
	lda	Input.button
	and	Input.button + 1
	bne	+

	lda	#$ff
-
	sta	.mresult
	
	lda	#0
	sta	.mstate
	lda	#<.MenuClear
	sta	.mcall + 1
	lda	#>.MenuClear
	sta	.mcall + 2
	
	rts
	
+
	dec	.mdelay
	beq	+
	rts
+	
	dec	.mcount
	bne	+

	lda	#$00
	beq	-
+
	ldx	#8
	ldy	#7
	jsr	BigFont.SetCursor
	
	lda	#50
	sta	.mdelay
	
	lda	.mcount
	asl
	asl
	asl
	asl
	adc	#<Sound.ContinueSound
	ldy	#>Sound.ContinueSound
	bcc	+
	iny
+	jsr	Sound.PlaySound
	
	
	
	lda	.mcount
	clc
	adc	#$2f
	ldx	#3
	jsr	BigFont.DrawChar
	rts
	
	


.MenuReadyPlayer
	lda	.mstate
	bne	+
	
	lda	#<Sound.PlayerReadySound1
	ldy	#>Sound.PlayerReadySound1
	jsr	Sound.PlaySound

	lda	#<Sound.PlayerReadySound2
	ldy	#>Sound.PlayerReadySound2
	jsr	Sound.PlaySound
	
	lda	#<Sound.PlayerReadySound3
	ldy	#>Sound.PlayerReadySound3
	jsr	Sound.PlaySound
	
+
	
	lda	.mstate
	cmp	#7
	bcs	+

	asl
	adc	#2
	tax
	ldy	#2
	jsr	BigFont.SetCursor
	
	ldx	#0
	ldy	.mstate
	lda	.tready1, y
	
	jsr	BigFont.DrawChar
	inc	.mstate
	rts
	
+
	cmp	#7 + 3
	bcs	+

	asl
	sbc	#7
	tax
	ldy	#6
	jsr	BigFont.SetCursor
	
	ldx	#0
	ldy	.mstate
	lda	.tready2 - 7, y
	
	jsr	BigFont.DrawChar
	
	lda	#0
	sta	.mdelay
	inc	.mstate
		
	rts

+
	cmp	#7 + 3 + 6
	bcs	+

	asl
	sbc	#16
	tax
	ldy	#10
	jsr	BigFont.SetCursor
	
	ldx	#0
	ldy	.mstate
	lda	.tready3 - 10, y
	
	jsr	BigFont.DrawChar
	
	lda	#0
	sta	.mdelay
	inc	.mstate
		
	rts
	
+
	
	dec	.mdelay
	bne	+

	lda	#0
	sta	.mstate
	lda	#<.MenuClear
	sta	.mcall + 1
	lda	#>.MenuClear
	sta	.mcall + 2
	
+
	rts
	
.MenuGameOver
	lda	.mstate
	cmp	#0
	beq	+
	cmp	#30
	beq	+
	cmp	#80
	bne	++
+	
	
	lda	#<Sound.GameOverSound
	ldy	#>Sound.GameOverSound
	jsr	Sound.PlaySound
	
++	
	lda	.mstate
	cmp	#9
	bcs	+

	asl
	tax
	ldy	#0
	jsr	BigFont.SetCursor
	
	ldx	#0
	ldy	.mstate
	lda	.tgameover1, y
	
	jsr	BigFont.DrawChar
	inc	.mstate
	rts
	
+
	cmp	#8 + 9
	bcs	+
	
	asl
	sec
	sbc	#2 * 9 - 1
	tax
	ldy	#4
	jsr	BigFont.SetCursor
	
	ldx	#0
	ldy	.mstate
	lda	Status.ScoresScreen - 9, y
	sec
	sbc	#48
	
	jsr	BigFont.DrawChar
	
	lda	#0
	sta	.mdelay
	inc	.mstate
		
	rts

+
	lda	Status.hashigh
	and	#$7f
	beq	++
	
	
	lda	.mstate	
	cmp	#3 + 8 + 9
	bcs	+

	asl
	sec
	sbc	#2 * (9 + 8) - 6
	tax
	ldy	#9
	jsr	BigFont.SetCursor
	
	ldx	#0
	ldy	.mstate
	lda	.tgameover3 - 9 - 8, y
	
	jsr	BigFont.DrawChar
	
	lda	#0
	sta	.mdelay
	inc	.mstate
		
	rts
+

	lda	.mstate	
	cmp	#3 + 8 + 9 + 9
	bcs	+++

	asl
	sec
	sbc	#2 * (9 + 8 + 3)
	tax
	ldy	#13
	jsr	BigFont.SetCursor
	
	ldx	#0
	ldy	.mstate
	lda	.tgameover2 - 9 - 8 - 3, y
	
	jsr	BigFont.DrawChar
	
	lda	#0
	sta	.mdelay
	inc	.mstate
		
	rts
	
++
	lda	.mstate	
	cmp	#8 + 9 + 9
	bcs	+

	asl
	sec
	sbc	#2 * (9 + 8)
	tax
	ldy	#9
	jsr	BigFont.SetCursor
	
	ldx	#0
	ldy	.mstate
	lda	.tgameover2 - 9 - 8, y
	
	jsr	BigFont.DrawChar
	
	lda	#0
	sta	.mdelay
	inc	.mstate
		
	rts
	
+
	cmp	#8 + 8 + 9 + 9
	bcs	+++
	
	asl
	sec
	sbc	#2 * (9 + 8 + 9) - 1
	tax
	ldy	#13
	jsr	BigFont.SetCursor
	
	ldx	#0
	ldy	.mstate
	lda	Status.highscore - 9 - 8 - 9, y
	sec
	sbc	#48
	
	jsr	BigFont.DrawChar
	
	lda	#0
	sta	.mdelay
	inc	.mstate
		
	rts
	
+++
	dec	.mdelay
	bne	+	

	lda	#0
	sta	.mstate
	lda	#<.MenuClear
	sta	.mcall + 1
	lda	#>.MenuClear
	sta	.mcall + 2

+
	rts

	
.MenuCompleted
	lda	.mstate
	cmp	#0
	beq	+
	cmp	#30
	beq	+
	cmp	#80
	bne	++
+	
	
	lda	#<Sound.GameOverSound
	ldy	#>Sound.GameOverSound
;	jsr	Sound.PlaySound
	
++	
	lda	.mstate
	cmp	#7
	bcs	+

	asl
	clc
	adc	#2
	tax
	ldy	#0
	jsr	BigFont.SetCursor
	
	ldx	#0
	ldy	.mstate
	lda	.tcompleted1, y
	
	jsr	BigFont.DrawChar
	inc	.mstate
	rts
	
+
	cmp	#9 + 7
	bcs	+
	
	asl
	sec
	sbc	#2 * 7
	tax
	ldy	#4
	jsr	BigFont.SetCursor
	
	ldx	#0
	ldy	.mstate
	lda	.tcompleted2 - 7, y
	
	jsr	BigFont.DrawChar
	
	lda	#0
	sta	.mdelay
	inc	.mstate
		
	rts

+
	cmp	#7 + 9 + 7
	bcs	+

	asl
	sec
	sbc	#2 * (9 + 7) - 2
	tax
	ldy	#9
	jsr	BigFont.SetCursor
	
	ldx	#0
	ldy	.mstate
	lda	.tcompleted3 - 9 - 7, y
	
	jsr	BigFont.DrawChar
	
	lda	#0
	sta	.mdelay
	inc	.mstate
		
	rts
+

	lda	.mstate	
	cmp	#7 + 7 + 9 + 7
	bcs	+++

	asl
	sec
	sbc	#2 * (7 + 9 + 7) - 2
	tax
	ldy	#13
	jsr	BigFont.SetCursor
	
	ldx	#0
	ldy	.mstate
	lda	.tcompleted4 - 7 - 9 - 7, y
	
	jsr	BigFont.DrawChar
	
	lda	#0
	sta	.mdelay
	inc	.mstate
		
	rts
	
	
+++
	dec	.mdelay
	bne	+	

	lda	#0
	sta	.mstate
	lda	#<.MenuClear
	sta	.mcall + 1
	lda	#>.MenuClear
	sta	.mcall + 2

+
	rts
	
	
!align	255, 0
.colortab	!byte	11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 12, 11, 12, 11, 12, 12, 12, 12, 15, 12, 15, 12, 15, 15, 15, 15, 1, 15, 1, 15, 1, 1, 1, 1, 15, 1, 15, 1, 15, 15, 15, 15, 14, 15, 14, 15, 14, 14, 14, 14, 6, 14, 6, 14, 6, 6, 6, 6, 11, 6, 11, 6, 11, 11, 11, 11, 9, 11, 9, 11, 9, 9, 9, 9, 8, 9, 8, 9, 8, 8, 8, 8, 7, 8, 7, 8, 7, 7, 7, 7, 1, 7, 1, 7, 1, 1, 1, 1, 13, 1, 13, 1, 13, 13, 13, 13, 3, 13, 3, 13, 3, 3, 3, 3, 5, 3, 5, 3, 5, 5, 5, 5, 11, 5, 11, 5, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 12, 11, 12, 11, 12, 12, 12, 12, 15, 12, 15, 12, 15, 15, 15, 15, 1, 15, 1, 15, 1, 1, 1, 1, 15, 1, 15, 1, 15, 15, 15, 15, 14, 15, 14, 15, 14, 14, 14, 14, 6, 14, 6, 14, 6, 6, 6, 6, 11, 6, 11, 6, 11, 11, 11, 11, 9, 11, 9, 11, 9, 9, 9, 9, 8, 9, 8, 9, 8, 8, 8, 8, 7, 8, 7, 8, 7, 7, 7, 7, 1, 7, 1, 7, 1, 1, 1, 1, 13, 1, 13, 1, 13, 13, 13, 13, 3, 13, 3, 13, 3, 3, 3, 3, 5, 3, 5, 3, 5, 5, 5, 5, 11, 5, 11, 5, 11, 11

.RasterEffect
	lda	#2

	ldx	#45
-	
	cpx	$d012
	bne	-
	lda	$d011
	bmi	-
-	
	cpx	$d012
	beq	-
	
	inx

	ldy	#10
-
	dey
	bne	-

;	sta	$d020
	cpx	$d012
	bne	+
	nop
	nop
+

	inx

	ldy	#10
-
	dey
	bne	-
	nop

	cpx	$d012
	beq	+
+
	inx

	ldy	#10
-
	dey
	bne	-
	nop
	nop

	cpx	$d012
	beq	+
+
	inx

	ldy	#9
-
	dey
	bne	-
	nop
	nop
	nop
	nop

	cpx	$d012
	beq	+
+

	ldy	#9
-
	dey
	bne	-

	ldy	#91
-
	dey
	bne	-
	
	ldy	Phase
	
	dex
	dex
--
	lda	.colortab, y
;	sta	$d020
	sta	$d021
	iny
	nop
;	nop
;	nop
	inx
	
	txa
	and	#$07
	beq	--

	tya
	ldy	#5
-
	dey
	bne	-
	tay
	
	nop
	nop
	nop
	nop
	
	cpx	#194
	bcc	--

	lda	#0
	sta	$d020
	sta	$d021
	

	rts

.InvertStars
	ldx	#0
-
	lda	CharsetData + 8 * $80, x
	eor	#$ff
	sta	CharsetData + 8 * $80, x

	lda	CharsetData + 8 * $90, x
	eor	#$ff
	sta	CharsetData + 8 * $90, x

	lda	CharsetData + 8 * $a0, x
	eor	#$ff
	sta	CharsetData + 8 * $a0, x

	lda	CharsetData + 8 * $b0, x
	eor	#$ff
	sta	CharsetData + 8 * $b0, x

	lda	CharsetData + 8 * $c0, x
	eor	#$ff
	sta	CharsetData + 8 * $c0, x

	lda	CharsetData + 8 * $d0, x
	eor	#$ff
	sta	CharsetData + 8 * $d0, x

	lda	CharsetData + 8 * $e0, x
	eor	#$ff
	sta	CharsetData + 8 * $e0, x

	lda	CharsetData + 8 * $f0, x
	eor	#$ff
	sta	CharsetData + 8 * $f0, x

	lda	CharsetData + 8 * 112, x
	eor	#$ff
	sta	CharsetData + 8 * 112, x
	
	inx
	cpx	#8
	bne	-

	ldx	#0
-
	lda	CharsetData + 8 * 200, x
	eor	#$ff
	sta	CharsetData + 8 * 200, x

	lda	CharsetData + 8 * 216, x
	eor	#$ff
	sta	CharsetData + 8 * 216, x

	inx
	cpx	#64
	bne	-
		
	rts
	
.Menu
	lda	.menujmpl, x
	sta	.mcall + 1
	lda	.menujmph, x
	sta	.mcall + 2
	
	jsr	Starfield.BlackStars
	jsr	.InvertStars
	
	lda	#0
	sta	.mstate

.mloop
	lda	#0
	sta	Sprites.vsync

-
	lda	Sprites.vsync
	beq	-

	jsr	Sound.Loop
	
	jsr	Starfield.DrawFloor

	jsr	Input.Scan

.mcall
	jsr	$dead
	
	jsr	.RasterEffect
	
	jsr	Starfield.DrawStars
	
	inc	Phase
	
	lda	.mstate
	cmp	#$fe
	bcc	.mloop
+

	jsr	.InvertStars
	jsr	Starfield.ColorStars

	rts
	
.itext	!text	"     WELCOME TO <PLEKTHORA> STARFLEET, WHERE HEROES ARE THE NORMAL     "
	!text	"     PUSH BUTTON TO START     ..........      "
.itextx	!text	"WRITTEN IN 2021 AFTER 35 YEARS OF C64 ABSTINENCE BY DRMORTALWOMBAT, JUST TO HAVE FUN WITH A 32 WAY SPRITE MULTIPLEXER.", 0
	
.Intro
	lda	#<.itext
	sta	BigFont.textl
	lda	#>.itext
	sta	BigFont.texth
	lda	#0
	sta	BigFont.posx
	
	ldx	#0
--
	lda	CharLinesL + 7, x
	sta	tmpl
	lda	CharLinesH + 7, x
	eor	#$90
	sta	tmph
	ldy	#0
	lda	#0
	sta	(tmpl), y
	iny
	lda	#11
	sta	(tmpl), y
	iny
	lda	#12
	sta	(tmpl), y
	iny
	lda	#15
	sta	(tmpl), y
	iny
	lda	#1
-	sta	(tmpl), y
	iny
	cpy	#36
	bne	-
	lda	#15
	sta	(tmpl), y
	iny
	lda	#12
	sta	(tmpl), y
	iny
	lda	#11
	sta	(tmpl), y
	iny
	inx
	cpx	#7
	bne	--	

	lda	#<.itextx
	ldy	#>.itextx
	jsr	Starfield.QueueText
	
.iloop
	lda	#2

-
	cmp	Sprites.vsync
	bne	-
	
	jsr	BigFont.scrollGlpyhs
	
	jsr	Starfield.DrawStars

	jsr	Starfield.DrawFloor

	inc	BigFont.posx
	lda	BigFont.posx
	cmp	#8
	bne	+
	lda	#0
	sta	BigFont.posx
	inc	BigFont.textl
	bne	+
	inc	BigFont.texth
+
	
	lda	BigFont.textl
	cmp	#<(.itextx - 6)
	bne	+
	lda	BigFont.texth
	cmp	#>(.itextx - 6)
	bne	+
	
	lda	#<.itext
	sta	BigFont.textl
	lda	#>.itext
	sta	BigFont.texth	

+
	jsr	Input.Scan
	jsr	Sound.Loop
		
	inc	Phase

	lda	Input.button + 0
	and	Input.button + 0
	bne	.iloop

-	
	jsr	Input.Scan

	lda	Input.button + 0
	and	Input.button + 0
	beq	-
	
	jsr	Starfield.ClearStars

	rts
	
.pausetext	!text	"PAUSED", 0

.pausecolor	!text	0, 11, 12, 15, 1, 15, 12, 11

.Pause

	lda	#0
	sta	tmpu

.ploop

	lda	#0
	sta	Sprites.vsync

-
	lda	Sprites.vsync
	beq	-


	jsr	Input.Scan
	
	lda	Input.button
	and	Input.button + 1
	bne	+
	
-
	jsr	Input.Scan
	
	lda	Input.button
	and	Input.button + 1
	beq	-

	
	ldx	#7
	jsr	BigFont.ClearLine
	
	rts
+

	jsr	Sound.Loop
	

	ldx	#3
	ldy	#7
	jsr	BigFont.SetCursor
	
	lda	tmpu
	lsr
	and	#7
	tay
	ldx	.pausecolor, y

	lda	#<.pausetext
	ldy	#>.pausetext
	jsr	BigFont.DrawText
	
	inc	tmpu
	
-
	lda	Sprites.vsync
	bmi	-
	
	jmp	.ploop
	
.measurefree	=	0
	
!if (.measurefree) {
.freeclk	!word	0
}

.Check2PlayerRespawn
	bit	.twoplayer
	bpl	++
	lda	Status.lives	
	bne	++
	lda	Player.state
	eor	Player.state + 1
	bpl	++
	jmp	Status.AddLive
++
	rts
	
.Loop

	jsr	EnemyWave.Start

	bit	.twoplayer
	bmi	+
	lda	#$ff
	sta	Player.state + 1
+

	lda	#0
	sta	.state
.loop

; wait for vsync interrut to synchronize with sprite code


!if (.measurefree) {
	lda	.freeclk + 1
	ldy	#42
	jsr	.PutHex
	lda	.freeclk
	ldy	#44
	jsr	.PutHex
	
	lda	#0
	sta	.freeclk
	sta	.freeclk+ 1
}
	lda	#0
	sta	Sprites.vsync

-
!if (.measurefree) {
	inc	.freeclk
	bne	+
	inc	.freeclk+1
+
}
	lda	Sprites.vsync
	beq	-
	
	
!if .showirq {
	lda	#3
	sta	$d020
}
	
	jsr	Starfield.DrawStars

!if .showirq {
	lda	#13
	sta	$d020
}
	
	lda	#0
	sta	Player.index
	jsr	PlayerWeapon.Draw
	bit	.twoplayer
	bpl	+
	inc	Player.index
	jsr	PlayerWeapon.Draw
+

!if .showirq {
	lda	#2
	sta	$d020
}
	jsr	Starfield.DrawLoot	

!if .showirq {
	lda	#6
	sta	$d020
}	
	jsr	Starfield.DrawFloor

!if .showirq {
	lda	#7
	sta	$d020
}	
	jsr	EnemyWave.Advance

!if .showirq {
	lda	#8
	sta	$d020
}
	jsr	Input.Scan
	
; clone input for second player

	!if 0 {
	
		lda	Input.dx + 0
		sta	Input.dx + 1
		lda	Input.dy + 0
		sta	Input.dy + 1
		lda	Input.button + 0
		sta	Input.button + 1
	
	}
	
	lda	#0
	sta	Player.index
	jsr	Player.Iterate
	bit	.twoplayer
	bpl	+
	inc	Player.index
	jsr	Player.Iterate
	jsr	Player.CheckSpritePressure
+

!if .showirq {
	lda	#4
	sta	$d020
}
	jsr	Enemies.Move
!if .showirq {
	lda	#12
	sta	$d020
}

	
	lda	#0
	sta	Player.index
	jsr	PlayerWeapon.Update
	bit	.twoplayer
	bpl	+
	inc	Player.index
	jsr	PlayerWeapon.Update
+

!if .showirq {
	lda	#7
	sta	$d020
}
	jsr	Sound.Loop

!if .showirq {
	lda	#0
	sta	$d020
}	


-
!if (.measurefree) {
	inc	.freeclk
	bne	+
	inc	.freeclk+1
+
}
	lda	Sprites.vsync
	bmi	-

	
!if .showirq {
	lda	#8
	sta	$d020
}
	lda	#0
	sta	Player.index
	jsr	Player.Update
	bit	.twoplayer
	bpl	+
	inc	Player.index
	jsr	Player.Update
+

!if .showirq {
	lda	#14
	sta	$d020
}	
	jsr	Status.Update
	
!if .showirq {
	lda	#5
	sta	$d020
}	
	jsr	Enemies.Update

!if .showirq {
	lda	#0
	sta	$d020
}
	inc	Phase
	
	lda	Input.key
	cmp	#'q'
	beq	++
	cmp	#'t'
	bne	+
	dec	Status.trainer
+
	cmp	#' '
	bne	+
	jsr	.Pause
+
	bit	EnemyWave.completed
	bmi	++

	lda	Player.state + 0
	bpl	+
	and	#Player.PSExploded
	beq	+
	bit	.twoplayer
	bpl	++

	lda	Player.state + 1
	bpl	+
	and	#Player.PSExploded
	bne	++
+	jmp	.loop
++

	jsr	Sprites.Reset
	
	rts
	
