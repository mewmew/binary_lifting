all: binary_lifting_proposal.pdf

%.pdf: %.tex
	latexrun --latex-cmd=xelatex -o $@ $<
	# Compile again (to fix section progress bar).
	latexrun --latex-cmd=xelatex -o $@ $<

.PHONY: clean inc

clean:
	$(RM) -v -rf latex.out
	$(RM) -v binary_lifting_proposal.pdf
