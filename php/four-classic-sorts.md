### 四大经典排序

```php 
/**
 * 冒泡排序
 *
 * 双层循环 判断大小后 交换位置
 *
 * 时间复杂度 O(n²)
 *
 * 空间复杂度 O(1)
 *
 * @param array $arr
 *
 * @return array
 */
function bubble_sort(array $arr): array
{
    for ($i = 0; $i < count($arr); $i++) {
        for ($j = 0; $j < count($arr); $j++) {
            if ($arr[$i] < $arr[$j]) {
                // 交换位置
                [$arr[$i], $arr[$j]] = [$arr[$j], $arr[$i]];
            }
        }
    }

    return $arr;
}

/**
 * 插入排序
 *
 * 先选择一个参考点 然后再循环逐个比较大小 交换位置
 *
 * 时间复杂度 O(n²)
 *
 * 空间复杂度 O(1)
 *
 * @param array $arr
 *
 * @return array
 */
function insert_sort(array $arr): array
{
    for ($i = 1; $i < count($arr); $i++) {
        // 基准
        $tmp = $arr[$i];
        for ($j = $i - 1; $j >= 0; $j--) {
            if ($tmp < $arr[$j]) {
                // 将当前位置的值设置为基准值 当前位置的后一元素设置为当前位置元素值
                [$arr[$j], $arr[$j + 1]] = [$tmp, $arr[$j]];
            }
        }
    }

    return $arr;
}

/**
 * 选择排序 (不稳定)
 *
 * 每次外层循环时 内层循环需要根据当前外层值判断大小 找出最小元素的索引  然后交换位置
 *
 * 时间复杂度 O(n²)
 *
 * 空间复杂度 O(1)
 *
 * @param array $arr
 *
 * @return array
 */
function select_sort(array $arr): array
{
    for ($i = 0; $i < count($arr) - 1; $i++) {
        // 当前循环最小元素的索引
        $minIndex = $i;
        for ($j = $i + 1; $j < count($arr); $j++) {
            // 循环比较 取出最小的元素 索引值
            if ($arr[$j] < $arr[$minIndex]) {
                $minIndex = $j;
            }
        }

        [$arr[$minIndex], $arr[$i]] = [$arr[$i], $arr[$minIndex]];
    }

    return $arr;
}

/**
 * 快速排序 (不稳定)
 *
 * 选择
 *
 * 时间复杂度 O(nlog n)
 *
 * 空间复杂度 O(log n)
 *
 * @param array $arr
 *
 * @return array
 */
function quick_sort(array $arr, $pivotIndex = 0): array
{
    $length = count($arr);
    if ($length <= 1) {
        return $arr;
    }

    $left = $right = [];
    for ($i = 1; $i < $length; $i++) {
        if ($arr[$i] < $arr[0]) {
            $left[] = $arr[$i];
        } else {
            $right[] = $arr[$i];
        }
    }

    $left = quick_sort($left);
    $right = quick_sort($right);

    return array_merge($left, [$arr[0]], $right);
}

// 生成随机数组
$arr = get_random_array();
var_dump(
    $arr,
    bubble_sort($arr),
    insert_sort($arr),
    select_sort($arr),
    quick_sort($arr)
);


/**
 * 随机生成数组
 *
 * @param int $length
 * @param int $min
 * @param int $max
 *
 * @return array
 */
function get_random_array(int $length = 7, int $min = 0, int $max = 10): array
{
    $arr = [];
    for ($i = 0; $i < $length; $i++) {
        $arr[] = mt_rand($min, $max);
    }

    return $arr;
}
```