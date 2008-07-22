package jp.seagirl.sample.core
{
	import jp.seagirl.genius.core.Application;
	import jp.seagirl.genius.managers.ApplicationManager;
	import jp.seagirl.sample.views.Main;
	
	import mx.events.FlexEvent;
	
	import org.libspark.thread.EnterFrameThreadExecutor;
	import org.libspark.thread.Thread;

	public class Application extends jp.seagirl.genius.core.Application
	{		
		public static const APPLICATION_NAME:String = 'Portfolio';
		public static const APPLICATION_VERSION:String = '1.5.0';
		public static const DEFAULT_PAGE:String = 'Intro';
		
		private var applicationManager:ApplicationManager;
		private var mainView:Main;
		
		private function initializeApplication():void
		{
			applicationManager = ApplicationManager.instance;
			applicationManager.name = APPLICATION_NAME;
			applicationManager.version = APPLICATION_VERSION;
			applicationManager.defaultState.page = DEFAULT_PAGE;
			applicationManager.traceApplicationInformation();
			
			Thread.initialize(new EnterFrameThreadExecutor());
		}
		
		private function initializeView():void
		{
			mainView = new Main();
			addChild(mainView);
			mainView.percentHeight = 100;
			mainView.percentWidth = 100;
		}
		
		override protected function initializeHandler(event:FlexEvent):void
		{	
			initializeApplication();
			initializeView();
		}
		
	}
}
