# phper function #
	
	
1. array_merge  ---  array_merge(array1,array2,array3...)

	说明：将一个或者多个数组合并为一个
	实例
	
		$a1=array("red","green");
		$a2=array("blue","yellow");
		print_r(array_merge($a1,$a2));
	
	结果
	
		Array ( [0] => red [1] => green [2] => blue [3] => yellow )

	注释：如果两个或更多个数组元素有相同的键名，则最后的元素会覆盖其他元素。

2. compact  ---  compact(var1,var2...)

	说明:创建包含变量名和它们的值的数组
	实例
	
		$firstname = "Bill";
		$lastname = "Gates";
		$age = "60";
		$result = compact("firstname", "lastname", "age");
		print_r($result);
	结果
	
		Array ( [firstname] => Bill [lastname] => Gates [age] => 60 )

3. array_chunk  ---  array_chunk(array,size,preserve_key) 
	<br>说明：将数组分割成新的组块
	实例
	
		$cars=array("Volvo","BMW","Toyota","Honda","Mercedes","Opel");
		print_r(array_chunk($cars,2));
	结果
	
		Array ( [0] => Array ( [0] => Volvo [1] => BMW ) [1] => Array ( [0] => Toyota [1] => Honda ) [2] => Array ( [0] => Mercedes [1] => Opel ) )
		
4.  array_column  ---  array_column(array,column_key,index_key)

	说明： 返回输入数组中某个单一列的值
	实例
	
		$a = array(
		  array(
		    'id' => 5698,
		    'first_name' => 'Bill',
		    'last_name' => 'Gates',
		  ),
		  array(
		    'id' => 4767,
		    'first_name' => 'Steve',
		    'last_name' => 'Jobs',
		  ),
		  array(
		    'id' => 3809,
		    'first_name' => 'Mark',
		    'last_name' => 'Zuckerberg',
		  )
		);

		$last_names = array_column($a, 'last_name');
		print_r($last_names);
	结果
	
		Array
		(
		  [0] => Gates
		  [1] => Jobs
		  [2] => Zuckerberg
		)

5  array_diff  ---  array_diff(array1,array2,array3...)

	说明：返回两个数组的差集数组
	实例
	
		$a1=array("a"=>"red","b"=>"green","c"=>"blue","d"=>"yellow");
		$a2=array("e"=>"red","f"=>"green","g"=>"blue");

		$result=array_diff($a1,$a2);
		print_r($result);
	结果
	
		Array ( [d] => yellow )
