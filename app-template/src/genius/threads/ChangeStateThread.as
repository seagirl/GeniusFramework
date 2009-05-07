package [% package %].threads
{
	import jp.seagirl.genius.core.Context;
	import jp.seagirl.genius.threads.GeniusThread;
	
	public class ChangeStateThread extends GeniusThread
	{	
		override protected function run():void
		{
			if (data == null)
				data = context.config.defaultState;
				
			var newState:Object = {};
			
			for (var key1:String in context.state)
			{				
				newState[key1] = context.state[key1];
			}
				
			for (var key2:String in data)
			{
				newState[key2] = data[key2];
			}
			
			context.state = newState;
		}
		
	}
}
