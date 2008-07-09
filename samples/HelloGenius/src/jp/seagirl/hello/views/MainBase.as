package jp.seagirl.hello.views
{
	import jp.seagirl.genius.managers.ApplicationManager;
	import jp.seagirl.genius.views.ViewBase;
	import jp.seagirl.hello.threads.ChangeStateThread;
	
	import mx.binding.utils.BindingUtils;
	import mx.containers.ViewStack;
	import mx.core.UIComponent;

	public class MainBase extends ViewBase
	{	
		public var viewStack:ViewStack;
		
		override protected function initializeView():void
		{
			BindingUtils.bindSetter(changePage, ApplicationManager.instance, 'state');
		}
		
		private function changePage(data:Object):void
		{
			if (data == null)
				return;
				
			var child:UIComponent;
			viewStack.getChildren().forEach(
				function (element:UIComponent, index:int, array:Array):void
				{
					if (element.className == ApplicationManager.instance.state.page)
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
		
	}
}
