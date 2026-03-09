compile:
	eask compile

lint:
	eask lint package evil-textobj-tree-sitter.el

checkdoc:
	eask lint checkdoc

test: install-deps
	eask test ert evil-textobj-tree-sitter-test.el

test-queries: install-deps
	eask test ert evil-textobj-tree-sitter-query-test.el

install-deps:
	eask install-deps --dev

.PHONY: compile lint checkdoc test test-queries install-deps
