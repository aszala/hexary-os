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
SRC = src/

ASM_KERNAL = kernal.asm
ASM_BIN = $(BIN)kasm.o
LINK_FILE = link.ld

SRC_FILES = $(wildcard $(SRC)*.c)
OBJ_FILES = $(patsubst $(SRC)%.c, $(BIN)%.o, $(SRC_FILES))

KERNAL_BIN = $(BOOT)kernal.bin
KERNAL_ISO = hexary.iso

$(BIN)%.o: $(SRC)%.c $(BIN)
	$(CC) $(CC_FLAGS) -o $@ $<

$(BOOT)%.bin: $(BIN) $(OBJ_FILES)
	$(ASM) $(ASM_FLAGS) $(ASM_KERNAL) -o $(ASM_BIN)
	$(LINK) $(LINK_FLAGS) $(LINK_FILE) -o $(KERNAL_BIN) $(OBJ_FILES) $(ASM_BIN)

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

