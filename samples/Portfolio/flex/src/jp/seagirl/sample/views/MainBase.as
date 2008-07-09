package jp.seagirl.sample.views
{
	import flash.events.MouseEvent;
	
	import jp.seagirl.controls.Link;
	import jp.seagirl.genius.managers.ApplicationManager;
	import jp.seagirl.genius.views.ViewBase;
	import jp.seagirl.sample.threads.ChangeStateThread;
	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	import mx.containers.VBox;
	import mx.containers.ViewStack;
	import mx.core.UIComponent;
	import mx.events.PropertyChangeEvent;

	public class MainBase extends ViewBase
	{		
		public var title:Link;
		public var navigation:VBox;
		public var viewStack:ViewStack;
		
		override protected function initializeView():void
		{
			BindingUtils.bindSetter(changePage, ApplicationManager.instance, 'state');
			
			title.addEventListener(MouseEvent.CLICK, titleClickHandler);
			navigation.getChildren().forEach(
				function (element:Link, index:int, array:Array):void
				{
					element.addEventListener(MouseEvent.CLICK, linkClickHandler);
				}
			);
		}
		
		private function changePage(data:Object):void
		{
			if (data == null)
				return;
			
			var child:UIComponent;
			viewStack.getChildren().forEach(
				function (element:UIComponent, index:int, array:Array):void
				{
					if (element.className == ApplicationManager.instance.currentPage)
						child = element;
				}
			);
			
			if (child)
			{
				viewStack.selectedIndex = viewStack.getChildIndex(child);
				return;
			}
			
			new ChangeStateThread().start();
		}
		
		private function titleClickHandler(event:MouseEvent):void
		{
			new ChangeStateThread().start();
		}
		
		private function linkClickHandler(event:MouseEvent):void
		{
			var page:String = Link(event.currentTarget).name;
			new ChangeStateThread().startWithData({ page: page });
		}
		
	}
}
