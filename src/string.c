#include "string.h"

uint16 strlength(string ch) {
	unint16 i = 0;

	while (ch[i++]);

	return i;
}
