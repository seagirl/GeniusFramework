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
	import flash.net.SharedObject;
	import flash.system.Security;
	
	import mx.core.Application;
	import mx.events.BrowserChangeEvent;
	import mx.managers.BrowserManager;
	import mx.managers.IBrowserManager;
	import mx.utils.URLUtil;
	
	/**
	 * ApplicationManagerはアプリケーションを管理するクラスです。
	 * 
	 * @author yoshizu 
	 */	
	public class ApplicationManager
	{
		//--------------------------------------------------------------------------
		//
		//  Class properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  instance
		//----------------------------------
		
		/**
		 * @private 
		 */	
		private static var _instance:ApplicationManager;
		
		/**
		 * このクラスの唯一のインスタンスです。
		 */		
		public static function get instance():ApplicationManager
		{
			if (_instance == null)
				_instance = new ApplicationManager();
			return _instance;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * コンストラクタ 
		 */		
		public function ApplicationManager()
		{
			if (_instance != null)
				throw new Error("Public construction not allowed.");
			initialize();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private 
		 */		
		private var sharedObject:SharedObject;
		
		/**
		 * @private 
		 */		
		private var browserManager:IBrowserManager;
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  name
		//----------------------------------
		
		/**
		 * アプリケーションの名前です。
		 */	
		public var name:String = 'Application';
		
		//----------------------------------
		//  version
		//----------------------------------
		
		/**
		 * アプリケーションのバージョンです。
		 */	
		public var version:String = '';
		
		//----------------------------------
		//  defaultState
		//----------------------------------
		
		/**
		 * デフォルトの状態です。
		 */
		public var defaultState:Object = { page: 'index' };
		
		
		//----------------------------------
		//  state
		//----------------------------------
		
		/**
		 * @private 
		 */	
		private var _state:Object = defaultState;
		
		[Bindable]
		/**
		 * アプリケーションの状態です。
		 */
		public function get state():Object
		{
			return _state;
		}
		
		/**
		 * @private 
		 */	
		public function set state(value:Object):void
		{
			_state = value;
			
			if (browserManager != null)
			{
				var string:String = URLUtil.objectToString(_state, '&');
				browserManager.setFragment(string);
			}
		}
		
		//----------------------------------
		//  data
		//----------------------------------

		/**
		 * SharedObjectに保存されるデータです。
		 */
		public function get data():Object
		{
			return sharedObject.data;
		}
		
		/**
		 * @private 
		 */	
		public function set data(value:Object):void
		{
			if (sharedObject.data != value)
			{	
				if (value == null)
				{
					for (var index:String in sharedObject.data)	
					{
						sharedObject.data[index] = null;
						delete sharedObject.data[index];
					}
				}
				else
				{
					for (var index2:String in value)	
					{
						sharedObject.data[index2] = value[index2];
					}
				}
				sharedObject.flush();
			}
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private 
		 */		
		private function initialize():void
		{
			sharedObject = SharedObject.getLocal('db');
			
			browserManager = BrowserManager.getInstance();
			browserManager.addEventListener(
				BrowserChangeEvent.BROWSER_URL_CHANGE, browserURLChangeHandler);
			browserManager.init();
		}
		
		/**
		 * Applicationの基本的な情報をコンソールに出力します。
		 * 
		 * @param name 
		 */		
		public function traceApplicationInformation(name:String = null, version:String = null):void
		{
			if (name != null)
				this.name = name;
			if (version != null)
				this.version = version;	
			
			trace('---------------------------------------------', new Date());
			trace(this.name, this.version);
			trace('SandboxType is', Security.sandboxType, '\n');
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */		
		private function browserURLChangeHandler(event:BrowserChangeEvent):void
		{
			var urlString:String = browserManager.fragment;
			if (urlString != '')
				state = URLUtil.stringToObject(urlString, '&');
			else
				state = defaultState;
		}

	}
}