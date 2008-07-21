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
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.formatters.DateFormatter;
	
	/**
	 * LabelFunctionはDataGridColumnのlabelFunctionに
	 * 渡すことが出来る関数群です。
	 * 
	 * @author yoshizu
	 * @see DataGridColumn
	 */	
	public class LabelFunction
	{
		//--------------------------------------------------------------------------
		//
		//  Class methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 日付を表示します。
		 * @param formatString 表示したい日付のフォーマットを指定します。
		 * @return  
		 */		
		public static function displayDate(formatString:String = 'YYYY-MM-DD JJ:NN:SS'):Function
		{
			return function (data:Object, self:DataGridColumn):String
			{
				var dateString:String = data[self.dataField];
				var splittedByDotStringFragments:Array = dateString.split('.');		
				var dateFormattedString:String = String(splittedByDotStringFragments.shift()).replace(/-/g, '/');
				var dateFormatter:DateFormatter = new DateFormatter();
				dateFormatter.formatString = formatString;
				return dateFormatter.format(dateFormattedString);	
			}
		}

	}
}