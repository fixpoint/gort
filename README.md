# 🐐 gort
[![Build Status](https://travis-ci.com/lambdalisue/gort.svg?branch=master)](https://travis-ci.com/lambdalisue/gort)
[![Go Report Card](https://goreportcard.com/badge/github.com/lambdalisue/gort)](https://goreportcard.com/report/github.com/lambdalisue/gort) 
[![GoDoc](https://godoc.org/github.com/lambdalisue/gort?status.svg)](https://godoc.org/github.com/lambdalisue/gort)
[![license](https://img.shields.io/badge/license-MIT-4183c4.svg)](https://github.com/lambdalisue/gort/blob/master/LICENSE)

**gort** is a collection of utility functions to help writing slice sort.

## Installation

```
$ go get github.com/lambdalisue/gort
```

## Usage

Use `func ConcatToLess(conditions ...int) bool` to concat multiple conditions (-1 means less, 0 means equal, and 1 means great) to create a function for `sort.Slice()` like

```
package main

import (
	"fmt"
	"sort"
	"strings"

	"github.com/lambdalisue/gort"
)

func main() {
	ns := []struct{
		a string
		b int
	}{
		{ a: "world", b: 1 },
		{ a: "hello", b: 3 },
		{ a: "hello", b: 2 },
		{ a: "world", b: 0 },
	}
	sort.Slice(ns, func(i, j int) bool {
		a := ns[i]
		b := ns[j]
		return gort.ConcatToLess(
			compareString(a.a, b.a),    // First condition
			compareInt(a.b, b.b),       // Second concition
		)
	})
	fmt.Println(ns)
	// Output:
	// [{hello 2} {hello 3} {world 0} {world 1}]
}

func compareString(a, b string) int {
	return strings.Compare(a, b)
}

func compareInt(a, b int) int {
	switch {
	case a < b:
		return -1
	case a > b:
		return 1
	default:
		return 0
	}
}
```

Or with [kamichidu/go-msort/comapre](https://godoc.org/github.com/kamichidu/go-msort/compare):

```
package main

import (
	"fmt"
	"sort"
	"strings"

	"github.com/lambdalisue/gort"
	"github.com/kamichidu/go-msort/compare"
)

func main() {
	ns := []struct{
		a string
		b int
	}{
		{ a: "world", b: 1 },
		{ a: "hello", b: 3 },
		{ a: "hello", b: 2 },
		{ a: "world", b: 0 },
	}
	sort.Slice(ns, func(i, j int) bool {
		a := ns[i]
		b := ns[j]
		return gort.ConcatToLess(
			compare.String(a.a, b.a),
			compare.Int(a.b, b.b),
		)
	})
	fmt.Println(ns)
	// Output:
	// [{hello 2} {hello 3} {world 0} {world 1}]
}
```

## Authors

- lambdalisue
- c000
