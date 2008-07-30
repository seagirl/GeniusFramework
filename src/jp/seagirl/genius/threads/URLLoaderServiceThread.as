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

package jp.seagirl.genius.threads
{
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import org.libspark.thread.threads.net.URLLoaderThread;

	/**
	 * URLLoaderThread を使ったサービスクラスです。 
	 * @author yoshizu 
	 */	
	public class URLLoaderServiceThread extends GeniusThread
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * URLLoaderThread のインスタンスを保持するための変数です.
		 */		
		protected var urlLoaderThread:URLLoaderThread;
		
		/**
		 * URLRequest のインスタンスです.
		 */		
		protected var request:URLRequest = new URLRequest();
		
		/**
		 * URLVariables のインスタンスです.
		 */		
		protected var variables:URLVariables = new URLVariables();
		
		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------
		
		override public function addData(data:Object):GeniusThread
		{
			this.data = data;
			
			for (var key:String in data)
			{
				if (data[key] != null)
					variables[key] = data[key];
			}
			
			return this;
		}
		
		override public function startWithData(data:Object):void
		{
			this.data = data;
			
			for (var key:String in data)
			{
				if (data[key] != null)
					variables[key] = data[key];
			}
			
			start();
		}
		
	}
}