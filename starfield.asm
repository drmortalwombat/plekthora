
!zone	Starfield

.lines		=	16
.stars		=	3
.size		=	.lines * .stars
.xpos		= 	$e800
.xlow		=	.xpos + .size
.xvel		=	.xlow + .size

.scroll		!byte	0
.scroll1	!byte	0
.scroll2	!byte	0
.scroll3	!byte	0
.floori1	!byte	0
.floori2	!byte	0

.textp		!word	0
.textn		!word	0

.sloot		=	4
.nloot		!byte	0
.lootx		!fill	.sloot
.looty		!fill	.sloot
.lootp		!byte	0

.LineColors	!byte	1, 1, 14, 1, 15, 15, 7, 1, 15, 15, 1, 7, 14, 1, 15, 1, 15, 1, 7, 3

.copyrows1	=	$f000
.copyrows2	=	$f200
.copyrows3	=	$f400
.DrawStars	=	$f500
; to $fbff


.buildcopy
	lda	CharLinesL, y
	sta	tmpml
	lda	CharLinesH, y
	sta	tmpmh
	
	ldx	#0
	ldy	#0
-
	lda	#$ad
	sta	(tmpl), y
	iny

	sec
	txa
	adc	tmpml
	sta	(tmpl), y
	iny
	lda	#0
	adc	tmpmh
	sta	(tmpl), y
	iny
		
	lda	#$8d
	sta	(tmpl), y
	iny

	clc
	txa
	adc	tmpml
	sta	(tmpl), y
	iny
	lda	#0
	adc	tmpmh
	sta	(tmpl), y
	iny	
	inx
	cpx	#39
	bcc	-
	tya
	clc
	adc	tmpl
	sta	tmpl
	bcc	+
	inc	tmph
+	rts
	
.BlackStars
	ldx	#1
--	lda	CharLinesL, x
	sta	tmpl
	lda	CharLinesH, x
	eor	#$90
	sta	tmph
	lda	#0
	ldy	#0
-	sta	(tmpl),y
	iny
	cpy	#40
	bne	-
	inx
	cpx	#20
	bne	--	
	rts
	
.ColorStars
	ldx	#1
--	lda	CharLinesL, x
	sta	tmpl
	lda	CharLinesH, x
	eor	#$90
	sta	tmph
	lda	.LineColors, x
	ldy	#0
-	sta	(tmpl),y
	iny
	cpy	#40
	bne	-
	inx
	cpx	#20
	bne	--	
	rts
	
.ClearStars
	ldx	#1
--	lda	CharLinesL, x
	sta	tmpl
	lda	CharLinesH, x
	sta	tmph
	lda	#112
	ldy	#0
-	sta	(tmpl),y
	iny
	cpy	#40
	bne	-
	inx
	cpx	#20
	bne	--	
	rts



.Init
	ldx	#0
-
	jsr	Random.rand
	and	#$3f
	cmp	#40
	bcs	-	
	sta	.xpos, x
	jsr	Random.rand	
	sta	.xlow, x
	jsr	Random.rand
	and	#$7f
	adc	#$20
	sta	.xvel, x
	inx
	cpx	#.size
	bne	-

	ldx	#0
-
	lsr	.xvel, x
	lsr	.xvel, x
	inx
	lsr	.xvel, x
	inx
	inx
	
	cpx	#.size
	bne	-

	lda	#<.copyrows1
	sta	tmpl
	lda	#>.copyrows1
	sta	tmph
	
	ldy	#22
	jsr	.buildcopy
	ldy	#23
	jsr	.buildcopy
	
	ldy	#0
	lda	#$60
	sta	(tmpl),y
	
	lda	#<.copyrows2
	sta	tmpl
	lda	#>.copyrows2
	sta	tmph

	ldy	#20
	jsr	.buildcopy
	ldy	#21
	jsr	.buildcopy
	
	ldy	#0
	lda	#$60
	sta	(tmpl), y
	
	lda	#<.copyrows3
	sta	tmpl
	lda	#>.copyrows3
	sta	tmph

	ldy	#24
	jsr	.buildcopy
	
	ldy	#0
	lda	#$60
	sta	(tmpl), y

	lda	#0
	jsr	.BuildStarLines
	
	lda	#$00
	ldx	#$00
-
	sta	Screen + $000, x
	sta	Screen + $100, x
	sta	Screen + $200, x
	sta	Screen + $300, x
	inx
	bne	-
	
	lda	#15
-
	sta	Color + $000, x
	sta	Color + $100, x
	sta	Color + $200, x
	sta	Color + $300, x
	inx
	bne	-
	
	jsr	.ClearStars
	jsr	.ColorStars
	
	ldx	#0
-	
	lda	#9
	sta	Color + 20 * 40, x
	sta	Color + 21 * 40, x
	lda	#9
	sta	Color + 22 * 40, x
	lda	#11
	sta	Color + 23 * 40, x
	lda	#1
	sta	Color + 24 * 40, x
	
	jsr	.drawfloor1
	jsr	.drawfloor2
	
	inx
	cpx	#40
	bne	-
	
	lda	#0
	sta	.nloot
	
	sta	.textp + 0
	sta	.textp + 1
	sta	.textn + 0
	sta	.textn + 1
	
	rts

.Reset
	lda	#0
	sta	.nloot
	
	sta	.textp + 0
	sta	.textp + 1
	sta	.textn + 0
	sta	.textn + 1

	rts
	
; queue text in a/y

.QueueText
	sta	.textn + 0
	sty	.textn + 1
	
	lda	.textp + 1
	bne	+
	lda	.textn + 0
	sta	.textp + 0
	sty	.textp + 1
	lda	#0
	sta	.textn + 1
+	
	rts

; star is in x, tmpx selectes backcheck
.BuildStarLine
	ldy	#0
	
	; ldy starfield.xpos
	lda	#$ac
	sta	(tmpl),y
	iny
	txa
	sta	(tmpl),y
	iny
	lda	#>Starfield.xpos
	sta	(tmpl), y
	iny
	
	; lda starfield.xlow	
	lda	#$ad
	sta	(tmpl),y
	iny
	txa
	clc
	adc	#Starfield.xlow - Starfield.xpos
	sta	(tmpl),y
	iny
	lda	#>Starfield.xpos
	sta	(tmpl), y
	iny
	
	; sec
	lda	#$38
	sta	(tmpl),y
	iny
	
	; sbc starfield.xvel
	lda	#$ed
	sta	(tmpl),y
	iny
	txa
	clc
	adc	#Starfield.xvel - Starfield.xpos
	sta	(tmpl),y
	iny
	lda	#>Starfield.xpos
	sta	(tmpl), y
	iny

	; sta starfield.xlow	
	lda	#$8d
	sta	(tmpl),y
	iny
	txa
	clc
	adc	#Starfield.xlow - Starfield.xpos
	sta	(tmpl),y
	iny
	lda	#>Starfield.xpos
	sta	(tmpl), y
	iny

	bit	tmpx
	bpl	+

	; tax
	lda	#$aa
	sta	(tmpl),y
	iny

+	
	; bcs .same
	lda	#$b0
	sta	(tmpl),y
	iny
	
	lda	#16
	bit	tmpx
	bpl	+
	lda	#20
+
	
	sta	(tmpl),y
	iny

	bit	tmpx
	bmi	+
	
	; tax
	lda	#$aa
	sta	(tmpl),y
	iny
	
	bne	++
+
	
	; lda screen, y		
	lda	#$b9
	sta	(tmpl),y
	iny
	lda	tmpml
	sta	(tmpl),y
	iny
	lda	tmpmh
	sta	(tmpl),y
	iny
	
	; and #$0f
	lda	#$29
	sta	(tmpl),y
	iny
	lda	#$0f
	sta	(tmpl),y
	iny
	
	; bne + 5
	
	lda	#$d0
	sta	(tmpl),y
	iny
	lda	#$05
	sta	(tmpl),y
	iny
	
++
	; lda #112
	lda	#$a9
	sta	(tmpl),y
	iny
	lda	#112
	sta	(tmpl),y
	iny

	; sta screen, y	
	lda	#$99
	sta	(tmpl),y
	iny
	lda	tmpml
	sta	(tmpl),y
	iny
	lda	tmpmh
	sta	(tmpl),y
	iny
		
	; dey
	lda	#$88
	sta	(tmpl),y
	iny
	
	; bpl .same
	lda	#$10
	sta	(tmpl),y
	iny
	lda	#2
	sta	(tmpl),y
	iny
	
	; ldy #39
	lda	#$a0
	sta	(tmpl),y
	iny
	lda	#39
	sta	(tmpl),y
	iny

	; .samec
	; sty starfield.xpos
	lda	#$8c
	sta	(tmpl),y
	iny
	txa
	sta	(tmpl),y
	iny
	lda	#>Starfield.xpos
	sta	(tmpl), y
	iny

	bit	tmpx
	bpl	++

	; lda screen, y		
	lda	#$b9
	sta	(tmpl),y
	iny
	lda	tmpml
	sta	(tmpl),y
	iny
	lda	tmpmh
	sta	(tmpl),y
	iny
	
	; and #$0f
	lda	#$29
	sta	(tmpl),y
	iny
	lda	#$0f
	sta	(tmpl),y
	iny
	
	; bne + 8
	
	lda	#$d0
	sta	(tmpl),y
	iny
	lda	#$08
	sta	(tmpl),y
	iny

++

	; txa
	lda	#$8a
	sta	(tmpl),y
	iny

	; sec
	lda	#$38
	sta	(tmpl),y
	iny
	
	; .same
	; ror
	lda	#$6a
	sta	(tmpl),y
	iny
	
	; and #$f0
	lda	#$29
	sta	(tmpl),y
	iny
	lda	#$f0
	sta	(tmpl),y
	iny
	
	; sta screen, y	
	lda	#$99
	sta	(tmpl),y
	iny
	lda	tmpml
	sta	(tmpl),y
	iny
	lda	tmpmh
	sta	(tmpl),y
	iny
	
	tya
	clc
	adc	tmpl
	sta	tmpl
	lda	tmph
	adc	#0
	sta	tmph
	rts

.BuildStarLines
	sta	tmpx
	
	lda	#<.DrawStars
	sta	tmpl
	lda	#>.DrawStars
	sta	tmph
	
	lda	CharLinesL + 2
	sta	tmpml
	lda	CharLinesH + 2
	sta	tmpmh
	
	ldx	#0
-
	jsr	.BuildStarLine
	inx
	jsr	.BuildStarLine
	inx
	jsr	.BuildStarLine
	inx		
	
	clc
	lda	tmpml
	adc	#40
	sta	tmpml
	lda	tmpmh
	adc	#0
	sta	tmpmh
	
	cpx	#3 * .lines
	bne	-
	
	ldy	#0
	lda	#$60
	sta	(tmpl), y
	
	rts


!if 0 {
.DrawStars
	jsr	.drawstars
	ldx	#0

-
	lda	CharLinesL + 2, x
	sta	tmpl
	lda	CharLinesH + 2, x
	sta	tmph
	
	!for ti=0 to .stars - 1
		ldy	Starfield.xpos + (ti * Starfield.lines),x
		lda	Starfield.xlow + (ti * Starfield.lines),x
		sec
		sbc	Starfield.xvel + (ti * Starfield.lines),x
		sta	Starfield.xlow + (ti * Starfield.lines),x
		bcs	.same
		
		lda	#0
		sta	(tmpl),y
		dey
		bpl	.samec
		ldy	#39		

	.samec	tya
		sta	Starfield.xpos + (ti * Starfield.lines),x
		lda	Starfield.xlow + (ti * Starfield.lines),x
		sec
	.same
		ror
		and	#$f0
;		ora	#$80
		sta	(tmpl), y
	!end
	
	inx
	cpx	#.lines
	bne	-
	dec	$d020
	rts
}
	
!if 0 {
.DrawBackStars
	ldx	#0

-
	lda	CharLinesL + 2, x
	sta	tmpl
	lda	CharLinesH + 2, x
	sta	tmph
	
	!for ti=0 to .stars - 1
		ldy	Starfield.xpos + (ti * Starfield.lines),x
		lda	Starfield.xlow + (ti * Starfield.lines),x
		sec
		sbc	Starfield.xvel + (ti * Starfield.lines),x
		sta	Starfield.xlow + (ti * Starfield.lines),x
		bcs	.bsame
		
		lda	(tmpl),y
		and	#$0f
		bne	.sb1
		sta	(tmpl),y
	.sb1		
		dey
		bpl	.bsamec
		ldy	#39		

	.bsamec	tya
		sta	Starfield.xpos + (ti * Starfield.lines),x
	.bsame
		lda	(tmpl), y
		and	#$0f
		bne	.sb2
		lda	Starfield.xlow + (ti * Starfield.lines),x
		sec
		ror
		and	#$f0
		sta	(tmpl), y
	.sb2
	!end
	
	inx
	cpx	#.lines
	beq	+
	jmp	-
+	rts
}

.AddLoot
	ldx	.nloot
	cpx	#.sloot
	bcs	++
	sta	.lootx, x
	tya
	bne	+
	lda	#1
+
	cmp	#19
	bcc	+
	lda	#19
+
	sta	.looty, x
	inx
	stx	.nloot
++
	rts
	
.CheckLoot
	lda	CharLinesL, x
	sta	tmpl
	lda	CharLinesH, x
	sta	tmph
	lda	(tmpl),y
	and	#$f8
	cmp	#168
	beq	++
	iny
	lda	(tmpl),y
	and	#$f8
	cmp	#168
	beq	++
	
	inx
	lda	#40
	lda	CharLinesL, x
	sta	tmpl
	lda	CharLinesH, x
	sta	tmph
	
	lda	(tmpl),y
	and	#$f8
	cmp	#168
	beq	++
	dey
	lda	(tmpl),y
	and	#$f8
	cmp	#168
	beq	++
	
	clc
	rts
	
++	lda	(tmpl),y
	and	#1
	beq	+
	dey
+
	lda	#112
	sta	(tmpl),y
	iny
	sta	(tmpl),y
	dey
	lda	tmph
	eor	#$90
	sta	tmph
	lda	.LineColors, x
	sta	(tmpl),y
	iny
	sta	(tmpl),y
	dey
	
	txa
	ldx	.nloot
-	cmp	.looty - 1, x
	bne	+
	pha
	tya
	cmp	.lootx - 1, x
	beq	++
	pla
+	dex
	bne	-
	rts
++
	pla
	ldy	.nloot
	lda	.looty - 1, y
	sta	.looty - 1, x
	lda	.lootx - 1, y
	sta	.lootx - 1, x
	dey
	sty	.nloot	
	
	jsr	Status.AddStar
	
	lda	#Sound.SOFStar
	jsr	Sound.QueueEffect
	
	sec
	rts
	

.DrawLoot
	ldx	.nloot
	bne	+
	rts
+

	lda	.lootp
	and	#3
	bne	++
	dec	.lootp

	ldx	.nloot
-	ldy	.looty - 1, x
	lda	CharLinesL, y
	sta	tmpl
	sta	tmpml
	lda	CharLinesH, y
	sta	tmph
	eor	#$90
	sta	tmpmh
	
	ldy	.lootx - 1, x
	beq	+
	dey
	tya
	sta	.lootx - 1, x
	lda	#174
	sta	(tmpl), y
	lda	#7
	sta	(tmpml), y
	
	iny
	lda	#175
	sta	(tmpl), y
	lda	#7
	sta	(tmpml), y
	iny
	lda	#112
	sta	(tmpl), y
	lda	.LineColors, x
	sta	(tmpml), y
	dex
	bne	-
	rts
+
	lda	#112
	sta	(tmpl), y
	iny
	sta	(tmpl), y
	
	ldy	.nloot	
	lda	.lootx - 1, y
	sta	.lootx - 1, x
	lda	.looty - 1, y
	sta	.looty - 1, x
	dec	.nloot
	
	dex	
	bne	-
	rts
++
	dec	.lootp
-
	ldy	.looty - 1, x
	lda	CharLinesL, y
	sta	tmpl
	lda	CharLinesH, y
	sta	tmph
	ldy	.lootx - 1, x
	lda	.lootp
	and	#3
	asl
	ora	#168
	sta	(tmpl), y
	iny
	ora	#1
	sta	(tmpl), y
	dex
	bne	-
	
	
.noloot
	rts

.drawfloor1
	jsr	.copyrows1
	
	lda	.floori1
	and	#$07
	ora	#232
	sta	Screen + 22 * 40 + 39
	ora	#16
	sta	Screen + 23 * 40 + 39
	inc	.floori1
	rts
	
.drawfloor2
	jsr	.copyrows2
	
	lda	.floori2
	sta	Screen + 20 * 40 + 39
	ora	#8
	sta	Screen + 21 * 40 + 39
	and	#$f7
	clc
	adc	#1
	sta	.floori2
	and	#8
	beq	++
	jsr	Random.rand
	and	#$30
	ora	#$08
	clc
	adc	.floori2
	cmp	#$60
	bcc	+
	sbc	#$60
+
	sta	.floori2
++
	rts

.drawfloor3
	jsr	.copyrows3
	
	lda	.textp + 1
	beq	++
	sta	tmph
	lda	.textp + 0
	sta	tmpl
	ldy	#0
	lda	(tmpl), y
	bne	+
	ldy	.textn + 1
	sty	.textp + 1
	ldy	.textn + 0
	sty	.textp + 0
	lda	#0
	sta	.textn + 1
	beq	++
+
	inc	.textp + 0
	bne	++
	inc	.textp + 1	
++
	and	#$3f
	tay
	lda	TextFontIndex, y
	
	sta	Screen + 24 * 40 + 39
	rts

.base = CharsetData + 248 * 8
.base2 = CharsetData + 232 * 8

.rolfloor1
	asl
	bcc	+
--	ldy	.base + 8 * 0, x
	cpy	#$80
	rol	.base + 8 * 7, x
	rol	.base + 8 * 6, x
	rol	.base + 8 * 5, x
	rol	.base + 8 * 4, x
	rol	.base + 8 * 3, x
	rol	.base + 8 * 2, x
	rol	.base + 8 * 1, x
	rol	.base + 8 * 0, x
+
-	inx
	asl
	bcs	--
	bne	-
	rts

.rorfloor1
	asl
	bcc	+
--	tay
	lda	.base2 + 8 * 7, x
	lsr
	ror	.base2 + 8 * 0, x
	ror	.base2 + 8 * 1, x
	ror	.base2 + 8 * 2, x
	ror	.base2 + 8 * 3, x
	ror	.base2 + 8 * 4, x
	ror	.base2 + 8 * 5, x
	ror	.base2 + 8 * 6, x
	ror	.base2 + 8 * 7, x
	tya
+
-	inx
	asl
	bcs	--
	bne	-
	rts
	
.rolmask	!byte	$7f, $03, $1d, $07, $2b, $17, $0d, $02
.rormask	!byte	$fc, $00, $00, $c0, $30, $00, $c0, $00
	
.DrawFloor
	inc	.scroll

	lda	.scroll
	clc
	adc	#3
	tax
	and	#7
	bne	.done1

	jsr	.drawfloor1
		
.done1
	lda	.scroll
	and	#7
	tax
	lda	.rolmask, x
	ldx	#0
	jsr	.rolfloor1

	lda	.scroll
	and	#7
	tax
	lda	.rormask, x
	ldx	#0
	jsr	.rorfloor1

	lda	.scroll
	and	#15
	bne	.done2

	jsr	.drawfloor2

.done2

	lda	.scroll
	clc
	adc	#1
	tax
	and	#3
	bne	.done3

	jsr	.drawfloor3

.done3

	lda	.scroll
	lsr
	and	#7
	eor	#7
	sta	.scroll1

	lda	.scroll
	clc
	adc	#3
	and	#7
	eor	#7
	sta	.scroll2

	lda	.scroll
	clc
	adc	#1
	and	#3
	asl
	eor	#6
	sta	.scroll3

	rts
	