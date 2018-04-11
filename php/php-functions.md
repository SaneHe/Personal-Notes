# phper function #
	
	
1. array_merge  ---  array_merge(array1,array2,array3...)
	<br>说明：将一个或者多个数组合并为一个
	实例
	
		$a1=array("red","green");
		$a2=array("blue","yellow");
		print_r(array_merge($a1,$a2));
	
	结果<br>
		Array ( [0] => red [1] => green [2] => blue [3] => yellow )

	注释：如果两个或更多个数组元素有相同的键名，则最后的元素会覆盖其他元素。

2. compact  ---  compact(var1,var2...)
	<br>说明:创建包含变量名和它们的值的数组
	实例
	
		$firstname = "Bill";
		$lastname = "Gates";
		$age = "60";
		$result = compact("firstname", "lastname", "age");
		print_r($result);
	结果<br>
		Array ( [firstname] => Bill [lastname] => Gates [age] => 60 )

3. array_chunk  ---  array_chunk(array,size,preserve_key) 
	<br>说明：将数组分割成新的组块
	实例
	
		$cars=array("Volvo","BMW","Toyota","Honda","Mercedes","Opel");
		print_r(array_chunk($cars,2));
	结果<br>
		Array ( [0] => Array ( [0] => Volvo [1] => BMW ) [1] => Array ( [0] => Toyota [1] => Honda ) [2] => Array ( [0] => Mercedes [1] => Opel ) )
