package jp.seagirl.sample.threads.amazon
{
	import jp.seagirl.genius.threads.GeniusThread;
	import jp.seagirl.sample.amazon;
	import jp.seagirl.sample.models.AmazonModel;
	
	import org.libspark.thread.threads.net.URLLoaderThread;
	
	use namespace amazon;

	public class LoadAmazonThread extends GeniusThread
	{		
		private var model:AmazonModel = AmazonModel.instance;
		private var c:int = 1;
		
		override protected function run():void
		{				
			if (model.rawdata == null)
				next(load);
		}
		
		private function load():void
		{
			model.isLoading = true;
			
			variables.Service = 'AWSECommerceService';
			variables.AWSAccessKeyId = '1XKY6JB5V4QYKXJ6KZR2';
			variables.Operation = 'ItemSearch';
			variables.Sort = 'salesrank';
			variables.SearchIndex = 'Music';
			variables.BrowseNode = '569322';
			variables.ResponseGroup = 'Images';
			variables.ItemPage = c;
			
			request.url = 'http://webservices.amazon.co.jp/onca/xml';
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
				model.merge(result.Items.Item);
				model.data = new XMLList(model.rawdata);
			}
			catch (e:Error)
			{
				model.lastResult =
				<result>
					<status>-1</status>
				</result>;
			}
			
			if (c < 30)
			{
				c++;
				next(load);
			}
			else
			{
				model.loaded = true;
				model.isLoading = false;	
			}
		}
		
	}
}