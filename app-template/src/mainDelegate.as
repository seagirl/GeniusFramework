package
{
	import jp.seagirl.genius.controllers.ApplicationDelegate;
	
	import [% package %].views.Main;
	
	public class [% name %]Delegate extends ApplicationDelegate
	{
		public var view:[% name %];
		
		override protected function initializeApplication():void
		{
			context.name = Config.APPLICATION_NAME;
			context.version = Config.APPLICATION_VERSION;
			
			context.traceApplicationInformation();
		}
		
		override protected function initializeState():void
		{
			context.defaultState = Config.DEFAULT_STATE;
			
			if (!context.state.hasOwnProperty('page'))
				context.state = Config.DEFAULT_STATE;
		}
		
		override protected function initializeModels():void
		{			
			
		}
		
		override protected function initializeViews():void
		{
			var main:Main = new Main();
			view.addChild(main);
			main.percentWidth = 100;
			main.percentHeight = 100;
		}

	}
}