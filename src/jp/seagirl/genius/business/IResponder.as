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

package jp.seagirl.genius.business
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;

	/**
	 * サービスの呼び出しに応答するクラスを定義するインターフェースです。
	 * 
	 * @author yoshizu
	 */     
	public interface IResponder
	{
		/**
		 *  結果を受け取り終わるとサービスに呼び出されるメソッドです。
		 */
		function complete(event:Event):void;
		
		/**
		 *  IOエラーが起こるとサービスに呼び出されるメソッドです。
		 */
		function ioError(event:IOErrorEvent):void;
		
		/**
		 *  結果を受け取っている間、サービスに呼び出されるメソッドです。
		 */
		function progress(event:ProgressEvent):void;
		
		/**
		 *  セキュリティエラーが起こるとサービスに呼び出されるメソッドです。
		 */	
		function securityError(event:SecurityErrorEvent):void;
	}
}