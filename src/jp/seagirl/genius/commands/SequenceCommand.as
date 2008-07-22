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

package jp.seagirl.genius.commands
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import jp.seagirl.genius.controllers.GeniusEvent;
	import jp.seagirl.genius.controllers.GeniusEventDispatcher;
	
	//--------------------------------------
	//  Events
	//--------------------------------------
	
	/**
	 * 処理が完了すると発行されます。
	 * 
	 * @eventType flash.events.Event.COMPLETE
	 */
	[Event(name="complete", type="flash.events.Event")]
	
	/**
	 * SequenceCommandはシーケンスで使われるコマンドの実装クラスです。
	 * （互換性のために残してある古いクラスです。）
	 * 
	 * @author yoshizu 
	 */	
	public class SequenceCommand extends EventDispatcher implements ISequenceCommand
	{	
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private 
		 */		
		private var _nextEvent:GeniusEvent;
		
		/**
		 * 処理終了後に実行するイベントです。
		 * 
		 * @return  
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
		 * @inheritDoc
		 */		
		public function execute(event:GeniusEvent):void
		{
			nextEvent = event.nextEvent;
		}

	}
}