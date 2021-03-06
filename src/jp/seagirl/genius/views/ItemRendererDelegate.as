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
 
 package jp.seagirl.genius.views
{
	import jp.seagirl.genius.controllers.ViewController;
	import jp.seagirl.genius.core.Config;
	import jp.seagirl.genius.models.IModel;
	
	import mx.events.FlexEvent;

	public class ItemRendererDelegate extends AbstractDelegate
	{	
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
		
		override protected function view_initializeHandler(event:FlexEvent):void
		{
			super.view_initializeHandler(event);
			
			if (this['view'].data)
				update();
			
			this['view'].addEventListener(FlexEvent.DATA_CHANGE, view_dataChangeHandler);
		}
		
		protected function view_dataChangeHandler(event:FlexEvent):void
		{
			if (this['view'].data)
				update();
		}
		
	}
}