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
