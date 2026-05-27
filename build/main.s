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
 ;  17 "./include/customDelay.h" 1
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
 ;  33 "./include/customDelay.h" 1
	1: sbiw r24,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
/* epilogue start */
	ret
	.size	asm_delay_word, .-asm_delay_word
.global	delay_ms
	.type	delay_ms, @function
delay_ms:
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
 ;  33 "./include/customDelay.h" 1
	1: sbiw r30,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	sbiw r24,1
	rjmp .L4
	.size	delay_ms, .-delay_ms
.global	delay_us
	.type	delay_us, @function
delay_us:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r18,lo8(4)
	ldi r19,0
.L7:
	sbiw r24,0
	brne .L8
/* epilogue start */
	ret
.L8:
	movw r30,r18
/* #APP */
 ;  33 "./include/customDelay.h" 1
	1: sbiw r30,1
	brne 1b
 ;  0 "" 2
/* #NOAPP */
	sbiw r24,1
	rjmp .L7
	.size	delay_us, .-delay_us
.global	buzzer
	.type	buzzer, @function
buzzer:
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 6 */
.L__stack_usage = 6
	mov r14,r24
	movw r28,r22
	movw r16,r20
	ldi r24,0
	ldi r25,0
	call __floatunsisf
	movw r18,r22
	movw r20,r24
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(-128)
	ldi r25,lo8(63)
	call __divsf3
	ldi r18,0
	ldi r19,0
	ldi r20,0
	ldi r21,lo8(63)
	call __mulsf3
	cpi r28,-11
	sbci r29,1
	brsh .L10
	ldi r18,0
	ldi r19,0
	ldi r20,lo8(122)
	ldi r21,lo8(68)
	call __mulsf3
	call __fixunssfsi
	movw r28,r22
	movw r24,r16
	movw r22,r28
	call __udivmodhi4
	movw r16,r22
	ldi r24,lo8(1)
	ldi r25,0
	movw r18,r24
	rjmp 2f
	1:
	lsl r18
	2:
	dec r14
	brpl 1b
	mov r14,r18
.L11:
	cp r16,__zero_reg__
	cpc r17,__zero_reg__
	brne .L12
.L9:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
.L12:
	in r24,0x5
	eor r24,r14
	out 0x5,r24
	movw r24,r28
	call delay_ms
	subi r16,1
	sbc r17,__zero_reg__
	rjmp .L11
.L10:
	ldi r18,0
	ldi r19,lo8(36)
	ldi r20,lo8(116)
	ldi r21,lo8(73)
	call __mulsf3
	call __fixunssfsi
	movw r28,r22
	movw r24,r16
	movw r22,r28
	call __udivmodhi4
	ldi r24,lo8(-24)
	ldi r25,lo8(3)
	mul r22,r24
	movw r16,r0
	mul r22,r25
	add r17,r0
	mul r23,r24
	add r17,r0
	clr r1
	ldi r18,lo8(1)
	ldi r19,0
	movw r24,r18
	rjmp 2f
	1:
	lsl r24
	2:
	dec r14
	brpl 1b
	mov r14,r24
.L13:
	cp r16,__zero_reg__
	cpc r17,__zero_reg__
	breq .L9
	in r24,0x5
	eor r24,r14
	out 0x5,r24
	movw r24,r28
	call delay_us
	subi r16,1
	sbc r17,__zero_reg__
	rjmp .L13
	.size	buzzer, .-buzzer
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0x4
	ori r24,lo8(48)
	out 0x4,r24
	in r24,0x5
	out 0x5,r24
	ldi r28,lo8(100)
	ldi r29,0
	ldi r17,lo8(32)
.L17:
	in r24,0x5
	eor r24,r17
	out 0x5,r24
	ldi r20,lo8(-24)
	ldi r21,lo8(3)
	movw r22,r28
	ldi r24,lo8(4)
	call buzzer
	ldi r24,lo8(-24)
	ldi r25,lo8(3)
	call delay_ms
	subi r28,-100
	sbci r29,-1
	cpi r28,-48
	ldi r24,7
	cpc r29,r24
	brne .L17
	ldi r28,lo8(100)
	ldi r29,0
	rjmp .L17
	.size	main, .-main
.global	__fixunssfsi
.global	__mulsf3
.global	__divsf3
.global	__floatunsisf
	.ident	"GCC: (GNU) 15.2.0"
