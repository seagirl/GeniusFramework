package
{
	import jp.seagirl.genius.core.ApplicationConfig;
	
	public class [% name %]Config extends ApplicationConfig
	{
		override protected function initialize():void
		{
			// アプリケーションの名前
			applicationName = '[% name %]';
			
			// アプリケーションのバージョン
			applicationVersion = '1.0.0';
			
			// デフォルトの状態
			defaultState = { page: 'Page1' };
		}
	}
}