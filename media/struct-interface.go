package main

type testInterface interface {
	test()
}

type sane struct {
}

func (s sane) test() {

}

type kang struct {
}

func (k *kang) test() {

}

func main() {

	// 接口变量
	//var s testInterface
	//s.test() // invalid memory address or nil pointer dereference

	// 接口指针 声明
	//var ss *testInterface
	//ss.test() // struct-interface.go:29:4: ss.test undefined (type *testInterface is pointer to interface, not interface)

	// 结构体变量
	var ssv testInterface = sane{}
	ssv.test()

	// 接口指针初始化
	var ssp testInterface = new(sane)
	ssp.test()

	// 接口变量
	//var k testInterface
	//k.test() // invalid memory address or nil pointer dereference

	// 接口指针 声明
	//var kk *testInterface
	//kk.test() // struct-interface.go:41:4: kk.test undefined (type *testInterface is pointer to interface, not interface)

	// 结构体变量
	var kkv testInterface = kang{} // cannot use kang{} (type kang) as type testInterface in assignment: kang does not implement testInterface (test method has pointer receiver)
	kkv.test()

	// 接口指针
	var kkp testInterface = new(kang)
	kkp.test()
}
