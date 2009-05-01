package [% package %].views
{
	import flash.events.MouseEvent;
	
	import jp.seagirl.genius.controllers.ViewController;
	
	import [% package %].threads.ChangeStateThread;

	public class Page2Delegateextends ViewController
	{
		public var view:Page2;
		
		override protected function initialize():void
		{
			trace('initialize page2.');
			
			view.button.addEventListener(MouseEvent.CLICK, buttonClickHandler);	
		}
		
		override public function update():void
		{
			trace('update page2.');
		}

		private function buttonClickHandler(event:MouseEvent):void
		{	
			new ChangeStateThread().startWithData({ page: 'Page1' });
		}
		
	}
}