package
{
	import [% package %].controllers.*;
	
	import jp.seagirl.genius.core.Config;
	import jp.seagirl.genius.views.ApplicationDelegate;
	
	public class [% name %]Delegate extends ApplicationDelegate
	{
		public var view:[% name %];
		
		/**
		 * アプリケーションの設定 
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
		 * アプリケーションで使用するモデルを初期化します。 
		 */		
		override protected function initializeModels():void
		{			
			//addModel(new MainModel());
		}
		
		/**
		 * アプリケーションで使用するビューを初期化します。 
		 */	
		override protected function initializeViews():void
		{
			view.viewStack.addAllViewsToContextMenu(view);
		}
		
		/**
		 * アプリケーションで使用するコントローラを初期化します。 
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
			view.viewStack.selectViewByClassName(data.page);
		}

	}
}