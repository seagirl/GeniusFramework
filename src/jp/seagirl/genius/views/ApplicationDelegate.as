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
	import com.flashdynamix.utils.SWFProfiler;
	
	import jp.seagirl.genius.controllers.ViewController;
	import jp.seagirl.genius.core.Config;
	import jp.seagirl.genius.core.Context;
	import jp.seagirl.genius.events.ApplicationEvent;
	import jp.seagirl.genius.models.Model;
	
	import mx.binding.utils.BindingUtils;
	import mx.core.Application;
	
	import org.libspark.thread.EnterFrameThreadExecutor;
	import org.libspark.thread.Thread;
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
		
		private var config:Config;
		
		override protected function preinitialize():void
		{
			Thread.initialize(new EnterFrameThreadExecutor());
			
			var application:Application = this['view'] as Application;
			
			if (application)
			{
				SWFWheel.initialize(application.systemManager.stage);
				SWFProfiler.init(application.systemManager.stage, application);
				
				application.data = { delegate: this };
				application.styleName = 'plain';
				application.setStyle('color', '#000000');
			}
		}
		
		override protected function initialize():void
		{
			config = createConfig();
			config.addEventListener(ApplicationEvent.APPLICATION_DID_FINISHED_INITIALIZING_CONFIG, configInitializedHandler);
			config.initialize();
		}
		
		protected function createConfig():Config
		{
			return new Config();
		}
		
		protected function initializeContext():void
		{
			context = new Context(config);
			context.traceApplicationInformation();
				
			BindingUtils.bindSetter(onContextStateChange, context, 'state');
		}
		
		protected function initializeModels():void
		{
			
		}
		
		protected function initializeViews():void
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
		
		private function configInitializedHandler(event:ApplicationEvent):void
		{
			initializeContext();
			initializeModels();
			initializeViews();
			initializeControllers();
		}
		
	}
}