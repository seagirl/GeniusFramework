package [% package %]
{
	import flash.errors.IOError;
	
	import jp.seagirl.genius.threads.URLLoaderServiceThread;
	import jp.seagirl.genius.models.Model;
	
	import org.libspark.thread.threads.net.URLLoaderThread;

	public class [% name %] extends URLLoaderServiceThread
	{
		private var model:Model;

		override protected function run():void
		{			
			model.isLoading = true;
			
			variables.modified = model.lastModified;
									
			for (var key:String in data)
			{
				if (data[key] != null)
					variables[key] = data[key];
			}
			
			request.url = '';
			request.data = variables;
			
			urlLoaderThread = new URLLoaderThread(request);
			urlLoaderThread.start();
			urlLoaderThread.join();
			
			error(IOError, handleError);
			error(SecurityError, handleError);
			
			next(complete);
		}
		
		private function complete():void
		{
			var result:XML = XML(urlLoaderThread.loader.data);
			
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