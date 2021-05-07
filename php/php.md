# phper  #
	
	
1. 全排列（递归）

	说明：输入一个字符串或者数组得到其进行全排列形式；
			
	代码：


			function fullArrangement( $arr, $str )
			{ // $str 为保存由 i 组成的一个排列情况 

				if( !is_array($arr) )
				{
					// 将字符串分割为数组
					$arr = str_split($arr);
				} 
			    $cnt = count( $arr );  
			 
			    if( $cnt == 1 )
			    {  
			        echo $str . $arr[0] . "\n<br>";  
			    }else{  
			        for( $i = 0; $i < count($arr); $i++ ){  
			            $tmp     = $arr[0]; 
			            $arr[0]  = $arr[$i];
			            $arr[$i] = $tmp;
			            fullArrangement( array_slice($arr, 1), $str . $arr[0] ); 
			        }  
			    }        
			}


2. 排序

	说明：输入一个字符串或者数组得其排列顺序；
			
	代码：

			-冒泡排序
			function bubbleSort( $arr )
			{
				$len = count( $arr);

				for( $i=1; $i < $len; $i++){
					for( $k=0; $k < $len - $i; $k++){
						if( $arr[$k] > $arr[$k+1] )
						{	
							$tmp = $arr[$k+1];
							$arr[$k+1] = $arr[$k];
							$arr[$k] = $tmp;
						}
					}
				}
				
				return $arr;
			}
			
			
			-快速排序
			function quickSort( $arr )
			{	
				$len = count( $arr );
				if( $len <= 1)
				{
					return $arr;
				}
				
				$base_num = $arr[0];
				
				$left_array  = array();
				$right_array = array();
				
				for( $i=1; $i < $len; $++){
					if( $base_num > $arr[$i] )
					{
						$left_array[$i]  = $arr[$i];
					}esle{
						$right_array[$i] = $arr[$i];
					}
				}
				
				$left_array  = quickSort( $left_array );
				$right_array = quickSort( $right_array );
				
				return array_merge( $left_array, array($base_num), $right_array );
			}


3.我们的程序运行过程中每分钟会采集一个整数的数据指标。持续采集n分钟就得到一个有n个元素的整数数组a[n]。现在我们需要一个简单的算法，检测采集到的数据指标中，是否有异常。异常的检测标准是：如果在连续m分钟内的指标的平均值大于w，则说明有异常。输入：数组a[n], 正整数m, 整数w返回：有异常返回 1，没有异常返回 0例如：对于a={1, 5, 1, 3, 2}, m=2, w=2, 返回:1 附加说明：不同的实现方式执行效率不一样，如果能找到一个很高效的算法就更好了。 

此题写了两个方法，只是作为参照
   auth by hejilu
   email sane.stays@gmail.com
	
	代码如下：
	

		/**
		 * 思路为对当前的数组对器 m 整数分割，然后求出平均值，存在一个大于 w 整数的，即为异常，直接返回；效率较高，缺点为分割后的数组内平均			值不存在异常，
		 * 而分割连接点的数组平均值存在异常，不够完善
		 * 
		 * collectIndex function
		 *
		 * @param [array] $arr
		 * @param [int] $m
		 * @param [int] $w
		 * @return int
		 */

		$arr = [1, 5, 1, 3, 2];
		$m = 2;
		$w = 2;

		function collectIndex( $arr, $m, $w )
		{
		    $len = count($arr);
		    if( $len < $m ){
			return (array_sum( $arr ) / $m) > $w ? 1 : 0;
		    }

		    $arrTmp = array_chunk( $arr, $m);
		    foreach( $arrTmp as $tmp ){
			$checkStatus  = array_sum( $tmp ) / $m;
			if( $checkStatus > $w )
			{
			    return 1;
			}
		    }

		    return 0; 
		}

		// echo collectIndex( $arr, $m, $w ) . "<br>";


		/**
		 * 此题思路为利用 php 的递归，对数组进行按照相邻元素进行分割，加上变量引用，最后进行判断返回，个人感觉较为严禁。效率较高
		 * 
		 * collectIndex function
		 *
		 * @param [array] $arr
		 * @param [int] $m
		 * @param [int] $w
		 * @param string $checkStatus
		 * @return int
		 */
		function collectIndex2( $arr, $m, $w, &$checkStatus='' )
		{
		    $len = count($arr);

		    if( $len == $m && array_sum( $arr ) > $m*$w )
		    {  
			$checkStatus .= '1';
		    }else if( $len == $m && array_sum( $arr ) <= $m*$w ) {
			$checkStatus .= '0';
		    } 

		    if( $len > $m ){
			for( $i = 0; $i < $len; $i++ ){  
			    collectIndex2( array_slice($arr, $i, $m), $m, $w, $checkStatus); 
			}  
		    }

		    return strpos( $checkStatus, '1') !== false ? 1 : 0;
		}

		// var_dump( collectIndex2( $arr, $m, $w ) );


4.我们的程序运行过程中用到了一个数组a，数组元素是一个Map/Dictionary。数组元素的“键”和“值”都是字符串类型。在不同的语言中，对应的类型是：PHP的array, Java的HashMap, C++的std::map, Objective-C的NSDictionary, Swift的Dictionary, Python的dict, JavaScript的object, 等等
示例：
a[0]["key1"]="value1"
a[0]["key2"]="value2"
a[1]["keyA"]="valueA"
...
为了方便保存和加载，我们使用了一个基于文本的存储结构，数组元素每行一个：
text="key1=value1;key2=value2\nkeyA=valueA\n..."
要求：请实现一个“保存”函数、一个“加载”函数。
text=store(a);
a=load(text);
这两个函数分别用于把数组保存到一个文本字符串中、把文本字符串中的内容读取为数组。
必须自己手写代码实现保存/加载逻辑，严格按照上述的“每行一个、key=value”的格式保存。
附加说明：基于上述格式，如果value中有特殊字符，比如有换行符/分号等怎么办？
如果有思路，请基于上述的格式设计并实现一个完美的方案。

	代码如下：
	
		$arr = [ [ "key1" => "value1", "key2" => "value2" ], [ "keyA" => "valueA" ], [ "keyC" => "valueC" ], "keyD" => "valueD" 		];
		$text = './test.txt';

		/**
		 * store array function
		 *
		 * @param [array] $arr
		 * @param string $text
		 * @return int
		 */
		function store( $arr, &$text="" )
		{
		    if( is_array( $arr ) && !empty( $arr ) ){
			foreach( $arr as $key => $value ){
			    if( !is_array( $value ) ){
				$text .= $key . '=' . $value. ';';
			    }else{             
				$text = $text =='' ? $text : substr($text, 0, -1). PHP_EOL;
				store( $value, $text );
			    }
			}
		    }

		    $encode = mb_detect_encoding($text, array("ASCII",'UTF-8',"GB2312","GBK",'BIG5'));
		    if( $encode != 'UTF-8' ) {       
			$text = mb_convert_encoding($text, 'UTF-8', $encode);
		    }
		    $text = substr($text, 0, -1). PHP_EOL;

		    return file_put_contents( "test.txt", $text);
		}

		// var_dump(store( $arr ) );

		/**
		 * read text content function
		 *
		 * @param [path] $text
		 * @return array
		 */
		function load( $text )
		{
		    $text = file_get_contents( $text );
		    $arr = strToArr( $text );

		    return $arr;
		}

		/**
		 * strToArr function
		 *
		 * @param [string] $text
		 * @param array $arr
		 * @param [string] $delimiter
		 * @return array
		 */
		function strToArr( $text, &$arr=array(), $delimiter = PHP_EOL )
		{              
		    static $index =0;

		    if( strpos( $text, $delimiter ) !== false )
		    {
			$arrTmp  =  explode( $delimiter, $text);
			$arrTmp  = array_filter( $arrTmp );

			foreach( $arrTmp as $keys => $tmp ){

			    strToArr( $tmp, $arr, ';' );
			    if( $delimiter === PHP_EOL ) $index ++;
			}
		    }else{

			$key = substr( $text, 0, strpos( $text, '=') );
			$value = substr( $text, -(strlen($text) - strpos( $text, '=') -1) );

			$arr[ $index ][ $key ] = $value;
		    }
		    return $arr;
		}

		// var_dump(load( $text ) );

		/**
		 * 如果有换行符/分号等情况，我的想法是可以在我存储数组的过程中先对这些字符进行替换，将其以其他形式存在，然后读取的时候再对其转换
		 */
