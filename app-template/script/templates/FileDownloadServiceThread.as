package [% package %]
{
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import jp.seagirl.genius.models.Model;
	import jp.seagirl.genius.threads.GeniusThread;

	public class [% name %] extends GeniusThread
	{
		private var model:Model;
		private var file:FileReference;
		
		override protected function run():void
		{	
			file = new FileReference();
			
			var name:String = '';
			var ext:String = '';
			
			var variables:URLVariables = new URLVariables();
			
			var request:URLRequest = new URLRequest();
			request.url = '';
			request.data = variables;
			request.method = URLRequestMethod.POST; 
			
			event(file, Event.SELECT, select);
			
			file.download(request, name + '.' + ext);
		}
		
		private function select(e:Event):void
		{
			file.removeEventListener(Event.SELECT, arguments.callee);
			
			event(file, Event.COMPLETE, complete);
			
			error(IOError, handleError);
			error(SecurityError, handleError);
			
			model.isLoading = true;
		}
		
		private function complete(e:Event):void
		{
			file.removeEventListener(Event.COMPLETE, arguments.callee);
			
			trace('downloaded "', file.name, '" at ', new Date())
			
			model.lastResult = <result><status>1</status></result>;
			model.isLoading = false;
		}
		
		private function handleError():void
		{
			model.lastResult = <result><status>-100</status></result>;
		}
		
	}
}