package main

import (
	"flag"
	"fmt"
)

var number = flag.Int("n", 10, "the size of the matrix")
var sym = flag.Int("n", 10, "the size of the matrix")

func main() {
	flag.Parse()
	n := number

	fmt.Printf("c Four color problem; a simple encoding\n")


                               
	nbVar := (n * n) * 4
	nbCls := ((n - 1) * (n - 1) * n * n) / 4
    nbColors := 4
    
	if sym {
        nbCls += 2
	}

    clauses := make([]clause, 0,  nbCls)

	fmt.Printf("p cnf %v %v\n", nbVar, nbCls)
	for x := 1; x <= n; x++ {
		for y := 1; y <= n; y++ {
			for dx := x + 1; dx <= n; dx++ {
				for dy := y + 1; dy <= n; dy++ {
				    for col := 1; col <= 4; col++ {

                    a := getVar(Var{x,y,col})
                    b := getVar(Var{x,dy,col})
                    c := getVar(Var{dx,y,col})
                    d := getVar(Var{dx,dy,col})

                    clauses := append(clauses, clause{"four",[]lit{-a,-b,-c,-d} }
				}
			}
		}
	}
		// symmetry breaker
	if sym {
        clauses := append(clauses, clause{"sym",[]lit{getVar(Var{1,1,1})}} )
	}

}

type clause struct {
	desc     string
	literals []int
}

type idGen struct {
	nextId        int
	mapping map[Var]int
}

type Var struct {
	x int
	y int
    c int
}

var gen idGen

func getId(v Var) (id int) {
	id, b := gen.mapping[v]

	if !b {
		gen.nextId++
		id = gen.nextId
		gen.mapping[v] = id
	}

	return id
}


func solve(clauses []clause) {

    printClausesDIMACS(clauses)

}

func printClausesDIMACS(clauses []clause) {

	fmt.Printf("p cnf %v %v\n", len(gen.mapping), len(clauses))

	for _, c := range clauses {
		for _, l := range c.literals {
			fmt.Printf("%v ", l)
		}
		fmt.Printf("0\n")
	}
}

func generateSymbolTable() []string {

	symbolTable := make([]string, len(gen.mapping)+1)

	for key, cnfId := range gen.mapping {
		s := "var" +"("
		s += strconv.Itoa(key.V1)
		s += ","
		s += strconv.Itoa(key.V2)
		s += ")"
		symbolTable[cnfId] = s
	}

	return symbolTable
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

func printDebug(symbolTable []string, clauses []clause) {

	// first print symbol table into file
	fmt.Println("c color(X,Y,C).")

	for i, s := range symbolTable {
		fmt.Println("c", i, "\t:", s)
	}

	stat := make(map[string]int, 0)
    var keys []string

	for _, c := range clauses {

		count, ok := stat[c.desc]
		if !ok {
			stat[c.desc] = 1
            keys = append(keys,c.desc)
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
			if l < 0 {
				fmt.Printf("-%s", symbolTable[-l])

			} else {
				fmt.Printf("+%s", symbolTable[l])
			}
		}
		fmt.Println(".")
	}

	for _,key := range keys {
		fmt.Printf("c %v\t: %v\t%.1f \n", key, stat[key], 100*float64(stat[key])/float64(len(clauses)))
	}
	fmt.Printf("c %v\t: %v\t%.1f \n", "tot", len(clauses), 100.0)
}
