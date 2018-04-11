# phper function #
	
	
1. array_merge
	说明：将一个或者多个数组合并为一个
	实例
	
	$a1=array("red","green");
	$a2=array("blue","yellow");
	print_r(array_merge($a1,$a2));
	
	结果
		Array ( [0] => red [1] => green [2] => blue [3] => yellow )

	注释：如果两个或更多个数组元素有相同的键名，则最后的元素会覆盖其他元素。
