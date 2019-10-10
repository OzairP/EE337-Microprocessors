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
//#include <stdlib.h>
//#include <ctype.h>
//#include <string.h>

/* ------- Function Prototypes, State Variables, and Constants ---------- */
void test(char word[10], char result[4]);

/* ------------------------- Main Routine ------------------------------- */
int main() {
	char word1[10] = "hardware";
	char word2[10] = "software ";
	char word3[10] = "EE337    ";
	char word4[10] = "Lab";
	char word5[10] = " Manual";

	char result1[4];
	char result2[4];
	char result3[4];
	char result4[4];
	char result5[4];

	test(word1, result1);
	test(word2, result2);
	test(word3, result3);
	test(word4, result4);
	test(word5, result5);

	printf("Result1[]: %s\n", result1);
	printf("Result2[]: %s\n", result2);
	printf("Result3[]: %s\n", result3);
	printf("Result4[]: %s\n", result4);
	printf("Result5[]: %s\n", result5);
}

void test(char word[10], char result[4]) {
	int secondLetterIsO = word[1] == 'o';
	int sixthLetterIsA = word[5] == 'a';
	int hasTrailingSpaceBeforeNull = 0;

	int i;
	for (i = 0; i < 10; ++i) {
		if (word[i] == '\0') {
			break;
		}

		hasTrailingSpaceBeforeNull = word[i] == ' ';
	}

	sprintf(result, "%d%d%d", secondLetterIsO, sixthLetterIsA, hasTrailingSpaceBeforeNull);
}

/* -------------------------- End Program ------------------------------ */
/* --------------------------------------------------------------------- */