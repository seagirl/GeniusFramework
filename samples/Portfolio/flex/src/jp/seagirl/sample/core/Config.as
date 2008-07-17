package jp.seagirl.sample.core
{
	import flash.system.Security;
	
	import mx.core.Application;
	
	public class Config
	{	
		public static const LOCAL_BASE_URL:String = 'http://localhost/~yoshizu/libspark/as3/GeniusFramework/trunk/samples/Portfolio/htdocs/';	
		
		public static const BASE_URL:String = initializeBaseURL();
		public static const API_URL:String = BASE_URL + 'api/index.cgi';
		
		private static function initializeBaseURL():String
		{
			if ((Security.sandboxType.indexOf('local') != -1))
				return LOCAL_BASE_URL;
			else
				return mx.core.Application.application.url.replace(/\/[0-9a-zA-Z_-]+\.swf$/, '/');
		}

	}
}