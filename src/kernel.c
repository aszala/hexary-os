#include "include/screen.h"
#include "include/types.h"
#include "include/keyboard.h"

int main() {
	clearScreen();
	print("Welcome to HexaryOS\n");

	uint8 run = 1;

	while (run) {
		print("\nHexaryOS>");

		string cmd = readInput();

		if (strEquals(cmd, "clear")) {
			clearScreen();
		} else {
			print("\n" + cmd + ": command not found");
		}
	}

	return 0;
}
