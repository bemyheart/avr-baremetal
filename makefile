BOARD = atmega328p 
PORT = COM3
BAUDRATE = 115200
PROGRAMMER = arduino
BUILDDIR = ./build

#building the programm going through all the stages
default: object elf hex

# making object files
object:
	@echo -n "Making obj files..."
	@avr-gcc ./src/main.c -I./include -Os -Wall -mmcu=${BOARD} -c -o${BUILDDIR}/main.o
	@echo "done"

# making executable file from all object files and linking libraries
elf:
	@echo -n "Making elf files..."
	@avr-gcc ${BUILDDIR}/main.o -Os -Wall -mmcu=${BOARD} -o ${BUILDDIR}/main.elf
	@echo "done"

# making hex file, taking only .text and .data leaving bootloader and misc. stuff
hex:
	@echo -n "Making hex files..."
	@avr-objcopy -Oihex -j.text -j.data ${BUILDDIR}/main.elf ${BUILDDIR}/main.hex
	@echo "done"

# flashing mcu, no fuses
flash:
	@echo "Flashing..."
	avrdude -c${PROGRAMMER} -p${BOARD} -P${PORT} -b${BAUDRATE} -Uflash:w:${BUILDDIR}/main.hex

# checking active comports
testPort:
	reg query HKLM\HARDWARE\DEVICEMAP\SERIALCOMM

# checking if selected board is returning correct ID
testBoard:
	avrdude -c${PROGRAMMER} -p${BOARD} -P${PORT} -b${BAUDRATE}

# cleaning build directory
clean:
	@${RM} ${BUILDDIR}/*
	@echo "Cleaning of build directory done!"
