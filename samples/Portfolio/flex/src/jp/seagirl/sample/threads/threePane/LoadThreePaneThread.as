package jp.seagirl.sample.threads.threePane
{
	import flash.net.URLRequestMethod;
	
	import jp.seagirl.genius.threads.GeniusThread;
	import jp.seagirl.sample.models.ThreePaneModel;
	
	import org.libspark.thread.threads.net.URLLoaderThread;

	public class LoadThreePaneThread extends GeniusThread
	{
		private var model:ThreePaneModel = ThreePaneModel.instance;
		
		override protected function run():void
		{	
			model.isLoading = true;
			
			variables.controller = 'ThreePane';
			variables.action = model.rawdata == null ? 'load' : 'sync';
			variables.modified = model.lastModified;
			
			request.url = 'http://seagirl.jp/genius/sample/api/index.cgi';
			request.method = URLRequestMethod.POST;
			request.data = variables;
			
			loaderThread = new URLLoaderThread(request);
			loaderThread.start();
			loaderThread.join();
			next(complete);
		}
		
		private function complete():void
		{
			try
			{
				var result:XML = XML(loaderThread.loader.data);
				model.lastModified = result.modified;
				if (model.rawdata == null)
					model.rawdata = result.post;
				else
					model.merge(result.post);
				model.data = new XMLList(model.rawdata);
			}
			catch (e:Error)
			{
				model.lastResult =
				<result>
					<status>-1</status>
				</result>;
			}

			model.loaded = true;
			model.isLoading = false;
		}
		
	}
}