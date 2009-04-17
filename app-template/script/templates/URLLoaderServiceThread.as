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
			if (model.isLoading)
				return;
							
			model.isLoading = true;
			
			next(load);
		}
		
		private function load():void
		{
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
			
			model.isLoading = false;
		}
		
		private function handleError(error:Error, thread:Thread):void
		{
			trace(error.message);
			
			model.lastResult = <result><status>{ Config.ERROR_CODES.IOError }</status></result>;
			model.notifyView = true;
			model.isLoading = false;
		}
		
	}
}