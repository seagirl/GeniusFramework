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
	 * Sequenceはイベントのシーケンスを作成するクラスです。
	 * （互換性のために残してある古いクラスです。）
	 * 
	 * @author yoshizu
	 */
	public class Sequence
	{	
		//--------------------------------------------------------------------------
		//
		//  variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 * 
		 * イベントを格納するための配列です。
		 */
		protected var repository:Array = [];
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * シーケンスにイベントを追加します。
		 * 
		 * @param event 
		 */		
		public function addEvent(event:GeniusEvent):void
		{
			repository.push(event);
		}
		
		/**
		 * シーケンスに複数のイベントを追加します。
		 * 
		 * @param events 
		 */		
		public function addEvents(events:Array):void
		{
			for each (var event:GeniusEvent in events)
			{
				repository.push(event);
			}
		}
		
		/**
		 * シーケンスを開始します。
		 * 
		 * @return
		 */
		public function run():Boolean
		{	
			for (var i:int = 0; i < repository.length; i++)
			{	
				if (i < repository.length - 1)
				{
					var event:GeniusEvent = repository[i];
					var nextEvent:GeniusEvent = repository[i + 1];
					event.nextEvent = nextEvent;
				}
			}
			
			var firstEvent:GeniusEvent = repository[0];
			return GeniusEventDispatcher.instance.dispatchEvent(firstEvent);
		}
	}
}