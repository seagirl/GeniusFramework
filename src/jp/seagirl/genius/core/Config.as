/**
 * Licensed under the MIT License
 * 
 * Copyright (c) 2009 seagirl
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
 
 package jp.seagirl.genius.core
{	
	public class Config
	{
		public function Config()
		{

		}
		
		private var _applicationName:String = 'Genius Application';

		public function get applicationName():String
		{
			return _applicationName;
		}
		
		public function set applicationName(value:String):void
		{
			_applicationName = value;
		}
		
		private var _applicationVersion:String = '1.0.0';
		
		public function get applicationVersion():String
		{
			return _applicationVersion;
		}
		
		public function set applicationVersion(value:String):void
		{
			_applicationVersion = value;
		}
		
		private var _defaultState:Object = { page: 'Page1' };
		
		public function get defaultState():Object
		{
			return _defaultState;
		}
		
		public function set defaultState(value:Object):void
		{
			_defaultState = value;
		}
		
		private var _errorCodes:Object =
		{
			'unknown': 0,
			'server' : 99,
			'io'     : 100
		};
		
		public function set errorCodes(val:Object):void
		{
			_errorCodes = val;
		}

		public function get errorCodes():Object
		{
			return _errorCodes;
		}
		
		private var _errorMessages:Object =
		{
			0:   'Unknown Error',
			99:  'Server Error',
			100: 'IO Error or Security Error'
		};
		
		public function set errorMessages(val:Object):void
		{
			_errorMessages = val;
		}

		public function get errorMessages():Object
		{
			return _errorMessages;
		}
		
		private var _localBaseURL:String;
		
		public function set localBaseURL(val:String):void
		{
			_localBaseURL = val;
		}

		public function get localBaseURL():String
		{
			return _localBaseURL;
		}
		
		private var _baseURL:String;
		
		public function set baseURL(val:String):void
		{
			_baseURL = val;
		}
		
		public function get baseURL():String
		{
			return _baseURL;
		}
		
		private var _serviceURL:String;
		
		public function set serviceURL(val:String):void
		{
			_serviceURL = val;
		}

		public function get serviceURL():String
		{
			return _serviceURL;
		}
	}
}