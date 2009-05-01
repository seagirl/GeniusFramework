package
{
	import [% package %].controllers.Page1Controller;
	import [% package %].controllers.Page2Controller;
	
	import flash.display.DisplayObject;
	
	import jp.seagirl.genius.views.ApplicationDelegate;
	
	import mx.binding.utils.BindingUtils;
	import mx.core.UIComponent;
	
	import [% package %].threads.ChangeStateThread;
	
	public class [% name %]Delegate extends ApplicationDelegate
	{
		public var view:[% name %];
		
		/**
		 * アプリケーション情報を登録します。 
		 */		
		override protected function initializeApplication():void
		{
			context.name = Config.APPLICATION_NAME;
			context.version = Config.APPLICATION_VERSION;		
			context.traceApplicationInformation();
		}
		
		/**
		 * アプリケーションの状態を登録します。 
		 */		
		override protected function initializeState():void
		{
			context.defaultState = Config.DEFAULT_STATE;
			
			if (!context.state.hasOwnProperty('page'))
				context.state = Config.DEFAULT_STATE;
				
			BindingUtils.bindSetter(changePage, context, 'state');
		}
		
		/**
		 * アプリケーションで使用するモデルを登録します。 
		 */		
		override protected function initializeModels():void
		{			
			//context.addModel(new MainModel());
		}
		
		/**
		 * アプリケーションで使用するビューコントローラを登録します。 
		 */		
		override protected function initializeControllers():void
		{
			context.addController(new Page1Controller(view.page1));
			context.addController(new Page2Controller(view.page2));
		}
		
		/**
		 * 状態に変化があると呼び出されるコールバック関数です。
		 */		
		private function changePage(data:Object):void
		{
			if (data == null)
				return;
				
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