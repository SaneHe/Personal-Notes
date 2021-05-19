# `php` 访问类中私有成员

```php
<?php

/**
 * Description
 *
 * @author   Sane
 * @link     https://github.com/SaneHe/
 * @date     2021-05-07 17:58:11
 *
 */
class person
{
    private $age;
    private $sex;
    public function __construct($age, $sex)
    {
        $this->age = $age;
        $this->sex = $sex;
    }
    public function getage()
    {
        return $this->age;
    }
    public function getclosure()
    {
        return function () {
            return $this->age . "-->" . $this->sex;
        };
    }
}

$tom = new person(18, 1);
$lucy = new person(16, 2);

$set = Closure::bind(function ($obj, $k, $v) {
    $obj->$k = $v;
}, null, person::class);

$get = Closure::bind(function ($obj, $k) {
    return $obj->$k;
}, null, person::class);

$get_tom_age = Closure::bind(function () use ($tom) {
    return $tom->age;
}, null, person::class);

echo $get_tom_age() . "\n"; //18
echo $get($tom, 'age') . "\n"; //18

$set($tom, 'age', 20);
echo $get($tom, 'age') . "\n"; //20

$c1 = $tom->getclosure();
echo $c1() . "\n"; //20-->1

$c1 = $c1->bindTo($lucy);
echo $c1() . "\n";//16-->2

```
