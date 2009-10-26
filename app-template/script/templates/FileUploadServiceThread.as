package [% package %]
{
	import flash.events.DataEvent;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLRequestMethod;
	
	import jp.seagirl.genius.models.Model;
	import jp.seagirl.genius.threads.FileReferenceServiceThread;

	public class [% name %] extends FileUploadServiceThread
	{
		private var model:Model;

		override public function start():void
		{			
			request.url = '';
			request.data = variables;
			request.method = URLRequestMethod.POST;
			
			files.addEventListener(Event.SELECT, selectHandler);
			files.browse([new FileFilter("Image", "*.jpg;*.jpeg;*.JPG;*.JPEG;*.gif;*.GIF;*.png;*.PNG;")]);
		}
		
		private function selectHandler(event:Event):void
		{
			files.removeEventListener(Event.SELECT, arguments.callee);
			
			files.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			files.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			
			for (var i:int = 0; i < files.fileList.length; i++)
			{
				var file:FileReference = files.fileList[i];
				file.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, completeHandler);
				file.upload(request);
			}
			
			model.isLoading = true;
		}
		
		private function complete(event:DataEvent):void
		{
			var file:FileReference = event.currentTarget as FileReference;
			file.removeEventListener(DataEvent.UPLOAD_COMPLETE_DATA, arguments.callee);
			
			var result:XML = XML(event.data);
			
			if (result.@status == 1)
			{
				trace('uploaded "', file.name, '" at ', new Date());

				model.lastResult = result;
				model.notify('アップロードしました。');
			}
			else if (result.@status == context.config.errorCodes.server)
			{
				model.lastResult = result;
				alert(result.@data);	
			}
			else
			{
				alert("データ形式が正しくありません。");
			}
		}
		
		private function errorHandler(event:ErrorEvent):void
		{
			alert(event.text);
		}
		
	}
}