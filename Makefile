.PHONY: iso dirs clean

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
C_KERNAL = kernal.c
LINK_FILE = link.ld

ASM_KERNAL_BIN = $(BIN)kasm.o
C_KERNAL_BIN = $(BIN)kc.o

KERNAL_BIN = $(BOOT)kernal.bin
KERNAL_ISO = hexary.iso

$(BIN)%.o: | $(BIN)
	$(ASM) $(ASM_FLAGS) $(ASM_KERNAL) -o $(ASM_KERNAL_BIN)
	$(CC) $(CC_FLAGS) $(C_KERNAL) -o $(C_KERNAL_BIN)

$(BOOT)%.bin: $(ASM_KERNAL_BIN) $(C_KERNAL_BIN)
	$(LINK) $(LINK_FLAGS) $(LINK_FILE) -o $(KERNAL_BIN) $(ASM_KERNAL_BIN) $(C_KERNAL_BIN)

iso: | $(KERNAL_BIN)
	grub-mkrescue -o $(KERNAL_ISO) $(ROOT)

run: | $(KERNAL_BIN)
	qemu-system-i386 -kernel $(KERNAL_BIN)

%/:
	mkdir -p $@

clean:
	rm -rf $(BIN)
	rm $(KERNAL_BIN)

