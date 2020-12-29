#include "include/string.h"
#include "include/types.h"
#include "include/screen.h"

uint16 strLength(string s) {
	uint16 i = 0;

	while (s[i++]);

	return i;
}

uint8 strEquals(string s1, string s2) {
	uint16 s1Size = strLength(s1);
	uint16 s2Size = strLength(s2);

	if (s1Size != s2Size) {
		return 0;
	} else {
		uint16 i = 0;

		for (i;i<=s1Size;i++) {
			if (s1[i] != s2[i]) {
				print("S1:");
				printch(s1[i]);
				print("; S2");
				printch(s2[i]);
				return 0;
			}
		}
	}

	return 1;
}
