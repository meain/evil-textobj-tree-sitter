package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"regexp"
	"strings"
)

func reprint(col []string, mr []string) {
	if mr != nil {
		ibc := 0
		icol := []string{}
		for _, ie := range col {
			switch ie {
			case "(":
				ibc += 1
				icol = append(icol, ie)
			case ")":
				icol = append(icol, ie)
				ibc -= 1
			case mr[1]:
				if ie != "@_start" && ie != "@_end" {
					icol = append(icol, ie)
				}
				icol = append(icol, " ", "@"+mr[0]+"._start")
			case mr[2]:
				if ie != "@_start" && ie != "@_end" {
					icol = append(icol, ie)
				}
				icol = append(icol, " ", "@"+mr[0]+"._end")
			default:
				icol = append(icol, ie)
			}
		}
		fmt.Print(strings.Join(icol, ""))
	} else {
		fmt.Print(strings.Join(col, ""))
	}
}

func tokenize(input string) []string {
	// I thought of writing a full tokenizer, but lets use a hacky one
	reg := regexp.MustCompile("[^( )]+|[( )]")
	lines := strings.Split(input, "\n")
	split := []string{}
	for _, l := range lines {
		split = append(split, reg.FindAllString(l, -1)...)
		split = append(split, "\n")
	}

	msplit := []string{}
	ins := false
	s := []string{}
	for _, e := range split {
		switch e {
		case "\"":
			if ins {
				msplit = append(msplit, "\""+strings.Join(s, "")+"\"")
				s = []string{}
			}
			ins = !ins
		default:
			if ins {
				s = append(s, e)
			} else {
				msplit = append(msplit, e)
			}
		}
	}
	return msplit
}

func reformat(input string) string {
	split := tokenize(input)
	bc := 0
	i := 0
	var mr []string
	var col []string
	for {
		e := split[i]
		switch e {
		case "(":
			bc += 1
			col = append(col, e)
		case ")":
			bc -= 1
			col = append(col, e)
			if bc == 0 {
				reprint(col, mr)
				mr = nil
				col = []string{}
			}
		case "#make-range!":
			col = col[:len(col)-1]
			bc -= 1
			mr = []string{split[i+2][1 : len(split[i+2])-1], split[i+4], split[i+6]}
			i += 7
		default:
			if bc == 0 {
				fmt.Print(e)
			} else {
				col = append(col, e)
			}
		}

		i++
		if i >= len(split) {
			break
		}
	}

	return input
}

func main() {
	// reformat(`(function_definition
	// body: (block)? @function.inner) @function.outer`)

	// 	reformat(`((tuple
	// 	"," @_start .
	// 	(_) @parameter.inner
	// 	)
	// 	(#make-range! "parameter.outer" @_start @parameter.inner)
	// 	)`)

	// 	reformat(`
	// ((tuple
	//     "(" .
	//     (_) @parameter.inner
	//     . ","? @_end
	//   )
	//   (#make-range! "parameter.outer" @parameter.inner @_end)
	// )
	// `)

	// TODO: see what is with function.outer.start in the source
	content, err := ioutil.ReadFile(os.Args[1]) // the file is inside the local directory
	if err != nil {
		log.Fatalf("unable to read file %s", os.Args[1])
	}
	reformat(string(content))
}
