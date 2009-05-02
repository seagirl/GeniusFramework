package [% controller_package %]
{
	import jp.seagirl.genius.controllers.ViewController;
	
	import [% view_package %].[% name %];

	public class [% name %]Controller extends ViewController
	{
		public function [% name %]Controller(view:Object)
		{
			super(view);	
		}
		
		public var view:[% name %];
	
		override protected function initialize():void
		{
			// ここに初期化処理を記述します。
			// このビューが生成された時にのみ実行されます。
		}
		
		override public function update():void
		{
			// ここに画面更新処理を記述します。
			// このビューが表示されると毎回実行されます。
		}
		
	}
}
