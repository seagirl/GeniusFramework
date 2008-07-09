package jp.seagirl.sample.threads
{
	import jp.seagirl.genius.managers.ApplicationManager;
	import jp.seagirl.genius.threads.GeniusThread;
	
	public class ChangeStateThread extends GeniusThread
	{
		override protected function run():void
		{
			if (data == null)
				data = ApplicationManager.instance.defaultState;
			
			ApplicationManager.instance.state = data;
		}
		
	}
}