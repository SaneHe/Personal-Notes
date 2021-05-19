# `trietree` `go` 路由版本


```go
package trie

import (
	"fmt"
	"strings"
)

type node struct {
	pattern  string
	part     string
	children []*node
	isWild   bool
}

func (n *node) String() string {
	return fmt.Sprintf("node{pattern=%s, part=%s, isWild=%t}", n.pattern, n.part, n.isWild)
}

func (n *node) insert(pattern string, parts []string, height int) {
	if len(parts) == height {
		n.pattern = pattern
		return
	}

	part := parts[height]
	child := n.matchChild(part)
	if child == nil {
		child = &node{part: part, isWild: part[0] == ':' || part[0] == '*'}
		n.children = append(n.children, child)
	}
	child.insert(pattern, parts, height+1)
}

func (n *node) search(parts []string, height int) *node {
	if len(parts) == height || strings.HasPrefix(n.part, "*") {
		if n.pattern == "" {
			return nil
		}
		return n
	}

	part := parts[height]
	children := n.matchChildren(part)

	for _, child := range children {
		result := child.search(parts, height+1)
		if result != nil {
			return result
		}
	}

	return nil
}

func (n *node) travel(list *([]*node)) {
	if n.pattern != "" {
		*list = append(*list, n)
	}
	for _, child := range n.children {
		child.travel(list)
	}
}

func (n *node) matchChild(part string) *node {
	for _, child := range n.children {
		if child.part == part || child.isWild {
			return child
		}
	}
	return nil
}

func (n *node) matchChildren(part string) []*node {
	nodes := make([]*node, 0)
	for _, child := range n.children {
		if child.part == part || child.isWild {
			nodes = append(nodes, child)
		}
	}
	return nodes
}

```

# 使用

```go

    
    type route struct {
        Method string `json:"method"`
        Pattern string `json:"path"`
    }


	var rous = make([]route, 1)
	var n  = make(map[string]*node)
	var data string = "[{\"method\":\"GET\",\"path\":\"api/aaa\"},{\"method\":\"GET\",\"path\":\"api/bbb\"},{\"method\":\"PUT\",\"path\":\"api/ccc\"},{\"method\":\"POST\",\"path\":\"api/ddd\"}]"

	json.Unmarshal( []byte(data), &rous)
	
	for  _, rou := range rous {
		parts := strings.Split(rou.Pattern, "/")

		_, ok := n[rou.Method]
		if !ok{
			n[rou.Method] = &node{}
		}

		n[rou.Method].insert(rou.Pattern, parts, 0)
	}

	method := "GET"
	path := "api/aaa"
	partss := strings.Split(path, "/")

    // 生成树 查询元素
	fmt.Println(rous, n[method].search(partss, 0))
```

# 参考

- [trie tree](https://geektutu.com/post/gee-day3.html)
