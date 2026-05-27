#ifndef _CUSTOMDELAY_
#define _CUSTOMDELAY_

#ifndef FREQ
#define FREQ 16000000UL
#endif //FREQ

#define mSIterations FREQ/4000
#define uSIterations FREQ/4000000

#include "customSys.h"

// 256 iterations max
// 1 iteration = 3 proc cycles
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

// 0,016384 of a second = 65536 iterations + overhead for setting up starting registers
// for 16MHZ:
// 1 iteration = 4 proc cycles 
// 4 proc cycle = 1/4uS (freq/4cycles)
// 4 iterations = 1 uS
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
void delay_ms(uint16t __mSeconds)
{
    while(__mSeconds)
    {
        //delay 1mS
        asm_delay_word(mSIterations);
        --__mSeconds;
    }
    return;
}

//in us
void delay_us(uint16t __uSeconds)
{
    while(__uSeconds)
    {
        //delay 1uS
        asm_delay_word(uSIterations);
        --__uSeconds;
    }
    return;
}

#endif //_CUSTOMDELAY_