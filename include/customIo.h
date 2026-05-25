#ifndef _CUSTOMIO_
#define _CUSTOMIO_

// register adresses
#define PBIN *(volatile uint8t*) 0x23
#define PBDDR *(volatile uint8t*) 0x24
#define PBOUT *(volatile uint8t*) 0x25

//uno pins
#define PIN13 PB5
#define PIN12 PB4

//atmega328p pins
#define PB5 5
#define PB4 4 

#endif //_CUSTOMIO_