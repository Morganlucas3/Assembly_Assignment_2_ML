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

;;;;;;;
; Local variable for the array of integers 

LOCAL_VARIABLE_COUNT		equ		100

;;;;;
; Inputted integers

ENTERED_INT		dq		0

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

;;;;;;;;
; new line 

;CRLF			db		13,10
;CRLF_LEN		equ		$-CRLF


;;;;;;;;;;;;;;;;;;;;;;;;
;BEGIN THE TEXT SECTION
;;;;;;;;;;;;;;;;;;;;;;;;

section .text

;;;;; Externals
extern libPuhfessorP_printSignedInteger64
extern libPuhfessorP_inputSignedInteger64
extern main
extern display_array
extern reverse


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
	
;;;;;;;;
; allocates an array of integers as a local variable (on the stack)

; pushing to the stack
	
	push rbp 		; rbp = base pointer
	push rbx		; rbx = ptr to last int on the stack
	push r12		; r12 = pointer to the beginning of the array
	push r13		; r13 = current value to write to 
	push r14		; r14 = current index
	
	
	mov rbp, rsp		; moves the stack pointer into the base pointer 
				; base pointer = where the stack started
				
	mov r10, LOCAL_VARIABLE_COUNT 	; r10 = temp register
						; dont need to push/pop because its not callee saved	
						; moves the integer count into r10
						; r10 = n_integers 
						
	imul r10, 8				; each 64 bit integer = 8 bytes 
						; r10 = n_integers * 8 = how many bytes we need for our integers
						
	sub rsp, r10				; allocates our integers onto the stack by moving the stack pointer down
	
	mov r12, rsp				; r12 = pointer to the first int

;;;;;;;;;
; loop area 

	mov r14, 0			; r14 = current index, starting at 0 
					; do this before loop so it only is set to 0 once
					; counter
 manager_loop:
 
; "Enter the next integer: "

	mov rax, SYS_WRITE			
	mov rdi, FD_STDOUT			
	mov rsi, NEXT_INTEGER	
	mov rdx, NEXT_INTEGER_LEN
	syscall
			
; User input (receiving an integer)

	call libPuhfessorP_inputSignedInteger64
	mov [ENTERED_INT], rax
	mov rdi, [ENTERED_INT]
	
	
; right here need to say "if not valid user input, jmp to done"
 
 
 

	
; "You entered: "

	mov rax, SYS_WRITE			
	mov rdi, FD_STDOUT			
	mov rsi, YOU_ENTERED	
	mov rdx, YOU_ENTERED_LEN
	syscall

; print user input

	mov rdi, [ENTERED_INT]
	call libPuhfessorP_printSignedInteger64
	;;call manager_crlf
	
	
; fill array with user input

	mov r13, [ENTERED_INT]		; r13 = current value to write, filled with first user input

; adjust r13 and r14 so we can write to the next spot and our index increases
	
	mov [r12 + (r14 * 8)], r13	; filling array with the user input 
	
	inc r14			; increase the index 

; do it again, until user input is not valid 

	jmp manager_loop			; jump to the beginning of loop:
	


 loop_done:

 ; this is where the loop will end and move on when the user input is bad 
 ; "You've entered nonsense. Assuming you are done!"
 
 	mov rax, SYS_WRITE			
	mov rdi, FD_STDOUT			
	mov rsi, YOURE_DONE	
	mov rdx, YOURE_DONE_LEN
	syscall
 
 ;;;;;;;
 ;"These numbers were received and placed into the array"
 
	mov rax, SYS_WRITE			
	mov rdi, FD_STDOUT			
	mov rsi, NUMBERS_RECEIVED	
	mov rdx, NUMBERS_RECEIVED_LEN
	syscall
	
 ; this is where i need to call display_array.asm
 
 	call display_array
 
 
 ;;;;;;;;
 ;"After the reverse function, these are the numbers of the array in their new order: "
 
 	mov rax, SYS_WRITE			
	mov rdi, FD_STDOUT			
	mov rsi, AFTER_REVERSE	
	mov rdx, AFTER_REVERSE_LEN
	syscall

; this is where i need to call reverse.cpp




;;;;;;;;;
; mean

;"You entered "

	mov rax, SYS_WRITE			
	mov rdi, FD_STDOUT			
	mov rsi, TOTAL_ENTERED	
	mov rdx, TOTAL_ENTERED_LEN
	syscall
	
; this is the mount of numbers, probably has to do with r14 since im using that as a counter 




; " total numbers and their mean is "

	mov rax, SYS_WRITE			
	mov rdi, FD_STDOUT			
	mov rsi, THEIR_MEAN_IS	
	mov rdx, THEIR_MEAN_IS_LEN
	syscall
	

; heres where i need to calculate the mean 





; "The mean will no be returned to the main function."

	mov rax, SYS_WRITE			
	mov rdi, FD_STDOUT			
	mov rsi, RETURNED_MEAN
	mov rdx, RETURNED_MEAN_LEN
	syscall
	
;;;;;;
;CRLF

 ;manager_crlf:
 
 	;mov rax, SYS_WRITE
	;mov rdi, FD_STDOUT
	;mov rsi, CRLF
	;mov rdx, CRLF_LEN
	;syscall	




















