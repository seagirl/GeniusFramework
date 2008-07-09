package jp.seagirl.hello.views
{
	import flash.events.MouseEvent;
	
	import jp.seagirl.genius.views.ViewBase;
	import jp.seagirl.hello.threads.ChangeStateThread;
	
	import mx.controls.Button;

	public class TestBase extends ViewBase
	{
		public var button:Button;
		
		override protected function initializeView():void
		{
			// ここに初期化処理を記述します。
			// このビューが生成された時にのみ実行されます。
			
			trace('Initialize Test.');
			
			button.addEventListener(MouseEvent.CLICK, buttonClickHandler);
		}
		
		override protected function updateView():void
		{
			// ここに画面更新処理を記述します。
			// このビューが表示されると毎回実行されます。
			
			trace('Update Test.');
		}
		
		private function buttonClickHandler(event:MouseEvent):void
		{
			new ChangeStateThread().start();	
		}
	}
}