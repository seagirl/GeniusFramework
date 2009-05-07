package [% package %]
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import jp.seagirl.genius.models.Model;
	import jp.seagirl.genius.threads.FileReferenceServiceThread;

	public class [% name %] extends FileReferenceServiceThread
	{
		private var model:Model;
		
		override protected function run():void
		{				
			var name:String = '';
			var ext:String = '';
			
			var variables:URLVariables = new URLVariables();
			
			var request:URLRequest = new URLRequest();
			request.url = '';
			request.data = variables;
			request.method = URLRequestMethod.POST; 
			
			file.addEventListener(Event.SELECT, selectHandler);
			file.download(request, name + '.' + ext);
		}
		
		private function selectHandler(event:Event):void
		{
			file.removeEventListener(Event.SELECT, arguments.callee);
			
			file.addEventListener(Event.COMPLETE, completeHandler);
			file.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			file.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			
			model.isLoading = true;
		}
		
		private function completeHandler(event:Event):void
		{
			file.removeEventListener(Event.COMPLETE, arguments.callee);
			
			trace('downloaded "', file.name, '" at ', new Date());
			
			model.lastResult = <result><status>2</status></result>;
			model.notifyView = true;
			model.isLoading = false;
		}
		
		private function errorHandler(event:ErrorEvent):void
		{
			trace(event.text);
			
			model.lastResult = <result><status>context.config.errorCodes.io</status></result>;
			model.notifyView = true;
			model.isLoading = false;
		}
		
	}
}