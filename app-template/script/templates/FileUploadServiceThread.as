package [% package %]
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequestMethod;
	
	import jp.seagirl.genius.threads.FileUploadServiceThread;
	import jp.seagirl.genius.models.Model;
	
	import org.libspark.thread.threads.net.FileUploadThread;

	public class [% name %] extends FileUploadServiceThread
	{
		private var model:Model;
		private var file:FileReference;

		override protected function run():void
		{	
			file = new FileReference();
						
			request.url = '';
			request.data = variables;
			request.method = URLRequestMethod.POST;
			
			event(file, Event.SELECT, select);
			
			file.browse([new FileFilter("Images", "*.jpg;")]);
		}
		
		private function select(e:Event):void
		{
			model.isLoading = true;

			fileUploadThread = new FileUploadThread(request, file);
			fileUploadThread.waitCompleteData = true;
			fileUploadThread.doBrowse = false;
			fileUploadThread.start();
			fileUploadThread.join();
			
			error(IOError, handleError);
			error(SecurityError, handleError);
			
			next(complete);
		}
		
		private function complete():void
		{
			var result:XML = XML(fileUploadThread.data);
			
			if (result != '')
				model.lastResult = result;
			
			model.isLoading = false;
		}
		
		private function handleError():void
		{
			model.lastResult = <result><status>-100</status></result>;
		}
		
	}
}