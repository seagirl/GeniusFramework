package jp.seagirl.genius.core
{
	import flash.system.Security;
	
	import mx.core.Application;
	
	public class ApplicationConfig implements IConfig
	{
		public function ApplicationConfig()
		{
			initialize();
		}
		
		private var _applicationName:String;

		public function get applicationName():String
		{
			return _applicationName;
		}
		
		public function set applicationName(value:String):void
		{
			_applicationName = value;
		}
		
		private var _applicationVersion:String;
		
		public function get applicationVersion():String
		{
			return _applicationVersion;
		}
		
		public function set applicationVersion(value:String):void
		{
			_applicationVersion = value;
		}
		
		private var _defaultState:Object;
		
		public function get defaultState():Object
		{
			return _defaultState;
		}
		
		public function set defaultState(value:Object):void
		{
			_defaultState = value;
		}
		
		private var _pageLengh:int = 100;
		
		public function set pageLengh(val:int):void
		{
			_pageLengh = val;
		}

		public function get pageLengh():int
		{
			return _pageLengh;
		}

		private var _statuCodes:Object;
		
		public function set statuCodes(val:Object):void
		{
			_statuCodes = val;
		}

		public function get statuCodes():Object
		{
			return _statuCodes;
		}
		
		private var _statusNames:Object;
		
		public function set statusNames(val:Object):void
		{
			_statusNames = val;
		}

		public function get statusNames():Object
		{
			return _statusNames;
		}
		
		private var _errorCodes:Object =
		{
			'Unknown': 0,
			'Server' : 99,
			'IO'     : 100
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
		
		private var _timerInterval:int = 5; // minutes
		
		public function set timerInterval(val:int):void
		{
			_timerInterval = val;
		}

		public function get timerInterval():int
		{
			return _timerInterval;
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
		
		private var _serviceURL:String;
		private var _application:Application = Application.application as Application;
		
		public function set serviceURL(val:String):void
		{
			_serviceURL = val;
		}

		public function get serviceURL():String
		{
			return Security.sandboxType.indexOf('local') != -1
				? _localBaseURL + _serviceURL
				: _application.url.replace(/\/[0-9a-zA-Z_-]+\.swf$/, _serviceURL);
		}
		
		protected function initialize():void
		{
			
		}
			
	}
}