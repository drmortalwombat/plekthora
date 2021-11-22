	!zone PlayerShots
.size	=	12
	!align	.size - 1, 0
	
.xpos	!fill	.size
.ypos	!fill	.size
.cool	!byte	0, 0
.num	!byte	0

.Init
	lda	#0
	sta	.num
	lda	#0
	sta	.cool + 0
	sta	.cool + 1
	rts
	
.Remove
	ldy	.num
	dey
	lda	.xpos, y
	sta	.xpos, x
	lda	.ypos, y
	sta	.ypos, x
	sty	.num
	rts

; player index in x, cooling in y
	
.Add
	lda	.cool, x
	bne	.cooling
	
	tya
	
	ldy	.num
	cpy	#.size
	bcs	.cooling
	
	sta	.cool, x
	
	lda	Player.yposh, x
	sec
	sbc	#20
	sta	.ypos, y
	lda	Player.xposh, x
	sec
	sbc	#4
	lsr
	lsr
	sta	.xpos, y
	iny
	sty	.num
	
	lda	#Sound.SOFShot
	jsr	Sound.QueueEffect
	
.cooling	
	rts

; player index in x, cooling in y

.Add2
	lda	.cool, x
	bne	.cooling
	
	tya
	
	ldy	.num
	cpy	#.size
	bcs	.cooling

	sta	.cool, x
	
	lda	Player.yposh, x
	sec
	sbc	#22
	sta	.ypos, y
	lda	Player.xposh, x
	sec
	sbc	#4
	lsr
	lsr
	sta	.xpos, y

	iny
	cpy	#.size
	bcs	.full2
	
	lda	Player.yposh, x
	sec
	sbc	#18
	sta	.ypos, y
	lda	Player.xposh, x
	sec
	sbc	#4
	lsr
	lsr
	sta	.xpos, y
	iny
.full2
	sty	.num

	lda	#Sound.SOFShot
	jsr	Sound.QueueEffect

.unone	rts
	

.Update
	lda	Player.index
	beq	+
	rts
+

	ldy	.num
	beq	.unone
	dey
	
.uloop	ldx	Enemies.head
	bmi	.uempty
	
	lda	.ypos, y
	clc
	adc	#25
	sta	tmpy
	
	lda	.xpos, y
	asl
	asl
	sta	tmpx
	
	sec
.eloop	

; we know carry is set at this point
; x check first, least number of cycles, due to known width

	lda	Enemies.xposh,x
	sbc	tmpx
	cmp	#12
	bcc	.ehitx
	
.emiss
	lda	Enemies.succ,x
	tax
	bpl	.eloop
	
.uempty
	dey
	bpl	.uloop
.dnone	rts

.ehitx
	lda	tmpy
	sbc	Enemies.yposh,x
	cmp	Enemies.ysize,x
	bcs	.emiss

; most enemies are hit by a shot, so we check this last

.ehit
	lda	Enemies.sflags, x
	bpl	.emiss

	and	#Enemies.SFExplodes
	beq	+

	lda	#2
	jsr	Enemies.Explode
	jmp	++
+
	lda	#Sound.SOFDing
	jsr	Sound.QueueEffect
++

	tya
	tax
	
	lda	.ypos,x
	lsr
	lsr
	tay
	lda	CharLinesL, y
	sta	tmpl
	lda	CharLinesH, y
	sta	tmph
	ldy	.xpos, x
	lda	#112
	sta	(tmpl), y
	lda	#$90
	eor	tmph
	sta	tmph
	lda	#15
	sta	(tmpl), y

	jsr	.Remove
	
	txa
	tay
	
	dey
	bpl	.uloop
	rts
	
	
.Draw
	lda	Player.index
	bne	.ddone

	ldx	.num
	beq	.ddone
	dex
	
.dloop	lda	.ypos , x
	lsr
	lsr
	tay
	lda	CharLinesL, y
	sta	tmpl
	sta	tmpml
	lda	CharLinesH, y
	sta	tmph
	eor	#$90
	sta	tmpmh
	
	lda	Starfield.LineColors, y
	ldy	.xpos, x
	
	sta	(tmpml), y
	lda	#112
	sta	(tmpl), y
	
	iny
	cpy	#40
	beq	.done
	tya	
	sta	.xpos, x

	lda	#1
	sta	(tmpml), y
	lda	.ypos, x
	and	#3
	ora	#136
	sta	(tmpl), y

	dex
	bpl	.dloop

.ddone
	ldx	Player.index
	ldy	.cool, x
	beq	+
	dey
	tya
	sta	.cool, x
+
	rts
	
.done
	jsr	.Remove
	dex
	bpl	.dloop
	bmi	.ddone
	
	
	!zone PlayerLaser
	
.xpos	!byte	0, 0
.ypos	!byte	0, 0
.size	!byte	0, 0
.pxpos	!byte	0, 0
.pypos	!byte	0, 0
.psize	!byte	0, 0
.phase	!byte	0, 0
.cool	!byte	0, 0

.Init
	lda	#0
	sta	.phase + 0
	sta	.phase + 1
	sta	.psize + 0
	sta	.psize + 1
	rts
	
	; y : Cool, a : Phase, x : PlayerID 
	
.Fire
	pha
	
	lda	.cool, x
	bne	.cooling
	
	lda	#0
	sta	.size, x
	sta	.psize, x
	
	tya
	sta	.cool, x
	
	pla
	ldy	.phase, x
	sta	.phase, x
	
	bne	+
	
	lda	#Sound.SOFLaser
	jsr	Sound.QueueEffect
+
	rts
	
.cooling
		
	pla
	rts
	
	; x : PlayerID
.Release
	lda	.phase, x
	cmp	#3
	bcc	+
	lda	#3
	sta	.phase, x
+
	rts

.Update
	ldx	Player.index
	
	lda	.phase, x
	bne	++

	lda	.cool, x
	beq	+
	dec	.cool, x
+

	lda	#0
	sta	.size, x
	rts
	
++
	lda	Player.yposh, x
	sec
	sbc	#20
	sta	.ypos, x
	lda	Player.xposh, x
	sec
	sbc	#4
	lsr
	lsr
	sta	.xpos, x

	dec	.phase, x

	lda	#166
	sta	.size, x
	lda	#$ff
	sta	tmp
	
	ldx	Enemies.head
	bmi	.eempty
	
	ldy	Player.index
	
	lda	.ypos, y
	clc
	adc	#25
	sta	tmpy
	
	lda	.xpos, y
	asl
	asl
	sta	tmpx
	
	sec
.eloop	

	lda	tmpy
	sbc	Enemies.yposh,x
	cmp	Enemies.ysize,x
	bcs	.emiss

	lda	Enemies.sflags, x
	bpl	.emiss

	lda	Enemies.xposh,x
	cmp	tmpx
	bcc	.emiss
	
	cmp	.size, y
	bcs	.emiss

	stx	tmp
	ldy	Player.index
	sta	.size, y
	
.emiss
	lda	Enemies.succ,x
	tax
	bpl	.eloop

	ldx	tmp
	bmi	.eempty
	
	lda	Enemies.sflags, x
	and	#Enemies.SFExplodes
	beq	.eempty
	
	lda	#1
	jsr	Enemies.Explode

.eempty
	ldy	Player.index
	lda	.size, y
	sec
	sbc	#6
	lsr
	lsr
	sta	.size, y
		
	rts

.PhaseColor	!byte	0, 2, 7, 1, 14, 6, 14, 1, 14, 6, 14, 1, 14, 6, 14, 1, 14, 6, 14, 1, 14, 6, 14, 1

.Draw
	ldx	Player.index
	
	lda	.psize, x
	bne	.dprev
	lda	.size, x
	beq	.dnone

; New laser or a new laser line
	
.ddraw
	lda	.ypos, x
	lsr
	lsr
	sta	.pypos, x
	tay
	
	clc
	lda	.xpos, x
	sta	.pxpos, x
	adc	CharLinesL, y
	sta	tmpl
	sta	tmpml
	
	lda	CharLinesH, y
	adc	#0
	sta	tmph
	eor	#$90
	sta	tmpmh

	ldy	.phase, x
	lda	.PhaseColor, y
	sta	tmp
	
	clc
	lda	.size, x
	sta	.psize, x
	sbc	.xpos, x
	bcc	.dnone
	tay

	lda	.ypos, x
	and	#3
	ora	#136
	sta	tmpx
-
	lda	tmp
	sta	(tmpml), y
	lda	tmpx
	sta	(tmpl), y
	dey
	bpl	-
	
.dnone	rts


; we have to clear something+

.dprev
	ldy	.pypos, x
	clc
	lda	.pxpos, x
	adc	CharLinesL, y
	sta	tmpl
	sta	tmpml
	lda	CharLinesH, y
	adc	#0
	sta	tmph
	eor	#$90
	sta	tmpmh
	lda	Starfield.LineColors, y
	sta	tmp
	
; new and old laser, check for same line

;	lda	.ypos
;	lsr
;	lsr
;	cmp	.pypos
;	beq	.dsamey
	
; new and old laser but different line

	clc
	lda	.psize, x
	sbc	.pxpos, x
	bcc	+
	tay
-
	lda	#112
	sta	(tmpl), y
	lda	tmp
	sta	(tmpml), y
	dey
	bpl	-

+
	jmp	.ddraw

; new and old laser, but same line
	
.dsamey
	
; no new laser, so clear the old one and be done
	
.dclear
	
	lda	.pxpos, x
	cmp	.psize, x
	bcs	.dfinal
	tay
	lda	.psize, x
	sta	tmpy
	
-
	lda	#112
	sta	(tmpl), y
	lda	tmp
	sta	(tmpml), y
	iny
	cpy	tmpy
	bcc	-
	
.dfinal
	lda	#0
	sta	.psize, x
	rts
	

	!zone 	PlayerFlame
		
.xpos	!byte	0, 0
.ypos	!byte	0, 0
.pxpos	!byte	0, 0
.pypos	!byte	0, 0
.phase	!byte	0, 0

.Init
	lda	#0
	sta	.phase + 0
	sta	.phase + 1
	lda	#$ff
	sta	.pypos + 0
	sta	.pypos + 1
	rts
	
; a : increment, x : player ID

.Fire
	ldy	.phase, x
	bpl	+
	rts

+	
	clc
	adc	.phase, x
	cmp	#$2f
	bcc	+
	lda	#$2f
+
	sta	.phase, x
	
	lda	Player.yposh, x
	sec
	sbc	#22
	sta	.ypos, x

	lda	Player.xposh, x
	clc
	adc	#2
	lsr
	lsr
	sta	.xpos, x
	rts

;  x : playwerID
.Release
	lda	.phase, x
	bmi	+
	beq	+

	ora	#$80
	sta	.phase, x
	
	lda	#Sound.SOFFlame
	jsr	Sound.QueueEffect
+	
	rts

.Clear
	ldx	Player.index
	
	lda	.pypos, x
	bmi	+
	lsr
	lsr
	tay
	lda	CharLinesL, y
	sta	tmpl
	sta	tmpml
	lda	CharLinesH, y
	sta	tmph
	eor	#$90
	sta	tmpmh
	lda	Starfield.LineColors, y
	sta	tmpu
	lda	Starfield.LineColors + 1, y
	sta	tmpv

	
	ldy	.pxpos, x
	
	lda	#112
	sta	(tmpl),y
	iny
	sta	(tmpl),y
	iny
	sta	(tmpl),y
	lda	tmpu
	sta	(tmpml),y
	dey
	sta	(tmpml),y
	dey
	sta	(tmpml),y
	
	tya
	clc
	adc	#40
	tay
	
	lda	#112
	sta	(tmpl),y
	iny
	sta	(tmpl),y
	iny
	sta	(tmpl),y
	lda	tmpv
	sta	(tmpml),y
	dey
	sta	(tmpml),y
	dey
	sta	(tmpml),y
	
	lda	#$ff
	sta	.pypos, x
+
	rts

.FlameColor	!byte	$02, $08, $07, $01, $07, $08, $02, $0D
	
.Draw
	jsr	.Clear
	
	lda	.phase, x
	bne	+
	rts
+
	and	#$7f
	sta	tmpx
	
	lda	Phase, x
	and	#7
	tay
	lda	.FlameColor, y
	sta	tmpu
	
	lda	.ypos, x
	sta	.pypos, x
	lsr
	lsr
	tay
	lda	CharLinesL, y
	sta	tmpl
	sta	tmpml
	lda	CharLinesH, y
	sta	tmph
	eor	#$90
	sta	tmpmh
	
	lda	.xpos, x
	sta	.pxpos, x
	tay

	lda	.ypos, x
	and	#3
	asl
	asl
	asl
	asl
	asl
	
	ldx	tmpx
		
	cpx	#$10
	bcs	+
	ora	#$86
	sta	(tmpl),y
	tax
	lda	tmpu
	sta	(tmpml),y
	tya
	clc
	adc	#40
	tay
	lda	tmpu
	sta	(tmpml),y
	txa
	ora	#$10
	sta	(tmpl),y
	rts
+
	cpx	#$20
	bcs	+
	ora	#$84
	sta	(tmpl),y
	iny
	ora	#$01
	sta	(tmpl),y
	tax
	lda	tmpu
	sta	(tmpml),y
	dey
	sta	(tmpml),y
	tya
	clc
	adc	#41
	tay
	lda	tmpu
	sta	(tmpml),y
	dey
	sta	(tmpml),y	
	txa
	eor	#$11
	sta	(tmpl),y
	iny
	ora	#$01
	sta	(tmpl),y
	rts
+
	ora	#$81
	sta	(tmpl),y
	iny
	eor	#$03
	sta	(tmpl),y
	iny
	ora	#$01
	sta	(tmpl),y
	tax
	lda	tmpu
	sta	(tmpml),y
	dey
	sta	(tmpml),y
	dey
	sta	(tmpml),y
	tya
	clc
	adc	#42
	tay
	lda	tmpu
	sta	(tmpml),y
	dey
	sta	(tmpml),y
	dey
	sta	(tmpml),y
	txa
	eor	#$12
	sta	(tmpl),y
	iny
	eor	#$03
	sta	(tmpl),y
	iny
	ora	#$01
	sta	(tmpl),y
	rts
	
	
.Update
	ldy	Player.index
	
	lda	.phase, y
	bmi	+
	rts
	
+	
	ldx	.xpos, y
	inx
	cpx	#38
	bcs	.efinish
	txa
	sta	.xpos, y
		
	ldx	Enemies.head
	bmi	.uempty
	
	lda	.ypos, y
	clc
	adc	#25
	sta	tmpy
	
	lda	.xpos, y
	asl
	asl
	sta	tmpx
	
	sec
.eloop	

; we know carry is set at this point
; x check first, least number of cycles, due to known width

	lda	Enemies.xposh,x
	sbc	tmpx
	cmp	#12
	bcc	.ehitx
	
.emiss
	lda	Enemies.succ,x
	tax
	bpl	.eloop
	
.uempty
.dnone	rts

.ehitx	clc
	lda	Enemies.ysize, x
	adc	#4
	sta	tmps	
	clc
	lda	Enemies.ysize, x
	adc	Enemies.yposh,x
	sec
	sbc	tmpy
	cmp	tmps
	bcs	.emiss

; most enemies are hit by a shot, so we check this last

.ehit
	lda	Enemies.sflags, x
	bpl	.emiss

	and	#Enemies.SFExplodes
	beq	+
	
	lda	Enemies.hits, x
	pha
	
	ldy	Player.index
	lda	.phase, y
	and	#$7f
	jsr	Enemies.Explode
	
	pla
	!byte	$2C	;	skip load
+
	lda	#1
	
	ldy	Player.index
	eor	#$ff
	sec
	adc	.phase, y
	bpl	.efinish
	sta	.phase, y
	
	rts
		
.efinish
	ldy	Player.index
	lda	#0
	sta	.phase, y
	rts
	

	!zone	PlayerWeapon

.WTNone		=	0
	
.WTType		=	$f0
.WTLevel	=	$0f

.WTSlug		=	$10
.WTSlug1	=	.WTSlug + 0
.WTSlug2	=	.WTSlug + 1
.WTSlug3	=	.WTSlug + 2
.WTSlug4	=	.WTSlug + 3

.WTLaser	=	$20
.WTLaser1	=	.WTLaser + 0
.WTLaser2	=	.WTLaser + 1
.WTLaser3	=	.WTLaser + 2
.WTLaser4	=	.WTLaser + 3

.WTFlame	=	$30
.WTFlame1	=	.WTFlame + 0
.WTFlame2	=	.WTFlame + 1
.WTFlame3	=	.WTFlame + 2
.WTFlame4	=	.WTFlame + 3
	
	
.level		!byte	0, 0
.type		!byte	0, 0

.Init
	jsr	PlayerShots.Init
	jsr	PlayerLaser.Init
	jsr	PlayerFlame.Init

	lda	#.WTSlug
	ldx	#0
	jsr	.Select
	ldx	#1
	jsr	.Select
	
	rts

	; player ID in X
.Select
	pha
	lda	#0
	jsr	PlayerFlame.Release
	pla
	
	pha
	and	#$0f
	sta	.level, x
	pla
	and	#$f0
	sta	.type, x
	rts
	
.laserphase	!byte	4, 4, 11, 11
.lasercool	!byte	13, 9, 13, 9

.Fire
	ldx	Player.index
	lda	.type, x
	cmp	#.WTSlug
	beq	.FireSlug
	cmp	#.WTLaser
	beq	.FireLaser
	
.FireFlame
	lda	Input.button, x
	beq	+
	jmp	PlayerFlame.Release
+
	lda	.level, x
	clc
	adc	#1
	jmp	PlayerFlame.Fire
	
.FireLaser
	lda	Input.button, x
	beq	+
	jmp	PlayerLaser.Release
+
	ldy	.level, x
	lda	.laserphase, y
	pha
	lda	.lasercool, y
	tay
	pla
	
	jmp	PlayerLaser.Fire
	
.FireSlug
	lda	Input.button, x
	beq	+
	
	lda	#0
	sta	PlayerShots.cool, x
	rts
+
	ldy	#13
	lda	.level, x
	and	#1
	beq	+
	ldy	#9
+
	lda	.level, x
	and	#2
	bne	+	
	jmp	PlayerShots.Add
+
	jmp	PlayerShots.Add2
	
		
.Update
	jsr	PlayerShots.Update
	jsr	PlayerLaser.Update
	jsr	PlayerFlame.Update
	rts
	
.Draw
	jsr	PlayerShots.Draw
	jsr	PlayerLaser.Draw
	jsr	PlayerFlame.Draw
	rts
	
