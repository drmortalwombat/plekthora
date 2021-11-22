	!zone	BigFont
		
.chars	!byte	112, 216, 204, 220, 202, 218, 206, 222, 201, 217, 205, 221, 203, 219, 207, 223

	
.posx	!byte	0
.textl	!byte	0
.texth	!byte	0
.linesb	!fill	6 * 8

.linesb	=	$eb00
.linesc	=	$eb40
	
.scrollGlpyhs
	lda	.textl
	sta	.st1 + 1
	lda	.texth
	sta	.st1 + 2

	ldx	#0
.st1	lda	$ffff,x
	and	#$3f
	tay
	lda	TextFontIndex, y
	tay
	
	lda	Math.asl3, y
	sta	tmpl
	lda	Math.asr5, y
	and	#7
	ora	#>CharsetData
	sta	tmph
	
	ldy	#0
	lda	(tmpl), y
	sta	.linesb + 0 * 6, x
	iny
	lda	(tmpl), y
	sta	.linesb + 1 * 6, x
	iny
	lda	(tmpl), y
	sta	.linesb + 2 * 6, x
	iny
	lda	(tmpl), y
	sta	.linesb + 3 * 6, x
	iny
	lda	(tmpl), y
	sta	.linesb + 4 * 6, x
	iny
	lda	(tmpl), y
	sta	.linesb + 5 * 6, x
	iny
	lda	(tmpl), y
	sta	.linesb + 6 * 6, x
	
	inx
	cpx	#6
	bne	.st1

	lda	#7
	sta	tmpy
	
	lda	#<.linesb
	sta	.sts0 + 1
	sta	.sts1 + 1

	sec
	lda	CharLinesL + 7
	sbc	#216
	sta	.sts2 + 1
	sta	.sts3 + 1
	lda	CharLinesH + 7
	sbc	#0
	sta	.sts2 + 2
	sta	.sts3 + 2

	lda	.posx
	eor	#$07
	sta	.stj + 1
	
---
	ldx	#0	
	ldy	#216
		
.sts0	lda	.linesb, x
	inx
	sec
	rol	
.stj	bne	.stj1
	asl
	asl
	asl
	asl
	asl
	asl
	asl
.stj1
	sta	tmpu
	bcs	.ston
.stoff
	lda	#112
.sts2	sta	$ffff, y
	iny
	beq	++
	asl	tmpu
	bcc	.sts2
	beq	.sts1
.ston	
	lda	#223
.sts3	sta	$ffff, y
	iny
	beq	++
	asl	tmpu
	bcc	.stoff	
	bne	.sts3
	
.sts1	lda	.linesb, x
	inx
	sec
	rol	
	bne	.stj1
++
	
	clc
	lda	.sts2 + 1
	adc	#40
	sta	.sts2 + 1
	sta	.sts3 + 1
	bcc	+
	inc	.sts2 + 2
	inc	.sts3 + 2
+	
	clc
	lda	.sts0 + 1
	adc	#6
	sta	.sts0 + 1
	sta	.sts1 + 1
	dec	tmpy
	bne	---
	

	rts
	

	
	
	
	


.putGlyph
	and	#$3f
	tay
	lda	TextFontIndex, y
	tay
	lda	Math.asl3, y
	sta	.t1 + 1
	sta	.t2 + 1
	lda	Math.asr5, y
	and	#7
	ora	#>CharsetData
	sta	.t1 + 2
	sta	.t2 + 2
	
.loop	
.t1
	lda	$0000
	inc	.t1 + 1
	inc	.t1 + 1
	sta	tmps
	inc	.t2 + 1
.t2	
	lda	$0000
	inc	.t2 + 1
	sta	tmpt
	
	ldy	#0
-
	lda	#0
	asl	tmps
	rol
	asl	tmps
	rol
	asl	tmpt
	rol
	asl	tmpt
	rol
	tax
	lda	.chars, x
	sta	(tmpl), y
	iny
	cpy	#4
	bne	-
	
	clc
	lda	tmpl
	adc	#40
	sta	tmpl
	lda	tmph
	adc	#0
	sta	tmph
	
	lda	.t1 + 1
	and	#7
	bne	.loop
	
	sec
	lda	tmpl
	sbc	#156
	sta	tmpl
	lda	tmph
	sbc	#0
	sta	tmph
	rts

; set cursor to x, y
.SetCursor
	txa
	asl
	adc	#2
	adc	CharLinesL + 2, y
	sta	tmpl
	sta	tmpml
	lda	CharLinesH + 2, y
	adc	#0
	sta	tmph
	eor	#$90
	sta	tmpmh
	rts

.clearxline
	lda	CharLinesL + 2, x
	sta	tmpl
	sta	tmpml
	lda	CharLinesH + 2, x
	sta	tmph
	eor	#$90
	sta	tmpmh
	
	lda	#112
	ldy	#40
-	dey
	sta	(tmpl),y	
	bne	-

	lda	Starfield.LineColors, x
	ldy	#40
-	dey
	sta	(tmpml),y
	bne	-
	inx
	rts
	

.ClearLine
	jsr	.clearxline
	jsr	.clearxline
	jsr	.clearxline
	jmp	.clearxline

	
; draw a color in x
.DrawChar
	stx	tmpx
	jsr	.putGlyph

	rts
	
	ldx	#0
--	ldy	#0
	lda	tmpx
-	sta	(tmpml), y
	iny
	cpy	#4
	bne	-

	clc
	lda	tmpml
	adc	#40
	sta	tmpml
	lda	tmpmh
	adc	#0
	sta	tmpmh
	inx
	cpx	#4
	bne	--

	sec
	lda	tmpml
	sbc	#156
	sta	tmpml
	lda	tmpmh
	sbc	#0
	sta	tmpmh

	rts
	
; draw ay to .tmpl, color in x
.DrawText
	stx	tmpx
	sta	.t3 + 1
	sty	.t3 + 2
	ldy	#0
.loop1
.t3
	lda	$0000, y
	beq	.ddone
	
	sty	tmpy
	jsr	.putGlyph
	
	ldx	#0
--	ldy	#0
	lda	tmpx
-	sta	(tmpml), y
	iny
	cpy	#4
	bne	-

	clc
	lda	tmpml
	adc	#40
	sta	tmpml
	lda	tmpmh
	adc	#0
	sta	tmpmh
	inx
	cpx	#4
	bne	--

	sec
	lda	tmpml
	sbc	#156
	sta	tmpml
	lda	tmpmh
	sbc	#0
	sta	tmpmh

	
	ldy	tmpy
	iny
	jmp	.loop1
.ddone
	rts
	
	
	