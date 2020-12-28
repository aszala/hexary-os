#include "include/screen.h"
#include <stdio.h>

int main() {
	clearScreen();
	print("This is a test\n");
	print("This is a test 2\n");

	char c = getchar();

	printch(c);

	return 0;
}
