  	* = $0801
	!basic

	jmp	Start
	
; Zero Page Allocation
;
; Global	$02 .. $1f
; Sprites	$20 .. $6f
; Enemies	$70 .. $bf
; Sound		$c0 .. $df
; Player	$e0 .. $ef
;
; $e000 region
;
; Bonus Sprites $e000 .. $e3ff
; Sprites       $e400 .. $e4ff
; Enemies       $e500 .. $e7ff
; Starfield	$e800 .. $e8ff
; Respawn	$e900 .. $eaff
; Menu Screen	$eb00 .. $ebff
; Math		$ec00 .. $edff
; Sound		$ee00 .. $eeff
;
; $f000 region
; 
; Starfield	$f000 .. $ffbff
;

tmp	=	$02
tmpx	=	$03
tmpy	=	$04
tmpl	=	$05
tmph	=	$06

tmpml	=	$07
tmpmh	=	$08
tmpmc	=	$09
tmps	=	$0a
tmpt	=	$0b
tmpu	=	$0c
tmpv	=	$0d


Phase	!byte	0


BitMask	!byte	0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80
NotMask	!byte	0xfe, 0xfd, 0xfb, 0xf7, 0xef, 0xdf, 0xbf, 0x7f

	

Screen		=	$4800
Color		=	$d800
	
CharLinesL	!for ci=0 to 24
			!byte	<(Screen + ci * 40)
		!end
		
CharLinesH	!for ci=0 to 24
			!byte	>(Screen + ci * 40)
		!end
	
TextFontIndex
	!byte	$bf, $71, $72, $73, $74, $75, $76, $77, $78, $79, $7a, $7b, $7c, $7d, $7e, $7f
	!byte	$8c, $8d, $8e, $8f, $98, $99, $9a, $9b, $9c, $9d, $9e, $9f, $9f, $9f, $9f, $9f
	!byte	$bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $bf, $87, $97, $6b, $6f
	!byte	$60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6a, $bf, $6d, $bf, $6c, $bf
	
	
Start	!zone	Start

; Disable interrupts
	
	sei

	lda	#$7f
	sta	$dc0d
	sta	$dd0d
	
; Disable ROM

	lda	#$35
	sta	$01

; Copy Bonus sprite images
	ldy	#0
-
	lda	$4800, y
	sta	$e000, y
	lda	$4900, y
	sta	$e100, y
	lda	$4a00, y
	sta	$e200, y
	lda	$4b00, y
	sta	$e300,y
	iny
	bne	-

; Init Sprites	
	
	jsr	Math.Init
	jsr	Sprites.Init
	jsr	Game.Init
    
	lda 	#$ff
	sta	$d015
	sta	$d01c
	
	lda	#1
	sta	$d025
	lda	#11
	sta	$d026
	
	lda	#$00
	sta	$d012
	lda	#$9b
	sta	$d011
	
	lda	#$01
	sta	$d01a

	lda	$dd00
	and	#$fc
	ora	#$02
	sta	$dd00
	
	lda	#$20
	sta	$d018
	
	lda	#$00
	sta	$d020
	sta	$d021

	lda	#$ff
	sta	$d019

	cli

	lda	#$80
	jsr	Starfield.BuildStarLines
	
	jsr	Game.Intro

.loop0
	jsr	RespawnPoint.Init
	jsr	EnemyWave.Init

	jsr	Game.Reset
		
	ldx	#Game.MTitle
	jsr	Game.Menu
	
	lda	Game.moptions + 0
	sec
	sbc	#1
	sta	EnemyWave.startlevel
	
	lda	Game.moptions + 1
	and	#2
	beq	+
	lda	#$80
+	sta	Game.twoplayer

	lda	Game.moptions + 2
	sta	Status.lives
	jsr	Status.DrawLives	
	
	ldx	Game.moptions + 2
	lda	Status.starfactors - 1, x
	sta	Status.starfactor	

	ldx	#Game.MReadyPlayer
	jsr	Game.Menu
	
.loop1
	lda	#0
	jsr	Starfield.BuildStarLines

	jsr	Game.Loop


	lda	#$80
	jsr	Starfield.BuildStarLines

	bit	EnemyWave.completed
	bpl	+

	ldx	#Game.MCompleted
	jsr	Game.Menu
	
	jmp	.loop0

+	
	ldx	#Game.MGameOver
	jsr	Game.Menu
	
	lda	RespawnPoint.current
	beq	.loop0

	ldx	#Game.MContinue
	jsr	Game.Menu

	lda	Game.mresult
	beq	.loop0
	
	jsr	Game.Reset
	jsr	RespawnPoint.Restore

	ldx	#Game.MReadyPlayer
	jsr	Game.Menu
	
	jmp	.loop1
		
!source "starfield.asm"
!source "sprites.asm"
!source "enemies.asm"
!source "weapons.asm"
!source "status.asm"

	* = $8000
	
!source "math.asm"
!source	"random.asm"
!source "input.asm"
!source "bigfont.asm"
!source "game.asm"
!source "player.asm"
!source "sound.asm"
!source "enemywave.asm"


        * = $4000

!zone	Media	
CharsetData
	!media	"starfield.charsetproject", char
	
	* = $4800
	
SpriteLevelData
   	!media  "levelsprites.spriteproject", sprite, 0, 32
	
	* = $5000
  
SpriteData
   	!media  "numsprites.spriteproject", sprite, 0, 192

	