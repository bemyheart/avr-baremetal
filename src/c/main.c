#include "customSys.h"
#include "customIo.h"
#include "customDelay.h"


int main(void)
{
    PBDDR |= 1<<PIN13; 
    PBOUT |= 0;

    while(1)
    {
        PBOUT ^= 1<<PIN13;
        delay(3000);
    }
    return 0;
}