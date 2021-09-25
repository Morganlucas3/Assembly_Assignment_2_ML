
; TODO: Your code

;;;;;;;;;;;;;;;;;;;;;;;;
;BEGIN THE DATA SECTION
;;;;;;;;;;;;;;;;;;;;;;;;

section .data






;;;;;;;;;;;;;;;;;;;;;;;;
;BEGIN THE TEXT SECTION
;;;;;;;;;;;;;;;;;;;;;;;;

section .text

;;;;; Externals
extern libPuhfessorP_printSignedInteger64
extern libPuhfessorP_inputSignedInteger64
extern manager

global display_array
display_array:


push r15						; r15 = running pointer


mov r15, r12						; r15 = r12 = running pointer = beginning of the array
lea rbx, [r12 + (LOCAL_VARIABLE_COUNT * 8) - 1]	





display_array_print_loop:

	cmp r15, rbx					; compares our running pointer with the pointer to the last int 
	jge display_array_done				; finish printing once the running ptr is greater than the last int
	
	mov rdi, [r15]					; [r15] grabs the value of where its currently pointing
							; mov the value into rdi so we can print
							
	call libPuhfessorP_printSignedInteger64	; print the value 
	
	;now we need to move the position of r15 and repeat
	
	inc r15
	inc r15
	inc r15
	inc r15
	inc r15
	inc r15
	inc r15
	inc r15					; moves the running pointer 8 bytes to the next integer position
	
	jmp display_array_print_loop			; do it again 
	

display_array_done:

	
	pop r15
	
	mov rax, 0
	
	ret	






















