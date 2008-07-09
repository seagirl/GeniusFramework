package jp.seagirl.hello.views
{
	import flash.events.MouseEvent;
	
	import jp.seagirl.controls.Link;
	import jp.seagirl.genius.views.ViewBase;
	import jp.seagirl.hello.threads.ChangeStateThread;

	public class IntroBase extends ViewBase
	{
		public var link:Link;
		
		override protected function initializeView():void
		{
			// ここに初期化処理を記述します。
			// このビューが生成された時にのみ実行されます。
			
			trace('Initialize Intro.');
			
			link.addEventListener(MouseEvent.CLICK, linkClickHandler);
		}
		
		override protected function updateView():void
		{
			// ここに画面更新処理を記述します。
			// このビューが表示されると毎回実行されます。
			
			trace('Update Intro.');
		}
		
		private function linkClickHandler(event:MouseEvent):void
		{
			new ChangeStateThread().startWithData({ page: 'Test' });
		}
		
	}
}
