COMPILER = gcc
CCFLAGS = -ansi -pedantic -Wall

mystery: mystery.h mystery.c
	$(COMPILER) $(CCFLAGS) -o mystery mystery.c

clean:
	rm -f mystery
	rm -f *.o
