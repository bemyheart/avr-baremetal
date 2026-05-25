	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	asm_delay_byte
	.type	asm_delay_byte, @function
asm_delay_byte:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
/* #APP */
 ;  12 "./include/customDelay.h" 1
	1: dec r24
	brne 1b
 ;  0 "" 2
/* #NOAPP */
/* epilogue start */
	ret
	.size	asm_delay_byte, .-asm_delay_byte
.global	asm_delay_word
	.type	asm_delay_word, @function
asm_delay_word:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
/* #APP */
 ;  24 "./include/customDelay.h" 1
	1: sbiw r24,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
/* epilogue start */
	ret
	.size	asm_delay_word, .-asm_delay_word
.global	delay
	.type	delay, @function
delay:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r18,lo8(-96)
	ldi r19,lo8(15)
.L4:
	sbiw r24,0
	brne .L5
/* epilogue start */
	ret
.L5:
	movw r30,r18
/* #APP */
 ;  24 "./include/customDelay.h" 1
	1: sbiw r30,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	sbiw r24,1
	rjmp .L4
	.size	delay, .-delay
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbi 0x4,5
	in r24,0x5
	out 0x5,r24
	ldi r28,lo8(32)
.L7:
	in r24,0x5
	eor r24,r28
	out 0x5,r24
	ldi r24,lo8(-72)
	ldi r25,lo8(11)
	call delay
	rjmp .L7
	.size	main, .-main
	.ident	"GCC: (GNU) 15.2.0"
