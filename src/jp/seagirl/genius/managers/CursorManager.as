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
 
 package jp.seagirl.genius.managers
{
	import mx.managers.CursorManager;
	import mx.utils.UIDUtil;
	
	/**
	 * これは Genius Framework 内部でのみ使用するクラスです。
	 * 
	 * @author yoshizu 
	 */	
	public class CursorManager
	{
		private static var repository:Object = {};
		private static var isLoading:Boolean = false;
		
		public static function setBusyCursor():String
		{
			if (!isLoading)
			{
				isLoading = true;
				mx.managers.CursorManager.setBusyCursor();
			}
			
			var id:String = UIDUtil.createUID();
			repository[id] = true;
			
			return id;
		}
		
		public static function removeBusyCursor(id:String):void
		{
			if (repository.hasOwnProperty(id))
			{
				repository[id] = false;
				delete repository[id];
			}
			
			var flag:Boolean = false;
			for each (var value:Boolean in repository)
			{
				if (value)
					flag = true;
			}
			
			if (!flag)
			{
				mx.managers.CursorManager.removeBusyCursor();
				isLoading = false;
			}
		}

	}
}