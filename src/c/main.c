#include "customSys.h"
#include "customIo.h"
#include "customDelay.h"
#include "buzzer.h"

#define INTERNALLED PIN13
#define BUZZERPIN PIN12

int main(void)
{
    PBDDR |= 1<<INTERNALLED | 1<<BUZZERPIN; 
    PBOUT |= 0;

    int frequency = 100;
    while(1)
    {
        PBOUT ^= 1<<PIN13;
        buzzer(BUZZERPIN, frequency, 1000);
        delay_ms(1000);
        frequency+=100;
        if(frequency == 2000) frequency = 100;
    }
    return 0;
}