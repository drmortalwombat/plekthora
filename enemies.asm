	!zone Enemies
.size		=	24

.SFCollides	=	$80
.SFExplodes	=	$40
.SFExplosion	=	$20
.SFButton	=	$10
.SFBoss		=	$08
.SFBossShield	=	$04
.SFShot		=	$02

.PFCollides	=	$80
.PFBonus	=	$40
.PFSolid	=	$20
.PFGate		=	$10

.PFYEscape	=	$08

.xposl	=	$e500
.xposh	=	$70
.yposl	=	.xposl + .size
.yposh	=	.xposh + .size

.succ	=	.yposh + .size

.xvel	=	.yposl + .size
.yvel	=	.xvel + .size
.xsize	=	.yvel + .size
.ysize	=	.xsize + .size
.xacc	=	.ysize + .size
.yacc	=	.xacc + .size

.img	=	.yacc + .size
.color	=	.img + .size
.type	=	.color + .size
.sflags	=	.type + .size
.pflags =	.sflags + .size
.hits	=	.pflags + .size

.pathc	=	.hits + .size
.pathl	=	.pathc + .size
.pathh	=	.pathl + .size
.pathi	=	.pathh + .size
.pathe  =	.pathi + .size
.paths  =	.pathe + .size

.scorel	=	.paths + .size
.scoreh	=	.scorel + .size

.ai	=	.scoreh + .size

.boss	!byte	$00, $00
.bossp	!byte	$00
.bossf	!byte	$00
.bosse	!byte	$00
.bossshield	!byte	$00

.head	!byte	$ff
.free	!byte	$00
.minx	!byte	$00


.TNone		=	0
.TAsteroid	=	1
.TArrow1	=	2
.TStarMine	=	3
.THomingMissile	=	4
.TDestroyer1	=	5
.TWall		=	6
.TElectro	=	7
.TSentinel	=	8
.TArrow2	=	9
.TCrossWipe	=	10
.TAssassin	=	11
.TBonus		=	12
.TSpike		=	13
.TSAMissile	=	14
.TWhirling	=	15
.TSquid		=	16
.TMine		=	17
.TWallGun	=	18
.TLevel		=	19
.TBreaker	=	20
.TBlubber	=	21
.TBoomerang	=	22
.TGate		=	23
.TButton	=	24
.TEnergyWall	=	25
.TDiamond	=	26
.TBoss1		=	27
.TBoss2		=	28
.TBoss2Electro	=	29
.TBoss3a	=	30
.TBoss3b	=	31
.TSwarm		=	32
.TSlidingWall	=	33
.TShiftingWall	=	34
.TBombDrop	=	35
.TSnake		=	36
.TGrowBlock	=	37
.TBoss4		=	38
.TBoss4b	=	39
.Shot		=	0x80

.AINone		=	0 * 3
.AIHoming	=	1 * 3
.AIPath		=	2 * 3
.AIShooting	=	3 * 3
.AIAssassin	=	4 * 3
.AIBonus	=	5 * 3
.AISAMissile	=	6 * 3
.AIYOffset	=	7 * 3
.AIYJitter	=	8 * 3
.AIShootForward	=	9 * 3
.AIBreaker	=	10 * 3
.AI11		=	11 * 3
.AIEnergyWall	=	12 * 3
.AIBoss1	=	13 * 3
.AIBoss2	=	13 * 3
.AIBoss2Electro	=	14 * 3
.AIBoss3a	=	15 * 3
.AIBoss3b	=	16 * 3
.AIElectro	=	17 * 3
.AISlidingWall	=	18 * 3
.AIShiftingWall =	19 * 3
.AIBombDrop	=	20 * 3
.AIGrowBlock0	=	21 * 3
.AIGrowBlock1	=	22 * 3
.AIGrowBlock2	=	23 * 3
.AIBoss4a	=	24 * 3
.AIBoss4b	=	25 * 3
.AIAccelerate	=	26 * 3	; must always be last

.jump_add_l	!byte	0, <.AddAsteroid, <.AddArrow, <.AddStarMine, <.AddHomingMissile, <.AddDestroyer, <.AddWall, <.AddElectro, <.AddSentinel
		!byte	<.AddArrow2, <.AddCrossWipe, <.AddAssassin, <.AddBonus, <.AddSpike, <.AddSAMissile, <.AddWhirling, <.AddSquid
		!byte	<.AddMine, <.AddWallGun, <.AddLevel, <.AddBreaker, <.AddBlubber, <.AddBoomerang, <.AddGate, <.AddButton
		!byte	<.AddEnergyWall, <.AddDiamond, <.AddBoss1, <.AddBoss2, <.AddBoss2Electro, <.AddBoss3a, <.AddBoss3b
		!byte	<.AddSwarm, <.AddSlidingWall, <.AddShiftingWall, <.AddBombDrop, <.AddSnake, <.AddGrowBlock, <.AddBoss4, <.AddBoss4b
.jump_add_h	!byte	0, >.AddAsteroid, >.AddArrow, >.AddStarMine, >.AddHomingMissile, >.AddDestroyer, >.AddWall, >.AddElectro, >.AddSentinel
		!byte	>.AddArrow2, >.AddCrossWipe, >.AddAssassin, >.AddBonus, >.AddSpike, >.AddSAMissile, >.AddWhirling, >.AddSquid
		!byte	>.AddMine, >.AddWallGun, >.AddLevel, >.AddBreaker, >.AddBlubber, >.AddBoomerang, >.AddGate, >.AddButton
		!byte	>.AddEnergyWall, >.AddDiamond, >.AddBoss1, >.AddBoss2, >.AddBoss2Electro, >.AddBoss3a, >.AddBoss3b
		!byte	>.AddSwarm, >.AddSlidingWall, >.AddShiftingWall, >.AddBombDrop, >.AddSnake, >.AddGrowBlock, >.AddBoss4, >.AddBoss4b


;!align	255, 0

.animtab
		!byte	$00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $0A, $0B, $0C, $0D, $0E, $0F
		!byte	$10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $1E, $1F
		!byte	$20, $21, $22, $23, $24, $25, $26, $27, $28, $29, $2A, $2B, $2C, $2D, $2E, $2F
		!byte	$30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3A, $3B, $3C, $3D, $3E, $3F
		!byte	$40, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4A, $4B, $4C, $4D, $4E, $4F
		!byte	$51, $52, $53, $54, $55, $56, $57, $58, $59, $5A, $5B, $5C, $5D, $5E, $5F, $50
		!byte	$61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $6C, $6D, $6E, $6F, $00
		!byte	$71, $72, $73, $70, $75, $76, $77, $74, $79, $7A, $7B, $78, $7D, $7E, $7F, $7C
		!byte	$80, $81, $82, $83, $84, $85, $86, $87, $89, $8A, $8B, $88, $8D, $8E, $8F, $8C 
		!byte	$91, $92, $93, $94, $95, $96, $97, $90, $99, $9A, $9B, $98, $9D, $9E, $9F, $9C
	        !byte	$A0, $A1, $A2, $A3, $A4, $A5, $A6, $A7, $A9, $AA, $AB, $A8, $AD, $AE, $AF, $AC
		!byte	$B1, $B2, $B3, $B4, $B5, $B6, $B7, $B0, $B9, $BA, $BB, $B8, $BD, $BE, $BF, $BC
		!byte	$C0, $C1, $C2, $C3, $C4, $C5, $C6, $C7, $C8, $C9, $CA, $CB, $CD, $CE, $CF, $CC
		!byte	$D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7, $D8, $D9, $DA, $DB, $DC, $DD, $DE, $DF
		!byte	$E1, $E2, $E3, $E0, $E5, $E6, $E7, $E4, $E8, $E9, $EA, $EB, $ED, $EE, $EF, $EC
		!byte	$F1, $F2, $F3, $F0, $F5, $F6, $F7, $F4, $F8, $F9, $FA, $FB, $FC, $FD, $FE, $FF

		
.Init
	ldx	#1
-
	txa
	sta	.succ - 1, x
	inx
	cpx	#.size
	bne	-
	
	lda	#0
	sta	.free
	lda	#$ff
	sta	.head
	sta	.succ + .size - 1
	
	rts

; Allocate a new enemy, return index in x, carry is set if none found
	
.Allocate
	ldx	.free
	bmi	+
	lda	.succ, x
	sta	.free
	lda	.head
	sta	.succ, x
	stx	.head
+	cpx 	#$80

	rts

; Free an enemy in x and return the successor in y
	
.Free

; Hide sprite, does not matter if asynch, sprite mux runs on y shadow

	lda	#$ff
	sta	Sprites.ypos + 8, x

; Check first element
	
	cpx	.head
	bne	+
	ldy	.succ, x
	sty	.head
	jmp	++

; Search for predecessor

+	ldy	.head
-	txa
	cmp	.succ, y
	beq	+
	lda	.succ, y
	tay
	jmp	-

+	lda	.succ, x
	sta	.succ, y
	tay

; Insert into free list
	
++
	lda	.free
	sta	.succ, x
	stx	.free
	rts

.ExplodeGates
	tya
	pha
	txa
	pha
	
	ldx	.head
-
	lda	.pflags, x
	and	#.PFGate
	beq	+
	
	lda	#1
	jsr	.Explode
	
+
	lda	.succ, x
	tax
	bpl	-
	
	pla
	tax
	pla
	tay
	rts	

.ExplodeBoss
	tya
	pha
	txa
	pha
	
	ldx	.head
-
	lda	.sflags, x
	and	#.SFBoss
	beq	+
	
	lda	#0
	sta	.sflags, x
	
	lda	#100
	jsr	.Explode
	
+
	lda	.succ, x
	tax
	bpl	-
	
	pla
	tax
	pla
	tay
	rts	

.ExposeBoss
	txa
	pha
	
	ldx	.head
-
	lda	.sflags, x
	and	#.SFBoss
	beq	+
	
	lda	#.SFCollides + .SFBoss + .SFExplodes
	sta	.sflags, x
		
+
	lda	.succ, x
	tax
	bpl	-
	
	pla
	tax
	rts
	
	
	
.HighlightBoss
	tya
	pha
	txa
	pha
	
	ldy	.hits, x
	ldx	#24
	lda	.bosse
	
	jsr	Math.umul8x8div8
	
	jsr	Status.DrawBossEnergy
	pla
	tax
	
	ldy	.head
-
	lda	.sflags, y
	and	#.SFBoss + .SFExplodes
	cmp	#.SFBoss + .SFExplodes
	bne	+

	lda	.hits, x
	sta	.hits, y

	lda	.color, y
	ora	#$e0
	sta	.color, y
	lda	#1
	sta	Sprites.color + 8, y
+	
	lda	.succ, y
	tay
	bpl	-
	
	pla
	tay
	lda	#Sound.SOFHit
	jmp	Sound.QueueEffect
	
.Explode
	eor	#$ff
	sec
	adc	.hits, x
	bcc	++
	beq	++
	sta	.hits, x

	lda	.sflags, x
	and	#.SFBoss
	beq	+
	
	jmp	.HighlightBoss
	
+
	
	lda	.color, x
	ora	#$e0
	sta	.color, x
	lda	#1
	sta	Sprites.color + 8, x
	
	lda	#Sound.SOFHit
	jmp	Sound.QueueEffect
	
++
	lda	.sflags, x
	and	#.SFButton
	beq	+
	lda	#0
	sta	.sflags, x
	sta	.color, x
	sta	Sprites.color + 8, x	
	jmp	.ExplodeGates
	
+
	lda	.sflags, x
	and	#.SFBoss
	beq	+
	jmp	.ExplodeBoss
	
+
	lda	.sflags, x
	and	#.SFBossShield
	beq	+
	dec	.bossshield
	bne	+
	
	jsr	.ExposeBoss
	
+
	lda	#.SFExplosion 
	sta	.sflags, x
	lda	#.PFYEscape + 1
	sta	.pflags, x
	
	lda	#7
	sta	.color, x
	sta	Sprites.color + 8, x
	lda	#$60
	sta	.img, x
	
	lda	#0
	sta	.xacc, x
	sta	.yacc, x
	sta	.ai, x

	tya
	pha
	txa
	pha

	lda	.scorel, x
	ldy	.scoreh, x
	jsr	Status.IncScore
	
	lda	.yposh,x
	lsr
	lsr
	sbc	#5
	bcc	+
	tay
	lda	.xposh,x
	lsr
	lsr
	sbc	#2
	bcc	+
	jsr	Starfield.AddLoot
+	
	pla
	tax
	pla
	tay

	lda	#Sound.SOFExplosion
	jmp	Sound.QueueEffect
	
.Add
	pha
	tya
	pha
	txa
	pha
	
	jsr	.Allocate
	bcs	+
	
	lda	#0
	sta	.xacc,x
	sta	.yacc,x
	sta	.ai, x
	sta	.xposl,x
	sta	.yposl,x
	sta	.scoreh, x
	sta	.pathe, x
	sta	.paths, x
	
	lda	#10
	sta	.scorel, x

	pla
	tay
	
	lda	.jump_add_l, y
	sta	tmpl
	lda	.jump_add_h, y	
	sta	tmph
	
	jmp	(tmpl)

; failed, drop parameters

+	pla
	pla
	pla
	rts
	
.pickplayer
	; pick a player
	; player one iff only single player, or player two is offline, or player one is not offline and random is set
	
	ldy	#0
	bit	Game.twoplayer
	bpl	+
	bit	Player.state + 1
	bmi	+
	iny
	bit	Player.state
	bmi	+
	bit	Random.last
	bmi	+
	dey
+
	rts
	
.AddShot
	txa
	pha
	
	jsr	.Allocate
	bcc	+
	
; failed, drop parameters
	
	pla
	rts
+

	stx	tmpx
	
	pla
	tay
	
	lda	#Sound.SOFEnemyShot
	jsr	Sound.QueueEffect
	
	lda	.xposl, y
	sta	.xposl, x
	lda	.xposh, y
	sta	.xposh, x

	lda	.yposl, y
	sta	.yposl, x
	lda	.yposh, y
	clc
	adc	#4
	sta	.yposh, x
	
	lda	#7
	sta	.color, x
	sta	Sprites.color + 8, x
	lda	#$40 + 64
	sta	.img, x
	lda	#0
	sta	.ai, x
	
	lda	#.SFShot
	sta	.sflags, x
	
	lda	#.PFCollides + .PFYEscape
	sta	.pflags, x
	
	lda	#2
	sta	.xsize, x
	sta	.ysize, x

	jsr	.pickplayer

	lda	Player.xposh, y
	sta	tmps
	lda	Player.yposh, y
	sta	tmpu
	
	ldy	#0
	
	; tmps is abs(dx)
	; tmpu is abs(dy)
	; tmpv is sign(dx) sign(dy)
	
	clc
	lda	tmps
	adc	#4
	sec
	sbc	.xposh, x
		
	bcs	+
	eor	#$ff
	adc	#1
	ldy	#2
+	sta	tmps

	clc
	lda	tmpu
	adc	#4
	sec
	sbc	.yposh, x
	
	bcs	+
	eor	#$ff
	adc	#1
	iny
+	sta	tmpu

	sty	tmpv
	
	lda	tmps
	cmp	tmpu
	bcs	++
	
	; abs(dy) > abs(dx)
	; vy = 64, vx = 64 * dx / dy
	
	ldx	tmps
	ldy	#64
	lda	tmpu
	
	jsr	Math.umul8x8div8
	
	ldx	tmpx
	
	tay
	lsr	tmpv
	bcc	+
	lda	#-64
	!byte	$2c
+	lda	#64
	sta	.yvel, x
	tya
	lsr	tmpv
	bcc	+
	eor	#$ff
	adc	#1
+	sta	.xvel, x
	
	clc
	rts
++	
	ldx	tmpu
	ldy	#64
	lda	tmps
	
	jsr	Math.umul8x8div8
	
	ldx	tmpx

	lsr	tmpv
	bcc	+
	eor	#$ff
	adc	#1
+	sta	.yvel, x
	
	lsr	tmpv
	bcc	+
	lda	#-64
	!byte	$2c
+	lda	#64
	sta	.xvel, x
	
	clc
	rts
	
.acolors	!byte	2, 9, 12, 15

.AddAsteroid

; Outside screen

	lda	#172
	sta	.xposh,x
	
	jsr	Random.rand
	and	#63
	clc
	adc	#28
	sta	.yposh,x

	jsr	Random.rand
	and	#31
	ora	#192
	sta	.xvel,x

	jsr	Random.rand
	and	#63
	sec
	sbc	#32
	sta	.yvel,x
	
	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	txa
	and	#15
	clc
	adc	#$50
	sta	.img, x
	
	txa
	and	#3
	tay
	lda	.acolors, y
	sta	.color, x			
	sta	Sprites.color + 8, x

	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	
	lda	#.PFCollides + 3
	sta	.pflags, x
	
	lda	#6
	sta	.hits, x
	
	lda	#<50
	sta	.scorel, x
	lda	#>50
	sta	.scoreh, x

	lda	Random.last
	and	#3
	bne	+
	
	lda	#<Sound.AsteroidSound
	ldy	#>Sound.AsteroidSound
	jsr	Sound.PlaySound
+	
	pla
	pla
	rts

.AddBlubber

; Outside screen

	jsr	Random.rand
	and	#7
	clc
	adc	#165
	sta	.xposh,x

	pla
	sta	.yposh,x

	lda	#-67
	sta	.xvel,x

	lda	#0
	sta	.yvel,x
	
	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	jsr	Random.rand
	and	#3
	ora	#$40 + 180
	sta	.img, x
	
	pla
	bmi	+	
	lda	#13
	ldy	#4
	bne	++
+	lda	#5
	ldy	#8
++

	sta	.color, x
	sta	Sprites.color + 8, x
	
	tya
	sta	.hits, x
	
	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	
	lda	#.PFCollides + 3
	sta	.pflags, x
	
	lda	#<25
	sta	.scorel, x
	lda	#>25
	sta	.scoreh, x

	rts


.AddBonus

	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-24
	sta	.xvel,x
	
	pla
	sta	.yposh, x

	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	lda	#12
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#0
	sta	.sflags, x
	lda	#.PFCollides + .PFBonus + 1
	sta	.pflags, x
	
	lda	#.AIBonus
	sta	.ai, x
	
	pla
	sta	.type,x
	
	asl
	asl
	asl
	asl
	asl
	asl
	sta	tmpl
	lda	#$70
	rol
	sta	tmph
	ldy	#15
-
	lda	$6e00,y
	and	#$fc
	ora	(tmpl),y
	sta	$6e00, y

	lda	$6e40,y
	and	#$fc
	ora	(tmpl),y
	sta	$6e40, y

	lda	$6e80,y
	and	#$fc
	ora	(tmpl),y
	sta	$6e80, y

	lda	$6ec0,y
	and	#$fc
	ora	(tmpl),y
	sta	$6ec0, y
	iny
	
	lda	(tmpl),y
	sta	$6e00, y

	lda	(tmpl),y
	sta	$6e40, y

	lda	(tmpl),y
	sta	$6e80, y

	lda	(tmpl),y
	sta	$6ec0, y
	iny
	
	lda	$6e00,y
	and	#$3f
	ora	(tmpl),y
	sta	$6e00, y

	lda	$6e40,y
	and	#$3f
	ora	(tmpl),y
	sta	$6e40, y

	lda	$6e80,y
	and	#$3f
	ora	(tmpl),y
	sta	$6e80, y

	lda	$6ec0,y
	and	#$3f
	ora	(tmpl),y
	sta	$6ec0, y
	iny
	
	
	cpy	#48
	bne	-
	
	lda	#$40 + 120
	sta	.img, x

	rts

.AddWall

	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-16
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	pla
	pha
	and	#$80
	sta	.yposl, x

	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	lda	#12
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#.SFCollides
	sta	.sflags, x
	lda	#.PFCollides + .PFSolid
	sta	.pflags, x
	
	pla
	and	#$7f
	clc
	adc	#$40 + 65
	sta	.img, x

	rts

.AddSlidingWall

	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-16
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	pla
	pha
	and	#$80
	sta	.yposl, x

	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	lda	#12
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#.SFCollides
	sta	.sflags, x
	lda	#.PFCollides
	sta	.pflags, x
	
	lda	#.AISlidingWall
	sta	.ai, x
	pla
	pha
	and	#$78
	sta	.pathi, x
	lda	#32
	sta	.pathc, x
	
	pla
	and	#$07
	clc
	adc	#$40 + 65
	sta	.img, x

	rts


.AddShiftingWall

	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-16
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	pla
	pha
	and	#$80
	sta	.yposl, x

	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	lda	#15
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#.SFCollides
	sta	.sflags, x
	lda	#.PFCollides
	sta	.pflags, x
	
	lda	#.AIShiftingWall
	sta	.ai, x
	pla
	pha
	and	#$78
	sta	.pathi, x
	lda	#56
	sta	.pathc, x
	
	pla
	and	#$07
	clc
	adc	#$40 + 65
	sta	.img, x

	
	rts


.AddWallGun

	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-16
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	pla
	pha
	and	#$80
	sta	.yposl, x

	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	lda	#12
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#.SFCollides
	sta	.sflags, x
	lda	#.PFCollides
	sta	.pflags, x
	lda	#.AIShootForward
	sta	.ai, x
	lda	#31
	sta	.pathc, x
	lda	#32
	sta	.pathi, x

	
	pla
	
	lda	#$40 + 134
	sta	.img, x

	rts

.AddButton

	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-16
	sta	.xvel,x
	
	pla
	sta	.yposh, x

	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	lda	#8
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#.SFCollides + .SFButton + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides
	sta	.pflags, x
	lda	#1
	sta	.hits, x
	
	pla
	
	lda	#$40 + 185
	sta	.img, x

	rts

.bossvy		=	6

.BossPath1	!byte	20

		!byte	 3, -.bossvy, 10,  2,  .bossvy, 10, -2,  .bossvy, 10, -2,        0, 10
		
		!byte	 2,        0, 10,  2, -.bossvy, 10, -2, -.bossvy, 10, -2,        0, 10
		!byte	 2,        0,  5,  2,  .bossvy, 10, -2,  .bossvy, 10, -2,        0,  5				

		!byte	 2,        0, 10,  2, -.bossvy, 10, -2, -.bossvy, 10, -2,        0, 10
		!byte	 2,        0, 10,  2,  .bossvy, 10, -2,  .bossvy, 10, -2,        0, 10				

		!byte	 2,        0, 10,  2, -.bossvy, 10, -2, -.bossvy, 10, -2,        0, 10
		!byte	 2,        0,  5,  2,  .bossvy, 10, -2,  .bossvy, 10, -2,        0,  5				

		!byte	 2,        0, 10,  2, -.bossvy, 10, -2, -.bossvy, 10, -2,        0, 10
		!byte	 2,        0, 10,  2,  .bossvy, 10, -2,  .bossvy, 10, -2,        0, 10				
		
		!byte	 2,        0,  5,  2, -.bossvy, 10, -2, -.bossvy, 10, -2,        0,  5
		!byte	 2,        0, 10,  2,  .bossvy, 10, -2,  .bossvy, 10, -2,        0, 10				
		
		!byte	 2,        0, 10,  2, -.bossvy, 10, -2, -.bossvy, 10, -2,        0, 10
		!byte	 2,        0,  5,  2,  .bossvy, 10, -2,  .bossvy, 10, -2,        0,  5					
		
		!byte	 2,        0, 10,  2, -.bossvy, 10, -2, -.bossvy, 10, -2,        0, 10
		!byte	 2,        0, 10,  2,  .bossvy, 10, -2,  .bossvy, 10, -2,        0, 10				
		
		!byte	-10, -1, 20, 0, 0, 0
	
.BossColor1	!byte	15, 14, 3, 7
.BossHits1	!byte	24, 48, 96, 144

.AddBoss1

	stx	.boss

	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-32
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	pla
	pha
	and	#$80
	sta	.yposl, x	
	
	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	pla
	pha
	lsr
	lsr
	lsr
	lsr
	and	#3
	tay
	
	lda	.BossColor1, y	
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	.BossHits1, y
	sta	.hits, x
	sta	.bosse

	lda	#.SFCollides + .SFBoss + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides
	sta	.pflags, x
	lda	#.AIBoss1
	sta	.ai, x

	lda	#<.BossPath1
	sta	.pathl, x
	sta	tmpl
	lda	#>.BossPath1
	sta	.pathh, x
	sta	tmph
	
	ldy	#0
	lda	(tmpl),y
	sta	.pathc, x
	iny
	tya
	sta	.pathi, x
	
	pla
	and	#$0f	
	sta	.type, x
	bne	+

	pha
	txa
	pha
	
	lda	#<Sound.EnemyBoss1Sound
	ldy	#>Sound.EnemyBoss1Sound
	jsr	Sound.PlaySound

	lda	#<Sound.EnemyBoss1bSound
	ldy	#>Sound.EnemyBoss1bSound
	jsr	Sound.PlaySound
	
	pla
	tax
	pla
	
+
	clc
	adc	#$40 + 128
	sta	.img, x

	lda	#<400
	sta	.scorel, x
	lda	#>400
	sta	.scoreh, x
	
	rts

.bossvy		=	6

.BossPath2	!byte	20

		!byte	 1, 0, 8
		!byte	 2, -.bossvy, 10,  0,  .bossvy, 10
		
		!byte	-2,   .bossvy, 10,  0,  0, 10,  4, -.bossvy, 10, -1, 0, 20			
		!byte	 2,  -.bossvy, 10,  0,  0, 10, -3,  .bossvy, 10,  1, 0, 20
		!byte	-2,   .bossvy, 10,  0,  0, 12,  3, -.bossvy, 10, -1, 0, 20				
		!byte	 2,  -.bossvy, 10,  0,  0,  8, -4,  .bossvy, 10,  1, 0, 20
		!byte	-2,   .bossvy, 10,  0,  0,  8,  4, -.bossvy, 10, -1, 0, 20					
		!byte	 2,  -.bossvy, 10,  0,  0, 12, -4,  .bossvy, 10,  1, 0, 20
		
		!byte	-2,   .bossvy, 10,  0,  0, 10,  4, -.bossvy, 10, -1, 0, 20			
		!byte	 2,  -.bossvy, 10,  0,  0, 10, -3,  .bossvy, 10,  1, 0, 20
		!byte	-2,   .bossvy, 10,  0,  0, 12,  3, -.bossvy, 10, -1, 0, 20				
		!byte	 2,  -.bossvy, 10,  0,  0,  8, -4,  .bossvy, 10,  1, 0, 20
		!byte	-2,   .bossvy, 10,  0,  0,  8,  4, -.bossvy, 10, -1, 0, 20					
		!byte	 2,  -.bossvy, 10,  0,  0, 12, -4,  .bossvy, 10,  1, 0, 20

		!byte	-2,   .bossvy, 10,  0,  0, 10,  4, -.bossvy, 10, -1, 0, 20			
		!byte	 2,  -.bossvy, 10,  0,  0, 10, -3,  .bossvy, 10,  1, 0, 20
		!byte	-2,   .bossvy, 10,  0,  0, 12,  3, -.bossvy, 10, -1, 0, 20				
		!byte	 2,  -.bossvy, 10,  0,  0,  8, -4,  .bossvy, 10,  1, 0, 20
		!byte	-2,   .bossvy, 10,  0,  0,  8,  4, -.bossvy, 10, -1, 0, 20					
		!byte	 2,  -.bossvy, 10,  0,  0, 12, -4,  .bossvy, 10,  1, 0, 20
		
		!byte	-20, 1, 10, 0, 0, 0

.AddBoss2

	stx	.boss

	lda	#0
	sta	.bossp
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-32
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	pla
	pha
	and	#$80
	sta	.yposl, x	
	
	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	pla
	pha
	lsr
	lsr
	lsr
	lsr
	and	#3
	tay
	
	lda	.BossColor1, y	
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	.BossHits1, y
	sta	.hits, x
	sta	.bosse
	
	lda	#.SFCollides + .SFBoss + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides
	sta	.pflags, x
	lda	#.AIBoss1
	sta	.ai, x

	lda	#<.BossPath2
	sta	.pathl, x
	sta	tmpl
	lda	#>.BossPath2
	sta	.pathh, x
	sta	tmph
	
	ldy	#0
	lda	(tmpl),y
	sta	.pathc, x
	iny
	tya
	sta	.pathi, x
	
	pla
	and	#$0f	
	sta	.type, x
	bne	+

	pha
	txa
	pha
	
	lda	#<Sound.EnemyBoss1Sound
	ldy	#>Sound.EnemyBoss1Sound
	jsr	Sound.PlaySound

	lda	#<Sound.EnemyBoss1bSound
	ldy	#>Sound.EnemyBoss1bSound
	jsr	Sound.PlaySound
	
	pla
	tax
	pla
	
+
	clc
	adc	#$40 + 136
	sta	.img, x

	lda	#<600
	sta	.scorel, x
	lda	#>600
	sta	.scoreh, x

	rts

.AddBoss2Electro

	stx	.bossf
	
	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-32
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	pla
	pha
	and	#$80
	sta	.yposl, x	
	
	lda	#12
	sta	.xsize, x
	lda	#4
	sta	.ysize, x
		
	lda	#14
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#1
	sta	.hits, x
	
	lda	#.SFBoss
	sta	.sflags, x
	lda	#.PFCollides + 1
	sta	.pflags, x
	lda	#.AIBoss2Electro
	sta	.ai, x

	pla
	sta	.pathi, x
	txa
	and	#3
	adc	#$40 + 140
	sta	.img, x
	lda	#0
	sta	.pathc, x

	rts


.BossPath3a	!byte	20, 2, 0, 16

		!byte	0, -4, 10, 0, 0, 5, 0, 8, 10, 0, -4, 10
		!byte	-10, 0, 12, 0, 0, 20, 20, 0, 12, 0, 0, 20, -10, 0, 12
		!byte	0,  4, 10, 0, 0, 10, 0, -8, 10, 0, 4, 10
		!byte	-10, 0, 12, 0, 0, 20, 20, 0, 12, 0, 0, 20, -10, 0, 12
		!byte	0,  4, 10, 0, 0, 10, 0, -8, 10, 0, 4, 10
		!byte	-10, 0, 12, 0, 0, 20, 20, 0, 12, 0, 0, 20, -10, 0, 12
		!byte	0, -4, 10, 0, 0, 5, 0, 8, 10, 0, -4, 10
		!byte	-10, 0, 12, 0, 0, 20, 20, 0, 12, 0, 0, 20, -10, 0, 12
		!byte	0,  4, 10, 0, 0, 10, 0, -8, 10, 0, 4, 10
		!byte	-10, 0, 12, 0, 0, 20, 20, 0, 12, 0, 0, 20, -10, 0, 12
		!byte	0, -4, 10, 0, 0, 5, 0, 8, 10, 0, -4, 10
		!byte	-10, 0, 12, 0, 0, 20, 20, 0, 12, 0, 0, 20, -10, 0, 12
		!byte	0, -4, 10, 0, 0, 5, 0, 8, 10, 0, -4, 10
		!byte	-10, 0, 12, 0, 0, 20, 20, 0, 12, 0, 0, 20, -10, 0, 12
		!byte	0, -4, 10, 0, 0, 5, 0, 8, 10, 0, -4, 10
		!byte	-10, 0, 12, 0, 0, 20, 20, 0, 12, 0, 0, 20, -10, 0, 12
		!byte	0,  4, 10, 0, 0, 10, 0, -8, 10, 0, 4, 10
		!byte	-10, 0, 12, 0, 0, 20, 20, 0, 12, 0, 0, 20, -10, 0, 12
		
		!byte	-10, -1, 20, 0, 0, 0
	
.AddBoss3a

	stx	.boss

	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-32
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	pla
	pha
	and	#$80
	sta	.yposl, x	
	
	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	pla
	pha
	lsr
	lsr
	lsr
	lsr
	and	#3
	tay
	
	lda	.BossColor1, y	
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	.BossHits1, y
	sta	.hits, x
	sta	.bosse

	lda	#.SFCollides + .SFBoss + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides
	sta	.pflags, x
	lda	#.AIBoss3a
	sta	.ai, x

	lda	#<.BossPath3a
	sta	.pathl, x
	sta	tmpl
	lda	#>.BossPath3a
	sta	.pathh, x
	sta	tmph
	
	ldy	#0
	lda	(tmpl),y
	sta	.pathc, x
	iny
	tya
	sta	.pathi, x
	
	pla
	and	#$0f	
	sta	.type, x
	bne	+

	pha
	txa
	pha
	
	lda	#<Sound.EnemyBoss1Sound
	ldy	#>Sound.EnemyBoss1Sound
	jsr	Sound.PlaySound

	lda	#<Sound.EnemyBoss1bSound
	ldy	#>Sound.EnemyBoss1bSound
	jsr	Sound.PlaySound
	
	pla
	tax
	pla
	
+
	clc
	adc	#$40 + 144
	sta	.img, x

	lda	#<600
	sta	.scorel, x
	lda	#>600
	sta	.scoreh, x
	
	rts

.BossPath3b	!byte	16, 4, 0, 16

		!byte	0,  4, 10, 0, 0, 10, 0, -8, 10, 0, 4, 10
		!byte	-10, 0, 12, 0, 0, 20, 20, 0, 12, 0, 0, 20, -10, 0, 12
		!byte	0, -4, 10, 0, 0, 5, 0, 8, 10, 0, -4, 10
		!byte	-10, 0, 12, 0, 0, 20, 20, 0, 12, 0, 0, 20, -10, 0, 12
		!byte	0,  4, 10, 0, 0, 10, 0, -8, 10, 0, 4, 10
		!byte	-10, 0, 12, 0, 0, 20, 20, 0, 12, 0, 0, 20, -10, 0, 12
		!byte	0, -4, 10, 0, 0, 5, 0, 8, 10, 0, -4, 10
		!byte	-10, 0, 12, 0, 0, 20, 20, 0, 12, 0, 0, 20, -10, 0, 12
		!byte	0,  4, 10, 0, 0, 10, 0, -8, 10, 0, 4, 10
		!byte	-10, 0, 12, 0, 0, 20, 20, 0, 12, 0, 0, 20, -10, 0, 12
		!byte	0,  4, 10, 0, 0, 10, 0, -8, 10, 0, 4, 10
		!byte	-10, 0, 12, 0, 0, 20, 20, 0, 12, 0, 0, 20, -10, 0, 12
		!byte	0, -4, 10, 0, 0, 5, 0, 8, 10, 0, -4, 10
		!byte	-10, 0, 12, 0, 0, 20, 20, 0, 12, 0, 0, 20, -10, 0, 12
		!byte	0, -4, 10, 0, 0, 5, 0, 8, 10, 0, -4, 10
		!byte	-10, 0, 12, 0, 0, 20, 20, 0, 12, 0, 0, 20, -10, 0, 12
		!byte	0, -4, 10, 0, 0, 5, 0, 8, 10, 0, -4, 10
		!byte	-10, 0, 12, 0, 0, 20, 20, 0, 12, 0, 0, 20, -10, 0, 12
		
		!byte	-10, -1, 20, 0, 0, 0
	

.AddBoss3b

	stx	.boss + 1

	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-64
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	pla
	pha
	and	#$80
	sta	.yposl, x	
	
	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	pla
	pha
	lsr
	lsr
	lsr
	lsr
	and	#3
	tay
	
	lda	.BossColor1, y	
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	.BossHits1, y
	sta	.hits, x
	sta	.bosse

	lda	#.SFCollides + .SFBoss + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides
	sta	.pflags, x
	lda	#.AIBoss3b
	sta	.ai, x

	lda	#<.BossPath3b
	sta	.pathl, x
	sta	tmpl
	lda	#>.BossPath3b
	sta	.pathh, x
	sta	tmph
	
	ldy	#0
	lda	(tmpl),y
	sta	.pathc, x
	iny
	tya
	sta	.pathi, x
	
	pla
	and	#$0f	
	sta	.type, x
	bne	+

	pha
	txa
	pha
	
	lda	#<Sound.EnemyBoss1Sound
	ldy	#>Sound.EnemyBoss1Sound
	jsr	Sound.PlaySound

	lda	#<Sound.EnemyBoss1bSound
	ldy	#>Sound.EnemyBoss1bSound
	jsr	Sound.PlaySound
	
	pla
	tax
	pla
	
+
	clc
	adc	#$40 + 144
	sta	.img, x

	lda	#<600
	sta	.scorel, x
	lda	#>600
	sta	.scoreh, x
	
	rts

.BossPath4	
		!byte	1,   0,  32
.BossPath4s	= * - .BossPath4
		!byte  -4,  -1,  20
		!byte	0,   0,  10
		!byte   8,   2,  20
		!byte	0,   0,  10
		!byte  -4,  -1,  20

		!byte  -4,   1,  20
		!byte	0,   0,  10
		!byte   8,  -2,  20
		!byte	0,   0,  10
		!byte  -4,   1,  20
		
		!byte   3,   1,  20
		!byte	0,   0,  10
		!byte  -3,  -3,  20
		!byte	0,   0,  10
		!byte  -3,   3,  20
		!byte	0,   0,  10
		!byte   3,  -1,  20
		
		!byte  -3,   1,  20
		!byte	0,   0,  10
		!byte   3,  -3,  20
		!byte	0,   0,  10
		!byte   3,   3,  20
		!byte	0,   0,  10
		!byte  -3,  -1,  20

		!byte  -4,  -1,  20
		!byte	0,   0,  10
		!byte   8,   2,  20
		!byte	0,   0,  10
		!byte  -4,  -1,  20

		!byte  -4,   1,  20
		!byte	0,   0,  10
		!byte   8,  -2,  20
		!byte	0,   0,  10
		!byte  -4,   1,  20
		
		!byte   3,  -1,  20
		!byte	0,   0,  10
		!byte  -3,   3,  20
		!byte	0,   0,  10
		!byte  -3,  -3,  20
		!byte	0,   0,  10
		!byte   3,   1,  20
		
		!byte  -3,  -1,  20
		!byte	0,   0,  10
		!byte   3,   3,  20
		!byte	0,   0,  10
		!byte   3,  -3,  20
		!byte	0,   0,  10
		!byte  -3,   1,  20

		!byte  -4,  -1,  20
		!byte	0,   0,  10
		!byte   8,   2,  20
		!byte	0,   0,  10
		!byte  -4,  -1,  20

		!byte  -4,   1,  20
		!byte	0,   0,  10
		!byte   8,  -2,  20
		!byte	0,   0,  10
		!byte  -4,   1,  20
		
		!byte   3,   1,  20
		!byte	0,   0,  10
		!byte  -3,  -3,  20
		!byte	0,   0,  10
		!byte  -3,   3,  20
		!byte	0,   0,  10
		!byte   3,  -1,  20
		
		!byte  -3,   1,  20
		!byte	0,   0,  10
		!byte   3,  -3,  20
		!byte	0,   0,  10
		!byte   3,   3,  20
		!byte	0,   0,  10
		!byte  -3,  -1,  20
.BossPath4e	= * - .BossPath4

		!byte	0,   0,  200
		!byte	0,   0,  200
		!byte	0,   0,  200

.AddBoss4

	stx	.boss

	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-32
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	
	lda	#0
	sta	.yposl, x	
	
	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
		
	lda	#15
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#120
	sta	.hits, x
	sta	.bosse
	
	lda	#6
	sta	.bossshield

	lda	#.SFBoss ;.SFCollides +  + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides
	sta	.pflags, x
	lda	#.AIBoss4a
	sta	.ai, x

	lda	#<.BossPath4
	sta	.pathl, x
	sta	tmpl
	lda	#>.BossPath4
	sta	.pathh, x
	sta	tmph
	lda	#0
	sta	.pathi, x
	lda	#64
	sta	.pathc, x
	lda	#.BossPath4s
	sta	.paths, x
	lda	#.BossPath4e
	sta	.pathe, x

	pla
	pha
	
	clc
	adc	#$40 + 186
	sta	.img, x

	lda	#<800
	sta	.scorel, x
	lda	#>800
	sta	.scoreh, x
	
	pla
	bne	+
	
	lda	#<Sound.EnemyBoss1Sound
	ldy	#>Sound.EnemyBoss1Sound
	jsr	Sound.PlaySound

	lda	#<Sound.EnemyBoss1bSound
	ldy	#>Sound.EnemyBoss1bSound
	jsr	Sound.PlaySound
+	
	rts	
	
.AddBoss4b

	lda	#0
	sta	.yvel,x
	sta	.xvel,x

	lda	#172
	sta	.xposh,x
	
	pla
	sta	.yposh, x
	
	lda	#0
	sta	.yposl, x	
	
	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
		
	lda	#$0f
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#79
	sta	.hits, x

	lda	#.SFCollides + .SFBossShield + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides
	sta	.pflags, x
	lda	#.AIBoss4b
	sta	.ai, x

	pla
	sta	.pathi, x
	
	lda	#$40 + 156
	sta	.img, x

	lda	#<100
	sta	.scorel, x
	lda	#>100
	sta	.scoreh, x

	rts	
	
.AddGate

	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-16
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	pla
	and	#$80
	sta	.yposl, x

	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	lda	#7
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#.SFCollides
	sta	.sflags, x
	lda	#.PFCollides + .PFGate
	sta	.pflags, x
	
	lda	#1
	sta	.hits, x
	
	lda	#$40 + 184
	sta	.img, x

	rts

.AddLevel

	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-48
	sta	.xvel,x
	
	pla
	sta	.yposh, x

	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	pla
	pha
	lsr
	lsr
	lsr
	lsr
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#0
	sta	.sflags, x
	lda	#.PFSolid
	sta	.pflags, x
	
	pla
	and	#$0f
	clc
	adc	#$30
	sta	.img, x

	rts

.MineJitter	!byte	0, 0, 0, 2, 5, 5, 0, -10, -19, -17, 0, 24, 40, 32, 0, -41, -64, -50, 0, 58, 88, 67, 0, -74, -109, -80, 0, 85, 123, 89, 0, -90, -128, -90, 0, 89, 123, 85, 0, -80, -109, -74, 0, 67, 88, 58, 0, -50, -64, -41, 0, 32, 40, 24, 0, -17, -19, -10, 0, 5, 5, 2, 0, 0


.AddMine

	lda	#0
	sta	.yvel,x

	jsr	Random.rand
	and	#7
	clc
	adc	#165
	sta	.xposh,x
	
	lda	#-16
	sta	.xvel,x
	
	pla
	sta	.yposh, x

	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	lda	#12
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides
	sta	.pflags, x
	
	lda	#20
	sta	.hits, x
	
	lda	#.AIYJitter
	sta	.ai, x
	jsr	Random.rand
	and	#63
	sta	.pathi,x
	
	pla
	clc
	adc	#$40 + 133
	sta	.img, x

	lda	#<70
	sta	.scorel, x
	lda	#>70
	sta	.scoreh, x

	rts

.AddElectro

	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-16
	sta	.xvel,x
	
	pla
	sta	.yposh, x

	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	pla
	bmi	+	
	lda	#7
	ldy	#16
	bne	++
+	lda	#14
	ldy	#32
++

	sta	.color, x
	sta	Sprites.color + 8, x
	
	tya
	sta	.hits, x
	
	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides + 1
	sta	.pflags, x
	lda	#.AIElectro
	sta	.ai, x
		
	lda	#$40 + 72
	sta	.img, x

	lda	#<35
	sta	.scorel, x
	lda	#>35
	sta	.scoreh, x

	rts

.AddEnergyWall

	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-16
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	sta	.pathl, x

	lda	#3
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	lda	#7
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#.SFCollides
	sta	.sflags, x
	lda	#.PFCollides
	sta	.pflags, x
	lda	#.AIEnergyWall
	sta	.ai, x
	lda	Phase
	and	#$0f
	sta	.pathc, x
		
	lda	#$40 + 150
	sta	.img, x

	pla
	rts

.AddSentinel

	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-16
	sta	.xvel,x
	
	pla
	sta	.yposh, x

	lda	#12
	sta	.xsize, x
	lda	#11
	sta	.ysize, x
	
	lda	#2
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides + 3
	sta	.pflags, x
	lda	#.AIShooting
	sta	.ai, x
	lda	#127
	sta	.pathc, x
	lda	#0
	sta	.pathi, x
	
	lda	#16
	sta	.hits, x
	
	lda	#$40 + 76
	sta	.img, x

	lda	#<120
	sta	.scorel, x
	lda	#>120
	sta	.scoreh, x

	pla
	rts

.AddBreaker

	lda	#172
	sta	.xposh,x
	
	lda	#-32
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	
	pla
	sta	.yvel, x

	lda	#12
	sta	.xsize, x
	lda	#6
	sta	.ysize, x
	
	lda	#7
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides
	sta	.pflags, x
	lda	#.AIBreaker
	sta	.ai, x
	
	lda	#2
	sta	.hits, x
	
	lda	#$40 + 135
	sta	.img, x

	lda	#<40
	sta	.scorel, x
	lda	#>40
	sta	.scoreh, x

	lda	#<Sound.EnemyBreakerSound
	ldy	#>Sound.EnemyBreakerSound
	jsr	Sound.PlaySound
	
	rts

.AddBoomerang

	lda	#0
	sta	.xposh,x
	
	lda	#100
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	
	pla
	sta	.yvel, x
	
	lda	#-1
	sta	.xacc, x

	lda	#12
	sta	.xsize, x
	lda	#8
	sta	.ysize, x
	
	lda	#3
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides
	sta	.pflags, x
	lda	#.AIAccelerate
	sta	.ai, x
	
	lda	#2
	sta	.hits, x
	
	lda	#$40 + 149
	sta	.img, x

	lda	#<125
	sta	.scorel, x
	lda	#>125
	sta	.scoreh, x

	rts

.AddAssassin

	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-16
	sta	.xvel,x
	
	pla
	sta	.yposh, x

	lda	#12
	sta	.xsize, x
	lda	#11
	sta	.ysize, x
	
	lda	#2
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides + 3
	sta	.pflags, x
	lda	#.AIAssassin
	sta	.ai, x
	
	lda	#8
	sta	.hits, x
	
	lda	#$40 + 108
	sta	.img, x

	lda	#<250
	sta	.scorel, x
	lda	#>250
	sta	.scoreh, x

	pla
	rts

.ArrowPath0	!byte	40,  20,   5,  5,  -2, 0, 0
.ArrowPath1	!byte	0
.ArrowPath2	!byte	40,  20,  -5,  5,  -2, 0, 0
.ArrowIndex	!byte	0, .ArrowPath1 - .ArrowPath0, .ArrowPath2 -.ArrowPath0

.AddArrow
	
	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-64
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	
	lda	#12
	sta	.xsize, x
	lda	#5
	sta	.ysize, x
	
	pla
	pha
	bmi	+	
	lda	#13
	ldy	#2
	bne	++
+	lda	#5
	ldy	#4
++

	sta	.color, x
	sta	Sprites.color + 8, x
	
	tya
	sta	.hits, x
	
	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides + 3
	sta	.pflags, x
	lda	#.AIPath
	sta	.ai, x
	
	lda	#$40 + 52
	sta	.img, x


	lda	#<.ArrowPath0
	sta	.pathl, x
	sta	tmpl
	lda	#>.ArrowPath0
	sta	.pathh, x
	sta	tmph
	
	pla
	and	#$7f
	tay
	lda	.ArrowIndex,y
	tay
	
	lda	(tmpl),y
	sta	.pathc, x
	iny
	tya
	sta	.pathi, x
		
	lda	#<30
	sta	.scorel, x
	lda	#>30
	sta	.scoreh, x
	
	lda	#<Sound.EnemyArrowSound
	ldy	#>Sound.EnemyArrowSound
	jsr	Sound.PlaySound

	rts

.Arrow2Path0	!byte	20
		!byte    1,  0,  30
		!byte	 0,  3,   7
		!byte	 2,  2,  14
		!byte	 3,  0,  14
		!byte	 2, -2,  14
		!byte	 0, -3,  14
		!byte	-2, -2,  14
		!byte	-3,  0,  14
		!byte	-2,  2,  14
		!byte	 0,  5,   7
		!byte   -5,  0,   0

.Arrow2Path1	!byte	20
		!byte    1,  0,  30
		!byte	 0, -3,   7
		!byte	 2, -2,  14
		!byte	 3,  0,  14
		!byte	 2,  2,  14
		!byte	 0,  3,  14
		!byte	-2,  2,  14
		!byte	-3,  0,  14
		!byte	-2, -2,  14
		!byte	 0, -3,   7
		!byte   -5,  0,   0

.Arrow2Index	!byte	0, .Arrow2Path1 - .Arrow2Path0

.AddArrow2
	
	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-64
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	
	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	pla
	pha
	bmi	+	
	lda	#14
	ldy	#2
	bne	++
+	lda	#6
	ldy	#4
++

	sta	.color, x
	sta	Sprites.color + 8, x
	
	tya
	sta	.hits, x
	
	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides + 3
	sta	.pflags, x
	lda	#.AIPath
	sta	.ai, x 

	txa
	and	#3
	clc
	adc	#$40 + 88
	sta	.img, x

	lda	#<.Arrow2Path0
	sta	.pathl, x
	sta	tmpl
	lda	#>.Arrow2Path0
	sta	.pathh, x
	sta	tmph
	
	pla
	and	#$7f
	tay
	lda	.Arrow2Index,y
	tay
	
	lda	(tmpl),y
	sta	.pathc, x
	iny
	tya
	sta	.pathi, x
		
	lda	#<60
	sta	.scorel, x
	lda	#>60
	sta	.scoreh, x
	
	rts
	
.stime0	=	5
.stime1 = 	2 * .stime0

.SwarmPath0	!byte	10
		!byte	 2,  3,  .stime0
.SwarmPath0s	=	* - .SwarmPath0
		!byte	 2,  2,  Enemies.stime1
		!byte	 3,  0,  Enemies.stime1
		!byte	 2, -2,  Enemies.stime1
		!byte	 0, -3,  Enemies.stime1
		!byte	-2, -2,  Enemies.stime1
		!byte	-3,  0,  Enemies.stime1
		!byte	-2,  2,  Enemies.stime1
		!byte	 0,  3,  Enemies.stime1
.SwarmPath0e	=	* - .SwarmPath0

.SwarmPath1	!byte	10
		!byte	 2, -3,  .stime0

		!byte	 2, -2,  Enemies.stime1
		!byte	 3,  0,  Enemies.stime1
		!byte	 2,  2,  Enemies.stime1
		!byte	 0,  3,  Enemies.stime1
		!byte	-2,  2,  Enemies.stime1
		!byte	-3,  0,  Enemies.stime1
		!byte	-2, -2,  Enemies.stime1
		!byte	 0, -3,  Enemies.stime1

	
.AddSwarm
	
	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-64
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	
	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	lda	#13
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides + 3
	sta	.pflags, x
	lda	#.AIPath
	sta	.ai, x
	
	lda	#$40 + 176
	sta	.img, x

	lda	#2
	sta	.hits, x

	pla
	bne	+
	
	lda	#<.SwarmPath0
	ldy	#>.SwarmPath0
	jmp	++
+
	lda	#<.SwarmPath1
	ldy	#>.SwarmPath1
++
	
	sta	.pathl, x
	sta	tmpl
	tya
	sta	.pathh, x
	sta	tmph
	
	ldy	#0
	lda	(tmpl),y
	sta	.pathc, x
	iny
	tya
	sta	.pathi, x
	
	lda	#.SwarmPath0s
	sta	.paths, x
	lda	#.SwarmPath0e
	sta	.pathe, x
		
	lda	#<30
	sta	.scorel, x
	lda	#>30
	sta	.scoreh, x
	
;	lda	#<Sound.EnemyArrowSound
;	ldy	#>Sound.EnemyArrowSound
;	jsr	Sound.PlaySound

	rts


.SnakePath
		!byte	15, -32, 1
		!byte	0, 0, 20

.SnakePaths	= * - .SnakePath		
			
		!byte	-16, 0, 1
		!byte	0, 2, 32
		!byte	16, 0, 1
		!byte	0, 0, 50
		
		!byte	-16, 0, 1
		!byte	0, -2, 32
		!byte	16, 0, 1
		!byte	0, 0, 50

.SnakePathe	= * - .SnakePath		

.SnakeColor1		!byte	15, 14, 7, 0
.SnakeHits1		!byte	2, 4, 8, 12

.AddSnake
	
	lda	#0
	sta	.yvel,x

	lda	#160
	sta	.xposh,x
	
	lda	#-16
	sta	.xvel, x
	lda	#0
	sta	.yvel, x
	
	pla
	sta	.yposh, x
	
	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	pla
	tay
	lda	.SnakeColor1, y
	sta	.color, x
	sta	Sprites.color + 8, x
	lda	.SnakeHits1, y
	sta	.hits, x
	
	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides + 1
	sta	.pflags, x
	lda	#.AIPath
	sta	.ai, x
	
	lda	#$40 + 160
	sta	.img, x

	lda	#<.SnakePath
	sta	.pathl, x
	lda	#>.SnakePath
	sta	.pathh, x
	
	lda	#10
	sta	.pathc, x
	lda	#0
	sta	.pathi, x

	lda	#.SnakePaths
	sta	.paths, x
	lda	#.SnakePathe
	sta	.pathe, x
	
	lda	#<20
	sta	.scorel, x
	lda	#>20
	sta	.scoreh, x


	lda	#<Sound.EnemySnakeSound
	ldy	#>Sound.EnemySnakeSound
	jsr	Sound.PlaySound


	rts

	
.DiamondPath0		!byte	10,  0,   6,  20,  -1, -16, 10, -1,  8, 10, 0, -8, 10, 0,  8, 10,  0, -8, 10, 0,  8, 10, 0, -8, 10, 0,  8, 10,  0, -8, 10, 0,  8, 10, 0, -8, 10, 0,  4, 10, 0, 0, 0
.DiamondPath1		!byte	10,  0,   2,  20,  -1,  -8, 10, -1,  8, 10, 0, -8, 10, 0,  8, 10,  0, -8, 10, 0,  8, 10, 0, -8, 10, 0,  8, 10,  0, -8, 10, 0,  8, 10, 0, -8, 10, 0,  4, 10, 0, 0, 0
.DiamondPath2		!byte	10,  0,  -2,  20,  -1,   8, 10, -1, -8, 10, 0,  8, 10,  0, -8, 10, 0,  8, 10, 0, -8, 10, 0,  8, 10,  0, -8, 10, 0,  8, 10, 0, -8, 10, 0,  8, 10, 0, -4, 10, 0, 0, 0
.DiamondPath3		!byte	10,  0,  -6,  20,  -1,  16, 10, -1, -8, 10, 0,  8, 10,  0, -8, 10, 0,  8, 10, 0, -8, 10, 0,  8, 10,  0, -8, 10, 0,  8, 10, 0, -8, 10, 0,  8, 10, 0, -4, 10, 0, 0, 0
.DiamondIndex		!byte	0, .DiamondPath1 - .DiamondPath0, .DiamondPath2 -.DiamondPath0, .DiamondPath3 -.DiamondPath0

.AddDiamond
	
	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-48
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	
	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	pla
	pha
	bmi	+	
	lda	#15
	ldy	#2
	bne	++
+	lda	#7
	ldy	#4
++

	sta	.color, x
	sta	Sprites.color + 8, x
	
	tya
	sta	.hits, x
	
	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides + 7
	sta	.pflags, x
	lda	#.AIPath
	sta	.ai, x
	
	lda	#$40 + 124
	sta	.img, x

	lda	#<.DiamondPath0
	sta	.pathl, x
	sta	tmpl
	lda	#>.DiamondPath0
	sta	.pathh, x
	sta	tmph
	
	pla
	and	#$7f
	tay
	lda	.DiamondIndex,y
	tay
	
	lda	(tmpl),y
	sta	.pathc, x
	iny
	tya
	sta	.pathi, x
		
	lda	#<65
	sta	.scorel, x
	lda	#>65
	sta	.scoreh, x
	
	lda	#<Sound.EnemyArrowSound
	ldy	#>Sound.EnemyArrowSound
	jsr	Sound.PlaySound

	rts
	
.SquidPath0	!byte	15
		!byte	-1, -2,  15
		!byte	 0,  0,   5
		!byte    2,  0,  15
		!byte	 0, 5,   6
		!byte	 3, 3,   14
		!byte	5,  0,   14
		!byte	 3, -3,   14
		!byte	 0, -5,   7
		!byte	-3, -1,   14
		!byte	-5,  0,   14
		!byte	-3,  3,   14
		!byte	 0,  5,   6
		!byte  -5,  0,   0

.SquidPath1	!byte	15
		!byte	-1,  2,  15
		!byte	 0,  0,  5 
		!byte    2,  0,  15
		!byte	 0, -5,   6
		!byte	 3,  -3,  14
		!byte	5,  0,  14
		!byte	 3, 3,  14
		!byte	 0,  5,  7
		!byte	-3,  1,  14
		!byte	-5,  0,  14
		!byte	-3,  -3,  14
		!byte	 0,  -5,   6
		!byte  -5,  0,   0

.SquidIndex	!byte	0, .SquidPath1 - .SquidPath0

.AddSquid
	
	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-64
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	
	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	

	pla
	pha
	bmi	+	
	lda	#4
	ldy	#2
	bne	++
+	lda	#0
	ldy	#8
++

	sta	.color, x
	sta	Sprites.color + 8, x
	
	tya
	sta	.hits, x
	
	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides + 3
	sta	.pflags, x
	lda	#.AIPath
	sta	.ai, x 

	txa
	and	#3
	clc
	adc	#$40 + 104
	sta	.img, x

	lda	#<.SquidPath0
	sta	.pathl, x
	sta	tmpl
	lda	#>.SquidPath0
	sta	.pathh, x
	sta	tmph
	
	pla
	and	#$7f
	tay
	lda	.SquidIndex,y
	tay
	
	lda	(tmpl),y
	sta	.pathc, x
	iny
	tya
	sta	.pathi, x
		
	lda	#<80
	sta	.scorel, x
	lda	#>80
	sta	.scoreh, x
	
	lda	#<Sound.EnemySquidSound
	ldy	#>Sound.EnemySquidSound
	jsr	Sound.PlaySound

	rts
	

.CrossWipePath0	!byte	10, 0, 6, 10
		!byte	0, 0, 20, 0, -6, 20, 0, 0, 20, 0,  6, 20
		!byte	0, 0, 20, 0, -6, 20, 0, 0, 20, 0,  6, 20
		!byte	0, 0, 20, 0, -6, 20, 0, 0, 20, 0,  6, 20
		!byte	0, 0, 20, 0, -6, 20, 0, 0, 20, 0,  6, 20
		!byte	0, 0, 0
.CrossWipePath1	!byte	10, 0, -6, 10
		!byte	0, 0, 20, 0,  6, 20, 0, 0, 20, 0, -6, 20
		!byte	0, 0, 20, 0,  6, 20, 0, 0, 20, 0, -6, 20
		!byte	0, 0, 20, 0,  6, 20, 0, 0, 20, 0, -6, 20
		!byte	0, 0, 20, 0,  6, 20, 0, 0, 20, 0, -6, 20
		!byte	0, 0, 0
.CrossWipeIndex	!byte	0, .CrossWipePath1 - .CrossWipePath0

.AddCrossWipe
	
	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-36
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	
	lda	#12
	sta	.xsize, x
	lda	#5
	sta	.ysize, x
	
	lda	#7
	sta	.color, x
	sta	Sprites.color + 8,x
	
	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides + 3
	sta	.pflags, x
	lda	#.AIPath
	sta	.ai, x
	
	lda	#$40 + 92
	sta	.img, x

	lda	#2
	sta	.hits, x

	lda	#<.CrossWipePath0
	sta	.pathl, x
	sta	tmpl
	lda	#>.CrossWipePath0
	sta	.pathh, x
	sta	tmph
	
	pla
	tay
	lda	.CrossWipeIndex,y
	tay
	
	lda	(tmpl),y
	sta	.pathc, x
	iny
	tya
	sta	.pathi, x
		
	lda	#<175
	sta	.scorel, x
	lda	#>175
	sta	.scoreh, x
	
	rts

.SpikePath0	!byte	10, 0, 4, 10
		!byte	1,  0, 35,  0, -4, 20, -1, 0, 35,  0,  4, 20
		!byte	1,  0, 35,  0, -4, 20, -1, 0, 35,  0,  4, 20
		!byte	1,  0, 35,  0, -4, 20, -1, 0, 35,  0,  4, 20
		!byte	1,  0, 35,  0, -4, 20, -1, 0, 35,  0,  4, 20
		!byte	0, 0, 0

.SpikePath1	!byte	10, 0, -4, 10
		!byte	1,  0, 35,  0, 4, 20, -1, 0, 35,  0,  -4, 20
		!byte	1,  0, 35,  0, 4, 20, -1, 0, 35,  0,  -4, 20
		!byte	1,  0, 35,  0, 4, 20, -1, 0, 35,  0,  -4, 20
		!byte	1,  0, 35,  0, 4, 20, -1, 0, 35,  0,  -4, 20
		!byte	0, 0, 0

.AddSpike
	
	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-36
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	
	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	lda	#3
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#.SFCollides
	sta	.sflags, x
	lda	#.PFCollides
	sta	.pflags, x
	lda	#.AIPath
	sta	.ai, x
	
	pla
	pha
	and	#3
	clc
	adc	#$40 + 153
	sta	.img, x

	lda	#2
	sta	.hits, x

	pla
	and	#4
	bne	+
	
	lda	#<.SpikePath0
	sta	.pathl, x
	sta	tmpl
	lda	#>.SpikePath0
	sta	.pathh, x
	sta	tmph
	
	jmp	++
+
	lda	#<.SpikePath1
	sta	.pathl, x
	sta	tmpl
	lda	#>.SpikePath1
	sta	.pathh, x
	sta	tmph
++
	
	ldy	#0
	
	lda	(tmpl),y
	sta	.pathc, x
	iny
	tya
	sta	.pathi, x
		
	rts
	

.wv0a		=	2
.wv1a		=	4
.wvd1		=	11
.wvd2		=	2 * .wvd1

.WhirlingPath0F	!byte	255
		!byte	0, 0, 255
		
.WhirlingPath1F	!byte	30
		!byte	-1 * (.wvd1) * (.wv0a), 0, 1				
		!byte	     0,  .wv0a,  .wvd1
		!byte	 .wv0a,      0,  .wvd2
		!byte	     0, -.wv0a,  .wvd2
		!byte	-.wv0a,      0,  .wvd2
		!byte	     0,  .wv0a,  .wvd2
		

.WhirlingPath2F	!byte	30
		!byte	-1 * (.wvd1) * (.wv1a), 0, 1							
		!byte	     0,  .wv1a,  .wvd1
		!byte	 .wv1a,      0,  .wvd2
		!byte	     0, -.wv1a,  .wvd2
		!byte	-.wv1a,      0,  .wvd2
		!byte	     0,  .wv1a,  .wvd2
		

.WhirlingPath3F	!byte	30
		!byte	1 * (.wvd1) * (.wv0a), 0, 1				
		!byte	     0, -.wv0a,  .wvd1
		!byte	-.wv0a,      0,  .wvd2
		!byte	     0,  .wv0a,  .wvd2
		!byte	 .wv0a,      0,  .wvd2
		!byte	     0, -.wv0a,  .wvd2
		

.WhirlingPath4F	!byte	30
		!byte	1 * (.wvd1) * (.wv1a), 0, 1							
		!byte	     0, -.wv1a,  .wvd1
		!byte	-.wv1a,      0,  .wvd2
		!byte	     0,  .wv1a,  .wvd2
		!byte	 .wv1a,      0,  .wvd2
		!byte	     0, -.wv1a,  .wvd2
				
.WhirlingPath0B	!byte	255
		!byte	0, 0, 255
		
.WhirlingPath1B	!byte	30
		!byte	 1 * (.wvd1) * (.wv0a), 0, 1
		
		!byte	     0,  .wv0a,  .wvd1
		!byte	-.wv0a,      0,  .wvd2
		!byte	     0, -.wv0a,  .wvd2
		!byte	 .wv0a,      0,  .wvd2
		!byte	     0,  .wv0a,  .wvd2

.WhirlingPath2B	!byte	30
		!byte	 1 * (.wvd1) * (.wv1a), 0, 1							
		!byte	     0,  .wv1a,  .wvd1
		!byte	-.wv1a,      0,  .wvd2
		!byte	     0, -.wv1a,  .wvd2
		!byte	 .wv1a,      0,  .wvd2
		!byte	     0,  .wv1a,  .wvd2
		

.WhirlingPath3B	!byte	30
		!byte	-1 * (.wvd1) * (.wv0a), 0, 1				
		!byte	     0, -.wv0a,  .wvd1
		!byte	 .wv0a,      0,  .wvd2
		!byte	     0,  .wv0a,  .wvd2
		!byte	-.wv0a,      0,  .wvd2
		!byte	     0, -.wv0a,  .wvd2
		

.WhirlingPath4B	!byte	30
		!byte	-1 * (.wvd1) * (.wv1a), 0, 1							
		!byte	     0, -.wv1a,  .wvd1
		!byte	 .wv1a,      0,  .wvd2
		!byte	     0,  .wv1a,  .wvd2
		!byte	-.wv1a,      0,  .wvd2
		!byte	     0, -.wv1a,  .wvd2
		

.WhirlingPathsF	!byte	0, .WhirlingPath1F - .WhirlingPath0F, .WhirlingPath2F - .WhirlingPath0F, .WhirlingPath3F - .WhirlingPath0F, .WhirlingPath4F - .WhirlingPath0F
.WhirlingPathsB	!byte	0, .WhirlingPath1B - .WhirlingPath0B, .WhirlingPath2B - .WhirlingPath0B, .WhirlingPath3B - .WhirlingPath0B, .WhirlingPath4B - .WhirlingPath0B

.WhirlColor	!byte	3, 3, 7, 3, 7
.WhirlSprite	!byte	0, 1, 2, 1, 2

.AddWhirling
	
	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-18
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	
	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	lda	#.SFCollides
	sta	.sflags, x
	lda	#.PFCollides
	sta	.pflags, x
	lda	#.AIPath
	sta	.ai, x
	
	pla
	pha
	and	#7

	tay
	lda	.WhirlColor, y
	sta	.color, x
	sta	Sprites.color + 8, x
	lda	.WhirlSprite, y
	ora	#$40 + 156
	sta	.img, x

	lda	#2
	sta	.hits, x

	pla
	pha
	
	and	#7
	bne	+

	txa	
	pha
	
	lda	#<Sound.EnemyWhirlingSound	
	ldy	#>Sound.EnemyWhirlingSound	
	jsr	Sound.PlaySound
	
	pla
	tax
+

	pla
	tay	
	and	#8
	bne	+
	
	lda	.WhirlingPathsF, y
	tay
	
	lda	#<.WhirlingPath0F
	sta	.pathl, x
	sta	tmpl
	lda	#>.WhirlingPath0F
	sta	.pathh, x
	sta	tmph
	jmp	++
+
	tya
	and	#7
	tay
	
	lda	.WhirlingPathsB, y
	tay
	
	
	lda	#<.WhirlingPath0B
	sta	.pathl, x
	sta	tmpl
	lda	#>.WhirlingPath0B
	sta	.pathh, x
	sta	tmph
++	
	tya
	clc
	adc	#7
	sta	.paths, x
	adc	#12
	sta	.pathe, x
	
	lda	(tmpl),y
	sta	.pathc, x
	iny
	tya
	sta	.pathi, x
		
	rts
	
	
.AddDestroyer
	

	lda	#172
	sta	.xposh,x
	
	lda	#-32
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	
	pla
	sta	.yvel, x

	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x	
	
	lda	#2
	sta	.color, x
	sta	Sprites.color + 8, x

	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides + 3
	sta	.pflags, x
	lda	#.AIShooting
	sta	.ai, x
	lda	#63
	sta	.pathc, x
	lda	#0
	sta	.pathi, x

	lda	#$40 + 56
	sta	.img, x
	lda	#4
	sta	.hits, x

	lda	#<300
	sta	.scorel, x
	lda	#>300
	sta	.scoreh, x

	rts
	
.AddStarMine
	
	lda	#172
	sta	.xposh,x
	
	lda	#-46
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	pla
	sta	.yvel, x
	
	lda	#12
	sta	.xsize, x
	lda	#5
	sta	.ysize, x
		
	lda	#7
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides + 3
	sta	.pflags, x
	
	lda	#$40 + 60
	sta	.img, x
	lda	#2
	sta	.hits, x

	lda	#<250
	sta	.scorel, x
	lda	#>250
	sta	.scoreh, x
	
	rts
	
.AddHomingMissile
		
	lda	#172
	sta	.xposh,x
	
	jsr	Random.rand
	and	#63
	sbc	#31
	sta	.yvel,x

	jsr	Random.rand
	and	#$3f
	ora	#$c0
	sta	.xvel,x
	
	lda	#-1
	sta	.xacc, x
	
	pla
	sta	.yposh, x
	
	lda	#12
	sta	.xsize, x
	lda	#4
	sta	.ysize, x
	
	
	lda	#2
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides + 3
	sta	.pflags, x
	lda	#.AIHoming
	sta	.ai, x
	
	jsr	.pickplayer
	tya
	sta	.pathe, x
	
	jsr	Random.rand
	and	#15
	sec
	sbc	#8
	sta	.pathc, x
	
	lda	#$40 + 48
	sta	.img, x
	lda	#2
	sta	.hits, x

	lda	#<60
	sta	.scorel, x
	lda	#>60
	sta	.scoreh, x

	pla
	rts


.AddSAMissile
		
	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-16
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	
	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	
	lda	#2
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides + .PFYEscape
	sta	.pflags, x
	lda	#.AISAMissile
	sta	.ai, x
	
	
	lda	#$40 + 152
	sta	.img, x
	lda	#2
	sta	.hits, x

	lda	#<150
	sta	.scorel, x
	lda	#>150
	sta	.scoreh, x

	pla
	rts

.AddBombDrop
		
	lda	#0
	sta	.yvel,x

	lda	#172
	sta	.xposh,x
	
	lda	#-16
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	
	lda	#7
	sta	.xsize, x
	lda	#9
	sta	.ysize, x
	
	
	lda	#8
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides + .PFYEscape + 3
	sta	.pflags, x
	lda	#.AIBombDrop
	sta	.ai, x
	
	
	lda	#$40 + 164
	sta	.img, x
	lda	#2
	sta	.hits, x

	lda	#<150
	sta	.scorel, x
	lda	#>150
	sta	.scoreh, x

	pla
	rts

.AddGrowBlock
		
	lda	#0
	sta	.yvel,x

	lda	#168
	sta	.xposh,x
	
	lda	#0
	sta	.xvel,x
	
	pla
	sta	.yposh, x
	
	lda	#12
	sta	.xsize, x
	lda	#10
	sta	.ysize, x
	
	
	lda	#15
	sta	.color, x
	sta	Sprites.color + 8, x
	
	lda	#.SFCollides + .SFExplodes
	sta	.sflags, x
	lda	#.PFCollides + .PFYEscape
	sta	.pflags, x
	pla
	clc
	adc	#.AIGrowBlock0
	sta	.ai, x
	
	
	lda	#0
	sta	.pathi, x
	lda	#$40 + 172
	sta	.img, x
	lda	#40
	sta	.hits, x

	lda	#<150
	sta	.scorel, x
	lda	#>150
	sta	.scoreh, x

	lda	#<Sound.EnemyGrowBlockSound
	ldy	#>Sound.EnemyGrowBlockSound
	jsr	Sound.PlaySound
	rts



.DoAIHoming
	lda	.xposh, x
	cmp	#80
	bcc	.aihome2
	
	ldy	.pathe, x
	
	lda	.yvel, x
	cmp	#$80
	ror
	cmp	#$80
	ror
	adc	.yposh, x
	adc	.pathc, x
	cmp	Player.yposh, y
	
	lda	#-4
	bcs	.aihome1
	lda	#4
.aihome1
	sta	.yacc,x

	jmp	.DoAccelerate
.aihome2
	lda	.yvel,x
	beq	.aihome1
	bpl	+
	lda	#1
	bne	.aihome1
+	lda	#-1
	bne	.aihome1
	
.DoAIGrowBlock0
	lda	.pathi, x
	clc
	adc	#1
	and	#3
	sta	.pathi, x
	tay
	ora	#$40 + 172
	sta	.img, x
	tya
	bne	+
	lda	.xposh, x
	sec
	sbc	#12
	sta	.xposh, x
+	
	jmp	.DoAINone

.DoAIGrowBlock1
	lda	#$40 + 172 + 3
	sta	.img, x

	lda	.pathi, x
	clc
	adc	#1
	and	#3
	sta	.pathi, x
	bne	+
	lda	.xposh, x
	sec
	sbc	#12
	sta	.xposh, x
+	
	jmp	.DoAINone

.DoAIGrowBlock2
	lda	.pathi, x
	clc
	adc	#1
	and	#3
	sta	.pathi, x
	tay
	eor	#3
	ora	#$40 + 172
	sta	.img, x
	tya
	bne	+
	lda	.xposh, x
	sec
	sbc	#12
	sta	.xposh, x
+	
	jmp	.DoAINone
	
.DoAIBreaker
	lda	Phase
	and	#1
	beq	+
-	jmp	.DoAINone

+	lda	.yvel,x
	beq	-
	bpl	+
	inc	.yvel, x
	jmp	.DoAINone
+	dec	.yvel, x
	jmp	.DoAINone

.maxplayerx
	lda	Player.xposh
	bit	Game.twoplayer
	bpl	+
	bit	Player.state + 1
	bmi	+
	bit	Player.state
	bmi	++
	cmp	Player.xposh + 1
	bcc	++
+
	rts
++
	lda	Player.xposh + 1
	rts
	
.DoAISAMissile
	jsr	.maxplayerx

	clc	
	adc	#20
	cmp	.xposh, x
	bcc	+

	lda	#-5
	sta	.yacc, x
	
	lda	#.AIAccelerate
	sta	.ai, x

	txa
	pha
	
	lda	#<Sound.MissileLaunchSound
	ldy	#>Sound.MissileLaunchSound
	jsr	Sound.PlaySound
	
	pla
	tax

+	
	jmp	.DoAccelerate

.DoAIBombDrop
	jsr	.maxplayerx

	clc	
	adc	#20
	cmp	.xposh, x
	bcc	+

	lda	#5
	sta	.yacc, x
	
	lda	#.AIAccelerate
	sta	.ai, x

	txa
	pha
	
	lda	#<Sound.BombDropSound
	ldy	#>Sound.BombDropSound
	jsr	Sound.PlaySound
	
	pla
	tax

+	
	jmp	.DoAccelerate

.DoAIElectro	

	lda	Random.last
	and	#3
	bne	+
	
	txa
	pha

	lda	#<Sound.EnemyElectroSound
	ldy	#>Sound.EnemyElectroSound
	jsr	Sound.PlaySound
	
	pla
	tax
+	
	jmp	.DoAINone
	
.DoAIPath
	dec	.pathc, x
	bne	++
	lda	.pathl, x
	sta	tmpl
	lda	.pathh, x
	sta	tmph
	ldy	.pathi, x
	
	lda	(tmpl),y
	sta	.xacc, x
	iny
	lda	(tmpl),y
	sta	.yacc, x
	iny
	lda	(tmpl),y
	sta	.pathc, x
	iny
	tya

	cmp	.pathe, x
	bne	+
	lda	.paths, x
+
	sta	.pathi,x
++
	jmp	.DoAccelerate

.DoAIYOffset
	lda	.pathl, x
	sta	tmpl
	lda	.pathh, x
	sta	tmph
	ldy	.pathi, x
	
	lda	(tmpl),y
	sta	.yvel, x
	
	iny
	tya
	and	#63
	sta	.pathi, x
	jmp	.DoAINone
	
.DoAIYJitter
	ldy	.pathi, x
	lda	.MineJitter, y
	sta	.yvel, x
	iny
	tya
	and	#63
	sta	.pathi, x
	jmp	.DoAINone
	
.slwallvy	
	!byte	10, 128, 0, 32, -10, 128, 0, 32
	!byte	-10, 128, 0, 32, 10, 128, 0, 32

	!byte	20, 64, 0, 32, -20, 64, 0, 32
	!byte	-20, 64, 0, 32, 20, 64, 0, 32

	!byte	40, 32, 0, 32, -40, 32, 0, 32
	!byte	-40, 32, 0, 32, 40, 32, 0, 32

	!byte	80, 16, 0, 32, -80, 16, 0, 32
	!byte	-80, 16, 0, 32, 80, 16, 0, 32

	!byte	10, 32, 0, 32, -10, 32, 0, 32
	!byte	-10, 32, 0, 32, 10, 32, 0, 32

	!byte	20, 16, 0, 32, -20, 16, 0, 32
	!byte	-20, 16, 0, 32, 20, 16, 0, 32
	
	!byte	40, 8, 0, 32, -40, 8, 0, 32
	!byte	-40, 8, 0, 32, 40, 8, 0, 32

	!byte	40, 8, 0, 24, -40, 8, 0, 24
	!byte	-40, 8, 0, 24, 40, 8, 0, 24

.DoAISlidingWall
	dec	.pathc, x
	bne	++
	lda	.pathi, x
	tay
	clc
	adc	#2
	sta	.pathi, x
	and	#7
	bne	+
	sec
	lda	.pathi, x
	sbc	#8
	sta	.pathi, x
+
	
	lda	.slwallvy + 1, y
	sta	.pathc, x
	lda	.slwallvy + 0, y
	sta	.yvel, x
	
	beq	+
	txa
	pha
	lda	#<Sound.WallMoveSound
	ldy	#>Sound.WallMoveSound
	jsr	Sound.PlaySound
	pla
	tax
	jmp	++
+
	txa
	pha
	lda	#<Sound.WallHitSound
	ldy	#>Sound.WallHitSound
	jsr	Sound.PlaySound
	pla
	tax

++
	jmp	.DoAINone
	

.slwallvx
	!byte	30, 64, 0, 32, -30, 64, 0, 32
	!byte	-30, 64, 0, 32, 30, 64, 0, 32

	!byte	40, 32, 0, 32, -40, 32, 0, 32
	!byte	-40, 32, 0, 32, 40, 32, 0, 32

	!byte	40, 32, 0, 16, -40, 32, 0, 16
	!byte	-40, 32, 0, 16, 40, 32, 0, 16
	
	!byte	30, 32, -30, 64, 30, 32, 0, 32
	!byte	-30, 32, 30, 64, -30, 32, 0, 32
	
.DoAIShiftingWall
	dec	.pathc, x
	bne	++
	lda	.pathi, x
	tay
	clc
	adc	#2
	sta	.pathi, x
	and	#7
	bne	+
	sec
	lda	.pathi, x
	sbc	#8
	sta	.pathi, x
+
	sec
	lda	.slwallvx + 0, y
	sbc	#16
	sta	.xvel, x
	lda	.slwallvx + 1, y
	sta	.pathc, x

	lda	.slwallvx + 0, y
	beq	++
	
	txa
	pha
	lda	#<Sound.WallMoveSound
	ldy	#>Sound.WallMoveSound
	jsr	Sound.PlaySound
	pla
	tax

++
	jmp	.DoAINone
	

.DoAIShooting

	lda	.pathi, x
	bne	++

	txa
	clc
	adc	Random.last
	and	.pathc, x
	bne	+
	
	lda	#16
	sta	.pathi, x

	txa
	pha
	
	jsr	.AddShot
	
	pla
	tax
	
+
	jmp	.DoAINone
++
	dec	.pathi, x
	jmp	.DoAINone

.DoAIShootForward
	
	lda	.pathi, x
	bne	++

	sec
	lda	.xposh, x
	sbc	#20
	bcc	+
	cmp	Player.xposh
	bcc	+

	txa
	clc
	adc	Random.last
	and	.pathc, x
	bne	+
	
	lda	#16
	sta	.pathi, x
	
	txa
	pha
	
	jsr	.AddShot
	
	pla
	tax
	
+
	jmp	.DoAINone
++
	dec	.pathi, x
	jmp	.DoAINone

.DoAIAssassin
	
	txa
	clc
	adc	Random.last
	and	#$03
	bne	++
	
	lda	.yposh, x
	cmp	Player.yposh
	lda	#-1
	bcs	+
	lda	#1
+	sta	.yacc, x

++

	lda	.xposh, x
	sec
	sbc	#48
	bcc	+
	cmp	Player.xposh
	lda	#-1
	bcs	++
+	lda	#2
++	sta	.xacc, x
	
	jmp	.DoAccelerate
	
.energywallcolor	!byte	1, 14, 4, 4, 6, 7, 0, 0, 0, 0, 0, 6, 6, 4, 4, 14

.DoAIEnergyWall
	jsr	Random.rand
	lsr
	and	#$1f
	clc
	adc	.pathl, x
	sta	.yposh, x
	
	lda	Random.last
	and	#1
	ora	#$40 + 150
	sta	.img, x

	lda	Phase
	and	#$07
	beq	+
	jmp	.DoAINone
+
	
	lda	.pathc, x
	clc
	adc	#1
	and	#$0f
	sta	.pathc, x
	tay
	lda	.energywallcolor, y
	sta	.color, x
	sta	Sprites.color + 8, x
	beq	+
	lda	#.PFCollides
	sta	.pflags, x
	lda	#.SFCollides
	sta	.sflags, x
	jmp	.DoAINone
+
	sta	.pflags, x
	sta	.sflags, x
	jmp	.DoAINone
	

.bonuscolors	!byte	1, 7, 8, 2, 8, 7, 1, 14

.DoAIBonus
	lda	Phase
	lsr
	and	#7
	tay	
	lda	.bonuscolors, y
	sta	.color, x
	sta	Sprites.color + 8, x
	jmp	.DoAINone
	
.DoAIBoss1
	cpx	.boss
	bne	+
	jmp	.DoAIPath
+
	ldy	.boss
	lda	.xvel, y
	sta	.xvel, x
	lda	.yvel, y
	sta	.yvel, x
	
	lda	.type, x
	cmp	#3
	beq	.bosaitop
	cmp	#4
	beq	.bosaibot
	jmp	.DoAINone
.bosaitop
	lda	.pathc, x
	beq	+
	dec	.pathc, x
	jmp	.DoAINone
+	jsr	Random.rand
	and	#$1f
	bne	++
	txa
	pha	
	jsr	.AddShot	
	bcs	+
	lda	#-4
	adc	.yposh, x
	sta	.yposh, x
+	pla
	tax	
	lda	#16
	sta	.pathc, x
++	
	jmp	.DoAINone
	
.bosaibot
	lda	.pathc, x
	beq	+
	dec	.pathc, x
	jmp	.DoAINone
+	jsr	Random.rand
	and	#$1f
	bne	++
	txa
	pha	
	jsr	.AddShot
	bcs	+
	lda	#4
	adc	.yposh, x
	sta	.yposh, x
+	pla
	tax	
	lda	#16
	sta	.pathc, x
++	
	jmp	.DoAINone
	
	
.DoAIBoss2Electro
	ldy	.boss
	lda	.yposl, y
	sta	.yposl, x
	lda	.yposh, y
	clc
	adc	.pathi, x
	sta	.yposh, x

	lda	.bossp
	bne	++

	lda	.xposh, y
	sec
	sbc	#12
	sta	.xposh, x
	
	jsr	Random.rand
	and	#127
	bne	+
	lda	#1
	sta	.bossp
+	
	jmp	.DoAINone
++
	cpx	.bossf
	bne	+
	inc	.bossp
	inc	.bossp
+
	lda	.xposh, y
	sec
	sbc	#12
	cmp	.bossp
	bcs	+

	lda	#0
	sta	.bossp
	jmp	.DoAINone
+	
	txa
	pha
	
	jsr	Random.rand
	
	ldy	.bossp
	tax
	jsr	Math.umul8x8
	stx	tmpl
	pla
	tax
	
	ldy	.boss
	lda	.xposh, y
	sec
	sbc	#12
	sbc	tmpl
	sta	.xposh, x
	
	jmp	.DoAINone
	
	
.DoAIBoss3a
	cpx	.boss
	bne	+
	jmp	.DoAIPath
+
	ldy	.boss
	lda	.xvel, y
	sta	.xvel, x
	lda	.yvel, y
	sta	.yvel, x
	
	jmp	.DoAINone
	
.DoAIBoss3b
	cpx	.boss + 1
	bne	+
	jmp	.DoAIPath
+
	ldy	.boss + 1
	lda	.xvel, y
	sta	.xvel, x
	lda	.yvel, y
	sta	.yvel, x
	
	jmp	.DoAINone

.DoAIBoss4a
	cpx	.boss
	bne	+
	jmp	.DoAIPath
+
	ldy	.boss
	lda	.xvel, y
	sta	.xvel, x
	lda	.yvel, y
	sta	.yvel, x
	
	jmp	.DoAINone
	
.boss4bhitcolor	!byte	$0e, $07, $08, $04, $0f

.DoAIBoss4b
	ldy	.boss
	lda	.xposh, y
	sec
	sbc	#10
	sta	.xposh, x
	lda	.yposh, y
	sta	.yposh, x

	lda	.pathi, x
	clc
	adc	Phase
	and	#$3f
	tay
	
	clc
	lda	.xposh, x
	adc	Math.sin20, y
	sta	.xposh, x
	
	clc
	tya
	adc	#$10
	and	#$3f
	tay
	
	clc
	lda	.yposh, x
	adc	Math.sin20, y
	sta	.yposh, x
	
	lda	.hits, x
	lsr
	lsr
	lsr
	lsr
	tay
	lda	.color, x
	and	#$f0
	ora	.boss4bhitcolor, y
	sta	.color, x
	
	jmp	.DoAINone
	
.Move
	jsr	Random.rand
	
	lda	#$ff
	sta	.minx
	
	ldx	.head
	bpl	.mloop
-	

!if (0) {
	
	lda	.minx
	ldy	#42
	jsr	Game.PutHex

}
	rts

.mnext	tax
	bmi	-
	
.mloop

	
; Animate
	lda	.color, x
	bpl	+
	sec
	sbc	#$20
	sta	.color, x
	bmi	+
	sta	Sprites.color + 8, x	
+
	
	lda	.pflags, x
	and	#3
	beq	++
	and	Phase
	bne	++
	
	ldy	.img, x
	lda	.animtab, y
	sta	.img, x
	bne	++
	
	lda	.sflags,x
	and	#.SFExplosion
	beq	++
	
	jmp	.remove
++

; Do some "AI" work

.DoAI
	lda	.ai, x
	sta	.doaib + 1
.doaib
	bne	+
+
	jmp	.DoAINone
	jmp	.DoAIHoming
	jmp	.DoAIPath
	jmp	.DoAIShooting
	jmp	.DoAIAssassin
	jmp	.DoAIBonus
	jmp	.DoAISAMissile
	jmp	.DoAIYOffset
	jmp	.DoAIYJitter
	jmp	.DoAIShootForward
	jmp	.DoAIBreaker
	nop
	nop
	nop
	jmp	.DoAIEnergyWall
	jmp	.DoAIBoss1
	jmp	.DoAIBoss2Electro
	jmp	.DoAIBoss3a
	jmp	.DoAIBoss3b
	jmp	.DoAIElectro
	jmp	.DoAISlidingWall
	jmp	.DoAIShiftingWall
	jmp	.DoAIBombDrop
	jmp	.DoAIGrowBlock0
	jmp	.DoAIGrowBlock1
	jmp	.DoAIGrowBlock2
	jmp	.DoAIBoss4a
	jmp	.DoAIBoss4b
	; Intentional fall through
;	jmp	.DoAccelerate	

.DoAccelerate

!if ((.DoAccelerate - .doaib) != (2 + .AIAccelerate)) {
	!error "Invalid AI Jump table ", .DoAccelerate - .doaib
}

+
	lda	.xacc,x
	beq	+
	clc
	adc	.xvel,x
	bvs	+
	sta	.xvel,x
+

	lda	.yacc,x
	beq	+
	clc
	adc	.yvel,x
	bvs	+
	sta	.yvel,x
+
	
.DoAINone

; Move horizontal

	ldy	.xvel, x
	lda	Math.asl3, y
	clc
	adc	.xposl, x
	sta	.xposl, x
	lda	Math.asr5, y
	adc	.xposh, x	
	sta	.xposh, x

; Remove if outside of screen
	
	cmp	#173
	bcs	.remove
	
	cmp	.minx
	bcs	+
	sta	.minx
+

; Move vertical
	
	ldy	.yvel, x
	beq	.noymove
	lda	Math.asl3, y
	; carry is clear at this point
	adc	.yposl, x
	sta	.yposl, x
	lda	Math.asr5, y
	adc	.yposh, x
	sta	.yposh, x

; Check for bottem / top collision

	cmp	#25
	bcc	+
	cmp	#110
	bcs	+

.noymove
	
	lda	.succ, x
	jmp	.mnext
	
+
	lda	.pflags, x
	and	#.PFYEscape
	beq	+

.remove
	jsr	.Free
	tya
	jmp	.mnext
	
+
	lda	#25
	bcc	+
	lda	#109
+	sta	.yposh, x
	
	lda	#0
	sec	
	sbc	.yvel, x
	sta	.yvel, x
	jmp	.noymove
	
	
.Update	
	ldx	.head
	bmi	++
-	
	lda	.xposl, x
	asl
	lda	.xposh, x
	rol
	
	sta	Sprites.xposl + 8, x
	lda	#0
	rol
	sta	Sprites.xposh + 8, x
	
	lda	.yposl, x
	asl
	lda	.yposh, x
	rol
	
	sta	Sprites.ypos + 8, x

	lda	.img, x
	sta	Sprites.img + 8, x	
		
	lda	.succ, x
	tax
	bpl	-
++
	rts
	

