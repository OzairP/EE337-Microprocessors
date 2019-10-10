; ------------------------------------------------------------
; Name: Ozair-Ahmed Patel
; BlazerID: opatel1
; Assignment: L2
; TA_Assignment: L2
; Date Started: 10/04/19
;
; Prelab Answers:
;   1. What causes signal bounce on the output of switches?
;      What other electro-mechanical devices might bounce when
;      changing state?
;         a. The switch physically bounces and the contacts
;            don't cleanly disengage.
;   2. Discuss the advantages and disadvantages of writing a
;      software debounce in C vs Assembly for a given processor
;         a. ADV: Very low level so this processing is very fast
;            and higher level programs don't need to worry
;         b. DIS: Verbose and needs to be included for every
;            program.
;
; Postlab Answers:
;   1. Signal debouncing can be done with both hardware and
;      software. Compare the advantages and disadvantages of
;      each solution.
;         a. Hardware is much faster and always runs. Software
;            can be improved and shipped without changing
;            or replacing hardware.
;   2. Why is debouncing important?
;         a. Remove extraneous noise and falsey inputs
;   3. List the number of cycles for each of the opcodes used
;      in your delay function then sum the total time of the
;      delay in clock cycles
;         a. 
;
; Lab Description: Remove noise from switch to ensure input precision
; ------------------------------------------------------------
 INCLUDE 'derivative.inc'
 XDEF Entry, _Startup, main
 XREF __SEG_END_SSTACK
MY_EXTENDED_RAM: SECTION
MyCode: SECTION
_Startup:
main:
Entry:
; ------------------------------
 lds #__SEG_END_SSTACK ; set the stack pointer
 cli

 ; set ddrh
 LDAA DDRH
 ANDA #$FE ; 0b1111110 last 1 as input (low)
 STAA DDRH
 
 ; binset ddrb
 BSET DDRB,$FF
 
 ; ddrj and portj
 BSET DDRJ,$02
 BCLR PTJ,$02
 
 ; ddrp
 BSET DDRP,$FF
 
 LDAB #$00 ; our incrementer
 
; ------------------------------
Main_Loop:
 LDAA PTIH     ; load h
 ANDA #$01     ; & 0001 - equals 0000 pressed 0001 unpressed
 BNE Main_Loop ; go back if not 0000
 
 INCB          ; increment b
 STAB PORTB    ; write reg b to port b
 
 JSR DELAY
 JSR Wait_For_Release
 JSR DELAY

 nop
 bra Main_Loop
 
; ------------------------------
Wait_For_Release:
 LDAA PTIH            ; load input
 ANDA #$01            ; pressed bitmask
 BEQ Wait_For_Release ; go back if 0001 (unpressed)
 RTS
 
; ------------------------------
DELAY:
 LDY #$FFFF           ; delay for 65,536 (16bit max) cycles
DELAY_Y_LOOP:
 DEY
 BNE DELAY_Y_LOOP
 
 RTS
 
; ------------------------------------------------------------
; ------------------------------------------------------------