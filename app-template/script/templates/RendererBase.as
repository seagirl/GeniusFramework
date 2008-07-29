package [% package %]
{
	import jp.seagirl.genius.views.ItemRenderer;

	public class [% name %]Base extends ItemRenderer
	{		
		override protected function initializeView():void
		{
			// ここに初期化処理を記述します。
			// このビューが生成された時にのみ実行されます。
		}
		
		override protected function updateView():void
		{
			// ここに画面更新処理を記述します。
			// このビューが表示されると毎回実行されます。
		}
		
	}
}
