#ifndef _BUZZER_
#define _BUZZER_

#include "customIo.h"
#include "customDelay.h"
#include "customSys.h"


/// 100 hz to 20kHz
// ~1kb of extra memory due to float division ->think on rewriting
// lower frequencies only execute on very low frequencies, when frequency goes above ~300 tone is broken

//pin frequency in hz, duration in mS
void buzzer(uint8t pin, uint16t frequency, uint16t duration)
{   
    uint16t delayTime;
    uint16t iterations;
    
    if(frequency <= 500)
    {
        
        delayTime = ((1.0/frequency) / 2.0) * 1000; // calculate time between toggles in ms
        iterations = duration / delayTime;

        while(iterations)
        {
            PBOUT ^= 1<<pin;
            delay_ms(delayTime);
            iterations--;
        }
    }
    else 
    {
        delayTime = ((1.0/frequency) / 2.0) * 1000000; // calculate time between toggles in us
        iterations = (duration / delayTime) * 1000;
        
        while(iterations)
        {
            PBOUT ^= 1<<pin;
            delay_us(delayTime);
            iterations--;
        }
    }

    return;
}

// calculate full period 1/1000 = 0,001
// calculate half period 0,001/2 = 0,0005
// calculate iterations 1000/0,0005 = 

#endif //_BUZZER_