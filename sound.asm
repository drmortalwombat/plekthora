	!zone	Sound

.cmdl		=	$c0
.cmdh		=	$c1
.tmpx		=	$c2

.zbase		=	$c3
.base		=	$ee00

.pri		=	.zbase + 0
.ptrl		=	.zbase + 1
.ptrh		=	.zbase + 2
.delay		=	.zbase + 3
.freql		=	.zbase + 4
.freqh		=	.zbase + 5
.wave		=	.zbase + 6

.dfreql		=	.base + 0
.dfreqh		=	.base + 1
.loopc		=	.base + 2
.loopl		=	.base + 3
.looph		=	.base + 4
.stackl		=	.base + 5
.stackh		=	.base + 6



.effect	!byte	0

.SOFShot	=	$01
.SOFLaser	=	$02
.SOFFlame	=	$04
.SOFEnemyShot	=	$08
.SOFHit		=	$10
.SOFExplosion	=	$20
.SOFDing	=	$40
.SOFStar	=	$80

.ShotSound	!byte	30, .CFreq, 0, 30, .CWave, $09, $00, $21, .CSweep, $00, $ff, 20, .CDone
.HitSound	!byte	20, .CFreq, 0, 20, .CWave, $09, $00, $81, .CSweep, $00, $ff, 10, .CDone
.ExplosionSound	!byte	10, .CFreq, 0,  5, .CWave, $0e, $00, $81, .CSweep, $e0, $ff, 30, .CDone
.DingSound	!byte	40, .CFreq, 0, 50, .CWave, $06, $00, $11, .CWait, 12, .CDone

.LaserSound	!byte	40
		!byte	.CFreq, 0, 40, .CWave, $1c, $00, $21
		!byte	.CSweep, $00, $ff, 8, .CSweep, $00, $01, 8
		!byte	.CSweep, $00, $ff, 8, .CSweep, $00, $01, 8
		!byte	.CSweep, $00, $ff, 20
		!byte	.CDone

.FlameSound	!byte	30, .CFreq, 0, 50, .CWave, $2a, $00, $81, .CSweep, $00, $ff, 30, .CDone
.EnemyShotSound	!byte	45, .CFreq, 0, 07, .CRWave, 2, $0a, $00, $41, .CSweep, $80, $ff,  6, .CDone

.AsteroidSound	!byte	35
		!byte	.CFreq, 0,  4, .CWave, $10, $ec, $81 
		!byte	.CDo, 2, .CSweep, $c0, $ff, 2, .CSweep, $30, $00, 4, .CLoop 
		!byte	.CStop
		!byte	.CDo, 6, .CSweep, $c0, $ff, 6, .CSweep, $30, $00, 4, .CLoop
		!byte	.CDone

.PlayerExplosionSound1
		!byte	10
		!byte	.CDo, 3
		!byte	.CFreq, 0,  4, .CWave, $1a, $00, $81, .CSweep, $f0, $ff, 20
		!byte	.CLoop
		!byte	.CDone
.PlayerExplosionSound2
		!byte	10
		!byte	.CFreq, 0,  2, .CWave, $0e, $00, $81, .CSweep, $fe, $ff, 80
		!byte	.CDone
		
.StarSound	!byte	45, .CFreq, 0, $50, .CRWave, 2, $11, $8a, $41, .CWait, 4, .CStop, .CSweep, $f8, $ff, 32, .CDone

.BonusSound	!byte	22
		!byte	.CFreq, $4b, $22, .CRWave, 4, $18, $40, $41, .CSweep, $10, $00, 2, .CStop, .CSweep, $10, $00, 1
		!byte	.CFreq, $34, $2b, .CRWave, 4, $18, $40, $41, .CSweep, $10, $00, 4, .CStop, .CSweep, $10, $00, 1
		!byte	.CFreq, $61, $33, .CRWave, 4, $18, $40, $41, .CSweep, $10, $00, 2, .CStop, .CSweep, $10, $00, 1
		!byte	.CFreq, $61, $33, .CRWave, 4, $1a, $00, $41, .CSweep, $02, $00, 20, .CDone
				
.LevelSound	
		!byte	22
		!byte	.CFreq, $00, $04, .CRWave, 4, $3c, $40, $41, .CSweep, $80, $00, 40, .CStop
		!byte	.CFreq, $00, $03, .CRWave, 4, $3c, $40, $41, .CSweep, $80, $00, 40, .CStop
		!byte	.CFreq, $00, $02, .CRWave, 4, $3c, $40, $41, .CSweep, $80, $00, 40, .CStop
		!byte	.CDone

.ContinueSound
		!byte	10, .CFreq, 0, $80, .CWave, $10, $c8, $21, .CWait, 8, .CStop, .CSweep, $f0, $ff, 32, .CDone
		!byte	10, .CFreq, 0, $70, .CWave, $10, $c8, $21, .CWait, 8, .CStop, .CSweep, $f0, $ff, 32, .CDone
		!byte	10, .CFreq, 0, $60, .CWave, $10, $c8, $21, .CWait, 8, .CStop, .CSweep, $f0, $ff, 32, .CDone
		!byte	10, .CFreq, 0, $50, .CWave, $10, $c8, $21, .CWait, 8, .CStop, .CSweep, $f0, $ff, 32, .CDone
		!byte	10, .CFreq, 0, $40, .CWave, $10, $c8, $21, .CWait, 8, .CStop, .CSweep, $f0, $ff, 32, .CDone
		!byte	10, .CFreq, 0, $30, .CWave, $10, $c8, $21, .CWait, 8, .CStop, .CSweep, $f0, $ff, 32, .CDone
		!byte	10, .CFreq, 0, $20, .CWave, $10, $c8, $21, .CWait, 8, .CStop, .CSweep, $f0, $ff, 32, .CDone
		
	
.GameOverSound
		!byte	10
		!byte	.CFreq, 0,  50, .CRWave, 2, $10, $ec, $41 
		!byte	.CSweep, $00, $ff, 20
		!byte	.CDo, 2, .CSweep, $00, $ff, 7, .CSweep, $00, $6, 1, .CLoop 
		!byte	.CStop
		!byte	.CDo, 8, .CSweep, $00, $ff, 7, .CSweep, $00, $6, 1, .CLoop
		!byte	.CDone
		
		
		!macro prnode1 freq, dur, pause
			!byte	Sound.CFreq, <freq, >freq, Sound.CRWave, 3, $10, $c5, $41, Sound.CWait, dur, Sound.CStop, Sound.CWait, pause
			
;			!byte	22, <freq, >freq, 3, $66, $5c, $41, 1, dur, $80, $00
;			!byte	22, <freq, >freq, 3, $66, $5c, $40, 1, pause, $80, $00
		!end

		!macro prnode4 freq1, freq2, dur, pause
			!byte	Sound.CFreq, <freq1, >freq1, Sound.CRWave, 1, $00, $45, $41, Sound.CAlter, <freq2, >freq2, dur, Sound.CStop, Sound.CWait, pause
		!end

		!macro prnode2 freq, dur, pause
			!byte	Sound.CFreq, <freq, >freq, Sound.CRWave, 1, $00, $fa, $41, Sound.CWait, dur, Sound.CStop, Sound.CWait, pause

;			!byte	22, <freq, >freq, 1, $2a, $5c, $41, 1, dur, $80, $00
;			!byte	22, <freq, >freq, 1, $2a, $5c, $40, 1, pause, $80, $00
		!end

		!macro prnode3 freq1, freq2, dur, pause
			!byte	Sound.CFreq, <freq1, >freq1, Sound.CWave, $4e, $00, $21, dur, Sound.CStop, Sound.CWait, pause
		!end
		
		!macro prnode5 freq1, dur, pause
			!byte	Sound.CFreq, <freq1, >freq1, Sound.CRWave, 1, $40, $8c, $41, Sound.CAlter, <(3 * freq1 / 2), >(3 * freq1 / 2), dur, Sound.CStop, Sound.CAlter, <(freq1 / 2), >(freq1 / 2), pause
		!end
		
		!macro prnode6 freq1, pause
			!byte	Sound.CFreq, <freq1,  >freq1, Sound.CRWave, $08, $00, $f9, $81, Sound.CWait, 2, Sound.CFreq, 0,  11, Sound.CForm, $41, Sound.CWait, 1, Sound.CForm, $11, Sound.CWait, 1, Sound.CStop, Sound.CWait, pause - 4
		!end
		

.nC2 = $0449
.nD2 = $04d0
.nE2 = $0567
.nF2 = $05b9
.nG2 = $066c
.nA2 = $0735
.nH2 = $0817
		
.nC3 = $0893
.nD3 = $099f
.nE3 = $0acd
.nF3 = $0b72
.nG3 = $0c08
.nA3b = $0d9c
.nA3 = $0e6b
.nB3 = $0f46
.nH3 = $102f
.nC4 = $1125
.nD4b = $122a
.nD4 = $133f
.nE4b = $1464
.nE4 = $159a
.nF4 = $16e3
.nG4 = $1981
.nC5 = $224b
.nE5 = $2b34
	
.InterludeSound1
		!byte	12
		
		!byte	.CDo, 4
		
		+prnode5	.nC2, 4, 28
		+prnode5	.nC2, 4, 28
		+prnode5	.nG2, 4, 12
		+prnode5	.nG2, 4, 12
		+prnode5	.nC2, 4, 28
		+prnode5	.nC2, 8, 56

		+prnode5	.nG2, 4, 28
		+prnode5	.nG2, 4, 28
		+prnode5	.nC3, 4, 12
		+prnode5	.nC3, 4, 12
		+prnode5	.nG2, 4, 28
		+prnode5	.nG2, 8, 56
		
		!byte	.CLoop
		!byte	.CDone
		
		; E4 G16 F8 .16 A16 D8 .16 F16 E8
		; E = 0acd, G = 0c08, F = 0b72, A = 0e6b
.PlayerReadySound1
		!byte	22
		
		
		!byte	.CWait, 64
		+prnode1	.nE3, 4, 4
		+prnode1	.nE3, 4, 4
		+prnode1	.nC4, 4, 4
		+prnode1	.nG3, 36, 4

		+prnode1	.nC4, 4, 4
		+prnode1	.nC4, 4, 4
		+prnode1	.nE4, 4, 4
		+prnode1	.nG4, 36, 4

		+prnode1	.nG4, 4, 4
		+prnode1	.nG4, 4, 4
		+prnode1	.nC3, 4, 4
		+prnode1	.nC5, 36, 4
		!byte	.CWait, 64
	
		!byte	.CDone
		
		+prnode1 .nF3, 8, 8
		+prnode1 .nF3, 6, 6
		+prnode1 .nF3,  2, 2
		+prnode1 .nB3, 8, 8
		+prnode1 .nE4b, 6, 6
		+prnode1 .nD4,  2, 2
		+prnode1 .nF4, 16, 16
		+prnode1 .nG4, 16, 16
		!byte	.CDone
		
.PlayerReadySound2
		!byte	22

		!byte	.CWait, 64
		+prnode4 .nE3, .nE3 + 10, 60, 4
		+prnode4 .nG3, .nG3 + 10, 60, 4
		+prnode4 .nC4, .nC4 + 10, 60, 4
		!byte	.CWait, 64

		!byte	.CDone

		+prnode2 .nF3, 2, 14
		+prnode2 .nF3, 2, 10
		+prnode2 .nF3,  2, 2
		+prnode2 .nB3, 2, 14
		+prnode2 .nE4b, 2, 10
		+prnode2 .nD4,  2, 2

		+prnode2 .nA3, 2, 14
		+prnode2 .nA3, 2, 10
		+prnode2 .nA3,  2, 2
		+prnode2 .nD3, 2, 14
		+prnode2 .nG4, 2, 10
		+prnode2 .nC4,  2, 2
		+prnode2 .nD4, 2, 62
		!byte	.CDone

.PlayerReadySound3
		!byte	22

		!byte	.CDo, 5
		!byte	.CFreq, 0,  7, .CRWave, $08, $00, $f9, $81, .CWait, 1, .CFreq, 0,  11, .CForm, $41, .CWait, 1, .CForm, $11, .CWait, 1, .CStop, .CWait, 5
		!byte	.CFreq, 0,  7, .CRWave, $08, $00, $f9, $81, .CWait, 1, .CFreq, 0,  11, .CForm, $41, .CWait, 1, .CForm, $11, .CWait, 1, .CStop, .CWait, 5
		!byte	.CFreq, 0,  7, .CRWave, $08, $00, $f9, $81, .CWait, 1, .CFreq, 0,  11, .CForm, $41, .CWait, 1, .CForm, $11, .CWait, 1, .CStop, .CWait, 5
		!byte	.CFreq, 0,  5, .CRWave, $08, $00, $f9, $81, .CWait, 1, .CFreq, 0,  11, .CForm, $41, .CWait, 1, .CForm, $11, .CWait, 1, .CStop, .CWait, 13
		!byte	.CFreq, 0,  7, .CRWave, $08, $00, $f9, $81, .CWait, 1, .CFreq, 0,  11, .CForm, $41, .CWait, 1, .CForm, $11, .CWait, 1, .CStop, .CWait, 5
		!byte	.CFreq, 0,  5, .CRWave, $08, $00, $f9, $81, .CWait, 1, .CFreq, 0,  11, .CForm, $41, .CWait, 1, .CForm, $11, .CWait, 1, .CStop, .CWait, 13
		!byte	.CLoop

		!byte	.CDone
		+prnode3 .nD3, .nC3, 63, 1
		+prnode3 .nF3, .nE3, 31, 1
		+prnode3 .nF3, .nE3, 15, 1
		+prnode3 .nF3, .nE3, 15, 1
		+prnode3 .nE3, .nD3, 63, 1
		!byte	.CDone
		
.MissileLaunchSound
		!byte	30, .CFreq, 0, 50, .CWave, $0c, $00, $81, .CSweep, $00, $fe, 20, .CWait, 40, .CDone
		
.BombDropSound
		!byte	30
		!byte	.CFreq, 0, 90, .CWave, $0e, $00, $11, .CSweep, $00, $fa, 10, .CSweep, $00, $fe, 10, .CStop, .CSweep, $80, $ff, 10, .CDone
		
.EnemyBreakerSound
		!byte	35, .CFreq, $00, $20, .CWave, $1e, $00, $21, .CSweep, $c0, $ff, 40, .CDone

.EnemyWhirlingSound
		!byte	35
		!byte	.CFreq, $00, $18, .CWave, $7c, $40, $21, .CSweep, $c0, $ff, 32, .CSweep, $40, $00, 32
		!byte	.CFreq, $00, $17, .CSweep, $c0, $ff, 32, .CSweep, $40, $00, 32
		!byte	.CFreq, $00, $16, .CSweep, $c0, $ff, 32, .CSweep, $40, $00, 32
		!byte	.CFreq, $00, $15, .CSweep, $c0, $ff, 32, .CSweep, $40, $00, 32
		!byte	.CFreq, $00, $14, .CSweep, $c0, $ff, 32, .CSweep, $40, $00, 32
		!byte	.CDone
		
.EnemyArrowSound
		!byte	35
		!byte	.CFreq, $00, $05, .CWave, $9c, $00, $21, .CSweep, $fa, $ff, 50, .CDone

.EnemyGrowBlockSound
		!byte	45
		!byte	.CFreq, 0, 5, .CWave, $05, $8a, $81, .CSweep, $40, $ff, 4
		!byte	.CFreq, 0, 3, .CStop, .CWait, 20
		!byte	.CDone

.WallMoveSound
		!byte	45, .CFreq, 0, 50, .CWave, $2a, $00, $81, .CSweep, $00, $ff, 40, .CDone
		
.WallHitSound
		!byte	35, .CFreq, 0,  2, .CRWave, 2, $0a, $00, $41, .CSweep, $fe, $ff, 40, .CDone
		
.EnemyElectroSound
		!byte	35
		!byte	.CFreq, $00, $40, .CWave, $04, $04, $81, .CSweep, $00, $fc,  4, .CForm, $20, .CWait, 1
		!byte	.CFreq, $00, $50, .CWave, $04, $04, $81, .CSweep, $00, $fc,  6, .CForm, $20, .CWait, 1
		!byte	.CFreq, $00, $40, .CWave, $04, $04, $81, .CSweep, $00, $fc,  4, .CForm, $20, .CWait, 1
		!byte	.CFreq, $00, $50, .CWave, $04, $04, $81, .CSweep, $00, $fc,  6, .CForm, $20, .CWait, 1
		!byte	.CFreq, $00, $30, .CWave, $04, $04, $81, .CSweep, $00, $fc, 10, .CForm, $20, .CWait, 1
		!byte	.CDone
		
;		!byte	35, $00, $05, $04, $04, $04, $40,  1, 1, $00, $ff
;		!byte	35, $00, $50, $04, $04, $04, $81,  6, 1, $00, $fc
;		!byte	35, $00, $04, $04, $04, $04, $40,  1, 1, $00, $ff
;		!byte	35, $00, $40, $04, $04, $04, $81,  4, 1, $00, $fc
;		!byte	35, $00, $06, $04, $04, $04, $40,  1, 1, $00, $ff
;		!byte	35, $00, $50, $04, $04, $04, $81,  6, 1, $00, $fc
;		!byte	35, $00, $03, $04, $04, $04, $40,  1, 1, $00, $ff
;		!byte	35, $00, $30, $04, $04, $04, $81, 10, 1, $00, $fc
;		!byte	35, $00, $08, $04, $04, $04, $40,  1, 1, $00, $ff, $80

.EnemySquidSound
		!byte	35
		!byte	.CFreq, $00, $20, .CWave, $7c, $40, $11
		!byte	.CDo, 8
		!byte	.CSweep, $00, $ff,  8, .CSweep, $00, $01, 9
		!byte	.CLoop
		!byte	.CDone
				
.EnemySnakeSound
		!byte	15
		!byte	.CFreq, $00, $11, .CRWave, $03, $00, $cc, $41, .CWait, 2, .CStop
		!byte	.CDo, 64
		!byte	.CSweep, $00, $01, 4, .CSweep, $00, $ff, 4
		!byte	.CLoop
		!byte	.CDone
		
.EnemyBoss1Sound
		!byte	15
		!byte	.CFreq, $00, $07, .CRWave, $07, $24, $ce, $41, .CSweep, $e0, $ff, 40
		!byte	.CFreq, $00, $02, .CSweep, $f8, $ff, 40, .CStop
		!byte	.CFreq, $00, $02, .CSweep, $20, $00, 10
		!byte	.CFreq, $00, $05, .CSweep, $e0, $ff, 10
		!byte	.CFreq, $00, $02, .CSweep, $20, $00, 10
		!byte	.CFreq, $00, $05, .CSweep, $e0, $ff, 10
		!byte	.CDone

.EnemyBoss1bSound
		!byte	15, .CFreq, $00, $05, .CRWave, $07, $0e, $00, $41, .CSweep, $f0, $ff, 40, .CDone

.PlayerMoveUpSound
		!byte	80, .CFreq, 0, 50, .CWave, $00, $4a, $81, .CWait, 5, .CStop, .CWait, 10, .CDone

.PlayerMoveForwardSound
		!byte	80, .CFreq, 0, 20, .CWave, $00, $6c, $81, .CWait, 10, .CStop, .CWait, 20, .CDone

.MenuButtonSound1
		!byte	.CFreq, 0,  5, .CRWave, $08, $00, $fa, $81, .CWait, 1, .CFreq, 0,  6, .CForm, $41, .CWait, 1, .CForm, $11, .CWait, 1, .CStop, .CDone

.MenuButtonSound2
		!byte	.CFreq, 0,  7, .CRWave, $08, $00, $fa, $81, .CWait, 1, .CFreq, 0,  8, .CForm, $41, .CWait, 1, .CForm, $11, .CWait, 1, .CStop, .CDone
		
!align	255, 0
.CmdSection
.CmdStart
		lda	.wave, x
		ora	#$01
		sta	.wave, x
		sta	$d404, x
		jmp	.CmdNext

.CmdStop	
		lda	.wave, x
		and	#$fe
		sta	.wave, x
		sta	$d404, x
		jmp	.CmdNext
		
.CmdFreq	
		lda	(.cmdl), y
		sta	.freql, x
		sta	$d400, x
		iny

		lda	(.cmdl), y
		sta	.freqh, x
		sta	$d401, x
		iny
		
		jmp	.CmdNext
		
.CmdRWave
		lda	(.cmdl), y
		sta	$d403, x
		iny
		
.CmdWave
		lda	(.cmdl), y
		sta	$d405, x
		iny
		lda	(.cmdl), y
		sta	$d406, x
		iny	
		
.CmdForm	
		lda	(.cmdl), y
		sta	.wave, x
		sta	$d404, x
		iny
		jmp	.CmdNext
		
.CmdSweep
		lda	(.cmdl), y
		sta	.dfreql, x
		iny
		lda	(.cmdl), y
		sta	.dfreqh, x
		iny
		lda	(.cmdl), y
		sta	.delay, x
		iny
		lda	#.SSweep
		jmp	.CmdFinal

.CmdAlter
		lda	(.cmdl), y
		sta	.dfreql, x
		iny
		lda	(.cmdl), y
		sta	.dfreqh, x
		iny
		lda	(.cmdl), y
		sta	.delay, x
		iny
		lda	#.SAlter
		jmp	.CmdFinal
		
.CmdReset
		lda	#$00
		sta	$d405, x
		sta	$d406, x
		sta	$d404, x
		lda	#2
		sta	.delay, x
		lda	#.SWait
		jmp	.CmdFinal
		
.CmdWait
		lda	(.cmdl), y
		iny
		sta	.delay, x
		lda	#.SWait
		jmp	.CmdFinal
		
.CmdDone
		lda	.wave, x
		and	#$fe
		sta	$d404, x
		lda	#$ff
		sta	.pri, x
		lda	#.SIdle
		jmp	.CmdFinal
		
.CmdDo	
		lda	(.cmdl), y
		sta	.loopc, x
		iny
		
		clc
		tya
		adc	.cmdl
		sta	.loopl, x
		lda	.cmdh
		adc	#0
		sta	.looph, x
		jmp	.CmdNext

.CmdLoop
		dec	.loopc, x
		beq	+
		
		lda	.loopl, x
		sta	.cmdl
		lda	.looph, x
		sta	.cmdh
		ldy	#0
+
		jmp	.CmdNext
		
.CmdCall
		jmp	.CmdXCall
		
.CmdReturn
		lda	.stackl, x
		sta	.cmdl
		lda	.stackh, x
		sta	.cmdh
		
		jmp	.CmdNext0
		
.CmdXCall		
		clc
		tya
		adc	#2
		adc	.cmdl
		sta	.stackl, x
		lda	.cmdh
		adc	#0
		sta	.stackh, x

		lda	(.cmdl), y
		pha
		iny
		lda	(.cmdh), y
		sta	.cmdh
		pla
		sta	.cmdl
		
		jmp	.CmdNext0	

!align 255, 0
.StateSection
.StateIdle
		rts
.StateStart
		lda	.pri, x
		clc
		adc	#10
		sta	.pri, x
		jmp	.CmdFirst
		

.StateSweep
		clc
		lda	.freql, x
		adc	.dfreql, x
		sta	.freql, x
		sta	$d400, x
		lda	.freqh, x
		adc	.dfreqh, x
		sta	.freqh, x
		sta	$d401, x
		
; intentional fall through
	
.StateWait
		dec	.delay, x
		beq	+
		rts
+		jmp	.CmdFirst

.StateAlter
		lda	.delay, x
		and	#2
		beq	+
		lda	.freql, x
		sta	$d400, x
		lda	.freqh, x
		sta	$d401, x
		jmp	.StateWait
+		lda	.dfreql, x
		sta	$d400, x
		lda	.dfreqh, x
		sta	$d401, x
		jmp	.StateWait
		

			
.CStart		=	<.CmdStart
.CStop		=	<.CmdStop
.CFreq		=	<.CmdFreq
.CRWave		=	<.CmdRWave
.CWave		=	<.CmdWave
.CForm		=	<.CmdForm
.CSweep		=	<.CmdSweep
.CWait		=	<.CmdWait
.CDone		=	<.CmdDone
.CDo		=	<.CmdDo
.CLoop		=	<.CmdLoop
.CCall		=	<.CmdCall
.CReturn	=	<.CmdReturn
.CAlter		=	<.CmdAlter
.CReset		=	<.CmdReset

.SIdle		=	<.StateIdle
.SWait		=	<.StateWait
.SStart		=	<.StateStart
.SSweep		=	<.StateSweep
.SAlter		=	<.StateAlter
		


; Main State Loop

.Loop
;		inc	$d020

		jsr	.CheckQueue
!if 0 {				
		lda	.dostate0 + 1
		ldy	#41
		jsr	Game.PutHex
		
		lda	.ptrl + 0
		ldy	#44
		jsr	Game.PutHex
		
		lda	.delay + 0
		ldy	#47
		jsr	Game.PutHex
		

		lda	.dostate1 + 1
		ldy	#51
		jsr	Game.PutHex

		lda	.ptrl + 7
		ldy	#54
		jsr	Game.PutHex
		
		lda	.delay + 7
		ldy	#57
		jsr	Game.PutHex
		
		
		lda	.dostate2 + 1
		ldy	#61
		jsr	Game.PutHex

		lda	.ptrl + 14
		ldy	#64
		jsr	Game.PutHex
		
		lda	.delay + 14
		ldy	#67
		jsr	Game.PutHex
}		
		; every state has seven bytes
		
		ldx	#0
.dostate0
		jsr	.StateSection
		nop
		nop

		ldx	#7
.dostate1
		jsr	.StateSection
		nop
		nop

		ldx	#14
.dostate2
		jsr	.StateSection
		nop
		nop
		
;		dec	$d020
		
		rts

.CmdFirst
		lda	.ptrl, x
		sta	.cmdl
		lda	.ptrh, x
		sta	.cmdh
.CmdNext0		
		ldy	#0		
.CmdNext
		lda	(.cmdl), y
		iny
		sta	.cmdjmp + 1
.cmdjmp
		jmp	.CmdStart
		
.CmdFinal
		sta	.dostate0 + 1, x
		
		tya
		clc
		adc	.cmdl
		sta	.ptrl, x
		lda	#0
		adc	.cmdh
		sta	.ptrh, x
		rts
	
.Init
	lda	#$ff
	sta	.pri + 0
	sta	.pri + 7
	sta	.pri + 14
	
	lda	#$00
	sta	$d404 + 0
	sta	$d404 + 7
	sta	$d404 + 14
	sta	.effect
	sta	.wave + 0
	sta	.wave + 7
	sta	.wave + 14
	
	lda	#.SIdle
	sta	.dostate0 + 1
	sta	.dostate0 + 8
	sta	.dostate0 + 15
	
	lda	#0
	sta	$d402
	sta	$d402 + 7
	sta	$d402 + 14
	
	lda	#1
	sta	$d403
	sta	$d403 + 7
	sta	$d403 + 14
	
	lda	#$03
	sta	$d415
	lda	#$ff
	sta	$d416
	lda	#$00
	sta	$d417
	lda	#$0a
	sta	$d418
	rts
		
.QueueEffect
	ora	.effect
	sta	.effect
	rts
	

; sound effect in a/y preserves x
	
.PlaySound
	sta	.cmdl
	sty	.cmdh
	stx	.tmpx
		
	ldx	#0	
	lda	.pri + 0	
	cmp	.pri + 7
	bcs	+
	ldx	#7
	lda	.pri + 7
+
	cmp	.pri + 14
	bcs	+
	ldx	#14
	lda	.pri + 14
+
	
	ldy	#0
	cmp	(.cmdl), y
	
	bcs	.found
	ldx	.tmpx
	rts
	
.found
	lda	#0
	sta	$d405, x
	sta	$d406, x
	sta	$d404, x

	lda	(.cmdl), y
	sta	.pri, x

	clc
	lda	.cmdl
	adc	#1
	sta	.ptrl, x
	lda	.cmdh
	adc	#0
	sta	.ptrh, x
	
	lda	#.SStart
	sta	.dostate0 + 1, x
	
	ldx	.tmpx
	rts		
		
.CheckQueue
	lda	.effect
	beq	++

	and	#.SOFExplosion
	beq	+
	
	lda	#<.ExplosionSound
	ldy	#>.ExplosionSound
	jsr	.PlaySound
+	

	lda	.effect
	and	#.SOFHit
	beq	+
	
	lda	#<.HitSound
	ldy	#>.HitSound
	jsr	.PlaySound
+

	lda	.effect
	and	#.SOFFlame
	beq	+
	
	lda	#<.FlameSound
	ldy	#>.FlameSound
	jsr	.PlaySound
+

	lda	.effect
	and	#.SOFShot
	beq	+
	
	lda	#<.ShotSound
	ldy	#>.ShotSound
	jsr	.PlaySound
+

	lda	.effect
	and	#.SOFEnemyShot
	beq	+
	
	lda	#<.EnemyShotSound
	ldy	#>.EnemyShotSound
	jsr	.PlaySound
+

	lda	.effect
	and	#.SOFLaser
	beq	+
	
	lda	#<.LaserSound
	ldy	#>.LaserSound
	jsr	.PlaySound
+
	
	lda	.effect
	and	#.SOFDing
	beq	+
	
	lda	#<.DingSound
	ldy	#>.DingSound
	jsr	.PlaySound
+
	
	lda	.effect
	and	#.SOFStar
	beq	+
	
	lda	#<.StarSound
	ldy	#>.StarSound
	jsr	.PlaySound
+	
	lda	#0
	sta	.effect
++	rts
