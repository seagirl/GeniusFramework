package jp.seagirl.sample.threads.amazon
{
	import jp.seagirl.genius.threads.URLLoaderServiceThread;
	import jp.seagirl.sample.amazon;
	import jp.seagirl.sample.models.AmazonModel;
	
	import org.libspark.thread.threads.net.URLLoaderThread;

	public class LoadAmazonThread extends URLLoaderServiceThread
	{		
		private var model:AmazonModel = AmazonModel.instance;
		private var c:int = 1;
		
		override protected function run():void
		{				
			if (model.rawdata == null)
			{
				model.isLoading = true;
			
				next(load);
			}
		}
		
		private function load():void
		{
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
			
			urlLoaderThread = new URLLoaderThread(request);
			urlLoaderThread.start();
			urlLoaderThread.join();
			
			next(complete);
		}
		
		private function complete():void
		{
			try
			{
				use namespace amazon;	
				var result:XML = XML(urlLoaderThread.loader.data);
				model.merge(result.Items.Item, 'ASIN', amazon);
				model.data = new XMLList(model.rawdata);
			}
			catch (e:Error)
			{
				model.lastResult =
				<result>
					<status>-1</status>
				</result>;
			}
			finally
			{
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
}