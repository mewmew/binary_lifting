extern printf
extern exit

global main

main:
	; int x = f(1)
	mov     ecx, 1
	call    f
	; return x
	ret

; int __fastcall f(int x)
f:
	; switch (x)
	cmp     ecx, 0
	jl      f.default
	cmp     ecx, 2
	jg      f.default
	shl     ecx, 2
	jmp     DWORD[f.jump_table + ecx]

  .jump_table: ; <- jump table in code segment
	dd f.case_0
	dd f.case_1
	dd f.case_2

	; case 0:
  .case_0:
	mov    eax, 12
	ret
	; case 1:
  .case_1:
	mov    eax, 42
	ret
	; case 2:
  .case_2:
	mov    eax, 30
	ret
	; default:
  .default:
	mov    eax, 0
	ret
