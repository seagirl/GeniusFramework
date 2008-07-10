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
	
	import mx.containers.Canvas;
	import mx.controls.TextArea;
	import mx.controls.listClasses.ListBase;
	import mx.core.Application;
	
	/**
	 * Macでもホイールスクロールが動作するようにするためのクラスです。
	 * 
	 * @author yoshizu 
	 */	
	public final class MouseWheelSupport
	{
		//--------------------------------------------------------------------------
		//
		//  Class variables
		//
		//--------------------------------------------------------------------------
		
		public static const js:String = "" + 
			"function (objectID)" + 
			"{" + 
			"	function MouseWheelSupport(swf)" + 
			"	{" + 
			"		this.swf = swf;" + 
			"		this.init();" + 
			"	}" + 
			"" + 
			"	MouseWheelSupport.prototype =" + 
			"	{" + 
			"		init: function ()" + 
			"		{" + 
			"			MouseWheelSupport.instance = this;" + 
			"" + 
			"			if (window.addEventListener)" + 
			"			{" + 
			"				window.addEventListener('DOMMouseScroll', MouseWheelSupport.instance.wheel, false);" + 
			"			}" + 
			"			window.onmousewheel = document.onmousewheel = MouseWheelSupport.instance.wheel;" + 
			"		}," + 
			"" + 
			"		handle: function (delta, mouseX, mouseY)" + 
			"		{" + 
			"			this.swf.dispatchMouseWheelEvent(delta, mouseX, mouseY);" + 
			"		}," + 
			"" + 
			"		wheel: function (event)" + 
			"		{" + 
			"			var delta = 0;" + 
			"			var mouseX;" + 
			"			var mouseY;" + 
			"" + 
			"			if (event.wheelDelta)" + 
			"			{" + 
			"				delta = Math.round(event.wheelDelta / 80);" + 
			"				if (window.opera)" + 
			"					delta = -delta;" + 
			"			}" + 
			"			else if (event.detail)" + 
			"			{" + 
			"				delta = -event.detail / 3;" + 
			"			}" + 
			"" + 
			"			if (/AppleWebKit/.test(navigator.userAgent))" + 
			"				delta /= 3;" + 
			"" + 
			"			if ((navigator.userAgent.indexOf('Firefox') > -1) ||" + 
			"				(navigator.userAgent.indexOf('Camino') > -1))" + 
			"			{" + 
			"				mouseX = event.layerX;" + 
			"				mouseY = event.layerY;" + 
			"			}" + 
			"			else" + 
			"			{" + 
			"				mouseX = event.offsetX;" + 
			"				mouseY = event.offsetY;" + 
			"			}" + 
			"" + 
			"			if (delta)" + 
			"				MouseWheelSupport.instance.handle(delta, mouseX, mouseY);" + 
			"" + 
			"			if (event.preventDefault)" + 
			"				event.preventDefault();" + 
			"" + 
			"			event.returnValue = false;" + 
			"		}" + 
			"	};" + 
			"" + 
			"	new MouseWheelSupport(document[objectID]);" + 
			"}";
		
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
					ExternalInterface.call(js, ExternalInterface.objectID);
				}
			}
		}
		
		private function calcurateDelta(value:Number):Number
		{
			var delta:Number;
			
			if (value < 1 && value > 0)
				delta = 1;
			else if (value > -1 && value < 0)
				delta = -1;
			else
				delta = value;
				
			return delta;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private 
		 */	
		private function mouseWheelHandler(delta:Number, mouseX:Number, mouseY:Number):void
		{
			delta = calcurateDelta(delta);
			
			var stage:Stage = Application.application.systemManager.stage;
			var items:Array = stage.getObjectsUnderPoint(new Point(mouseX, mouseY));
			for each (var item:DisplayObject in items)
			{
				item = item.parent;
				if (item is InteractiveObject)
				{
					if (item is TextArea) {
						var textArea:TextArea = item as TextArea;
						textArea.verticalScrollPosition -= delta;
					}
					else if (item is Canvas || item is ListBase)
					{
						var wheelEvent:MouseEvent = new MouseEvent(MouseEvent.MOUSE_WHEEL);
						wheelEvent.delta = delta;
						item.dispatchEvent(wheelEvent);
					}
				}
			}	
		}
	}
}
