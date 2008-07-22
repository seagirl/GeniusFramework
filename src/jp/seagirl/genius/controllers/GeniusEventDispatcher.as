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
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * GeniusEventDispatcherはGeniusで扱うイベントを送出するクラスです。
	 * （互換性のために残してある古いクラスです。）
	 * 
	 * @author yoshizu
	 */
	public class GeniusEventDispatcher
	{	
		//--------------------------------------------------------------------------
		//
		//  Class properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  instance
		//----------------------------------
		
		/**
		 * @private 
		 */	
		private static var _instance:GeniusEventDispatcher;
		
		/**
		 * このクラスの唯一のインスタンスです。
		 */		
		public static function get instance():GeniusEventDispatcher
		{
			if (_instance == null)
				_instance = new GeniusEventDispatcher();
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
		public function GeniusEventDispatcher(target:IEventDispatcher=null)
		{
			if (_instance != null)
				throw new Error("Public construction not allowed.");
			eventDispatcher = new EventDispatcher(target);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 * 操作を委譲するために、flash.events.EventDispatcherクラスの
		 * インスタンスを保持しておくオブジェクトです。
		 */
		private var eventDispatcher:IEventDispatcher;
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * リスナーオブジェクトを登録するメソッド
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/**
		 * リスナーオブジェクトを削除するメソッドです。
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			eventDispatcher.removeEventListener(type, listener, useCapture);
		}
		
		/**
		 * イベントをイベントフローに送出するメソッドです。
		 */
		public function dispatchEvent(event:GeniusEvent):Boolean
		{
			return eventDispatcher.dispatchEvent(event);
		}
		
		/**
		 * 特定のイベントタイプに対して登録されたリスナーがあるかどうか確認するメソッドです。
		 */
		public function hasEventListener(type:String):Boolean
		{
			return eventDispatcher.hasEventListener(type);
		}
		
		/**
		 * 特定のイベントタイプに対して、このオブジェクトまたはその祖先に、
		 * 登録されたリスナーがあるかどうか確認するメソッドです。
		 */
		public function willTrigger(type:String):Boolean
		{
			return eventDispatcher.willTrigger(type);	
		}
	}
}