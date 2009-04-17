package [% package %].controllers
{
	import flash.events.MouseEvent;
	
	import jp.seagirl.genius.controllers.ViewController;
	
	import [% package %].threads.ChangeStateThread;
	
	import [% package %].views.Page2;

	public class Page2Controller extends ViewController
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