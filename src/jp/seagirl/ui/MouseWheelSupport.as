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

package jp.seagirl.ui {
	
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.geom.Point;
	import flash.system.Capabilities;
	import flash.utils.getTimer;
	
	import mx.containers.Canvas;
	import mx.controls.TextArea;
	import mx.controls.listClasses.ListBase;
	import mx.core.Application;
	
	/**
	 * Macでもホイールスクロールが動作するようにするためのクラスです。
	 * MouseWheelSupport.jsを使います。
	 * 
	 * @author yoshizu 
	 */	
	public final class MouseWheelSupport
	{
		//--------------------------------------------------------------------------
		//
		//  Class properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private 
		 */		
		private static var _instance:MouseWheelSupport;
		
		/**
		 * インスタンスを返します。
		 */
		public static function get instance():MouseWheelSupport
		{
			if (_instance == null)
				_instance = new MouseWheelSupport();
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
		public function MouseWheelSupport()
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
		private var lastTime:int;
		
		/**
		 * @private 
		 */	
		private var lastDelta:int;
		
		/**
		 * @private 
		 */	
		private var irregularCount:int;
		
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
			if (Capabilities.os.toLowerCase().indexOf('mac') > -1)
			{
				if (ExternalInterface.available)
				{
					ExternalInterface.addCallback("dispatchMouseWheelEvent", mouseWheelHandler);
					ExternalInterface.call("initializeMouseWheel");
				}
			}
		}
		
		/**
		 * @private 
		 */	
		private function validateDelta(delta:int):int
		{
			var currentTime:int = getTimer();
			var interval:int = currentTime - lastTime;
			lastTime = currentTime;
			
			if (delta != lastDelta)
			{
				if (irregularCount > 2 || interval > 200) {
					lastDelta = delta;
					irregularCount = 0;	
				}
				else
				{
					delta = lastDelta;
					irregularCount++;
				}
			}
			
			var speed:int = (interval < 1000) ? 1000 / interval : 1;
			var validatedDelta:int = (speed > 1200 ? 120 : speed) * delta * 0.1;
			return validatedDelta === 0 ? delta : validatedDelta;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private 
		 */	
		private function mouseWheelHandler(delta:int, mouseX:Number, mouseY:Number):void
		{
			var validatedDelta:int = validateDelta(delta);
			var stage:Stage = Application.application.stage;
			var items:Array = stage.getObjectsUnderPoint(new Point(mouseX, mouseY));
			for each (var item:DisplayObject in items)
			{
				item = item.parent;
				if (item is InteractiveObject)
				{
					if (item is TextArea) {
						var textArea:TextArea = item as TextArea;
						textArea.verticalScrollPosition -= validatedDelta / 6;
					}
					else if (item is Canvas || item is ListBase)
					{
						var wheelEvent:MouseEvent = new MouseEvent(
							MouseEvent.MOUSE_WHEEL,
							true,
							false,
							NaN,
							NaN,
							null,
							false,
							false,
							false,
							false,
							validatedDelta
						);
						item.dispatchEvent(wheelEvent);
					}
				}
			}	
		}
	}
}
