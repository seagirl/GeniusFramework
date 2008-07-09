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
	import flash.events.Event;

	/**
	 * GeniusEventはGeniusで使用するイベントクラスです。
	 * 
	 * @author yoshizu
	 */
	public class GeniusEvent extends Event
	{	
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *　コンストラクタ
		 *  
		 * @param type
		 * @param bubbles
		 * @param cancelable
		 * @see flash.events.Event
		 */		
		public function GeniusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  data
		//----------------------------------
		
		/**
		 * @private 
		 */		
		private var _data:*;
		
		/**
		 * イベントの取り回し時に使用出来る汎用的なデータオブジェクトです。
		 */
		public function get data():*
		{
			return _data;
		}
		
		/**
		 * @private 
		 */		
		public function set data(value:*):void
		{
			_data = value;
		}
		
		//----------------------------------
		//  nextEvent
		//----------------------------------
		
		/**
		 * @private 
		 */		
		private var _nextEvent:GeniusEvent;
		
		/**
		 * 実行時にISequenceCommandのnextEventプロパエィに渡されます。
		 */
		public function get nextEvent():GeniusEvent
		{
			return _nextEvent;
		}
		
		/**
		 * @private 
		 */		
		public function set nextEvent(value:GeniusEvent):void
		{
			_nextEvent = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * 自分自身をGeniusEventDispatcherに送出させるメソッドです。
		 * 
		 * @return
		 */
		public function dispatch(data:* = null):Boolean
		{
			if (data != null)
				_data = data;
			return GeniusEventDispatcher.instance.dispatchEvent(this);
		}
	}
}