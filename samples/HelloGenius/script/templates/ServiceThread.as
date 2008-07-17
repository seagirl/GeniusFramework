package [% package %].threads.event
{
	import flash.errors.IOError;
	
	import jp.seagirl.genius.models.Model;
	import jp.seagirl.genius.threads.GeniusThread;
	
	import org.libspark.thread.threads.net.URLLoaderThread;

	public class [% name %] extends GeniusThread
	{
		private var model:Model;

		override protected function run():void
		{			
			model.isLoading = true;
									
			for (var key:String in data)
			{
				if (data[key] != null)
					variables[key] = data[key];
			}
			
			request.url = '';
			request.data = variables;
			
			loaderThread = new URLLoaderThread(request);
			loaderThread.start();
			loaderThread.join();
			
			error(IOError, handleError);
			error(SecurityError, handleError);
			
			next(complete);
		}
		
		private function complete():void
		{
			var result:XML = XML(loaderThread.loader.data);
			
			if (model.lastModified != result.modified)
			{
				model.lastModified = result.modified;
				
			}
			
			model.loaded = true;
			model.isLoading = false;
		}
		
		private function handleError():void
		{
			model.lastResult = <result><status>-100</status></result>;
		}
		
	}
}