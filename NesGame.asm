.db "NES",$1A,2,2,0,0,0,0,0,0,0,0,0,0 ; cartridge header

.define PPUCTRL $2000
.define PPUADDR $2006
.define PPUDATA $2007
.define PPUMASK $2001
.define PPUSTATUS $2002
.define OAMADDRESS $2003
.define OAMDATA $2004
.define JOYPAD1 $4016


.define UPL 8
.define DOWNL 4
.define UPR 1
.define DOWNR 2

.macro init_sprite y index attributes x y_ram index_ram attributes_ram x_ram
LDA #y
STA y_ram

LDA #index
STA index_ram

LDA #attributes
STA attributes_ram

LDA #x
STA x_ram
.endmacro

.macro update_sprite ram_address

    LDA ram_address
    sta OAMDATA

    LDA ram_address+
    STA OAMDATA

    LDA ram_address++
    STA OAMDATA

    LDA ram_address+++
    STA OAMDATA

.endmacro

.org 0000
buttons: .ram 1

spriteL_y: .ram 1
spriteL_tile: .ram 1
spriteL_attributes: .ram 1
spriteL_x: .ram 1

spriteL1_y: .ram 1
spriteL1_tile: .ram 1
spriteL1_attributes: .ram 1
spriteL1_x: .ram 1

spriteL2_y: .ram 1
spriteL2_tile: .ram 1
spriteL2_attributes: .ram 1
spriteL2_x: .ram 1

spriteL3_y: .ram 1
spriteL3_tile: .ram 1
spriteL3_attributes: .ram 1
spriteL3_x: .ram 1


spriteR_y: .ram 1
spriteR_tile: .ram 1
spriteR_attributes: .ram 1
spriteR_x: .ram 1

spriteR1_y: .ram 1
spriteR1_tile: .ram 1
spriteR1_attributes: .ram 1
spriteR1_x: .ram 1

spriteR2_y: .ram 1
spriteR2_tile: .ram 1
spriteR2_attributes: .ram 1
spriteR2_x: .ram 1

spriteR3_y: .ram 1
spriteR3_tile: .ram 1
spriteR3_attributes: .ram 1
spriteR3_x: .ram 1

ball_y: .ram 1
ball_tile: .ram 1
ball_attributes: .ram 1
ball_x: .ram 1

scoreLeftPlayer_y: .ram 1
scoreLeftPlayer_tile: .ram 1
scoreLeftPlayer_y_attributes: .ram 1
scoreLeftPlayer_y_x: .ram 1

scoreRightPlayer_y: .ram 1
scoreRightPlayer_tile: .ram 1
scoreRightPlayer_y_attributes: .ram 1
scoreRightPlayer_y_x: .ram 1

speed_x: .ram 1 
speed_y: .ram 1

offSetBallX: .ram 1
offSetBallY: .ram 1

scorePlayerR: .ram 1
scorePlayerL: .ram 1



.org $8000 $fff9


main:

LDA #%00000000
STA PPUCTRL ;write 0 to $2000

LDA #0
STA OAMADDRESS

LDA $3f
STA PPUADDR ;carica palette 1-4
LDA $00
STA PPUADDR

LDA #$29
STA PPUDATA
LDA #$29
STA PPUDATA
LDA #$1A
STA PPUDATA
LDA #$0F
STA PPUDATA

LDA #$29
STA PPUDATA
LDA #$36
STA PPUDATA
LDA #$17
STA PPUDATA
LDA #$0F
STA PPUDATA

LDA #$29
STA PPUDATA
LDA #$30
STA PPUDATA
LDA #$21
STA PPUDATA
LDA #$0F
STA PPUDATA

LDA #$29
STA PPUDATA
LDA #$27
STA PPUDATA
LDA #$17
STA PPUDATA
LDA #$0F
STA PPUDATA

LDA #$29
STA PPUDATA
LDA #$16
STA PPUDATA
LDA #$0F
STA PPUDATA
LDA #$0F
STA PPUDATA

LDA #$29
STA PPUDATA
LDA #$36
STA PPUDATA
LDA #$17
STA PPUDATA
LDA #$0F
STA PPUDATA

LDA #$29
STA PPUDATA
LDA #$30
STA PPUDATA
LDA #$21
STA PPUDATA
LDA #$0F
STA PPUDATA

LDA #$29
STA PPUDATA
LDA #$27
STA PPUDATA
LDA #$17
STA PPUDATA
LDA #$0F
STA PPUDATA

LDA #%00010000
STA PPUMASK



LDA #0
STA OAMADDRESS
;left player
init_sprite 100 $11 %00000000 10 spriteL_y spriteL_tile spriteL_attributes spriteL_x
init_sprite 107 $11 %00000000 10 spriteL1_y spriteL1_tile spriteL1_attributes spriteL1_x
init_sprite 114 $11 %00000000 10 spriteL2_y spriteL2_tile spriteL2_attributes spriteL2_x
init_sprite 121 $11 %00000000 10 spriteL3_y spriteL3_tile spriteL3_attributes spriteL3_x
;right player
init_sprite 100 $11 %00000000 240 spriteR_y spriteR_tile spriteR_attributes spriteR_x
init_sprite 107 $11 %00000000 240 spriteR1_y spriteR1_tile spriteR1_attributes spriteR1_x
init_sprite 114 $11 %00000000 240 spriteR2_y spriteR2_tile spriteR2_attributes spriteR2_x
init_sprite 121 $11 %00000000 240 spriteR3_y spriteR3_tile spriteR3_attributes spriteR3_x
;ball
init_sprite 100 $5d %00000000 120 ball_y ball_tile ball_attributes ball_x
;score
init_sprite 15 $30 %00000000 30 scoreLeftPlayer_y scoreLeftPlayer_tile scoreLeftPlayer_y_attributes scoreLeftPlayer_y_x
init_sprite 15 $30 %00000000 200 scoreRightPlayer_y scoreRightPlayer_tile scoreRightPlayer_y_attributes scoreRightPlayer_y_x


;Update sprite player left
update_sprite spriteL_y
update_sprite spriteL1_y
update_sprite spriteL2_y
update_sprite spriteL3_y

;Update sprite player right
update_sprite spriteR_y
update_sprite spriteR1_y
update_sprite spriteR2_y
update_sprite spriteR3_y
;Update sprite ball
update_sprite ball_y
;Update spite Score
update_sprite scoreLeftPlayer_y
update_sprite scoreRightPlayer_y


LDA #3
STA offSetBallX

LDA #3
STA offSetBallY

LDA #-1
STA speed_x

LDA #-1
STA speed_y


                        ;LOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOP
loop:
JSR checkCollisionHorizontal
JSR checkCollisionVertical
JSR returnCollision
JSR moveBall
JSR readjoy
JSR check_button_P1
JSR check_button_P2


wait_for_vblank:

LDA PPUSTATUS
BPL wait_for_vblank

update_sprite spriteL_y
update_sprite spriteL1_y
update_sprite spriteL2_y
update_sprite spriteL3_y


update_sprite spriteR_y
update_sprite spriteR1_y
update_sprite spriteR2_y
update_sprite spriteR3_y  

update_sprite ball_y

update_sprite scoreLeftPlayer_y
update_sprite scoreRightPlayer_y


JMP loop

vblank:

RTI

ignore:
RTI



check_button_P1:
LDA buttons
AND #UPL
BNE moveup_l
LDA buttons
AND #DOWNL
BNE movedown_l
LDA spriteL_y
STA spriteL_y
RTS

check_button_P2:
LDA buttons
AND #UPR
BNE moveup_r
LDA buttons
AND #DOWNR
BNE movedown_r
LDA spriteR_y
STA spriteR_y
RTS

moveup_r:
DEC spriteR_y
DEC spriteR1_y
DEC spriteR2_y
DEC spriteR3_y

RTS

moveup_l:
DEC spriteL_y
DEC spriteL1_y
DEC spriteL2_y
DEC spriteL3_y
RTS

movedown_l:
INC spriteL_y
INC spriteL1_y
INC spriteL2_y
INC spriteL3_y
RTS


movedown_r:
INC spriteR_y
INC spriteR1_y
INC spriteR2_y
INC spriteR3_y
RTS

moveBall:
LDA ball_x
CLC
ADC speed_x
STA ball_x 
LDA ball_y
CLC
ADC speed_y
STA ball_y 
rts

invertBall:
LDA #1
STA speed_x
JMP returnCollision

returnCollision:
RTS

invertBallSpeed:
LDA #-1
sta speed_x
JMP returnCollision

invertBallSpeedY:
LDA #-1
STA speed_y
JMP returnCollision

incrementBallSpeedY:
LDA #1
STA speed_y
JMP returnCollision


checkCollisionVertical:
;check collision with down screen
LDA ball_y
CMP #217
BEQ invertBallSpeedY    
;check collision with up screen
LDA ball_y
CMP #10
BEQ incrementBallSpeedY
RTS


checkCollisionHorizontal:
;check collision with first player
LDA ball_x
CLC
ADC offSetBallX
CMP spriteR1_x
BEQ checkRight
;check collision with  two player
LDA ball_x
SEC
SBC offSetBallX
CMP spriteL_x
BEQ checkLeft
;JMP returnCollision
RTS

checkRight:
LDA ball_y
CMP spriteR_y
BCS CheckGoalRight
JMP goalLeftPlayer
;se non collide segna 
rts

CheckGoalRight:
LDA ball_y
CMP spriteR3_y
BCC invertBallSpeed
JMP goalLeftPlayer
;hai fatto goal
rts

; ----------------------------------
checkLeft:
LDA ball_y
CMP spriteL_y
BCS CheckGoalLeft
JMP goalRightPlayer
rts

CheckGoalLeft:
LDA ball_y
CMP spriteL3_y
BCC invertBall
JMP goalRightPlayer
rts
;hai fatto goal


;GOAL FUNCTION
goalRightPlayer:
INC scoreRightPlayer_tile
JMP respawnBallL

goalLeftPlayer:
INC scoreLeftPlayer_tile
JMP respawnBallR


respawnBallR:
LDA #100
STA ball_y
LDA #120
sta ball_x
LDA #1 
STA speed_x
STA speed_y
JMP checkCollisionHorizontal

respawnBallL:
LDA #100
STA ball_y
LDA #120
sta ball_x
LDA #-1 
STA speed_x
STA speed_y
JMP checkCollisionHorizontal

readjoy:
    lda #$01
    ; While the strobe bit is set, buttons will be continuously reloaded.
    ; This means that reading from JOYPAD1 will only return the state of the
    ; first button: button A.
    sta JOYPAD1
    sta buttons
    lsr a        ; now A is 0
    ; By storing 0 into JOYPAD1, the strobe bit is cleared and the reloading stops.
    ; This allows all 8 buttons (newly reloaded) to be read from JOYPAD1.
    sta JOYPAD1
readjoy_loop:
    lda JOYPAD1
    lsr a	       ; bit 0 -> Carry
    rol buttons  ; Carry -> bit 0; bit 7 -> Carry
    bcc readjoy_loop
    rts

.org $fffa
.dw vblank
.dw main
.dw ignore

.incbin "sprite.bin"
