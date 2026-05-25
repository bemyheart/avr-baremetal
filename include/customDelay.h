#ifndef _CUSTOMDELAY_
#define _CUSTOMDELAY_

#ifndef FREQ
#define FREQ 16000000UL
#endif //FREQ

#include "customSys.h"

void asm_delay_byte(uint8t __amount)
{
    __asm__ volatile (
		"1: dec %0" "\n\t"
		"brne 1b"
		: "=r" (__amount)
		: "0" (__amount)
	);
    return;
}

//0,016384 of a second = 65536 iterations
void asm_delay_word(uint16t __amount)
{
	__asm__ volatile (
		"1: sbiw %0,1" "\n\t"
		"brne 1b"
		: "+w" (__amount)
	);
    return;
}

//in mS
void delay(uint16t __mSeconds)
{
    unsigned int __ticks = __mSeconds;

    while(__ticks)
    {
        //delay 1mS
        asm_delay_word(((16000000) / 4e3));
        __ticks--;
    }
    return;
}

#endif //_CUSTOMDELAY_