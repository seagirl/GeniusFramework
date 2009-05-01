package [% package %].views
{
	import flash.events.MouseEvent;
	
	import jp.seagirl.genius.controllers.ViewController;
	
	import [% package %].threads.ChangeStateThread;

	public class Page1Delegate extends ViewController
	{
		public var view:Page1;
		
		override protected function initialize():void
		{
			trace('initialize page1.');
			
			view.button.addEventListener(MouseEvent.CLICK, buttonClickHandler);	
		}
		
		override public function update():void
		{
			trace('update page1.');
		}

		private function buttonClickHandler(event:MouseEvent):void
		{	
			new ChangeStateThread().startWithData({ page: 'Page2' });
		}
		
	}
}