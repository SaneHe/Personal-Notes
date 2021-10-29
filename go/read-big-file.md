### `golang` 读取大文件方式 (含有中、英文)

>兼容含有中、英文的复杂情况

- `bufio.NewReader` 
- `file Read`
- [face.txt](../media/code/face.txt)


```golang
package main

import (
	"bufio"
	"flag"
	"fmt"
	"io"
	"os"
	"runtime"
	"time"
	"unicode/utf8"
	"unsafe"
)

const buffer = "buffer" // bufio 方式读
const stream = "stream"

func main() {
	t := flag.String("t", buffer, "reader type e.g: bufio stream")
	flag.Parse()
	// flag.PrintDefaults() 输出默认参数情况

	filePath := "./face.txt" 

	// 获取内存占用情况
	m := new(runtime.MemStats)
	runtime.ReadMemStats(m)

	switch *t {
	case buffer:
		readFileViaBuf(filePath, m)
	case stream:
		readFileViaStream(filePath, m)
	}
}

func readFileViaBuf(filePath string, mem *runtime.MemStats) {
	begin := time.Now().Nanosecond() / 1e6

	f, err := os.Open(filePath)
	defer f.Close()

	if err != nil {
		panic(err)
	}

	defer func() {
		fmt.Println(humanBytesLoaded(mem.Sys))
		fmt.Printf(" \n执行时间: %d ms", time.Now().Nanosecond()/1e6-begin)
	}()

	buf := bufio.NewReader(f)
	for {
		if line, _, err := buf.ReadLine(); err == nil {
			fmt.Print(*(*string)(unsafe.Pointer(&line)))
		} else {
			break
		}

		// if line, err := buf.ReadString('\n'); err == nil {
		// 	fmt.Print(line)
		// } else {
		// 	break
		// }
	}
}

func readFileViaStream(filePath string, mem *runtime.MemStats) {
	begin := time.Now().Nanosecond() / 1e6
	f, err := os.Open(filePath)
	defer f.Close()

	if err != nil {
		panic(err)
	}

	defer func() {
		fmt.Println(humanBytesLoaded(mem.Sys))
		fmt.Printf("\n执行时间: %d ms", time.Now().Nanosecond()/1e6-begin)
	}()

	// 上-次读取剩余
	var last []byte
	// 每次读取长度
	buf := make([]byte, 7)

	for {
		switch n, err := f.Read(buf); true {
		case err != nil && err != io.EOF:
			panic(err)
		case n == 0:
			return
		case n > 0:
			if last = append(last, buf[:n]...); !utf8.FullRune(last) {
				break
			}

		cycle:
			for i := 0; i < len(last); i++ {
				if utf8.FullRune(last[:i]) {
					r, size := utf8.DecodeRune(last[:i])
					last = last[size:]
					fmt.Print(string(r))
					goto cycle
				}
			}

		}
	}
}

// 存储空间大小 转换
func humanBytesLoaded(bytes uint64) string {
	suffix := ""
	b := bytes
	if bytes > (1 << 30) {
		suffix = "G"
		b = bytes / (1 << 30)
	} else if bytes > (1 << 20) {
		suffix = "M"
		b = bytes / (1 << 20)
	} else if bytes > (1 << 10) {
		suffix = "K"
		b = bytes / (1 << 10)
	}

	return fmt.Sprintf("\n\n占用内存大小为：%d %s", b, suffix)
}
```

