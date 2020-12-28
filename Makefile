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

ASM_KERNEL = kernel.asm
ASM_BIN = $(BIN)kasm.o
LINK_FILE = link.ld

SRC_FILES = $(wildcard $(SRC)*.c)
OBJ_FILES = $(patsubst $(SRC)%.c, $(BIN)%.o, $(SRC_FILES))

KERNEL_BIN = $(BOOT)kernel.bin
KERNEL_ISO = hexary.iso

$(BIN)%.o: $(SRC)%.c $(BIN)
	$(CC) $(CC_FLAGS) -o $@ $<

$(BOOT)%.bin: $(BIN) $(OBJ_FILES)
	$(ASM) $(ASM_FLAGS) $(ASM_KERNEL) -o $(ASM_BIN)
	$(LINK) $(LINK_FLAGS) $(LINK_FILE) -o $(KERNEL_BIN) $(OBJ_FILES) $(ASM_BIN)

boot: $(KERNEL_BIN)

iso: $(KERNEL_BIN)
	grub-mkrescue -o $(KERNEL_ISO) $(ROOT)

run: $(KERNEL_BIN)
	qemu-system-i386 -kernel $(KERNEL_BIN)

%/:
	mkdir -p $@

clean:
	rm -rf $(BIN)
	rm $(KERNEL_BIN)

