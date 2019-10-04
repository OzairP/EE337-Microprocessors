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
 
 ; set ddrb
 LDAA DDRB
 ORAA #$07 ; 0b00000111 last 3 as output (high)
 STAA DDRB

 ; set ddrh
 LDAA DDRH
 ANDA #$F8 ; 0b11111000 last 3 as input (low)
 STAA DDRH
 
 ; set drrj
 LDAA DDRJ
 ORAA #$02
 STAA DDRJ
 
 ; set portj
 LDAA PTJ
 ANDA #$FD
 STAA PTJ
 
; ------------------------------
Main_Loop:

 LDAA PTIH  ; read port h
 COMA       ; negate input (high isnt pressed, low is pressed)
 STAA PORTB ; store into port b

 nop
 bra Main_Loop
; ------------------------------------------------------------
; ------------------------------------------------------------
