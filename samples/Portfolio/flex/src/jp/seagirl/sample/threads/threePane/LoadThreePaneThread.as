package jp.seagirl.sample.threads.threePane
{
	import flash.net.URLRequestMethod;
	
	import jp.seagirl.genius.threads.GeniusThread;
	import jp.seagirl.sample.core.Config;
	import jp.seagirl.sample.models.ThreePaneModel;
	
	import org.libspark.thread.threads.net.URLLoaderThread;

	public class LoadThreePaneThread extends GeniusThread
	{
		private var model:ThreePaneModel = ThreePaneModel.instance;
		
		override protected function run():void
		{	
			model.isLoading = true;
			
			variables.modified = model.lastModified;
			
			request.url = Config.API_URL + '/ThreePane'
			request.url += model.rawdata == null ? '/load' : '/sync';
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