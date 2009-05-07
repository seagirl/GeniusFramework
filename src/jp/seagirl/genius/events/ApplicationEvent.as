package jp.seagirl.genius.events
{
	import flash.events.Event;

	public class ApplicationEvent extends Event
	{
		public static const APPLICATION_DID_FINISHED_INITIALIZING_CONFIG:String = 'applicationDidFinishedInitializingConfig';
		
		public function ApplicationEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}