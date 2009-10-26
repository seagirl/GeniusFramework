package [% package %]
{	
	import jp.seagirl.genius.threads.URLLoaderServiceThread;
	import jp.seagirl.genius.models.Model;
	
	import org.libspark.thread.threads.net.URLLoaderThread;

	public class [% name %] extends URLLoaderServiceThread
	{
		private var model:Model;

		override protected function initialize():void
		{			
			if (model.isLoading)
				return;
							
			model.isLoading = true;
			
			next(load);
		}
		
		override protected function finalize():void
		{
			model.isLoading = false;
		}
		
		private function load():void
		{
			request.url = context.config.serviceURL + '/hoge';
			request.data = variables;
			
			urlLoaderThread = new URLLoaderThread(request);
			urlLoaderThread.start();
			urlLoaderThread.join();
			
			next(complete);
		}
		
		private function complete():void
		{
			var result:XML = XML(urlLoaderThread.loader.data);
			
			// 成功
			if (result.@status == 1)
			{
				model.lastResult = result;
			}
			// サーバーエラー
			else if (result.@status == context.config.errorCodes.server)
			{
				model.lastResult = result;
				alert(result.@data);	
			}
			// 不正なデータ
			else
			{
				alert("データ形式が正しくありません。");	
			}
		}
		
	}
}