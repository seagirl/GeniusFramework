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
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	/**
	 * FileReferenceを使ったサービスクラスです。
	 * （互換性のために残してある古いクラスです。）
	 * 
	 * @author yoshizu
	 */
	public class FileReferenceService extends FileReference implements IService
	{	
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  コンストラクタ
		 */
		public function FileReferenceService()
		{
			super();
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  url
		//----------------------------------
		
		private var _url:String;
		
		/**
		 *  @inheritDoc
		 *  @see jp.s2factory.genius.business.IService
		 */
		public function get url():String
		{
			return _url;
		}

		public function set url(value:String):void
		{
			_url = value;
		}
		
		//----------------------------------
		//  method
		//----------------------------------
		
		private var _method:String;
		
		/**
		 *  @inheritDoc
		 *  @see jp.s2factory.genius.business.IService
		 */
		public function get method():String
		{
			return _method;
		}
		
		public function set method(value:String):void
		{
			_method = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *  Service要求を実行する
		 */
		public function send(params:Object):void
		{
			var typeFilter:Array = [];
			if (params.hasOwnProperty('typeFilter'))
				typeFilter = params.typeFilter;
			
			var uploadDataFieldName:String = 'Filedata';
			if (params.hasOwnProperty('uploadDataFieldName'))
				uploadDataFieldName = params.uploadDataFieldName;
				
			addEventListener(Event.SELECT, selectHandler(params, uploadDataFieldName));
			browse(typeFilter);
		}
		
		/**
		 *  サービスからの呼び出しに応答するクラスを登録する
		 */
		public function addResponder(responder:IResponder):void
		{
			addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, responder.complete);
			addEventListener(IOErrorEvent.IO_ERROR, responder.ioError);
			addEventListener(ProgressEvent.PROGRESS, responder.progress);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, responder.securityError);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------
		
		/**
		 * @private 
		 */		
		private function selectHandler(params:Object, uploadDataFieldName:String):Function
		{
			return function (event:Event):void
			{
				var variables:URLVariables = new URLVariables();
				for (var index:String in params) {
					variables[index] = params[index]
				}
				
				var request:URLRequest = new URLRequest();
				request.url = url;
				request.method = method;
				request.data = variables;
				
				var file:FileReference = FileReference(event.target);
				file.upload(request, uploadDataFieldName);
			}
		}
	}
}