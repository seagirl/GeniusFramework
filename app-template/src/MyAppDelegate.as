package
{
	import [% package %].controllers.Page1Controller;
	import [% package %].controllers.Page2Controller;
	
	import flash.display.DisplayObject;
	
	import jp.seagirl.genius.core.Config;
	import jp.seagirl.genius.views.ApplicationDelegate;
	
	import mx.core.UIComponent;
	
	import [% package %].threads.ChangeStateThread;
	
	public class [% name %]Delegate extends ApplicationDelegate
	{
		public var view:[% name %];
		
		/**
		 * アプリケーション設定ファイルを初期化 
		 */		
		override protected function createConfig():Config
		{				
			return new Config("assets/config.json");
			
			//return new Config("assets/config.yaml");
			
			/* return new Config({
				applicationName: 'GettingStarted',
				applicationVersion: '1.0.0'
			}); */
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
			view.viewStack.selectByClassName(data.page);
		}

	}
}