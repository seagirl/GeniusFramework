package jp.seagirl.hello.threads
{
	import jp.seagirl.genius.managers.ApplicationManager;
	import jp.seagirl.genius.threads.GeniusThread;
	
	public class ChangeStateThread extends GeniusThread
	{
		override protected function run():void
		{
			if (data == null)
				data = { page: ApplicationManager.instance.defaultPage };
			
			ApplicationManager.instance.state = data;
		}
		
	}
}
