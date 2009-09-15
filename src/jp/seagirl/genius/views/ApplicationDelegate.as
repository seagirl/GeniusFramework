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
	
	import flash.events.ContextMenuEvent;
	import flash.external.ExternalInterface;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import jp.seagirl.genius.controllers.ViewController;
	import jp.seagirl.genius.core.Config;
	import jp.seagirl.genius.core.Context;
	import jp.seagirl.genius.events.GeniusEvent;
	import jp.seagirl.genius.models.IModel;
	
	import mx.binding.utils.BindingUtils;
	import mx.core.Application;
	import mx.events.FlexEvent;
	
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
		
		protected function createConfig():Config
		{
			return new Config();
		}
		
		override public function initialized(document:Object, id:String):void
		{
			if (!Thread.isReady)
				Thread.initialize(new EnterFrameThreadExecutor());
			
			if (!hasOwnProperty('view'))
				throw new Error("対応する View が見つかりません。");
			
			this['view'] = document;
			
			viewClass = getViewClass();
			
			var application:Application = this['view'] as Application;
			
			if (application)
			{
				application.data = { delegate: this };
				application.styleName = 'plain';
				application.setStyle('color', '#000000');
				
				application.addEventListener(FlexEvent.PREINITIALIZE, view_preinitializeHandler);
				application.addEventListener(FlexEvent.INITIALIZE, view_initializeHandler);
				application.addEventListener(FlexEvent.CREATION_COMPLETE, view_creationCompleteHandler);
			}
		}
		
		override protected function initialize():void
		{

		}
		
		protected function loadAssets():void
		{
			dispatchEvent(new GeniusEvent(GeniusEvent.ASSETES_LOADED));
		}
		
		protected function createContextMenu():void
		{
			var target:Application = this['view'] as Application;
			
			var item:ContextMenuItem = new ContextMenuItem("Reload");
			item.separatorBefore = true;
			item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, itemSelectHandler);
			
			var menu:ContextMenu = target.contextMenu as ContextMenu;
			menu.hideBuiltInItems();
			menu.customItems = [item].concat(menu.customItems);
			target.contextMenu = menu;
		}
		
		public function changePage(data:Object):void
		{
			
		}
		
		public function getModel(modelName:String):IModel
		{
			return context.getModel(modelName);
		}
		
		public function hasModel(modelName:String):Boolean
		{
			return context.hasModel(modelName);
		}
		
		public function addModel(model:IModel):void
		{
			context.addModel(model);
		}
		
		public function removeModel(modelName:String):IModel
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
		
		private function onContextStateChange(data:Object):void
		{
			if (this['view'] == null || data == null)
				return;
			
			changePage(data);
		}
		
		private function assetsLoadedHandler(event:GeniusEvent):void
		{
			initialize();
		}
		
		override protected function view_preinitializeHandler(event:FlexEvent):void
		{
			this['view'].removeEventListener(FlexEvent.PREINITIALIZE, view_preinitializeHandler);
			
			preinitialize();
		}
		
		override protected function view_initializeHandler(event:FlexEvent):void
		{
			this['view'].removeEventListener(FlexEvent.INITIALIZE, view_initializeHandler);
			
			var application:Application = this['view'] as Application;
			
			if (application)
			{
				context = new Context(createConfig());
				context.traceApplicationInformation();
				
				BindingUtils.bindSetter(onContextStateChange, context, 'state');
				
				SWFWheel.initialize(application.systemManager.stage);
				SWFProfiler.init(application.systemManager.stage, application);
			}
			
			addEventListener(GeniusEvent.ASSETES_LOADED, assetsLoadedHandler);
			loadAssets();
		}
		
		private function itemSelectHandler(event:ContextMenuEvent):void
		{
			var caption:String = ContextMenuItem(event.target).caption;
			
			if (caption === "Reload")
			{
				ExternalInterface.call("document.location.reload");
			}
		}
		
	}
}