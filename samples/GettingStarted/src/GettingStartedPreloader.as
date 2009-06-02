package
{
	import jp.seagirl.genius.core.Config;
	import jp.seagirl.preloaders.GeniusPreloader;

	public class GettingStartedPreloader extends GeniusPreloader
	{
		override protected function createConfig():Config
		{
			return new Config("assets/config.json");
		}
		
	}
}