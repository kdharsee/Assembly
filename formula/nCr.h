
#pragma once
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>
#include <limits.h>
#include <sys/time.h>
/****************************
 * prints out the help message to aquaint user
 * with usage interface
 */
void printhelp(void);

/*****************************
 * inputs: positive int
 * Outputs: factorial
 * calculates the factorial of the given input
 * returns 0 when overflow
 */
int factorial(int num);

/******************************
 * implements the equation nCr
 * nCr = n! / (r! * (n - r)! )
 */
int nCr(int n, int r);
