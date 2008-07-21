/**
 * Licensed under the MIT License
 * 
 * Copyright (c) 2008 seagirl
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 */

package jp.seagirl.collections
{
	/**
	 * SortCompareFunctionはDataGridColumnのsortCompareFunctionに
	 * 渡すことが出来る関数群です。
	 * 
	 * @author yoshizu
	 * @see DataGridColumn
	 */	
	public class SortCompareFunction
	{
		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * プライマリキーを使ったソートです。デフォルトのプライマリキーの名前は 'id' です。
		 * 
		 * @param obj1
		 * @param obj2
		 * @return 
		 */	
		public static function by(primaryKey:String = 'id'):Function
		{
			return function (obj1:Object, obj2:Object):int
			{
				var a:int = int(obj1[primaryKey]);
				var b:int = int(obj2[primaryKey]);
				return (a < b) ? -1 : (a == b) ? 0 : 1;
			}
		}
		
		/**
		 * 整数値とプライマリキーを使ったソートです。
		 * 
		 * @param name
		 * @return 
		 */		
		public static function byInt(key:String, primaryKey:String = 'id'):Function
		{
			return function (obj1:Object, obj2:Object):int
			{
				var a:int = int(obj1[key]);
				var b:int = int(obj2[key]);				
				
				if (a == b)
				{
					a = int(obj1[primaryKey]);
					b = int(obj2[primaryKey]);
					
					return (a < b) ? -1 : (a == b) ? 0 : 1;
				}
			
				return (a < b) ? -1 : 1;
			}
		}
		
		/**
		 * 文字列とプライマリキーを使ったソートです。
		 * 
		 * @param name
		 * @return 
		 */		
		public static function byString(key:String, primaryKey:String = 'id'):Function
		{
			return function (obj1:Object, obj2:Object):int
			{
				var a:String = String(obj1[key]);
				var b:String = String(obj2[key]);
				
				if (a == b)
				{
					a = int(obj1[primaryKey]);
					b = int(obj2[primaryKey]);
					
					return (a < b) ? -1 : (a == b) ? 0 : 1;
				}
				
				return (a < b) ? -1 : 1;
			}
		}

	}
}