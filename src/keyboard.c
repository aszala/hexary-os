#include "include/keyboard.h"
#include "include/types.h"
#include "include/screen.h"
#include "include/system.h"

const char* inputMap = "  1234567890-=\b qwertyuiop[]  asdfghjkl;    zxcvbnm,././  ";

string readInput() {
	char buff;
	string buffString;

	uint8 i = 0;
	uint8 reading = 1;

	while (reading) {
		if (inportb(0x64) & 0x1) {
			uint8 input = inportb(0x60);

			if (input == 0 || input == 1 || input == 15 || input == 29 || input == 42 || input == 43 || input == 56) {

			} else if (input == 28) {
				i++;
				reading = 0;
			} else {
				char c = inputMap[input];
				printch(c);
				buffString[i] = c;
				i++;
			}
		}
	}

	buffString[i] = 0;

	return buffString;
}
