package jp.seagirl.genius.controllers
{
	import jp.seagirl.genius.core.Context;
	
	import mx.core.Application;
	
	import org.libspark.ui.SWFWheel;

	public class ApplicationDelegate extends Controller
	{
		override protected function preinitialize():void
		{
			context = new Context();
			
			if (this['view'] is Application)
				SWFWheel.initialize(Application(this['view']).systemManager.stage);
				
			this['view'].data = { delegate: this };
			this['view'].styleName = 'plain';
			this['view'].setStyle('color', '#000000');
			
			initializeApplication();
			
			initializeModels();
			initializeViews();
		}
		
		protected function initializeApplication():void
		{
			
		}
		
		protected function initializeModels():void
		{
			
		}
		
		protected function initializeViews():void
		{
			
		}
		
	}
}