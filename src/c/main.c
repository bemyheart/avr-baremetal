#include "basicIO.h"

typedef unsigned char uint8t;

int main(void)
{
    PBDDR = 0b00100000; //(1<<5)

    PBDR = 0b00000000;

    return 0;
}