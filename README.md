# gort

```golang
package main

import (
	"fmt"
	"sort"

	"github.com/kamichidu/go-msort/compare"
	"github.com/lambdalisue/gort"
)

type Iface struct {
	Address string
	Ifname  string
	Ifindex int
}

func main() {
	lessIfaceAsc := func(ifaces []Iface) func(int, int) bool {
		return func(i, j int) bool {
			a := ifaces[i]
			b := ifaces[j]
			return ConcatToLess(
				compare.String(a.Address, b.Address),
				compare.String(a.Ifname, b.Ifname),
				compare.Int(a.Ifindex, b.Ifindex),
			)
		}
	}

	ifaces := []Iface {
		{
			"192.168.1.1",
			"eth1",
			2,
		},
		{
			"192.168.1.1",
			"eth1",
			1,
		},
		{
			"192.168.1.1",
			"eth0",
			1,
		},
		{
			"192.168.1.0",
			"eth0",
			1,
		},
	}

	fmt.Println("Before")
	for _, iface := range ifaces {
		fmt.Println(iface)
	}

	sort.Slice(ifaces, lessIfaceAsc(ifaces))

	fmt.Println("After")
	for _, iface := range ifaces {
		fmt.Println(iface)
	}
	// Output:
	// Before
	// {192.168.1.1 eth1 2}
	// {192.168.1.1 eth1 1}
	// {192.168.1.1 eth0 1}
	// {192.168.1.0 eth0 1}
	// After
	// {192.168.1.0 eth0 1}
	// {192.168.1.1 eth0 1}
	// {192.168.1.1 eth1 1}
	// {192.168.1.1 eth1 2}
}
```

## Acknowledgements

- @kamichidu
- @c000
