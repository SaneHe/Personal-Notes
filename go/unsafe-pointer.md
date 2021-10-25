## `uintptr`、`unsafe.Pointer`、` *T (普通指针)`

- `unsafe.Pointer` 是通用的指针类型, 可以转换成不同类型指针; `不参与指针运算`、也`不可以` `读取内存存储的值`(需转换到某一类型的普通指针)
- `*T` 普通类型指针, 用于传递对象地址, `不可以` 进行 `指针运算`
- `uintptr` 用于指针运算, `GC` 不把 `uintptr` 当指针, `uintptr` 无法持有对象, `uintptr` 类型的目标会被回收
- `unsafe.Pointer` 可以和 `普通指针` 进行相互转换
- `unsafe.Pointer` 可以和 `uintptr` 进行相互转换
- `unsafe.Pointer` 是桥梁

## `unsafe 包`

```golang
type ArbitraryType int
type Pointer *ArbitraryType
func Sizeof(x ArbitraryType) uintptr
func Offsetof(x ArbitraryType) uintptr
func Alignof(x ArbitraryType) uintptr
```

- `ArbitraryType`  `int` 的别名, 在 `Go` 中对 `ArbitraryType` 赋予特殊的意义; 代表一个任意Go表达式类型
- `Pointer`  `int` `指针类型` 的别名，在 `Go` 中可以把 `Pointer` 类型，理解成 `任何指针的父类型`
- `Sizeof(x ArbitrayType)` 方法主要作用是用返回类型x所占据的字节数, 但并不包含x所指向的内容的大小, 与C语言标准库中的 Sizeof()方法功能一样, 比如在32位机器上, 一个指针返回大小就是4字节
- `Offsetof(x ArbitraryType)` 方法主要作用是返回结构体成员在内存中的位置离结构体起始处(结构体的第一个字段的偏移量都是0)的字节数，即偏移量，我们在注释中看一看到其入参必须是一个结构体，其返回值是一个常量
- `Alignof(x ArbitratyType)` 的主要作用是返回一个类型的对齐值，也可以叫做对齐系数或者对齐倍数。对齐值是一个和内存对齐有关的值，合理的内存对齐可以提高内存读写的性能。一般对齐值是2^n，最大不会超过8(受内存对齐影响).获取对齐值还可以使用反射包的函数，也就是说：unsafe.Alignof(x)等价于reflect.TypeOf(x).Align()。对于任意类型的变量x，unsafe.Alignof(x)至少为1。对于struct结构体类型的变量x，计算x每一个字段f的unsafe.Alignof(x，f)，unsafe.Alignof(x)等于其中的最大值。对于array数组类型的变量x，unsafe.Alignof(x)等于构成数组的元素类型的对齐倍数。没有任何字段的空struct{}和没有任何元素的array占据的内存空间大小为0，不同大小为0的变量可能指向同一块地址

## 使用

- ### 转换
  
    ```golang
    func main() {
        number := 5
        pointer := &number
        fmt.Printf("number:addr:%p, value:%d\n", pointer, *pointer)

        float32Number := (*int64)(unsafe.Pointer(pointer))
        *float32Number = *float32Number + 3
        fmt.Printf("float64:addr:%p, value:%d\n", float32Number, *float32Number)

        sane := "sane 呵呵呵"
        b := []byte(sane)

        fmt.Println(*(*string)(unsafe.Pointer(&b)))
    }


    // result
    go run unsafe.go 
    number:addr:0xc00001a0a8, value:5
    float64:addr:0xc00001a0a8, value:8
    sane 呵呵呵
    ```

- ### 修改

```golang


type Sane struct {
	Position string
	Age      int
	Gender   bool
}

func main() {
	var s *Sane = new(Sane)
	fmt.Println(s.Position, s.Age, s.Gender)

	position := unsafe.Pointer(uintptr(unsafe.Pointer(s)) + unsafe.Offsetof(s.Position))
	*((*string)(position)) = "shanghai"

	fmt.Println(s.Position, s.Age, s.Gender)
}

// result 
go run unsafe.go
 0 false
shanghai 0 false
```

> uintptr(unsafe.Pointer(s)) 获取了 s 的指针起始值
unsafe.Offsetof(s.Position) 获取 position 变量的偏移量
两个相加就得到了 position 的地址值, 将通用指针 Pointer 转换成具体指针 ((*string)(position)), 通过 * 符号取值, 然后赋值; *((*string)(position)) 相当于把 (*string)(position) 转换成 string 了, 最后对变量重新赋值成 shanghai , 这样指针运算就完成了

## 参考

- [golang面试题：能说说uintptr和unsafe.Pointer的区别吗？](https://mp.weixin.qq.com/s?__biz=Mzg5NDY2MDk4Mw==&mid=2247486359&idx=1&sn=8355fed3fbd26f4eaa141ec072bec44d&source=41#wechat_redirect)
- [公众号](https://mp.weixin.qq.com/s/wdFdPv3Bdnhy5pc8KL6w6w)
- [csdn](https://www.cnblogs.com/-wenli/p/12682477.html)