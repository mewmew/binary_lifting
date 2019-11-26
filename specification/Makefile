all: binary_lifting_specification.pdf

%.pdf: %.tex
	latexrun --latex-cmd=xelatex -o $@ $<
	# Compile again, because LaTeX.
	latexrun --latex-cmd=xelatex -o $@ $<

.PHONY: clean inc

clean:
	$(RM) -v -rf latex.out
	$(RM) -v binary_lifting_specification.pdf
