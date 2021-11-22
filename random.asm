!zone Random

.seed	!byte	0x32, 0x31, 0xb7, 0x21
.last	= .seed + 3
.rand		
	lda	.seed + 0
	asl
	asl
	asl
	asl
	eor	.seed + 0
	sta	tmp
	lda	.seed + 1
	sta	.seed + 0
	lda	.seed + 2
	sta	.seed + 1
	lda	.seed + 3
	sta	.seed + 2
	lda	tmp
	asl
	eor	tmp
	eor	.seed + 2
	sta	tmp
	lda	.seed + 2
	lsr
	eor	tmp
	sta	.seed + 3
	rts
