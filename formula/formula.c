#include "formula.h"

int main(int argc, char** argv){
	unsigned int power;
	int counter;
	unsigned int pcount;
	int coeff;
	struct timeval start;
	struct timeval end;
	int elapsedtime;
	gettimeofday(&start, NULL);
	/***************************
	 * checking inputs for any faults in format
	 */
	if(argc != 2){
		fprintf(stderr, "Incorrect number of arguments\n");
		return 0;
	}
	if(atoi(argv[1]) < 0){
		fprintf(stderr, "Second argument must be a positive number\n");
		return 0;
	}
	if (strcmp(argv[1], "-h") == 0){
		printhelp();
		return 0;
	}
	for(counter = 0; counter < strlen(argv[1]); counter++){
		if(!isdigit(argv[1][counter])){
			fprintf(stderr, "Second argument must be Positive Integer\n");
			return 0;
		}
	}
	power = atoi(argv[1]);
	if(power == 0){
		printf("(1 + x)^%d = 1", power);
		gettimeofday(&end, NULL);
		elapsedtime = end.tv_usec - start.tv_usec;
		printf("\nTime Required = %d microsecond\n", elapsedtime);
		return 0;
	}
		
	/****************************
	 * begin looping up to the power input
	 */
	for(pcount = 1; pcount <= power; pcount++){
		/**************************
		 * calculate the coefficient for each term in equation
		 */
		coeff = nCr(power, pcount);
		if (coeff == 0){ /** overflow condition */
			fprintf(stderr, "ERROR: Overflow, Enter a lower number\n");
			return 0; 
		}
		if(pcount == 1)	printf("(1 + x)^%d = 1", power);
		printf(" + %d*x^%d", coeff, pcount);
	}
	gettimeofday(&end, NULL);
	/***************************
	 * complete run-time calculation using gettimeofday() values
	 */
	elapsedtime = end.tv_usec - start.tv_usec;
	printf("\nTime Required = %d microsecond\n", elapsedtime);
	return 0;
}
