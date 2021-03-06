.section .data
.macro linea 
#	.int -1,-1,-1,-1
#	.int 1,-2,1,-2
#	.int 1,2,-3,-4
#	.int 0x7FFFFFFF,0x7FFFFFFF,0x7FFFFFFF,0x7FFFFFFF
#	.int 0x80000000,0x80000000,0x80000000,0x80000000
#	.int 0x04000000,0x04000000,0x04000000,0x04000000
#	.int 0x08000000,0x08000000,0x08000000,0x08000000
#	.int 0xFC000000,0xFC000000,0xFC000000,0xFC000000
#	.int 0xF8000000,0xF8000000,0xF8000000,0xF8000000
	.int 0xF0000000,0xE0000000,0xE0000000,0xD0000000



.endm
lista: .irpc i,12345678
	linea
	.endr
longitud:
	.int (.-lista)/4
resultado:
	.quad 0x0123456789ABCDEF
formato:
	.ascii "suma = %lld = %llx hex\n\0"	

.section .text
main: .global main
	movl $lista, %ebx
	movl longitud, %ecx
	call suma
	mov %eax, resultado
	mov %edx, resultado + 4
	push resultado + 4
	push resultado
	push resultado + 4
	push resultado 
	push $formato
	call printf
	add $20, %esp

	mov $1, %eax
	mov $0, %ebx
	int $0x80
suma: 
	
	movl $0, %ebp
	movl $0, %edi
	movl $0, %esi

bucle:
	movl (%ebx,%esi,4), %eax
	cltd
	add %eax, %edi
	adc %edx, %ebp
	inc %esi
	cmp %esi, %ecx
	jne bucle
	movl %edi, %eax
	movl %ebp, %edx
	ret



