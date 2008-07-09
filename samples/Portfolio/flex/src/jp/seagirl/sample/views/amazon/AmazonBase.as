package jp.seagirl.sample.views.amazon
{
	import jp.seagirl.genius.views.ViewBase;
	import jp.seagirl.sample.models.AmazonModel;
	import jp.seagirl.sample.threads.*;
	import jp.seagirl.sample.threads.amazon.LoadAmazonThread;
	
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.XMLListCollection;
	import mx.controls.TileList;
	import mx.events.PropertyChangeEvent;

	public class AmazonBase extends ViewBase
	{
		public var tileList:TileList;
		
		override protected function initializeView():void
		{
			ChangeWatcher.watch(AmazonModel.instance, 'data', dataChangeHandler);
		}
		
		override protected function updateView():void
		{
			new LoadAmazonThread().start();
		}
		
		private function dataChangeHandler(event:PropertyChangeEvent):void
		{
			tileList.dataProvider = new XMLListCollection(event.newValue as XMLList);
		}
		
	}
}