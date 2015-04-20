#include "mystery.h"
int num[200];

int add(int num1, int num2){
	return num1 + num2;
}
int compute_fib(int number){
	int y;
	if(num[number] != -1){
		return num[number];
	}
	y = -1;
	if(number == 0){
		y = 0;
	}
	else{
		if(number == 1){
			y = 1;
		}
		else{
			y = add(compute_fib(number-1), compute_fib(number-2));
		}
	}
	if(num[number]  == -1){
		num[number] = y;
	}
	return num[number];
}
	

int main(int argc, char **argv){
	int x, y;
	x = atoi(argv[1]);
	y = 0;
	while(y <= 199){
		num[y] = -1;
		y = y + 1;
	}
	printf("Value:   %d\n", compute_fib(x));
	return 0;
}
