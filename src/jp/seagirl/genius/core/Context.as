package jp.seagirl.genius.core
{
	import flash.net.SharedObject;
	import flash.system.Security;
	
	import jp.seagirl.genius.models.Model;
	
	import mx.core.IMXMLObject;
	import mx.events.BrowserChangeEvent;
	import mx.managers.BrowserManager;
	import mx.managers.IBrowserManager;
	import mx.utils.URLUtil;
	
	import org.libspark.thread.EnterFrameThreadExecutor;
	import org.libspark.thread.Thread;
	
	public class Context implements IMXMLObject
	{	
		
		public function Context()
		{
			initialize();
		}
		
		private var modelMap:Array = [];
		
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
		public var version:String = '1.0';
		
		//----------------------------------
		//  defaultState
		//----------------------------------
		
		/**
		 * デフォルトの状態です。
		 */
		public var defaultState:Object = {};
		
		
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
		
		public function initialized(document:Object, id:String):void
		{
			initializeModels();
		}
		
		protected function initialize():void
		{
			Thread.initialize(new EnterFrameThreadExecutor());
			
			sharedObject = SharedObject.getLocal('db');
			
			browserManager = BrowserManager.getInstance();
			browserManager.addEventListener(
				BrowserChangeEvent.BROWSER_URL_CHANGE, browserURLChangeHandler);
			browserManager.init();
		}
		
		protected function initializeModels():void
		{
			
		}
		
		public function getModel(modelName:String):Model
		{
			return modelMap[modelName];
		}
		
		public function hasModel(modelName:String):Boolean
		{
			return modelMap[modelName] != null;
		}
		
		public function addModel(model:Model):void
		{
			modelMap[model.name] = model;
		}
		
		public function removeModel(modelName:String):Model
		{
			var model:Model = modelMap[modelName] as Model;
			
			if (model)
			{
				modelMap[modelName] = null;
			}
			
			return model;
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
				state = defaultState;
		}
		
	}
}