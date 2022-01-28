### 获取所有子集

```php
<?php

function (array $arr) {
    $result[] = [];

    for ($i = 0; $i < count($arr); $i++) {

        foreach ($result as $item) {
            $item[] = $arr[$i];
            $result[] = $item;
        }
    }
    return $result;
}

```
