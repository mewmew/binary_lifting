all: binary_lifting.pdf chap_lit_rev.pdf

%.pdf: %.tex
	latexrun --latex-cmd=xelatex -o $@ $<
	# Re-run command, because LaTeX...
	latexrun --latex-cmd=xelatex -o $@ $<

lit_rev: chap_lit_rev.pdf

.PHONY: all clean

clean:
	$(RM) -r latex.out binary_lifting.pdf chap_lit_rev.pdf
