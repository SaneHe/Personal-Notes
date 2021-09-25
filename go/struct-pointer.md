```go
package main

import "fmt"

type interNonPointer interface {
	NonPointer()
}

type interPointer interface {
	Pointer()
}

type S struct {
	Name string
}

func (s S) NonPointer() {
	fmt.Printf("结构体变量 Name 值为: %v \n", s.Name)
}

func (s *S) Pointer() {
	fmt.Printf("结构体指针 Name 值为: %v \n", s.Name)
}

func main() {

	// 结构体变量
	var s S
	s.Name = "sane s"
	fmt.Printf("结构体变量： 值为- %v 类型为- %T \n", s, s) // 结构体变量： 值为- {sane s} 类型为- main.S
	//fmt.Println(s == nil) // invalid operation: s == nil (mismatched types S and nil)
	s.NonPointer() // 结构体变量 Name 值为: sane s
	s.Pointer()    // 	结构体指针 Name 值为: sane s

	// 结构体指针 返回的值是指向该类型新分配的零值的指针
	spv := new(S)
	//spv.Name = "sane spv" // 此赋值没有影响
	fmt.Printf("结构体指针 (new) ： 值为- %v 类型为- %T \n", spv, spv) // 结构体指针 (new) ： 值为- &{} 类型为- *main.S
	fmt.Printf("结构体指针 (new) ： spv == nil 为: %v \n", spv == nil) // 结构体指针 (new) ： spv == nil 为: false
	spv.NonPointer() // 结构体变量 Name 值为:
	spv.Pointer() // 结构体变量 Name 值为:

	// 结构体指针
	var sp *S
	//sp = &S{Name: "sane sp"} // 缺少赋值会触发 panic
	fmt.Printf("结构体指针 (var) ： 值为- %v 类型为- %T \n", sp, sp) //结构体指针 (var) ： 值为- <nil> 类型为- *main.S
	fmt.Printf("结构体指针 (var) ： sp == nil 为: %v \n", sp == nil) // 结构体指针 (var) ： sp == nil 为: true
	sp.NonPointer()
	sp.Pointer()

	//var i interNonPointer = S{Name: "sane interface"}
	//fmt.Printf("结构体指针 (interface) ： 值为- %v 类型为- %T \n", i, i)
	//i.NonPointer()
	//i.Pointer()
}
```