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
	--eval "(advice-add 'package-lint--check-eval-after-load :around 'ignore)" \
	--eval "(advice-add 'package-lint--check-version-regexp-list :around 'ignore)" \
	--eval "(advice-add 'package-lint--check-symbol-separators :around 'ignore)" \
	--eval "(advice-add 'package-lint--check-defs-prefix :around 'ignore)" \
	--eval "(advice-add 'package-lint--check-provide-form :around 'ignore)" \
	-f package-lint-batch-and-exit *.el

test: elpa
	$(CASK) exec $(EMACS) -Q -batch $(LOADPATH) $(TESTPATH) \
-l evil-textobj-treesitter-test.el -f ert-run-tests-batch-and-exit

.PHONY: compile lint test
