/**
 * Licensed under the MIT License
 * 
 * Copyright (c) 2009 seagirl
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
 
 package jp.seagirl.genius.views
{
	import jp.seagirl.genius.controllers.ViewController;
	import jp.seagirl.genius.core.Context;
	import jp.seagirl.genius.core.IConfig;
	import jp.seagirl.genius.models.Model;
	
	import mx.binding.utils.BindingUtils;
	import mx.core.Application;
	
	import org.libspark.ui.SWFWheel;

	public class ApplicationDelegate extends AbstractDelegate
	{
		public static function sharedApplicationDelegate():ApplicationDelegate
		{
			var delegate:ApplicationDelegate;
			
			if (Application.application.data.hasOwnProperty('delegate'))
				delegate = Application.application.data.delegate;

			if (Application.application.hasOwnProperty('delegate'))
				delegate = Application.application.delegate;
				
			if (delegate == null)
				throw new Error("Couldn't find any ApplicationDelegate.");
				
			return delegate;
		}
		
		protected var config:IConfig;
		
		override protected function preinitialize():void
		{
			if (this['view'] is Application)
				SWFWheel.initialize(Application(this['view']).systemManager.stage);
				
			this['view'].data = { delegate: this };
			this['view'].styleName = 'plain';
			this['view'].setStyle('color', '#000000');
		}
		
		override protected function initialize():void
		{
			initializeConfig();
			initializeContext();
			initializeModels();
			initializeControllers();
		}
		
		protected function initializeConfig():void
		{
			if (config == null)
				throw new Error("IConfig インスタンスが設定されていません。")
		}
		
		protected function initializeContext():void
		{
			context = new Context();
			context.name = config.applicationName;
			context.version = config.applicationVersion;
			context.traceApplicationInformation();
			
			context.defaultState = config.defaultState;
			
			if (!context.state.hasOwnProperty('page'))
				context.state = config.defaultState;
				
			BindingUtils.bindSetter(onContextStateChange, context, 'state');
		}
		
		protected function initializeModels():void
		{
			
		}
		
		protected function initializeControllers():void
		{
			
		}
		
		protected function changePage(data:Object):void
		{
			
		}
		
		public function getModel(modelName:String):Model
		{
			return context.getModel(modelName);
		}
		
		public function hasModel(modelName:String):Boolean
		{
			return context.hasModel(modelName);
		}
		
		public function addModel(model:Model):void
		{
			context.addModel(model);
		}
		
		public function removeModel(modelName:String):Model
		{
			return context.removeModel(modelName);
		}
		
		public function getController(controllerName:String):ViewController
		{
			return context.getController(controllerName);
		}
		
		public function hasController(controllerName:String):Boolean
		{
			return context.hasController(controllerName);
		}
		
		public function addController(controller:ViewController):void
		{
			context.addController(controller);
		}
		
		public function removeController(controllerName:String):ViewController
		{
			return context.removeController(controllerName);
		}
		
		/**
		 * 状態に変化があると呼び出されるコールバック関数です。
		 */		
		private function onContextStateChange(data:Object):void
		{
			if (data == null)
				return;
			
			changePage(data);
		}
		
	}
}