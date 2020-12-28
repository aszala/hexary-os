.PHONY: iso run clean boot

NAME = hexary

CC = gcc
CC_FLAGS = -m32 -c

ASM = nasm
ASM_FLAGS = -f elf32

LINK = ld
LINK_FLAGS = -m elf_i386 -T

ROOT = $(NAME)/
BOOT = $(ROOT)boot/
BIN = bin/

ASM_KERNAL = kernal.asm
LINK_FILE = link.ld

OBJ_FILES = $(BIN)kernal.o $(BIN)test.o
SRC_FILES = $(wildcard *.c)

KERNAL_BIN = $(BOOT)kernal.bin
KERNAL_ISO = hexary.iso

$(BIN)%.o: %.c $(BIN)
	$(CC) $(CC_FLAGS) -o $@ $<

$(BOOT)%.bin: $(BIN) $(OBJ_FILES)
	$(ASM) $(ASM_FLAGS) $(ASM_KERNAL) -o $(BIN)kasm.o
	$(LINK) $(LINK_FLAGS) $(LINK_FILE) -o $(KERNAL_BIN) $(OBJ_FILES) $(BIN)kasm.o

boot: $(KERNAL_BIN)

iso: $(KERNAL_BIN)
	grub-mkrescue -o $(KERNAL_ISO) $(ROOT)

run: $(KERNAL_BIN)
	qemu-system-i386 -kernel $(KERNAL_BIN)

%/:
	mkdir -p $@

clean:
	rm -rf $(BIN)
	rm $(KERNAL_BIN)

