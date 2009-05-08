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

package jp.seagirl.controls
{
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import jp.seagirl.genius.threads.ChangeStateThread;
	
	import mx.controls.Label;

	/**
	 * Linkはmx.controls.Labelの拡張です。
	 * 
	 * @author yoshizu 
	 */	
	public class Link extends Label
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/** 
		 * コンストラクタ
		 */		
		public function Link()
		{
			super();
			useHandCursor = true;
			buttonMode = true;
			mouseChildren = false;
			setStyle('textDecoration', 'underline');
		}
		
		private var type:String;
		
		private var _href:String;
		
		public function get href():String
		{
			return _href;
		}
		
		public function set href(value:String):void
		{
			_href = value;
			
			if (_href.indexOf('http://') > -1 ||
				_href.indexOf('https://') > -1)
				type = 'external';
			else
				type = 'internal';
			
			if (!hasEventListener(MouseEvent.CLICK))
				addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function clickHandler(event:MouseEvent):void
		{
			if (type === 'external')
			{
				navigateToURL(new URLRequest(href));
			}
			else
			{
				new ChangeStateThread().startWithData({ page: href });	
			}
		}
	}
}