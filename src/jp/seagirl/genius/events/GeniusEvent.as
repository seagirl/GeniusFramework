package jp.seagirl.genius.events
{
	import flash.events.Event;

	public class GeniusEvent extends Event
	{
		public static const ASSETES_LOADED:String = 'assetsLoaded';
		public static const UPDATE_PAGE:String = 'updatePage';
		public static const NOTIFIED:String = 'notified';
		
		public function GeniusEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		public var data:Object;
		
	}
}