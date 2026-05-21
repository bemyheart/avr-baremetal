    .EQU    PBDDR, 0x4
    .EQU    PBDR, 0x5
    .EQU    oLoopVal, 71    ; outer loop counter value
    .EQU    iLoopVal, 28168 ; inner loop counter value
    .EQU    oLoopR, 17     ; outer loop register address
    .EQU    iLoopRl, 24   ; inner loop register address low
    .EQU    iLoopRh, 25    ; inner loop register address high
    .EQU    LEDSTATE, 20
    .EQU    EORMASK, 21
    .global	main
    .type main, @function

main:
    
    ldi EORMASK, 0b00100000
    clr LEDSTATE
    out PBDDR, EORMASK    ; setting pin to iutput, but using EORMASK to save on memory
    out PBDR, LEDSTATE
    
loop:
    eor LEDSTATE, EORMASK
    out PBDR, LEDSTATE

; delay block
    ldi oLoopR, oLoopVal    ; initializing outer loop counter
oLoop:
    ldi iLoopRl, lo8(iLoopVal) ;initializing inner loop counter lower segment
    ldi iLoopRh, hi8(iLoopVal) ;initializing inner loop counter higher segment
iLoop:
    sbiw iLoopRl, 1
    brne iLoop

    dec oLoopR
    brne oLoop
; end of delay block

    rjmp loop
    ret
