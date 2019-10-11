/**************************************************************************
 * Name: Ozair-Ahmed Patel
 * BlazerID: opatel1
 * Assignment: C1
 * TA_Assignment:
 * Date Started: 10/10/2019
 *
 * Prelab Answers:
 * 		1. How do you import external libraries in C? How do you define
 * 		   functions? What are function prototypes and when are they needed?
 * 		   		a. #include directive
 * 		   		b. <ret_type> <iden> ( <args ) { <body> }
 * 		   		c. Function signature declarations. If you are going to
 * 		   		   initialize a functions body later on
 * 		2. What is the difference between using single ' ' and double " "
 * 		   quotes in C?
 * 		        a. Single is for character literals
 * 		        b. Double is for string literals
 * 		3. What are programming flags? How can a flag be used to control
 * 		   program flow?
 * 		   		a. Boolean variables that indicates different behavior
 * 		   		   to the called function
 * 		   		b. Skip something if a flag is true
 * 		4. What are pointers? How are pointers initialized and set in C?
 * 				a. A literal address in memory
 * 				b. Automatically initialized by language
 *
 * Postlab Answers:
 *
 * Lab Description: Play with control statements and variables
 *
***************************************************************************/

/* --------------------- External Library Imports ----------------------- */
//#include <hidef.h>      // Common defines and macros
//#include "derivative.h" // Derivative-specific definitions
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* ------- Function Prototypes, State Variables, and Constants ---------- */
/**
 * @author http://www.strudel.org.uk/itoa/
 */
char *itoa(int value, char *result, int base) {
	// check that the base if valid
	if (base < 2 || base > 36) {
		*result = '\0';
		return result;
	}

	char *ptr = result, *ptr1 = result, tmp_char;
	int tmp_value;

	do {
		tmp_value = value;
		value /= base;
		*ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz"[35 + (tmp_value - value * base)];
	} while (value);

	// Apply negative sign
	if (tmp_value < 0)
		*ptr++ = '-';
	*ptr-- = '\0';
	while (ptr1 < ptr) {
		tmp_char = *ptr;
		*ptr-- = *ptr1;
		*ptr1++ = tmp_char;
	}
	return result;
}

/* ------------------------- Main Routine ------------------------------- */
int main() {
	int myNum = 0b0;
	char asBin[9];
	char asHex[4];

	int results1 = 0;
	int results2 = 0;
	int results3 = 0;
	int results4 = 0;
	int results5 = 0;
	int results6 = 0;

	int i = 0;
	int alternationCount = 0;
	int finishedResults4 = 0;
	int finishedResults5 = 0;
	while (i < 8) {
		printf("\n\n--- Iteration %d ---\n", i);
		itoa(myNum, asBin, 2);
		itoa(myNum, asHex, 16);
		printf("Bin: %s\n", asBin);
		printf("Hex: %s\n", asHex);
		printf("R1: %d\n", results1);
		printf("R2: %d\n", results2);
		printf("R3: %d\n", results3);
		printf("R4: %d\n", results4);
		printf("R5: %d\n", results5);
		printf("R6: %d\n", results6);

		if (i == 0) {
			myNum = 0xF0;
			results1 = myNum;
		}

		if (i == 1) {
			myNum = ~myNum;
			results2 = myNum;

			if (alternationCount < 10) {
				alternationCount++;
				continue;
			}
		}

		if (i == 2) {
			results2 = 0;
			results3 = 0;
		}

		if (i == 3 && (results4 != 0 || !finishedResults4)) {
			if (results4 != 127 && !finishedResults4) {
				results4++;
			} else {
				results4--;
				finishedResults4 = 1;
			}
			continue;
		}

		if (i == 4 && (results5 != 0 || !finishedResults5)) {
			if (results5 != -128 && !finishedResults5) {
				results5--;
			} else {
				results5++;
				finishedResults5 = 1;
			}
			continue;
		}

		if (i == 4) {
			myNum = 0b1010101;
		}

		if (i == 5) {
			results6 = myNum + 0b1010101;
		}

		if (i == 6) {
			results6 = myNum ^ 0b11110000;
		}

		i++;
	}
}

/* -------------------------- End Program ------------------------------ */
/* --------------------------------------------------------------------- */