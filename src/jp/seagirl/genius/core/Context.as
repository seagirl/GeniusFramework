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
 
package jp.seagirl.genius.core
{
	import flash.net.SharedObject;
	import flash.system.Security;
	
	import jp.seagirl.genius.controllers.ViewController;
	import jp.seagirl.genius.models.IModel;
	
	import mx.events.BrowserChangeEvent;
	import mx.managers.BrowserManager;
	import mx.managers.IBrowserManager;
	import mx.utils.URLUtil;
	
	public class Context
	{	
		
		public function Context(config:Config)
		{
			this.config = config;
			
			initialize();
		}
		
		private var modelsMap:Array = [];
		private var controllersMap:Array = [];
		
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
		//  config
		//----------------------------------
		
		/**
		 * アプリケーションの設定です。
		 */	
		public var config:Config;
		
		//----------------------------------
		//  defaultState
		//----------------------------------
		
		/**
		 * デフォルトの状態です。 
		 */		
		public function get defaultState():Object
		{
			return config.defaultState;
		}
		
		//----------------------------------
		//  ignoredState
		//----------------------------------
		
		/**
		 * ブラウザに同期させない状態のキーを定義した配列です。
		 */	
		public var ignoredState:Array = [];
		
		//----------------------------------
		//  state
		//----------------------------------
		
		/**
		 * @private 
		 */	
		private var _state:Object;
		
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
				var aState:Object = {};
				
				for (var aKey:String in _state)
				{
					var ignore:Boolean = false;
					
					for each (var ignoredKey:String in ignoredState)
					{
						if (aKey == ignoredKey)
							ignore = true;
					}
					
					if (!ignore)
						aState[aKey] = _state[aKey];
				}
				
				var string:String = URLUtil.objectToString(aState, '&');
				browserManager.setFragment(string);
			}
		}
		
		//----------------------------------
		//  storedData
		//----------------------------------

		/**
		 * SharedObjectに保存されるデータです。
		 */
		public function get storedData():Object
		{
			return sharedObject.data;
		}
		
		/**
		 * @private 
		 */	
		public function set storedData(value:Object):void
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
		
		protected function initialize():void
		{
			state = config.defaultState;
			
			sharedObject = SharedObject.getLocal('db');
			
			browserManager = BrowserManager.getInstance();
			browserManager.addEventListener(
				BrowserChangeEvent.BROWSER_URL_CHANGE, browserURLChangeHandler);
			browserManager.init();
		}
		
		public function getModel(modelName:String):IModel
		{
			return modelsMap[modelName];
		}
		
		public function hasModel(modelName:String):Boolean
		{
			return modelsMap[modelName] != null;
		}
		
		public function addModel(model:IModel):void
		{
			modelsMap[model.name] = model;
		}
		
		public function removeModel(modelName:String):IModel
		{
			var model:IModel = modelsMap[modelName] as IModel;
			
			if (model)
			{
				modelsMap[modelName] = null;
			}
			
			return model;
		}
		
		public function getController(controllerName:String):ViewController
		{
			return controllersMap[controllerName];
		}
		
		public function hasController(controllerName:String):Boolean
		{
			return controllersMap[controllerName] != null;
		}
		
		public function addController(controller:ViewController):void
		{
			controllersMap[controller.name] = controller;
		}
		
		public function removeController(controllerName:String):ViewController
		{
			var controller:ViewController = controllersMap[controllerName] as ViewController;
			
			if (controller)
			{
				controllersMap[controllerName] = null;
			}
			
			return controller;
		}
		
		/**
		 * Applicationの基本的な情報をコンソールに出力します。
		 * 
		 * @param name 
		 */		
		public function traceApplicationInformation():void
		{			
			trace('---------------------------------------------', new Date());
			trace(config.applicationName, config.applicationVersion);
			trace('Sandbox is', Security.sandboxType, '\n');
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
				state = config.defaultState;
		}
		
	}
}