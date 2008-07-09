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
	import flash.net.URLRequestMethod;
	
	/**
	 * サービスクラスを使った処理を委譲されるクラスです。
	 * 
	 * @author yoshizu 
	 */	
	public class BusinessDelegate
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		/**
		 * コンストラクタ
		 * 
		 * @param responder 
		 */		
		public function BusinessDelegate(responder:IResponder)
		{
			_responder = responder;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//----------------------------------
		//  controller
		//----------------------------------
		
		private var _controller:String;
		
		/**
		 * コントローラ
		 * 
		 * @return  
		 */		
		public function get controller():String
		{
			return _controller;
		}
		
		public function set controller(value:String):void
		{
			_controller = value;
		}
		
		//----------------------------------
		//  responder
		//----------------------------------
		
		private var _responder:IResponder;
		
		/**
		 * サービスの要求に答える
		 * 
		 * @see jp.seagirl.genius.business.IResponder
		 * @return  
		 */		
		public function get responder():IResponder
		{
			return _responder;
		}
		
		public function set responder(value:IResponder):void
		{
			_responder = value;
		}
		
		//----------------------------------
		//  service
		//----------------------------------
		
		private var _service:IService;
		
		/**
		 * サービス
		 * 
		 * @see jp.seagirl.genius.business.IService
		 * @return  
		 */		
		public function get service():IService
		{
			return _service;
		}
		
		public function set service(value:IService):void
		{
			_service = value;
		}
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 * サービスにコマンドを送ります。
		 * 
		 * @param action
		 * @param params 
		 */		
		public function execute(params:Object = null):void
		{
			if (params == null)
				params = {};
			
			if (_service == null)
				throw new Error("Can't find any Service.");
			_service.addResponder(_responder);
			_service.send(params);
		}
		
		/**
		 * executeのショートカットです。
		 * 
		 * @param params 
		 */		
		public function load(params:Object = null):void
		{
			if (params == null)
				params = {};
			if (controller != null)
				params.controller = controller;
			params.action = 'load';
			execute(params);
		}
		
		/**
		 * executeのショートカットです。
		 * 
		 * @param params 
		 */	
		public function sync(params:Object):void
		{
			if (!params.hasOwnProperty('modified'))
				throw new Error('modified must be specified');
			if (controller != null)
				params.controller = controller;
			params.action = 'sync';
			execute(params);
		}
		
		/**
		 * executeのショートカットです。
		 * 
		 * @param params 
		 */	
		public function loadDetail(params:Object):void
		{
			if (!params.hasOwnProperty('id'))
				throw new Error('id must be specified');
			if (controller != null)
				params.controller = controller;
			params.action = 'loadDetail';
			execute(params);
		}
		
		/**
		 * executeのショートカットです。
		 * 
		 * @param params 
		 */	
		public function create(params:Object = null):void
		{
			if (params == null)
				params = {};
			if (controller != null)
				params.controller = controller;
			params.action = 'create';
			execute(params);
		}
		
		/**
		 * executeのショートカットです。
		 * 
		 * @param params 
		 */	
		public function update(params:Object):void
		{
			if (!params.hasOwnProperty('id'))
				throw new Error('id must be specified');
			if (controller != null)
				params.controller = controller;
			params.action = 'update';
			execute(params);
		}
		
		/**
		 * executeのショートカットです。
		 * 
		 * @param params 
		 */	
		public function remove(params:Object = null):void
		{
			if (!params.hasOwnProperty('id'))
				throw new Error('id must be specified');
			if (controller != null)
				params.controller = controller;
			params.action = 'delete';
			execute(params);
		}

	}
}