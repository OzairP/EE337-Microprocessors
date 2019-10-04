                   ; ------------------------------------------------------------
; Name: Ozair-Ahmed Patel
; BlazerID: opatel1
; Assignment:
; TA_Assignment: L1
; Date Started: 10/04/19
;
; Prelab Answers:
;   1. What are ports? What document has information about the
;      available ports on the Dragon12 Board? What does the 
;      Data Direction Register (DDR) of a port do?
;        a. Ports are physical slots that allow for
;           communication with outside components
;        b. Dragon 12 plus manual
;        c. It is a pin that determines if the port is input
;           or output
;   2. Explain how PTIH relates to SW2-SW5. Also explain the
;      functions of PORTB and how to initialize it as an
;      input/output.
;        a. Port H contains pins each of which can be used by
;           a button
;        b. You have to register the DDR on ports B to declare
;           them as an output port not an input port
; Postlab Answers:
; Lab Description:
; ------------------------------------------------------------
 INCLUDE 'derivative.inc'
 XDEF Entry, _Startup, main
 XREF __SEG_END_SSTACK
MY_EXTENDED_RAM: SECTION
MyCode: SECTION
main:
Entry:
; ------------------------------
 lds #__SEG_END_SSTACK ; set the stack pointer
 cli

 ; set ddrh
 LDAA DDRH
 ANDA #$FE ; 0b1111110 last 1 as input (low)
 STAA DDRH
 
 LDAB #$00 ; our incrementer
 
; ------------------------------
Main_Loop:

 LDAA PTIH     ; load h
 ANDA #$01     ; & 0001 - equals 0000 pressed 0001 unpressed
 BNE Main_Loop ; branch if not equal to 0
 
 INCB          ; increment b
 
 JSR DELAY
 JSR Wait_For_Release
 JSR DELAY

 nop
 bra Main_Loop
 
; ------------------------------

Wait_For_Release:
 LDAA PTIH
 ANDA #$01
 BSR Wait_For_Release ; ??
 RTS
 
; ------------------------------

DELAY:
 LDY #$0FFF
DELAY_Y_LOOP:
 LDX #$FFFF
DELAY_X_LOOP:
 NOP
 DEX
 BNE DELAY_X_LOOP
 DEY
 BNE DELAY_Y_LOOP
 
 RTS
 
; ------------------------------------------------------------
; ------------------------------------------------------------
