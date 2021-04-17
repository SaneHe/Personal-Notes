# 单例模式

## 解释

创建型模式，提供一个唯一对象的访问方式，无需重新实例化对象

    tips：
        1、有且仅有一个实例 
        2、自己创建实例
        3、提供对外访问

## 组成

- `必须`一个 `private` 修饰符的构造函数
- `必须`一个保存类的实例的 `private` 修饰符的静态成员变量
- `必须`一个访问该实例的静态公共方法
- 一个 `private` 修饰符的 `__clone` 方法

## 代码实现

```php
<?php
class Db
{
    private static $instance;

    private function __construct(){}

    private function __clone(){}

    public static function getInstance()
    {
        return self::$instance instanceof self ?
            self::$instance :
            self::$instance = new self;
    }
}
```
