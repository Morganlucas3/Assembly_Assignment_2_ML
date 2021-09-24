
// TODO: Your code

#include <stdio.h>

extern long manager_assembly_function();

int main() {

	printf("Welcome to Arrays of Integers\n");
	printf("Brought to you by Morgan Lucas\n");


	long returnValue = manager_assembly_function();


	printf("Main received this number: %ld\n", returnValue);
	printf("Main will return 0 to the operating system. Bye!\n");
	

return 0;
}


