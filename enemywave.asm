	!zone	RespawnPoint

.size	=	20

		
.lives		=	$e900

.state0		=	.lives + .size
.state1		=	.state0 + .size

.slug		=	.state1 + .size
.laser		=	.slug + .size
.flame		=	.laser + .size
.drone		=	.flame + .size
.shield		=	.drone + .size
.missile	=	.shield + .size
.speed0		=	.missile + .size
.speed1		=	.speed0 + .size
.weapon0	=	.speed1 + .size
.weapon1	=	.weapon0 + .size
.level		=	.weapon1 + .size
.stars		=	.level + .size
.multiplier	=	.stars + .size
.score		=	.multiplier + .size

.current	!byte	0

.Init
	lda	#0
	sta	.current
	rts
	
.Save
	; do not save is player is just exploding his last ship here
	
	lda	Status.lives
	bne	+
	lda	Player.state
	and	Player.state + 1
	bpl	+
	rts
+

	ldx	.current

	lda	Status.lives
	sta	.lives, x
	
	; per player
	lda	Player.state + 0
	sta	.state0, x
	lda	Player.state + 1
	sta	.state1, x
	
	; joined player with two bits each
	lda	Player.laser + 0
	asl
	asl
	ora	Player.laser + 1	
	sta	.laser, x
	
	lda	Player.weapon + 0
	asl
	asl
	ora	Player.weapon + 1	
	sta	.slug, x
	
	lda	Player.flame + 0
	asl
	asl
	ora	Player.flame + 1
	sta	.flame, x
	
	; joined player with two bits each
	lda	Player.drone + 0
	asl
	asl
	ora	Player.drone + 1
	sta	.drone, x
	
	lda	Player.shield + 0
	asl
	asl
	ora	Player.shield + 1	
	sta	.shield, x
	
	lda	Player.missile + 0
	asl
	asl
	ora	Player.missile + 1
	sta	.missile, x
	
	; per player
	lda	Player.maxx + 0
	sta	.speed0, x
	lda	Player.maxx + 1
	sta	.speed1, x

	lda	PlayerWeapon.type + 0
	ora	PlayerWeapon.level + 0
	sta	.weapon0, x

	lda	PlayerWeapon.type + 1
	ora	PlayerWeapon.level + 1
	sta	.weapon1, x
	
	lda	EnemyWave.leveli
	lsr
	sta	.level, x
	
	lda	Status.stars
	sta	.stars, x
	lda	Status.multiplier
	sta	.multiplier, x
	
	lda	Status.ScoresScreen + 0
	sta	.score + 0 * .size, x
	lda	Status.ScoresScreen + 1
	sta	.score + 1 * .size, x
	lda	Status.ScoresScreen + 2
	sta	.score + 2 * .size, x
	lda	Status.ScoresScreen + 3
	sta	.score + 3 * .size, x
	lda	Status.ScoresScreen + 4
	sta	.score + 4 * .size, x
	lda	Status.ScoresScreen + 5
	sta	.score + 5 * .size, x
	lda	Status.ScoresScreen + 6
	sta	.score + 6 * .size, x
	lda	Status.ScoresScreen + 7
	sta	.score + 7 * .size, x
	
	inx
	stx	.current
	rts

.Restore
	ldx	.current
	bne	+
	rts
+
	dex
	stx	.current

	lda	.lives, x
	sta	Status.lives
	
	lda	.state0, x
	sta	Player.state + 0
	lda	.state1, x
	sta	Player.state + 1
	
	lda	.laser, x
	lsr
	lsr
	sta	Player.laser + 0
	lda	.laser, x
	and	#3
	sta	Player.laser + 1
	
	lda	.slug, x
	lsr
	lsr
	sta	Player.weapon + 0
	lda	.slug, x
	and	#3
	sta	Player.weapon + 1

	lda	.flame, x
	lsr
	lsr
	sta	Player.flame + 0
	lda	.flame, x
	and	#3
	sta	Player.flame + 1

	lda	.drone, x
	lsr
	lsr
	sta	Player.drone + 0
	lda	.drone, x
	and	#3
	sta	Player.drone + 1

	lda	.shield, x
	lsr
	lsr
	sta	Player.shield + 0
	lda	.shield, x
	and	#3
	sta	Player.shield + 1

	lda	.missile, x
	lsr
	lsr
	sta	Player.missile + 0
	lda	.missile, x
	and	#3
	sta	Player.missile + 1
	
	lda	.speed0, x
	sta	Player.maxx + 0
	sta	Player.maxy + 0
	eor	#$ff
	clc
	adc	#1
	sta	Player.minx + 0
	sta	Player.miny + 0	

	lda	.speed1, x
	sta	Player.maxx + 1
	sta	Player.maxy + 1
	eor	#$ff
	clc
	adc	#1
	sta	Player.minx + 1
	sta	Player.miny + 1	
	
	lda	.stars, x
	sta	Status.stars
	ldy	.multiplier, x
	dey
	beq	+
-
	jsr	Status.IncMultiplier
	dey
	bne	-
+
	lda	.score + 0 * .size, x
	sta	Status.ScoresScreen + 0
	lda	.score + 1 * .size, x
	sta	Status.ScoresScreen + 1
	lda	.score + 2 * .size, x
	sta	Status.ScoresScreen + 2
	lda	.score + 3 * .size, x
	sta	Status.ScoresScreen + 3
	lda	.score + 4 * .size, x
	sta	Status.ScoresScreen + 4
	lda	.score + 5 * .size, x
	sta	Status.ScoresScreen + 5
	lda	.score + 6 * .size, x
	sta	Status.ScoresScreen + 6
	lda	.score + 7 * .size, x
	sta	Status.ScoresScreen + 7

	lda	.weapon0, x
	ldx	#0
	jsr	PlayerWeapon.Select
	
	ldx	.current
	lda	.weapon1, x
	ldx	#1
	jsr	PlayerWeapon.Select
	
	ldx	.current
	lda	.level, x
	sta	EnemyWave.startlevel

	jsr	Status.DrawLives

	rts



	!zone	EnemyWave
.type	=	0
.param	=	1
.ypos	=	2


.CDone		=	$00
.CSleep		=	$80
.CLevel		=	$81
.CText		=	$82
.CWait		=	$83
.CSound		=	$84
.CCompleted	=	$85
.CLoop		=	$c0

.DelayWave
	!byte	.CSleep, 255
	!byte	.CDone
	
.DelayWave1
	!byte	.CSleep,  16
	!byte	.CDone

.DelayWave2
	!byte	.CSleep,  32
	!byte	.CDone

.DelayWave3
	!byte	.CSleep,  48
	!byte	.CDone


.DelayWave4
	!byte	.CSleep,  64
	!byte	.CDone

.DelayWave6
	!byte	.CSleep,  96
	!byte	.CDone

.DelayWave8
	!byte	.CSleep, 128
	!byte	.CDone

.DelayWave16
	!byte	.CSleep, 128
	!byte	.CSleep, 128
	!byte	.CDone

.WallWaveLargeTop
	!byte	Enemies.TWall,     $00,  29
	!byte	Enemies.TWall,     $81,  39
	!byte	Enemies.TWall,     $01,  50
	!byte	Enemies.TWall,     $83,  60
	!byte	Enemies.TWall,     $01,  71
	!byte	Enemies.TWall,     $82,  81
	!byte	.CSleep,	 128
	!byte	.CDone

	
.WallWaveLargeBottom
	!byte	Enemies.TWall,     $00,  44
	!byte	Enemies.TWall,     $81,  54
	!byte	Enemies.TWall,     $04,  65
	!byte	Enemies.TWall,     $81,  75
	!byte	Enemies.TWall,     $01,  86
	!byte	Enemies.TWall,     $82,  96
	!byte	.CSleep,	 128
	!byte	.CDone
	
.WallWaveLargeGate
	!byte	Enemies.TWall,     $00,  29
	!byte	Enemies.TWall,     $81,  39
	!byte	Enemies.TWall,     $02,  50

	!byte	Enemies.TWall,     $00,  75
	!byte	Enemies.TWall,     $81,  85
	!byte	Enemies.TWall,     $02,  96
	!byte	.CSleep,	 128
	!byte	.CDone
	
.WallWaveLargeTopButton
	!byte	Enemies.TButton,   0,  40
	!byte	.CSleep,	  12
	!byte	Enemies.TWall,     $00,  31
	!byte	Enemies.TWall,     $81,  41
	!byte	Enemies.TWall,     $01,  52
	!byte	Enemies.TWall,     $81,  62
	!byte	Enemies.TGate,     $00,  73
	!byte	Enemies.TGate,     $80,  83
	!byte	Enemies.TWall,     $02,  94
	!byte	.CSleep,	 128
	!byte	.CDone
	
	
.WallWaveLargeBottomButton
	!byte	Enemies.TButton,   0,  80
	!byte	.CSleep,	  12
	!byte	Enemies.TWall,     $00,  31
	!byte	Enemies.TGate,     $80,  41
	!byte	Enemies.TGate,     $00,  52
	!byte	Enemies.TWall,     $81,  62
	!byte	Enemies.TWall,     $01,  73
	!byte	Enemies.TWall,     $81,  83
	!byte	Enemies.TWall,     $02,  94
	!byte	.CSleep,	 128
	!byte	.CDone
	
.WallWaveMid1
	!byte	Enemies.TWall,     $00,  29
	!byte	Enemies.TWall,     $81,  39
	!byte	Enemies.TWall,     $03,  50
	!byte	Enemies.TWall,     $82,  60
	!byte	.CSleep,	  96
	!byte	.CDone

.WallWaveMid2
	!byte	Enemies.TWall,     $00,  41
	!byte	Enemies.TWall,     $84,  51
	!byte	Enemies.TWall,     $01,  62
	!byte	Enemies.TWall,     $82,  72
	!byte	.CSleep,	  96
	!byte	.CDone

.WallWaveMid3
	!byte	Enemies.TWall,     $00,  54
	!byte	Enemies.TWall,     $81,  64
	!byte	Enemies.TWall,     $04,  75
	!byte	Enemies.TWall,     $82,  85
	!byte	.CSleep,	  96
	!byte	.CDone

.WallWaveMid4
	!byte	Enemies.TWall,     $00,  67
	!byte	Enemies.TWall,     $83,  77
	!byte	Enemies.TWall,     $01,  88
	!byte	Enemies.TWall,     $82,  98
	!byte	.CSleep,	  96
	!byte	.CDone


	
.EnergyWallWave1
	!byte	Enemies.TWall,     $00,  29
	!byte	Enemies.TWall,     $85,  39
	!byte	Enemies.TWall,     $06,  92
	!byte	Enemies.TWall,     $82, 102
	!byte	.CSleep,	   8
	!byte	Enemies.TEnergyWall, 0, 50
	!byte	Enemies.TEnergyWall, 0, 50
	!byte	.CSleep,	 192
	!byte	.CDone
	
.EnergyWallWave2
	!byte	Enemies.TWall,     $00,  29
	!byte	Enemies.TWall,     $85,  39
	!byte	Enemies.TWall,     $06,  92
	!byte	Enemies.TWall,     $82, 102
	!byte	.CSleep,	   8
	!byte	Enemies.TEnergyWall, 0, 50
	!byte	Enemies.TEnergyWall, 0, 50
	!byte	.CSleep,	  64
	!byte	.CDone

.WallSlideWaveMid1a
	!byte	Enemies.TSlidingWall,   $80,  29
	!byte	Enemies.TSlidingWall,   $01,  40
	!byte	Enemies.TSlidingWall,   $81,  50
	!byte	Enemies.TSlidingWall,   $02,  61
	!byte	.CSleep,	 	112
	!byte	.CDone

.WallSlideWaveMid1b
	!byte	Enemies.TSlidingWall,   $88,  71
	!byte	Enemies.TSlidingWall,   $09,  82
	!byte	Enemies.TSlidingWall,   $89,  92
	!byte	Enemies.TSlidingWall,   $0a, 103
	!byte	.CSleep,	 	112
	!byte	.CDone

.WallSlideWaveMid2a
	!byte	Enemies.TSlidingWall,   $90,  29
	!byte	Enemies.TSlidingWall,   $11,  40
	!byte	Enemies.TSlidingWall,   $91,  50
	!byte	Enemies.TSlidingWall,   $12,  61
	!byte	.CSleep,	 	112
	!byte	.CDone

.WallSlideWaveMid2b
	!byte	Enemies.TSlidingWall,   $98,  71
	!byte	Enemies.TSlidingWall,   $19,  82
	!byte	Enemies.TSlidingWall,   $99,  92
	!byte	Enemies.TSlidingWall,   $1a, 103
	!byte	.CSleep,	 	112
	!byte	.CDone
	
.WallSlideWaveMid3a
	!byte	Enemies.TSlidingWall,   $a0,  29
	!byte	Enemies.TSlidingWall,   $21,  40
	!byte	Enemies.TSlidingWall,   $a1,  50
	!byte	Enemies.TSlidingWall,   $22,  61
	!byte	.CSleep,	 	112
	!byte	.CDone

.WallSlideWaveMid3b
	!byte	Enemies.TSlidingWall,   $a8,  71
	!byte	Enemies.TSlidingWall,   $29,  82
	!byte	Enemies.TSlidingWall,   $a9,  92
	!byte	Enemies.TSlidingWall,   $2a, 103
	!byte	.CSleep,	 	112
	!byte	.CDone

.WallSlideWaveMid4a
	!byte	Enemies.TSlidingWall,   $b0,  29
	!byte	Enemies.TSlidingWall,   $31,  40
	!byte	Enemies.TSlidingWall,   $b1,  50
	!byte	Enemies.TSlidingWall,   $32,  61
	!byte	.CSleep,	 	112
	!byte	.CDone

.WallSlideWaveMid4b
	!byte	Enemies.TSlidingWall,   $b8,  71
	!byte	Enemies.TSlidingWall,   $39,  82
	!byte	Enemies.TSlidingWall,   $b9,  92
	!byte	Enemies.TSlidingWall,   $3a, 103
	!byte	.CSleep,	 	112
	!byte	.CDone


.WallSlideWaveDoor1a
	!byte	Enemies.TSlidingWall,   $40,  28
	!byte	Enemies.TSlidingWall,   $c1,  38
	!byte	Enemies.TSlidingWall,   $42,  49

	!byte	Enemies.TSlidingWall,   $48,  80
	!byte	Enemies.TSlidingWall,   $c9,  90
	!byte	Enemies.TSlidingWall,   $4a, 101

	!byte	.CSleep,	 	112
	!byte	.CDone
	
.WallSlideWaveDoor2a
	!byte	Enemies.TSlidingWall,   $50,  28
	!byte	Enemies.TSlidingWall,   $d1,  38
	!byte	Enemies.TSlidingWall,   $52,  49

	!byte	Enemies.TSlidingWall,   $58,  80
	!byte	Enemies.TSlidingWall,   $d9,  90
	!byte	Enemies.TSlidingWall,   $5a, 101

	!byte	.CSleep,	 	112
	!byte	.CDone

.WallSlideWaveDoor3a
	!byte	Enemies.TSlidingWall,   $60,  28
	!byte	Enemies.TSlidingWall,   $e1,  38
	!byte	Enemies.TSlidingWall,   $62,  49

	!byte	Enemies.TSlidingWall,   $68,  80
	!byte	Enemies.TSlidingWall,   $e9,  90
	!byte	Enemies.TSlidingWall,   $6a, 101

	!byte	.CSleep,	 	112
	!byte	.CDone

.WallSlideWaveDoor4a
	!byte	Enemies.TSlidingWall,   $70,  28
	!byte	Enemies.TSlidingWall,   $f1,  38
	!byte	Enemies.TSlidingWall,   $72,  49

	!byte	Enemies.TSlidingWall,   $78,  80
	!byte	Enemies.TSlidingWall,   $f9,  90
	!byte	Enemies.TSlidingWall,   $7a, 101

	!byte	.CSleep,	 	112
	!byte	.CDone
	
.WallShiftWave1a
	!byte	Enemies.TShiftingWall,   $00,  28
	!byte	Enemies.TShiftingWall,   $81,  38
	!byte	Enemies.TShiftingWall,   $01,  49
	!byte	Enemies.TShiftingWall,   $82,  59
	!byte	Enemies.TWall,		 $00,  70
	!byte	Enemies.TWall,           $81,  80
	!byte	Enemies.TWall,           $01,  91
	!byte	Enemies.TWall,           $82, 101
	!byte	.CSleep,	 	 120
	!byte	Enemies.TWall,		 $00,  70
	!byte	Enemies.TWall,           $81,  80
	!byte	Enemies.TWall,           $01,  91
	!byte	Enemies.TWall,           $82, 101

	!byte	.CSleep,	 	 128
	!byte	.CDone

.WallShiftWave1b
	!byte	Enemies.TShiftingWall,   $00,  70
	!byte	Enemies.TShiftingWall,   $81,  80
	!byte	Enemies.TShiftingWall,   $01,  91
	!byte	Enemies.TShiftingWall,   $82, 101
	!byte	Enemies.TWall,		 $00,  28
	!byte	Enemies.TWall,           $81,  38
	!byte	Enemies.TWall,           $01,  49
	!byte	Enemies.TWall,           $82,  59
	!byte	.CSleep,	 	 120
	!byte	Enemies.TWall,		 $00,  28
	!byte	Enemies.TWall,           $81,  38
	!byte	Enemies.TWall,           $01,  49
	!byte	Enemies.TWall,           $82,  59

	!byte	.CSleep,	 	 128
	!byte	.CDone

.WallShiftWave2a
	!byte	Enemies.TShiftingWall,   $30,  28
	!byte	Enemies.TShiftingWall,   $b1,  38
	!byte	Enemies.TShiftingWall,   $31,  49
	!byte	Enemies.TShiftingWall,   $b2,  59
	!byte	Enemies.TShiftingWall,   $38,  70
	!byte	Enemies.TShiftingWall,   $b9,  80
	!byte	Enemies.TShiftingWall,   $39,  91
	!byte	Enemies.TShiftingWall,   $ba, 101

	!byte	.CSleep,	 	 128
	!byte	.CDone

.WallShiftWave2b
	!byte	Enemies.TShiftingWall,   $38,  28
	!byte	Enemies.TShiftingWall,   $b9,  38
	!byte	Enemies.TShiftingWall,   $39,  49
	!byte	Enemies.TShiftingWall,   $ba,  59
	!byte	Enemies.TShiftingWall,   $30,  70
	!byte	Enemies.TShiftingWall,   $b1,  80
	!byte	Enemies.TShiftingWall,   $31,  91
	!byte	Enemies.TShiftingWall,   $b2, 101

	!byte	.CSleep,	 	 128
	!byte	.CDone

.WallShiftWave3a
	!byte	Enemies.TShiftingWall,   $00,  28
	!byte	Enemies.TShiftingWall,   $81,  38
	!byte	Enemies.TShiftingWall,   $01,  49
	!byte	Enemies.TShiftingWall,   $82,  59
	!byte	Enemies.TWall,		 $00,  70
	!byte	Enemies.TWall,           $81,  80
	!byte	Enemies.TWall,           $01,  91
	!byte	Enemies.TWall,           $82, 101
	!byte	.CSleep,	 	 120
	!byte	Enemies.TWall,		 $00,  70
	!byte	Enemies.TWall,           $81,  80
	!byte	Enemies.TWall,           $01,  91
	!byte	Enemies.TWall,           $82, 101
	!byte	.CSleep,	 	 120
	!byte	Enemies.TShiftingWall,   $08,  28
	!byte	Enemies.TShiftingWall,   $89,  38
	!byte	Enemies.TShiftingWall,   $09,  49
	!byte	Enemies.TShiftingWall,   $8a,  59
	!byte	Enemies.TWall,		 $00,  70
	!byte	Enemies.TWall,           $81,  80
	!byte	Enemies.TWall,           $01,  91
	!byte	Enemies.TWall,           $82, 101

	!byte	.CSleep,	 	 128
	!byte	.CDone

.WallShiftWave3b
	!byte	Enemies.TShiftingWall,   $00,  70
	!byte	Enemies.TShiftingWall,   $81,  80
	!byte	Enemies.TShiftingWall,   $01,  91
	!byte	Enemies.TShiftingWall,   $82, 101
	!byte	Enemies.TWall,		 $00,  28
	!byte	Enemies.TWall,           $81,  38
	!byte	Enemies.TWall,           $01,  49
	!byte	Enemies.TWall,           $82,  59
	!byte	.CSleep,	 	 120
	!byte	Enemies.TWall,		 $00,  28
	!byte	Enemies.TWall,           $81,  38
	!byte	Enemies.TWall,           $01,  49
	!byte	Enemies.TWall,           $82,  59
	!byte	.CSleep,	 	 120
	!byte	Enemies.TShiftingWall,   $08,  70
	!byte	Enemies.TShiftingWall,   $89,  80
	!byte	Enemies.TShiftingWall,   $09,  91
	!byte	Enemies.TShiftingWall,   $8a, 101
	!byte	Enemies.TWall,		 $00,  28
	!byte	Enemies.TWall,           $81,  38
	!byte	Enemies.TWall,           $01,  49
	!byte	Enemies.TWall,           $82,  59

	!byte	.CSleep,	 	 128
	!byte	.CDone

.WallShiftWave4a
	!byte	Enemies.TShiftingWall,   $80,  28
	!byte	Enemies.TShiftingWall,   $01,  39
	!byte	Enemies.TShiftingWall,   $82,  49

	!byte	Enemies.TWall,		 $00,  60
	!byte	Enemies.TWall,           $82,  70

	!byte	Enemies.TShiftingWall,   $08,  81
	!byte	Enemies.TShiftingWall,   $89,  91
	!byte	Enemies.TShiftingWall,   $0a, 102

	!byte	.CSleep,	 	 160
	!byte	.CDone

.WallShiftWave5a
	!byte	Enemies.TShiftingWall,   $90,  28
	!byte	Enemies.TShiftingWall,   $11,  39
	!byte	Enemies.TShiftingWall,   $92,  49

	!byte	Enemies.TWall,		 $00,  60
	!byte	Enemies.TWall,           $82,  70

	!byte	Enemies.TShiftingWall,   $18,  81
	!byte	Enemies.TShiftingWall,   $99,  91
	!byte	Enemies.TShiftingWall,   $1a, 102

	!byte	.CSleep,	 	 144
	!byte	.CDone

.WallShiftWave6a
	!byte	Enemies.TShiftingWall,   $a0,  28
	!byte	Enemies.TShiftingWall,   $21,  39
	!byte	Enemies.TShiftingWall,   $a2,  49

	!byte	Enemies.TWall,		 $00,  60
	!byte	Enemies.TWall,           $82,  70

	!byte	Enemies.TShiftingWall,   $28,  81
	!byte	Enemies.TShiftingWall,   $a9,  91
	!byte	Enemies.TShiftingWall,   $2a, 102

	!byte	.CSleep,	 	 128
	!byte	.CDone

.WallShiftWave4b
	!byte	Enemies.TShiftingWall,   $88,  28
	!byte	Enemies.TShiftingWall,   $09,  39
	!byte	Enemies.TShiftingWall,   $8a,  49

	!byte	Enemies.TWall,		 $00,  60
	!byte	Enemies.TWall,           $82,  70

	!byte	Enemies.TShiftingWall,   $00,  81
	!byte	Enemies.TShiftingWall,   $81,  91
	!byte	Enemies.TShiftingWall,   $02, 102

	!byte	.CSleep,	 	 160
	!byte	.CDone

.WallShiftWave5b
	!byte	Enemies.TShiftingWall,   $98,  28
	!byte	Enemies.TShiftingWall,   $19,  39
	!byte	Enemies.TShiftingWall,   $9a,  49

	!byte	Enemies.TWall,		 $00,  60
	!byte	Enemies.TWall,           $82,  70

	!byte	Enemies.TShiftingWall,   $10,  81
	!byte	Enemies.TShiftingWall,   $91,  91
	!byte	Enemies.TShiftingWall,   $12, 102

	!byte	.CSleep,	 	 144
	!byte	.CDone

.WallShiftWave6b
	!byte	Enemies.TShiftingWall,   $a8,  28
	!byte	Enemies.TShiftingWall,   $29,  39
	!byte	Enemies.TShiftingWall,   $aa,  49

	!byte	Enemies.TWall,		 $00,  60
	!byte	Enemies.TWall,           $82,  70

	!byte	Enemies.TShiftingWall,   $20,  81
	!byte	Enemies.TShiftingWall,   $a1,  91
	!byte	Enemies.TShiftingWall,   $22, 102

	!byte	.CSleep,	 	 128
	!byte	.CDone

;.LevelTest
;	!word	.DelayWave, .WallSlideWaveMid1a, .WallSlideWaveMid1b, .WallSlideWaveDoor1a, .DelayWave, .WallSlideWaveMid2a, .WallSlideWaveMid2b, .WallSlideWaveDoor2a, .DelayWave, .WallSlideWaveMid3a, .WallSlideWaveMid3b, .WallSlideWaveDoor3a, .DelayWave, .WallSlideWaveMid4a, .WallSlideWaveMid4b, .WallSlideWaveDoor4a, .DelayWave
;	!word	.DelayWave, .WallShiftWave4a, .WallShiftWave4a, .WallShiftWave4a, .DelayWave, .WallShiftWave5a, .WallShiftWave5a, .WallShiftWave5a, .DelayWave, .WallShiftWave6a, .WallShiftWave6a, .WallShiftWave6a, .DelayWave

	

.WallShootWaveTop
	!byte	Enemies.TWall,     $00,  24
	!byte	Enemies.TWallGun,  $81,  34
	!byte	Enemies.TWall,     $01,  45
	!byte	Enemies.TWall,     $84,  55
	!byte	Enemies.TWall,     $01,  66
	!byte	Enemies.TWall,     $82,  76

	!byte	.CSleep,	 128
	!byte	.CDone

.WallShootWaveBottom
	!byte	Enemies.TWall,     $00,  44
	!byte	Enemies.TWall,     $81,  54
	!byte	Enemies.TWall,     $03,  65
	!byte	Enemies.TWall,     $81,  75
	!byte	Enemies.TWallGun,  $01,  86
	!byte	Enemies.TWall,     $82,  96
	
	!byte	.CSleep,	 128
	!byte	.CDone

.WallShootWaveGate
	!byte	Enemies.TWall,     $00,  24
	!byte	Enemies.TWallGun,  $81,  34
	!byte	Enemies.TWall,     $02,  45

	!byte	Enemies.TWall,     $00,  75
	!byte	Enemies.TWallGun,  $81,  85
	!byte	Enemies.TWall,     $02,  96
	
	!byte	.CSleep,	 128
	!byte	.CDone


.WallWaveElectroTop
	!byte	Enemies.TWall,     $00,  28
	!byte	Enemies.TWall,     $81,  38
	!byte	Enemies.TWall,     $01,  49
	!byte	Enemies.TWall,     $85,  59
	!byte	Enemies.TElectro,  $00,  70
	!byte	Enemies.TWall,     $86,  80
	!byte	Enemies.TWall,     $04,  91
	!byte	Enemies.TWall,     $82, 101

	!byte	.CSleep,	 254
	!byte	.CDone

.WallWaveElectroBottom
	!byte	Enemies.TWall,     $80,  28
	!byte	Enemies.TWall,     $03,  39
	!byte	Enemies.TWall,     $85,  49
	!byte	Enemies.TElectro,  $00,  60
	!byte	Enemies.TWall,     $86,  70
	!byte	Enemies.TWall,     $01,  81
	!byte	Enemies.TWall,     $81,  91
	!byte	Enemies.TWall,     $02, 102

	!byte	.CSleep,	254
	!byte	.CDone


.WallWaveElectroTop2
	!byte	Enemies.TWall,     $00,  28
	!byte	Enemies.TWall,     $81,  38
	!byte	Enemies.TWall,     $01,  49
	!byte	Enemies.TWall,     $84,  59
	!byte	Enemies.TWall,     $05,  70
	!byte	Enemies.TElectro,  $80,  80
	!byte	Enemies.TWall,     $06,  91
	!byte	Enemies.TWall,     $82, 101
	
	!byte	.CSleep,	128
	!byte	.CDone

.WallWaveElectroBottom2
	!byte	Enemies.TWall,     $80,  28
	!byte	Enemies.TWall,     $05,  39
	!byte	Enemies.TElectro,  $80,  49
	!byte	Enemies.TWall,     $06,  60
	!byte	Enemies.TWall,     $84,  70
	!byte	Enemies.TWall,     $03,  81
	!byte	Enemies.TWall,     $81,  91
	!byte	Enemies.TWall,     $02, 102

	!byte	.CSleep,	128
	!byte	.CDone
	
	
.WallWaveDownSlopeTop
	!byte	Enemies.TWall,	   34,  20
	!byte	.CSleep,	    4
	!byte	.CLoop + 4,	   10,  10
	!byte	Enemies.TWall,	   31,  30
	!byte	Enemies.TWall,	   31,  70
	!byte	.CSleep,	    4
	!byte	Enemies.TWall,	   34,  80

	!byte	.CSleep,	  128
	!byte	.CDone


.WallWaveDownSlopeBottom
	!byte	Enemies.TWall,	   34,  40
	!byte	.CSleep,	    4
	!byte	.CLoop + 4,	   10,  10
	!byte	Enemies.TWall,	   31,  50
	!byte	Enemies.TWall,	   31,  90
	!byte	.CSleep,	    4
	!byte	Enemies.TWall,	   34, 100
	
	!byte	.CSleep,	  128
	!byte	.CDone

.WallWaveUpSlopeTop
	!byte	Enemies.TWall,	   34,  80
	!byte	.CSleep,	    4
	!byte	.CLoop + 4,	   10, -10
	!byte	Enemies.TWall,	   32,  70
	!byte	Enemies.TWall,	   32,  30
	!byte	.CSleep,	    4
	!byte	Enemies.TWall,	   34,  20

	!byte	.CSleep,	  128
	!byte	.CDone

.WallWaveUpSlopeBottom
	!byte	Enemies.TWall,	   34, 100
	!byte	.CSleep,	    4
	!byte	.CLoop + 4,	   10, -10
	!byte	Enemies.TWall,	   32,  90
	!byte	Enemies.TWall,	   32,  50
	!byte	.CSleep,	    4
	!byte	Enemies.TWall,	   34,  40
	
	!byte	.CSleep,	  128
	!byte	.CDone

.WallWaveSlopeGateDown1
	!byte	Enemies.TWall,	   34,  32
	!byte	.CSleep,	    6
	!byte	Enemies.TWall,	   31,  42
	!byte	.CSleep,	    6
	!byte	Enemies.TWall,	   34,  52
	!byte	.CSleep,	   22
	!byte	.CLoop + 3,	   24,   6
	!byte	Enemies.TWall,	   36,  56
	!byte	Enemies.TWall,	   36,  74
	!byte	.CSleep,	   22
	!byte	Enemies.TWall,	   34,  80
	!byte	.CSleep,	   32
	
	!byte	Enemies.TWall,	   34,  40
	!byte	.CSleep,	   22
	!byte	.CLoop + 4,	   24,   6
	!byte	Enemies.TWall,	   38,  46
	!byte	Enemies.TWall,	   38,  70
	!byte	.CSleep,	   22
	!byte	Enemies.TWall,	   34,  76
	!byte	.CSleep,	    6
	!byte	Enemies.TWall,	   31,  86
	!byte	.CSleep,	    6
	!byte	Enemies.TWall,	   34,  96
	!byte	.CSleep,	   88
	!byte	.CDone

.WallWaveSlopeGateDown2
	!byte	Enemies.TWall,	   34,  32
	!byte	.CSleep,	    6
	!byte	Enemies.TWall,	   31,  42
	!byte	.CSleep,	    6
	!byte	Enemies.TWall,	   34,  52
	!byte	.CSleep,	   22
	!byte	.CLoop + 3,	   24,   6
	!byte	Enemies.TWall,	   36,  56
	!byte	Enemies.TWall,	   36,  74
	!byte	.CSleep,	   22
	!byte	Enemies.TWall,	   34,  80
	!byte	.CSleep,	    6
	
	!byte	Enemies.TWall,	   34,  40
	!byte	.CSleep,	   22
	!byte	.CLoop + 4,	   24,   6
	!byte	Enemies.TWall,	   38,  46
	!byte	Enemies.TWall,	   38,  70
	!byte	.CSleep,	   22
	!byte	Enemies.TWall,	   34,  76
	!byte	.CSleep,	    6
	!byte	Enemies.TWall,	   31,  86
	!byte	.CSleep,	    6
	!byte	Enemies.TWall,	   34,  96
	!byte	.CSleep,	   88
	!byte	.CDone

.WallWaveSlopeGateUp1
	!byte	Enemies.TWall,	   34, 100
	!byte	.CSleep,	    6
	!byte	.CLoop + 2,	    8, -10
	!byte	Enemies.TWall,	   32,  90
	!byte	Enemies.TWall,	   34,  70
	!byte	.CSleep,	   22
	!byte	.CLoop + 3,	   24,  -6
	!byte	Enemies.TWall,	   35,  64
	!byte	Enemies.TWall,	   35,  46
	!byte	.CSleep,	   22
	!byte	Enemies.TWall,	   34,  40
	!byte	.CSleep,	   32
	
	!byte	Enemies.TWall,	   34,  80
	!byte	.CSleep,	   22
	!byte	.CLoop + 3,	   24,  -6
	!byte	Enemies.TWall,	   37,  74
	!byte	Enemies.TWall,	   37,  56
	!byte	.CSleep,	   22
	!byte	Enemies.TWall,	   34,  50
	!byte	.CSleep,	    4
	!byte	Enemies.TWall,	   32,  40
	!byte	.CSleep,	    8
	!byte	Enemies.TWall,	   34,  30
	!byte	.CSleep,	   88
	!byte	.CDone
	 
.WallWaveSlopeGateUp2
	!byte	Enemies.TWall,	   34, 100
	!byte	.CSleep,	    6
	!byte	.CLoop + 2,	    8, -10
	!byte	Enemies.TWall,	   32,  90
	!byte	Enemies.TWall,	   34,  70
	!byte	.CSleep,	   22
	!byte	.CLoop + 3,	   24,  -6
	!byte	Enemies.TWall,	   35,  64
	!byte	Enemies.TWall,	   35,  46
	!byte	.CSleep,	   22
	!byte	Enemies.TWall,	   34,  40
	!byte	.CSleep,	    6
	
	!byte	Enemies.TWall,	   34,  80
	!byte	.CSleep,	   22
	!byte	.CLoop + 3,	   24,  -6
	!byte	Enemies.TWall,	   37,  74
	!byte	Enemies.TWall,	   37,  56
	!byte	.CSleep,	   22
	!byte	Enemies.TWall,	   34,  50
	!byte	.CSleep,	    4
	!byte	Enemies.TWall,	   32,  40
	!byte	.CSleep,	    8
	!byte	Enemies.TWall,	   34,  30
	!byte	.CSleep,	   88
	!byte	.CDone


.WallWaveBranchTop
	!byte	Enemies.TWall,    34,  30
	!byte	.CSleep,	   5
	!byte	Enemies.TWall,    31,  40
	!byte	.CSleep,	   5
	!byte	Enemies.TWall,    34,  50
	!byte	.CSleep,	  22
	!byte	Enemies.TWall,	  36,  53
	!byte	.CSleep,	  24
	!byte	Enemies.TWall,     0,  53
	!byte	Enemies.TWall,     3,  63
	!byte	Enemies.TWall,     5,  73
	!byte	Enemies.TElectro,  0,  83
	!byte	Enemies.TWall,     6,  93
	!byte	Enemies.TWall,     2, 103
	!byte	.CSleep,	  24
	!byte	Enemies.TWall,    35,  53
	!byte	.CSleep,	  22
	!byte	Enemies.TWall,    34,  50
	!byte	.CSleep,	   5
	!byte	Enemies.TWall,    32,  40
	!byte	.CSleep,	   5
	!byte	Enemies.TWall,    34,  30
	!byte	.CSleep,	 240
	!byte	.CDone
	 
.WallWaveBranchBottom
	!byte	Enemies.TWall,    34, 103
	!byte	.CSleep,	   5
	!byte	Enemies.TWall,    32,  93
	!byte	.CSleep,	   5
	!byte	Enemies.TWall,    34,  83
	!byte	.CSleep,	  22
	!byte	Enemies.TWall,	  35,  80
	!byte	.CSleep,	  24
	!byte	Enemies.TWall,     2,  80
	!byte	Enemies.TWall,     3,  70
	!byte	Enemies.TWall,     6,  60
	!byte	Enemies.TElectro,  0,  50
	!byte	Enemies.TWall,     5,  40
	!byte	Enemies.TWall,     0,  30		
	!byte	.CSleep,	  24
	!byte	Enemies.TWall,    36,  80
	!byte	.CSleep,	  22
	!byte	Enemies.TWall,    34,  83
	!byte	.CSleep,	   5
	!byte	Enemies.TWall,    31,  93
	!byte	.CSleep,	   5
	!byte	Enemies.TWall,    34, 103
	!byte	.CSleep,	 240
	!byte	.CDone
	 
.AsteroidWaveSeg
	!byte	.CLoop + 6,		 5,  0
	!byte	Enemies.TAsteroid,   	 0,  0
	!byte	.CSleep,		16
	!byte	.CLoop + 6,		 5,  0
	!byte	Enemies.TAsteroid,   	 0,  0
	!byte	.CSleep,		16
	!byte	.CDone

.AsteroidText		!text	"WARNING, OBSTACLES AHEAD", 0


.AsteroidWave1
	!byte	EnemyWave.CText, 	<.AsteroidText, >.AsteroidText
	!byte	.CLoop + 8,		40,  0
	!byte	Enemies.TAsteroid,   	 0,  0
	!byte	.CSleep, 		32
	!byte	.CDone

.AsteroidWave2
	!byte	EnemyWave.CText, 	<.AsteroidText, >.AsteroidText
	!byte	.CLoop + 12,		30,  0
	!byte	Enemies.TAsteroid,   	 0,  0
	!byte	.CSleep, 		32
	!byte	.CDone

.AsteroidWave3
	!byte	EnemyWave.CText, 	<.AsteroidText, >.AsteroidText
	!byte	.CLoop + 16,		20,  0
	!byte	Enemies.TAsteroid,   	 0,  0
	!byte	.CSleep, 		32
	!byte	.CDone

.AsteroidWave4
	!byte	EnemyWave.CText, 	<.AsteroidText, >.AsteroidText
	!byte	.CLoop + 32,		16,  0
	!byte	Enemies.TAsteroid,   	 0,  0
	!byte	.CSleep, 		32
	!byte	.CDone

.AsteroidWave5
	!byte	EnemyWave.CText, 	<.AsteroidText, >.AsteroidText
	!byte	.CLoop + 32,		12,  0
	!byte	Enemies.TAsteroid,   	 0,  0
	!byte	.CSleep, 		32
	!byte	.CDone

.AsteroidWave6
	!byte	EnemyWave.CText, 	<.AsteroidText, >.AsteroidText
	!byte	.CLoop + 32,		 8,  0
	!byte	Enemies.TAsteroid,   	 0,  0
	!byte	.CSleep, 		32
	!byte	.CDone
	
.AsteroidWave7
	!byte	EnemyWave.CText, 	<.AsteroidText, >.AsteroidText
	!byte	.CLoop + 48,		 8,  0
	!byte	Enemies.TAsteroid,   	 0,  0
	!byte	.CSleep, 		32
	!byte	.CDone

.MinefieldText		!text	"DO NOT TOUCH THE MINES", 0

.MinefieldWave1
	!byte	EnemyWave.CText, 	<.MinefieldText, >.MinefieldText
	
	!byte	.CLoop + 3, 	 0,  35
	!byte	Enemies.TMine,   0,  30
	!byte	.CSleep,	80

	!byte	.CLoop + 2, 	 0,  40
	!byte	Enemies.TMine,   0,  55
	!byte	.CSleep,	80

	!byte	.CLoop + 2, 	 0,  40
	!byte	Enemies.TMine,   0,  45
	!byte	.CSleep,	80

	!byte	.CLoop + 3, 	 0,  35
	!byte	Enemies.TMine,   0,  35
	!byte	.CSleep,	80

	!byte	.CLoop + 2, 	 0,  40
	!byte	Enemies.TMine,   0,  40
	!byte	.CSleep,       255
	!byte	.CDone

.MinefieldWave2
	!byte	EnemyWave.CText, 	<.MinefieldText, >.MinefieldText

	!byte	.CLoop + 3, 	 0,  35
	!byte	Enemies.TMine,   0,  35
	!byte	.CSleep,	72

	!byte	.CLoop + 2, 	 0,  35
	!byte	Enemies.TMine,   0,  45
	!byte	.CSleep,	72

	!byte	.CLoop + 3, 	 0,  35
	!byte	Enemies.TMine,   0,  31
	!byte	.CSleep,	72

	!byte	.CLoop + 2, 	 0,  35
	!byte	Enemies.TMine,   0,  42
	!byte	.CSleep,	72

	!byte	.CLoop + 3, 	 0,  30
	!byte	Enemies.TMine,   0,  40
	!byte	.CSleep,       255
	!byte	.CDone

.MinefieldWave3
	!byte	EnemyWave.CText, 	<.MinefieldText, >.MinefieldText

	!byte	.CLoop + 3, 	 0,  30
	!byte	Enemies.TMine,   0,  30
	!byte	.CSleep,	64

	!byte	.CLoop + 2, 	 0,  30
	!byte	Enemies.TMine,   0,  55
	!byte	.CSleep,	64

	!byte	.CLoop + 3, 	 0,  30
	!byte	Enemies.TMine,   0,  45
	!byte	.CSleep,	64

	!byte	.CLoop + 3, 	 0,  30
	!byte	Enemies.TMine,   0,  40
	!byte	.CSleep,	64

	!byte	.CLoop + 3, 	 0,  30
	!byte	Enemies.TMine,   0,  35
	!byte	.CSleep,       255
	!byte	.CDone

.MinefieldWave4
	!byte	EnemyWave.CText, 	<.MinefieldText, >.MinefieldText

	!byte	.CLoop + 3, 	 0,  30
	!byte	Enemies.TMine,   0,  30
	!byte	.CSleep,	56

	!byte	.CLoop + 3, 	 0,  30
	!byte	Enemies.TMine,   0,  35
	!byte	.CSleep,	56

	!byte	.CLoop + 2, 	 0,  30
	!byte	Enemies.TMine,   0,  55
	!byte	.CSleep,	56

	!byte	.CLoop + 3, 	 0,  30
	!byte	Enemies.TMine,   0,  40
	!byte	.CSleep,	56

	!byte	.CLoop + 3, 	 0,  30
	!byte	Enemies.TMine,   0,  35
	!byte	.CSleep,	56

	!byte	.CLoop + 3, 	 0,  30
	!byte	Enemies.TMine,   0,  45
	!byte	.CSleep,       255
	!byte	.CDone

.MinefieldWave5
	!byte	EnemyWave.CText, 	<.MinefieldText, >.MinefieldText

	!byte	.CLoop + 3, 	 0,  30
	!byte	Enemies.TMine,   0,  30
	!byte	.CSleep,	48

	!byte	.CLoop + 3, 	 0,  30
	!byte	Enemies.TMine,   0,  35
	!byte	.CSleep,	48

	!byte	.CLoop + 2, 	 0,  30
	!byte	Enemies.TMine,   0,  55
	!byte	.CSleep,	48

	!byte	.CLoop + 3, 	 0,  30
	!byte	Enemies.TMine,   0,  40
	!byte	.CSleep,	48

	!byte	.CLoop + 3, 	 0,  30
	!byte	Enemies.TMine,   0,  35
	!byte	.CSleep,	48

	!byte	.CLoop + 3, 	 0,  30
	!byte	Enemies.TMine,   0,  45
	!byte	.CSleep,       255
	!byte	.CDone

.MinefieldWave6
	!byte	EnemyWave.CText, 	<.MinefieldText, >.MinefieldText

	!byte	.CLoop + 4, 	 0,  22
	!byte	Enemies.TMine,   0,  28
	!byte	.CSleep,	72

	!byte	.CLoop + 3, 	 0,  22
	!byte	Enemies.TMine,   0,  42
	!byte	.CSleep,	72

	!byte	.CLoop + 4, 	 0,  22
	!byte	Enemies.TMine,   0,  37
	!byte	.CSleep,	72

	!byte	.CLoop + 4, 	 0,  22
	!byte	Enemies.TMine,   0,  30
	!byte	.CSleep,	72

	!byte	.CLoop + 4, 	 0,  22
	!byte	Enemies.TMine,   0,  35
	!byte	.CSleep,       255
	!byte	.CDone

.HomingWave1
	!byte	.CLoop + 4, 		 24,   5
	!byte	Enemies.THomingMissile,   0,  50
	!byte	.CSleep,       		128
	!byte	.CDone

.HomingWave2
	!byte	.CLoop + 4, 		 16,  15
	!byte	Enemies.THomingMissile,   0,  30
	!byte	.CSleep,       		 32
	!byte	.CLoop + 4, 		 16, -15
	!byte	Enemies.THomingMissile,   0,  90
	!byte	.CSleep,       		128
	!byte	.CDone

.HomingWave3
	!byte	.CLoop + 4, 		  8,  15
	!byte	Enemies.THomingMissile,   0,  30
	!byte	.CSleep,       		 32
	!byte	.CLoop + 4, 		  8, -15
	!byte	Enemies.THomingMissile,   0,  90
	!byte	.CSleep,       		128
	!byte	.CDone

.HomingWave4
	!byte	.CLoop + 2, 		  0,  30
	!byte	Enemies.THomingMissile,   0,  30
	!byte	.CSleep,       		 32
	!byte	.CLoop + 2, 		  0,  30
	!byte	Enemies.THomingMissile,   0,  40
	!byte	.CSleep,       		 32
	!byte	.CLoop + 2, 		  0,  30
	!byte	Enemies.THomingMissile,   0,  50
	!byte	.CSleep,       		 32
	!byte	.CLoop + 4, 		  4,  30
	!byte	Enemies.THomingMissile,   0,  60
	!byte	.CSleep,       		128
	!byte	.CDone

.BreakerWave1
	!byte	.CLoop + 7, 		 20,   5
	!byte	Enemies.TBreaker,     	 40,  20
	!byte	.CSleep,       		 48
	!byte	.CLoop + 7, 		 20,  -5
	!byte	Enemies.TBreaker,    	-40, 110
	!byte	.CSleep,       		255
	!byte	.CDone

.BreakerWave2
	!byte	.CLoop + 7, 		 20,   5
	!byte	Enemies.TBreaker,     	 40,  20
	!byte	.CSleep,       		 32
	!byte	.CLoop + 7, 		 20,  -5
	!byte	Enemies.TBreaker,    	-40, 110
	!byte	.CSleep,       		255
	!byte	.CDone

.BreakerWave3
	!byte	.CLoop + 2, 		  0,  20
	!byte	Enemies.TBreaker,     	 40,  20
	!byte	.CSleep,       		 16
	!byte	.CLoop + 2, 		  0, -20
	!byte	Enemies.TBreaker,    	-40, 110
	!byte	.CSleep,       		 16
	!byte	.CLoop + 2, 		  0,  20
	!byte	Enemies.TBreaker,     	 40,  20
	!byte	.CSleep,       		 16
	!byte	.CLoop + 2, 		  0, -20
	!byte	Enemies.TBreaker,    	-40, 110
	!byte	.CSleep,       		 16
	!byte	.CLoop + 2, 		  0,  20
	!byte	Enemies.TBreaker,     	 40,  20
	!byte	.CSleep,       		 16
	!byte	.CLoop + 2, 		  0, -20
	!byte	Enemies.TBreaker,    	-40, 110
	!byte	.CSleep,       		 16
	!byte	.CLoop + 2, 		  0,  20
	!byte	Enemies.TBreaker,     	 40,  20
	!byte	.CSleep,       		 16
	!byte	.CLoop + 2, 		  0, -20
	!byte	Enemies.TBreaker,    	-40, 110
	!byte	.CSleep,       		255
	!byte	.CDone

.BlubberWave1
	!byte	.CLoop + 6, 		  0,  12
	!byte	Enemies.TBlubber,    	  0,  32
	!byte	.CSleep,       		128
	!byte	.CDone

.BlubberWave2
	!byte	.CLoop + 6, 		  0,  12
	!byte	Enemies.TBlubber,    	$80,  32
	!byte	.CSleep,       		128
	!byte	.CDone

.BlubberWave3
	!byte	.CLoop + 6, 		  0,  12
	!byte	Enemies.TBlubber,    	  0,  27
	!byte	.CSleep,       		 24
	!byte	.CLoop + 6, 		  0,  12
	!byte	Enemies.TBlubber,    	  0,  32
	!byte	.CSleep,       		128
	!byte	.CDone

.BlubberWave4
	!byte	.CLoop + 6, 		  0,  12
	!byte	Enemies.TBlubber,    	$80,  27
	!byte	.CSleep,       		 24
	!byte	.CLoop + 6, 		  0,  12
	!byte	Enemies.TBlubber,    	$80,  32
	!byte	.CSleep,       		128
	!byte	.CDone

.BlubberWave5
	!byte	.CLoop + 6, 		  0,  12
	!byte	Enemies.TBlubber,    	  0,  30
	!byte	.CSleep,       		 24
	!byte	.CLoop + 6, 		  0,  12
	!byte	Enemies.TBlubber,    	  0,  27
	!byte	.CSleep,       		 24
	!byte	.CLoop + 6, 		  0,  12
	!byte	Enemies.TBlubber,    	  0,  32
	!byte	.CSleep,       		128
	!byte	.CDone
	
.BlubberWave6
	!byte	.CLoop + 6, 		  0,  12
	!byte	Enemies.TBlubber,    	$80,  30
	!byte	.CSleep,       		 24
	!byte	.CLoop + 6, 		  0,  12
	!byte	Enemies.TBlubber,    	$80,  27
	!byte	.CSleep,       		 24
	!byte	.CLoop + 6, 		  0,  12
	!byte	Enemies.TBlubber,    	$80,  32
	!byte	.CSleep,       		128
	!byte	.CDone
	
.WallTunnelWave1a
	!byte	Enemies.TWall,	  	 34,   60
	!byte	Enemies.TWall,	  	 34,  100
	!byte	.CSleep,       		 22
	!byte	Enemies.TWall,	  	 35,   54
	!byte	Enemies.TWall,	  	 35,   94
	!byte	.CSleep,       		 24
	!byte	Enemies.TWall,	  	 35,   48
	!byte	Enemies.TWall,	  	 35,   88
	!byte	.CSleep,       		 24
	!byte	Enemies.TWall,	  	 35,   42
	!byte	Enemies.TWall,	  	 35,   82
	!byte	.CSleep,       		 24
	!byte	Enemies.TWall,	  	 35,   36
	!byte	Enemies.TWall,	  	 35,   76
	!byte	.CSleep,       		 24
	!byte	Enemies.TWall,	  	 35,   30
	!byte	Enemies.TWall,	  	 35,   70
	!byte	.CSleep,       		 22
	!byte	Enemies.TWall,	   	 34,   26
	!byte	Enemies.TWall,	   	 34,   66
	!byte	.CSleep,       		150
	!byte	.CDone

.WallTunnelWave2a
	!byte	Enemies.TWall,	  	 34,   26
	!byte	Enemies.TWall,	  	 34,   66
	!byte	.CSleep,       		 22
	!byte	Enemies.TWall,	  	 36,   30
	!byte	Enemies.TWall,	 	 36,   70
	!byte	.CSleep,       		 24
	!byte	Enemies.TWall,	  	 36,   36
	!byte	Enemies.TWall,	  	 36,   76
	!byte	.CSleep,       		 24
	!byte	Enemies.TWall,	  	 36,   42
	!byte	Enemies.TWall,	  	 36,   82
	!byte	.CSleep,       		 24
	!byte	Enemies.TWall,	  	 36,   48
	!byte	Enemies.TWall,	  	 36,   88
	!byte	.CSleep,       		 24
	!byte	Enemies.TWall,	  	 36,   54
	!byte	Enemies.TWall,	  	 36,   94
	!byte	.CSleep,       		 22
	!byte	Enemies.TWall,	  	 34,   60
	!byte	Enemies.TWall,	  	 34,  100
	!byte	.CSleep,       		150
	!byte	.CDone

.WallTunnelWave1b
	!byte	Enemies.TWall,	  	 34,   62
	!byte	Enemies.TWall,	  	 34,   95
	!byte	.CSleep,       		 22
	!byte	Enemies.TWall,	  	 35,   56
	!byte	Enemies.TWall,	  	 35,   89
	!byte	.CSleep,       		 24
	!byte	Enemies.TWall,	  	 35,   50
	!byte	Enemies.TWall,	  	 35,   83
	!byte	.CSleep,       		 24
	!byte	Enemies.TWall,	  	 35,   44
	!byte	Enemies.TWall,	  	 35,   77
	!byte	.CSleep,       		 24
	!byte	Enemies.TWall,	  	 35,   38
	!byte	Enemies.TWall,	  	 35,   71
	!byte	.CSleep,       		 24
	!byte	Enemies.TWall,	  	 35,   32
	!byte	Enemies.TWall,	  	 35,   65
	!byte	.CSleep,       		 22
	!byte	Enemies.TWall,	  	 34,   28
	!byte	Enemies.TWall,	  	 34,   61
	!byte	.CSleep,       		150
	!byte	.CDone

.WallTunnelWave2b
	!byte	Enemies.TWall,	  	 34,   28
	!byte	Enemies.TWall,	  	 34,   61
	!byte	.CSleep,       		 22
	!byte	Enemies.TWall,	  	 36,   32
	!byte	Enemies.TWall,	  	 36,   65
	!byte	.CSleep,       		 24
	!byte	Enemies.TWall,	  	 36,   38
	!byte	Enemies.TWall,	  	 36,   71
	!byte	.CSleep,       		 24
	!byte	Enemies.TWall,	  	 36,   44
	!byte	Enemies.TWall,	  	 36,   77
	!byte	.CSleep,       		 24
	!byte	Enemies.TWall,	  	 36,   50
	!byte	Enemies.TWall,	  	 36,   83
	!byte	.CSleep,       		 24
	!byte	Enemies.TWall,	  	 36,   56
	!byte	Enemies.TWall,	  	 36,   89
	!byte	.CSleep,       		 22
	!byte	Enemies.TWall,	  	 34,   62
	!byte	Enemies.TWall,	  	 34,   95
	!byte	.CSleep,       		150
	!byte	.CDone

.BoomerangText	!text	"LOOK OUT, ENEMIES FROM BEHIND", 0

.BoomerangWave1
	!byte	EnemyWave.CText, 	<.BoomerangText, >.BoomerangText
	!byte	.CSleep,		 64

	!byte	Enemies.TBoomerang,  	 14,  35
	!byte	.CSleep,       		 32
	!byte	Enemies.TBoomerang,  	-14,  95
	!byte	.CSleep,       		128
	!byte	.CDone

.BoomerangWave2
	!byte	EnemyWave.CText, 	<.BoomerangText, >.BoomerangText
	!byte	.CSleep,		 64

	!byte	Enemies.TBoomerang, 	 14,  35
	!byte	.CSleep,       		 32
	!byte	Enemies.TBoomerang, 	-14,  95
	!byte	.CSleep,       		 32
	!byte	Enemies.TBoomerang, 	 -6,  55
	!byte	.CSleep,       		 32
	!byte	Enemies.TBoomerang, 	  6,  75
	!byte	.CSleep,       		128
	!byte	.CDone

.BoomerangWave3
	!byte	EnemyWave.CText, 	<.BoomerangText, >.BoomerangText
	!byte	.CSleep,		 64

	!byte	Enemies.TBoomerang, 	 14,  35
	!byte	.CSleep,       		 32
	!byte	Enemies.TBoomerang, 	-14,  95
	!byte	.CSleep,       		 32
	!byte	Enemies.TBoomerang, 	 10,  45
	!byte	.CSleep,       		 32
	!byte	Enemies.TBoomerang, 	-10,  85
	!byte	.CSleep,       		 32
	!byte	Enemies.TBoomerang, 	  6,  55
	!byte	.CSleep,       		 32
	!byte	Enemies.TBoomerang, 	 -6,  75
	!byte	.CSleep,       		128
	!byte	.CDone

.BoomerangWave4
	!byte	EnemyWave.CText, 	<.BoomerangText, >.BoomerangText
	!byte	.CSleep,		 64

	!byte	.CLoop + 2,		 12,  10
	!byte	Enemies.TBoomerang, 	 14,  35
	!byte	.CSleep,       		 32
	!byte	.CLoop + 2,		 12, -10
	!byte	Enemies.TBoomerang, 	-14,  95
	!byte	.CSleep,       		 32
	!byte	.CLoop + 2,		 12,  10
	!byte	Enemies.TBoomerang, 	 10,  45
	!byte	.CSleep,       		 32
	!byte	.CLoop + 2,		 12, -10
	!byte	Enemies.TBoomerang, 	-10,  85
	!byte	.CSleep,       		 32
	!byte	.CLoop + 2,		 12,  10
	!byte	Enemies.TBoomerang, 	  6,  55
	!byte	.CSleep,       		 32
	!byte	.CLoop + 2,		 12, -10
	!byte	Enemies.TBoomerang, 	 -6,  75
	!byte	.CSleep,       		128
	!byte	.CDone

	
.ArrowWave1
	!byte	.CLoop + 3,		 16,   0
	!byte	Enemies.TArrow1,    	  0,  35
	!byte	.CSleep,       		 24
	!byte	.CLoop + 3,		 16,   0
	!byte	Enemies.TArrow1,     	  1,  60
	!byte	.CSleep,       		 24
	!byte	.CLoop + 3,		 16,   0
	!byte	Enemies.TArrow1,   	  2,  95
	!byte	.CSleep,       		 64
	!byte	.CDone

.ArrowWave2
	!byte	.CLoop + 4,		 12,   0
	!byte	Enemies.TArrow1,   	  0,  30
	!byte	.CSleep,       		 16
	!byte	.CLoop + 4,		 12,   0
	!byte	Enemies.TArrow1,   	  1,  60
	!byte	.CSleep,       		 16
	!byte	.CLoop + 4,		 12,   0
	!byte	Enemies.TArrow1,     	  2,  90
	!byte	.CSleep,       		 64
	!byte	.CDone

.ArrowWave3
	!byte	.CLoop + 5,		  8,   1
	!byte	Enemies.TArrow1,   	  0,  30
	!byte	.CSleep,       		 12
	!byte	.CLoop + 5,		  8,   0
	!byte	Enemies.TArrow1,   	  1,  60
	!byte	.CSleep,       		 12
	!byte	.CLoop + 5,		  8,  -1
	!byte	Enemies.TArrow1,   	  2,  90
	!byte	.CSleep,       		 64
	!byte	.CDone

.ArrowWave4
	!byte	.CLoop + 3,		 16,   0
	!byte	Enemies.TArrow1,    	$80,  35
	!byte	.CSleep,       		 24
	!byte	.CLoop + 3,		 16,   0
	!byte	Enemies.TArrow1,     	$81,  60
	!byte	.CSleep,       		 24
	!byte	.CLoop + 3,		 16,   0
	!byte	Enemies.TArrow1,   	$82,  95
	!byte	.CSleep,       		 64
	!byte	.CDone

.ArrowWave5
	!byte	.CLoop + 4,		 12,   0
	!byte	Enemies.TArrow1,   	$80,  30
	!byte	.CSleep,       		 16
	!byte	.CLoop + 4,		 12,   0
	!byte	Enemies.TArrow1,   	$81,  60
	!byte	.CSleep,       		 16
	!byte	.CLoop + 4,		 12,   0
	!byte	Enemies.TArrow1,     	$82,  90
	!byte	.CSleep,       		 64
	!byte	.CDone

.ArrowWave6
	!byte	.CLoop + 5,		  8,   1
	!byte	Enemies.TArrow1,   	$80,  30
	!byte	.CSleep,       		 12
	!byte	.CLoop + 5,		  8,   0
	!byte	Enemies.TArrow1,   	$81,  60
	!byte	.CSleep,       		 12
	!byte	.CLoop + 5,		  8,  -1
	!byte	Enemies.TArrow1,   	$82,  90
	!byte	.CSleep,       		 64
	!byte	.CDone

	
.CirclerWave1
	!byte	.CLoop + 4,		 20,  -4
	!byte	Enemies.TArrow2,   	  0,  50
	!byte	.CSleep,       		192
	!byte	.CLoop + 4,		 20,   4
	!byte	Enemies.TArrow2,   	  1,  85
	!byte	.CSleep,       		192
	!byte	.CDone

.CirclerWave2
	!byte	.CLoop + 6,		 16,  -4
	!byte	Enemies.TArrow2,   	  0,  50
	!byte	.CSleep,       		192
	!byte	.CLoop + 6,		 16,   4
	!byte	Enemies.TArrow2,   	  1,  85
	!byte	.CSleep,       		192
	!byte	.CDone

.CirclerWave3
	!byte	.CLoop + 6,		 15,  -5
	!byte	Enemies.TArrow2,   	  0,  50
	!byte	.CSleep,       		128
	!byte	.CLoop + 6,		 15,   5
	!byte	Enemies.TArrow2,   	  1,  85
	!byte	.CSleep,       		128
	!byte	.CLoop + 6,		 15,  -5
	!byte	Enemies.TArrow2,   	  0,  50
	!byte	.CSleep,       		128
	!byte	.CLoop + 6,		 15,   5
	!byte	Enemies.TArrow2,    	  1,  85
	!byte	.CSleep,       		192
	!byte	.CDone

.CirclerWave4
	!byte	.CLoop + 6,		 16,  -4
	!byte	Enemies.TArrow2,   	$80,  50
	!byte	.CSleep,       		192
	!byte	.CLoop + 6,		 16,   4
	!byte	Enemies.TArrow2,   	$81,  85
	!byte	.CSleep,       		192
	!byte	.CDone

.CirclerWave5
	!byte	.CLoop + 3,		 16,  -4
	!byte	Enemies.TArrow2,   	$80,  50
	!byte	.CLoop + 3,		 16,   4
	!byte	Enemies.TArrow2,   	$81,  85
	!byte	.CLoop + 3,		 16,  -4
	!byte	Enemies.TArrow2,   	$80,  38
	!byte	.CLoop + 3,		 16,   4
	!byte	Enemies.TArrow2,   	$81,  97
	!byte	.CSleep,       		192
	!byte	.CDone

.CirclerWave6
	!byte	.CLoop + 2,		 16,  -3
	!byte	Enemies.TArrow2,   	$80,  50
	!byte	.CLoop + 2,		 16,   3
	!byte	Enemies.TArrow2,   	$81,  85
	!byte	.CLoop + 2,		 16,  -3
	!byte	Enemies.TArrow2,   	$80,  44
	!byte	.CLoop + 2,		 16,   3
	!byte	Enemies.TArrow2,   	$81,  91
	!byte	.CLoop + 2,		 16,  -3
	!byte	Enemies.TArrow2,   	$80,  38
	!byte	.CLoop + 2,		 16,   3
	!byte	Enemies.TArrow2,   	$81,  97
	!byte	.CLoop + 2,		 16,  -3
	!byte	Enemies.TArrow2,   	$80,  32
	!byte	.CLoop + 2,		 16,   3
	!byte	Enemies.TArrow2,   	$81, 103
	!byte	.CSleep,       		192
	!byte	.CDone


.DiamondWave1
	!byte	.CLoop + 3,		 16,   0
	!byte	Enemies.TDiamond,    	  0,  35
	!byte	.CSleep,       		 24
	!byte	.CLoop + 3,		 16,   0
	!byte	Enemies.TDiamond,   	  1,  50
	!byte	.CSleep,       		 24
	!byte	.CLoop + 3,		 16,   0
	!byte	Enemies.TDiamond,   	  2,  80
	!byte	.CSleep,       		 24
	!byte	.CLoop + 3,		 16,   0
	!byte	Enemies.TDiamond,   	  3,  95
	!byte	.CSleep,       		 64
	!byte	.CDone
	
.DiamondWave2
	!byte	.CLoop + 4,		 16,   0
	!byte	Enemies.TDiamond,   	  0,  35
	!byte	.CSleep,       		 24
	!byte	.CLoop + 4,		 16,   0
	!byte	Enemies.TDiamond,   	  1,  50
	!byte	.CSleep,       		 24
	!byte	.CLoop + 4,		 16,   0
	!byte	Enemies.TDiamond,   	  2,  80
	!byte	.CSleep,       		 24
	!byte	.CLoop + 4,		 16,   0
	!byte	Enemies.TDiamond,  	  3,  95
	!byte	.CSleep,       		 64
	!byte	.CDone
	

.DiamondWave3
	!byte	.CLoop + 5,		 16,   0
	!byte	Enemies.TDiamond,   	  0,  35
	!byte	.CSleep,       		 24
	!byte	.CLoop + 5,		 16,   0
	!byte	Enemies.TDiamond,   	  1,  50
	!byte	.CSleep,       		 24
	!byte	.CLoop + 5,		 16,   0
	!byte	Enemies.TDiamond,   	  2,  80
	!byte	.CSleep,       		 24
	!byte	.CLoop + 5,		 16,   0
	!byte	Enemies.TDiamond,   	  3,  95
	!byte	.CSleep,       		 64
	!byte	.CDone
	
.DiamondWave4
	!byte	.CLoop + 3,		 16,   0
	!byte	Enemies.TDiamond,    	$80,  35
	!byte	.CSleep,       		 24
	!byte	.CLoop + 3,		 16,   0
	!byte	Enemies.TDiamond,   	$81,  50
	!byte	.CSleep,       		 24
	!byte	.CLoop + 3,		 16,   0
	!byte	Enemies.TDiamond,   	$82,  80
	!byte	.CSleep,       		 24
	!byte	.CLoop + 3,		 16,   0
	!byte	Enemies.TDiamond,   	$83,  95
	!byte	.CSleep,       		 64
	!byte	.CDone
	
.DiamondWave5
	!byte	.CLoop + 4,		 16,   0
	!byte	Enemies.TDiamond,   	$80,  35
	!byte	.CSleep,       		 24
	!byte	.CLoop + 4,		 16,   0
	!byte	Enemies.TDiamond,   	$81,  50
	!byte	.CSleep,       		 24
	!byte	.CLoop + 4,		 16,   0
	!byte	Enemies.TDiamond,   	$82,  80
	!byte	.CSleep,       		 24
	!byte	.CLoop + 4,		 16,   0
	!byte	Enemies.TDiamond,  	$83,  95
	!byte	.CSleep,       		 64
	!byte	.CDone
	

.DiamondWave6
	!byte	.CLoop + 5,		 16,   0
	!byte	Enemies.TDiamond,   	$80,  35
	!byte	.CSleep,       		 24
	!byte	.CLoop + 5,		 16,   0
	!byte	Enemies.TDiamond,   	$81,  50
	!byte	.CSleep,       		 24
	!byte	.CLoop + 5,		 16,   0
	!byte	Enemies.TDiamond,   	$82,  80
	!byte	.CSleep,       		 24
	!byte	.CLoop + 5,		 16,   0
	!byte	Enemies.TDiamond,   	$83,  95
	!byte	.CSleep,       		 64
	!byte	.CDone
	

.BossWave1a
	!byte	Enemies.TBoss1,	       	$03,  55
	!byte	Enemies.TBoss1,	       	$84,  65
	!byte	.CSleep,       		 12
	!byte	Enemies.TBoss1,	       	$80,  49
	!byte	Enemies.TBoss1,	       	$01,  60
	!byte	Enemies.TBoss1,	       	$82,  70
	!byte	.CWait,			  0,   0
	!byte	.CDone
	

.BossWave1b
	!byte	Enemies.TBoss1,	       	$13,  55
	!byte	Enemies.TBoss1,	       	$94,  65
	!byte	.CSleep,       		 12
	!byte	Enemies.TBoss1,	       	$90,  49
	!byte	Enemies.TBoss1,	       	$11,  60
	!byte	Enemies.TBoss1,	       	$92,  70
	!byte	.CWait,			  0,   0
	!byte	.CDone

.BossWave1c
	!byte	Enemies.TBoss1,	       	$23,  55
	!byte	Enemies.TBoss1,	       	$a4,  65
	!byte	.CSleep,       		 12
	!byte	Enemies.TBoss1,	       	$a0,  49
	!byte	Enemies.TBoss1,	       	$21,  60
	!byte	Enemies.TBoss1,	       	$a2,  70
	!byte	.CWait,			  0,   0
	!byte	.CDone
	
.BossWave1d
	!byte	Enemies.TBoss1,	       	$33,  55
	!byte	Enemies.TBoss1,	       	$b4,  65
	!byte	.CSleep,       		 12
	!byte	Enemies.TBoss1,	       	$b0,  49
	!byte	Enemies.TBoss1,	       	$31,  60
	!byte	Enemies.TBoss1,	       	$b2,  70
	!byte	.CWait,			  0,   0
	!byte	.CDone
	
.BossWave2a
	!byte	Enemies.TBoss2,	       	$82,  60
	!byte	.CSleep,       		  4
	!byte	Enemies.TBoss2,	       	$00,  50
	!byte	Enemies.TBoss2,	       	$01,  71
	!byte	.CSleep,       		  4
	!byte	Enemies.TBoss2,	       	$83,  60

	!byte	Enemies.TBoss2Electro, 	 -8,  60
	!byte	Enemies.TBoss2Electro, 	 14,  60					
	!byte	Enemies.TBoss2Electro, 	 -8,  60
	!byte	Enemies.TBoss2Electro, 	 14,  60					
	!byte	Enemies.TBoss2Electro, 	 -8,  60
	!byte	Enemies.TBoss2Electro, 	 14,  60				
	!byte	.CWait,			  0,   0
	!byte	.CDone

.BossWave2b
	!byte	Enemies.TBoss2,	       	$92,  60
	!byte	.CSleep,       		  4
	!byte	Enemies.TBoss2,	       	$10,  50
	!byte	Enemies.TBoss2,	       	$11,  71
	!byte	.CSleep,       		  4
	!byte	Enemies.TBoss2,	       	$93,  60

	!byte	Enemies.TBoss2Electro, 	 -8,  60
	!byte	Enemies.TBoss2Electro, 	 14,  60					
	!byte	Enemies.TBoss2Electro, 	 -8,  60
	!byte	Enemies.TBoss2Electro, 	 14,  60					
	!byte	Enemies.TBoss2Electro, 	 -8,  60
	!byte	Enemies.TBoss2Electro, 	 14,  60				
	!byte	.CWait,			  0,   0
	!byte	.CDone

.BossWave2c
	!byte	Enemies.TBoss2,	       	$a2,  60
	!byte	.CSleep,       		  4
	!byte	Enemies.TBoss2,	       	$20,  50
	!byte	Enemies.TBoss2,	       	$21,  71
	!byte	.CSleep,       		  4
	!byte	Enemies.TBoss2,	       	$a3,  60

	!byte	Enemies.TBoss2Electro, 	 -8,  60
	!byte	Enemies.TBoss2Electro, 	 14,  60					
	!byte	Enemies.TBoss2Electro, 	 -8,  60
	!byte	Enemies.TBoss2Electro, 	 14,  60					
	!byte	Enemies.TBoss2Electro, 	 -8,  60
	!byte	Enemies.TBoss2Electro, 	 14,  60				
	!byte	.CWait,			  0,   0
	!byte	.CDone

.BossWave2d
	!byte	Enemies.TBoss2,	       	$b2,  60
	!byte	.CSleep,       		  4
	!byte	Enemies.TBoss2,	       	$30,  50
	!byte	Enemies.TBoss2,	       	$31,  71
	!byte	.CSleep,       		  4
	!byte	Enemies.TBoss2,	       	$b3,  60

	!byte	Enemies.TBoss2Electro, 	 -8,  60
	!byte	Enemies.TBoss2Electro, 	 14,  60					
	!byte	Enemies.TBoss2Electro, 	 -8,  60
	!byte	Enemies.TBoss2Electro, 	 14,  60					
	!byte	Enemies.TBoss2Electro, 	 -8,  60
	!byte	Enemies.TBoss2Electro, 	 14,  60				
	!byte	.CWait,			  0,   0
	!byte	.CDone

.BossWave3a
	!byte	Enemies.TBoss3a,      	$81,  55
	!byte	.CSleep,       		  2
	!byte	Enemies.TBoss3a,      	$00,  45
	!byte	Enemies.TBoss3a,      	$02,  66
	!byte	.CSleep,       		 10
	!byte	Enemies.TBoss3a,      	$03,  50
	!byte	Enemies.TBoss3a,      	$84,  60
	!byte	.CSleep,       		 96
	!byte	Enemies.TBoss3b,      	$81,  55
	!byte	.CSleep,       		  1
	!byte	Enemies.TBoss3b,      	$00,  45
	!byte	Enemies.TBoss3b,      	$02,  66
	!byte	.CSleep,       		  5
	!byte	Enemies.TBoss3b,      	$03,  50
	!byte	Enemies.TBoss3b,      	$84,  60
	!byte	.CWait,			  0,   0
	!byte	.CDone

.BossWave3b
	!byte	Enemies.TBoss3a,      	$91,  55
	!byte	.CSleep,       		  2
	!byte	Enemies.TBoss3a,      	$10,  45
	!byte	Enemies.TBoss3a,      	$12,  66
	!byte	.CSleep,       		 10
	!byte	Enemies.TBoss3a,      	$13,  50
	!byte	Enemies.TBoss3a,      	$94,  60
	!byte	.CSleep,       		 96
	!byte	Enemies.TBoss3b,      	$91,  55
	!byte	.CSleep,       		  1
	!byte	Enemies.TBoss3b,      	$10,  45
	!byte	Enemies.TBoss3b,      	$12,  66
	!byte	.CSleep,       		  5
	!byte	Enemies.TBoss3b,      	$13,  50
	!byte	Enemies.TBoss3b,      	$94,  60
	!byte	.CWait,			  0,   0
	!byte	.CDone

.BossWave3c
	!byte	Enemies.TBoss3a,      	$a1,  55
	!byte	.CSleep,       		  2
	!byte	Enemies.TBoss3a,      	$20,  45
	!byte	Enemies.TBoss3a,      	$22,  66
	!byte	.CSleep,       		 10
	!byte	Enemies.TBoss3a,      	$23,  50
	!byte	Enemies.TBoss3a,      	$a4,  60
	!byte	.CSleep,       		 96
	!byte	Enemies.TBoss3b,      	$a1,  55
	!byte	.CSleep,       		  1
	!byte	Enemies.TBoss3b,      	$20,  45
	!byte	Enemies.TBoss3b,      	$22,  66
	!byte	.CSleep,       		  5
	!byte	Enemies.TBoss3b,      	$23,  50
	!byte	Enemies.TBoss3b,      	$a4,  60
	!byte	.CWait,			  0,   0
	!byte	.CDone

.BossWave3d
	!byte	Enemies.TBoss3a,      	$b1,  55
	!byte	.CSleep,       		  2
	!byte	Enemies.TBoss3a,      	$30,  45
	!byte	Enemies.TBoss3a,      	$32,  66
	!byte	.CSleep,       		 10
	!byte	Enemies.TBoss3a,      	$33,  50
	!byte	Enemies.TBoss3a,      	$b4,  60
	!byte	.CSleep,       		 96
	!byte	Enemies.TBoss3b,      	$b1,  55
	!byte	.CSleep,       		  1
	!byte	Enemies.TBoss3b,      	$30,  45
	!byte	Enemies.TBoss3b,      	$32,  66
	!byte	.CSleep,       		  5
	!byte	Enemies.TBoss3b,      	$33,  50
	!byte	Enemies.TBoss3b,      	$b4,  60
	!byte	.CWait,			  0,   0
	!byte	.CDone

	
	
.BossWave4a
	!byte	Enemies.TBoss4,	       	$02,  60
	!byte	.CSleep,       		  4
	!byte	Enemies.TBoss4,	       	$00,  51
	!byte	Enemies.TBoss4,	       	$04,  69
	!byte	.CSleep,       		 12
	!byte	Enemies.TBoss4,	       	$01,  51
	!byte	Enemies.TBoss4,	       	$05,  69
	!byte	.CSleep,       		  4
	!byte	Enemies.TBoss4,	       	$03,  60
	!byte	.CSleep,		 12

	!byte	Enemies.TBoss4b,       	  0,  51
	!byte	Enemies.TBoss4b,       	 11,  51
	!byte	Enemies.TBoss4b,       	 21,  51
	!byte	Enemies.TBoss4b,       	 32,  51
	!byte	Enemies.TBoss4b,       	 43,  51
	!byte	Enemies.TBoss4b,       	 54,  51
	
	!byte	.CWait,			  0,   0
	!byte	.CDone
	
.SwarmWave1
	!byte	Enemies.TSwarm,  	  0,  30
	!byte	.CSleep,       		  5
	!byte	Enemies.TSwarm,  	  0,  40
	!byte	.CSleep,       		 13
	!byte	Enemies.TSwarm,  	  0,  35
	!byte	.CSleep,       		  7
	!byte	Enemies.TSwarm,  	  1,  65
	!byte	.CSleep,       		 11
	!byte	Enemies.TSwarm,  	  0,  50
	!byte	.CSleep,       		 11
	!byte	Enemies.TSwarm,  	  0,  35
	!byte	.CSleep,       		  7
	!byte	Enemies.TSwarm,  	  0,  40
	!byte	.CSleep,       		 13
	!byte	Enemies.TSwarm,  	  1,  60
	!byte	.CSleep,       		  4
	!byte	Enemies.TSwarm,  	  1,  75
	!byte	.CSleep,       		 13
	!byte	Enemies.TSwarm,  	  0,  50
	!byte	.CSleep,       		128
	!byte	.CDone
	

.SwarmWave2
	!byte	Enemies.TSwarm,  	  0,  30
	!byte	.CSleep,       		  5
	!byte	Enemies.TSwarm,  	  0,  50
	!byte	.CSleep,       		 11
	!byte	Enemies.TSwarm,  	  0,  40
	!byte	.CSleep,       		 13
	!byte	Enemies.TSwarm,  	  0,  35
	!byte	.CSleep,       		  7
	!byte	Enemies.TSwarm,  	  0,  55
	!byte	.CSleep,       		 13
	!byte	Enemies.TSwarm,  	  1,  65
	!byte	.CSleep,       		 11
	!byte	Enemies.TSwarm,  	  0,  50
	!byte	.CSleep,       		 11
	!byte	Enemies.TSwarm,  	  1,  90
	!byte	.CSleep,       		 13
	!byte	Enemies.TSwarm,  	  0,  35
	!byte	.CSleep,       		  7
	!byte	Enemies.TSwarm,  	  0,  55
	!byte	.CSleep,       		 13
	!byte	Enemies.TSwarm,  	  1,  60
	!byte	.CSleep,       		  4
	!byte	Enemies.TSwarm,  	  0,  35
	!byte	.CSleep,       		  7
	!byte	Enemies.TSwarm,  	  1,  75
	!byte	.CSleep,       		 13
	!byte	Enemies.TSwarm,  	  0,  50
	!byte	.CSleep,       		128
	!byte	.CDone
	
.SwarmWave3                      	
	!byte	Enemies.TSwarm,  	  0,  30
	!byte	.CSleep,       		  5
	!byte	Enemies.TSwarm,  	  0,  50
	!byte	.CSleep,       		 11
	!byte	Enemies.TSwarm,  	  0,  40
	!byte	.CSleep,       		 13
	!byte	Enemies.TSwarm,  	  1,  60
	!byte	.CSleep,       		  4
	!byte	Enemies.TSwarm,  	  0,  35
	!byte	.CSleep,       		  7
	!byte	Enemies.TSwarm,  	  0,  55
	!byte	.CSleep,       		 13
	!byte	Enemies.TSwarm,  	  0,  45
	!byte	.CSleep,       		  6
	!byte	Enemies.TSwarm,  	  1,  65
	!byte	.CSleep,       		 11
	!byte	Enemies.TSwarm,  	  0,  50
	!byte	.CSleep,       		 11
	!byte	Enemies.TSwarm,  	  1,  90
	!byte	.CSleep,       		 13
	!byte	Enemies.TSwarm,  	  0,  60
	!byte	.CSleep,       		  4
	!byte	Enemies.TSwarm,  	  0,  35
	!byte	.CSleep,       		  7
	!byte	Enemies.TSwarm,  	  0,  55
	!byte	.CSleep,       		 13
	!byte	Enemies.TSwarm,  	  0,  40
	!byte	.CSleep,       		 13
	!byte	Enemies.TSwarm,  	  1,  60
	!byte	.CSleep,       		  4
	!byte	Enemies.TSwarm,  	  0,  35
	!byte	.CSleep,       		  7
	!byte	Enemies.TSwarm,  	  1,  75
	!byte	.CSleep,       		 13
	!byte	Enemies.TSwarm,  	  0,  50
	!byte	.CSleep,       		128
	!byte	.CDone
	


.CrossWipeWave1
	!byte	Enemies.TCrossWipe,   	  0,  30
	!byte	.CSleep,       		 45
	!byte	Enemies.TCrossWipe,   	  1,  90
	!byte	.CSleep,       		 45
	!byte	Enemies.TCrossWipe,   	  0,  35
	!byte	.CSleep,       		 45
	!byte	Enemies.TCrossWipe,   	  1,  85
	!byte	.CSleep,       		 45
	!byte	Enemies.TCrossWipe,   	  0,  25
	!byte	.CSleep,       		 45
	!byte	Enemies.TCrossWipe,   	  1,  95
	!byte	.CSleep,       		192
	!byte	.CDone

.CrossWipeWave2                       	
	!byte	Enemies.TCrossWipe,   	  0,  35
	!byte	.CSleep,       		 20
	!byte	Enemies.TCrossWipe,   	  1,  85
	!byte	.CSleep,       		 20
	!byte	Enemies.TCrossWipe,   	  0,  30
	!byte	.CSleep,       		 20
	!byte	Enemies.TCrossWipe,   	  1,  90
	!byte	.CSleep,       		 20
	!byte	Enemies.TCrossWipe,   	  0,  25
	!byte	.CSleep,       		 20
	!byte	Enemies.TCrossWipe,   	  1,  95
	!byte	.CSleep,       		 20
	!byte	Enemies.TCrossWipe,   	  0,  30
	!byte	.CSleep,       		 20
	!byte	Enemies.TCrossWipe,   	  1,  90
	!byte	.CSleep,       		 20
	!byte	Enemies.TCrossWipe,   	  0,  35
	!byte	.CSleep,       		 20
	!byte	Enemies.TCrossWipe,   	  1,  85
	!byte	.CSleep,       		 20
	!byte	Enemies.TCrossWipe,   	  0,  25
	!byte	.CSleep,       		 20
	!byte	Enemies.TCrossWipe,   	  1,  95
	!byte	.CSleep,       		192
	!byte	.CDone


.CrossWipeWave3                       	
	!byte	.CLoop + 3,  		 10,   5
	!byte	Enemies.TCrossWipe,   	  0,  25
	!byte	.CSleep,       		 30
	!byte	.CLoop + 3,  		 10,  -5
	!byte	Enemies.TCrossWipe,   	  1,  95
	!byte	.CSleep,       		 30
	!byte	.CLoop + 3,  		 10,   5
	!byte	Enemies.TCrossWipe,   	  0,  25
	!byte	.CSleep,       		 30
	!byte	.CLoop + 3,  		 10,  -5
	!byte	Enemies.TCrossWipe,   	  1,  95
	!byte	.CSleep,       		 30
	!byte	.CLoop + 3,  		 10,   5
	!byte	Enemies.TCrossWipe,   	  0,  25
	!byte	.CSleep,       		 30
	!byte	.CLoop + 3,  		 10,  -5
	!byte	Enemies.TCrossWipe,   	  1,  95
	!byte	.CSleep,       		192
	!byte	.CDone

	
.CrossWipeWave4                       	
	!byte	Enemies.TCrossWipe,   	  0,  35
	!byte	.CSleep,       		  5
	!byte	Enemies.TCrossWipe,   	  1,  85
	!byte	.CSleep,       		 20
	!byte	Enemies.TCrossWipe,   	  0,  30
	!byte	.CSleep,       		  5
	!byte	Enemies.TCrossWipe,   	  1,  90
	!byte	.CSleep,       		 20
	!byte	Enemies.TCrossWipe,   	  0,  25
	!byte	.CSleep,       		  5
	!byte	Enemies.TCrossWipe,   	  1,  95
	!byte	.CSleep,       		 20
	!byte	Enemies.TCrossWipe,   	  0,  30
	!byte	.CSleep,       		  5
	!byte	Enemies.TCrossWipe,   	  1,  90
	!byte	.CSleep,       		 20
	!byte	Enemies.TCrossWipe,   	  0,  35
	!byte	.CSleep,       		  5
	!byte	Enemies.TCrossWipe,   	  1,  85
	!byte	.CSleep,       		 20
	!byte	Enemies.TCrossWipe,   	  0,  25
	!byte	.CSleep,       		  5
	!byte	Enemies.TCrossWipe,   	  1,  95
	!byte	.CSleep,       		192
	!byte	.CDone

.StarMineWave1
	!byte	Enemies.TStarMine,   	 32,  30
	!byte	.CSleep,       		  5
	!byte	Enemies.TStarMine,   	-32,  90
	!byte	.CSleep,       		  5
	!byte	Enemies.TStarMine,   	 32,  60
	!byte	.CSleep,       		  5
	!byte	Enemies.TStarMine,   	-32,  60
	!byte	.CSleep,       		 37
	
	!byte	Enemies.TStarMine,   	 32,  30
	!byte	.CSleep,       		  5
	!byte	Enemies.TStarMine,   	-32,  90
	!byte	.CSleep,       		  5
	!byte	Enemies.TStarMine,   	 32,  60
	!byte	.CSleep,       		  5
	!byte	Enemies.TStarMine,   	-32,  60
	!byte	.CSleep,       		 69
	!byte	.CDone
	
.StarMineWave2                       	
	!byte	Enemies.TStarMine,   	 28,  30
	!byte	Enemies.TStarMine,   	-28,  90
	!byte	Enemies.TStarMine,   	 28,  60
	!byte	Enemies.TStarMine,   	-28,  60
	!byte	.CSleep,       		 24
	
	!byte	Enemies.TStarMine,   	 32,  30
	!byte	Enemies.TStarMine,   	-32,  90
	!byte	Enemies.TStarMine,   	 32,  60
	!byte	Enemies.TStarMine,   	-32,  60
	!byte	.CSleep,       		 24
	
	!byte	Enemies.TStarMine,   	 36,  30
	!byte	Enemies.TStarMine,   	-36,  90
	!byte	Enemies.TStarMine,   	 36,  60
	!byte	Enemies.TStarMine,   	-36,  60
	!byte	.CSleep,       		 32
	!byte	.CDone

.StarMineWave3                       	
	!byte	Enemies.TStarMine,   	 32,  30
	!byte	Enemies.TStarMine,   	-32,  90
	!byte	Enemies.TStarMine,   	 32,  60
	!byte	Enemies.TStarMine,   	-32,  60
	!byte	.CSleep,       		 12

	!byte	Enemies.TStarMine,   	 42,  30
	!byte	Enemies.TStarMine,   	-42,  90
	!byte	Enemies.TStarMine,   	 42,  60
	!byte	Enemies.TStarMine,   	-42,  60
	!byte	.CSleep,       		 18
	
	!byte	Enemies.TStarMine,   	 52,  30
	!byte	Enemies.TStarMine,   	-52,  90
	!byte	Enemies.TStarMine,   	 52,  60
	!byte	Enemies.TStarMine,   	-52,  60
	!byte	.CSleep,       		 32
	!byte	.CDone

	
.SentinelWave1
	!byte	.CLoop + 2,  		  0,  40
	!byte	Enemies.TSentinel, 	  0,  30
	!byte	.CSleep,       		160
	!byte	.CLoop + 2,  		  0,  40
	!byte	Enemies.TSentinel, 	  0,  50
	!byte	.CSleep,       		160
	!byte	.CDone

.SentinelWave2                     	  
	!byte	.CLoop + 2,  		  0,  40
	!byte	Enemies.TSentinel, 	  0,  30
	!byte	.CSleep,       		160
	!byte	.CLoop + 2,  		  0,  40
	!byte	Enemies.TSentinel, 	  0,  40
	!byte	.CSleep,       		160
	!byte	.CLoop + 2,  		  0,  40
	!byte	Enemies.TSentinel, 	  0,  50
	!byte	.CSleep,       		160
	!byte	.CDone

.SentinelWave3                     	  
	!byte	.CLoop + 3,  		  0,  20
	!byte	Enemies.TSentinel, 	  0,  35
	!byte	.CSleep,       		160
	!byte	.CLoop + 3,  		  0,  20
	!byte	Enemies.TSentinel, 	  0,  45
	!byte	.CSleep,       		160
	!byte	.CDone


.SentinelWave4                     	  
	!byte	.CLoop + 3,  		  0,  20
	!byte	Enemies.TSentinel, 	  0,  30
	!byte	.CSleep,       		144
	!byte	.CLoop + 3,  		  0,  20
	!byte	Enemies.TSentinel, 	  0,  40
	!byte	.CSleep,       		144
	!byte	.CLoop + 3,  		  0,  20
	!byte	Enemies.TSentinel, 	  0,  50
	!byte	.CSleep,       		160
	!byte	.CDone


.SentinelWave5                     	  
	!byte	.CLoop + 3,  		  0,  20
	!byte	Enemies.TSentinel, 	  0,  30
	!byte	.CSleep,       		144
	!byte	.CLoop + 3,  		  0,  20
	!byte	Enemies.TSentinel, 	  0,  40
	!byte	.CSleep,       		144
	!byte	.CLoop + 3,  		  0,  20
	!byte	Enemies.TSentinel, 	  0,  50
	!byte	.CSleep,       		160
	!byte	.CLoop + 3,  		  0,  20
	!byte	Enemies.TSentinel, 	  0,  30
	!byte	.CSleep,       		144
	!byte	.CLoop + 3,  		  0,  20
	!byte	Enemies.TSentinel, 	  0,  40
	!byte	.CSleep,       		144
	!byte	.CLoop + 3,  		  0,  20
	!byte	Enemies.TSentinel, 	  0,  50
	!byte	.CSleep,       		160
	!byte	.CDone


.SentinelWave6                     	  
	!byte	.CLoop + 3,  		  2,  15
	!byte	Enemies.TSentinel, 	  0,  30
	!byte	.CSleep,       		128
	!byte	.CLoop + 3,  		  2,  15
	!byte	Enemies.TSentinel, 	  0,  40
	!byte	.CSleep,       		128
	!byte	.CLoop + 3,  		  2,  15
	!byte	Enemies.TSentinel, 	  0,  50
	!byte	.CSleep,       		160
	!byte	.CLoop + 3,  		  2,  15
	!byte	Enemies.TSentinel, 	  0,  35
	!byte	.CSleep,       		128
	!byte	.CLoop + 3,  		  2,  15
	!byte	Enemies.TSentinel, 	  0,  45
	!byte	.CSleep,       		128
	!byte	.CLoop + 3,  		  2,  15
	!byte	Enemies.TSentinel, 	  0,  55
	!byte	.CSleep,       		160
	!byte	.CDone

	
.SentinelShortWave1
	!byte	.CLoop + 2,  		  0,  40
	!byte	Enemies.TSentinel, 	  0,  30
	!byte	.CSleep,       		 80
	!byte	.CDone

.SentinelShortWave2
	!byte	.CLoop + 2,  		  0,  40
	!byte	Enemies.TSentinel, 	  0,  50
	!byte	.CSleep,       		 80
	!byte	.CDone



.AssassinWave1
	!byte	Enemies.TAssassin, 	  0,  30
	!byte	.CSleep,       		254
	!byte	.CDone

.AssassinWave2                     	  
	!byte	.CLoop + 2,  		  4,  60
	!byte	Enemies.TAssassin, 	  0,  30
	!byte	.CSleep,       		254
	!byte	.CDone

.AssassinWave3                     	  
	!byte	.CLoop + 2,  		  4,  60
	!byte	Enemies.TAssassin, 	  0,  30
	!byte	.CSleep,       		 96
	!byte	.CLoop + 2,  		  4,  60
	!byte	Enemies.TAssassin, 	  0,  30
	!byte	.CSleep,       		254
	!byte	.CDone

.AssassinWave4                     	  
	!byte	.CLoop + 3,  		  4,  30
	!byte	Enemies.TAssassin, 	  0,  30
	!byte	.CSleep,       		 96
	!byte	.CLoop + 3,  		  4,  30
	!byte	Enemies.TAssassin, 	  0,  30
	!byte	.CSleep,       		 96
	!byte	.CLoop + 3,  		  4,  30
	!byte	Enemies.TAssassin, 	  0,  30
	!byte	.CSleep,       		254
	!byte	.CDone

	
.BonusWaveWeapon1
	!byte	Enemies.TBonus, 0,  30
	!byte	.CSleep,       		96
	!byte	.CDone

.BonusWaveLaser1
	!byte	Enemies.TBonus, 1,  30
	!byte	.CSleep,       		96
	!byte	.CDone
	
.BonusWaveDrone1
	!byte	Enemies.TBonus, 2,  30
	!byte	.CSleep,       		96
	!byte	.CDone

.BonusWaveShield1
	!byte	Enemies.TBonus, 3,  30
	!byte	.CSleep,       		96
	!byte	.CDone

.BonusWaveMissile1
	!byte	Enemies.TBonus, 4,  30
	!byte	.CSleep,       		96
	!byte	.CDone

.BonusWaveLive1
	!byte	Enemies.TBonus, 5,  30
	!byte	.CSleep,       		96
	!byte	.CDone

.BonusWaveTurbo1
	!byte	Enemies.TBonus, 6,  30
	!byte	.CSleep,       		96
	!byte	.CDone

.BonusWaveFlame1
	!byte	Enemies.TBonus, 7,  30
	!byte	.CSleep,       		96
	!byte	.CDone
	
.BonusWaveWeapon2
	!byte	Enemies.TBonus, 0,  80
	!byte	.CSleep,       		96
	!byte	.CDone

.BonusWaveLaser2
	!byte	Enemies.TBonus, 1,  80
	!byte	.CSleep,       		96
	!byte	.CDone
	
.BonusWaveDrone2
	!byte	Enemies.TBonus, 2,  80
	!byte	.CSleep,       		96
	!byte	.CDone

.BonusWaveShield2
	!byte	Enemies.TBonus, 3,  80
	!byte	.CSleep,       		96
	!byte	.CDone

.BonusWaveMissile2
	!byte	Enemies.TBonus, 4,  80
	!byte	.CSleep,       		96
	!byte	.CDone

.BonusWaveLive2
	!byte	Enemies.TBonus, 5,  80
	!byte	.CSleep,       		96
	!byte	.CDone

.BonusWaveTurbo2
	!byte	Enemies.TBonus, 6,  80
	!byte	.CSleep,       		96
	!byte	.CDone

.BonusWaveFlame2
	!byte	Enemies.TBonus, 7,  80
	!byte	.CSleep,       		96
	!byte	.CDone

	
.DestroyerWave1
	!byte	Enemies.TDestroyer1,    -20,  70
	!byte	.CSleep,       		144
	!byte	.CDone
	
.DestroyerWave2
	!byte	Enemies.TDestroyer1,   	 20,  30
	!byte	.CSleep,       	 	 28
	!byte	Enemies.TDestroyer1,   	-20,  90
	!byte	.CSleep,       		144
	!byte	.CDone
	
.DestroyerWave3                        	
	!byte	Enemies.TDestroyer1,   	 20,  30
	!byte	.CSleep,       	 	 28
	!byte	Enemies.TDestroyer1,   	  0,  60
	!byte	.CSleep,       	 	 28
	!byte	Enemies.TDestroyer1,   	-20,  90
	!byte	.CSleep,       		144
	!byte	.CDone
	
.DestroyerWave4                        	
	!byte	Enemies.TDestroyer1,   	 20,  30
	!byte	.CSleep,       	 	 28
	!byte	.CLoop + 2,  		 16,  10
	!byte	Enemies.TDestroyer1,   	 10,  40
	!byte	.CSleep,       	 	 16
	!byte	Enemies.TDestroyer1,   	  0,  60
	!byte	.CSleep,       	 	 28
	!byte	.CLoop + 2,  		 16,  10
	!byte	Enemies.TDestroyer1,   	-10,  70
	!byte	.CSleep,       	 	 16
	!byte	Enemies.TDestroyer1,   	-20,  90
	!byte	.CSleep,       		144
	!byte	.CDone

	
.SquidWave1
	!byte	Enemies.TSquid, 	  0, 100
	!byte	.CSleep,       	 	 16
	!byte	Enemies.TSquid, 	  1,  40
	!byte	.CSleep,       	 	128
	!byte	.CDone

.SquidWave2
	!byte	Enemies.TSquid, 	  0, 100
	!byte	.CSleep,       	 	 16
	!byte	Enemies.TSquid, 	  1,  40
	!byte	.CSleep,       	 	 32
	!byte	Enemies.TSquid, 	  0, 100
	!byte	.CSleep,       	 	 16
	!byte	Enemies.TSquid, 	  1,  40
	!byte	.CSleep,       	 	128
	!byte	.CDone

.SquidWave3                     	  
	!byte	Enemies.TSquid, 	  0, 100
	!byte	.CSleep,       	 	 16
	!byte	Enemies.TSquid, 	  1,  40
	!byte	.CSleep,       	 	 32
	!byte	Enemies.TSquid, 	  0, 100
	!byte	.CSleep,       	 	 16
	!byte	Enemies.TSquid, 	  1,  40
	!byte	.CSleep,       	 	 32
	!byte	Enemies.TSquid, 	  0, 100
	!byte	.CSleep,       	 	 16
	!byte	Enemies.TSquid, 	  1,  40
	!byte	.CSleep,       	 	128
	!byte	.CDone

.SquidWave4                     	  
	!byte	.CLoop + 2,  		  0, -10
	!byte	Enemies.TSquid, 	  0, 100
	!byte	.CSleep,       	 	 16
	!byte	.CLoop + 2,  		  0,  10
	!byte	Enemies.TSquid, 	  1,  40
	!byte	.CSleep,       	 	 32
	!byte	.CLoop + 2,  		  0, -10
	!byte	Enemies.TSquid, 	  0, 100
	!byte	.CSleep,       	 	 16
	!byte	.CLoop + 2,  		  0,  10
	!byte	Enemies.TSquid, 	  1,  40
	!byte	.CSleep,       	 	128
	!byte	.CDone

.SquidWave5
	!byte	Enemies.TSquid, 	$80, 100
	!byte	.CSleep,       	 	 16
	!byte	Enemies.TSquid, 	$81,  40
	!byte	.CSleep,       	 	128
	!byte	.CDone

.SquidWave6
	!byte	Enemies.TSquid, 	$80, 100
	!byte	.CSleep,       	 	 16
	!byte	Enemies.TSquid, 	$81,  40
	!byte	.CSleep,       	 	 32
	!byte	Enemies.TSquid, 	$80, 100
	!byte	.CSleep,       	 	 16
	!byte	Enemies.TSquid, 	$81,  40
	!byte	.CSleep,       	 	128
	!byte	.CDone

.SquidWave7                     		  
	!byte	Enemies.TSquid, 	$80, 100
	!byte	.CSleep,       	 	 16
	!byte	Enemies.TSquid, 	$81,  40
	!byte	.CSleep,       	 	 32
	!byte	Enemies.TSquid, 	$80, 100
	!byte	.CSleep,       	 	 16
	!byte	Enemies.TSquid, 	$81,  40
	!byte	.CSleep,       	 	 32
	!byte	Enemies.TSquid, 	$80, 100
	!byte	.CSleep,       	 	 16
	!byte	Enemies.TSquid, 	$81,  40
	!byte	.CSleep,       	 	128
	!byte	.CDone

	
.SpikeWave1
	!byte	Enemies.TSpike,  	  0,  30
	!byte	Enemies.TSpike,  	  1,  40
	!byte	Enemies.TSpike,  	  2,  50
	!byte	.CSleep,       	 	128
	!byte	.CDone

.SpikeWave2                      	
	!byte	Enemies.TSpike,  	  0,  30
	!byte	Enemies.TSpike,  	  1,  40
	!byte	Enemies.TSpike,  	  2,  50
	!byte	.CSleep,       	 	 64
	!byte	Enemies.TSpike,  	  4,  85
	!byte	Enemies.TSpike,  	  5,  95
	!byte	Enemies.TSpike,  	  6, 105
	!byte	.CSleep,       	 	128
	!byte	.CDone

.SpikeWave3                      	
	!byte	Enemies.TSpike,  	  0,  30
	!byte	Enemies.TSpike,  	  1,  40
	!byte	Enemies.TSpike,  	  2,  50
	!byte	.CSleep,       	 	 80
	!byte	Enemies.TSpike,  	  4,  85
	!byte	Enemies.TSpike,  	  5,  95
	!byte	Enemies.TSpike,  	  6, 105
	!byte	.CSleep,       	 	 80
	!byte	Enemies.TSpike,  	  0,  30
	!byte	Enemies.TSpike,  	  1,  40
	!byte	Enemies.TSpike,  	  2,  50
	!byte	.CSleep,       	 	 80
	!byte	Enemies.TSpike,  	  4,  85
	!byte	Enemies.TSpike,  	  5,  95
	!byte	Enemies.TSpike,  	  6, 105
	!byte	.CSleep,       	 	128
	!byte	.CDone

.SpikeWave4                      	
	!byte	Enemies.TSpike,  	  0,  30
	!byte	Enemies.TSpike,  	  1,  40
	!byte	Enemies.TSpike,  	  2,  50
	!byte	.CSleep,       	 	 80
	!byte	Enemies.TSpike,  	  0,  30
	!byte	Enemies.TSpike,  	  1,  40
	!byte	Enemies.TSpike,  	  2,  50
	!byte	.CSleep,       	 	100
	!byte	Enemies.TSpike,  	  4,  85
	!byte	Enemies.TSpike,  	  5,  95
	!byte	Enemies.TSpike,  	  6, 105
	!byte	.CSleep,       	 	 80
	!byte	Enemies.TSpike,  	  0,  30
	!byte	Enemies.TSpike,  	  1,  40
	!byte	Enemies.TSpike,  	  2,  50
	!byte	.CSleep,       	 	100
	!byte	Enemies.TSpike,  	  4,  85
	!byte	Enemies.TSpike,  	  5,  95
	!byte	Enemies.TSpike,  	  6, 105
	!byte	.CSleep,       	 	 80
	!byte	Enemies.TSpike,  	  4,  85
	!byte	Enemies.TSpike,  	  5,  95
	!byte	Enemies.TSpike,  	  6, 105
	!byte	.CSleep,       	 	100
	!byte	Enemies.TSpike,  	  0,  30
	!byte	Enemies.TSpike,  	  1,  40
	!byte	Enemies.TSpike,  	  2,  50
	!byte	.CSleep,       	 	 80
	!byte	Enemies.TSpike,  	  4,  85
	!byte	Enemies.TSpike,  	  5,  95
	!byte	Enemies.TSpike,  	  6, 105
	!byte	.CSleep,       	 	128
	!byte	.CDone

.SAMissileWave1
	!byte	.CLoop + 3,  		 24,   0
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,       	 	128
	!byte	.CDone

.SAMissileWave2                     	  
	!byte	.CLoop + 5,  		 24,   0
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,       	 	128
	!byte	.CDone

.SAMissileWave3                     	  
	!byte	.CLoop + 5,  		 36,   0
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,       	 	128
	!byte	.CDone

.SAMissileWave4                     	  
	!byte	.CLoop + 2,  		 24,   0
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,       	 	 48
	!byte	.CLoop + 2,  		 24,   0
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,       	 	 48
	!byte	.CLoop + 2,  		 24,   0
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,       	 	 48
	!byte	.CLoop + 2,  		 24,   0
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,       	 	128
	!byte	.CDone

	
.BombDropWave1
	!byte	.CLoop + 3,  		 24,   0
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	.CSleep,       	 	128
	!byte	.CDone

.BombDropWave2                     	  
	!byte	.CLoop + 5,  		 24,   0
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	.CSleep,       	 	128
	!byte	.CDone

.BombDropWave3                     	  
	!byte	.CLoop + 5,  		 36,   0
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	.CSleep,       	 	128
	!byte	.CDone

.BombDropWave4                     	  
	!byte	.CLoop + 2,  		 24,   0
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	.CSleep,       	 	 48
	!byte	.CLoop + 2,  		 24,   0
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	.CSleep,       	 	 48
	!byte	.CLoop + 2,  		 24,   0
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	.CSleep,       	 	 48
	!byte	.CLoop + 2,  		 24,   0
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	.CSleep,       	 	128
	!byte	.CDone

	
.BombMissileWave1
	!byte	.CLoop + 2,  		 24,   0
	!byte	Enemies.TBombDrop,  	  0,  25
	!byte	.CLoop + 3,  		 24,   0
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,       	 	128
	!byte	.CDone

.BombMissileWave2                   	  
	!byte	.CLoop + 2,  		 24,   0
	!byte	Enemies.TBombDrop,  	  0,  25
	!byte	.CLoop + 2,  		 24,   0
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,       	 	 24
	!byte	.CLoop + 2,  		 24,   0
	!byte	Enemies.TBombDrop,  	  0,  25
	!byte	.CLoop + 2,  		 24,   0
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,       	 	128
	!byte	.CDone

.BombMissileWave3                   	  
	!byte	.CLoop + 2,  		 24,   0
	!byte	Enemies.TBombDrop,  	  0,  25
	!byte	.CLoop + 2,  		 24,   0
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,       	 	 24
	!byte	.CLoop + 2,  		 24,   0
	!byte	Enemies.TBombDrop,  	  0,  25
	!byte	.CLoop + 2,  		 24,   0
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,       	 	 24
	!byte	.CLoop + 2,  		 24,   0
	!byte	Enemies.TBombDrop,  	  0,  25
	!byte	.CLoop + 2,  		 24,   0
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,       	 	128
	!byte	.CDone
	
	
.SnakeWave1
	!byte	.CLoop + 20,  		 14,   0
	!byte	Enemies.TSnake, 	  0,  60
	!byte	.CSleep,       	 	250
	!byte	.CDone

.SnakeWave2
	!byte	.CLoop + 20,  		 14,   0
	!byte	Enemies.TSnake, 	  1,  60
	!byte	.CSleep,       	 	250
	!byte	.CDone

.SnakeWave3
	!byte	.CLoop + 20,  		 14,   0
	!byte	Enemies.TSnake, 	  2,  60
	!byte	.CSleep,       	 	250
	!byte	.CDone

.SnakeWave4
	!byte	.CLoop + 20,  		 14,   0
	!byte	Enemies.TSnake, 	  3,  60
	!byte	.CSleep,       	 	250
	!byte	.CDone
	
.GrowBlockText	!text	"SLOW DOWN, ROADBLOCK AHEAD", 0

.GrowBlockWave1a
	!byte	EnemyWave.CText, 	<.GrowBlockText, >.GrowBlockText
	!byte	.CSleep,       	 	 64

	!byte	Enemies.TGrowBlock, 	  0,  30
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  30
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  30
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  30
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  6,  30
	!byte	.CSleep,       	 	 64
	!byte	.CDone              	

.GrowBlockWave1b                    	
	!byte	Enemies.TGrowBlock, 	  0,  55
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  55
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  55
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  55
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  6,  55
	!byte	.CSleep,       	 	 64
	!byte	.CDone              	

.GrowBlockWave1c                    	
	!byte	Enemies.TGrowBlock, 	  0,  80
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  80
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  80
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  80
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  6,  80
	!byte	.CSleep,       	 	 64
	!byte	.CDone              	

.GrowBlockWave2a                    	
	!byte	EnemyWave.CText, 	<.GrowBlockText, >.GrowBlockText
	!byte	.CSleep,       	 	 64

	!byte	Enemies.TGrowBlock, 	  0,  40
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  40
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  40
	!byte	Enemies.TGrowBlock, 	  0,  80
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  40
	!byte	Enemies.TGrowBlock, 	  3,  80
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  6,  40
	!byte	Enemies.TGrowBlock, 	  3,  80
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  80
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  6,  80
	!byte	.CSleep,       	 	 64
	!byte	.CDone              	

.GrowBlockWave2b                    	
	!byte	Enemies.TGrowBlock, 	  0,  30
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  30	
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  30
	!byte	Enemies.TGrowBlock, 	  0,  60
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  30
	!byte	Enemies.TGrowBlock, 	  3,  60
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  6,  30
	!byte	Enemies.TGrowBlock, 	  3,  60
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  60
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  6,  60
	!byte	.CSleep,       	 	 64
	!byte	.CDone              	

.GrowBlockWave2c                    	
	!byte	Enemies.TGrowBlock, 	  0,  50
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  50
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  50
	!byte	Enemies.TGrowBlock, 	  0,  30
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  50
	!byte	Enemies.TGrowBlock, 	  3,  30
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  6,  50
	!byte	Enemies.TGrowBlock, 	  3,  30
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  30
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  6,  30
	!byte	.CSleep,       	 	 64
	!byte	.CDone              	

.GrowBlockWave3a
	!byte	EnemyWave.CText, 	<.GrowBlockText, >.GrowBlockText
	!byte	.CSleep,       	 	 64

	!byte	Enemies.TGrowBlock, 	  0,  30
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  30
	!byte	.CSleep,       	 	  4

	!byte	Enemies.TGrowBlock, 	  3,  30
	!byte	Enemies.TGrowBlock, 	  0,  80
	!byte	.CSleep,       	 	  4
	
	!byte	Enemies.TGrowBlock, 	  3,  30
	!byte	Enemies.TGrowBlock, 	  3,  80
	!byte	.CSleep,       	 	  4

	!byte	Enemies.TGrowBlock, 	  6,  30
	!byte	Enemies.TGrowBlock, 	  3,  80
	!byte	Enemies.TGrowBlock, 	  0,  50
	!byte	.CSleep,       	 	  4
	
	!byte	Enemies.TGrowBlock, 	  3,  80
	!byte	Enemies.TGrowBlock, 	  3,  50
	!byte	.CSleep,       	 	  4

	!byte	Enemies.TGrowBlock, 	  6,  80
	!byte	Enemies.TGrowBlock, 	  3,  50
	!byte	.CSleep,       	 	  4
	
	!byte	Enemies.TGrowBlock, 	  3,  50
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  6,  50
	!byte	.CSleep,       	 	 64
	!byte	.CDone              	

.GrowBlockWave3b                    	
	!byte	Enemies.TGrowBlock, 	  0,  90
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  90
	!byte	.CSleep,       	 	  4

	!byte	Enemies.TGrowBlock, 	  3,  90
	!byte	Enemies.TGrowBlock, 	  0,  45
	!byte	.CSleep,       	 	  4
	
	!byte	Enemies.TGrowBlock, 	  3,  90
	!byte	Enemies.TGrowBlock, 	  3,  45
	!byte	.CSleep,       	 	  4

	!byte	Enemies.TGrowBlock, 	  6,  90
	!byte	Enemies.TGrowBlock, 	  3,  45
	!byte	Enemies.TGrowBlock, 	  0,  70
	!byte	.CSleep,       	 	  4
	
	!byte	Enemies.TGrowBlock, 	  3,  45
	!byte	Enemies.TGrowBlock, 	  3,  70
	!byte	.CSleep,       	 	  4

	!byte	Enemies.TGrowBlock, 	  6,  45
	!byte	Enemies.TGrowBlock, 	  3,  70
	!byte	.CSleep,       	 	  4
	
	!byte	Enemies.TGrowBlock, 	  3,  70
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  6,  70
	!byte	.CSleep,       	 	 64
	!byte	.CDone              	

.GrowBlockWave3c                    	
	!byte	Enemies.TGrowBlock, 	  0,  25
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  3,  25
	!byte	.CSleep,       	 	  4

	!byte	Enemies.TGrowBlock, 	  3,  25
	!byte	Enemies.TGrowBlock, 	  0,  75
	!byte	.CSleep,       	 	  4
	
	!byte	Enemies.TGrowBlock, 	  3,  25
	!byte	Enemies.TGrowBlock, 	  3,  75
	!byte	.CSleep,       	 	  4

	!byte	Enemies.TGrowBlock, 	  6,  25
	!byte	Enemies.TGrowBlock, 	  3,  75
	!byte	Enemies.TGrowBlock, 	  0,  40
	!byte	.CSleep,       	 	  4
	
	!byte	Enemies.TGrowBlock, 	  3,  75
	!byte	Enemies.TGrowBlock, 	  3,  40
	!byte	.CSleep,       	 	  4

	!byte	Enemies.TGrowBlock, 	  6,  75
	!byte	Enemies.TGrowBlock, 	  3,  40
	!byte	.CSleep,       	 	  4
	
	!byte	Enemies.TGrowBlock, 	  3,  40
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  6,  40
	!byte	.CSleep,       	 	 64
	!byte	.CDone              	

.GrowBlockWave4a                    	
	!byte	EnemyWave.CText, 	<.GrowBlockText, >.GrowBlockText
	!byte	.CSleep,       	 	 64

	!byte	Enemies.TGrowBlock, 	  0,  65
	!byte	.CSleep,       	 	  4

	!byte	Enemies.TGrowBlock, 	  3,  65
	!byte	Enemies.TGrowBlock, 	  0,  25
	!byte	.CSleep,       	 	  4
	
	!byte	Enemies.TGrowBlock, 	  3,  65
	!byte	Enemies.TGrowBlock, 	  3,  25
	!byte	.CSleep,       	 	  4
	
	!byte	Enemies.TGrowBlock, 	  3,  65
	!byte	Enemies.TGrowBlock, 	  3,  25
	!byte	.CSleep,       	 	  4

	!byte	Enemies.TGrowBlock, 	  6,  65
	!byte	Enemies.TGrowBlock, 	  3,  25
	!byte	Enemies.TGrowBlock, 	  0,  40
	!byte	.CSleep,       	 	  4
	
	!byte	Enemies.TGrowBlock, 	  6,  25
	!byte	Enemies.TGrowBlock, 	  3,  40
	!byte	.CSleep,       	 	  4
	
	!byte	Enemies.TGrowBlock, 	  3,  40
	!byte	Enemies.TGrowBlock, 	  0,  90
	!byte	.CSleep,       	 	  4

	!byte	Enemies.TGrowBlock, 	  3,  40
	!byte	Enemies.TGrowBlock, 	  3,  90
	!byte	.CSleep,       	 	  4

	!byte	Enemies.TGrowBlock, 	  6,  40
	!byte	Enemies.TGrowBlock, 	  3,  90
	!byte	.CSleep,       	 	  4
	
	!byte	Enemies.TGrowBlock, 	  3,  90
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  6,  90
	!byte	.CSleep,       	 	 64
	!byte	.CDone              	

.GrowBlockWave4b                    	
	!byte	Enemies.TGrowBlock, 	  0,  35
	!byte	.CSleep,       	 	  4

	!byte	Enemies.TGrowBlock, 	  3,  35
	!byte	Enemies.TGrowBlock, 	  0,  55
	!byte	.CSleep,       	 	  4
	
	!byte	Enemies.TGrowBlock, 	  3,  35
	!byte	Enemies.TGrowBlock, 	  3,  55
	!byte	.CSleep,       	 	  4
	
	!byte	Enemies.TGrowBlock, 	  3,  35
	!byte	Enemies.TGrowBlock, 	  3,  55
	!byte	.CSleep,       	 	  4

	!byte	Enemies.TGrowBlock, 	  6,  35
	!byte	Enemies.TGrowBlock, 	  3,  55
	!byte	Enemies.TGrowBlock, 	  0,  83
	!byte	.CSleep,       	 	  4
	
	!byte	Enemies.TGrowBlock, 	  6,  55
	!byte	Enemies.TGrowBlock, 	  3,  83
	!byte	.CSleep,       	 	  4
	
	!byte	Enemies.TGrowBlock, 	  3,  83
	!byte	Enemies.TGrowBlock, 	  0,  70
	!byte	.CSleep,       	 	  4

	!byte	Enemies.TGrowBlock, 	  3,  83
	!byte	Enemies.TGrowBlock, 	  3,  70
	!byte	.CSleep,       	 	  4

	!byte	Enemies.TGrowBlock, 	  6,  83
	!byte	Enemies.TGrowBlock, 	  3,  70
	!byte	.CSleep,       	 	  4
	
	!byte	Enemies.TGrowBlock, 	  3,  70
	!byte	.CSleep,       	 	  4
	!byte	Enemies.TGrowBlock, 	  6,  70
	!byte	.CSleep,       	 	 64
	!byte	.CDone              	


	
.WhirlingWave0F                     	
	!byte	Enemies.TWhirling,  	  2,  30
	!byte	Enemies.TWhirling,  	  1,  41
	!byte	Enemies.TWhirling,  	  0,  52
	!byte	Enemies.TWhirling,  	  3,  63
	!byte	Enemies.TWhirling,  	  4,  74
	!byte	.CSleep,       	 	128
	!byte	.CDone              	
	
.WhirlingWave1F                     	
	!byte	Enemies.TWhirling,  	  2,  40
	!byte	Enemies.TWhirling,  	  1,  51
	!byte	Enemies.TWhirling,  	  0,  62
	!byte	Enemies.TWhirling,  	  3,  73
	!byte	Enemies.TWhirling,  	  4,  84
	!byte	.CSleep,       	 	128
	!byte	.CDone              	
	
.WhirlingWave2F                     	
	!byte	Enemies.TWhirling,  	  2,  50
	!byte	Enemies.TWhirling,  	  1,  61
	!byte	Enemies.TWhirling,  	  0,  72
	!byte	Enemies.TWhirling,  	  3,  83
	!byte	Enemies.TWhirling,  	  4,  94
	!byte	.CSleep,       	 	128
	!byte	.CDone              	
	
.WhirlingWave0B                     	
	!byte	Enemies.TWhirling,  	 10,  30
	!byte	Enemies.TWhirling,  	  9,  41
	!byte	Enemies.TWhirling,  	  8,  52
	!byte	Enemies.TWhirling,  	 11,  63
	!byte	Enemies.TWhirling,  	 12,  74
	!byte	.CSleep,       	 	128
	!byte	.CDone              	
	
.WhirlingWave1B                     	
	!byte	Enemies.TWhirling,  	 10,  40
	!byte	Enemies.TWhirling,  	  9,  51
	!byte	Enemies.TWhirling,  	  8,  62
	!byte	Enemies.TWhirling,  	 11,  73
	!byte	Enemies.TWhirling,  	 12,  84
	!byte	.CSleep,       	 	128
	!byte	.CDone              	
	
.WhirlingWave2B                     	
	!byte	Enemies.TWhirling,  	 10,  50
	!byte	Enemies.TWhirling,  	  9,  61
	!byte	Enemies.TWhirling,  	  8,  72
	!byte	Enemies.TWhirling,  	 11,  83
	!byte	Enemies.TWhirling,  	 12,  94
	!byte	.CSleep,       	 	128
	!byte	.CDone              	
	

.WhirlingMissileWave0
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,		 24
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,		 24
	!byte	Enemies.TWhirling,  	 10,  30
	!byte	Enemies.TWhirling,  	  9,  41
	!byte	Enemies.TWhirling,  	  8,  52
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	Enemies.TWhirling,  	 11,  63
	!byte	Enemies.TWhirling,  	 12,  74
	!byte	.CSleep,		 24
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,		 24
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,       	 	128
	!byte	.CDone              	
	
.WhirlingMissileWave1
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,		 24
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,		 24
	!byte	Enemies.TWhirling,  	 10,  40
	!byte	Enemies.TWhirling,  	  9,  51
	!byte	Enemies.TWhirling,  	  8,  62
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	Enemies.TWhirling,  	 11,  73
	!byte	Enemies.TWhirling,  	 12,  84
	!byte	.CSleep,		 24
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,		 24
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,       	 	128
	!byte	.CDone              	
	
.WhirlingMissileWave2
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,		 24
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,		 24
	!byte	Enemies.TWhirling,  	 10,  50
	!byte	Enemies.TWhirling,  	  9,  61
	!byte	Enemies.TWhirling,  	  8,  72
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	Enemies.TWhirling,  	 11,  83
	!byte	Enemies.TWhirling,  	 12,  94
	!byte	.CSleep,		 24
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,		 24
	!byte	Enemies.TSAMissile, 	  0, 108
	!byte	.CSleep,       	 	128
	!byte	.CDone              	
	
.WhirlingBombWave0
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	.CSleep,		 24
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	.CSleep,		 24
	!byte	Enemies.TWhirling,  	 10,  30
	!byte	Enemies.TWhirling,  	  9,  41
	!byte	Enemies.TWhirling,  	  8,  52
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	Enemies.TWhirling,  	 11,  63
	!byte	Enemies.TWhirling,  	 12,  74
	!byte	.CSleep,		 24
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	.CSleep,		 24
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	.CSleep,       	 	128
	!byte	.CDone              	
	
.WhirlingBombWave1
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	.CSleep,		 24
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	.CSleep,		 24
	!byte	Enemies.TWhirling,  	 10,  40
	!byte	Enemies.TWhirling,  	  9,  51
	!byte	Enemies.TWhirling,  	  8,  62
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	Enemies.TWhirling,  	 11,  73
	!byte	Enemies.TWhirling,  	 12,  84
	!byte	.CSleep,		 24
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	.CSleep,		 24
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	.CSleep,       	 	128
	!byte	.CDone              	
	
.WhirlingBombWave2
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	.CSleep,		 24
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	.CSleep,		 24
	!byte	Enemies.TWhirling,  	 10,  50
	!byte	Enemies.TWhirling,  	  9,  61
	!byte	Enemies.TWhirling,  	  8,  72
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	Enemies.TWhirling,  	 11,  83
	!byte	Enemies.TWhirling,  	 12,  94
	!byte	.CSleep,		 24
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	.CSleep,		 24
	!byte	Enemies.TBombDrop, 	  0,  25
	!byte	.CSleep,       	 	128
	!byte	.CDone              	
	
.LevelTest1		!word	.DelayWave2, .WhirlingMissileWave0, .WhirlingBombWave1, .WhirlingMissileWave2, .WhirlingBombWave0, .WhirlingMissileWave1, .WhirlingBombWave2, .DelayWave8, 0
	
	

	!macro	LevelWave	level, color, message

	!byte	EnemyWave.CLevel, 	level, color
	!byte	EnemyWave.CText, 	<message, >message
	!byte	EnemyWave.CSleep,      16
	!byte	Enemies.TLevel, 	0 + 16 * color, 40
	!byte	EnemyWave.CSleep,       9
	!byte	Enemies.TLevel, 	1 + 16 * color, 40
	!byte	EnemyWave.CSleep,       4
	!byte	Enemies.TLevel, 	3 + level / 10 + 16 * color, 55
	!byte	EnemyWave.CSleep,       5
	!byte	Enemies.TLevel, 	2 + 16 * color, 40
	!byte	EnemyWave.CSleep,       4
	!byte	Enemies.TLevel, 	3 + level % 10 + 16 * color, 55
	!byte	EnemyWave.CSleep,       5
	!byte	Enemies.TLevel, 	1 + 16 * color, 40
	!byte	EnemyWave.CSleep,       9
	!byte	Enemies.TLevel, 	0 + 16 * color, 40
	!byte	EnemyWave.CSleep,     100
	!byte	EnemyWave.CDone

	!end

.Level01Msg	!text	"---LONG RANGE SENSORS DETECT INCOMMING FLEET---", 0
.Level02Msg	!text	"---INCOMMING FLEET CLASSIFIED AS HOSTILE---", 0
.Level03Msg	!text	"---LOOKS LIKE A MINOR SKIRMISH, HQ STARTS YEARLY FOLK DANCE FESITVAL---", 0
.Level04Msg	!text	"---OUTER SPACE EARLY WARNING SATELLITES LOST---", 0
.Level05Msg	!text	"---FORWARD DEFENCE LINE OVERRUN---", 0
.Level06Msg	!text	"---ENEMY HAS CLEARED OUTER RIM MINEFIELD---", 0
.Level07Msg	!text	"---MAIN DEFENCE FLEET NOW ON INTERCEPT COURSE---", 0
.Level08Msg	!text	"---CONTACT LOST WITH MINIG COLONIES IN ASTEROID BELT---", 0
.Level09Msg	!text	"---MAIN DEFENCE FLEET HAS ENGAGED ENEMY FLEET---", 0
.Level10Msg	!text	"---FLAGSHIP DESTROYED BY NUCLEAR BLAST---", 0
.Level11Msg	!text	"---CONTACT WITH DEFENCE FLEET LOST---", 0
.Level12Msg	!text	"---HOSTILE VANGUARD APPROACHING HOME WORLD---", 0
.Level13Msg	!text	"---HOME FLEET ENGAGING HOSTILE FLEET---", 0
.Level14Msg	!text	"---ORBITAL DEFENCE FORCES ENGAGING ENEMIES---", 0
.Level15Msg	!text	"---PLANETARY DEFENCE LINE UNDER HEAVY ATTACK---", 0
.Level16Msg	!text	"---THE ENEMY WILL NOT PREVAIL, FOLK DANCE FESTIVAL COMMENCES--", 0
.Level17Msg	!text	"---GOVERNMENT EVACUATED, IS ALL HOPE LOST---", 0
.Level18Msg	!text	"---PANIC IN THE STREETS, ALL MAJOR CITIES DESTROYED OR IN FLAMES---", 0
.Level19Msg	!text	"---FINAL DEFENCE LINE BREACHED, CIVILIZATION RESTS ON YOUR SHOULDERS---", 0
.Level20Msg	!text	"---LOOKS LIKE YOU ARE THE LAST ONE, WE WILL NOW ARGHHHHHHH---", 0

.Level01Wave	+LevelWave	 1,  5, .Level01Msg
.Level02Wave	+LevelWave	 2, 14, .Level02Msg
.Level03Wave	+LevelWave	 3, 14, .Level03Msg
.Level04Wave	+LevelWave	 4, 14, .Level04Msg
.Level05Wave	+LevelWave	 5, 15, .Level05Msg
.Level06Wave	+LevelWave	 6, 15, .Level06Msg
.Level07Wave	+LevelWave	 7, 10, .Level07Msg
.Level08Wave	+LevelWave	 8, 10, .Level08Msg
.Level09Wave	+LevelWave	 9, 13, .Level09Msg
.Level10Wave	+LevelWave	10, 13, .Level10Msg
.Level11Wave	+LevelWave	11,  3, .Level11Msg
.Level12Wave	+LevelWave	12,  3, .Level12Msg
.Level13Wave	+LevelWave	13,  4, .Level13Msg
.Level14Wave	+LevelWave	14,  4, .Level14Msg
.Level15Wave	+LevelWave	15,  7, .Level15Msg
.Level16Wave	+LevelWave	16,  7, .Level16Msg
.Level17Wave	+LevelWave	17,  7, .Level17Msg
.Level18Wave	+LevelWave	18,  8, .Level18Msg
.Level19Wave	+LevelWave	19,  8, .Level19Msg
.Level20Wave	+LevelWave	20,  0, .Level20Msg


.SoundInterludeWave	!byte	.CSound, <Sound.InterludeSound1, >Sound.InterludeSound1, .CDone
.CompletedWave		!byte	.CCompleted, 0, 0, .CSleep, 255, .CSleep, 255, .CDone

.Level00	!word	.WallWaveBranchTop, .DelayWave2, .WallWaveBranchBottom, .DelayWave4, .WallWaveLargeTop, .DelayWave, 0

;.LevelTest1
;	!word	.DelayWave, .BombDropWave4, .DelayWave

;	!word	.DelayWave, .WallSlideWaveMid1a, .WallSlideWaveMid1b, .WallSlideWaveDoor1a, .DelayWave, .WallSlideWaveMid2a, .WallSlideWaveMid2b, .WallSlideWaveDoor2a, .DelayWave, .WallSlideWaveMid3a, .WallSlideWaveMid3b, .WallSlideWaveDoor3a, .DelayWave, .WallSlideWaveMid4a, .WallSlideWaveMid4b, .WallSlideWaveDoor4a, .DelayWave
;	!word	.DelayWave, .WallShiftWave4a, .WallShiftWave4a, .WallShiftWave4a, .DelayWave, .WallShiftWave5a, .WallShiftWave5a, .WallShiftWave5a, .DelayWave, .WallShiftWave6a, .WallShiftWave6a, .WallShiftWave6a, .DelayWave


;	!word	.DelayWave, .GrowBlockWave1a, .GrowBlockWave1b, .GrowBlockWave1c, .DelayWave, .GrowBlockWave2a, .GrowBlockWave2b, .GrowBlockWave2c, .DelayWave, .GrowBlockWave3a, .GrowBlockWave3b, .GrowBlockWave3c, .DelayWave, .GrowBlockWave4a, .GrowBlockWave4b, .DelayWave

.Level01	!word	.Level01Wave, .ArrowWave1, .WallWaveMid3, .BonusWaveWeapon1, .WallWaveMid1, .DelayWave2, .AsteroidWave1, .BonusWaveDrone2, .BreakerWave1, .DelayWave2, .SnakeWave1, .DelayWave4, 0

.Level02	!word	.Level02Wave, .ArrowWave2, .SquidWave1, .BonusWaveMissile1, .SAMissileWave1, .WallWaveDownSlopeTop, .AsteroidWave1, .WallSlideWaveMid1a, .WallSlideWaveMid1b, .BonusWaveLaser1, .WhirlingWave1F, .BombDropWave1, .DelayWave2, .GrowBlockWave1a, 0

.Level03	!word	.Level03Wave, .ArrowWave3, .HomingWave1, .BonusWaveWeapon2, .CirclerWave1, .SoundInterludeWave, .WallSlideWaveDoor1a, .BonusWaveLaser2, .WallWaveSlopeGateDown1, .AsteroidWave2, .BreakerWave2, .BonusWaveLive1, .SwarmWave1, .DelayWave2, .GrowBlockWave1a, .GrowBlockWave1b, .GrowBlockWave1c, .DelayWave2, 0

.Level04	!word	.Level04Wave, .BonusWaveTurbo2, .CrossWipeWave1, .BonusWaveShield1, .MinefieldWave1, .SquidWave2, .WallTunnelWave1a, .BonusWaveTurbo1, .AssassinWave1, .EnergyWallWave1, .DelayWave2, .BossWave1a, .DelayWave2, 0

.Level05	!word	.Level05Wave, .BonusWaveWeapon1, .ArrowWave1, .SoundInterludeWave, .WallWaveLargeTop, .WallWaveLargeBottom, .WallWaveElectroTop, .SentinelWave1, .BonusWaveLaser2, .WallWaveElectroTop
		!word	.SnakeWave2, .AsteroidWave3, .SpikeWave1, .DelayWave, .BossWave3a, .DelayWave2, 0

.Level06	!word	.Level06Wave, .DiamondWave1, .SoundInterludeWave, .WallWaveMid1, .WallWaveMid3, .WallWaveMid2, .WallWaveMid4, .BonusWaveFlame1, .DelayWave2, .CrossWipeWave2, .EnergyWallWave1, .DestroyerWave1
		!word	.WallSlideWaveMid2a, .WallSlideWaveMid2b, .WallSlideWaveDoor2a, .DelayWave, .CirclerWave2, .AsteroidWave4, .BreakerWave3, .BonusWaveFlame2, .DelayWave2, 0

.Level07	!word	.Level07Wave, .StarMineWave1, .BonusWaveWeapon1, .SAMissileWave2, .MinefieldWave2, .CirclerWave3, .BonusWaveTurbo1, .BombDropWave2, .HomingWave2
		!word	.WallSlideWaveMid3a, .WallSlideWaveMid3b, .WallSlideWaveDoor3a, .DelayWave2, .BonusWaveLive2, .BombDropWave2, .DelayWave, .WallWaveLargeTopButton, .DelayWave, 0

.Level08	!word	.Level08Wave, .ArrowWave2, .SentinelWave2, .BonusWaveShield2, .WhirlingWave0F, .WhirlingWave2F, .WhirlingWave1B, .DelayWave, .BlubberWave1, .BombDropWave3
		!word	.WallWaveBranchTop, .BonusWaveFlame2, .StarMineWave1, .AsteroidWave4, .AssassinWave2, .DelayWave, .GrowBlockWave2a, .GrowBlockWave2c, .DelayWave2, .BossWave1b, .DelayWave2, 0

.Level09	!word	.Level09Wave, .DiamondWave2, .SoundInterludeWave, .WallWaveSlopeGateDown1, .BonusWaveLaser2, .WallWaveSlopeGateUp1, .DestroyerWave2, .BonusWaveWeapon1, .DelayWave, .WallShiftWave1a, .DelayWave2
		!word	.BoomerangWave1, .DelayWave2, .WallShootWaveGate, .MinefieldWave3, .BombDropWave4, .BonusWaveDrone1, .HomingWave3, .DelayWave2, .BossWave3b, .DelayWave2, 0

.Level10	!word	.Level10Wave, .SquidWave3, .SoundInterludeWave, .WallWaveLargeBottom, .WallShootWaveTop, .WallWaveLargeGate, .WallWaveLargeTop, .WallShootWaveBottom, .DelayWave6, .SwarmWave2, .BonusWaveMissile2, .SAMissileWave3
		!word	.SnakeWave3, .DelayWave6, .SpikeWave2, .DelayWave2, .WallWaveBranchBottom, .AsteroidWave5, .BonusWaveLive2, .DelayWave2, .GrowBlockWave2a, .GrowBlockWave2b, .GrowBlockWave2c, .DelayWave2, 0

.Level11	!word	.Level11Wave, .HomingWave4, .WhirlingWave2B, .WhirlingWave0F, .WhirlingWave1F, .BonusWaveShield2, .WhirlingWave2F, .DelayWave3, .WallShiftWave2a, .DelayWave3, .WhirlingWave0B, .DelayWave6
		!word	.WallSlideWaveMid4a, .WallSlideWaveMid4b, .WallSlideWaveDoor4a, .DelayWave6, .CrossWipeWave3, .MinefieldWave4, .BonusWaveDrone1, .StarMineWave2, .DelayWave2, 0

.Level12	!word	.Level12Wave, .ArrowWave3, .SpikeWave3, .BonusWaveWeapon1, .DelayWave2, .WallWaveBranchBottom, .SentinelWave3, .DelayWave ,.BoomerangWave2, .DelayWave2, .BlubberWave2, .BonusWaveShield2
		!word	.SoundInterludeWave, .WallTunnelWave1a, .WallTunnelWave2a, .DelayWave2, .BreakerWave3, .AsteroidWave5, .BombMissileWave1, .WallShiftWave3b, .DelayWave, .BossWave2a, .DelayWave2, 0

.Level13	!word	.Level13Wave, .DestroyerWave3, .BonusWaveLaser1, .SquidWave4, .WallWaveBranchTop, .BonusWaveLaser2, .StarMineWave3, .SoundInterludeWave, .WallWaveUpSlopeTop, .BonusWaveFlame1
		!word	.WallWaveUpSlopeBottom, .DelayWave4, .AsteroidWave6, .BonusWaveDrone2, .DelayWave2, .GrowBlockWave3a, .GrowBlockWave3b, .AssassinWave3, .DelayWave4, .WallShiftWave4a, .WallShiftWave4a, .WallShiftWave4a, .DelayWave6, .BossWave1c, .DelayWave2, 0

.Level14	!word	.Level14Wave, .BonusWaveTurbo2, .StarMineWave3, .BonusWaveWeapon1, .EnergyWallWave1, .DestroyerWave4, .WallWaveMid4, .WallWaveLargeBottomButton, .SAMissileWave4, .BonusWaveFlame1
		!word	.SoundInterludeWave, .WallTunnelWave1b, .WallTunnelWave2b, .DelayWave2, .SpikeWave4, .BonusWaveShield2, .DelayWave2, .BombMissileWave2, .SentinelWave4, .BonusWaveWeapon1, .MinefieldWave5, .BonusWaveLive2, .DelayWave, .BossWave2b, .DelayWave2, 0
		
.Level15	!word	.Level15Wave, .DiamondWave3, .SentinelWave5, .BonusWaveLaser1, .ArrowWave2, .BonusWaveWeapon2, .WallWaveMid2, .WallWaveElectroTop, .BonusWaveLaser1, .DiamondWave2, .BonusWaveWeapon2, .BoomerangWave3
		!word	.WallWaveMid3, .WallWaveElectroBottom, .BonusWaveLaser1, .ArrowWave3, .BonusWaveWeapon2, .WallShiftWave5a, .WallShiftWave5a, .WallShiftWave5a, .DelayWave2, .MinefieldWave6, .WallWaveBranchTop, .DelayWave2, .BossWave2c, .DelayWave2, 0

.Level16	!word	.Level16Wave, .BonusWaveShield1, .AsteroidWave1, .BonusWaveDrone2, .WallWaveMid1, .WallWaveLargeTopButton, .DelayWave4, .SwarmWave3, .SentinelWave6, .DelayWave2, .BreakerWave3, .AsteroidWave7, .DelayWave2, .CrossWipeWave4
		!word	.BlubberWave3, .AssassinWave4, .BoomerangWave4, .DelayWave2, .WallShiftWave6a, .WallShiftWave6a, .WallShiftWave6a, .BombMissileWave3, .BonusWaveLive1, .DelayWave2, .BossWave3c, .DelayWave2, 0

.Level17	!word	.Level17Wave, .ArrowWave4, .DelayWave2, .WallShiftWave2b, .DelayWave2, .BonusWaveWeapon1, .DiamondWave4, .DelayWave2, .WallShiftWave4b, .DelayWave2, .WhirlingMissileWave0, .WhirlingBombWave1, .WhirlingMissileWave2, .WhirlingBombWave0, .WhirlingMissileWave1, .WhirlingBombWave2, .DelayWave4
		!word	.CirclerWave4, .DelayWave4, .BlubberWave4, .WallWaveElectroTop2, .WallWaveElectroBottom2, .DelayWave16, .GrowBlockWave3a, .GrowBlockWave3b, .GrowBlockWave3c, .DelayWave4, .BonusWaveShield2
		!word	.BossWave1d, .DelayWave2, 0

.Level18	!word	.Level18Wave, .ArrowWave5, .DelayWave2, .WallWaveDownSlopeBottom, .DiamondWave5, .DelayWave2, .BonusWaveLaser1, .SquidWave5, .DelayWave2
		!word	.WallWaveLargeTop, .BonusWaveDrone2, .SentinelShortWave1, .WallWaveLargeBottom, .SentinelShortWave2, .WallWaveLargeTop, .SentinelShortWave1, .WallWaveLargeBottom, .SentinelShortWave2, .DelayWave8, .BlubberWave5, .BonusWaveFlame1
		!word	.BossWave2d, .DelayWave2, 0

.Level19	!word	.Level19Wave, .ArrowWave6, .DelayWave2, .SquidWave6, .DelayWave2, .BonusWaveMissile1, .WallWaveElectroTop, .AsteroidWaveSeg, .WallWaveElectroBottom, .AsteroidWaveSeg, .WallWaveElectroTop, .AsteroidWaveSeg, .WallWaveElectroBottom, .AsteroidWaveSeg, .DelayWave2
		!word	.CirclerWave5, .DelayWave4, .BonusWaveWeapon2, .EnergyWallWave2, .EnergyWallWave2, .DelayWave4, .BonusWaveLive2, .EnergyWallWave2, .EnergyWallWave2, .DelayWave8, .GrowBlockWave4a, .GrowBlockWave4b, .DelayWave2, .BonusWaveShield1
		!word	.BossWave3d, .DelayWave2, 0

.Level20	!word	.Level20Wave, .DiamondWave6, .DelayWave2, .WallWaveSlopeGateDown2, .DelayWave8, .SquidWave7, .BonusWaveLaser2, .DelayWave2, .WallShiftWave5b, .DelayWave2, .WallWaveSlopeGateUp2, .DelayWave2
		!word	.CirclerWave6, .DelayWave4, .BlubberWave6, .WallShiftWave6b, .DelayWave4, .SnakeWave4, .BonusWaveFlame2, .DelayWave16, .WallWaveElectroTop2, .WallWaveElectroBottom2, .WallWaveElectroTop2, .WallWaveElectroBottom2, .DelayWave16
		!word	.BossWave4a, .DelayWave2, .CompletedWave, 0
		
.LevelDelay	!word	.DelayWave2, 0

.LevelTest
		!word	.BonusWaveDrone2, .DelayWave8, .SAMissileWave2, .DelayWave8, .CompletedWave, 0
		
		
.Levels		;!word	.Level19, .Level18, .Level20, .Level17
		;!word	.LevelTest
		!word	.Level01, .Level02, .Level03, .Level04, .Level05, .Level06, .Level07, .Level08, .Level09, .Level10, .Level11, .Level12, .Level13, .Level14, .Level15, .Level16, .Level17, .Level18, .Level19, .Level20

;
; level = Levels
; loop0: for(;;)
;		wave = *level++
; loop1:	while (*.wave)
;			cmd = *wave++
; loop2:		while ( cmd != CDone )
;				
;				count = enemy.count;
;				ycur = enemy.ypos;
; loop3:			do 
;					AddEnemy(enemy.type, enemy.param, enemy.yur)
;					ycur += enemy.step
;					Sleep(enemy.delay);
;				while (--count)
;				Sleep(enemy.final);
;				if (enemy.wait)	
;				 	while (enemies > 0) Sleep(10);
;				enemy++;
;				
;			

.wait	!byte	0
.final	!byte	0

.etype	!byte	0
.eparam	!byte	0
.eypos	!byte	0

.lyskip	!byte	0
.ldelay	!byte	0
.lcount	!byte	0


.CommandLevel
		jsr	Status.SetLevel
		jsr	Game.Check2PlayerRespawn
		rts
	
.CommandMessage
		jsr	Starfield.QueueText
		rts

.CommandSleep
		dec	.enemyi
.Sleep
		cmp	#0
		beq	+
		
		sta	.wait
		pla
		sta	.sleep + 0
		pla
		sta	.sleep + 1
+
		rts
		
.CommandWait	
		lda	Enemies.head
		bmi	+

		lda	#1
		sta	.final
		sta	.wait
		
		pla
		sta	.sleep + 0
		pla
		sta	.sleep + 1
+		
		rts
		
.CommandSound
		jsr	Sound.PlaySound
		rts
		
.CommandCompleted
		lda	#$ff
		sta	.completed
		rts
		
.CommandTabL	!byte	<.CommandSleep, <.CommandLevel, <.CommandMessage, <.CommandWait, <.CommandSound, <.CommandCompleted
.CommandTabH	!byte	>.CommandSleep, >.CommandLevel, >.CommandMessage, >.CommandWait, >.CommandSound, >.CommandCompleted

.DoCommand	
		pha
		txa
		and	#$40
		beq	+

		; Loop command is special
		txa
		and	#$3f
		sta	.lcount
		sty	.lyskip
		pla	
		sta	.ldelay
		rts
+		
		lda	.CommandTabL - $80, x
		sta	.wejmpl + 1
		lda	.CommandTabH - $80, x
		sta	.wejmpl + 2
		pla
.wejmpl		jmp	.CommandSleep
		

.startlevel	!byte	0
.completed	!byte	0
	
; index into list of levels

.leveli	!byte	0

; pointer to current wave

.wave	!word	0
.wavei	!byte	0

; pointer to current enemy

.enemy	!word	0
.enemyi	!byte	0

.sleep	!word	0


.Advance
	lda	.final
	beq	+
	lda	Enemies.head
	bpl	++
	lda	#0
	sta	.final
+
	dec	.wait
	bne	++
	lda	.sleep + 1
	pha
	lda	.sleep + 0
	pha
++
	rts
	
.Init
	lda	#0
	sta	.startlevel
	sta	.completed
	rts
	
.Start
	lda	.startlevel
	asl
	sta	.leveli
	lda	#0
	sta	.final
	lda	#20
	jsr	.Sleep
	
.loop0	
	lda	#<Sound.LevelSound
	ldy	#>Sound.LevelSound
	jsr	Sound.PlaySound

	ldx	.leveli
	lda	.Levels, x
	sta	.wave + 0
	inx
	lda	.Levels, x
	sta	.wave + 1
	inx
	stx	.leveli
	
	lda	#0
	sta	.wavei
	sta	.lcount
.loop1
	lda	.wave + 0
	sta	tmpl
	lda	.wave + 1
	sta	tmph
		
	ldy	.wavei
	lda	(tmpl), y
	sta	.enemy + 0
	iny
	lda	(tmpl), y
	bne	+
	
	jsr	RespawnPoint.Save	
	jmp	.loop0
+
	sta	.enemy + 1
	iny
	sty	.wavei
	lda	#0
	sta	.enemyi

.loop2
	
	lda	.enemy + 0
	sta	tmpl
	lda	.enemy + 1
	sta	tmph
	
	ldy	.enemyi
	lda	(tmpl), y
	beq	.loop1	
	sta	.etype

	iny
	lda	(tmpl), y
	sta	.eparam
	
	iny
	lda	(tmpl), y
	sta	.eypos
	
	iny
	sty	.enemyi
	
.loop3

	lda	.eparam
	ldy	.eypos
	ldx	.etype
	bmi	.command
	
	jsr	Enemies.Add
	
	lda	.lcount
	beq	.loop2
	
	clc
	lda	.eypos
	adc	.lyskip
	sta	.eypos
	
	lda	.ldelay
	jsr	.Sleep
	
	dec	.lcount
	bne	.loop3
	jmp	.loop2

.command
	jsr	.DoCommand
	jmp	.loop2

	
	
	
	
	
	
	
	

	
	