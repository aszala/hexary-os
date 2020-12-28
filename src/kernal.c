int main() {
	char* vidmem = (char*)0xb8000;
	vidmem[0] = 'H';
	vidmem[1] = 0x04;

	return 0;
}
