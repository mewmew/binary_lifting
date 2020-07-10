global main

main:
	mov     eax, 0
	test    eax, eax
	jz      f.real_branch_target ; <-- jump always taken
  f.fake_branch_target:
	db      0xE9                 ; 0xE9 = JMP opcode
  f.real_branch_target:
	mov     eax, 42
	ret
