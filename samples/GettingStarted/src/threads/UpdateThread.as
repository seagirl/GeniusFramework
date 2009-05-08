package threads
{
	import jp.seagirl.genius.core.Context;
	import jp.seagirl.genius.threads.GeniusThread;
	
	import models.MainModel;
	
	public class UpdateThread extends GeniusThread
	{		
		private var model:MainModel;
		
		override protected function run():void
		{
			model = getModel("MainModel") as MainModel;
			
			next(load);
		}
		
		private function load():void
		{
			next(complete);
		}
		
		private function complete():void
		{
			model.currentItem = <data>{ model.hello() }</data>;	
		}

	}
}