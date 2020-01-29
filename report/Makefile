all: binary_lifting.pdf

%.pdf: %.tex
	latexrun --latex-cmd=xelatex -o $@ $<
	# Re-run command, because LaTeX...
	latexrun --latex-cmd=xelatex -o $@ $<

.PHONY: all clean

clean:
	$(RM) -r latex.out binary_lifting.pdf
