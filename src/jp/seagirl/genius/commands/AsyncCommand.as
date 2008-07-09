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
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	
	import jp.seagirl.genius.business.IResponder;

	/**
	 * AsyncCommandは非同期通信に使われるコマンドの実装クラスです。
	 * IResponderを実装します。
	 * 
	 * @author yoshizu 
	 * @see jp.s2factory.genius.business.IResponder
	 */	
	public class AsyncCommand extends SequenceCommand implements IResponder
	{		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */		
		public function complete(event:Event):void
		{
		}
		
		/**
		 * @inheritDoc
		 */		
		public function ioError(event:IOErrorEvent):void
		{
			throw new Error(event);
		}
		
		/**
		 * @inheritDoc
		 */		
		public function progress(event:ProgressEvent):void
		{
		}
		
		/**
		 * @inheritDoc
		 */		
		public function securityError(event:SecurityErrorEvent):void
		{
			throw new Error(event);
		}
		
	}
}