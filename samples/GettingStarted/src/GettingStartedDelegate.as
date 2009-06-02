package
{
	import controllers.Page1Controller;
	import controllers.Page2Controller;
	
	import jp.seagirl.genius.core.Config;
	import jp.seagirl.genius.views.ApplicationDelegate;
	
	import models.MainModel;
	
	public class GettingStartedDelegate extends ApplicationDelegate
	{
		public var view:GettingStarted;
		
		override protected function initializeModels():void
		{			
			addModel(new MainModel());
		}
		
		override protected function initializeViews():void
		{
			view.viewStack.addAllViewsToContextMenu(view);
		}
		
		override protected function initializeControllers():void
		{
			addController(new Page1Controller(view.page1));
			addController(new Page2Controller(view.page2));
		}
		
		override public function changePage(data:Object):void
		{
			view.viewStack.selectViewByClassName(data.page);
		}

	}
}