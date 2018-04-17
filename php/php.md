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

	
