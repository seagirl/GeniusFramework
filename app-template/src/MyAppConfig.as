package
{
	import flash.system.Security;
	
	import jp.seagirl.genius.core.Config;
	
	import mx.core.Application;

	public class [% name %]Config extends Config
	{
		public function [% name %]Config(application:Application)
		{
			super();
			
			// アプリケーション名
			applicationName = '[% name %]';
				
			// アプリケーションのバージョン
			applicationVersion = '1.0';
				
			// デフォルトの状態
			defaultState = { page: 'Page1' };
			
			//  ベース URL
			baseURL = Security.sandboxType.indexOf('local') > -1
				? 'http://localhost/'
				: application.url.replace(/\/CMS\/[0-9a-zA-Z_-]+\.swf$/, '');
				
			// サービスの URL
			serviceURL = Security.sandboxType.indexOf('local') > -1
				? baseURL + '/CMS/test.cgi'
				: baseURL + '/CMS/api';
		}
	}
}