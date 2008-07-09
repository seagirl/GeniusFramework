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
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	
	import jp.seagirl.genius.business.IResponder;
	import jp.seagirl.filesystem.FileIO;

	/**
	 * アップデート情報をチェックする処理において、サービスの要求に呼応するクラスです。
	 * 
	 * @author yoshizu
	 */	
	public class CheckUpdateResponder extends EventDispatcher implements IResponder
	{
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private
		 */		
		private function compareVersions(oleVersion:String, newVersion:String):Boolean
		{
			var oleVersions:Array = oleVersion.split('.');
			var newVersions:Array = newVersion.split('.');
			
			for (var index:String in oleVersions)
			{
				if (int(oleVersions[index]) < int(newVersions[index]))
					return true;
				else if (int(oleVersions[index]) > int(newVersions[index]))
					return false
			}
			
			return false;
		}
		
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
			var result:XML = new XML(event.target.data);
			
			var fileIO:FileIO = new FileIO();
			fileIO.writeString('logs/download.log', event.target.data);
			
			if (result.hasOwnProperty('version'))
			{
				namespace ns="http://ns.adobe.com/air/application/1.0";
				use namespace ns;
				
				var oldVersion:String = NativeApplication.nativeApplication.applicationDescriptor.version;
				var newVersion:String = result.version;
				
				var completeEvent:ApplicationUpdateEvent = new ApplicationUpdateEvent(Event.COMPLETE);
				completeEvent.needUpdating = compareVersions(oldVersion, newVersion);
				completeEvent.newVersion = newVersion;
				
				dispatchEvent(completeEvent);
			}
			else
				throw new Error('受信したデータが不正です。', event.target.data);
		}
		
		/**
		 * @see jp.s2factory.genius.business.IResponder
		 */
		public function ioError(event:IOErrorEvent):void
		{
			throw new Error('ioError');
		}
		
		/**
		 * @see jp.s2factory.genius.business.IResponder
		 */
		public function progress(event:ProgressEvent):void
		{
		}
		
		/**
		 * @see jp.s2factory.genius.business.IResponder
		 */
		public function securityError(event:SecurityErrorEvent):void
		{
			throw new Error('securityError');
		}
		
	}
}