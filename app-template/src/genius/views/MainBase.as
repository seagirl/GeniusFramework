package [% package %].views
{	
	import jp.seagirl.genius.managers.ApplicationManager;
	import jp.seagirl.genius.views.ViewBase;
	
	import mx.binding.utils.BindingUtils;
	import mx.containers.ViewStack;
	import mx.core.UIComponent;
	
	import [% package %].threads.ChangeStateThread;

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
				
			var child:ViewBase;
			viewStack.getChildren().forEach(
				function (element:UIComponent, index:int, array:Array):void
				{
					if (element.className == ApplicationManager.instance.state.page)
						child = element as ViewBase;
				}
			);
			
			if (child)
			{
				var oldIndex:int = viewStack.selectedIndex;
				var newIndex:int = viewStack.getChildIndex(child);
				
				viewStack.selectedIndex = newIndex;
				
				if (oldIndex == newIndex)
					child.updateView();
				
				return;
			}
			
			new ChangeStateThread().start();
		}
		
	}
}