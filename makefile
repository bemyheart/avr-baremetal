BOARD = atmega328p 
PORT = COM3
BAUDRATE = 115200
PROGRAMMER = arduino
BUILDDIR = ./build
INCDIR = ./include
CSRCFILES = ./src/c/main.c
SSRCFILES = ./src/s/main.s
COMARGS = -I${INCDIR} -Os -Wall -mmcu=${BOARD}

#building the programm going through all the stages
# can switch between pipelines: allC or allS
default: allC

## c pipeline #################################################

#going through all steps of builing a programm in c pipeline
allC: obj ass elfC hexC

# making object files
obj:
	@echo -n "Making obj files..."
	@avr-gcc ${CSRCFILES} ${COMARGS} -c -o${BUILDDIR}/main.o
	@echo "done"

# making assembler files form c in addition to object to control and debug
ass:
	@echo -n "Making ass files..."
	@avr-gcc ${CSRCFILES} ${COMARGS} -S -o${BUILDDIR}./main.s
	@echo "done"

# making executable file from all object files and linking libraries
elfC:
	@echo -n "Making elf files..."
	@avr-gcc ${BUILDDIR}/main.o ${COMARGS} -o${BUILDDIR}/main.elf
	@echo "done"

# making hex file from elf file, taking only .text and .data leaving bootloader and misc. stuff
hexC:
	@echo -n "Making hex files..."
	@avr-objcopy -Oihex -j.text -j.data ${BUILDDIR}/main.elf ${BUILDDIR}/main.hex
	@echo "done"


## assembly pipeline #################################################

#going through all steps of builing a programm in assembler pipeline
allS: elfS hexS

# making executable file from all assembly files and linking libraries
elfS:
	@echo -n "Making elf files..."
	@avr-gcc ${SSRCFILES} ${COMARGS} -o${BUILDDIR}/main.elf
	@echo "done"

# making hex file from object files
hexS:
	@echo -n "Making hex files..."
	@avr-objcopy -Oihex ${BUILDDIR}/main.elf ${BUILDDIR}/main.hex
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
