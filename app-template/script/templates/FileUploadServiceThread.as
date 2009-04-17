package [% package %]
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.DataEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequestMethod;
	
	import jp.seagirl.genius.models.Model;

	public class [% name %] extends FileUploadServiceThread
	{
		private var model:Model;

		override protected function run():void
		{			
			request.url = '';
			request.data = variables;
			request.method = URLRequestMethod.POST;
			
			file.addEventListener(Event.SELECT, selectHandler);
			file.browse([new FileFilter("Images", "*.jpg;")]);
		}
		
		private function selectHandler(event:Event):void
		{
			file.removeEventListener(Event.SELECT, arguments.callee);
			
			file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, completeHandler);
			file.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			
			model.isLoading = true;
			
			file.upload(request);
		}
		
		private function complete(event:DataEvent):void
		{
			file.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA, arguments.callee);
			
			var result:XML = XML(event.data);
			
			model.lastResult = result;
			model.notifyView = true;
			model.isLoading = false;
		}
		
		private function errorHandler(event:ErrorEvent):void
		{
			trace(event.text);
			
			model.lastResult = <result><status>100</status></result>;
			model.notifyView = true;
			model.isLoading = false;
		}
		
	}
}