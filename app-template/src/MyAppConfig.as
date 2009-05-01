package
{
	import jp.seagirl.genius.core.IConfig;
	
	public class [% name %]Config implements IConfig
	{
		// アプリケーションの名前
		public function get applicationName():String
		{
			return '[% name %]';
		}
		
		// アプリケーションのバージョン
		public function get applicationVersion():String
		{
			return '1.0.0';
		}
		
		// デフォルトの状態
		public function get defaultState():Object
		{
			return { page: 'Page1' };
		}
		
	}
}