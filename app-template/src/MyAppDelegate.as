package
{
	import [% package %].controllers.*;
	
	import jp.seagirl.genius.core.Config;
	import jp.seagirl.genius.views.ApplicationDelegate;
	
	public class [% name %]Delegate extends ApplicationDelegate
	{
		public var view:[% name %];
		
		/**
		 * 設定ファイルの初期化
		 */	
		override protected function createConfig():Config
		{
			return new [% name %]Config(view);
		}
		
		/**
		 * アプリケーションに必要なデータをロードするためのテンプレートメソッド
		 * オーバーライドしなければ即座に initialize メソッドに移行
		 * 実装する場合は GeniusEvent.ASSETES_LOADED を発行することで initialize メソッドに移行
		 */		
		//override protected function loadAssets():void
		//{
		//}
		
		/**
		 * 初期化 
		 */	
		override protected function initialize():void
		{
			context.ignoredState = [];
			
			addController(new Page1Controller(view.page1));
			addController(new Page2Controller(view.page2));
			
			createContextMenu();
		}
		
		/**
		 * 状態に変化があると呼び出されます。
		 */		
		override public function changePage(data:Object):void
		{
			view.viewStack.selectViewByClassName(data.page);
		}
	}
}