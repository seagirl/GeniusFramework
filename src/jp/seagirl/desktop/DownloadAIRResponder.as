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

package jp.seagirl.desktop
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.utils.ByteArray;
	
	import jp.seagirl.genius.business.IResponder;
	import jp.seagirl.filesystem.FileIO;

	/**
	 * ダウンロード処理において、サービスクラスの要求に呼応するクラスです。
	 * 
	 * @author yoshizu
	 */	
	public class DownloadAIRResponder extends EventDispatcher implements IResponder
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * コンストラクタ
		 * 
		 * @param saveAs
		 */		
		public function DownloadAIRResponder(saveAs:String)
		{
			this.saveAs = saveAs;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private 
		 */		
		private var saveAs:String;
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @see jp.s2factory.genius.business.IResponder
		 */
		public function complete(event:Event):void
		{
			var fileIO:FileIO = new FileIO();
			fileIO.writeBinary(saveAs, ByteArray(event.target.data));
			dispatchEvent(new ApplicationUpdateEvent(Event.COMPLETE));
		}
		
		/**
		 * @see jp.s2factory.genius.business.IResponder
		 */
		public function ioError(event:IOErrorEvent):void
		{
		}
		
		/**
		 * @see jp.s2factory.genius.business.IResponder
		 */
		public function progress(event:ProgressEvent):void
		{
			dispatchEvent(event);
		}
		
		/**
		 * @see jp.s2factory.genius.business.IResponder
		 */
		public function securityError(event:SecurityErrorEvent):void
		{
		}
		
	}
}