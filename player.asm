
	!zone Player	
		
.PSExplode	=	$80
.PSPhase	=	$1f
.PSExploded	=	$20
.PSStartup	=	$40

.index		=	$e0

.xposl		!byte	0, 0
.xposh		!byte	0, 0
.yposl		!byte	0, 0
.yposh		!byte	0, 0

.xvel		!byte	0, 0
.yvel		!byte	0, 0
.state		!byte	0, 0
.img0		!byte	0, 0
.img1		!byte	0, 0
.img2		!byte	0, 0

.drone		!byte	0, 0
.shield		!byte	0, 0
.missile	!byte	0, 0

.laser		!byte	0, 0
.weapon		!byte	0, 0
.flame		!byte	0, 0

.xdrone		!byte	0, 0
.ydrone		!byte	0, 0

.xshield	!byte	0, 0
.yshield	!byte	0, 0

.xpshield	!byte	-6,  0,  6,  6,  6,  0, -6, -6
.ypshield	!byte	-5, -5, -5,  0,  6,  6,  6,  0 

.xmissilel	!byte	0, 0
.xmissileh	!byte	0, 0
.ymissilel	!byte	0, 0
.ymissileh	!byte	0, 0
.vxmissile	!byte	0, 0
.vymissile	!byte	0, 0
.axmissile	!byte	0, 0
.aymissile	!byte	0, 0
.tmissile	!byte	0, 0

.spritepressure	!byte	0

.maxy		!byte	192, 192
.maxx		!byte	192, 192
.miny		!byte	64, 64 
.minx		!byte	64, 64

.playercolors	!byte	14, 7
.playerstarty	!byte	80, 60

.Init
	lda	#$40 + 5
	sta	Sprites.img + 0
	sta	Sprites.img + 1
	sta	Sprites.img + 2
	sta	Sprites.img + 3

	lda	#$40 + 159
	sta	Sprites.img + 6
	sta	Sprites.img + 7
	
	lda	#0
	sta	Sprites.color + 6
	sta	Sprites.color + 7
	
	lda	.playercolors + 0
	sta	Sprites.color + 0

	lda	.playercolors + 1
	sta	Sprites.color + 1

	lda	#7
	sta	Sprites.color + 2
	sta	Sprites.color + 3
	
	lda	#0
	sta	.spritepressure
	
	ldx	#0
-
	lda	#128 + 28
	sta	.maxx, x
	sta	.maxy, x
	
	lda	#128 - 28
	sta	.minx, x
	sta	.miny, x
	
	lda	#.PSStartup
	sta	.state, x
	lda	#0
	sta	.xposl, x
	sta	.yposl, x
	sta	.yvel, x
	lda	#10
	sta	.xposh, x
	lda	.playerstarty, x
	sta	.yposh, x
	lda	#$1f
	sta	.xvel, x
	
	lda	#0
	sta	.drone, x
	sta	.shield, x
	sta	.laser, x
	sta	.weapon, x
	sta	.flame, x
	sta	.missile, x
	
	inx
	cpx	#2
	bne	-
	
	rts

.Restart
	ldx	.index
	
	lda	#$40 + 5
	sta	Sprites.img + 0, x
	sta	Sprites.img + 2, x
	
	lda	.playercolors, x
	sta	Sprites.color + 0, x	
	lda	#7
	sta	Sprites.color + 2, x

	lda	#128 + 28
	sta	.maxx, x
	sta	.maxy, x
	
	lda	#128 - 28
	sta	.minx, x
	sta	.miny, x
	
	lda	#.PSStartup
	sta	.state, x
	lda	#0
	sta	.xposl, x
	sta	.yposl, x
	sta	.yvel, x
	lda	#10
	sta	.xposh, x
	lda	.playerstarty, x
	sta	.yposh, x
	lda	#$1f
	sta	.xvel, x
		
	lda	#0
	sta	.drone, x
	sta	.shield, x
	sta	.missile, x
		
	jsr	Status.ResetMultiplier
	
	lda	PlayerWeapon.type, x
	cmp	#PlayerWeapon.WTSlug
	bne	++
	
	lda	.weapon, x
	beq	+
	sec
	sbc	#1
	sta	.weapon, x
+	ora	#PlayerWeapon.WTSlug
	jmp	PlayerWeapon.Select
	
++
	cmp	#PlayerWeapon.WTLaser
	bne	++

	lda	.laser, x
	beq	+
	sec
	sbc	#1
	sta	.laser, x
+	ora	#PlayerWeapon.WTLaser
	jmp	PlayerWeapon.Select
	
++
	cmp	#PlayerWeapon.WTFlame
	bne	++

	lda	.flame, x
	beq	+
	sec
	sbc	#1
	sta	.flame, x
+	ora	#PlayerWeapon.WTFlame
	jmp	PlayerWeapon.Select

++	

	rts

.AddBonus
	pha
	lda	#<Sound.BonusSound
	ldy	#>Sound.BonusSound
	jsr	Sound.PlaySound
	pla
	
	asl
	asl
	sta	.abonus + 1
	
.abonus	bne	* + 2
	jmp	.abweapon
	nop
	jmp	.ablaser
	nop
	jmp	.abdrone
	nop
	jmp	.abshield
	nop
	jmp	.abmissile
	nop
	jmp	.ablife
	nop
	jmp	.abspeed
	nop
	jmp	.abflame
	nop
		
.txtweapon	!text	"WEAPONS UPGRADE LEVEL 0", 0

.abweapon
	ldx	.index
	
	ldy	.weapon, x
	lda	#PlayerWeapon.WTSlug
	cmp	PlayerWeapon.type
	bne	+
	iny
	cpy	#4
	bcs	+
	tya
	sta	.weapon, x
	lda	#PlayerWeapon.WTSlug
+		
	ora	.weapon, x
	jsr	PlayerWeapon.Select

	lda	.weapon, x
	clc
	adc	#49
	sta	.abweapon - 2
	
	lda	#<.txtweapon
	ldy	#>.txtweapon
	
	jmp	Starfield.QueueText


.txtlaser	!text	"LASER BEAM UPGRADE LEVEL 0", 0
	
.ablaser
	ldx	.index
	
	ldy	.laser, x
	lda	#PlayerWeapon.WTLaser
	cmp	PlayerWeapon.type
	bne	+
	iny
	cpy	#4
	bcs	+
	tya
	sta	.laser, x
	lda	#PlayerWeapon.WTLaser	
+		
	ora	.laser, x
	jsr	PlayerWeapon.Select
	
	lda	.laser, x
	clc
	adc	#49
	sta	.ablaser - 2

	lda	#<.txtlaser
	ldy	#>.txtlaser
	
	jmp	Starfield.QueueText


.txtflame	!text	"PLASMA BURST UPGRADE LEVEL 0", 0
	
.abflame
	ldx	.index
	
	ldy	.flame, x
	lda	#PlayerWeapon.WTFlame
	cmp	PlayerWeapon.type
	bne	+
	iny
	cpy	#4
	bcs	+
	tya
	sta	.flame, x
	lda	#PlayerWeapon.WTFlame	
+		
	ora	.flame, x
	jsr	PlayerWeapon.Select

	lda	.flame, x
	clc
	adc	#49
	sta	.abflame - 2

	lda	#<.txtflame
	ldy	#>.txtflame
	
	jmp	Starfield.QueueText

	
.txtdrone	!text	"PROTECTOR DRONE ENGAGED", 0

.abdrone
	ldx	.index

	lda	#0
	sta	.shield, x
	sta	.missile, x
	lda	#1
	sta	.drone, x
	
	lda	#<.txtdrone
	ldy	#>.txtdrone
	
	jmp	Starfield.QueueText

.txtshield	!text	"PHASE SHIELD AT MAXIMUM", 0
	
.abshield
	ldx	.index

	lda	#3
	sta	.shield, x
	lda	#0
	sta	.drone, x
	sta	.missile, x

	lda	#<.txtshield
	ldy	#>.txtshield
	
	jmp	Starfield.QueueText


.txtmissile	!text	"HOMING MISSILES ACTIVE", 0
	
.abmissile
	ldx	.index

	lda	#1
	sta	.missile, x
	lda	#0
	sta	.drone, x
	sta	.shield, x

	lda	#<.txtmissile
	ldy	#>.txtmissile
	
	jmp	Starfield.QueueText

	
.ablife
	jsr	Status.AddLive
	rts

.txtspeedup	!text	"SPEED UP", 0
	
.abspeed
	ldx	.index

	lda	.maxx, x
	cmp	#128 + 96
	bvs	+
	clc
	adc	#4
	sta	.maxx, x
	sta	.maxy, x
	sec
	lda	.minx, x
	sbc	#4
	sta	.minx, x
	sta	.miny, x

	lda	#<.txtspeedup
	ldy	#>.txtspeedup
	
	jmp	Starfield.QueueText
+
	rts
	
.BonusCollision
	ldy	.index
	
	lda	.xposh, y
	clc
	adc	#8
	sta	tmpx
	
	lda	.yposh, y
	clc
	adc	#7
	sta	tmpy
		
	ldx	Enemies.head
	bpl	.bloop
	rts
	
.bloop	
	lda	Enemies.pflags, x
	and	#Enemies.PFBonus
	beq	.bmiss

	lda	tmpx
	sec
	sbc	Enemies.xposh, x
	bcc	.bmiss
	sbc	#4
	bcc	+
	cmp	Enemies.xsize, x
	bcs	.bmiss
+

	lda	tmpy
	sec
	sbc	Enemies.yposh, x
	bcc	.bmiss
	sbc	#4
	bcc	+
	cmp	Enemies.ysize, x
	bcs	.bmiss
+
	
	lda	Enemies.type, x
	pha
	jsr	Enemies.Free
	pla
	
	jsr	.AddBonus
	jmp	.bempty
	
.bmiss
	lda	Enemies.succ,x
	tax
	bmi	.bempty
	jmp	.bloop
.bempty
	
	rts


.Collision
	ldy	.index
	
	lda	.xposh, y
	clc
	adc	#8
	sta	tmpx
	
	adc	#16
	cmp	Enemies.minx
	bcs	+
	jmp	.enone
+
	
	lda	.yposh, y
	clc
	adc	#7
	sta	tmpy
		
	ldx	Enemies.head
	bpl	.eloop
	rts
	
.eloop	
	lda	Enemies.pflags, x
	bpl	.emiss

	lda	tmpx
	sec
	sbc	Enemies.xposh, x
	bcc	.emiss
	sbc	#4
	bcc	+
	cmp	Enemies.xsize, x
	bcs	.emiss
+

	lda	tmpy
	sec
	sbc	Enemies.yposh, x
	bcc	.emiss
	sbc	#4
	bcc	+
	cmp	Enemies.ysize, x
	bcs	.emiss
+
	
	lda	Enemies.pflags, x
	and	#Enemies.PFBonus
	beq	+
	lda	Enemies.type, x
	pha
	jsr	Enemies.Free
	pla
	
	jsr	.AddBonus
	rts
+
	lda	Enemies.sflags, x
	and	#Enemies.SFExplodes + Enemies.SFShot
	beq	++
	and	#Enemies.SFExplodes	
	bne	+
	jsr	Enemies.Free
	jmp	++
+	
	lda	#4
	jsr	Enemies.Explode
	
++
	ldy	.index
	lda	.shield, y
	beq	+
	sec
	sbc	#1
	sta	.shield, y
	rts
+	
	jsr	.Explode
	rts
	
.emiss
	lda	Enemies.succ,x
	tax
	bpl	.eloop

.enone
	ldy	.index
	lda	.drone, y
	beq	.dnone
	
	lda	.ydrone, y
	clc
	adc	#2
	sta	tmpy

	lda	.xdrone, y
	clc
	adc	#2
	sta	tmpx

	adc	#12
	cmp	Enemies.minx
	bcc	.dnone
	
	ldx	Enemies.head
	bpl	.dloop
	rts
.dloop

	lda	Enemies.sflags, x
	bpl	.dmiss
	and	#Enemies.SFExplodes
	beq	.dmiss

	lda	tmpy
	sec
	sbc	Enemies.yposh, x
	cmp	Enemies.ysize, x
	bcs	.dmiss

	lda	tmpx
	sec
	sbc	Enemies.xposh, x
	cmp	Enemies.xsize, x
	bcs	.dmiss

	lda	#2
	jsr	Enemies.Explode
	
.dmiss

	lda	Enemies.succ,x
	tax
	bpl	.dloop
	
.dnone	
	ldy	.index
	
	lda	.missile, y
	bpl	.mnone

	ldx	Enemies.head
	bpl	.mloop
	rts

.mloop
	lda	Enemies.sflags, x
	bpl	.mmiss

	lda	.ymissileh, y
	clc
	adc	#3
	sec
	sbc	Enemies.yposh, x
	cmp	Enemies.ysize, x
	bcs	.mmiss

	lda	.xmissileh, y
	clc
	adc	#3
	sec
	sbc	Enemies.xposh, x
	cmp	Enemies.xsize, x
	bcs	.mmiss

	lda	#1
	sta	.missile, y

	lda	Enemies.sflags, x
	and	#Enemies.SFExplodes
	beq	.mmiss

	lda	#8
	jsr	Enemies.Explode	
	
.mmiss
	lda	Enemies.succ,x
	tax
	bpl	.mloop
.mnone	
	rts

.FireMissile
	ldy	.index
	
	lda	#$80
	sta	.missile, y
	
	lda	.xposl, y
	sta	.xmissilel, y
	lda	.xposh, y
	sta	.xmissileh, y
	
	lda	.yposl, y
	sta	.ymissilel, y
	lda	.yposh, y
	clc
	adc	#6
	sta	.ymissileh, y
	
	lda	#0
	sta	.aymissile, y
	lda	#1
	sta	.axmissile, y
	
	lda	#32
	sta	.vxmissile, y
	lda	#2
	sta	.vymissile, y
	
	lda	#$40 + 8
	sta	.img2, y
	
	ldx	Enemies.head
	bmi	++
-
	lda	Enemies.sflags, x
	and	#Enemies.SFExplodes
	bne	++
	lda	Enemies.succ, x
	tax
	bpl	-
	
++	txa
	sta	.tmissile, y

	rts
	
.ImgMissile	!byte	$48, $4e, $48, $49, $48, $4f, $48, $48, $48, $48, $48, $4b, $4c, $4d, $48, $4a

.MoveMissile
	ldy	.index
	
	ldx	.tmissile, y
	bmi	+++
	lda	Enemies.sflags, x
	and	#Enemies.SFExplodes
	bne	+
	lda	#$ff
	sta	.tmissile, y
	jmp	+++
	
+
	lda	.xmissileh, y
	sta	tmpx
	lda	.ymissileh, y
	sta	tmpy
	
	ldy	#0
	sec
	lda	Enemies.xposh, x
	sbc	tmpx
	bcs	+
	cmp	#$f7
	bcs	++
	dey
	jmp	++	
+	cmp	#8
	bcc	++
	iny
++	sty	tmpx

	ldy	#0
	sec
	lda	Enemies.yposh, x
	sbc	tmpy
	bcs	+
	cmp	#$f7
	bcs	++
	dey
	jmp	++
+	cmp	#8
	bcc	++
	iny
++	sty	tmpy

	ldy	.index
	lda	tmpx
	sta	.axmissile, y
	lda	tmpy
	sta	.aymissile, y
	
+++
	lda	.axmissile, y
	asl
	asl
	clc
	adc	.aymissile, y
	and	#15
	tax
	lda	.ImgMissile, x
	sta	.img2, y
	
	clc
	lda	.axmissile, y
	adc	.vxmissile, y
	bvs	+
	sta	.vxmissile, y
*	lda	.vxmissile, y

	ldx	#0
	asl
	bcc	+
	dex
	dex
+	asl
	bcc	+
	inx
+	clc
	adc	.xmissilel, y
	sta	.xmissilel, y
	txa
	adc	.xmissileh, y
	sta	.xmissileh, y
	
	cmp	#160
	bcc	+
	lda	#1
	sta	.missile, y
+	
	
	clc
	lda	.aymissile, y
	adc	.vymissile, y
	bvs	+
	sta	.vymissile, y
+	lda	.vymissile, y

	ldx	#0
	asl
	bcc	+
	dex
	dex
+	asl
	bcc	+
	inx
+	clc
	adc	.ymissilel, y
	sta	.ymissilel, y
	txa
	adc	.ymissileh, y
	sta	.ymissileh, y

	cmp	#120
	bcc	+
	lda	#1
	sta	.missile, y
+
	rts
	
.ShieldColors	!byte	0, 2, 7, 14
.ShieldOffset	!byte	0, 3
.DroneOffset	!byte	0, 16

.Move
	ldx	.index
	
	lda	.xvel, x
	beq	++
	bmi	+
	sec
	sbc	#1
	bcs	++
+	clc
	adc	#1
++	sta	.xvel, x

	lda	Input.dx, x
	beq	++
	cmp	Input.pdx, x
	beq	+
	lda	#<Sound.PlayerMoveForwardSound
	ldy	#>Sound.PlayerMoveForwardSound
	jsr	Sound.PlaySound
	lda	Input.dx, x
+
	asl
	asl
	asl
	clc
	adc	.xvel, x
	
	eor	#$80	
	cmp	.maxx, x
	bcc	+
	lda	.maxx, x
+	cmp	.minx, x
	bcs	+
	lda	.minx, x
+	eor	#$80
	sta	.xvel, x
++

	lda	.yvel, x 
	beq	++
	bmi	+
	sec
	sbc	#2
	bcs	++
+	clc
	adc	#2
++	sta	.yvel, x

	lda	Input.dy, x
	beq	++
	cmp	Input.pdy, x
	beq	+
	lda	#<Sound.PlayerMoveUpSound
	ldy	#>Sound.PlayerMoveUpSound
	jsr	Sound.PlaySound
	lda	Input.dy, x	
+

	asl
	asl
	asl
	clc
	adc	.yvel, x

	eor	#$80	
	cmp	.maxy, x
	bcc	+
	lda	.maxy, x
+	cmp	.miny, x
	bcs	+
	lda	.miny, x
+	eor	#$80
	sta	.yvel, x
++

	ldy	.xvel, x
	clc
	lda	.xposl, x
	adc	Math.asl3, y
	sta	.xposl, x
	lda	.xposh, x
	adc	Math.asr5, y
	
	cmp	#14
	bcs	+
	lda	#14
+	cmp	#160
	bcc	+
	lda	#159
+	
	sta	.xposh, x
	
	ldy	.yvel, x
	clc
	lda	.yposl, x
	adc	Math.asl3, y
	sta	.yposl, x	
	lda	.yposh, x
	adc	Math.asr5, y

	cmp	#27
	bcs	+
	lda	#27
+	cmp	#98
	bcc	+
	lda	#97
+	

	sta	.yposh, x

	lda	#$42
	ldy	.yvel, x
	beq	++
	bpl	+
	lda	#$41
	cpy	#$d0
	bcs	++
	lda	#$40
	bne	++
+
	lda	#$43
	cpy	#$30
	bcc	++
	lda	#$44
++
	sta	.img0, x
	
	lda	Input.dx, x
	clc
	adc	#$40 + 6
	sta	.img1, x
	
	jsr	PlayerWeapon.Fire
	
	ldx	.index
	
	lda	.drone, x
	beq	+
	
	lda	Phase
	adc	.DroneOffset, x
	and	#63	
	tay
	lda	Math.sin20, y
	clc
	adc	Player.xposh, x
	sta	.xdrone, x
	tya
	clc
	adc	#16
	and	#63
	tay
	lda	Math.sin20, y
	clc
	adc	Player.yposh, x
	sta	.ydrone, x
	
	lda	Phase
	lsr
	lsr
	and	#7
	ora	#$40 + 80
	sta	.img2, x
+
	ldy	.shield, x
	beq	+
	
	lda	.ShieldColors, y
	sta	Sprites.color + 4, x

	lda	Phase
	clc
	adc	.ShieldOffset, x
	and	#7
	tay
	lda	.xpshield, y
	clc
	adc	Player.xposh, x
	sta	.xshield, x
	
	lda	.ypshield, y
	clc
	adc	Player.yposh, x
	sta	.yshield, x
	
+
	lda	.missile, x
	beq	++
	bmi	+
	
	jsr	.FireMissile

+
	jsr	.MoveMissile
	
++
	ldx	.index
	
	lda	Player.xposh, x
	lsr
	lsr
	sbc	#2
	tay
	lda	Player.yposh, x
	lsr
	lsr
	sbc	#5
	tax
	jsr	Starfield.CheckLoot
	
	rts

.Explode
	ldx	.index
	
	lda	#.PSExplode
	sta	.state, x
	
	lda	#$40 + 32
	sta	.img0, x
	sta	.img1, x
	lda	#7
	sta	Sprites.color + 0, x
	sta	Sprites.color + 2, x
	
	lda	#<Sound.PlayerExplosionSound1
	ldy	#>Sound.PlayerExplosionSound1
	jsr	Sound.PlaySound
	lda	#<Sound.PlayerExplosionSound2
	ldy	#>Sound.PlayerExplosionSound2
	jsr	Sound.PlaySound

	rts
	
.Iterate
	ldx	.index
	
	lda	.state, x
	bmi	.itexplode
	and	#.PSStartup
	bne	+
	jsr	.Move
	jsr	.Collision
	rts
+	
	lda	Phase
	and	#1
	beq	+
	inc	.state, x
	bpl	+
	lda	#0
	sta	.state, x
+
	jsr	.Move
	jsr	.BonusCollision
	
	ldx	.index
	lda	.state, x
	and	#1
	bne	+
	lda	#$40 + 5
	sta	.img0, x
+
	rts

.itexplode
	lda	Phase
	and	#3
	beq	+
	rts
+
	lda	.state, x
	and	#.PSExploded
	beq	+
-	lda	Status.lives
	beq	++
	jsr	Status.RemLive
	jmp	.Restart
	
+	
	lda	.state, x	
	and	#.PSPhase
	cmp	#$10
	bcs	+
	ora	#$40 + 32
	!byte	$2c
+	lda	#$40 + 5
	sta	.img0, x
	sta	.img1, x
	inc	.state, x
	lda	.state, x
	and	#.PSExploded
	bne	-
++	
	rts

.CheckSpritePressure
	lda	.state
	ora	.state + 1
	bmi	++
	
	sec
	lda	.yposh + 0
	sbc	.yposh + 1
	bcc	+
	cmp	#13
	bcs	++
	
-	lda	#$ff
	sta	.spritepressure
	rts

+
	cmp	#-13
	bcs	-
	
++
	lda	#0
	sta	.spritepressure
	rts
	
	
.Update
	ldx	.index
	
	lda	.xposl, x
	asl
	lda	.xposh, x
	rol
	
	sta	Sprites.xposl + 0, x
	sta	Sprites.xposl + 6, x
	lda	#0
	rol
	sta	Sprites.xposh + 0, x
	sta	Sprites.xposh + 6, x

	lda	.state, x
	bpl	++
	
	and	#.PSExploded
	beq	+
	lda	#$ff
	sta	Sprites.ypos + 0, x
	sta	Sprites.ypos + 2, x
	sta	Sprites.ypos + 4, x
	sta	Sprites.ypos + 6, x
	rts
+
	lda	#7

	eor	#$ff
	sec
	adc	Sprites.xposl + 0, x
	sta	Sprites.xposl + 2, x
	lda	Sprites.xposh + 0, x
	sbc	#0
	sta	Sprites.xposh + 2, x
	
	lda	.yposl, x
	asl
	lda	.yposh, x
	rol
	
	sta	Sprites.ypos + 0, x
	adc	#4	
	sta	Sprites.ypos + 2, x
	
	lda	.img0, x
	sta	Sprites.img + 0, x
	sta	Sprites.img + 2, x
	
	lda	#$ff
	sta	Sprites.ypos + 4, x
	sta	Sprites.ypos + 6, x
	rts
	

++
	lda	#221
	sta	Sprites.ypos + 6, x

	lda	Phase
	and	#3
	clc
	adc	#25
	eor	#$ff
	sec
	adc	Sprites.xposl + 0, x
	sta	Sprites.xposl + 2, x
	lda	Sprites.xposh + 0, x
	sbc	#0
	sta	Sprites.xposh + 2, x
	
	lda	.yposl, x
	asl
	lda	.yposh, x
	rol
	
	sta	Sprites.ypos + 0, x
	adc	#4

	; Hide exhaust when under sprite pressure
	
	bit	.spritepressure
	bpl	+
	lda	#$ff
+
	sta	Sprites.ypos + 2, x
	
	lda	.img0, x
	sta	Sprites.img + 0, x
	
	lda	.img1, x
	sta	Sprites.img + 2, x
	
	lda	.drone, x
	beq	.nodrone

	; player has drone

	lda	#7
	sta	Sprites.color + 4, x
	
	lda	.img2, x
	sta	Sprites.img + 4, x

	lda	.xdrone, x
	asl
	sta	Sprites.xposl + 4, x
	lda	#0
	rol
	sta	Sprites.xposh + 4, x
	lda	.ydrone, x
	asl
	sta	Sprites.ypos + 4, x
	
	
	rts
	
.nodrone
	lda	.shield, x
	beq	.noshield

	; player has shield
	
	lda	Phase
	clc
	adc	.ShieldOffset, x
	and	#7
	ora	#$40 + 112
	sta	Sprites.img + 4, x

	lda	.xshield, x
	asl
	sta	Sprites.xposl + 4, x
	lda	#0
	rol
	sta	Sprites.xposh + 4, x
	lda	.yshield, x
	asl
	sta	Sprites.ypos + 4, x

	rts
	
.noshield
	lda	.missile, x
	beq	.nomissile

	; player has missile

	lda	#12
	sta	Sprites.color + 4, x
	
	lda	.img2, x
	sta	Sprites.img + 4, x
	
	lda	.xmissilel, x
	asl
	lda	.xmissileh, x
	rol
	
	sta	Sprites.xposl + 4, x
	lda	#0
	rol
	sta	Sprites.xposh + 4, x

	sec
	lda	.ymissilel, x
	asl
	lda	.ymissileh, x
	rol
	sta	Sprites.ypos + 4, x

	rts
	
.nomissile
	lda	#$ff
	sta	Sprites.ypos + 4, x

	rts
