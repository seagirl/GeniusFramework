package jp.seagirl.genius.core
{
	import com.adobe.serialization.json.JSON;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Security;
	
	import jp.seagirl.genius.events.ApplicationEvent;
	
	import mx.core.Application;
	
	import org.as3yaml.YAML;
	
	[Event(name="applicationDidFinishedInitializingConfig", type="jp.seagirl.genius.events.ApplicationEvent")]
	
	dynamic public class Config extends EventDispatcher
	{
		public function Config(source:Object = null)
		{
			this.source = source;
		}
		
		private var source:Object;
		
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
		
		public function initialize():void
		{
			if (source != null && source is String)
			{
				load();
				return;
			}
			
			process(source);
		}
		
		private function load():void
		{	
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loaderErrorHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loaderErrorHandler);
			loader.load(new URLRequest(source as String));
		}
		
		private function process(data:Object = null):void
		{
			for (var key:Object in data)
			{
				this[key] = data[key];
			}
			
			dispatchEvent(new ApplicationEvent(ApplicationEvent.APPLICATION_DID_FINISHED_INITIALIZING_CONFIG));
		}
		
		private function loaderErrorHandler(event:ErrorEvent):void
		{
			process();
		}
		
		private function loaderCompleteHandler(event:Event):void
		{
			var flagments:Array = source.split('.');
			var extension:String = flagments[flagments.length - 1] as String;
			var data:Object;
			
			switch (extension)
			{
				case "yaml":
				{
					data = YAML.decode(event.target.data);
					break;
				}
				case "json":
				{
					data = JSON.decode(event.target.data);	
					break;
				}
			}
		
			process(data);
		}	
	}
}