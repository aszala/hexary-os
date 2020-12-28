#ifndef SCREEN_H
#define SCREEN_H

#include "types.h"

void clearLine(uint8 from, uint8 to);
void updateCursor();
void clearScreen();
void scrollUp(uint8 lineNumber);
void newLineCheck();
void printch(char c);
void print(string c);

#endif
