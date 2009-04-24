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
 
 package jp.seagirl.genius.controllers
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import jp.seagirl.genius.core.Context;
	
	import mx.core.IMXMLObject;
	import mx.events.FlexEvent;

	public class AbstractDelegate implements IMXMLObject
	{
		public function AbstractDelegate()
		{
			if (Object(this).constructor == AbstractDelegate)
			{
				throw new Error("This is a abstract class.");	
			}
		}
		
		public var context:Context;
		public var viewClass:Class;
		
		protected function getViewClass():Class
		{
			var className:String = getQualifiedClassName(this['view']);				
			var viewClassName:String = className.replace(/::/g, '.');
			var viewClass:Class;
			
			try
			{
				viewClass = getDefinitionByName(viewClassName) as Class
			}
			catch(e:Error)
			{
				viewClass = null;
			}
			
			return viewClass;
			
		}

		public function initialized(document:Object, id:String):void
		{
			if (!hasOwnProperty('view'))
				throw new Error("対応する View が見つかりません。");
			
			this['view'] = document;
			
			viewClass = getViewClass();
			
			this['view'].addEventListener(FlexEvent.PREINITIALIZE, view_preinitializeHandler);
			this['view'].addEventListener(FlexEvent.INITIALIZE, view_initializeHandler);
			this['view'].addEventListener(FlexEvent.CREATION_COMPLETE, view_creationCompleteHandler);
		}
		
		protected function preinitialize():void
		{
			
		}
		
		protected function initialize():void
		{
			
		}
		
		protected function creationComplete():void
		{
			
		}
		
		public function update():void
		{
			
		}
		
		/**
		 * FlexEvent.PREINITIALIZEで呼ばれるハンドラ
		 * @param event 
		 */
		protected function view_preinitializeHandler(event:FlexEvent):void
		{
			this['view'].removeEventListener(FlexEvent.PREINITIALIZE, view_preinitializeHandler);
			
			preinitialize();
		}
		
		/**
		 * FlexEvent.INITIALIZEで呼ばれるハンドラ
		 * @param event 
		 */
		protected function view_initializeHandler(event:FlexEvent):void
		{
			this['view'].removeEventListener(FlexEvent.INITIALIZE, view_initializeHandler);
			
			initialize();
		}
		 
		/**
		 * FlexEvent.CREATION_COMPLETEで呼ばれるハンドラ
		 * @param event 
		 */		 
		protected function view_creationCompleteHandler(event:FlexEvent):void
		{
			this['view'].removeEventListener(FlexEvent.CREATION_COMPLETE, view_creationCompleteHandler);
			
			creationComplete();
		}
		
	}
}