### 堆栈

- `堆` 通常由编程人员控制申请和释放; `栈` 一般为操作系统来分配和释放
- `栈` 拥有 `先进后出` 的特性, 通常用来存放一些局部、常用到的数据, 例如: 临时变量、函数参数、返回值等 (局部的、占用空间确定); `堆` 通常用来存放 `全局变量` (不确定其具体占用情况)
- `栈` 比 `堆` 访问速度快, 并且 `栈` 为线程独享, `堆` 为线程共享

### `golang` 中的 `堆栈`

>在 `go` 中即使你使用 `new`、`make` 函数创建变量, 变量的分配依然是编译器负责管理其分配位置

```
How do I know whether a variable is allocated on the heap or the stack?
From a correctness standpoint, you don't need to know. Each variable in Go exists as long as there are references to it. The storage location chosen by the implementation is irrelevant to the semantics of the language.

The storage location does have an effect on writing efficient programs. When possible, the Go compilers will allocate variables that are local to a function in that function's stack frame. However, if the compiler cannot prove that the variable is not referenced after the function returns, then the compiler must allocate the variable on the garbage-collected heap to avoid dangling pointer errors. Also, if a local variable is very large, it might make more sense to store it on the heap rather than the stack.

In the current compilers, if a variable has its address taken, that variable is a candidate for allocation on the heap. However, a basic escape analysis recognizes some cases when such variables will not live past the return from the function and can reside on the stack.

translate google
我怎么知道一个变量是分配在堆上还是堆栈上？
从正确性的角度来看，您不需要知道。只要有对它的引用，Go 中的每个变量就存在。实现选择的存储位置与语言的语义无关。

存储位置确实对编写高效程序有影响。如果可能，Go 编译器将在该函数的堆栈帧中分配函数的局部变量。但是，如果编译器在函数返回后无法证明该变量未被引用，则编译器必须在垃圾收集堆上分配该变量以避免悬空指针错误。此外，如果局部变量非常大，将其存储在堆上而不是栈上可能更有意义。

在当前的编译器中，如果一个变量的地址被占用，则该变量是在堆上分配的候选对象。然而，一个基本的逃逸分析识别出一些情况，当这些变量在函数返回后不会存活并且可以驻留在堆栈中。  
```

#### `逃逸分析`

>`逃逸分析` 是指分析指针动态范围的方法; 当变量或者对象在方法分配后, 其指针有可能被返回或者引用, 这样有可能会被其他线程等引用, 这种现象称之为指针或者引用的 `逃逸` 

- 由 `指针` 产生的逃逸行为
  - 函数内返回局部变量的地址
  - 将指针以及指针值发送到通道
  
    ```golang
    package main 
    
    import "fmt"

    type Demo {
        Name string
    }

    func newDemo(name string) *Demo {
        d := new(Demo) // 局部变量 d 逃逸到堆
        d.Name = name
        return d 
    }
    
    funn main(){
        demo := newDemo("sane")
        fmt.Println(demo) // demo escapes to heap
    }
    ```

- `interface{}` 的动态类型
  
  ```golang
   // go tool compile -m main.go
   demo := newDemo("sane")
   fmt.Println(demo) // demo escapes to heap
  ```
- 栈空间不足
  - 操作系统对内核线程使用的栈空间是有大小限制的，64 位系统上通常是 8 MB。可以使用 ulimit -a 命令查看机器上栈允许占用的内存的大小
  - 因为栈空间通常比较小，因此递归函数实现不当时，容易导致栈溢出。对于 Go 语言来说，运行时(runtime) 尝试在 goroutine 需要的时候动态地分配栈空间，goroutine 的初始栈大小为 2 KB。当 goroutine 被调度时，会绑定内核线程执行，栈空间大小也不会超过操作系统的限制。对 Go 编译器而言，超过一定大小的局部变量将逃逸到堆上
  
- 闭包
  - Increase() 返回值是一个闭包函数，该闭包函数访问了外部变量 n，那变量 n 将会一直存在，直到 in 被销毁。很显然，变量 n 占用的内存不能随着函数 Increase() 的退出而回收，因此将会逃逸到堆上
  ```golang
  // go build -gcflags=-m main.go 
  func Increase() func() int {
        n := 0
        return func() int {
            n++
            return n
        }
    }

    func main() {
        in := Increase()
        fmt.Println(in()) // 1
        fmt.Println(in()) // 2
    }
  ```

### 参考

- [阮一峰-Stack的三种含义](http://www.ruanyifeng.com/blog/2013/11/stack.html)
- [go 逃逸分析](https://shuzang.github.io/2020/golang-deep-learning-8-stack-heap-and-escape-analysis/)
- [go 逃逸分析](https://geektutu.com/post/hpg-escape-analysis.html#2-1-%E4%BB%80%E4%B9%88%E6%98%AF%E9%80%83%E9%80%B8%E5%88%86%E6%9E%90)
- [Why passing pointers to channel is slower](https://stackoverflow.com/questions/41178729/why-passing-pointers-to-channel-is-slower)
