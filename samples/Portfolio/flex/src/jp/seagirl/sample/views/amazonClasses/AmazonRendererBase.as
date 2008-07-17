package jp.seagirl.sample.views.amazonClasses
{
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import jp.seagirl.genius.views.ItemRenderer;
	import jp.seagirl.sample.amazon;
	
	import mx.controls.Image;

	use namespace amazon;
	
	public class AmazonRendererBase extends ItemRenderer
	{	
		// Using MXML
		public var image:Image;
		
		override protected function initializeView():void
		{
			addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		override protected function updateView():void
		{
			if (data.MediumImage.length() > 0)
			 image.source = data.MediumImage.URL.toString();
		}
		
		private function clickHandler(event:MouseEvent):void
		{
			if (data.LargeImage.length() > 0)
			 navigateToURL(new URLRequest(data.LargeImage.URL.toString()));
		}
		
		
		
	}
}