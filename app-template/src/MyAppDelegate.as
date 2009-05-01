package
{
	import [% package %].controllers.Page1Controller;
	import [% package %].controllers.Page2Controller;
	
	import flash.display.DisplayObject;
	
	import jp.seagirl.genius.views.ApplicationDelegate;
	
	import mx.core.UIComponent;
	
	import [% package %].threads.ChangeStateThread;
	
	public class [% name %]Delegate extends ApplicationDelegate
	{
		public var view:[% name %];
		
		/**
		 * アプリケーション設定ファイルを初期化 
		 */		
		override protected function initializeConfig():void
		{
			config = new [% name %]Config();
		}
		
		/**
		 * アプリケーションで使用するモデルを登録します。 
		 */		
		override protected function initializeModels():void
		{			
			//addModel(new MainModel());
		}
		
		/**
		 * アプリケーションで使用するビューコントローラを登録します。 
		 */		
		override protected function initializeControllers():void
		{
			addController(new Page1Controller(view.page1));
			addController(new Page2Controller(view.page2));
		}
		
		/**
		 * 状態に変化があると呼び出されます。。
		 */		
		override protected function changePage(data:Object):void
		{
			var child:UIComponent;
			
			view.viewStack.getChildren().forEach
			(
				function (element:UIComponent, index:int, array:Array):void
				{
					if (element.className == context.state.page)
						child = element;
				}
			);
			
			if (child)
			{
				var oldIndex:int = view.viewStack.selectedIndex;
				var newIndex:int = view.viewStack.getChildIndex(child);
				
				view.viewStack.selectedIndex = newIndex;
				
				return;
			}
			
			new ChangeStateThread().start();
		}

	}
}