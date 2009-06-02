package jp.seagirl.preloaders
{
	import jp.seagirl.genius.core.Config;
	import jp.seagirl.genius.events.ApplicationEvent;
	
	import mx.preloaders.DownloadProgressBar;

	public class GeniusPreloader extends DownloadProgressBar
	{
		private static var _config:Config;
		
		public static function get config():Config
		{
			return _config;
		}
		
		public function GeniusPreloader()
		{
			super();
		}
		
		protected function createConfig():Config
		{
			return new Config();
		}
		
		override public function initialize():void
		{
			trace('p_initialize')
			GeniusPreloader._config = createConfig();
			config.addEventListener(ApplicationEvent.APPLICATION_DID_FINISHED_INITIALIZING_CONFIG, configInitializedHandler);
			config.initialize();
		}
		
		private function configInitializedHandler(event:ApplicationEvent):void
		{
			trace('p_configInitializedHandler')
			super.initialize();
		}
		
	}
}