EMACS ?= emacs
CASK ?= cask

LOADPATH = -L .
TESTPATH = -L ./test

ELPA_DIR = \
	.cask/$(shell $(EMACS) -Q --batch --eval '(princ emacs-version)')/elpa

compile:
	$(CASK) exec $(EMACS) -Q -batch	\
	-L . \
	-f batch-byte-compile *.el

lint:
	$(CASK) exec $(EMACS) -Q -batch	\
	--eval "(require 'package)"	\
	--eval "(push '(\"melpa\" . \"http://melpa.org/packages/\") package-archives)" \
	--eval "(package-initialize)" \
	--eval "(package-refresh-contents)" \
	-l package-lint.el \
	-f package-lint-batch-and-exit evil-textobj-tree-sitter.el

checkdoc:
	$(CASK) exec $(EMACS) -Q -batch	\
	--eval '(find-file "evil-textobj-tree-sitter.el")' \
	--eval '(setq checkdoc-create-error-function (lambda (text &rest _) (message "%s" text) (kill-emacs 1)))' \
	-l checkdoc.el \
	-f checkdoc

test: elpa
	$(CASK) exec $(EMACS) -Q -batch $(LOADPATH) $(TESTPATH) \
    -l evil-textobj-tree-sitter-test.el -f ert-run-tests-batch-and-exit

elpa: $(ELPA_DIR)
$(ELPA_DIR): Cask
	$(CASK) install
	mkdir -p $(ELPA_DIR)
	touch $@

.PHONY: compile lint checkdoc test elpa
