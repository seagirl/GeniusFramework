package jp.seagirl.genius.controllers
{
	import mx.events.FlexEvent;
	
	public class ItemRendererController extends Controller
	{		
		override protected function view_initializeHandler(event:FlexEvent):void
		{
			super.view_initializeHandler(event);
			
			this['view'].addEventListener(FlexEvent.DATA_CHANGE, view_dataChangeHandler);
		}
		
		protected function view_dataChangeHandler(event:FlexEvent):void
		{
			update();
		}
		
		
		
	}
}