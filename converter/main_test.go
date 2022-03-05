package main

import (
	"strings"
	"testing"

	"github.com/andreyvit/diff"
)

func TestReformatExact(t *testing.T) {
	input := `(function_definition
	body: (block)? @function.inner) @function.outer`
	expected := `(function_definition
	body: (block)? @function.inner) @function.outer`

	actual := reformat(input)
	if a, e := strings.TrimSpace(actual), strings.TrimSpace(expected); a != e {
		t.Errorf("Result not as expected:\n%v", diff.LineDiff(e, a))
	}
}

func TestReformatSimple(t *testing.T) {
	input := `((tuple
"," @_start .
(_) @parameter.inner
)
(#make-range! "parameter.outer" @_start @parameter.inner)
)`
	expected := `((tuple
","  @parameter.outer._start .
(_) @parameter.inner @parameter.outer._end
)

)`

	actual := reformat(input)
	// fmt.Println(strings.ReplaceAll(actual, " ", "."))
	// fmt.Println(strings.ReplaceAll(expected, " ", "."))
	if a, e := strings.TrimSpace(actual), strings.TrimSpace(expected); a != e {
		t.Errorf("Result not as expected:\n%v", diff.LineDiff(e, a))
	}
}

func TestReformatQuotedBracket(t *testing.T) {
	input := `((tuple
"(" .
(_) @parameter.inner
. ","? @_end
)
(#make-range! "parameter.outer" @parameter.inner @_end)
)`
	expected := `((tuple
"(" .
(_) @parameter.inner @parameter.outer._start
. ","?  @parameter.outer._end
)

)`

	actual := reformat(input)
	if a, e := strings.TrimSpace(actual), strings.TrimSpace(expected); a != e {
		t.Errorf("Result not as expected:\n%v", diff.LineDiff(e, a))
	}
}

func TestReformatRoot(t *testing.T) {
	input := `(parameter_list
"," @_start .
(parameter_declaration) @parameter.inner
(#make-range! "parameter.outer" @_start @parameter.inner))`
	expected := `(parameter_list
","  @parameter.outer._start .
(parameter_declaration) @parameter.inner @parameter.outer._end
)`

	actual := reformat(input)
	if a, e := strings.TrimSpace(actual), strings.TrimSpace(expected); a != e {
		t.Errorf("Result not as expected:\n%v", diff.LineDiff(e, a))
	}
}
