; ------------------------------------------------------------
; Name: Ozair-Ahmed Patel
; BlazerID: opatel1
; Assignment: L1
; TA_Assignment: L1
; Date Started: 10/04/19
;
; Prelab Answers:
;   1. What are ports? What document has information about the
;      available ports on the Dragon12 Board? What does the 
;      Data Direction Register (DDR) of a port do?
;          a. Ports are physical slots that allow for
;             communication with outside components
;          b. Dragon 12 plus manual
;          c. It is a pin that determines if the port is input
;             or output
;   2. Explain how PTIH relates to SW2-SW5. Also explain the
;      functions of PORTB and how to initialize it as an
;      input/output.
;          a. Port H contains pins each of which can be used by
;             a button
;          b. You have to register the DDR on ports B to declare
;             them as an output port not an input port
;
; Postlab Answers:
;   1. Explain the use of binary/hexadecimal numbers in this
;	     assignment. Why are they all (for the most part) 8 or
;      16-bit numbers?
;	         a. Numerics were used to declare the DDR of our IO.
;          b. They are 8 or 16 because processors hold data by
;             bytes which are 8 bits and other products of 8.
;	  2. What is a bit mask? Why is it often preferable to use
;      a bit mask over raw binary or hexadecimal numbers?
;          a. A figurative mask that only produces the bits that
;             we are concerned with
;          b. It is clear with a bitmask compared to raw numerics
;   3. What is the difference between serial I/O and parallel
;      I/O? Name 2 serial I/O interfaces and 2 parallel I/O
;      interfaces on the Dragon-12 board.
;          a. Serial processes inputs one at a time, parallel
;             is multiplexed so many inputs are processed at
;             the same time.
;
; Lab Description: Turn on LED when button is pressed
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
 
 
; ------------------------------
Main_Loop:
 LDAA #0 ; myNum
 STAA $1000 ; myNum
 ; 1
 LDAA #$F0
 STAA $1001 ; results1
 ; 2
 LDAB #10 ; instruct 2 incrementor

Instruct_2:
 COMA
 STAA $1002 ; results2
 DBNE A,Instruct_2
 BRA Instruct_3

; ------------------------------------------------------------

Instruct_3:
 LDAA #0
 STAA $1002 ; results2
 STAA $1003 ; results3
 STAA $1000 ; myNum
 BRA Instruct_4

; ------------------------------------------------------------

Instruct_4:
 ; need to data mode to signed, see page 583 of MC9S12DP256
 BSET $0005,0b01000000 ; set bit 6 to 1
 LDAA #0        ; incrementor
 STAA $1004     ; results4
 BSET $1008,$0 ; decrement flag
 JSR Instruct_4_SR
 ; revert signed mode
 BCLR $0005,0b01000000 ; set bit 6 to 0
 BRA Instruct_5

; accum B the output of comparisons
Instruct_4_SR:
 STAA $1004 ; store incrementor
 ; if !flag -> INC
 BRCLR $1008,$1,Instruct_4_SR_Inc
 ; flag must be true
 ; if A != 0 -> DEC
 CMPA #$0
 BNE Instruct_4_SR_Dec
 ; flag is true and A is zero
 RTS

Instruct_4_SR_Inc:
 INCA
 CMPA #127
 BNE Instruct_4_SR
 BSET $1008,$1 ; decrement flag true
 BRA Instruct_4_SR

Instruct_4_SR_Dec:
 DECA
 BRA Instruct_4_SR

; ------------------------------------------------------------

Instruct_5:
 ; need to data mode to signed, see page 583 of MC9S12DP256
 BSET $0005,0b01000000 ; set bit 6 to 1
 LDAA #0        ; incrementor
 STAA $1005     ; results5
 BSET $1008,$0  ; increment flag
 JSR Instruct_5_SR
 ; revert signed mode
 BCLR $0005,0b01000000 ; set bit 6 to 0
 BRA Instruct_6

; accum B the output of comparisons
Instruct_5_SR:
 STAA $1005 ; store incrementor
 ; if !flag -> DEC
 BRCLR $1008,$1,Instruct_5_SR_Dec
 ; flag must be true
 ; if A != 0 -> INC
 CMPA #$0
 BNE Instruct_5_SR_Inc
 ; flag is true and A is zero
 RTS

Instruct_5_SR_Inc:
 INCA
 CMPA #$FF
 BNE Instruct_5_SR
 BSET $1008,$1
 BRA Instruct_5_SR

Instruct_5_SR_Dec:
 DECA
 BRA Instruct_5_SR

; ------------------------------------------------------------
Instruct_6:
 LDAA #85
 STAA $1000 ; set myNum to 85
 ADDA #85
 STAA $1006 ; store result6
 BRA Instruct_7

Instruct_7:
 EORA 0b11110000
 STAA $1006 ; store result6
 NOP
 BRA Main_Loop
; ------------------------------------------------------------
