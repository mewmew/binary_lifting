extern printf

global main

main:
	; print_str()
	call    print_str
	; return 0
	xor     eax, eax
	ret

s:
	db "foo bar", 10, 0

print_str:
	; printf(s)
	push    s
	call    printf
	add     esp, 4
	ret
