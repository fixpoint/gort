package gort

// Concat concats multiple condition (-1, 0, 1) to a first non zero condition
func Concat(conditions ...int) int {
	for _, condition := range conditions {
		if condition != 0 {
			return condition
		}
	}
	return 0
}

// ConcatToLess invokes Concat and return False if a first non zero condition is -1
func ConcatToLess(conditions ...int) bool {
	return Concat(conditions...) < 0
}

// ConcatLazy concats multiple expression (a function which return condition) to a first non zero condition
func ConcatLazy(expressions ...func() int) int {
	for _, expression := range expressions {
		condition := expression()
		if condition != 0 {
			return condition
		}
	}
	return 0
}

// ConcatToLessLazy invokes ConcatLazy and return False if a first non zero condition is -1
func ConcatToLessLazy(expressions ...func() int) bool {
	return ConcatLazy(expressions...) < 0
}
