package [% package %].controllers
{
	import flash.events.MouseEvent;
	
	import jp.seagirl.genius.controllers.ViewController;
	import jp.seagirl.genius.threads.ChangeStateThread;
	
	import [% package %].views.Page1;

	public class Page1Controller extends ViewController
	{	
		public function Page1Controller(view:Object)
		{
			super(view);	
		}
		
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