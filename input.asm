!zone	Input	
.dx		!byte	0, 0
.dy		!byte	0, 0
.pdx		!byte	0, 0
.pdy		!byte	0, 0
.button		!byte	0, 0
.matrix		!fill	8
.pmatrix	!fill	8
.key		!byte	0
.pkey		!byte	0

.keycodes	!text	"........"
		!text	"3wa4zse."
		!text	"5rd6cftx"
		!text	"7yg8bhuv"
		!text	"9ij0mkon"
		!text	"+pl-.:@,"
		!text	".*;..=^/"
		!text	"1..2 .q "
	
.Scan

; First Joystick

	lda	.dx
	sta	.pdx
	lda	.dx + 1
	sta	.pdx + 1
	lda	.dy
	sta	.pdy
	lda	.dy + 1
	sta	.pdy + 1
	
	lda	$dc00
	ldy	#0
	lsr
	bcs	+
	dey
+	lsr
	bcs	+
	iny
+	sty	.dy + 0
	ldy	#0
	lsr
	bcs	+
	dey
+	lsr
	bcs	+
	iny
+	and	#1
	sty	.dx + 0
	sta	.button + 0

; Second Joystick

	lda	$dc01
	ldy	#0
	lsr
	bcs	+
	dey
+	lsr
	bcs	+
	iny
+	sty	.dy + 1
	ldy	#0
	lsr
	bcs	+
	dey
+	lsr
	bcs	+
	iny
+	and	#1
	sty	.dx + 1
	sta	.button + 1

; Keyboard

	lda	.matrix+0
	sta	.pmatrix+0
	lda	.matrix+1
	sta	.pmatrix+1
	lda	.matrix+2
	sta	.pmatrix+2
	lda	.matrix+3
	sta	.pmatrix+3
	lda	.matrix+4
	sta	.pmatrix+4
	lda	.matrix+5
	sta	.pmatrix+5
	lda	.matrix+6
	sta	.pmatrix+6
	lda	.matrix+7
	sta	.pmatrix+7
	
	ldx 	#$ff
	stx 	$dc02
	ldy 	#$00
	sty	.key
	
	; avoid joystick pollution
	cpx	$dc01
	bne	.nokeys
	
	sty 	$dc03

	; check all keys
    	sty 	$dc00
    	cpx 	$dc01
	bne	.haskeys
	
.nokeys
	sty	.pkey
	stx	.matrix+0
	stx	.matrix+1
	stx	.matrix+2
	stx	.matrix+3
	stx	.matrix+4
	stx	.matrix+5
	stx	.matrix+6
	stx	.matrix+7
    	stx	$dc00

	rts
	
.haskeys
	lda	#$fe
	sec
	
	sta 	$dc00
    	ldy 	$dc01
	sty	.matrix+0
	rol

	sta 	$dc00
    	ldy 	$dc01
    	sty 	.matrix+1
	rol

	sta 	$dc00
    	ldy 	$dc01
    	sty 	.matrix+2
	rol

	sta 	$dc00
    	ldy 	$dc01
    	sty 	.matrix+3
	rol

	sta 	$dc00
    	ldy 	$dc01
    	sty 	.matrix+4
	rol

	sta 	$dc00
    	ldy 	$dc01
    	sty 	.matrix+5
	rol

	sta 	$dc00
    	ldy 	$dc01
	sty	.matrix+6
	rol
	
	sta 	$dc00
   	ldy	$dc01
    	sty	.matrix+7
	rol

    	stx	$dc00
	
	ldy	#0
-
	lda	.matrix, y
	eor	#$ff
	and	.pmatrix, y
	bne	+
	iny
	cpy	#8
	bne	-
	
	rts
+
	tax
	tya
	asl
	asl
	asl
	tay
	txa
-	iny
	lsr
	bcc	-
	dey
	lda	.keycodes, y
	sta	.key
	sta	.pkey

	rts


	