package main

import (
	"bufio"
	"flag"
	"fmt"
	"math"
	"os"
	"strconv"
)

var number = flag.Int("n", 10, "Size of the grind. NOTICE encoding 3 can only do even numbers!")
var sym = flag.Bool("sym", false, "Adding symmetry breaking constraint.")
var eType = flag.Int("e", 1, "Type of Encodings: 1 simple, 2 mono color smart, 3 very smart.")
var ver = flag.Bool("ver", false, "Prints version info and license.")

type clause struct {
	desc     string
	literals []Lit
}

type Lit struct {
	parity   bool
	variable Variable
}

type Encoding struct {
	nextId int

	Mapping map[Variable]int
	Symbols []string

	Clauses []clause
}

type Variable struct {
	x int
	y int
	c int
}

func NewEncoding() (encoding Encoding) {
	encoding.nextId = 0
	encoding.Mapping = make(map[Variable]int, 0)
	encoding.Clauses = make([]clause, 0)
	return
}

func (encoding *Encoding) getCNFId(l Lit) (id int) {
	v := l.variable
	id, b := encoding.Mapping[v]
	if !b {
		encoding.nextId++
		id = encoding.nextId
		encoding.Mapping[v] = id
	}
	return id
}

func (encoding *Encoding) AddClause(c clause) {
	encoding.Clauses = append(encoding.Clauses, c)
}

func main() {
	flag.Parse()

	encoding := NewEncoding()

	if *ver {
		fmt.Println(`CNF Decoder for Rectangle Free Coloring Problem
Version tag: 0.1
For infos about flags use -help
Copyright (C) NICTA and Valentin Mayer-Eichberger
License GPLv2+: GNU GPL version 2 or later <http://gnu.org/licenses/gpl.html>
There is NO WARRANTY, to the extent permitted by law.`)
		return
	}

	fmt.Println("c Rectangle Free Coloring Problem, encoding", *eType, "size", *number)

	switch *eType {
	case 1:
		encoding.Encodingencode1(*number)
		encoding.GenerateIds()
		encoding.PrintDIMACS()
	case 2:
		encoding.Encodingencode2(*number)
		encoding.GenerateIds()
		encoding.PrintDIMACS()
	case 3:
		if *number%2 == 0 {
			encoding.Encodingencode3(*number)
		} else {
			fmt.Println("Encoding 3 can only do even nunbers, will be fixed in next version")
		}
	}
}

func (encoding Encoding) ClauseS(c clause) string {
	var s string
	for _, l := range c.literals {
		s += encoding.LitS(l)
	}
	return s + "0\n"
}

func (encoding *Encoding) Encodingencode1(n int) {

	nbColors := 4

	encoding.Clauses = make([]clause, 0)

	for x := 1; x <= n; x++ {
		for y := 1; y <= n; y++ {
			for dx := x + 1; dx <= n; dx++ {
				for dy := y + 1; dy <= n; dy++ {
					for col := 1; col <= nbColors; col++ {

						a := Lit{false, Variable{x, y, col}}
						b := Lit{false, Variable{x, dy, col}}
						c := Lit{false, Variable{dx, y, col}}
						d := Lit{false, Variable{dx, dy, col}}

						encoding.AddClause(clause{"rect", []Lit{a, b, c, d}})
					}
				}
			}
		}
	}

	for x := 1; x <= n; x++ {
		for y := 1; y <= n; y++ {
			lits := make([]Lit, nbColors)
			for col := 1; col <= nbColors; col++ {
				lits[col-1] = Lit{true, Variable{x, y, col}}
			}
			encoding.AddClause(clause{"min", lits})
		}
	}
	// symmetry breaker
	if *sym {
		a := Lit{true, Variable{1, 1, 1}}
		encoding.AddClause(clause{"sym", []Lit{a}})
	}
}

func roundUp(in float64) int {
	if in-math.Floor(in) > 0 {
		return int(math.Floor(in) + 1)
	} else {
		return int(math.Floor(in))
	}
}

// Do the clique encoding;
// @FutureWork; more will follow!
func (encoding *Encoding) AtMostOne(tag string, variables []Variable) {

	for i, x := range variables {
		for j := i + 1; j < len(variables); j++ {
			encoding.AddClause(clause{tag,
				[]Lit{Lit{false, x},
					Lit{false, variables[j]}}})
		}
	}
}

func (encoding *Encoding) AtLeastOne(tag string, variables []Variable) {

	lits := make([]Lit, len(variables))

	for i, _ := range lits {
		lits[i] = Lit{true, variables[i]}
	}
	encoding.AddClause(clause{tag, lits})
}

func (encoding *Encoding) ExactlyOne(tag string, variables []Variable) {
	encoding.AtLeastOne(tag, variables)
	encoding.AtMostOne(tag, variables)
}

func (encoding *Encoding) Encodingencode2(n int) {

	encoding.Clauses = make([]clause, 0)

	r := roundUp(float64(n) / 2)
	col := 1 //monocolor encoding

	for x1 := 1; x1 <= r; x1++ {
		for y1 := 1; y1 <= r; y1++ {
			x2, y2 := y1, n+1-x1
			x3, y3 := y2, n+1-x2
			x4, y4 := y3, n+1-x3
			fourCycle := []Variable{Variable{x1, y1, col},
				Variable{x2, y2, col},
				Variable{x3, y3, col},
				Variable{x4, y4, col}}
			if x2-x1 == 0 && y2-y1 == 0 {
				encoding.AddClause(clause{"sym", []Lit{Lit{true, fourCycle[0]}}})
			} else {
				encoding.ExactlyOne("ex1", fourCycle)
			}
		}
	}

	for x := 1; x <= n; x++ {
		for y := 1; y <= n; y++ {
			for dx := x + 1; dx <= n; dx++ {
				for dy := y + 1; dy <= n; dy++ {

					a := Lit{false, Variable{x, y, col}}
					b := Lit{false, Variable{x, dy, col}}
					c := Lit{false, Variable{dx, y, col}}
					d := Lit{false, Variable{dx, dy, col}}

					encoding.AddClause(clause{"rect", []Lit{a, b, c, d}})
				}
			}
		}
	}

	// symmetry breaker
	if *sym {
		a := Lit{true, Variable{1, 1, 1}}
		encoding.AddClause(clause{"sym", []Lit{a}})
	}
}

func (encoding *Encoding) Encodingencode3(n int) {

	nbVar := (n * n) / 2
	nbCls := ((n*n*n*n - 2*n*n*n + n*n) / 4)

	if *sym {
		nbCls += 2
	}

	fmt.Printf("p cnf %v %v\n", nbVar, nbCls)
	for x := 1; x <= n; x++ {
		for y := 1; y <= n; y++ {
			for dx := x + 1; dx <= n; dx++ {
				for dy := y + 1; dy <= n; dy++ {
					printC(x, y, n)
					printC(x, dy, n)
					printC(dx, y, n)
					printC(dx, dy, n)
					fmt.Print("0\n")
				}
			}
		}
	}
	// symmetry breaker
	if *sym {
		fmt.Printf("%v 0\n", (n*n)/4)
		fmt.Printf("%v 0\n", (n*n)/2)
	}
}

func printC(x, y, n int) {

	s := (x > n/2)
	p := (y > n/2)

	for x > n/2 || y > n/2 {
		x, y = y, n+1-x
	}
	tp(s)
	fmt.Printf("%v ", (x-1)*n/2+y)
	tp(p)
	fmt.Printf("%v ", (x-1)*n/2+y+(n*n)/4)
}

func tp(s bool) {
	if !s {
		fmt.Print("-")
	}
}

func (encoding *Encoding) LitS(l Lit) string {
	var p string
	if l.parity {
		p = ""
	} else {
		p = "-"
	}
	return fmt.Sprintf("%v%v ", p, encoding.getCNFId(l))
}

func (encoding *Encoding) Solve() {
}

func (encoding *Encoding) PrintDIMACS() {

	fmt.Printf("p cnf %v %v\n", len(encoding.Mapping), len(encoding.Clauses))

	for _, c := range encoding.Clauses {
		fmt.Printf(encoding.ClauseS(c))
	}
}

func (encoding *Encoding) GenerateIds() {

	symbolTable := make(map[int]string, len(encoding.Clauses)+1)

	for _, c := range encoding.Clauses {
		for _, l := range c.literals {
			if _, ok := symbolTable[encoding.getCNFId(l)]; !ok {
				s := "color" + "("
				s += strconv.Itoa(l.variable.x)
				s += ","
				s += strconv.Itoa(l.variable.y)
				s += ","
				s += strconv.Itoa(l.variable.c)
				s += ")"
				symbolTable[encoding.getCNFId(l)] = s
			}
		}
	}

	encoding.Symbols = make([]string, len(symbolTable)+1)

	for key, value := range symbolTable {
		encoding.Symbols[key] = value
	}
	//	for i, x := range encoding.Symbols {
	//		fmt.Println("c", i, x)
	//	}
}

func printSymbolTable(symbolTable []string, filename string) {

	symbolFile, err := os.Create(filename)
	if err != nil {
		panic(err)
	}
	// close fo on exit and check for its returned error
	defer func() {
		if err := symbolFile.Close(); err != nil {
			panic(err)
		}
	}()

	// make a write buffer
	w := bufio.NewWriter(symbolFile)

	for i, s := range symbolTable {
		// write a chunk
		if _, err := w.Write([]byte(fmt.Sprintln(i, "\t:", s))); err != nil {
			panic(err)
		}
	}

	if err = w.Flush(); err != nil {
		panic(err)
	}
}

func (encoding *Encoding) printDebug() {

	// first print symbol table into file
	fmt.Println("c color(X,Y,C).")

	for i, s := range encoding.Symbols {
		fmt.Println("c", i, "\t:", s)
	}

	stat := make(map[string]int, 0)
	var keys []string

	for _, c := range encoding.Clauses {

		count, ok := stat[c.desc]
		if !ok {
			stat[c.desc] = 1
			keys = append(keys, c.desc)
		} else {
			stat[c.desc] = count + 1
		}

		fmt.Printf("c %s ", c.desc)
		first := true
		for _, l := range c.literals {
			if !first {
				fmt.Printf(",")
			}
			first = false
			if l.parity {
				fmt.Printf("+%s")
			} else {
				fmt.Printf("-%s")
			}
			fmt.Printf(encoding.Symbols[encoding.getCNFId(l)])
		}
		fmt.Println(".")
	}

	for _, key := range keys {

		fmt.Printf("c %v\t: %v\t%.1f \n", key, stat[key], 100*float64(stat[key])/float64(len(encoding.Clauses)))
	}

	fmt.Printf("c %v\t: %v\t%.1f \n", "tot", len(encoding.Clauses), 100.0)
}
