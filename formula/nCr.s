	.file	"nCr.c"
	.section	.rodata
	.align 4
.LC0:
	.ascii	"Usage: formula <positive integer> "
	.string	"\n where the argument <positive integer> should be a non-negative integer. The program will print out the \"long\" form of (1 + x)^n, where n is equal to the argument <positive integer>. Your program should also print out its execution time (in microseconds).\n"
	.text
.globl printhelp
	.type	printhelp, @function
printhelp:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	stdout, %eax
	movl	%eax, 12(%esp) 
	movl	$290, 8(%esp)
	movl	$1, 4(%esp)
	movl	$.LC0, (%esp)
	call	fwrite
	leave
	ret
	.size	printhelp, .-printhelp
.globl factorial
	.type	factorial, @function
factorial:
	pushl	%ebp						# function entry setup
	movl	%esp, %ebp
	subl	$8, %esp
	cmpl	$0, 8(%ebp)					# base case, compare arg1 to 0
	jne	.L4
	movl	$1, -4(%ebp)
	jmp	.L6
.L4:
	cmpl	$0, 8(%ebp)					# check input validity (arg1 > 0)
	jns	.L7
	movl	$0, -4(%ebp)
	jmp	.L6
.L7:
	movl	8(%ebp), %eax
	subl	$1, %eax					# decrement to prepare for recursive calculation
	movl	%eax, (%esp)
	call	factorial					# recursive call to calculate num -1;
	movl	%eax, %edx
	imull	8(%ebp), %edx				# multiply num by factorial of num -1;
	movl	%edx, -4(%ebp)
	jno .L6
	movl	$0, %eax
.L6:
	movl	-4(%ebp), %eax
	leave
	ret
	.size	factorial, .-factorial
.globl nCr
	.type	nCr, @function
nCr:
	pushl	%ebp						# function entry setup
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	subl	$8, %esp
	movl	8(%ebp), %eax
	cmpl	$13, %eax
	je		.overflow
	cmpl	12(%ebp), %eax
	jne	.L11
	movl	$1, -12(%ebp)
	jmp	.L13
.L11:
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	factorial					# calling factorial for arg1 (n!)
	cmpl	$0, %eax					# checking if factorial returned overflow case
	je .overflow
	movl	%eax, %ebx
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	factorial					# calling factorial for arg2 (r!)
	cmpl	$0, %eax					# checking if factorial returned overflow case
	je .overflow
	movl	%eax, %esi
	movl	12(%ebp), %edx
	movl	8(%ebp), %eax
	subl	%edx, %eax
	movl	%eax, (%esp)
	call	factorial					# calling factorial for arg1-2 (n-r)!
	cmpl	$0, %eax					# checking if factorial returned overflow case
	je .overflow
	imull	%esi, %eax
	movl	%ebx, %edx
	movl	%eax, %ecx
	movl	%edx, %eax
	sarl	$31, %edx
	idivl	%ecx
	movl	%eax, -12(%ebp)
	jo .overflow						# jump to overflow label if overflowed flag
.L13:
	movl	-12(%ebp), %eax
.L14:
	addl	$8, %esp
	popl	%ebx
	popl	%esi
	popl	%ebp
	ret
.overflow:								# overflow process label
	movl $0, %eax						# return value gets set to 0 for overflow
	jmp .L14
	.size	nCr, .-nCr
	.ident	"GCC: (GNU) 4.1.2 20080704 (Red Hat 4.1.2-52)"
	.section	.note.GNU-stack,"",@progbits
