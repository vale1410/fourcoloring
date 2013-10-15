package main

import (
	"fmt"
    "flag"
)

var number = flag.Int("n", 10, "the size of the matrix")

func main() {
    flag.Parse()
    n := *number

	fmt.Printf("c Four color problem; a logarithmic encoding\n")

    nbVar := (n*n)/2
    nbCls := ((n*n*n*n-2*n*n*n+n*n)/4)+2
	fmt.Printf("p cnf %v %v\n",nbVar,nbCls)
    for x := 1;x<=n;x++ {
        for y := 1;y<=n;y++ {
            for dx := x+1;dx<=n;dx++ {
                for dy := y+1;dy<=n;dy++ {
                   printC(x,y,n)
                   printC(x,dy,n)
                   printC(dx,y,n)
                   printC(dx,dy,n)
                   fmt.Print("0\n")
                }
            }
        }
    }
    // symmetry breaker
	fmt.Printf("%v 0\n",(n*n)/4)
	fmt.Printf("%v 0\n",(n*n)/2)
}

func printC(x,y,n int) {

    s := (x > n/2)
    p := (y > n/2)

    for x > n/2 || y > n/2 {
        x,y = y,n+1-x
    }
    tp(s)
    fmt.Printf("%v ",(x-1)*n/2+y)
    tp(p)
    fmt.Printf("%v ",(x-1)*n/2+y+(n*n)/4)
}

func tp(s bool) {
    if (!s) {
        fmt.Print("-");
    }
}
