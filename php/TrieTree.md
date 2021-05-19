# `Trie tree` 路由实现

```php
<?php
/**
 * trie tree 构造路由
 *
 * @author   Sane
 * @link     https://github.com/SaneHe/
 * @date     2021-05-18 17:47:23
 *
 */

class TrieTree
{
    /**
     * 路由样式
     *
     * @var string
     */
    public $pattern;

    /**
     * 路由段
     *
     * @var string
     */
    public $part;

    /**
     * 子元素
     *
     * @var array
     */
    public $children;

    /**
     * 是否为动态匹配
     *
     * @var bool
     */
    public $isWild;

    public function __construct(string $part = '', bool $isWild = false, string $pattern = '', array $children = [])
    {
        $this->part = $part;
        $this->isWild = $isWild;
        $this->pattern = $pattern;
        $this->children = $children;
    }

    /**
     * 向树好插入一个数据
     *
     * @param string $pattern
     * @param array $parts
     * @param int $height
     */
    public function insert(string $pattern, array $parts, int $height = 0)
    {
        if (count($parts) == $height) {
            $this->pattern = $pattern;
            return $this;
        }

        $part = $parts[$height];
        if (!$child = $this->matchChild($part)) {
            $child = new TrieTree($part);
            array_push($this->children, $child);
        }

        return $child->insert($pattern, $parts, $height + 1);
    }

    /**
     * 查找下级
     *
     * @param string $part
     */
    private function matchChild(string $part)
    {
        foreach ($this->children as $value) {
            if ($value->part == $part || $value->isWild) {
                return $value;
            }
        }
        return false;
    }

    /**
     * 查找一个元素
     *
     * @param array $parts
     * @param int $height
     */
    public function search(array $parts, int $height = 0)
    {
        if (count($parts) == $height || strpos($this->part, '}') !== false) {
            return $this->pattern ? $this : '';
        }

        $children = $this->matchChildren($parts[$height]);

        foreach ($children as $child) {
            if ($trie = $child->search($parts, $height +1)) {
                return $trie;
            }
        }

        return '';
    }

    /**
     * 查找所有下级
     *
     * @param string $part
     *
     * @return array
     */
    private function matchChildren(string $part):array
    {
        $children = [];
        foreach ($this->children as $value) {
            if ($value->part == $part || $value->isWild) {
                array_push($children, $value);
            }
        }

        return $children;
    }
}

```

# 使用

```php
<?php

    // 构造
    $tree= [];
    $routers = [
        ['method' => 'GET', 'path' => '/api/test1'],
        ['method' => 'GET', 'path' => '/api/test2'],
        ['method' => 'PUT', 'path' => '/api/test3'],
        ['method' => 'POST', 'path' => '/api/test4'],
    ];

    foreach ($routers as $route) {
        if (empty($tree[$route['method']])) {
            $tree[$route['method']] = new TrieTree;
        }
        
        $tree[$route['method']]->insert($route['path'], explode('/', ltrim($route['path'], '/')));
    }

    // 查询
    $tree[$request->method()]->search(explode('/', 'api/test1'));
```

# 参考

- [trie tree](https://geektutu.com/post/gee-day3.html)
- [trie tree](https://blog.51cto.com/u_12597095/2146233)
