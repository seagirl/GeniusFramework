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
	import jp.seagirl.genius.controllers.ViewController;
	import jp.seagirl.genius.core.Config;
	import jp.seagirl.genius.core.Context;
	import jp.seagirl.genius.models.IModel;
	import jp.seagirl.genius.views.ApplicationDelegate;
	
	import mx.controls.Alert;
	import mx.utils.ObjectUtil;
	
	import org.libspark.thread.Thread;

	public class GeniusThread extends Thread
	{
		/**
		 * コンストラクタです.
		 */	
		public function GeniusThread()
		{
			super();
			
			context = ApplicationDelegate.sharedApplicationDelegate().context;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 汎用的なデータオブジェクトです.
		 */		
		protected var data:Object;
		
		/**
		 * コンテキストオブジェクトです.
		 */	
		protected var context:Context;
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		protected function getConfig():Config
		{
			return context.config;
		}
		
		protected function getModel(modelName:String):IModel
		{
			return context.getModel(modelName);
		}
		
		protected function getController(controllerName:String):ViewController
		{
			return context.getController(controllerName);
		}
		
		protected function alert(text:*, title:String = 'エラー'):void
		{
			Alert.show(ObjectUtil.toString(text), title);
		}
		
		/**
		 * 汎用的なデータを追加するためのメソッドです.
		 * @param data
		 * @return  
		 */		
		public function addData(data:Object):GeniusThread
		{
			this.data = data;
			
			return this;
		}
		
		/**
		 * 汎用的なデータを保持しながら、Thread を開始するためのメソッドです.
		 * @param data 汎用的なデータオブジェクト
		 */		
		public function startWithData(data:Object):void
		{
			this.data = data;
			
			start();
		}
		
	}
}