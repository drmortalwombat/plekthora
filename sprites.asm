
!zone	Sprites
.size	=	32
.order	=	$20
.ordery	=	$41
.tmpx	=	$61
.tmpy	=	$62
.index	=	$63
.vsync	=	$64
.irqa	=	$65
.irqx	=	$66
.irqy	=	$67


.xposl	=	$e400
.xposh	=	.xposl + .size
.xmask	= 	.xposh + .size
.img	=	.xmask + .size
.color	=	.img + .size
.ypos	=	.color + .size
.total 	=	.ypos + .size + 1

!align	63, 0
.IRQJumpTable
.JInterruptFinal
	jmp	.InterruptFinal
.JInterrupt0
	jmp	.Interrupt0
.JInterrupt1
	jmp	.Interrupt1
.JInterrupt2
	jmp	.Interrupt2
.JInterrupt3
	jmp	.Interrupt3
.JInterrupt4
	jmp	.Interrupt4
.JInterrupt5
	jmp	.Interrupt5
.JInterrupt6
	jmp	.Interrupt6
.JInterrupt7
	jmp	.Interrupt7
.JInterruptSplit1
	jmp	.InterruptSplit1
.JInterruptSplit2
	jmp	.InterruptSplit2
.JInterruptSplit3
	jmp	.InterruptSplit3
	
.Init
	lda	#.size
	sta	.order + .size
	ldx	#0
	stx	.index
	stx	.ypos + .size
	
-
	lda	#$ff
	sta	.ypos, x
	txa
	sta	.order, x
	
	inx
	cpx	#.size
	bne	-

	lda	#>.IRQJumpTable
	sta	$ffff
	lda	#<.JInterruptFinal
	sta	$fffe

	rts
	
.Reset
	ldx	#0
-
	lda	#$ff
	sta	.ypos, x
	inx
	cpx	#.size
	bne	-
	
	rts
	
.Sort
	
;	inc	$d020
	
	ldx	#0
	ldy	.order
	lda	.ypos,y
.loop0a
	sta	.ordery, x
	inx
.loop0
	
	ldy	.order, x
	lda	.ypos,y
	cmp	.ordery - 1, x
	bcs	.loop0a
	
	cpx	#.size
	beq	.done0

.nsorted

	stx	.tmpx
	sty	.tmpy

	ldy	.ordery - 1, x
	sty	.ordery, x
	ldy	.order - 1, x
	sty	.order, x
	dex
	beq	.lsorted
	
.loop1
	cmp	.ordery - 1, x
	bcs	.lsorted
	ldy	.ordery - 1, x
	sty	.ordery, x
	ldy	.order - 1, x
	sty	.order, x
	dex
	bne	.loop1
	
.lsorted
	ldy	.tmpy
	sta	.ordery, x
	sty	.order, x
	ldx	.tmpx
	
	inx
	cpx	#Sprites.size
	bne	.loop0
	
.done0

	ldx	#0
	
	; sentinel
	lda	#255
	sta	.ordery + .size

	lda	.ordery + 8,x
	cmp	#$ff
	beq	.ldone2
.loop2
;	carry is cleared at this position
	sbc	#23
	cmp	.ordery,x
	bcc	+
	lda	.ordery,x
+
	adc	#20
	sta	.ordery, x
	inx
	lda	.ordery + 8,x
	cmp	#$ff
	bne	.loop2
.ldone2

	; ensure last switch point is not below mountain range
	
	cpx	#0
	beq	++
	
-	lda	.ordery - 1, x	
	cmp	#$cf
	bcc	+
	dex
	bne	-
+	lda	#$ff
++
	sta	.ordery, x

	

	
;	dec	$d020

	rts
	
.Prepare
	lda	#$00
	sta	.index

	!for i=0 TO 7
		ldx	Sprites.order + i
		ldy	Sprites.img, x
		sty	$4bf8 + i
		ldy	Sprites.color,x
		sty	$d027 + i
		ldy	Sprites.ypos,x
		sty	$d001 + 2 * i
		ldy	Sprites.xposl, x
		sty	$d000 + 2 * i

		ldy	Sprites.xposh, x
		beq	.skip1
		ora	#(1 << (i & 7))
.skip1		
	!end
	sta	$d010

	!for i=8 TO Sprites.size - 1
		ldx	Sprites.order + i
		and	#!(1 << (i & 7))
		ldy	Sprites.xposh, x
		beq	.skip2
		ora	#(1 << (i & 7))
.skip2		sta	Sprites.xmask, x
	!end

	lda	#$ff
	sta	$d015

	rts

	
	!macro	spupdate sn, snext, sirq
		
	ldy	Sprites.order + 8, x
	
	lda	Sprites.ypos, y
	sta	$d001 + 2 * sn

	lda	Sprites.xposl, y
	sta	$d000 + 2 * sn
		
	lda	Sprites.img,y
	sta	$4bf8 + sn

	lda	Sprites.color,y
	sta	$d027 + sn

	inx	
	
	lda	Sprites.ordery, x
	cmp	$d012
	
	bcc	snext
	stx	Sprites.index

	ldx	Sprites.xmask, y
	stx	$d010	

	adc	#1
	bcs	+

	asl	$d019

	sta	$d012

	ldx	#<sirq
	stx	$fffe

	ldy	Sprites.irqy
	ldx	Sprites.irqx
	lda	Sprites.irqa
	
!if Sprites.showirq {
	dec	$d020	
}
	rti

+	
	jmp	Sprites.InterruptLast
	!end

.showirq	=	0

.InterruptFinal

!if .showirq {
	inc	$d020
}
	sta	.irqa
	stx	.irqx
	sty	.irqy

	lda	#0
	sta	$d021
	sta	$d016	

	jsr	.Sort
	
!if .showirq {
	inc	$d020
}

	jsr	.Prepare

!if .showirq {
	dec	$d020
}

		
	lda	#$ff
	sta	.vsync

	lda	#$1b
	sta	$d011
	
	lda	.ordery
	ldx	#<.JInterrupt0
	
	jmp	.InterruptDone
		

.Interrupt0	
!if .showirq {
	inc	$d020
}
	sta	.irqa
	stx	.irqx
	sty	.irqy
	
	ldx	.index
.Update0
	+spupdate	0, .Update1, .JInterrupt1
	
.Interrupt1
!if .showirq {
	inc	$d020
}
	sta	.irqa
	stx	.irqx
	sty	.irqy
	
	ldx	.index
.Update1
	+spupdate	1, .Update2, .JInterrupt2
	
.Interrupt2
!if .showirq {
	inc	$d020
}
	sta	.irqa
	stx	.irqx
	sty	.irqy
	
	ldx	.index
.Update2
	+spupdate	2, .Update3, .JInterrupt3
	
.Interrupt3
!if .showirq {
	inc	$d020
}
	sta	.irqa
	stx	.irqx
	sty	.irqy
	
	ldx	.index
.Update3
	+spupdate	3, .Update4, .JInterrupt4
	
.Interrupt4
!if .showirq {
	inc	$d020
}
	sta	.irqa
	stx	.irqx
	sty	.irqy
	
	ldx	.index
.Update4
	+spupdate	4, .Update5, .JInterrupt5
	
.Interrupt5
!if .showirq {
	inc	$d020
}
	sta	.irqa
	stx	.irqx
	sty	.irqy
	
	ldx	.index
.Update5
	+spupdate	5, .Update6, .JInterrupt6
	
.Interrupt6
!if .showirq {
	inc	$d020
}
	sta	.irqa
	stx	.irqx
	sty	.irqy
	
	ldx	.index
.Update6
	+spupdate	6, .Update7, .JInterrupt7

.Interrupt7
!if .showirq {
	inc	$d020
}
	sta	.irqa
	stx	.irqx
	sty	.irqy
	
	ldx	.index
.Update7
	+spupdate	7, .Update8, .JInterrupt0

.Update8
	jmp		.Update0

;	ldx	#49 + 8 * 20
	
.InterruptSplit1
	sta	.irqa
	
!if .showirq {
	inc	$d020
}	
	lda	Starfield.scroll1
	sta	$d016

	lda	#<.JInterruptSplit2
	sta	$fffe
	
	asl	$d019
	
	lda	#50 + 8 * 22
	sta	$d012

!if .showirq {
	dec	$d020
}	
	lda	.irqa
	rti
	

.InterruptSplit2
	sta	.irqa

;	inc	$d020

	lda	#<.JInterruptSplit3
	sta	$fffe
	
	asl	$d019
	
	lda	#50 + 8 * 24
	sta	$d012
	
	lda	#2
	sta	.vsync

	nop
	nop
	nop
	nop
	
	lda	Starfield.scroll2
	sta	$d016	
	lda	#12
	sta	$d021

;	dec	$d020
	
	lda	.irqa
	rti

.InterruptSplit3
	sta	.irqa

!if .showirq {
	inc	$d020
}	
	lda	#<.JInterruptFinal
	sta	$fffe

	asl	$d019
	
	nop
	nop
	nop
	nop
	
	lda	#255
	sta	$d012

	lda	#$00
	sta	$d015

	lda	Starfield.scroll3
	sta	$d016	
	lda	#11
	sta	$d021

!if .showirq {
	dec	$d020
}
	
	lda	.irqa
	rti

.InterruptLast
	asl	$d019
		
	lda	#$1b
	sta	$d011
	
	lda	#1
	sta	.vsync

	ldx	#<.JInterruptSplit1
	lda	#50 + 8 * 20

	sta	$d012

	stx	$fffe

	ldy	.irqy
	ldx	.irqx
	lda	.irqa
	
!if .showirq {
	dec	$d020	
}
	rti
	

.InterruptDone
	asl	$d019
	
	clc
	adc	#2
	bcc	+
	
	lda	#$1b
	sta	$d011
	
	lda	#1
	sta	.vsync

	ldx	#<.JInterruptSplit1
	lda	#50 + 8 * 20
+	
	sta	$d012

	stx	$fffe

	ldy	.irqy
	ldx	.irqx
	lda	.irqa
	
!if .showirq {
	dec	$d020	
}
	rti
	
