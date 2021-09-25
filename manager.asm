;;;;;;;;;;;;;;;;;;;;;;;;
;BEGIN THE DATA SECTION
;;;;;;;;;;;;;;;;;;;;;;;;

section .data

;;;;;;;;
; System calls

SYS_WRITE			equ		1

;;;;;;;;
; File descriptors

FD_STDIN			equ		0
FD_STDOUT			equ		1

;;;;;;;;
; Strings

PROGRAM_INTRO		db		"This program will reverse your array of integers.",13,10
PROGRAM_INTRO_LEN	equ		$-PROGRAM_INTRO

ENTER_SEQUENCE		db		"Enter a sequence of long integers separated by the enter key (one integer per line). Enter 'q' to quit.",13,10
ENTER_SEQUENCE_LEN	equ		$-ENTER_SEQUENCE

NEXT_INTEGER		db		"Enter the next integer: "
NEXT_INTEGER_LEN	equ		$-NEXT_INTEGER

YOU_ENTERED		db		"You entered: "
YOU_ENTERED_LEN	equ		$-YOU_ENTERED

YOURE_DONE		db		"You've entered nonsense. Assuming you are done!",13,10
YOURE_DONE_LEN		equ		$-YOURE_DONE

NUMBERS_RECEIVED	db		"These numbers were received and placed into the array: ",13,10
NUMBERS_RECEIVED_LEN	equ		$-NUMBERS_RECEIVED

AFTER_REVERSE		db		"After the reverse function, these are the numbers of the array in their new order: ",13,10
AFTER_REVERSE_LEN	equ		$-AFTER_REVERSE

;"You entered _ total numbers and their mean is _.

TOTAL_ENTERED		db		"You entered "
TOTAL_ENTERED_LEN 	equ		$-TOTAL_ENTERED

THEIR_MEAN_IS		db		" total numbers and their mean is "
THEIR_MEAN_IS_LEN	equ		$-THEIR_MEAN_IS

;"The mean will now be returned to the main function
RETURNED_MEAN		db		"The mean will now be returned to the main function.",13,10
RETURNED_MEAN_LEN	equ		$-RETURNED_MEAN


;;;;;;;;;;;;;;;;;;;;;;;;
;BEGIN THE TEXT SECTION
;;;;;;;;;;;;;;;;;;;;;;;;

section .text

global manager
manager:


;"This program will reverse your array of integers."

	mov rax, SYS_WRITE			
	mov rdi, FD_STDOUT			
	mov rsi, PROGRAM_INTRO	
	mov rdx, PROGRAM_INTRO_LEN
	syscall
	
;"Enter a sequence of long integers separated by the enter key (one integer per line). Enter 'q' to quit."

	mov rax, SYS_WRITE
	mov rdi, FD_STDOUT
	mov rsi, ENTER_SEQUENCE
	mov rdx, ENTER_SEQUENCE_LEN
	syscall



