SRC_ASM=$(wildcard *.asm)
OBJ=$(SRC_ASM:.asm=.o)
BIN=$(OBJ:.o=)

all: ${BIN} ${OBJ}

%: %.o
	clang -m32 -o $@ $<

data_in_code.o: data_in_code.asm
	nasm -f elf32 -o $@ $<
	strip -N 's' -N 'print_str' $@

jump_table_in_code.o: jump_table_in_code.asm
	nasm -f elf32 -o $@ $<
	strip -N 'f.jump_table' -N 'f.case_0' -N 'f.case_1' -N 'f.case_2' -N 'f.default' $@

fake_branch_target.o: fake_branch_target.asm
	nasm -f elf32 -o $@ $<
	strip -N 'f.fake_branch_target' -N 'f.real_branch_target' $@

%.o: %.asm
	nasm -f elf32 -o $@ $<

clean:
	$(RM) -v ${BIN}
	$(RM) -v ${OBJ}
