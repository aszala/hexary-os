#include "include/string.h"
#include "include/types.h"

uint16 strlength(string ch) {
	uint16 i = 0;

	while (ch[i++]);

	return i;
}
