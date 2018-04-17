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
   email 18217108467@163.com


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

